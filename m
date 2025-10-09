Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8137CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4104584459;
	Thu,  9 Oct 2025 14:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iNuqe27M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BF8844E4; Thu,  9 Oct 2025 12:21:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09465844D8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJljyAZ/SlVtylWwnTjnC0QJM2YpJpaMHD75eerz0n35KmDTRZr0PU6FVrS8+TcSgB+dyiroMIcJEWieAzcYfkXFQ8V3GeOy8F+CxsWqPK0SJQEfGdh8gbt1LFH69EhxATgbqn4GnYi35OwQ4abGiKoW+04rwiQ31TcCxP61eCWXeDKyzDnPhXyj3z4A+pHHLQKWcmMaFC3FYVQG7mcbbepdnv04A+cYXOI8Gl4GDslj6WQ+lF0qhfV94A5HKViUNWIFBRaUWYCMGh8gAtO9hIbNHl5a1USWvozKNQuqdjK9y4qsKCgXtJGWe4Xv7hZ5OhfLDd36TnKQTVjbzXClEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiPPGJtI/wG/4yNfeawKGblSFeNa6c6elszUcolQJC8=;
 b=dnHXh0vMHs6KPzruvbUCuOrwVPsYr2Uij+99eYEVjIcvWJFiNoKCdVD+hqAa6ff/OZvChgGw32FJioKkENhqKzQ8JAmFDIglkH4FTe5MlF+jU+ss/EAArR7ZfDUjhINgDdG+3bMrFxZb/XEy3P53de40F951iKipi+iIXWbv2TEUB+HWh2E0NnuxrG+FeLIkcQiuxgHNN11uQKCM55bCvOT5eXZ/ey8ReV2YCOiNqilP8gozB9b4r2IjXn8d3djnurEf8VmbASVnPVK4Oe5zvdofqY2jkoW3R0Q1ltsfPgnReNgob/1NsRxBvp+VDQPpEnEwN2W2S3hTmINx0GN1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiPPGJtI/wG/4yNfeawKGblSFeNa6c6elszUcolQJC8=;
 b=iNuqe27Mg9i7o5uD1TBza3vXOsgfe7d3oEBjQ/4vVMCS2V1CzBzzI2veEmnvaBlyh9ug8lja+IAgjwpEzs0cyENXfkAki3BAMsl865/KWiKeggmX1qoJHiUV6hpvIbpBPt76gn3F9qC7vfkMeeq5aIeabDyaqaX2fqvfzWMaODMxohi/YkOJQXPf7E6Zko9lVND9hx6BSidS1o+N6x5jYwt5SkXaBl9NaQ/1SKDwbAMWiSxfau1vAa/FIEl8Kg+5uI1rUHDrHyfZQozUErN+FK0H4WhRlZQKOeJt4Z/RlV5Qhvi2FBfMDkef0ugI8v0FATg+vcNKeNUzejRsCLOmdg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 10:20:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:20:59 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Troy Kisky
 <troy.kisky@boundarydevices.com>, Adrian Alonso <adrian.alonso@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0?=
 =?gb2312?B?OiBBZGQgZGVsYXkgYWZ0ZXIgc29mdHdhcmUgd3JpdGVzIERDVEwgaW4gZHdj?=
 =?gb2312?B?M19nYWRnZXRfcnVuX3N0b3AoKQ==?=
Thread-Topic: [EXT] Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after
 software writes DCTL in dwc3_gadget_run_stop()
Thread-Index: AQHcAHq7JAHAYgHUyUKTzLuOcoRaxLSqOkGAgA/Q2NA=
Date: Thu, 9 Oct 2025 10:20:59 +0000
Message-ID: <PAXPR04MB9644F7C43FF59924A2B7EB7FE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
In-Reply-To: <87a52dk5mo.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA4PR04MB7885:EE_
x-ms-office365-filtering-correlation-id: 4bfaa5d1-0651-4d8c-a43c-08de071d8a82
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|921020|7053199007|13003099007|38070700021;
x-microsoft-antispam-message-info: =?gb2312?B?c0RXVXJWdkZXNXY1UjdtNWhKemc2c0dVc1orbi8wRndEQm9RS2dkUnlIMWNR?=
 =?gb2312?B?OGIwWHA2MzRqZWt3b3RrcTRsZDVTdVpRZXRTeE42Wk1iU1FkbHlMRnpHU3lh?=
 =?gb2312?B?U0RqWHQwR0s4KzkrUG9XeXpTUUVJcGhNOWtVWUhtZGJycVZSZTRQQ1VCd3JT?=
 =?gb2312?B?QWZPYm00UkhTL3kxT0NHQWh3VVFKTUoxdjd2WTNiU2djeFhpV3VDeHcvZFRJ?=
 =?gb2312?B?Tloyd3NTK0lDTnlBVmk5eDBSckx1VURxanBzdzZ6NTdPeHNTaVNIMkUxRHA4?=
 =?gb2312?B?V1E1cUNWODdFaHdXWElpQkRVc0JuR1hwUHpuWW90Q20zTkI1YlMvTFl6T0c2?=
 =?gb2312?B?S0VGMmx2cUZPQmtjcUk1WDlXWlpRTWJROGpVdDVyek9VaCtYRitYdXAyNThS?=
 =?gb2312?B?S0Z5dkV3emwyUVJOQkUzenM2T1pnSjlhMUp3UlNveCtHcEFjOS9CR09hVXJj?=
 =?gb2312?B?VG9ZOUVyY0FuQWR4MW5Da0V2OWdMYnYwNGFwcEoxMi93NzdETGMzWm1QVndD?=
 =?gb2312?B?QnpXdVg3T3grckNNL2FlM3ZkM1p6WGdwUkVVYmR5ZFUvZ1VkRXFJck9MTFdT?=
 =?gb2312?B?ZlUrQzB6bWs1VG9QSlBHYjNVS01BbkZHcjNFUEt2aHBXUWFkT0NKNFZEWUho?=
 =?gb2312?B?dFZ3RmRIaWx6bTVxaU1vbWQ4YXgwRG9OZ3dTRTRKR09YeTMrdmZvSFNoaVJQ?=
 =?gb2312?B?cFVRTHFqQ0tWTlhUdTFMS3VIK3lISXdmVWM0VE1OemViV2VRQXBoT3RKK0F3?=
 =?gb2312?B?akR5SEZNWWIwZmR3Z2ZNODdrbXF1Rjlscms2RE5aREVleXptTmRiTkNER054?=
 =?gb2312?B?VHVER3pnUHhoRXpINlYyS2hyTzVGbjlYSE8vZnJiTEI3K0lCMEcwUWc0NFJq?=
 =?gb2312?B?cGhYMTBmZ0VkYjZhTDV0TUF3RDgrVmRPUXh1YmpBc3VFWjNpVFBFWEF3S2hM?=
 =?gb2312?B?bHo4OHk0ZElCc3ZLa0drNkhBYUE4RW9rMThSK1liQTJXQVNueHlCTEVsVnlT?=
 =?gb2312?B?RTRIWWlwQVRBbDUwMG9MZlAxdUcwclB3Q0diU3BwbnlGK3lkaHhMSk9wd3ZM?=
 =?gb2312?B?K0U1SkkvQ3lCVENCZWVhbnlwZktYbEJDRkhHc3M1QTlzVDZsUnZCcXpTbURz?=
 =?gb2312?B?bXREU1pDNDRzekh3SGVMWFNwNytkY0JYNzBqWDI1Y3QxNkNoZDBRMktEOFJh?=
 =?gb2312?B?QVFSL2dXQ3FHV1ZGYXFkV2FIUUNZK1Q0Q21xdDhILzJ5ZDVzWWt2RG5acng2?=
 =?gb2312?B?ck5xZlJJa1ZjaU4veDE2djZyTjlUQkY4WEJwVUUyYVBFckhWS0N3QSt6NFBL?=
 =?gb2312?B?SU9FYzdWL1NrbjVnaW4xb3dGdUFPZzBYdTkybjB6a2Z6NHQzMkNXZHdRSWxF?=
 =?gb2312?B?Zmw1M2lOMTVhRjlOdG1ocUZDRFc3T2s1TElHd1hhbWdhNU45Rm1nM2NHZTVR?=
 =?gb2312?B?MlRhZzBZSG43MlpTWVpwdXBSVnNyQ29lTkVWeGJoQ2VDZzFrMkQ0MEtzNUhG?=
 =?gb2312?B?NkxjbzlBODgrRXZOcy9hTnNhTjc2TUtQYzU3Q05OZG1DK2laTlp1R0s1cUYy?=
 =?gb2312?B?cVpSQXJ5SU1KRVdybUVoUlBJVkxiUmRPSVRJV3krWi9RR2pWTzNHRmJOYmlh?=
 =?gb2312?B?VTVUeEJKRXdTQWxIV2pOamFqcjBqT1d5MVZPdmpWbS8vSCtuRWtZOTl2cExw?=
 =?gb2312?B?bHdpRVNjcnJ6NTY1d09Hc2pLQVlGUDBoMGNFRHdLRmt0Wk9ET0ljSThUTGRT?=
 =?gb2312?B?bmxUQm1tdW40dTBtbnVpendqNnFhRzA3MFhiZUwrVjZUaEJtamZxQWxHblUv?=
 =?gb2312?B?RzkydHdmRTlEUitqM3hoWEwzdVpTUWs3YzFEUnRGNnhYUDM4M1JzeGNzZjNx?=
 =?gb2312?B?SHR0ZTVIRkJaOVpROEZXZ2E5eWpoRWxZMFFwdGxKT2lLa015TXk1azlmWTBW?=
 =?gb2312?B?TURxbWNqRVU3MUFERFFBYmtBbXlZOEVXTHRBbjd4RTZIUUtyRkFycVJ3UC8z?=
 =?gb2312?B?L0t4QjR4MWJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(921020)(7053199007)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eWNhTDBPSE52SFNVYktyUkg1a0xUbE1vSStONnlmYWV1VGNkSVlGWjB0MDZa?=
 =?gb2312?B?T3p1YW9oYUpCZmtaVmlpd0xXMjJtdGdTeFdBVVBRMzd1UUZFbWlycWZKVmVz?=
 =?gb2312?B?VDhkK3lFRFVzTlhKdWdqeWFjRkNuN1BweE4xeHNkYXEyb0FtRmpUSjMrVkpN?=
 =?gb2312?B?VFFYc2JrQWNDeUpMM3I0bEN5YUhpK1lVVkdtS1drNEhrZm5ZeEhtV0w1RDJY?=
 =?gb2312?B?THRZWGY5Tit1OWVzWm51akd5QlhoajBJN3VkWm1XK29BYS9yM0xZZlNwVEdI?=
 =?gb2312?B?SkZIZ2VMRXBMSmtobU1qb0JTNlFLRmtUYWRDYWpjRVBCTW5hWjRycDJLTFZ3?=
 =?gb2312?B?VW1WM3pXNnd3WjBGVUloRjA2K2dWalh4ellaVGpjcXcvb0ZBdEN6aS9RaTdB?=
 =?gb2312?B?S3kremNIeTFlOVNzVDhGUEVvZ2RZNnpHWlVBVXF1Mmp1RFEvS3FvVUJoZW9U?=
 =?gb2312?B?ekEwaGJodjNsc1p6TE4zaWxPSUdrVXFhSjB1amNEZGt5ME5YczhLQXczWlph?=
 =?gb2312?B?YWo2NGxONnk4b0ZLWjhDS3lsOUNTNDljTjJLR0hSNGZZZFFsZ2tMdkFnOXdJ?=
 =?gb2312?B?RXIwYis5emJpVjBQWHlwR1hpODEyYTgyT1ZkTWpoRzhSSU1NRHRCSWtxQXBZ?=
 =?gb2312?B?cmgxZXUwUk9XYzRWZ2Nidml1ZnV3VjJrdE9xRUVOelJkMlBVRmhWdnRyUW4z?=
 =?gb2312?B?VzdPalZib0lWbVdFQXRHaVRwd3JrNEVsaEZTZlIxUE5nMTNtdXMvaTZZWlVr?=
 =?gb2312?B?UzQ4N3AyUHB3UitrekFpWkRwUURiMTgraHB0ZkN6STFxU3YyWmpuaFp3T1RP?=
 =?gb2312?B?RzdMN1gxVnl0NUNmNkkxM2JGTlg3L2U2b01oS2cwcUp6V0EzZVk5cHNGOS9D?=
 =?gb2312?B?RHY5MjF5QUw2TXB2bHhkaXRDQjNNUE8xNG9GUjY3QzhSb2FqN0JmZ0xZaCtM?=
 =?gb2312?B?Z1NBZ25LOUgreXhpUU1ycDZ3RnMwUUFPNHBsenMxRGZtWVdJNTV2U0hlRFli?=
 =?gb2312?B?WGhDMHRFa1FDeUcxY214eHFTdnB5T0hrWG0xSFM4dVo3RlRJSm0xRUZ2a2tB?=
 =?gb2312?B?UnZCL1RKbnNkcWxjNUJYYXZZZDhudlpudmcrY3NQQVJIUU1Vd1JuN0pRMjhC?=
 =?gb2312?B?OTFvTjMyNzJ4ZGpUblJEUWI2YVp3cC81NXB3Y2hhYjRpVUp2aFpEcTdJdmZ3?=
 =?gb2312?B?V0xWblZZd1g3Uk5jWG12ZWs3SHBqUU1VU0FuSlpiejJ3cjdrSW5lNFI3clNr?=
 =?gb2312?B?Rk95a1h3ZGM4K1JnOEswR1QwU1FPbDBnd0I0V3BtU0V3Z2VkOFV6WUxWVkFR?=
 =?gb2312?B?NUw3M0UxSG5nM3dSUlFmS0hGSXh4eE9CU0ZIZVg4eXRaQWFhUDhiNzlJdHJh?=
 =?gb2312?B?OEJnVXppU0trdnk1enJnaWVLbWFrVFk3VlVxbDBrWTdUKzIrMCtQcS9HWDVl?=
 =?gb2312?B?UGl6R1ZueklySXpidy9QdDRQU0NXcVQ4Z2hmN0VDMzg3YnNBb0hmSFhtMzh2?=
 =?gb2312?B?L05yOE1UbHZwdUl2eFpvbEpseCtiTVJDVGl4QklVY0FNbkFCcjNwYUdES2Zm?=
 =?gb2312?B?WlRyNHlKQ2k2OEc0VXZNWWF1blBiZnlTU1F3UURLQ1JqeW9LZXVnUEF2TGNa?=
 =?gb2312?B?S1dYRG1lYmZ1QlJUTFdmaU9Hb1ZrTjRzOGNESzVybVcxdG8zQzkwSWJjTUZt?=
 =?gb2312?B?VWF2bHdSZm5HSnlSL2oyOFdDdkdGaWZIbm5pZW8wOXJoUWZaUnRheHpzWDdB?=
 =?gb2312?B?ellCdTRDSFU4Y1RMeC9iQWhsNFp1eXZ3V2JpWmg2T1lQc1EvZk9xU0NmTk1B?=
 =?gb2312?B?UDBsZEN1eDlubUxVUEc1TVBwMUVNNmhwNnBUdnV3b1MyWXF3QkMyOHJxVzBm?=
 =?gb2312?B?dWMxZ09uY1dCakdVSXZ6SHQweDNRckR0dlk4WVgwZWdJSnNRR211OUYwbk5t?=
 =?gb2312?B?SWtRaTdRaE1ISFpGUjJORlprNU93dkhmd0E2VTdGL0lRMnNYbXhsQndGcnds?=
 =?gb2312?B?NkNXZUpzVjl1eHZlQ1NUWi9neSswOHBiRzljZHFKK2RnQU1RZ1g1aW5BZVBS?=
 =?gb2312?B?Ukk0M3FaV0phTUxOdUtmblN2aVNXV2xnSHJtcnkrZGVyZGRiS2pjWXZUbS83?=
 =?gb2312?Q?Gwe0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfaa5d1-0651-4d8c-a43c-08de071d8a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:20:59.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JEG2VhgV5m+r9v/6EEYQZxt9mXjzCPkSyLk2NgPFA7hW5hQH2um9w91n66SfcUIglQuGku1rzK6MiPDmXSwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29y
cGVyc2hvZWtAa2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjI5yNUgMTY6NDcNCj4g
ytW8/sjLOiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFN0ZWZhbm8g
QmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVHJv
eSBLaXNreSA8dHJveS5raXNreUBib3VuZGFyeWRldmljZXMuY29tPjsgQWRyaWFuDQo+IEFsb25z
byA8YWRyaWFuLmFsb25zb0BueHAuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRl
PjsgTWF0dGlqcw0KPiBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBNYXJl
ayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
1vfM4jogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0OiBBZGQgZGVsYXkg
YWZ0ZXIgc29mdHdhcmUgd3JpdGVzDQo+IERDVEwgaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKQ0K
Pg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBta29ycGVyc2hvZWtAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhp
cw0KPiBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+IEhpIEFsaWNlLA0KPg0KPiBUaGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4NCj4NCj4gT24gU3VuLCBKdWwgMjAsIDIwMjUgYXQgMDY6MTMsICJBbGljZSBH
dW8gKE9TUykiIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPg0KPiA+IEZyb206
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBXaGVuIHVzaW5nIE5YUCBV
VVUgdG8gZG93bmxvYWQgZmxhc2guYmluIHRvIGkuTVg5NSAxOXgxOSBldmsgYm9hcmQsIGl0DQo+
ID4gd2lsbCBnZXQgc3R1Y2sgaW4gYSBsb29wIGF0IHNkcF9pbml0KCkgd2l0aG91dCB0aGlzIGNo
YW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+DQo+IEkgc2VlIHRoYXQgYSBzaW1pbGFyIGNoYW5nZSBleGlzdCBpbiB0aGUgTGludXgg
a2VybmVsOg0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3JnJTJGYWxsJTJGMjAyMjA5MDEx
OTM2MjUuODcyNy00LXF1aWNfd2NoZW5nJTQwcXVpY2luYy5jb20lMkYmZGENCj4gdGE9MDUlN0Mw
MiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0YzBh
DQo+IGQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3
MzI0MjExNTg5Mw0KPiAzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXUNCj4gTURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lU
V0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDDQo+ICU3QyZzZGF0YT04QW80dE9tY01T
S0h0b25paVZUd1A0MEp3ZzU0bHozNDJLUDBKSFVLd0E4JTNEJnJlc2Vydg0KPiBlZD0wDQo+DQo+
IFBsZWFzZSBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdjIu
DQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuLw0KPiBl
bC5vcmclMkZhbGwlMkYyMDI1MDExMC1kd2MyLWRldi12NC03LTk4N2Y0ZmQ2ZjhiMiU0MHBpZ21v
cmFsLnRlY2glMkYmDQo+IGRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0
YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0Yw0KPiAwYWQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3MzI0MjExNjINCj4gNjQxNiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQQ0KPiB1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdD
JTcNCj4gQyU3QyZzZGF0YT1NdFhxU3VlTkFaNkdmaU94ZG50JTJCSDZJVVdhYkwzSkRlMDFtOElL
SnBNeTAlM0Qmcg0KPiBlc2VydmVkPTANCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4IDJiMDExMTNkNTRjLi42YjJiMjVjN2FhNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0xNDIzLDYgKzE0MjMsNyBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsDQo+IGludCBpc19vbiwgaW50
IHN1c3BlbmQpDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0RDVEwsIHJlZyk7DQo+ID4gKyAgICAgbWRlbGF5KDIpOw0KPg0KPiBDYW4geW91
IGVsYWJvcmF0ZSBvbiB3aHkgMW1zIGlzIG5vdCBlbm91Z2g/DQo+DQpIaSBNYXR0aWpzLA0KDQpU
aGlzIHBhdGNoIEkgc3VibWl0dGVkIHdhcyBpbmRlZWQgaW5zcGlyZWQgYnkgdGhlIGNoYW5nZSB5
b3UgbWVudGlvbmVkIGluIHRoZSBMaW51eCBrZXJuZWwuIFRoZSBtZGVsYXkoMikgdmFsdWUgd2Fz
IGRldGVybWluZWQgZW1waXJpY2FsbHkgZHVyaW5nIHRlc3Rpbmcgb24gb3VyIGRldmVsb3BtZW50
IGJvYXJkLg0KDQpIb3dldmVyLCBhZnRlciBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRoZSBk
cml2ZXIsIEkgYmVsaWV2ZSB0aGUgcmVhbCByb290IGNhdXNlIGlzIHRoYXQgdGhlIFVTQjMgUEhZ
IHdhcyBub3QgcHJvcGVybHkgaW5pdGlhbGl6ZWQuIFdoZW4gRFdDMyBpcyBjb25maWd1cmVkIHRv
IERXQzNfRFNUU19TVVBFUlNQRUVEIGluIGR3YzNfZ2FkZ2V0X3N0YXJ0KCksIGVudW1lcmF0aW9u
IGZhaWxzIGJlY2F1c2UgdGhlIFBIWSBpcyBub3QgcmVhZHkgYW5kIGNhbm5vdCBjb21wbGV0ZSB0
aGUgZWxlY3RyaWNhbCBhbmQgcHJvdG9jb2wtbGV2ZWwgaGFuZHNoYWtlIHJlcXVpcmVkIGJ5IFVT
QiAzLjAuIFRoZSBkZWxheSBhY3RzIGFzIGEgd29ya2Fyb3VuZCB0byBjb21wZW5zYXRlIGZvciB0
aGUgbWlzc2luZyBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBvciB0aW1pbmcgaXNzdWVzLiBPbmNl
IHRoZSBQSFkgZHJpdmVyIChwaHktaW14OG1xLXVzYi5jKSBpcyBhZGRlZCBhbmQgcHJvcGVybHkg
aW5pdGlhbGl6ZXMgdGhlIFVTQjMgUEhZLCB0aGUgZGVsYXkgaXMgbm8gbG9uZ2VyIG5lZWRlZC4N
Cg0KVGhlIHVwZGF0ZWQgY2hhbmdlcyBhcmUgaW5jbHVkZWQgaW4gdGhlIHBhdGNoc2V0IHRpdGxl
ZCAiRW5hYmxlIFVTQiBhbmQgRU5FVEMgb24gaS5NWDk0MyBFVksiLCBzcGVjaWZpY2FsbHkgaW4g
cGF0Y2ggNiBhbmQgcGF0Y2ggNzoNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC91Ym9vdC9wYXRjaC8yMDI1MDkyMy11c2JuZXRjLXYxLTYtNTA3Y2RkYmU3MjE0QG9zcy5ueHAu
Y29tLw0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIw
MjUwOTIzLXVzYm5ldGMtdjEtNy01MDdjZGRiZTcyMTRAb3NzLm54cC5jb20vDQoNClRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrIQ0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
