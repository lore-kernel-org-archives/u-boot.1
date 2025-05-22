Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0438CC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352F883095;
	Thu, 22 May 2025 16:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="LbzSuWrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6165830B4; Thu, 22 May 2025 16:38:22 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D2183082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8YQdHSpta+G7sHv7+YFUdbYxahv4THoaMXhHneyD9eq0z4rZmfoRG4HNMGNmdQ2EpVXVmuk2nVywFyru4YOBdEbh79Vivrfq8HPJquc6NlBcQd+ex8ygF5V37ecRbKdL++EMOEj+jJLa+TbXw+1hQbmC9oe0QmqaITr+L9TMmm2T9J/Jfm2YnjMVm8sY1xtCvKWA+7jHMHuhkrAcHgEWD+154jg2oMvlbhueWKj91l5MGfV8B8wv0YiHhqwbuH4NLqbkKQcUNHYMx5KNdmMEeDoLbW/4mGzKp54NPNbg5NWYABurkL6eAjHXBgzKj12Ph2e2m5W4qM/hJHKkA74nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt/rgRu4AaBcB5Up+vZ4/Ml3fsmmr3Qp6i/SLH78/7c=;
 b=kGX6gvVqBhtwo2PmUukFnt22yk/zVdpn2VrV9P1YwzhOgrxxDNtEHcaIZmJrc07wgeFLiUvr/IWv22GRWwHy8zXgsNU8zi0ZHNm5NRRImEiCtQyGEejBWhfzHeOxJa91UAVV9fTnkrBHqLbOPXl2XJ3WxIwExX055o4+Xz+W1YGrYrpFQMhiaS2cntOQiD8sGqyeUkjQFOCXAbYNoH6A633ujLp0RjkCQ9rgasHViZ/D9Hr7UOujC0tVgAyMQriI9Yk/dffi0QDyuLr1zucE3zfXy4TGTUrjgULLQkURFDdBGXrtZWmYgcNTuR5eZ5I+y/aqYU/1xgRoX/4/RH3brA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt/rgRu4AaBcB5Up+vZ4/Ml3fsmmr3Qp6i/SLH78/7c=;
 b=LbzSuWrU+C9/IZe5POoisA9cInAyVQ74yZsX3Q4T8swUvZ2L0T0xHS4a1uqdKufMDpYsCMu8mMAC5+iiuL4ZumBGgQUg5f5ZI6RjQMpmSRFEtfOS2lrK9+24glOi2yGNanIIshzA3+6+M9a0kvGHBzAyLaLNVQ9nRvPBSL4vJYfoPPIcut0v2a0r4nWB7zDMlyGWzJQq1JY3VJTG1xgaqvSOLM3A9pvdT1qDRx+f9UNOlN6LbfwNMF1rUX8f82zCqMRCa3aXlqGrxe1fGo4vFqsl+W+u7CgjsFm0tuMxF3qSfrgheMhcg93jSi75bSnAgClsF8glmhvvGfTRg2tQbQ==
Received: from SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 14:38:16 +0000
Received: from SJ0PR11MB5582.namprd11.prod.outlook.com
 ([fe80::a534:22db:5d37:f389]) by SJ0PR11MB5582.namprd11.prod.outlook.com
 ([fe80::a534:22db:5d37:f389%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 14:38:16 +0000
From: <Conor.Dooley@microchip.com>
To: <Eoin.Dickson@microchip.com>, <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <Jamie.Gibbons@microchip.com>, <Praveen.Kumar@microchip.com>,
 <Cyril.Jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: Re: [PATCH v1 0/4] Add SD card support to the Beagle-V-Fire
Thread-Topic: [PATCH v1 0/4] Add SD card support to the Beagle-V-Fire
Thread-Index: AQHbyyNOAfXPN8Ya+U+f4LgYlGmbmLPeuAaA
Date: Thu, 22 May 2025 14:38:16 +0000
Message-ID: <d42bff2b-5257-48cc-9d4c-9f55fc4de1d0@microchip.com>
References: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
In-Reply-To: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5582:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 36f6ce89-bb00-492f-b699-08dd993e49f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N0xpeUxRWkNGcnNJUnN0eTBic1FueUJyTlpFSE5wNjR0Y0thSW40OFhEVzhF?=
 =?utf-8?B?SGd1QkRFYnFRRWk5WDYvSEFKR0Q1NWQxZ0VDdjBVZExyajY3b1NoMStmKyth?=
 =?utf-8?B?eDZVMTRzRTBkbUFJU1JkZ0t1TDBRcTFhMTY2cGx6aUNsbjlZQ05jVHc4TWpN?=
 =?utf-8?B?YjVkcGRSZ2pRRW9DU2VqRnJER0Flb1ZyZTRHc2djU1JtUERLdWVnY0xmWHF6?=
 =?utf-8?B?SUpra2srVytWU0ptbGRFN3ZwejgvMTZtOGR4R3ZnVjBTbDBtWDdybE9mM2l2?=
 =?utf-8?B?cklacS9RekVrbG9WRmNPVUhEaTZFRlVSZzFDaERaU1czYWtiTmNianZ0ZGVr?=
 =?utf-8?B?S3AxYWJ1NU9OK0p0L29RWjAzUWlrRU90SXZvbmxXY1M5UFI5eUk1WlpVRFlP?=
 =?utf-8?B?dnYzaFNRUi9GemttTkh5MVN5N05tM2M5bS8zL0Q0dVhHaXYyYzhmVTlSa2ln?=
 =?utf-8?B?QmVZTHZiWHdsVDdPWkp3TnMwaWFTWFRIdldoQUM4VU8rU3ozRUtQOElJdmVW?=
 =?utf-8?B?WWtOTFpweWthbTNCbElZb2RIelV1YTVPZzdTd3czTE9TeEo5MmhBZU1rR0tn?=
 =?utf-8?B?OUUxVENnVzI1cE83TkdwYndDY010N1VsSXdGS1EzMHFENGJ2YU5RT3BPY3Vs?=
 =?utf-8?B?c3ErSEdhTWZ3K3NnZDBZcnBxL0kyaEJOMlM2VElOeTMyRUk1eXd6TlE4VGFV?=
 =?utf-8?B?VXpYUU5aT09RRmhYcXU0WWVaWHM5Q09iMGJoUmthbTBwQ1h5cldMeFc5MlNq?=
 =?utf-8?B?d1NqbENRZzBIMEx4QkJkdU9JMkYycGwrY3lHekhmcHdLYmNEenRiS0pOUy9V?=
 =?utf-8?B?NUNKSzI4OE1XYktZR01GTXlGVjNTanl6N2FjUXhBdmRoZUgvYTJmSWF5YXRE?=
 =?utf-8?B?UjFEMkhlaDNweHJzREZKQW0vWUtnTTZkRnMwVnJTWU5ZNTM1ancvYzZXZHVG?=
 =?utf-8?B?V3prZ0NYaDNFM1VTby9TSUM1MHZGNi9vdHMzNWszZ0ZnVUpma0FyYThVMGpY?=
 =?utf-8?B?VVo0L2I4SDB1ZXZLWDNvNktiUVYrQjNIaklXMkJvamFMVjhkY3J1Smc5cjhz?=
 =?utf-8?B?N1IwVjMxZGtveFdBWUt1SWprWjdZdTFQT1JOUzhCTzVlTFhSOUJJTTVJZExl?=
 =?utf-8?B?dWNSbXcyTktpS3AwMFVzZnE0TVVZRkVDSXRVUHFSWVpFdy9LRkI1czJqVWZp?=
 =?utf-8?B?T2k0OFZDK3dTNG5sYTVjRDUrM2k1TWR1QmN0L1hyY1dXREM5RGRkanR2ek9V?=
 =?utf-8?B?UW50c0czWFpSN2tzRGI5ZXhuOHNZbWFvRFVnQmNCMG9lZlNHYm5FUVdER3ZL?=
 =?utf-8?B?Z0pseWpJRGFseWRUOXRlbmZMRmRudEc1SmpNRlQ1dGFVVENqZXNiemhreXZS?=
 =?utf-8?B?dWJGTTJUVFlkc25Ea2trc0ZuRjBHcDMvbERnZHdJcGszNW9jck1pQTZETmRw?=
 =?utf-8?B?TTVFaldVeHErbDBZSlYyb1QxZzRabytaYkxWLzd5ZEhzYUJqeDlxbzBzRmF5?=
 =?utf-8?B?bHM2ZVBtWXVkanF5cS9WajdjOWhNRkFibVNVVnZISjN1OVFBWTZ3bHdQdGpM?=
 =?utf-8?B?K0pEWi9FMjMrT3hzYlN4LzVlRXREaVMycm9yTi8xR1lUU0w1dSswdHJTb0hK?=
 =?utf-8?B?cFdud2IySU1ORW9welljMkhUNndtUmRqS1VmU2E3ZEZDZUY0Z3RXOHk1dEFT?=
 =?utf-8?B?ZXpBa0xUOWl4ZTdneGpqU1JYV1VFc2hQWDJqaDE0TGxQOEZ0RUhIdTVESnd6?=
 =?utf-8?B?YjNwMXNwRW1hNlp2R011a2dKL05OQ3hoSXRJVTNUaEUrakRLRkZva0diZnhw?=
 =?utf-8?B?d00vaWlsakV1aWlzbXZQdWZwbGhjWU94WmlnMWhmZVYydzluQ1RqYm9SL1Z3?=
 =?utf-8?B?QnVJbjVtdjdpMDlwRzNzR1BPNnBuZXFxUnlnYXkrbEhzYWhjUktZYjNkSHVz?=
 =?utf-8?B?L2ltZEtTQ1dGRldXQWRZRTRRem0rZzhJQmRkZU5id0I5QkZtNjloNHlNWXl3?=
 =?utf-8?Q?KNDjQlHdU8HseN3UBHe014wbTuepO0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5582.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NC95L2hqdTRvOEhFZ1R6VjhTY0trdVU5bnBRQ3JZQXg0NzBaZWpQZnpCd0pl?=
 =?utf-8?B?amJvTTllUXp6bjd1Mk5RYXlscXRVMkplWnJSTjFIVGdpTmhwQ25HcFJ1STVt?=
 =?utf-8?B?OFlhR3laMUt1ckF0VlV2NDNNSXEzS25IYWNSckVGVWY5TTg1WVVEa2J3Q3hx?=
 =?utf-8?B?MTFKdUE5bDBwbExLN2RHeXNPSlhESVY0bnhDZFRVS2lIYWJpZDVMVjBMU0dJ?=
 =?utf-8?B?MTZYS01wa0ZyN3NZV1NkUnBDMmpSb0c4SkxwUG1oM2x6V1dRV0JDT0NZMFU5?=
 =?utf-8?B?WXl5dzdXRSt5a2U0cDhQQnBER0hWT2FmZHptbjdiZTRnZExNVW51cldkb2NO?=
 =?utf-8?B?OXc3QStpUjJibTFvSVA5Qk4ySWk3R2dKTHVINHpTbG5EMmRhODZ2b1VtWnRw?=
 =?utf-8?B?M011STkwV3gyVXlwcGxOUXdWZE5WK042MUlmTFhzM0VLbGtqd01qT0tDRnlL?=
 =?utf-8?B?WEZOcHJldWM2aWJ1NkoxNDBoWUptYk00OTNyMzFhNmxIOTc4d3RGZlpvMHpT?=
 =?utf-8?B?RHJrUlc5NzJPVjRoekhYV3R0WWJMTkRYV2JzVFlXY25nTDV0YUozRHA1UDdR?=
 =?utf-8?B?SXVQbUUzQ29FTkdNNGpDN1pKbGNNNHF5Tno0N0dpUTRuWjJ2N2dLcUVDYWp5?=
 =?utf-8?B?Q243S0Rvd1FUUzFBTnU3VXI2MktTRmEzd2duTldZOGt6SGVuSTZtREpOaWFa?=
 =?utf-8?B?ampPTCtMSnY2Tk9QWWl4THNwU2trOTNQaFgraHNMR0REYmd3dk9KUVpqa0ls?=
 =?utf-8?B?aWdFYUtHTXZVU280UVloaEk2R1V1T25lWUdNUFAwWUJCak1IelZnYURxWHlG?=
 =?utf-8?B?THhZYTZ2S2tNM3E0Z0tHMjVCUG8wVVcxVlNmUlYrd0tlb2d2N0dLMEYwNnh5?=
 =?utf-8?B?aDlPMkNSL2tpc0VQS0E0bkFxYjBuZTQwMVM3Z1R0SkhGNlVoYUcyNStHS0oz?=
 =?utf-8?B?aTkrQi9TMURzNkErWDNMbk5SZy8wYjFIU04renVrT3RPdjRHVG9rMHFBUDlR?=
 =?utf-8?B?ajEvSGsrekE1K0E2alk0QldHZkFkeWJ5dk94dFZBRU5CcDdROGQ5QXgzcFpW?=
 =?utf-8?B?dXJ1b2dZRnZxMTc4NFIyQXh6SnAvQUpxeEZRM1BSMHR0ak5GdHphcytQZ3N2?=
 =?utf-8?B?KzloUGVTTDA1QkY3ZmJhaThHb0ZnMjZCSGpQRGZmbU5hZTVrWHhPNm8rL285?=
 =?utf-8?B?ajFiU3llb0FKZFNJYmxPcm5Xd1I1Y0hQUGJzdU55cm5vQ3NkbkRwVzJ0VW83?=
 =?utf-8?B?TmxwVXhtbCtHRjhWZ0pqZ0xVYzFKOS9GbUFhVy9KT0NVNW9udFFnbWlvNTdk?=
 =?utf-8?B?Wlo5dnhCZ3A3WndpMUpYOHlvZXJrRE9peDhPTnpqSExqMkplQ1BuYWlEVW9s?=
 =?utf-8?B?cDlIVEFNek1ncXFVMW56ODhWZU5HNytpek43WUUzT1N1dm52QTVMZTVTaVZB?=
 =?utf-8?B?cE9ubHE1YUpJYzg2aUxGbTNHM3hXdUhQamx6RDJGYllmQ3ZnYjNzdE96NlZ3?=
 =?utf-8?B?T1Q0bW5wNlQ4VGtad3d1ang0NWJQeEtKZ2x1NkhzdktDUEJqeFNHY2gyK1dJ?=
 =?utf-8?B?MlY5WGZXT2dhS21jM1NTYW1PcEJYYmE3bmx2YWMySEdMZEx3UU1hcjRrVzJF?=
 =?utf-8?B?TTlqZDc2MDk5blZsVWR5WGtUbkJ6d2J0QytWV0xWdFBxdWhHZ0J0ZGszZUpJ?=
 =?utf-8?B?SmdhQnZmS0JOZ2UwdU9ZaGZxWWFITVVXdFhuSnp2amJIRE9KZnNVR1RDUENh?=
 =?utf-8?B?OXdKUTNacXZGK2VDRXNjdlFFWkN5UnN0R3l0Y1hRd1E5NElXaVV6V1M4MThD?=
 =?utf-8?B?djZaNVI4NkQyNDhtUmMxYlNPWjBObG5YTjZ3QXc1RzdWNWNvSEMzbHdUaFhl?=
 =?utf-8?B?QlFObWhIUDNHSnZQN3JPQmRrT095RjRzSWQ0V1p2RTBXQnVLUFJua01FQTFK?=
 =?utf-8?B?bDRLZTFPQkxreWRsV3ZESmp4aU42N3p5dHFrc242NGhNczlUYk5KZ3FZM09B?=
 =?utf-8?B?aDJHNEdyc3U3UVlOK0YvcTdXTExWOW5QZ1g3dTNzMm9FaStlRzU2bk05T0kv?=
 =?utf-8?B?K2tDTlkxUXJsZXRFU3U3eStjM3BUWWhhalovRGR1Nm1zV0hsUTNtVTc2MDRE?=
 =?utf-8?B?R29kTVdVRmRVQW9tMitBM3hJU0lXbDRIMFVrWmR5bTg5UmJHRHZISFV1Yy9B?=
 =?utf-8?B?d0MxWGNaRnlSQVpveTdZMzJrVk1nMVhZZWkzYTNPWUtSYjVGck4wbTkrMnVK?=
 =?utf-8?B?c0VZT2xGcko5WDJnU21FTk9JVEJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <758164EB3D7D234493C5A96E1D0E98B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5582.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f6ce89-bb00-492f-b699-08dd993e49f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 14:38:16.3732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9PHWt0cpjXw+ot07S8mBfnvtpXaJLK+s/VziRLNvdwRvn0xEPRsRB2NQsZL2qoqbOXyH0XhY8crD3ov5OqNdV8S9cr27eLzw5sMNVTB0ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

T24gMjIvMDUvMjAyNSAxNTowOSwgRW9pbiBEaWNrc29uIHdyb3RlOg0KPiBGcm9tOiBFb2luIERp
Y2tzb24gPGVvaW4uZGlja3NvbkBtaWNyb2NoaXAuY29tPg0KPiANCj4gVGhpcyBzZXJpZXMgYWRk
IFNEIGNhcmQgc3VwcG9ydCBmb3IgdGhlIEJlYWdsZS1WLUZpcmUuIFRoZSBCZWFnbGUtVi1GaXJl
IHVzZXMgdGhlDQo+IE1pY3JvY2hpcCBjb3JlcXNwaSB4ZmVyIGZ1bmN0aW9uIGFuZCBhIGdwaW8g
Y2hpcCBzZWxlY3QsIHNvIHRoaXMgc2VyaWVzIGFkZHMgZ3Bpbw0KPiBzdXBwb3J0IGZvciBQb2xh
ckZpcmUgU29DIGFuZCB0aGUgeGZlciBmdW5jdGlvbiBpbnRvIHRoZSBNaWNyb2NoaXAgY29yZXFz
cGkgZHJpdmVyLg0KPiANCj4gRW9pbiBEaWNrc29uICg0KToNCj4gICAgZ3BpbzogYWRkIFBvbGFy
RmlyZSBTb0MgR1BJTyBhbmQgQ29yZSBHUElPIGRyaXZlcg0KPiAgICBzcGk6IGNvcmVxc3BpOiBh
ZGQgeGZlciBmdW5jdGlvbiBmb3IgUG9sYXJGaXJlIFNvQw0KDQo+ICAgIGNvbmZpZ3M6IGJlYWds
ZXZfZmlyZTogRW5hYmxlIEdQSU8gYW5kIE1NQ19TUEkNCj4gICAgcmlzY3Y6IGR0czogbWljcm9j
aGlwOiBlbmFibGUgZ3BpbyBiYW5rcyBpbiBCZWFnbGUtViBGaXJlDQoNCkkgdGhpbmsgd2hhdCB5
b3UgbmVlZC93YW50IGdwaW8gd2lzZSBpcyBhbHJlYWR5IGluIGR0cy91cHN0cmVhbS8NCmJ1dCB0
aGUgY29uZmlnIHlvdSdyZSBjaXRpbmcgaGVyZSBkb2Vzbid0IGV4aXN0IGluIHVwc3RyZWFtDQp5
ZXQsIHNvIGluIHYyIGVpdGhlciBkcm9wIHRoZSBiZWFnbGUtdiBzcGVjaWZpYyBiaXRzIGFuZCBq
dXN0DQppbmNsdWRlIHRoZSBkcml2ZXIgc3R1ZmYgb3IgZWxzZSBicmluZyB0aGUgd2hvbGUgYmVh
Z2xldiBzdXBwb3J0DQphbG9uZy4gVGhlIGZvcm1lciBtaWdodCBiZSBhIGJldHRlciBvcHRpb24s
IHNpbmNlIHRoZSBwbGF0Zm9ybQ0Kc3VwcG9ydCBwb3J0aW9uIHByb2JhYmx5IG5lZWRzIGEgd2Vl
IGNoYXQgd2l0aCB0aGUgVEkgZm9sa3MNCmFib3V0IHdodGhlciBpdCBnb2VzIHdpdGggdGhlICJy
ZWFsIiBUSSBiZWFnbGVzIG9yIG5vdC4NCg==
