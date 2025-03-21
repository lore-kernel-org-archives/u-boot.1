Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D6DC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0156281F0B;
	Fri, 21 Mar 2025 08:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yFQXAOMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0E781ECA; Fri, 21 Mar 2025 08:17:41 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 103A981D3B
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHo+/h7wGmYigrSxMpn4T69TGXK2MDLlZhUYn6A3VOUyKW2RSEyvckmEITAmOrraZvdAQzIEXsd91NRfM9uSISTwCXHIFbGiVL5T0/sTtQI0Fx2bhNQPeJ79gAQQiwZhpD0npvvTXI7AdDqC1q+G7eR2mDPV10vy0HO34Ji/JBGZalkoPfPR/BrcTzU6oW9n/4VO24sF6GgBNuU2IMOptHzKjPkz5/ISmGQJHIk112hwbaQyPOZDFxkatYhaB5ewX6LtwDaoMfx73m7z3Bky5MXSefHD0LavozygU4drHX9tY1hSJsJtWgSBboQcX/GLd6QElwYvxjHc2Hw4yTv4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3uSIyKQ9dqslaVHNcBA8f58RoPXNbeA13a3maIJi54=;
 b=PESNbkVVgXEvNlSfY0oDAB+004coyp7Hai2NlecLfNUR2zTAG/MKud29glAor1UazqW99eb1/uqM2yut/Xzsz2Zd8GEKIVvMp/vjFRLr+Eo3o4hZ8+yG/PJwJIeiYog5ywfwDP+79UqeUjOlUqyyPi9kcpLpv4g4uouBLnWPSIrL658v0FT1anlMa6kxqeWSQKBMUc+NkPRFqd3x+eAIjWnlwP631DS2xckOr0Cw1qU68Q5mRW0KtwVGlrYfN6veM/tv50ZMuKLrrL9NsSVs+hfGbw8Z1djlWXrLqfNEzJxl/+KK9F9PL024Mqld2HoGfwpLxKntSexn2jChV4EArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3uSIyKQ9dqslaVHNcBA8f58RoPXNbeA13a3maIJi54=;
 b=yFQXAOMWNwP54zRpf9gYrp0kXdPiR1qVuFCDPhWqQkZElOBaW58qzfHkll48PJX2JWnpWwBG1w5GMAu2ZKCCcpDBugY9Ce7BS/0QAVRWukO6KyyKvlma6PB/BBoEJHoRUM/VyBQ4fHT37X2zbXezRb58Vez8jccEqpprtdGnjZ4VGDycL77hC1VjL1puase456NnCzi7QrsU5mj5nKDnjJnStqu2qjtpGJBKFWA8HisKN/56q5rpIfX85weMWWSHLbibWXV5yuu0OZq1ZYv5p4sKtt+B6vuniCWYA+hphMBjFapIJPMwYOHX/FvV+qfMtDp+SOtaBUdNkPZ2qrfA1A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:17:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:17:37 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>, "Alice Guo
 (OSS)" <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjcgMTAvMTldIGlteDk6IHNjbWk6IGFkZCBpLk1Y?=
 =?utf-8?Q?95_SoC_and_clock_related_code?=
Thread-Topic: [PATCH v7 10/19] imx9: scmi: add i.MX95 SoC and clock related
 code
Thread-Index: AQHbjdKjwMW2p0zj90qn2OqYlZFIkbNlmU4AgBetN8A=
Date: Fri, 21 Mar 2025 07:17:37 +0000
Message-ID: <PAXPR04MB9644314215ECF61DAFA6E14AE2DB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-10-286d15acbb8a@oss.nxp.com>
 <20250306064158.4d7d708b@karo-electronics.de>
In-Reply-To: <20250306064158.4d7d708b@karo-electronics.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10488:EE_
x-ms-office365-filtering-correlation-id: 87fe8a5c-1256-4850-8399-08dd6848756e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0YxbGZXN3pabzZkVnFRWjZZVmFVd25qNGFzcHZGSFo4VzdJTGxlY2tvam9j?=
 =?utf-8?B?R1RCdm5PTGV6K2M2Uk1Ha1NNaUtjZE1mRFN3TWs4RUp6SVZ1SjhYRUJCWjVr?=
 =?utf-8?B?cDByaDNXNlExSHFzckVuaE1Rck1wa2UyTjZnMWFrQmpWdUJkaE5PUXBPTmdW?=
 =?utf-8?B?ZjdTNll1dW9weG52VWVuS2lrb3FkY3JMMW56dWROWWpSMTdKM2o4NXJJbVR4?=
 =?utf-8?B?RWlkbWt5UmFqUHFyNCs3ZXNJTFArdWFrSFJua2FwMXliQXJ0c3orbFB5OXNV?=
 =?utf-8?B?WGUvb3ArWXdHWENwYzhVMVd6d3VGUEdzNWtNSUNKdUQzYlc5dGMyeUxnZFFa?=
 =?utf-8?B?NFowR1kwVjlrMkg2S2JpQlpsOEdKajIwQ2g1M2FoaUJkem5UaEdPMGJrZWsw?=
 =?utf-8?B?TkNLS3phMGFqR1k2c0FRK2crcGdGdERncVNaVzZRV1BEV2lxNTRoaUFZMFQr?=
 =?utf-8?B?SlNybm1KU3FieDFsNTk4eDQ2dHp5em9zY3NKTTRtT2FTYzZhWHAvUXgvbUs5?=
 =?utf-8?B?elZ4cUN6WFNzUkNaME9jdWMvVG56amxEZk5LaFRmUHVlNENqajRLUkhNNDZ6?=
 =?utf-8?B?U2hGV2NrUU5HNUZ5cDJCRUlTeGhqMmxSOEI0WUcyeGRWVXVBVDN3Y3dUNzE4?=
 =?utf-8?B?VnJWb3dDR2JDRVNTTkZ4Q0dUbTJLbWovNnBQVWxGSDdRNytReGxkYitGQTNY?=
 =?utf-8?B?SjQzWUVjR1h0dWtjWWJna0l5WmtsWmNVblJRT2plaTFoeDFWaDFrQlZKck1l?=
 =?utf-8?B?dlV5Q0U4RlFBUjZxWHErTjVrbzQ3OThSUEVqWVJPWVV4RGo3MHNlZGw2NmxP?=
 =?utf-8?B?ZVV0bk1XT09JNG5NbmdlRndWZXp2RDZ0N0tUdE00VlorYjNVc2JEUDZyVnNt?=
 =?utf-8?B?OUpSOG50bTgycm1LL3RHODgvd0I1Y3JSVm92M2Z3eGlQVTQvb1JqZ0tDMTdO?=
 =?utf-8?B?aUNLNmxKb1IrRHBBMEVYZXg5QUVDcCtZQXcrSXZQQ3ZLcCtja25zSlBQRzVk?=
 =?utf-8?B?VXJleGVwZGRpV3h2K0FybUFlWnorcDhzTjJYNGRKVW1VdUpwTmJwaktLK3Br?=
 =?utf-8?B?MlcraE1KVWt1Y21vSnVURjVTSW1oZXdyVnVFVUtWRGl1aUxJckdUb1RlaXdL?=
 =?utf-8?B?SExqYk5lNUtTaHFuRTB4ZXBGc2dYYzZxbktEdERzb3VEalN3eWtRdXBwK2du?=
 =?utf-8?B?Y0JUVjRsamYvWCtncHJsemVuY2lyQ2NnRW0xeDJhbFMwdCtiTGNJY0NlWmdJ?=
 =?utf-8?B?a0hDUjJRUjFmeVJrYUhISWRhQjgzb3pkNFk0azlWUEI4amhJTkpzWFVCbnNv?=
 =?utf-8?B?eW9nQmpGc3Vidm50RlZmTmxVSDNHWTJhUU95VVhadzR2Zmw5bVdjc0xYdlcz?=
 =?utf-8?B?cFVSWmR1aDNSMi9IaVFSMk40WXhYdHl0bnAwbWxrNTdZR0dKRy9sNzJyVk5h?=
 =?utf-8?B?bWhWQ0pycElRVzNlbUNOMFdGQXNmb1hIOEZyWGV4amlSSHlJMmUrV1p1dk9q?=
 =?utf-8?B?bGJENHUzd1lCaDAva0Z2RjlKa3J3cnFTRGxUaDRRbUU2K1Y4ZmZiOElOT1J6?=
 =?utf-8?B?S2puUnpTVmk4ZzhSYWtEY2ZmejBPRU5TQ1o1Mms1NlJEczFpTFd5TStJMndR?=
 =?utf-8?B?Z3dCMUxod2tnTDJTcjUrQkY1VDZSeGZncG5RVEQrL0syazJLdDlJY3hpdkZZ?=
 =?utf-8?B?eEJWRGdKUCswSTdvMVdNODNWR1pmRWNKOUFjZGI2ZUxqYVVheW12NHJwSnI0?=
 =?utf-8?B?YVBJRjVya05nclIxeGg4VXRHc0lEM3N1dlpOT1BNeHk4cS9qVDJ0SHp6OExR?=
 =?utf-8?B?dFlhVkl6ZFdYWU9HN3Nibjk4UEhvWE44L2E3QVJDM0J4TGVVKzNRYzZsVDJ6?=
 =?utf-8?B?cGVxOVN0dTVYcW9FVnR3aDlaTEV0SjlPdVV5TUpjQU9oUHpNb2t1NVhGV3FY?=
 =?utf-8?Q?VLU4m5YqHjKz5pVDk/Y5XGrBCUhQR0fH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y28xR3l5OHZ5SEZXTzM5U2U5RjBXN2o1dlJKWVlZbDZBZjlaN3dGWVBBK1VP?=
 =?utf-8?B?cWFDQitqWnlSKzduakxnMTFEWFhKb0xneWwwcmw0U21QUFhRQUN4TDN1UDB2?=
 =?utf-8?B?dVM3NjgzSkhyclZXaHBlSUpXMWdZNnpZdWRyRE5Pb3pFaEs3VkIzQ3VDZkR6?=
 =?utf-8?B?KzNzNUxBNmhnMHJ4Qk5IcG1abTZyVXlLNG80STN6SXVBRXk2QlhKbWJJRjJU?=
 =?utf-8?B?aWNOdmE2Qm5NVUZsbTh0eGNJdjg1ZUVya2I3STk4cW5rbEVTSGNRZUt0VnFS?=
 =?utf-8?B?L3Y1cUI3Q205cXZ3TTkzVG5iOGcveXhSVGs4bW13Rncyblc5Z281aXE2VElt?=
 =?utf-8?B?U25uSU42Q0FoQmZQVkh6MnkxaGd6WGM5bmlIRTdDMVlzUnJOM0VpUE9YUDZ0?=
 =?utf-8?B?SUFldW5wMEpGWnk0WWJOeXViVkJqSUtESEFsUUFxRHp1aUR6OUxoYk1oRXVm?=
 =?utf-8?B?WUIwMzNIeXNmVFNiMWo1aW9neVVPSFJPNDNnSEhjeWlpNXVyRy9UVUhYZGhs?=
 =?utf-8?B?TlBERUsvVnhtYmNLUjd3Tm5mOHNlcnVLU2xJTHMyTTArMFFhRlMwZzhaZmg4?=
 =?utf-8?B?TWk1NlhndFJ6TllBOEpteUY0VzlOWjU2NHg5WEsxTGgrdDZaOUZIZ2dqdk43?=
 =?utf-8?B?UzUreUR6M1ZHSkJubkYvNWo2ZlZCN3luWml2NSs2anExTFlzQVNlVjVJVG9O?=
 =?utf-8?B?WXFBRkdQaC9zUjJGam13RW5wMTdrdGRBY01LVnVHOWh6czlHNnl6OXBwQVhx?=
 =?utf-8?B?aTNCVVlnNlYreERheXVNSDNTU3NKNFlmUVZTOGNpeGY4M2R0K0dkYWxhV2c5?=
 =?utf-8?B?RW9xVVg2UHhmRmllcG1VMFZUZlBkaWhhREJCWHQyRGtxakYvbEx1bjlhVldV?=
 =?utf-8?B?ZHluMG42cHFQS3J6WWllY213Ui90N3YwOS9QMFFPdWNRWFltRkJLNGEySW9x?=
 =?utf-8?B?NlpiQURrZC81R2IzL01FYjVvWU41VDQwVklPZnQ4am1yTFNzb2VFdVFsL3k4?=
 =?utf-8?B?K2lERE9kcG9CUjZLK2xDQUR1eFM0Q2d2cEZrQ2tNMGd0Vm10enZmTzNiM0FG?=
 =?utf-8?B?ZkNGZEN3d1BieHRISlNaK1BibzJabFV1UHkyQnU1Y0gvQkk0NlhKcVg0dVYr?=
 =?utf-8?B?M1dyMzU5MVViZW9IVCt1NGE3RnZaRmZpZFBzYTEzWmxkaGJEbk1CdURQZ0hM?=
 =?utf-8?B?bm1PdER6STVVZUNjWkZNQWV5VEx0S3R5NW1jbEx3TldpendNaDNGSkptZk5N?=
 =?utf-8?B?Z0hITFJ3YnFzbUtYbng2bk1YSG55eHJmcng2QkJWTVRJaVd2cVphTTZhR3la?=
 =?utf-8?B?SzlOTHhidlNGNlB1YlU4TWwxekF3NHBQN25WQThGV3lUV3R2ZnB4S1o0bEtJ?=
 =?utf-8?B?Mi9lQ1dzUFZ6WVFPeENOQkVYY1B0VnIvdWthVDdwQk40YU5udXRLbGVLV3Bo?=
 =?utf-8?B?VkJ4bGUwMnR6V3ZUOGtFZ01WVlhEY0lPVTlSTHdmbkF4NzRUelVFYmx3UjdD?=
 =?utf-8?B?bktSSVpCR1lORTdBa1p3ano5dHNnb2NkVDRmd1N2NEFWZU9Ub1lkanFMSGRU?=
 =?utf-8?B?NmVDOFZCVHVRcEVKdnRSTGUwYVFobjdoVVR2bFJpRlltbmljQlBkUXY3Y1Jh?=
 =?utf-8?B?VHQrMHd5SDNoZmg4WlR5U2JSZ0xvWGhScStod0M3UGhNRmtuNXlKd3dIa01E?=
 =?utf-8?B?YUVqVkdkRHVnclY4VitpT05lbTJycWdrbW1ucUU0OFBYZ29QQjVOQWRDT1Zq?=
 =?utf-8?B?cklhTUJBK1NkcTc3MjJqYnBReGZndmdKTXJxcVVtRjVBUmJWWkZZSzN0d0ta?=
 =?utf-8?B?emxESmJxTGRkaEUrYXVyYXowQWI3bEdxdUZ6WnNvc2h0Z1FrejduWHFIZjFM?=
 =?utf-8?B?T01kdndJRFRuaTNKWCtTL3BoSTZxSjJaTk90a3JqaUpzWHhTTmluYzM3RkhE?=
 =?utf-8?B?Z2hvZGoveXlLYXA0SU0wdlpOV2ZOY2QxRElZM1kwSlpzZml4Q0RVZkxUNVVG?=
 =?utf-8?B?aG91bnJpRGlRQjZHOVo5SmtLYjQrVGlrNCswRElkQW4wMS9GWEVUekgxZXk4?=
 =?utf-8?B?enBjY1NkYW1KbGNZc3VCR28yZ3dUYzNMamJZVlpuQ2JMRCtoZ21RbTFFbmRr?=
 =?utf-8?Q?Wr1oQiekRFCT5sJLTqvFnz0pd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe8a5c-1256-4850-8399-08dd6848756e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 07:17:37.3225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nC5sQLipzqmY0u6xJIdqILxY6POkozyFh1GwMNHAiilG54IhCwslxSWMXi99jgjeTEPt6lgqNxhYCSENnx3f4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTG90aGFyIFdhw59tYW5uIDxM
V0BLQVJPLWVsZWN0cm9uaWNzLmRlPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQz5pyINuaXpSAx
Mzo0Mg0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29t
Pg0KPiDmioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBMdWthc3ogTWFqZXdz
a2kgPGx1a21hQGRlbnguZGU+Ow0KPiBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47
IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsNCj4gU3RlZmFubyBCYWJpYyA8c2JhYmlj
QGRlbnguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBkbC11Ym9v
dC1pbXggPHVib290LWlteEBueHAuY29tPjsgQWxwZXIgTmViaSBZYXNhaw0KPiA8YWxwZXJuZWJp
eWFzYWtAZ21haWwuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47DQo+IG1hcmV4
QGRlbnguZGU7IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT47IFllIExpDQo+IDx5ZS5saUBueHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjcgMTAv
MTldIGlteDk6IHNjbWk6IGFkZCBpLk1YOTUgU29DIGFuZCBjbG9jayByZWxhdGVkIGNvZGUNCj4g
DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbHdAa2Fyby1lbGVjdHJvbmljcy5k
ZS4gTGVhcm4gd2h5IHRoaXMgaXMNCj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJu
QWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgMDUg
TWFyIDIwMjUgMjE6Mjg6MjIgKzA4MDAgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+IEZyb206
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGku
TVg5NSBTb0MgYW5kIGNsb2NrIHJlbGF0ZWQgY29kZS4gQmVjYXVzZSB0aGV5IGFyZQ0KPiA+IGJh
c2VkIG9uIFNDTUksIHB1dCB0aGVtIGluIHRoZSBzY21pIHN1YmZvbGRlci4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8
YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWlteC9jcHUu
aCAgICAgICAgfCAgIDIgKw0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWlteDkvY2xv
Y2suaCAgICAgfCAgMTAgKw0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWlteDkvaW14
LXJlZ3MuaCAgfCAgIDUgKw0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWlteDkvc3lz
X3Byb3RvLmggfCAgIDEgKw0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9tYWNoLWlteC9zeXNf
cHJvdG8uaCAgfCAgMzkgKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL01ha2Vm
aWxlICAgICAgIHwgICA2ICsNCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL2Nsb2Nr
LmMgICAgICAgIHwgMTA1ICsrKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL2Ns
b2NrX3NjbWkuYyAgIHwgMTMzICsrKysrDQo+ID4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkvc2Nt
aS9zb2MuYyAgICAgICAgICB8IDc4OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBhcmNoL3NhbmRib3gvaW5jbHVkZS9hc20vc2NtaV90ZXN0LmggICAgICAgfCAgIDIgKy0N
Cj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgMTA5MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9z
Y21pL2Nsb2NrLmMNCj4gYi9hcmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkvY2xvY2suYw0KPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMC4uOWViZDM4MDk3Ng0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkv
Y2xvY2suYw0KPiA+IEBAIC0wLDAgKzEsMTA1IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNSBOWFANCj4g
PiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8YXNtL2FyY2gvY2xvY2suaD4NCj4gPiArI2lu
Y2x1ZGUgPGRtL3VjbGFzcy5oPg0KPiA+ICsjaW5jbHVkZSA8c2NtaV9hZ2VudC5oPg0KPiA+ICsj
aW5jbHVkZSAiLi4vLi4vLi4vLi4vLi4vZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9mcmVlc2NhbGUv
aW14OTUtY2xvY2suaCINCj4gPg0KPiAiSW50ZXJlc3RpbmciIGluY2x1ZGUgcGF0aC4uLg0KPiBT
aG91bGRuJ3QgdGhpcyBmaWxlIGJlIGxvY2F0ZWQgdW5kZXIgZHRzL3Vwc3RyZWFtL2luY2x1ZGUv
ZHQtYmluZGluZ3MvIGxpa2UgYWxsIHRoZQ0KPiBvdGhlciBpbXgqLWNsb2NrLmggZmlsZXM/DQo+
IFRoZW4gdGhlIGZpbGUgc2hvdWxkIGJlIHBpY2tlZCB1cCB2aWENCj4gI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2lteDk1LWNsb2NrLmg+DQoNCkhpLA0KDQppbXg5NS1jbG9jay5oIGlzIG5vdCBpbiB0
aGlzIGRpcmVjdG9yeSBkdHMvdXBzdHJlYW0vaW5jbHVkZS9kdC1iaW5kaW5ncy8uDQoNCkJlc3Qg
UmVnYXJkcywNCkFsaWNlIEd1bw0KDQoNCg==
