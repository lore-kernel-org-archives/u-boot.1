Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3A7E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 13:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B3880104;
	Mon, 16 Dec 2024 14:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CUMZmCp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9375180141; Mon, 16 Dec 2024 14:50:09 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA678003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8kT/URMFL3hxHl53gUOpBPVyWCU2w5Cw0ygR/cnyrhe35N+8cOALFmP+HD6U7PBsanltNAoyQ3zeXJDlER5fE2648ICds2Xmo1Lc8j8qnBUksAAK3rNV2axUlSdNF7C9D+ReyOAQ8B1p3u/cRqLF9FwULuF4f3f2Z1FRVPlMLOEx//CHgSTLtM3EWbRb8oIRdBRXPj6WEbz83sP5lhSe0L9NTeWljOStd5O1sy3BoLaxEHvnxpJ0fdSit8k3LL4QU2eE6vikh179ZE71bA6CYLENqwUyUMCkDViKlgslQC0r6DgS+x+SrCZhXx4dxzK85YubmeUwNW3TDlQLIj/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4fipGLSTw4tTLXdcu5AWJ85xixcZix2FUyfocSVQLw=;
 b=G2MOeSIKHV9h3W7XCv/EQdQSX+wSsfatkDQJX/3sRoh4mCX9RTuAHRss6nnyNKe1+tBmLrj+r9o1xFuRi1Zgc2FTjVywrrql7e8SYRRdG2kVtQ6mrbC0A5zzOwegjwr9p/fMfmc7AMzw9/K/+td6WOCBL0WqwtQ0bMY+NI0BXJHsZ+Tu7brBhMHx9agBmuB3+6vtwzlFQSBom9nLK5gajC3BDrG9LktNyCm+HuYFDEam1hDZYUCq+2OGfIlB1v7zPEn557ElBcP9ZOcPZs5hAGAW7NnQ/Vh74J819FC9Tea+tpTaPPiPud4ojsCpqFrLhtG6APEP5INLAPVjIH+jDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4fipGLSTw4tTLXdcu5AWJ85xixcZix2FUyfocSVQLw=;
 b=CUMZmCp3pErQssek1ZmWqiGF8J9Q9hzbmvBaABftO+DuiTykXE98t7BBcFBjxm6UDLTFe+Ye38A2qkDC32hX5a5wtQ6OAkGdScHHDBMxKyPZ4VG92UtQvPnELd77i6X1InixHrNDwJ0YiGHI4v5zBj2owyeviypRvJew3IksLGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9397.eurprd04.prod.outlook.com (2603:10a6:102:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:50:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:50:03 +0000
Message-ID: <cfd4d79c-7015-4a35-b071-01ca82c7f9f6@cherry.de>
Date: Mon, 16 Dec 2024 14:50:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
 <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
 <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
 <6b93f3d7-c0bf-4517-9523-3c1a6a1e23dd@cherry.de>
 <445A20D66F127770+f902f36a-5648-4850-8dd9-99b7f36380a8@radxa.com>
 <e4a637ff-853e-4072-821a-8f79230913f5@cherry.de>
 <9FA439F060A2D933+5da96a32-8647-4949-b4e3-fc23fab19ace@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9FA439F060A2D933+5da96a32-8647-4949-b4e3-fc23fab19ace@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ec045-bc68-4143-a6fd-08dd1dd88ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmZYbjQ0OUZ0QjdaN1R2eDRSanQ5YUJ1QkRjbVRZNklLcXNTTXFEbmpNV1lF?=
 =?utf-8?B?VWR2Zm1tZTc5cFQ3WlZ4SG5UTUdGMDN0M1JMdGxZZGdNZ1RQSXpSUUpOL0tC?=
 =?utf-8?B?T3crd04zcEdPZUtiREMwSFhZTTdxcmNUdm1XZWx2OThiWUZoYzExTkN1bWdE?=
 =?utf-8?B?TnVzWlozeDh0L25nNDJyaE9HV1JUWVB1dkxDSk1UcGNsNDUzK2F5dUpzeTJB?=
 =?utf-8?B?THQ2ZlpQNHVRNlg5RGdnYXdsWDlLeGhXanFPMkpkOFRFUU4xUWlyQ3I4aXEv?=
 =?utf-8?B?Z002RmNXTjZKY25aYmsrSjg1VXZ0OHZKcFRwQ2pDR1J5QmtOYUlZYzRUYlFr?=
 =?utf-8?B?OWs1NHFmZWozekg1c05ZQ2ZKT3lSNjJ5N2NLalh3bHd1TmtzWHVmY2tQNUJK?=
 =?utf-8?B?QkJNODlmSERyU0U2UFBKWFlhRENTM1l3c3N5bm1EVncrT3pGeEhDSjRSVm15?=
 =?utf-8?B?U1N4TG5NcGpwK2ZVSUdpYjVRaURhV0hjTm9CakRHMXlUN0NpSDRYNmNnbFlm?=
 =?utf-8?B?TlEzdHVuL0FleG44dll1OWhoS0lPUlNnQllTNkg2cFZtT1RFWDBJMkVNdXVF?=
 =?utf-8?B?bWw3Rm15TzVoVHhxNGU5WFQrTEt2b0RkSVRjRzVrbXBGMTE0YllCVU5laVFQ?=
 =?utf-8?B?cEVpQ0RYK3ZLMTFEMVl2Zlp6YWJjQkNzTUNFRFdXODRqcHhVdEdJN1BVcnpV?=
 =?utf-8?B?MG9JdUkwWFYyb3lXZEoxUitja3NHbElpMkFoZ0VzUWhFNWN2WEFzZjFRcGNr?=
 =?utf-8?B?ekpwV3JqMjBRZVNJU0lCNDV3dURvYjQ0ZzFDNHlGdXJsQUI4SWhDemFLNGhh?=
 =?utf-8?B?RkRSckZwcnBLTktJYng2bVZ0dVJtNEx1eXlObmpMTXNtOVVJWGhBeUEzRjVK?=
 =?utf-8?B?Umk5OTl2Ym1ncEJsRUlnV0pHSEl2d3ArR016Nm9KVWxMaVVZb2dzcmxKVnJE?=
 =?utf-8?B?LzFQMkFnQmd3WFFGYllkNjlNQSs4Sll5THdjbnpPQ0J5a2RqZTkwMGJNWjd0?=
 =?utf-8?B?elhlT0Mrc0FnSEdIcEk5bUliUGxYS3h2ekdUREdWUlhXeVVweDVQTTRKZ3FQ?=
 =?utf-8?B?WUdqZEdjYkNoSWRsMU13b3F0T2FJQ1pSUG1DVlZKRWcrYU9MQkxRbEpFMGdu?=
 =?utf-8?B?eHB6N0R4aFBxR3VpRVl3RjBiMjFwaFQ1aER2STVUYzlZL0xIZHR1QXllZTlt?=
 =?utf-8?B?QTFBd0JXZDl1a2NXOHJJN2NJUEZjMEZpdGNFRm83SHZjNGZzK1V1NkJ1RVps?=
 =?utf-8?B?N3pFSFY3dHVmT0hrZXltamZOQ095VER2WFMzTUo0ZnFhT1JGR21PblBJdWl4?=
 =?utf-8?B?VENEOStINEtFcTRjMURKSG1FNG41ZHVTenJBTURXNGVReXVsS1lHU0xZN211?=
 =?utf-8?B?RW8zL0Y3bFdYb0tiTkw2VjJrUCtLZmpvSnhpQ0Y4V1VzanJxV1FIVjd4MmI4?=
 =?utf-8?B?aHFDYklxTDJhSXVuSUV5aDFQQU5FOHJRZ1ozRUdQdGRuVU5GOHhxVTk4K29x?=
 =?utf-8?B?K09IWllDYXkySHZ2NmNUaEM2TVZUQjZrYWx4aDJjYVN2aUliWTRXOTBQcENS?=
 =?utf-8?B?b2h1YWEyQjU1V2xYbDJlMHZUTWMzbE5CS3NJQlZDT0s4dHV1cnJTQmt6T0E3?=
 =?utf-8?B?M0FsbURGNzRhQ3hGSWRKZ3g1V1MyNXdsOFFIdlQzeEhVTXJKc2dlNVBacElJ?=
 =?utf-8?B?RDR0WXpYTW5DZWF4VUY5VTcxUmcyeXoza3F4T0Q5aE1RMnVpQjV1SWh2UVlo?=
 =?utf-8?Q?JiatANSyKWf3aX03mRKRoStYHobV6yF7Jyuq0Kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVuZzV2dnRXVDJ4dlBHRUs2YXJXRU5MRnAwZmU0TldzSGRML3hqTjRnWFR1?=
 =?utf-8?B?M3JpeTV2SWx0WEdpeG4yWFY1THRqM3ZRNXBtZUVvRldaUHNzMjFQNFBSeFh6?=
 =?utf-8?B?UUE3emZxbW15bVVKbUdtU0F6aSt5NnozUmhpRE50emV6RXdGL2kzZm5MUkhZ?=
 =?utf-8?B?c1BoQU95alRGRVd3ZEcyNjg0WnY4a0c4RU8ya1lRbmZaaWRHWm50Z2h0dU1Q?=
 =?utf-8?B?dExBWnJsZEhnbG1xaFJUMFN3SS9mNW9ROGxpd0lZSFhxMkkza1Bpb2ZtTTBL?=
 =?utf-8?B?aUtVbUZKNWNSelFDR2VwWnJmMW13bWEvUGNEVXlnOHRkY1ErNXQrKzhJak5T?=
 =?utf-8?B?M1EyZWJ0MHcrTnZqMDE0WDQ5MVo3b1dXSVMyVDgzQmpSZE9WZHJoUlF4K2hP?=
 =?utf-8?B?S21vYnd4cW5iQ0NpQk4xL0ZCNXY4eEJrTDk4NSt1QlRmd3pQUXV2TTI1d3RI?=
 =?utf-8?B?cWw2bFNvSGZ0bnRxZ2V2OEV5Z2hJY1I1YlJ4eEEwVHI5Z2UzY29BR0dLZFN0?=
 =?utf-8?B?ZEl3d3h2eEMrdW1udGgxMlNyT1VlVWcra044aDVSOU5OelBlTGxDdXVKbVpY?=
 =?utf-8?B?TlkrSnJKOUhIOFdEbGNtdE11QTJhYjlnbnZJWVoxdlpjUGdLaVhVeVNUQUxo?=
 =?utf-8?B?YklGbnBMVUs3NGhIYmp6MCtiYTR6eVlobEJDaE1hbDlzeXhEYitrdzgxSmpS?=
 =?utf-8?B?K2FaUkJreWxGN1ZqZnNrS1kzZis1ODBiSlBZZXlrZTNMQXh0YUx0Tk9ZWmVC?=
 =?utf-8?B?RkVkMzhlaHpRU1JBYUdqcjVCR0piRHhqRUhDYWw0bEgwYVVXazVNRi8xajR2?=
 =?utf-8?B?NG15VGRzeHpxV3E1Q3Z3QUI0RlhUR1JNejkvYnI4d1kxOVJXVGVRMklDQ1k0?=
 =?utf-8?B?WXJ2OEc2enVEWVJFZk5XR3Z5ZzFva2FLdkFyY2dVWThCeEVJTXdmeUJWVXJW?=
 =?utf-8?B?YXRaS1BDR2VzKzdaM01uUVhWZitGbFV1RmsrODhQQmwvK29tY1ZPS1BFemFm?=
 =?utf-8?B?akpDS0ZORndLdEhLNEdRbGwwb0JydmtTS1JXbDEwVjllNDVsQk1nK3FQeXRl?=
 =?utf-8?B?WjNxS3Fzb2E2SG90NEJsOUxITmVYODNkVHQrY04yOU9QbndtQlBrZ21teWpt?=
 =?utf-8?B?U3M4dTBrdTBlbjdMelZtempLZzhac0ppNGREK2s1RzB4bHNxckRLTE1HZURj?=
 =?utf-8?B?UldKTFlkcjBhMExJVXZINWdYZFVxcmVrNVhWWmtiU0VjTHJsQmN5ZkhkN1BP?=
 =?utf-8?B?QnpYdk9LU01FSGxZd3ptRHJyUnZpVnBkTE5FU2IwY2dUTUxRcmhFeCtzZ3hQ?=
 =?utf-8?B?cmpjSFFpMDBVemVlTWxzUkRGRlZEL29MYWJjem9rWVM1dHdhTE1XN1VqU1Ja?=
 =?utf-8?B?Q08vNXN2cFhLVVlXcThCT3VXbjVFRXEwa1pOQjkveFhvZGl4RjJSV0tEeXlo?=
 =?utf-8?B?NDkzR0NrNVNQVXg4RVlVVlpuTHJoZmh6YjdZSlN5M0lHdEdHeCtiUDczL3lk?=
 =?utf-8?B?VDRuSEFFbU9mNURCOXNtYWRRU2Q0UHBSU0daNU4veXdLQWFDdmNTbGl3Qm5J?=
 =?utf-8?B?U2h3VFBYSU1wSk0wZUdXRUIralVyaVB1cmJsd2hPeGpjSEhiYWQyNVh4djgw?=
 =?utf-8?B?RUNONFJZTXA5M1FRWTlQcHNYQWFKVHI2dVN2UmtlTzM0b2Z6Q1VvL1k2V2Fn?=
 =?utf-8?B?UGhCdDlyRHJZRmEyUVlHdTN1T2JMUnhRZzhuWUx5K3V5TDVkWHd6Y0lIVnpT?=
 =?utf-8?B?bU11MklxYWVOQk1Gd1ZMcXo3UVhSU29Dd1QzNkxmMW1jM25keGh5alYvMUIx?=
 =?utf-8?B?VVNPSXdrSlJiaDBrRlRDOVp3aFhMSFpwd0NkWXJ6QXFLQ25OMmhtNFBmTkhs?=
 =?utf-8?B?Zzlkb1YvQysrUEpHb1IwWm41MVRyT0NSUUNDTlVEVWdQdHNkREswMTZ2Qk1V?=
 =?utf-8?B?YUxmY2ViSnJSSmNVN0pRMzAwSHF1U0RQaklsaWdPWXl6U1J4YmR1NXVKdjI5?=
 =?utf-8?B?T09VY1NGWExCZUE4ZzZvUG95aDIzdU5kcm1NSE5rN1pXdk01cU1obG5sODdv?=
 =?utf-8?B?TG1pNHRQaVREZXkvKzdmcTRzaGJOUVo3ZG5zSWFwcDYrZTRlZVlWY0o1QXBm?=
 =?utf-8?B?dnRnbWZPbGhIUk5WNlpIcW96dzkwR2Fjc2pyYkhDUVg4aDNFajJDTndKSUp1?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ec045-bc68-4143-a6fd-08dd1dd88ab2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:50:03.5752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiUMR6oXckklAeZdxUwHi4XSQ28kTS1PoU/8/s2imJfn1Nhp58aIaHBowVrB8QEC8gBnR1O5zhPPgSaQiLRZQFCtk4w7+Uaz08a82ryWKl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9397
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

Hi Naoki,

On 12/16/24 2:25 PM, FUKAUMI Naoki wrote:
> Hi Quentin,
> 
> On 12/16/24 21:47, Quentin Schulz wrote:
>> Hi Naoki,
>>
>> On 12/16/24 1:39 PM, FUKAUMI Naoki wrote:
>>> Hi Quentin,
>>>
>>> On 12/16/24 18:57, Quentin Schulz wrote:
>>>> Hi Naoki,
>>>>
>>>> On 12/15/24 2:37 AM, FUKAUMI Naoki wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> Thank you very much for your review!
>>>>>
>>>>> On 12/13/24 22:11, Quentin Schulz wrote:
>>>>>> Hi Naoki,
>>>>>>
>>>>>> On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
>>>>>>> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>>>>>>>
>>>>>>> [1] https://eur02.safelinks.protection.outlook.com/? 
>>>>>>> url=https%3A%2F%2Fradxa.com%2Fproducts%2Frock5%2F5c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cbe7d810ae88f4203af8208dd1ca921c6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638698234938145886%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8TcHBC2dV1LzouPSR8%2FICOBVshq9RndgMQS3m3XLwFs%3D&reserved=0
>>>>>>>
>>>>>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>>>>>> ---
>>>>>>> Changes in v3:
>>>>>>> - fix compile error
>>>>>>> Changes in v2:
>>>>>>> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
>>>>>>> - include/configs/rock-5-rk3588s.h: fix include order
>>>>>>> ---
>>>>>>>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>>>>>>>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>>>>>>>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>>>>>>>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>>>>>>>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>>>>>>>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>>>>>>>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>>>>>>>   configs/rock-5-rk3588s_defconfig            | 94 ++++++++++++++ 
>>>>>>> + + + ++++
>>>>>>>   doc/board/rockchip/rockchip.rst             |  1 +
>>>>>>>   include/configs/rock-5-rk3588s.h            | 15 ++++
>>>>>>>   10 files changed, 239 insertions(+)
>>>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>>>>>>>   create mode 100644 configs/rock-5-rk3588s_defconfig
>>>>>>>   create mode 100644 include/configs/rock-5-rk3588s.h
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/ 
>>>>>>> dts/ rk3588s-rock-5-u-boot.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..be1a2f9ae7bb
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>>>> @@ -0,0 +1,16 @@
>>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include "rk3588s-u-boot.dtsi"
>>>>>>> +
>>>>>>> +&saradc {
>>>>>>> +    bootph-pre-ram;
>>>>>>> +    vdd-microvolts = <1800000>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&sdhci {
>>>>>>> +    cap-mmc-highspeed;
>>>>>>> +    mmc-hs200-1_8v;
>>>>>>> +};
>>>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/ 
>>>>>>> dts/ rk3588s-rock-5c-u-boot.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..bb1cc9e4a279
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>>>> @@ -0,0 +1,6 @@
>>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include "rk3588s-rock-5-u-boot.dtsi"
>>>>>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/ 
>>>>>>> mach- rockchip/rk3588/Kconfig
>>>>>>> index b5a0e624a532..e1487ecb0464 100644
>>>>>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>>>> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>>>>>>>         Front-panel connectors for audio and case-power, -leds
>>>>>>>         Powered by either 12V, ATX power-supply or PoE
>>>>>>> +config TARGET_ROCK_5_RK3588S
>>>>>>
>>>>>> This should be TARGET_ROCK_5C_RK3588S?
>>>>>
>>>>> rock-pi-4-rk3399_defconfig uses CONFIG_TARGET_ROCKPI4_RK3399.
>>>>> I'm doing same thing.
>>>>>
>>>>
>>>> config TARGET_ROCKPI4_RK3399
>>>>     help
>>>>       Support for ROCK Pi 4 board family by Radxa.
>>>>
>>>> Here you say this option is for ROCK 5C only.
>>>
>>> Because this is first patch which adds support for ROCK 5C.
>>>
>>
>> That's fine, you could say something like:
>>
>> Support for ROCK 5 board family by Radxa.
> 
> More accurately, "RK3588S based ROCK 5" for now. I'm not sure both 
> RK3588 and RK3588S based boards can be supported.
> 

Sounds good to me.

[...]

>> Is the ROCK 5T going to be supported by that common target, defconfig 
>> and board file as well? What are your plans :)?
> 
> I'm thinking to add support for 5B+ and 5T too. But for making single 

Are you planning to use TARGET_ROCK_5_RK3588S for 5B+ and 5T too?

> target, it needs "check SoC variant" code in addition to check "Board 
> ID". I guess following code may be used:
> 
>   https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Fpatch%2F20241110005622.1515100-3-jonas%40kwiboo.se%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C204a757d4a3045d900a008dd1dd52129%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638699523428166461%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=CLTAcH08Qzmu00q9KH1PuJuUxnAuFcRKobLhnhFR3nI%3D&reserved=0
> 

or just directly reading the OTP value you're interested in. But yes, 
that could be an option too. You could also have a target for all 
RK3588S Radxa boards that you can support with the same code, and 
another one for RK3588 Radxa boards that can be supported with the same 
code. You can have common codes in a different directory if you want, we 
use this for Theobroma boards for example, c.f. 
https://elixir.bootlin.com/u-boot/v2024.10/source/board/theobroma-systems/common. 
Plenty of options :)

> BTW, unfortunately, Board ID (ADC value) for ROCK 5B is not fixed...
> 

Does this include the ROCK 5B+ as well? It seems SARADC_VIN5_EVB_HW_ID 
is pulled high for that one though?

Cheers,
Quentin
