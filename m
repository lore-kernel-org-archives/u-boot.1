Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BABC7115A
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82EB80C93;
	Mon, 16 Jun 2025 09:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xd6D1TPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C40382A0A; Mon, 16 Jun 2025 09:53:59 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42758007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCQeal8sIfhGBeEKHxjpui+10YCcj3ZMffNG5VHr7+heE/cbeFz7YnRNctEelOdfpmLCQ0T6Awqe+qikVxI3aPxOFFV1rFOZHY4NwD+ONiy73LQLXL8vx+pIYaVtygcS7m4oENwGV9HmeudhJGRlr8YfTe8ojVmmJ9f4NxkkQz+fa/tZ9r+jzCgqQazgphcgng0PpzHRw4OPdhHHJQ5fwSZQerNlig5l5VpEh/K4HfoKtvnqYb4kCAxwFjEyze4twFdEtm08uFrGhimFT+pNqXuvWVEZwj20KW5SwrQK36OGaL0rdFSCzjQiqzZKjuSJ2SOhPOsEtpCpzjKQP3lkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxe0P4EGGKGFWr77B0M4tdcsuR6Csgx67Ie9mdXgXgo=;
 b=oQIDoSDPl0X4MEcd/t4psbmyag4vDMymYfdFBMtwnlZ6w5SNOAJCna0ArIZBiV/q/hUo9VKnlwMZJJGD9tx6YQ8hoUOn3H7sDWgSZ0HFxoOsdmtARUezhnlMgXD1Dw7woGgdbKlYsJ1soA4znLcwyOg/eCSPQl2mAgFEFkd1m4EKWnz7Qu5kkVJHcPqVaJcH4Jd2ON03k04wKmF5jiBfUZ6HpIGh+5kW/GzCKW3Eu4hO7bekyFwTMg/I7ZjMvz0TQ+iuMnX8z2OeFhoN01jQQI0tksJ0riGOOcNvTxSOj996VNMklLuWUhqkC346JKHXNiaN0WZ9URkCYNfEV+396g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxe0P4EGGKGFWr77B0M4tdcsuR6Csgx67Ie9mdXgXgo=;
 b=Xd6D1TPDYaTlBRke+IHgobYEmdAokdMytRqQcywv5a2g1mio6nXcd+For5KMbhJ4/MvktpC/JXDdPv3p4rWGR7EUa1ZeT/QwGEGCtgejHl7NvkpAyQj226FlIT+x/8kz0G9lHxccTT1INs+Q9m0sCYyBIrt9pwV+YJxSDKCpnmjZDWjzqhGCyRBKSIgwAzI96zy0Yi+EEbjMcVnzklIpbHCC+t9xQyO4Dkr/fvTAHjAj2UGaeQLZa5zDNwooc0N1t0TziyUDeLjt4hdWQKXZbPF10+Hou1f91sPORF0/z7jSurJtaQqLX8Wmt8IdMGw7NLRz97sXOv7SKybcY4yq7A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:53:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:53:53 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Enric Balletbo i Serra <eballetb@redhat.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjExIDE3LzIxXSB0b29sczogaW14OGltYWdlOiBh?=
 =?utf-8?Q?dd_i.MX95_support?=
Thread-Topic: [PATCH v11 17/21] tools: imx8image: add i.MX95 support
Thread-Index: AQHb3pPO3XUxLxMfI06WSecg+Yl7oQ==
Date: Mon, 16 Jun 2025 07:53:53 +0000
Message-ID: <PAXPR04MB96443123F3509A4792156C23E270A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
 <20250428-imx95-v1-17-a3df9c340ace@oss.nxp.com>
 <CALE0LRtOTErhJ=ixnN_pSp2YROGyW9CtMXQ3GXF46mH6bkdfjQ@mail.gmail.com>
In-Reply-To: <CALE0LRtOTErhJ=ixnN_pSp2YROGyW9CtMXQ3GXF46mH6bkdfjQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8438:EE_
x-ms-office365-filtering-correlation-id: de5c94cd-c154-4e01-8f8d-08ddacaaf091
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?VGRZVFUvUkpKMjF4QTNJYk5ITGFUSzFpaTNxaVJKV0djQ094cjVzdzU3d1k4?=
 =?utf-8?B?bFJjRytTcEdNbjFGMnRzeXBNaGc4aFJoY1lJcnU1TVF3SS9UbVZ2OERyM2FM?=
 =?utf-8?B?YWVzeTBtNmIrOWYxTGRldmtQcFRyY2gxOXo3V2hUc1hobDRKcmIxRmpUeHh3?=
 =?utf-8?B?czRoQWpPZHF0T2l4VWlUOW92dlR2aGxVTzdhUUY4YVVIbzNCc2hqM1IrL0U1?=
 =?utf-8?B?ZTRPUmlIeTBsbDBTdGR1ZzcwaTBpNFlzZ0hwb1ozNUtjb0ZjR2hMZWwrWWZB?=
 =?utf-8?B?YU5vZE1yM0wvRTZPdVRJSUtlU2Yyd0ZKSktxOGNhZFZSeXZpTVVhYy84ZnNn?=
 =?utf-8?B?ZW9Lb3ozVE81R1E0bG1Vekd2bUlTQ3FLT2R3WGZtTXdVTlRKc3hkdHNYUk5p?=
 =?utf-8?B?TXhGVXZwRkNBMHpsbjFKMzB0NDNWa1g5RjlyZ004WGd1ODVGMksxMndiS3Iw?=
 =?utf-8?B?T2g4YkQ4eWJ3cy9jVVk5TmVaUWNUaXhVZGl5OE9KVTJ2eTRJZU56WlM5aEtN?=
 =?utf-8?B?UitBOERIcXd6SkVod0NTSjVzbGJXQWdnMGQ0em53QlI3VkN5eW9ldHhDMFho?=
 =?utf-8?B?Ym0veWtCVllEZkVTQlZBdHZ6NURtUE9PQkJjU2NwSkEwZTl4T0o2VFYvVnZm?=
 =?utf-8?B?dmprZDVaOGhHTGlXTE1IQm1UZ3A5T2tPU01TYk9yZUc4b0VkNkF0a0hFc1pq?=
 =?utf-8?B?TVlhdTF3WVJBRis1bjVqd096bDhuUDFQTUhzVFY1RU8vN0twazAzNkVOMk9E?=
 =?utf-8?B?WnBCTGtaNkN5UXNnQ0ptREo5TlpocnNIR0RPM1M0VkxpQStiRk9vOXk0M1Bq?=
 =?utf-8?B?d0NhbHFqcXRBMG9Ld0FyazYzVVVlQlZodk9tb1N5VTdkY0Q4S1VmcElIdUow?=
 =?utf-8?B?UXZSRnBWdUNabXM0Q2JvY2phNnJGREdIRDZUQnFHaGVVWmtibW9OMWlJeG8r?=
 =?utf-8?B?emllbmxOUDM4Z2VvRlF5ZFM4WkVMcVF0S2hZZTM5WXJxMThpTERDZzcxSjM5?=
 =?utf-8?B?bm9sTXhNYm5hbkpJZFZvY1ZSTUFUS2JZWWNmVGF4bVd4RHl1TUtuQWZuY0Mx?=
 =?utf-8?B?WHJLeVM5OHhqUGFmMkFmTDYrV05pT1VwYTRieVllQWdsQmdCVmZFd1R0RmZY?=
 =?utf-8?B?aUtES3RnK1BuYTVDMWdjamZXVk9MM0Q1RExHNWovUTh5VE96ZDJaRVdHblFC?=
 =?utf-8?B?bytBZytkT3dOUHllUzJGd3ZtR1h0UWdvZG1WanVtMHh2YjFNODh4aHFUcURw?=
 =?utf-8?B?YjBhdkp4MnBPSmh5aVBIUWlZdW9XMHhrOHJOUERLS1hvVEloQlFaTUFoSkwv?=
 =?utf-8?B?K1hvWEhyY0s1N1pNbFVvUk9aMVBJQmduTE1wUGxjK2dqbGJjZFhSL1J4K2RO?=
 =?utf-8?B?Yk5aRmJEQ1Z2eGhycFU3Y2h6UWkwcFl4MzRON0JsYVY4T1BGejNER2xZSzFQ?=
 =?utf-8?B?NzZFVzBsb3UxM29VQ1VpWEIwL0xxMmRCa0p1L3lDM1NrMjl1bDdpMFdnR2V0?=
 =?utf-8?B?aTNRZkhKSjFpbEJzeVRLcTR1bndWVVJmbEZ1bmhacmdFcWFoUlM1WG1SYzVS?=
 =?utf-8?B?TElyOVowbS9CUXpRamR2TmtmckdwYU9abzBZc3pYWDlkMUpCM1grVDZFNjRY?=
 =?utf-8?B?WWdYTDhpMGZjMFJ0NFUwZllvSUM2bzdLZGlTOWlGU2VQM3Y2eGYzUFdwRURH?=
 =?utf-8?B?b09hSjNtS09FTUZ2ZXY3OEg2ZkNJRklsd0pWQ0NHRlRFRkkxSHlPd3F0T0Zp?=
 =?utf-8?B?R3VBNDdZaVk4bStBK2tpZjNKMWkrRlo3ZmtSZlo1N2RJMk1uVHRrTE0zdGxl?=
 =?utf-8?B?T2wzb1BzQWxhOGxnTW05ZjA5dFY1R2hxV3N4eTZJNmdNQjZaS2tuL3VBVWZQ?=
 =?utf-8?B?OTRoQlB5RDByVWhocC96ZDBySzZza29Fa3RMZmFoNjhIVG9GcmdKMUZTSG8z?=
 =?utf-8?B?d0NVT0tJYzZpU01LQ3d6R1Y4aVJ1SlM0aGo2MWlvZ0NWZ211RDgwZWdsV0xl?=
 =?utf-8?B?WklEd1B0aEhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29wUk1KT2dxWVk0RC9CNDZwUUo0bWE2L0pGRTQrdFU1Vlc0dlpKZ3JIRkxB?=
 =?utf-8?B?RmUxT240WUpxSDVJUzZJaFBZZWtJV3lnZU81NHBITkU0K2dJMWl6TXRjbUli?=
 =?utf-8?B?aitTNSt1NnZaNEdHS0I3VWVJMkxBK1VOenhjTVdkM3ZtV2RnNStEVERRd1dp?=
 =?utf-8?B?RVB5bjNGSzJ5VTdyRjl3dGUzbFVrM0VGSkRyaTUzZFNPRlp2cVRRZkFsK0N2?=
 =?utf-8?B?eW9iRFJWQ1BqbHFydGNaQUtmREFKTW0xMlZQQUNjTHBENEhVK0diUFVNMnNS?=
 =?utf-8?B?TFFXWjQ4M2l6RjMzLzdCZnV4R2d0U01ieDFvU0Z6R2s0VmJESXVvK243bUgv?=
 =?utf-8?B?M1NGaFJqRW5QZWxYazlEMlluYjJxeXZ5NE50bHRwTzJBSm14bUxDdUFLWDI1?=
 =?utf-8?B?YkZ1a0oxOTh4dk5rYmNNcGVBYnZsVkkvSlRJbjhnK2E2ZHdMeEEzdUJHREV6?=
 =?utf-8?B?d3J0SVpnL0xoRmdwSWJNeC8yWTdRSWwzcjBoMWdZcjRod21Jb0ZYNVhkVFdN?=
 =?utf-8?B?b3U5T2J4MncyeEdzQmlyMTZkcXhNUGNNeXFyRnRoS3lMU3hGekgyUWRaU3My?=
 =?utf-8?B?R0d6aGRJbjdUN2lad0JXdndOZnRQaVIrd2FBTnpmc0N0dHRIQWVpblRzTDgz?=
 =?utf-8?B?d2xZcEZ0enFaejZDdWRlQnVQU2lKOHFyQUJMWEt3KzMreEtLZHNvQjdsQjNS?=
 =?utf-8?B?VUNJNzFQQXZDWU9yZHRXbXpGNlJKU3YzMmx3ME1lZ0txQmVCazN4MWEwVTNC?=
 =?utf-8?B?K201Y2Y2NXdJd1QvVzVxNVE0dndlbi9XN1BUVlJpMkpERExMOUhtZU1SRTll?=
 =?utf-8?B?b2hvZUwyQlcrL3hUOS9ZRTRRRlZwS3FsVmtkMkNQeG5oS0p5d0kvU3h5cWkx?=
 =?utf-8?B?Y2pBaEtGd2hNV0VRc1pOVjBjNitYWWUyTkdZYm0wRXJzWUFUSEVZcVllRFB4?=
 =?utf-8?B?Y2NlSVhhZW45SmQzenB4cGxPQWpJdTRXSExzN3pIY0ZZb2EvMjhHVTdZSWJr?=
 =?utf-8?B?dkZ5WjFpcndmR2VIdiszdkhRM3JobXQ2Vm4zZGJzeFJHSllLUjRvOXFKWTZl?=
 =?utf-8?B?ektpUUVLMjJIaHVIQTlFenBlRGVSemRTaWFnYWcyOVNHV1Z5blFUVkRNaXBN?=
 =?utf-8?B?UE9ycnNnTk1TNkgxSXVWRFdqblJYa1MvQmp0N09pcmZnR0QrTlM4T2ZQOUhs?=
 =?utf-8?B?U0wwMS9aTnFaNXV1U2M5SUJWeXJIWnBxNFFZWDdvTkMwWmdWQS80ckxpUnc2?=
 =?utf-8?B?c0dhbHpqZVExZ3QzNktXM2tiaER1S2swRFJZdDNRZlBQMXd5TTZxZHdyV1Vt?=
 =?utf-8?B?ZUc3b0xJWGVkMmhadWY3cElxc0dyRGdNUHBEdW5iaUZ2WmJUb0dPSjdjYVpr?=
 =?utf-8?B?cjBuUDFzak1lbmFNOEpkUEJQOVU5eSsra1d1Umh1cDZRbDY4dlpsem1PUzRH?=
 =?utf-8?B?Ni9ROVlKSjJmdjV0WG51Y2V5eWNtUWFobWlhK2l4ZzB0TnFPcU5HU2IvTm03?=
 =?utf-8?B?RWRhbStMTkZqVDJVRjR2Skg1K3diTkRMMDdNcUZqeGgxRUhwSFA4OEl1Nlo4?=
 =?utf-8?B?NVFlOTVzUWI2cEtFYnRwcGtWNitaM0s1SWhYYXpXNUppbTd2dlRTRm5KWWUx?=
 =?utf-8?B?YjUzOXBaR3RxNGl4L1E4b05sTzBQN2c0QUFvWHJoOTkvM2xwU3hPdzcyYVhm?=
 =?utf-8?B?eGtXcC9VS2ZYR3FqcWJ3ZVVQeE9odFNUZ2sxK0JDRHJsdmZncUEzNGYvRlln?=
 =?utf-8?B?NkhmT0pnUlFaRVgrOUxRWEFJTlBJTm4vdlZhVDFsT3EwRFUzcjRxSVR3QWYz?=
 =?utf-8?B?V0x6b00wc3VBTjBsemFYUFM3cVNLSzhIcytSZjhxbDdtY3BQWDI2UlBnZzRH?=
 =?utf-8?B?ekQ1WmhCMjB5bGEvV3hENGN4VWI2YXl6SXhTNWxqdkttNEQvWCtDcEFTUHVU?=
 =?utf-8?B?L3RscFYrK0Zsbm9oQW9sT3czK0d0L0JxRUMraXBBSVlHUTJBaUJSYnppWmhT?=
 =?utf-8?B?SzlnTEJjY2ttSGJ1UFZCRGZmdFE0cEFZQ0Y1MDQ2VXY4SSs3NWFYV3ZJY2ZH?=
 =?utf-8?B?OTY3T3FWaFc2elViM2EyTFUvMll3WlhBSS84NGpGbFltT0szWFp1TW1LeDhk?=
 =?utf-8?Q?kUAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5c94cd-c154-4e01-8f8d-08ddacaaf091
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:53:53.6563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8ljCFhUD+wc/Sd5hH42OcT5htwzjugKOOgGupHkmeMadE4arS9YWYlXdX5FS92tomZtUjJKw+mk9ca8Q7GW7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRW5yaWMgQmFsbGV0Ym8gaSBT
ZXJyYSA8ZWJhbGxldGJAcmVkaGF0LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0NuaciDEy
5pelIDIyOjE4DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54
cC5jb20+DQo+IOaKhOmAgTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IEx1a2FzeiBN
YWpld3NraSA8bHVrbWFAZGVueC5kZT47DQo+IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwu
Y29tPjsgSmFlaG9vbiBDaHVuZw0KPiA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IFNpbW9uIEds
YXNzIDxzamdAY2hyb21pdW0ub3JnPjsgU3RlZmFubw0KPiBCYWJpYyA8c2JhYmljQGRlbnguZGU+
OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBBbHBlciBOZWJpDQo+IFlhc2Fr
IDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
PjsNCj4gdS1ib290QGxpc3RzLmRlbnguZGU7IExvdGhhciBXYcOfbWFubiA8TFdAa2Fyby1lbGVj
dHJvbmljcy5kZT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYxMSAxNy8yMV0gdG9vbHM6IGlteDhp
bWFnZTogYWRkIGkuTVg5NSBzdXBwb3J0DQo+IA0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFp
bCBmcm9tIGViYWxsZXRiQHJlZGhhdC5jb20uIExlYXJuIHdoeSB0aGlzIGlzDQo+IGltcG9ydGFu
dCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiAN
Cj4gSGkgYWxsLA0KPiANCj4gT24gTW9uLCBBcHIgMjgsIDIwMjUgYXQgMTI6NDHigK9QTSBBbGlj
ZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gaS5NWDk1IHVzZXMg
YmlubWFuIHRvIGludm9rZSBta2ltYWdlIHRvIGNyZWF0ZSBpbWFnZSBjb250YWluZXIuIDINCj4g
PiBpbWFnZSBjb250YWluZXJzIGFyZSBuZWVkZWQgY3VycmVudGx5LiBUaGUgZmlyc3Qgb25lIGlz
IGNvbXBvc2VkIG9mDQo+ID4gYWhhYi1jb250YWluZXIuaW1nLCBMUEREUiBmaXJtd2FyZSBpbWFn
ZXMsIE9FSSBpbWFnZXMsIFN5c3RlbSBNYW5hZ2VyDQo+ID4gaW1hZ2UgYW5kIHUtYm9vdC1zcGwu
YmluLiBUaGUgc2Vjb25kIG9uZSBpcyBjb25zaXN0ZWQgb2YgQVJNIFRydXN0ZWQNCj4gPiBmaXJt
d2FyZSBhbmQgdS1ib290LmJpbi4NCj4gPg0KPiA+IEJlY2F1c2UgRERSIE9FSSBpbWFnZSBhbmQg
TFBERFIgZmlybXdhcmUgaW1hZ2VzIGhhdmUgdG8gYmUgcGFja2FnZWQNCj4gPiB0b2dldGhlciBh
bmQgbmFtZWQgYXMgbTMzLW9laS1kZHJmdy5iaW4gYnkgYmlubWFuLCBzbyBpbXg5X2ltYWdlLnNo
DQo+ID4gZG9lcyBub3QgY2hlY2sgaWYgbTMzLW9laS1kZHJmdy5iaW4gZXhpc3RzLg0KPiA+DQo+
ID4gV2hlbiB1c2luZyAibWFrZSBpbXg5NV8xOXgxOV9ldmtfZGVmY29uZmlnOyBtYWtlIiwgaW14
OV9pbWFnZS5zaCB3aWxsDQo+ID4gZGVsZXRlIHRoZSBsaW5lIGZvciB1LWJvb3QuYmluIGluIGNv
bnRhaW5lci5jZmcuIEluIGZhY3QsIGJpbm1hbiBpcw0KPiA+IGFsd2F5cyBjYWxsZWQgYWZ0ZXIg
dGhlIHUtYm9vdC5iaW4gaXMgYnVpbHQsIHNvIGlteDlfaW1hZ2Uuc2ggZG9lcyBub3QNCj4gPiBj
aGVjayBpZiB1LWJvb3QuYmluIGV4aXN0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNl
IEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IA0KPiBJIGJpc2VjdGVkIGEgcHJvYmxlbSB3aXRo
IHRoZSBjdXJyZW50IG1haW5saW5lIHdpdGggdGhlIGlteDhxeHBfbWVrIGJvYXJkDQo+IGFuZCBz
ZWVtcyB0byBwb2ludCB0byB0aGF0IHBhdGNoLiBBZnRlciB0aGlzIHBhdGNoLCBJJ20gZ2V0dGlu
ZyB0aGUgZm9sbG93aW5nDQo+IGVycm9ycyB3aGVuIHUtYm9vdCBjcmVhdGVzIHRoZSAgZmxhc2gu
YmluIGJpbmFyeS4NCj4gDQo+ICAgIGVycm9yIHdyaXRpbmcgaW1hZ2UgaGRyIDQwMA0KPiAgICBN
S0lNQUdFIGZsYXNoLmJpbg0KPiANCj4gVGhlIHJlc3VsdGluZyBiaW5hcnkgc2VlbXMgdG8gbm90
IHdvcmsuIFJldmVydGluZyB0aGF0IHBhdGNoIGhlbHBzIHRvIG1ha2UNCj4gYm9vdGFibGUgdGhl
IGJvYXJkIGFnYWluLg0KPiANCj4gVGhlIHUtYm9vdCBsb2cgaXM6DQo+IC4uLi4NCj4gICBNS0lN
QUdFIHUtYm9vdC5jbnQNCj4gMSswIHJlY29yZHMgaW4NCj4gMSswIHJlY29yZHMgb3V0DQo+IDMz
NzkyIGJ5dGVzICgzNCBrQiwgMzMgS2lCKSBjb3BpZWQsIDYuNTA4OGUtMDUgcywgNTE5IE1CL3MN
Cj4gNjQrMSByZWNvcmRzIGluDQo+IDY0KzEgcmVjb3JkcyBvdXQNCj4gMzI5MDkgYnl0ZXMgKDMz
IGtCLCAzMiBLaUIpIGNvcGllZCwgMC4wMDAxNDIyNzIgcywgMjMxIE1CL3MNCj4gMSswIHJlY29y
ZHMgaW4NCj4gMSswIHJlY29yZHMgb3V0DQo+IDY3Njg2NCBieXRlcyAoNjc3IGtCLCA2NjEgS2lC
KSBjb3BpZWQsIDAuMDAwNjEwMTQ0IHMsIDEuMSBHQi9zDQo+IDEzMjArMSByZWNvcmRzIGluDQo+
IDEzMjArMSByZWNvcmRzIG91dA0KPiA2NzYyNzIgYnl0ZXMgKDY3NiBrQiwgNjYwIEtpQikgY29w
aWVkLCAwLjAwMzI2NTQ2IHMsIDIwNyBNQi9zDQo+IGJ1aWxkX2NvbnRhaW5lcjogMCAwDQo+IGVy
cm9yIHdyaXRpbmcgaW1hZ2UgaGRyIDQwMA0KPiAgIE1LSU1BR0UgZmxhc2guYmluDQo+IDErMCBy
ZWNvcmRzIGluDQo+IDErMCByZWNvcmRzIG91dA0KPiAxNjQ4NjQgYnl0ZXMgKDE2NSBrQiwgMTYx
IEtpQikgY29waWVkLCAwLjAwMDE2MDE2IHMsIDEuMCBHQi9zDQo+IDMyMSsxIHJlY29yZHMgaW4N
Cj4gMzIxKzEgcmVjb3JkcyBvdXQNCj4gMTY0NjA4IGJ5dGVzICgxNjUga0IsIDE2MSBLaUIpIGNv
cGllZCwgMC4wMDA2MTIyMzEgcywgMjY5IE1CL3MNCj4gMSswIHJlY29yZHMgaW4NCj4gMSswIHJl
Y29yZHMgb3V0DQo+IDc5ODcyIGJ5dGVzICg4MCBrQiwgNzggS2lCKSBjb3BpZWQsIDcuMzA0ZS0w
NSBzLCAxLjEgR0Ivcw0KPiAxNTUrMSByZWNvcmRzIGluDQo+IDE1NSsxIHJlY29yZHMgb3V0DQo+
IDc5Nzk5IGJ5dGVzICg4MCBrQiwgNzggS2lCKSBjb3BpZWQsIDAuMDAwOTYyMzAyIHMsIDgyLjkg
TUIvcw0KPiBidWlsZF9jb250YWluZXI6IDQwMCAwDQo+IGVycm9yIHdyaXRpbmcgaW1hZ2UgaGRy
IDQwMA0KPiBhcHBlbmQgdS1ib290LmNudCBhdCAzMTYgS0INCj4gNzAyKzAgcmVjb3JkcyBpbg0K
PiA3MDIrMCByZWNvcmRzIG91dA0KPiA3MTg4NDggYnl0ZXMgKDcxOSBrQiwgNzAyIEtpQikgY29w
aWVkLCAwLjAwMTg2MDE3IHMsIDM4NiBNQi9zDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgRW5y
aWMNCg0KSGkgRW5yaWMsDQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoaXMgaXNzdWUu
IFRoaXMgcGF0Y2ggc2V0cyBkY2Rfc2tpcCBwYXNzZWQgdG8gYnVpbGRfY29udGFpbmVyKCkgdG8g
ZmFsc2UuIEZvciBpLk1YOFFYUCwgZGNkX3NraXAgc2hvdWxkIGJlIHNldCB0byB0cnVlLiBJIHdp
bGwgc2VuZCBhIHBhdGNoIHRvIGZpeCB0aGlzIGVycm9yIGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMs
DQpBbGljZSBHdW8NCg==
