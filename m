Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62EE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADD580196;
	Fri,  3 Jan 2025 07:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H/NG9+1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C182801A0; Fri,  3 Jan 2025 07:29:00 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89371800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDkcsSsL5n75HA+gxW1+9I3X/a3/amccCLyHAjwp+PmkujiU3FWWnYh2AXf+pyx1/n6xpg8Rw8jXlI+/ixc14dse93FWqIQeu00X+Lbyw6ngkm82G5RrzXFeQMYTfUppSz7j4P45/XkCIw1K7YHXhGEqpoYYnaKDTwx2IZfidancI2sHrq/EdUyaWgRnPmMm5RWCJxpOR99jVl9YQZo4f95IKx/QHEuyin8qPZDqf3no8Fuu7IMsvhobtdpH+s0Cuz5kOkUF94lhNJOhjAtCWyNpXtZodxq9UjxdIL9CzSQvy8l7w1n4eJUhbYv+O1gvpML+OmFpkTI3nT9QnS3LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlCokkYZbP9jLAFZJnUWRYPBBP4I4Mwll1dvP3BmJmg=;
 b=bwmJqZk7A7jaQGQVurj0Q3+Rxnj9OG8IlsHLpwx9rKPc1x0sbafcOTi6UcERbVYuvaCSqFwZ1XHTujUxl21mouavw1WtPRJ4ujvG6GcaVRZ1oY8qrPUe/V5TylGTEZLgVk0Ku3dkh48k9g98V2qqNOhMZcrtFJ+MNaVgrFUlwRoiiVO5co5XFeWzs5WiCHNAv9JHphnt+2XZ1Oj9FoMfmoNg/VpBfUW9dDLvUm7JqYw4io+eVtA10E9+zOKR1+TkdmwQmfSVZ8kR0HS315lEBKMT81O6We8BMaVAKgxwl1939a7C2b5iDvTMIYTdZySS1rCa8nzO1zLXE5wnnunVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlCokkYZbP9jLAFZJnUWRYPBBP4I4Mwll1dvP3BmJmg=;
 b=H/NG9+1Xco21V4QC3nDt+R3tV0Y3V87JhmSS7w05Mhwy2Oo7Il59VnnL9FD3Rj1Rqgz8U7BzlteFcCkoc4C+rKjleRGlS2p1wxSONWZGakPGfkMt1N0U/k15cs1VBBP6ljhh5UEvIX47rXpIBiN2sv2UeCqgsgNrzZek/ZhG/3ucAF/np0sCBTYu0NAvdPBIhcIt/lB7gzB7JPa0smwzIZWkxZUUpQ7+1l2DFaj3TU7Ql6lbmyrzcIASe0deH3kBwhTgAKSApGiR7Jp8p6YhYbiN1ynJYuAW7jGEC+ULR5g6MTAl2G3AnDz8UBL85yvmT3F2oGQwRfJ/vTl+fu/5lw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 06:28:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:28:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Simon Glass
 <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marex@denx.de" <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbUoq3EiCr5MsbS0ytjsh9g3+ir7L63NsAgATUM4CAAS/pAIADybUg
Date: Fri, 3 Jan 2025 06:28:51 +0000
Message-ID: <PAXPR04MB96442ED02776FE68B96003D1E2152@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
 <PAXPR04MB964402195A6BCEFE58D850BEE20A2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU16TYwegj3GkP+mLMj_cYUWgn3hkbsQF0wmS6Yb2VLn2w@mail.gmail.com>
In-Reply-To: <CAJ+vNU16TYwegj3GkP+mLMj_cYUWgn3hkbsQF0wmS6Yb2VLn2w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: 90505b74-2c93-49fb-4422-08dd2bbfe3c4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkNLeERuME9qdVpDNUdkOXFRVWlXR0JRdGxUZ1QxeER5dXZsZXEvY0doVUM4?=
 =?utf-8?B?RGxNelVtNE44OE5ueUI3TnVyTTlUaGExcmhkS3JTcUVrcG1nWDNCM1ozT09x?=
 =?utf-8?B?QUd2Y3YxZnY4bjlZSGd6b0t1TjZQM3hyNnNmcUMzeVpEVSt2aG1zN0hQbnM1?=
 =?utf-8?B?Nkkzd2lCSzVmZVJ3TlB5ZEwvZFRtUHhRaHdBQ1I5bmppb0ZEQTFqMEdvTjhG?=
 =?utf-8?B?UHR3Mk5RYXZVempvU1dLN3lHRi9GcXBZcVR4NkdNRHpzSkRjbmtGdWViYi9h?=
 =?utf-8?B?UFZMNEwrNDRKNXRTYlljQjlSdE1tUVhwT3VkYmJZV3Q0WmQ4UlVyR0IwTEh1?=
 =?utf-8?B?VUZOWVMvV0UvSUpwNEFyNnFzbTR3UXlUQXVXeDdBZXJyOUZBSGpQeDY0a3gr?=
 =?utf-8?B?WmxjbVpUM0ZXQktlU0duaHVVMmhJK0tMSlRwWmdqUkdJb0xIaFRzeUZmQ1dh?=
 =?utf-8?B?UXhwVU43d2ZtdEhXTGMzdHR6MUNwYnpSMWpQbmpqVEFxYmpDRlVpcVBXdm8y?=
 =?utf-8?B?aXZwTXlXa0IyZi9Nd1JFL3R5Q2Q5ZDAvQlFvcXFZT2V2OUF3TzJ2cU4vbkU4?=
 =?utf-8?B?dEdEL2RuR3AxOVZuR0ZZRDZ4bGdST2U3eHkxVzdsaTNpMlQxN2RSaDRsckZW?=
 =?utf-8?B?QlFrZGcvNkYyaHo2cFNlZnI0VnNVekRNMmREWjB6ai9HZUs1MnVZSDZDM01x?=
 =?utf-8?B?VHJGVjdXOXVJRWUraDFFSzRJOGRBOUtHR1lQSEQ5L0RnaS8vakFMYWdZM0Fl?=
 =?utf-8?B?eDRSRHhibW5IMmdYSm1OQnd4akhrWGpNZndCV1RkTUhZU2tVUFpIQlQ0cFJy?=
 =?utf-8?B?SDRiZ0IyQTVwN1ZZbSt1R20zV3Rzck1EbnJGaVRmQWZnQklueU12UGI1UEpu?=
 =?utf-8?B?dnZ1Ry84SDcyRTVJTnBHZ3YrckliU2ZLb2lLK3FPZ3FFNDE3VWdZYUNFdS9t?=
 =?utf-8?B?ZVJkYTBKbzVMbjhxTjIzUGxPZm1ZdDAwbU9RQTdJNnZGeXdQaHkzMnVMVnRN?=
 =?utf-8?B?TldKY24zOVJNZVF2S0hOUEtmclI2ckY5Sk5COXFGUEZmdGhSbzlJdzlNSlNa?=
 =?utf-8?B?amJpaHp1Y2tMS2F5cHRzeFcyWDRJMUhacno0Y3NSeWkxbjRjOWtOZVpCY1hm?=
 =?utf-8?B?YmNPbzFDM2pVcFhsZlFVRkFXMDZKMFJXbjFKbXlRaEw4cUMyTmtRNXh3dngx?=
 =?utf-8?B?U0VqNm1zK2RCRUp2dFBJZXdaNDEwYzVaeGZtWGJhbysyK2VEV29hRGtkNk12?=
 =?utf-8?B?bURBa2l5L0JSbVpWZVBBS3ZXWjFvcDhCQkx6YytDbDdHRXdkd0JmKy9kVlBj?=
 =?utf-8?B?b1FDTVprTG5POFU5TkVOUDNycjNoenJEbFBjRVNjM1M1SUxqOWJ3ZFdwTDVU?=
 =?utf-8?B?SzFXVkJzL0xPSGVaVEhPTXVoSk9vb2dTYThQditYdWNHUTFlQld6RGg0WDFa?=
 =?utf-8?B?cEZKV0g0aVBzWUl4bXNCc1FVeWl0WmIwd2s5VHZLajVHOGdqV0xnV29KZ2ww?=
 =?utf-8?B?cjFZdXo5YWhrSHN2S2ZhaW4vY0dranZmc05LRGtiSWpISWRqd0Z3aG8zbldw?=
 =?utf-8?B?bWdMaW9aa3N6SDRFbEprc1hHeVhKVU5WUVVEWHZ6K0FHMkJreVRMOS9YNDFo?=
 =?utf-8?B?elNOb08wU1J4aHRKR2l2bGZvWThFOXhCb1luWjVONmUxZVBFc1Bjd0xvTE9P?=
 =?utf-8?B?elBxV2VRbUQ0S0haaC81NWpwMUlzUmFmWHNRaHhvd1BDZ3RRUUZTdFk1Zm1k?=
 =?utf-8?B?MExaZzM2allCL0xsY3FrQnhwZHg4U0NHMmgyNDFJYy90SHdKNk9meDlMcmlC?=
 =?utf-8?B?cFduTXJkbGo1RCt5L2NXNmYxUGR4dkxSdjEzM1dWeVY0ZlFVd09aaHJOQkI1?=
 =?utf-8?B?RWtxZ1FydFBPbUVkejROMHdmQUlldEx4SWVadG5sclNrZTBCNEl6Ly9LWVhP?=
 =?utf-8?Q?DKIXA2FHxFCdgyHSlagD1Agm9oOlvb0y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c01NRWxlaXdjOWtQRnlNYTF2dzdUVklmWjNrbFpsQXhXNCtsYXc5WVZwb2VP?=
 =?utf-8?B?MzhVd085SS9xdjlpRTRTeXI0OFJzSmtnYkdyZWRlTlBoYmJnbURIaWRBN2dJ?=
 =?utf-8?B?bEl4dzk2bVprdlB5YzlXVDFYb01NYkYvL0U5WmhNMHlDSHVCZTFYZERzWk5q?=
 =?utf-8?B?aWFwby80L21vNHJFNWI1TmhwbXFsaWZielVVajMzbEdKdytza2NqNFg0NW1X?=
 =?utf-8?B?bVdrOFRvQS93N01ZdEJZUG9ZTXhZa3dSdGs2YXlERzcxL3k2Q2Z2VUVVYnNS?=
 =?utf-8?B?QzdzcW40UW16NG43M1JUYmt0RG5ZT09BK2N3VjdSWTFZcjk2WS9zM2t5T2Zj?=
 =?utf-8?B?ZUF3QnkzcU1NVzU5SnBvSUNBUnNVeEcxTjNZYStHQlVtRHVXanNBYUxXZXhn?=
 =?utf-8?B?TitwS3F1OGVEZmVEeXB6Q1lYczNibFZ1em94cnlvQVllaUswVmpQSFBaWitk?=
 =?utf-8?B?MCs1U3FJa09qWjNRZ1d2YW16N0FDOXBLaTBtOFkzUHVtWTQ0MVovd1ZnSGtZ?=
 =?utf-8?B?NWdUcFA2dnR5OS8vVFhNcXpINnY3SGV4dkNlWFUwWXJNemZPc1BIV0NDd0FD?=
 =?utf-8?B?SGxxb0tTSU44czVVVlpJdWpnNklSWHhwVGVpd0hBQkV5RkgySHdzb0JPWWVV?=
 =?utf-8?B?TzhYVHdoZW1Ua1VJM3AwUWRpbktqV1JrR2U4Q3VZZzNQMU5JOXI0LzQvZUVj?=
 =?utf-8?B?c3ZRMGZGM1hjV2lJcHo1cEp4dmhxR2ZDVXpKc3R4U1pBVTJkTlZkb0VhKzZa?=
 =?utf-8?B?b3A1SkRXeUtCTkJpRzZyTzRZQ215c0xkTGZxbVZDVGRKNXhxT3p3VmhDbDNF?=
 =?utf-8?B?SU1lNVVZNFZLSTVEU3pQYlBQd2g5Q0cxRTNueG4yekRGYTBWcG9RK05RWi94?=
 =?utf-8?B?TDZqQjFmZkppRUl4T25sNkkyUlIzcG5qVDlhQkRBUERvd3VqN2MwOVBWQWVP?=
 =?utf-8?B?NW1wYjV0NzA1NlNGT3FBcklGSjNkTE5RWWgwNEtQTUhxS1VWY0lEbVJzSkw2?=
 =?utf-8?B?bklGQzkxaklMbUhNOHdabDB0bDRTOTh0dTZQUjR6UUZnWFQ4YjN5a0tpU09L?=
 =?utf-8?B?Ti9kcDRtdzdLK3hYcUpRby9zV01FcEExQ2FydW5ZbHFpSlp4am1wdFhoTmts?=
 =?utf-8?B?dkhnUHFJb0FwT3BIRlZXb0E1YlJOQWFyck5LU0VvZExtaXpiYXN5RERRNEd6?=
 =?utf-8?B?NjZJdFpLOW51WTYrb1pQTjlwWm03Z01yRkp0anlTbFoyT3pEeGxrakhQY2E0?=
 =?utf-8?B?R1RTSzZZSkNoRHFjQkNtQ2cvdjVwN2RDK0tySzd4aEJTQkdXZEpETy9QRGhx?=
 =?utf-8?B?WFhtT1pRUWZuRHZ6QWdhWnlJRThUZGRmaXJwZ0thSmpVZGxiWlFYaS9hYStq?=
 =?utf-8?B?VDI5bC9VTDlkamZGNTdaa3ArbDhybXdtQ01tMU1KTEdlWm52V0E3Ym9MbndY?=
 =?utf-8?B?V3lNN1NYUW9iNTZvQlpVR2N4NmsyZC9JN0VBeXY1OVVEUWRpdGpZRjl1b1BD?=
 =?utf-8?B?cDNybEdFaDdOajBKNlE5RFlTYlFQekJUeVBSeGx3VVBLL0dxelBzaTB3QUs1?=
 =?utf-8?B?NHM1bVBUNGhFUFE5bmlmajRkMzdwTmdSS216OUw2ZnU5YWZoWjVOcXVMRE82?=
 =?utf-8?B?QzFCVTVZZjJ0bW9XdUxDLzA5Y3FTcU03K0FUYitnSysxNXlUVC8xWGlaR1Fi?=
 =?utf-8?B?Zy9PNXRycUpNb0g3clpVQUswVHJ0ZXgrNGdCZmhhTzcwOVFGdG9LWUZ1dTJk?=
 =?utf-8?B?NWt2aHdqSTZ4bmhnTE9aTjRqMVBhL2pyQmVIcEVBSEo5RXVEaHZ6R1E1MStZ?=
 =?utf-8?B?WE03VVRqQzJNUk5QZHJPc0JGclpyaktTdnhPWFo4cEZIeGdpS05ZaW82ay9V?=
 =?utf-8?B?ODFIN2Z6QkJFVGF4Rnk1SjdVaHpGMFl2ODFoeHcyOWc0ZWpOcXlyU2hMbi9Q?=
 =?utf-8?B?WldsQ1FzZUtMeEtyWGVuQmRoT3I5bzMwMjFmNG01dDY0aytCNS9WZENYdzEw?=
 =?utf-8?B?aXoyUTFPKytNQ0hBSFVGOGxuS3d5RlphNExXaTY4eEFDNzRUbGNWYXpxZldn?=
 =?utf-8?B?NjlscXhRZU8vTjJTMGRpSENLQzZ1c3E1NDVIUnluOUQ2Rm9QSWNVSFBHZHpH?=
 =?utf-8?Q?/x7YE4k9yirkPGYv2CrSOPNj0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90505b74-2c93-49fb-4422-08dd2bbfe3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 06:28:51.6262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FXPbksY8KusCoU87P2hj0PpgONtTZLic5/n75zzQHDouIerVZAgM8j8649C1zlRHB8n4WGOeHowY/iWKWMSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQx5pyIMeaXpSA0OjMyDQo+
IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBTaW1v
biBHbGFzcw0KPiA8c2pnQGNocm9taXVtLm9yZz4NCj4g5oqE6YCBOiBUb20gUmluaSA8dHJpbmlA
a29uc3Vsa28uY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbw0KPiBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAu
Y29tPjsgTHVrYXN6DQo+IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBBbmRlcnNvbiA8
c2VhbmdhMkBnbWFpbC5jb20+OyBBbHBlcg0KPiBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0Bn
bWFpbC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gbWFyZXhAZGVueC5kZTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjIg
MTYvMTddIGlteDk1X2V2azogYWRkIGkuTVg5NSAxOXgxOSBFVksgYm9hcmQNCj4gYmFzaWMgc3Vw
cG9ydA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRh
a2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdo
ZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzDQo+
IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiBNb24sIERlYyAzMCwgMjAyNCBhdCA2OjM04oCv
UE0gQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMTYvMTddIGlteDk1X2V2azogYWRk
IGkuTVg5NSAxOXgxOSBFVksgYm9hcmQNCj4gPiA+IGJhc2ljIHN1cHBvcnQNCj4gPiA+ID4NCj4g
PiA+IEkgZ2F2ZSB0aGlzIHNlcmllcyBhIGdvIG9uIHRvcCBvZiA1Y2ZiZjhjMzY0IG9yaWdpbi9u
ZXh0IG9uIGFuIEVWSyBJDQo+ID4gPiBoYXZlIGhlcmUgYW5kIEkgc2F3IG5vIHUtYm9vdCBwcm9w
ZXIgb3V0cHV0IGFmdGVyIHRoZSBBVEYuDQo+ID4gPg0KPiA+ID4gSGVyZSBpcyB3aGF0IEkgc2F3
IG9uIFVBUlQyOg0KPiA+ID4gVS1Cb290IFNQTCAyMDI1LjAxLXJjNS0wMDM5My1nOWIyOTJmN2Qz
NDdmIChEZWMgMjcgMjAyNCAtIDE2OjEyOjIwDQo+ID4gPiAtMDgwMCkgRERSTUlYIGlzIHBvd2Vy
ZWQgVVAgTm9ybWFsIEJvb3QgVHJ5aW5nIHRvIGJvb3QgZnJvbSBNTUMyDQo+ID4gPiBQcmltYXJ5
IHNldCBzZWxlY3RlZCBMb2FkIGltYWdlIGZyb20gTU1DL1NEIDB4ZGVjMDANCj4gPiA+IE5PVElD
RTogIEJMMzE6IHYyLjEwLjAgIChyZWxlYXNlKTpsZi02LjYuNTItMi4yLjANCj4gPiA+IE5PVElD
RTogIEJMMzE6IEJ1aWx0IDogMTY6MDY6MTUsIERlYyAyNyAyMDI0DQo+ID4gPg0KPiA+ID4gVS1C
b290IFNQTCAyMDI1LjAxLXJjNS0wMDM5My1nOWIyOTJmN2QzNDdmIChEZWMgMjcgMjAyNCAtIDE2
OjEyOjIwDQo+ID4gPiAtMDgwMCkgRERSTUlYIGlzIHBvd2VyZWQgVVAgTm9ybWFsIEJvb3QgVHJ5
aW5nIHRvIGJvb3QgZnJvbSBNTUMyDQo+ID4gPiBQcmltYXJ5IHNldCBzZWxlY3RlZCBMb2FkIGlt
YWdlIGZyb20gTU1DL1NEIDB4ZGVjMDANCj4gPiA+IE5PVElDRTogIEJMMzE6IHYyLjEwLjAgIChy
ZWxlYXNlKTpsZi02LjYuNTItMi4yLjANCj4gPiA+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMTY6
MDY6MTUsIERlYyAyNyAyMDI0IF5eXiBub3RoaW5nIGFmdGVyIHRoaXMNCj4gPiA+DQo+ID4gPiBB
bnkgdGhvdWdodHMgb24gd2hhdCBpcyB3cm9uZyBoZXJlPw0KPiA+ID4NCj4gPiA+IEJlc3QgUmVn
YXJkcywNCj4gPiA+DQo+ID4gPiBUaW0NCj4gPg0KPiA+IEhpIFRpbSwNCj4gPg0KPiA+IEkgdHJp
ZWQgaXQgb24gbXkgTVg5NSBhbmQgaXQgd29ya3Mgd2VsbCwgc28gSSBub3Qgc3VyZSB3aGF0IGNh
dXNlcyB0aGlzIGlzc3VlIG9uDQo+IHlvdXIgRVZLLg0KPiA+DQo+IA0KPiBIaSBBbGljZSwNCj4g
DQo+IEkgZGlzY292ZXJlZCB3aGF0IGhhcHBlbmVkLiBUaGUgZmlyc3QgbWFrZSBmb3IgdWJvb3Qg
cmVzdWx0ZWQgaW4gYSBiaW5tYW4NCj4gd2FybmluZyAod2hpY2ggc2hvdWxkIGJlIGEgZmFpbHVy
ZSBidXQgaXMgbm90IGZvciBzb21lIHJlYXNvbikgYW5kIHJlc3VsdHMgaW4gYW4NCj4gaW1hZ2Ug
dGhhdCBkb2Vzbid0IGNvbnRhaW4gdWJvb3QgcHJvcGVyOg0KPiBXQVJOSU5HICcuL3UtYm9vdC5i
aW4nIG5vdCBmb3VuZCwgcmVzdWx0aW5nIGJpbmFyeSBtYXkgYmUgbm90LWZ1bmN0aW9uYWwNCj4g
DQo+IFNpbW9uLCBkbyB5b3Uga25vdyB3aHkgdGhpcyB3YXJuaW5nIGRvZXNuJ3QgcmVzdWx0IGlu
IGEgbWFrZSBmYWlsdXJlPw0KPiANCj4gRG9pbmcgYSBzZWNvbmQgbWFrZSB3b3Jrcywgc28gSSB0
aGluayB0aGVyZSBpcyBsaWtlbHkgYSBiaW5tYW4gZGVwZW5kZW5jeSBpc3N1ZQ0KPiBnb2luZyBv
biBoZXJlLiBZb3UgY2FuIHJlLWNyZWF0ZSB0aGUgaXNzdWUgd2l0aCBhIGRpc3RjbGVhbiBhcyBz
aG93biBoZXJlOg0KPiANCj4gICBDT1BZICAgIHNwbC91LWJvb3Qtc3BsLmJpbg0KPiAgIFNZTSAg
ICAgc3BsL3UtYm9vdC1zcGwuc3ltDQo+ICAgQ0hFQ0sgICAgc3BsL3UtYm9vdC1zcGwuY2Znb3V0
DQo+ICAgQ0hFQ0sgICAgdS1ib290LWNvbnRhaW5lci5jZmdvdXQNCj4gV0FSTklORyAnLi91LWJv
b3QuYmluJyBub3QgZm91bmQsIHJlc3VsdGluZyBiaW5hcnkgbWF5IGJlIG5vdC1mdW5jdGlvbmFs
DQo+ICAgT0JKQ09QWSB1LWJvb3Quc3JlYw0KPiAgIE9CSkNPUFkgdS1ib290LW5vZHRiLmJpbg0K
PiAgIFJFTE9DICAgdS1ib290LW5vZHRiLmJpbg0KPiAgIENBVCAgICAgdS1ib290LWR0Yi5iaW4N
Cj4gICBDT1BZICAgIHUtYm9vdC5iaW4NCj4gICBTWU0gICAgIHUtYm9vdC5zeW0NCj4gICBNS0lN
QUdFIHUtYm9vdC5pbWcNCj4gICBDT1BZICAgIHUtYm9vdC5kdGINCj4gICBNS0lNQUdFIHUtYm9v
dC1kdGIuaW1nDQo+ICAgTERTICAgICB1LWJvb3QtZWxmLmxkcw0KPiAgIExEICAgICAgdS1ib290
LmVsZg0KPiAgIEJJTk1BTiAgLmJpbm1hbl9zdGFtcA0KPiAgIE9GQ0hLICAgLmNvbmZpZw0KPiAt
cnctci0tci0tIDEgdGhhcnZleSBUaW0gSGFydmV5IDkyMjYyNCBEZWMgMzEgMTE6MDggaW14LWJv
b3QtaW14OTUuYmluIF5eXg0KPiBpbWFnZSB0b28gc21hbGwuLi4gbWlzc2luZyB1LWJvb3QuYmlu
DQo+IA0KPiAkIG1ha2UgJiYgbHMgLWwgaW14LWJvb3QtaW14OTUuYmluDQo+ICAgVVBEICAgICBp
bmNsdWRlL2dlbmVyYXRlZC90aW1lc3RhbXBfYXV0b2dlbmVyYXRlZC5oDQo+ICAgQ0MgICAgICBj
b21tb24vdmVyc2lvbi5vDQo+ICAgQVIgICAgICBjb21tb24vYnVpbHQtaW4ubw0KPiAgIExEICAg
ICAgdS1ib290DQo+ICAgT0JKQ09QWSB1LWJvb3Quc3JlYw0KPiAgIE9CSkNPUFkgdS1ib290LW5v
ZHRiLmJpbg0KPiAgIFJFTE9DICAgdS1ib290LW5vZHRiLmJpbg0KPiAgIENBVCAgICAgdS1ib290
LWR0Yi5iaW4NCj4gICBDT1BZICAgIHUtYm9vdC5iaW4NCj4gICBTWU0gICAgIHUtYm9vdC5zeW0N
Cj4gICBDQyAgICAgIHNwbC9jb21tb24vc3BsL3NwbC5vDQo+ICAgQVIgICAgICBzcGwvY29tbW9u
L3NwbC9idWlsdC1pbi5vDQo+ICAgTEQgICAgICBzcGwvdS1ib290LXNwbA0KPiAgIE9CSkNPUFkg
c3BsL3UtYm9vdC1zcGwtbm9kdGIuYmluDQo+ICAgQ0FUICAgICBzcGwvdS1ib290LXNwbC1kdGIu
YmluDQo+ICAgQ09QWSAgICBzcGwvdS1ib290LXNwbC5iaW4NCj4gICBTWU0gICAgIHNwbC91LWJv
b3Qtc3BsLnN5bQ0KPiAgIE1LSU1BR0UgdS1ib290LmltZw0KPiAgIE1LSU1BR0UgdS1ib290LWR0
Yi5pbWcNCj4gICBMRCAgICAgIHUtYm9vdC5lbGYNCj4gICBDSEVDSyAgICB1LWJvb3QtY29udGFp
bmVyLmNmZ291dA0KPiAgIEJJTk1BTiAgLmJpbm1hbl9zdGFtcA0KPiAgIE9GQ0hLICAgLmNvbmZp
Zw0KPiAtcnctci0tci0tIDEgdGhhcnZleSBUaW0gSGFydmV5IDE3MDkwNTYgRGVjIDMxIDExOjEw
IGlteC1ib290LWlteDk1LmJpbiBeXl4NCj4gbm93IHdlIGhhdmUgYSBwcm9wZXIgaW1hZ2UNCj4g
DQo+IEJlc3QgUmVnYXJkcywNCj4gDQo+IFRpbQ0KDQpIaSBUaW0sDQoNCldoZW4gdXNpbmcgIm1h
a2UgZGlzdGNsZWFuOyBtYWtlIGlteDk1XzE5eDE5X2V2a19kZWZjb25maWc7IG1ha2UiLCBpbXg5
X2ltYWdlLnNoIHdpbGwgZGVsZXRlIHRoZSBsaW5lICJJTUFHRSBBNTUgdS1ib290LmJpbiBDT05G
SUdfVEVYVF9CQVNFIiBpbiBjb250YWluZXIuY2ZnIGZvciBpLk1YOTUuIEkgY29ycmVjdCBpdCBp
biB2MyBhbmQgd2lsbCBzZW5kIGl0IGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8N
Cg0KDQo=
