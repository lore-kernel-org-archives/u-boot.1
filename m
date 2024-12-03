Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4028E64A82
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 11:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202218964B;
	Tue,  3 Dec 2024 12:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sb2aoCil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B4289048; Tue,  3 Dec 2024 12:48:55 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933E28964B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 12:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvNfYmwUixWunDXtAKsod8PBKppsv+OmS88HUmADKXjbzPuG7XPNs8Equ/L1VtF1aTs8qw9eGnhZTxF7TD0nK9dHfUeGW+iOhkxRVq7Accnr/Ef6yuukJIrHasOgiv51OSBraIX2Q+zQmWVB5prgjJnsl451Vw9tRMnX2QVS4eIqMyjyD0Dkf+42TvVw2Hk6ag3wQGBVZ6HUrO0lPN/juod/tgBLKZO/BVOT+aTjx9xrcW/QS43ParygSQAnclwk65d/3mI9Xw8fYYsPGVslxckHV0YvNB0rIdcEqP+XlWDe/8VMxFIc3H4dqnohSBI363hVc7J7sYsqgXWTHEAQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYlzH1XPp+OBieV6IwUeK7QOFQVTyFpqBeQ2I6+b1Xg=;
 b=HEX7FbBAGEhD1QFi7JXwHwwx2z+oIVHtBpFIx34Z3Tuum/uA9D1WjqMVoeqyzYf4ecyiXA3v32ce+64BcUEMlWwn2dJHcj1BmysCfwOttMCzTQ02Wl2wzrJH68Ix05mRGZfxEtYlEIL6biWAetTycXdQXiKBhjNkNea2MxOpc51z5SDtBtu8lE64I3YKY7nwjX3GI+WM1npis5glN8wxa9jyckXvG9ERrqSQck3urM/N8/HVmtaCENYsPUEZh4mVuy2+ErsPmyN0/Qc2BUzyX+p5FBTC5n4TmXXZK00qEnzvxVk3SVgWBMof8dHoL/90hyb/INW3PvbAb9wpPUuBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYlzH1XPp+OBieV6IwUeK7QOFQVTyFpqBeQ2I6+b1Xg=;
 b=Sb2aoCiloW0XtfqYhLcNtTjmwLGJFE3MnJakxOUxTQLQxZNO6v69p6ANYBRsgDD3/7QjghCwprtYSU2OBGIq5oum/NV5XgaPIBghWVxFwnH/uO6VU8TDOTb7kSyC7HExxctctqgv7SrbxxWdyACMw2KKcs99uFb5n1njvIg3CFc=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 11:48:48 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 11:48:47 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Topic: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Index: AQHbQkij5Vr6T6wrk0eUULAzACXQBLLUWkwAgAATYZA=
Date: Tue, 3 Dec 2024 11:48:47 +0000
Message-ID: <SA1PR12MB869712C44446C58C024B436498362@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
 <c4a9d8b7-9dfc-4317-b061-e6dd887d7efc@linaro.org>
In-Reply-To: <c4a9d8b7-9dfc-4317-b061-e6dd887d7efc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CY5PR12MB6059:EE_
x-ms-office365-filtering-correlation-id: 38395307-d054-40f0-a6f6-08dd139072d3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZUtNTzJ1ZmFtV0lteTFoeWZHMXFiN2hSRE0vcTNPaTBnVWFkaHpzOEVWTEhw?=
 =?utf-8?B?OG1nRGYxNUVPQ20yaW4rQ3FGdGZzZ2F5ZXV0aDg1OWpaZmJvV3VzN3VEeG1m?=
 =?utf-8?B?NEV3UzAwSVlUMXVXZ0ZKZ1VaQ0pIKytiVGtJZ25pNnVSelpsV2RFbDlpSC9Y?=
 =?utf-8?B?akVSNnRYbThTOFc0Qk9Lc3dxR1RtUmtrZHVoVEpZT01lamZ0VkdIS1RHNmVN?=
 =?utf-8?B?eWtST0dZUGk2a0x0KzJDQ0ZsTE5jQldBK0tDSDRyclRYY0dKMzNIL3U1cHBO?=
 =?utf-8?B?M0xEUUt5RUFaR0kxT2dFUUhFdHVIYXRUTUpiWGxtNCsxV1JKNG1YcWN3aTUy?=
 =?utf-8?B?S1h1SWRpc2dZV2g5UGYyUVRTNm14SFU3R2ZsblJ2MzhRbnZyOXdlYnczdWww?=
 =?utf-8?B?ZVlyd2xsNDNEdFQyNm5tV29vM3c4b3Q1bzYvc0s5ZzdkUTFDeFI5VC9WeEtN?=
 =?utf-8?B?d0tRanNUQVB5L25MSDBURGUxTHdpcEQ3aTlBK0wvR1h3a2taT1JEM3VIa3Rp?=
 =?utf-8?B?Vlh0ckhsNUl5S1dUUEk4WXZhVWl3YVRYR3d1UGo5RUhTZlVNeENqbmVMYmY1?=
 =?utf-8?B?Sk5WdHR1eTQrNHZPTWtmNVladXBQdWR6aUZuZTVaMWo5VWxFS1g4dmRGZ2dt?=
 =?utf-8?B?MmZiR3d3SGpJUHMvS3JzNGdiUVcrVEV0MDVnL3l4VDR4Z2svUVlYTURkemdT?=
 =?utf-8?B?RmUxR3BGQ2xRS2FIV2s0SGJQd2ZtSEJBMWh6TEhBOE1Xa0FMYzU3LzV4TXZW?=
 =?utf-8?B?dHFnajFqVGtpdWpqbU1pVU4vREQrb0JlZ3ppanRCNUNkTzRmRjNtZFJ3NjB1?=
 =?utf-8?B?RE1XNGQ4SWhUSmJGSzZtMDBaWlVRNFJnVk41Tlg1TkYzdVBqcXpPcVdrd1Iz?=
 =?utf-8?B?RitHek5pdTZhUFBINjNkdjMvTy8yZG5STitGWGRFSGNsSkdnZjB2MEN5SCtI?=
 =?utf-8?B?czZjaFcrRDRMM2h4ek16YkhSQVcvY0FabU5SNklFZGsydHBZdmNpVXEzbi9V?=
 =?utf-8?B?ZzJWTDJLY3JGRkhRdUdhb2FMZEkxaUgzVW1EOTZ1d0VGVzBlZUdWT0tjSU1G?=
 =?utf-8?B?T0NwblJGWlVOWWovV2s2RUhWaWkyQVk3NEdxV25ZanlmSGVEbjNrbmdncmZT?=
 =?utf-8?B?YjFXRVlVSjRMZUxIdDhvM0RGd2VaaTI3cWNMZm1KR1FWTGRDZ1cyTFpzdUNj?=
 =?utf-8?B?eldVMUhYMnBoSDRPUEEwZUEzcUJtanhqbWdYc1ZSSXZCcTBQWXZ4bjJUWXVH?=
 =?utf-8?B?R05NSjM4S3B3UHlNWEZ3cDNZWnM0aHM3bjIwbWgrWEExVzhLRk91dVJsZEgx?=
 =?utf-8?B?ZDBFRytxbXFCeEQ4YkpJczhIN3I2RE10NWI1TlNhTVVOdXZVdGR0WnJaZVdF?=
 =?utf-8?B?MUc5VXdCeUtLa2d0TnhvLzk0bXhuSi9hTUQ0Q1ZPZTZpbVU3cjJGTUFCUVhO?=
 =?utf-8?B?SFdmVEpURTRobU14Sko5ZWM5Rzd5NjFUR3BGTFpkc2pTQTg2L2dMT0hFOUU2?=
 =?utf-8?B?MTN2TjFvYVAvNXdIYVdUNjg3Y3dpVVZIb0JwWm5pWEs5TTh3dmgyNDhySnBk?=
 =?utf-8?B?ejNHUVp5QVZUaXVMZ09Jb1hWMzgxSEFneFl4VS9lNE5WWXQreWdpV0VlOWFC?=
 =?utf-8?B?UlAzVjlQYjVKek1iUTBLRXcyeEVVbXlxSEVGMUhkS0RHajltRHp2U0tjVjly?=
 =?utf-8?B?WVI0UW1KNXhnaVI4aEJPQ1FqV1dIOGY3SGhWc25UR3hvYW1UbDBFNnR6NG5n?=
 =?utf-8?B?SjFIN1lRN0Rwd003SzR6NUY3MDljWkhCSjlWZTFxRC9PVjRBbFBpOEdsTlFk?=
 =?utf-8?B?Z2s5em8rM1dobWgzTXFCaFVONUtmYUJSRUEzRFFCNVgvQ1JLTVA4UFpCNlk5?=
 =?utf-8?B?SlIyNlpSTXEvRmtEaytWdkJmNzJYeGlIR0dvWE1RTUszTnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xNYlB4V3VwS0N2WmRLUHpNaGg2ejVyVE5wcHNQY2pMWXV1WVRzSU5vb21B?=
 =?utf-8?B?MFVKS1dVMzRFakc0ak9VdjJiSmpUaXo0MHpMYWtJMVRYUnp6bDJhTFgyQ1dE?=
 =?utf-8?B?NHpzTGNsQzlFMElabTZyUE1JeWZYRnZFUXZsanNUZy9QYWFsS1o1KzZjb25i?=
 =?utf-8?B?U2ZRSDlPOTV0TDlFTktSdzJsQlMvc29Edmh1cjN2eTI0L1l4Y0c1U3ZzUVA3?=
 =?utf-8?B?d3EwSDFmWWRPbnUyVGV2SkZjUytsY2lRVHpaWlI5TEFWUUtDTHdzNGlrenYz?=
 =?utf-8?B?RzViL1ByTlN2R2Y2MStBSEtXUVJnQVZaSVFpOWJKU0JWaXRDTGNGM0lDVDFW?=
 =?utf-8?B?bysyQlFhZi9YdHhRQ2lGdXEwdk4zelViK2F5d0lsTkp3ZTluUGhYcUtNN2g5?=
 =?utf-8?B?MWtOR2MwamJFSElBb3dDS3ljY1dKSU12WFhVbnBqb3RWWG56Nk5FQUhRQTBy?=
 =?utf-8?B?b3ZLVW85Z1JycHJlSVVVb01xSnJzUEwzM2dVZ25CNWs4S29oWERtTnpKcWZQ?=
 =?utf-8?B?OVBBVXQxWWtWclVkUXE0cWM5Q1BXUmpNNUUxNTFGSkJndEZhNFZobVNrU0FH?=
 =?utf-8?B?SUREQlZxM25UVi9uUVl5WGQ1TlMxRC9qMmU5QkVpUnlKSk5kY3k5NENZNTUr?=
 =?utf-8?B?VkRJaHdpc0d1YVJnUmFXZGlySThRREw4RzhwaDEvNk94REhNUlVzNkEyV1NP?=
 =?utf-8?B?c1pTSDZ3RE1VL0VUWVRTdUM4SzA1RVNqNFBvWm1HenYrYnByV1hRUXV4aFVP?=
 =?utf-8?B?eEM0dTNIUTc0ZzJaakRJT0VjenpheUYyUW9pMjFTL1VvSnNsd1J1ZFFucTda?=
 =?utf-8?B?VDljRkZLZ3VOYVFXOVdydXUvMlc2a3BzaUFQRjU2UVdVQjdkS0hrRXgxbENn?=
 =?utf-8?B?SXVWb3BrWHI4bngyV1h2Q2pQWTgyZFlQay91Q0ZnUDVQN1J5Z1Q4bzhYRXU5?=
 =?utf-8?B?clVHQ0t1bzdMZmZZVHJSNU5IdVlYTW1QdzdaTFJvSjFSOFJ4NG1wZFF0d0Fv?=
 =?utf-8?B?QzJ3cC9GZ2VhMzBEa3VBdW1zMzRpN05RYVBFZGdQMHhGOUJRUTUzRTI5YjA3?=
 =?utf-8?B?NW1ONFdSaWdFMjErZDUxQzRnY09vaXREaUVLOGhWUlJlZ0hmYUFXbWRaMTQw?=
 =?utf-8?B?MHZxeFNrN0NXU2Zyb2RkVE85OWFQbHVRQnlzb1llaWoxaFArTWxjbVN3clFJ?=
 =?utf-8?B?RkwzRCtLRGhsUHRoTjhzMURrTVVCRnE3R1lBMjE2bkZGT0RkNUJ0NS9xQ3ph?=
 =?utf-8?B?ZFQwYkIyeXJLQ2Zaejl1ZUJ1SHAyQ2JnOUZHWGIzWnBkR1dKSkFPS1VjNVVw?=
 =?utf-8?B?dlFyc0M3OFpXcGRaRWoyMmpldWszSGdtNUNWcHR1eFhOWXFaOUFPbERiaStY?=
 =?utf-8?B?TXVYWU1ua1E0TDNvaUJXNjZ4ZTV5ZnppT3QrMmR6cGkzTEQ4aFNPdWZKWHJq?=
 =?utf-8?B?ZW5sU0tCWTltdUtBczdlakthNms3Yk53SHB0RFl2eTNBbTZSVm9hTHhNTjlO?=
 =?utf-8?B?Nm9VRmZFQVp4VEtwRDZrR3Y2QzBmM2RSQmNISVQ5bU4zTGxsV3ZYcG9TdDEw?=
 =?utf-8?B?RFQySDVzT2J1UEVWekZoMDRRcjlIanc1R0NROHFJL0doY2RNSTB0djRaSnFs?=
 =?utf-8?B?N0Q4ejFFQlVWdCtIYzRBZExMNitrZE01bVVhOXhsQzN2VXFSR2duUW1YN2tv?=
 =?utf-8?B?SXpZVUFTNnRqc0JXMTRzdGhyT21QU2NlamVnNEZ0VndEUlRJWE1FcXgxclVj?=
 =?utf-8?B?NHlHQXozMVVYRVAzUTBHQXBkN3FEVndlR3htY1hlVy9oQWxVakFMWUQzNG1j?=
 =?utf-8?B?ZnE3VHg4aG1ic1ZaYm5aYk5sZ29SSmViTy92bFFlTEFvbkRtYWppdGRyYWhD?=
 =?utf-8?B?c1krTzBIeW1FRnh3YldYd2lpTlN1eXMzTjJFenJRNUloaXhBZExKeW5vc2M5?=
 =?utf-8?B?dm1BQTZUZEQvNHhCR3RnUUl6c2VDZnRLVEhOajY5M05kNHRtVk5pVnpFUGdv?=
 =?utf-8?B?RjFVMGNBdnhXc0ozOGdmNW1uNlVtQjlnci9DL1JhZXdnWkJGbUpEcUx0a2hv?=
 =?utf-8?B?ZTZKVHpuWGpRVjRUcFE2S2FiaEtzSzl0YWUrWDN5Rk1yZ0lVRVhjd1lCdFE1?=
 =?utf-8?Q?eGi0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38395307-d054-40f0-a6f6-08dd139072d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 11:48:47.8745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujFTA85CAk0jmhKCnpC9Wv4H2SEtr+QJa2I8/tydGux16rLS9DQlp2GoO+LwjszRa/EtFh0HfwQYp2AESEzBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAy
MDI0IDQ6MDggUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFw
dUBhbWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+IGotaHVtcGhyZXlzQHRpLmNvbQ0K
PiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBqYWdhbkBhbWFydWxh
c29sdXRpb25zLmNvbTsNCj4gdmlnbmVzaHJAdGkuY29tOyB1LWt1bWFyMUB0aS5jb207IHRyaW5p
QGtvbnN1bGtvLmNvbTsgc2VhbmdhMkBnbWFpbC5jb207DQo+IGNhbGViLmNvbm5vbGx5QGxpbmFy
by5vcmc7IHNqZ0BjaHJvbWl1bS5vcmc7IHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tOw0KPiBz
dGVmYW5fYkBwb3N0ZW8ubmV0OyBxdWVudGluLnNjaHVsekBjaGVycnkuZGU7IFRha2FoaXJvLkt1
d2Fub0BpbmZpbmVvbi5jb207DQo+IHAtbWFudGVuYUB0aS5jb207IGdpdCAoQU1ELVhpbGlueCkg
PGdpdEBhbWQuY29tPjsgQXNob2sgUmVkZHkgU29tYQ0KPiA8YXNob2sucmVkZHkuc29tYUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtdGQ6IHNwaS1ub3I6IEVuYWJsZSBtdDM1
eHU1MTJhYmFfZml4dXBzIGZvciBhbGwgbXQzNXh4DQo+IGZsYXNoZXMNCj4gDQo+IA0KPiANCj4g
T24gMTEvMjkvMjQgMTA6MjIgQU0sIFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSB3cm90ZToNCj4g
PiBFbmFibGUgbXQzNXh1NTEyYWJhX2ZpeHVwcyBmb3IgYWxsIG10MzUgc2VyaWVzIGZsYXNoZXMg
dG8gd29yayBpbiBEVFINCj4gPiBtb2RlLCBhbmQgcmV0dXJuIGFmdGVyIG5vci0+Zml4dXBzIGlz
IHVwZGF0ZWQsIG90aGVyd2lzZQ0KPiANCj4gd2hhdCBEVFIgbW9kZSwgOEQtOEQtOEQgeW91IG1l
YW4/DQpZZXMuLi5jb3JyZWN0DQo+IA0KPiA+IGl0IHdpbGwgZ2V0IG92ZXJ3cml0dGVuIHdpdGgg
bWFjcm9uaXhfb2N0YWxfZml4dXBzLg0KPiA+IFRoaXMgZmxhc2ggd29ya3MgaW4gRFRSIG1vZGUg
b25seSBpZiBDT05GSUdfU1BJX0ZMQVNIX01UMzVYVSBpcw0KPiA+IGVuYWJsZWQgYW5kIFNQSV9O
T1JfT0NUQUxfRFRSX1JFQUQgZmxhZyBpcyBzZXQgaW4gaWQgdGFibGUuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBc2hvayBSZWRkeSBTb21hIDxhc2hvay5yZWRkeS5zb21hQGFtZC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJi
YXJhcHVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gUmVtb3Zl
ZCB0aGUgU1BJX1hGRVJfU0VUX0REUiBmbGFnLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL210ZC9z
cGkvc3BpLW5vci1jb3JlLmMgfCA3ICsrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS9zcGktbm9yLWNvcmUuYw0KPiA+IGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29y
ZS5jIGluZGV4IGVjODQxZmIxM2IuLjk2Zjc0OWY3YTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpL3NwaS1u
b3ItY29yZS5jDQo+ID4gQEAgLTQ0MDQsOCArNDQwNCwxMyBAQCB2b2lkIHNwaV9ub3Jfc2V0X2Zp
eHVwcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiA+ICNlbmRpZg0KPiA+DQo+ID4gICNpZmRlZiBD
T05GSUdfU1BJX0ZMQVNIX01UMzVYVQ0KPiA+IC0JaWYgKCFzdHJjbXAobm9yLT5pbmZvLT5uYW1l
LCAibXQzNXh1NTEyYWJhIikpDQo+ID4gKwlpZiAoIXN0cmNtcChub3ItPmluZm8tPm5hbWUsICJt
dDM1eHU1MTJhYmEiKSB8fA0KPiA+ICsJICAgICFzdHJjbXAobm9yLT5pbmZvLT5uYW1lLCAibXQz
NXhsNTEyYWJhIikgfHwNCj4gPiArCSAgICAhc3RyY21wKG5vci0+aW5mby0+bmFtZSwgIm10MzV4
dTAxZyIpIHx8DQo+ID4gKwkgICAgIXN0cmNtcChub3ItPmluZm8tPm5hbWUsICJtdDM1eHUwMmci
KSkgew0KPiA+ICAJCW5vci0+Zml4dXBzID0gJm10MzV4dTUxMmFiYV9maXh1cHM7DQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsJfQ0KPiANCj4gdGhpcyBsb29rcyBidWdneS4gbXQzNXh1NTEyYWJhIHN1
cHBvcnRzIG9jdGFsIG1vZGUgYW5kIEkgc2VlIHRoYXQgYmVmb3JlIHlvdXINCj4gcGF0Y2ggbm9y
LT5maXh1cHMgd2FzIHNldCB0byBlaXRoZXIgbXQzNXh1NTEyYWJhX2ZpeHVwcyBvciBtYWNyb25p
eF9vY3RhbF9maXh1cHMNCj4gZGVwZW5kaW5nIG9uIENPTkZJR19TUElfRkxBU0hfTVQzNVhVIGFu
ZCBTUElfRkxBU0hfTUFDUk9OSVguIFdoeQ0KPiBpcyBpdCBmaW5lIHRvIHJlbW92ZSBtYWNyb25p
eF9vY3RhbF9maXh1cHMgZm9yIG10MzV4dTUxMmFiYT8NCmh0dHBzOi8vZ2l0aHViLmNvbS91LWJv
b3QvdS1ib290L2Jsb2IvbWFzdGVyL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jI0wzNjAg
dGhlIG10MzV4dTUxMmFiYSBzdXBwb3J0cyBTUElfTk9SX09DVEFMX0RUUl9SRUFELg0KQm90aCB0
aGUgY29uZmlncyBDT05GSUdfU1BJX0ZMQVNIX01UMzVYVSBhbmQgU1BJX0ZMQVNIX01BQ1JPTklY
IGFyZSBlbmFibGVkIGluIG91ciBidWlsZCBhbmQgd2l0aG91dCByZXR1cm4gaXQgd2lsbCBnZXQg
b3ZlcndyaXR0ZW4gd2l0aCBtYWNyb25peF9vY3RhbF9maXh1cHMuDQoNCg0KVGhhbmtzDQpWZW5r
YXRlc2gNCg==
