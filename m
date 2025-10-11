Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01BCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED2683A9F;
	Sat, 11 Oct 2025 20:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gx3LeBL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A36283CF7; Sat, 11 Oct 2025 11:08:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BA683C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E81rmxGGkFxkbDGjuD8iy4BDGQz8/l+18m07XOfynG5m7cYOmGe18eTqYX9bLrlEhfs51UGaJBsK/lpYNw93PUMpU2dxKRM8eEhcpt0h/JLLPht2QP/DBcXCebJ6DfZWJLC1Pgy9ETn3DIoA3gwnrDbhvahDlbps0rIyqeh9cKRBlh606MJ+hi7tsh8WoWl4TwmtOpRUT5l/D6ZtqtmFEwPTJ+Y7ek839af/rv/ZRw2spda7nWzSLAhZH9d7pE+ON26jl7r2ubg5xsPS+gmRIe1tvWwBrywVfZamBrnxsVtSIT2fzKZ1VkTlQdKUx5nAA1dlYloPETGZ+nB9NLg2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyFaPl/TeZZeKDY+i+wA8fm7bvOWetxrEeXa7KLJ7oY=;
 b=M50kOvnlPOlpGVfmF/O/3KiEW/Aimcc7hEHOD0BLLLu7ZaGeo5DsBUdHeP1SLWB3TzscmrB9hkApAhKPTvzKK0RI6l2eSli+iXlJ8LRbSNKrHUYpPl30A/HB5np/yItHWGjew6WysrkNbsn/h5+E4JEEzzGAa7kPslVxnmH4NQy9fyE3TNzCIcLLz0Wf29ClS0QrDEDeMI7TjQbNQVXXe7zBdlyV3bzDbL8n2EDoDqY5SkT5jdmQi8/gTUA3aUAMWolru9A33A+PlXzczslGxjBv1k5AC5CG1tg1MwqkyBth07SfIdVajtAmBJYVfL8L1N+Ld6lcU89ECQ42jDJjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyFaPl/TeZZeKDY+i+wA8fm7bvOWetxrEeXa7KLJ7oY=;
 b=gx3LeBL5RdsNQ/FsP/fklbP5C/4l7+ADsmdsH/HhyITLyE7X5FO1OvmNH5H1Ky6aIUJIG4JyccLY8GJUdmy/bRHiSW5SDzItBXcJ2Nj6QHnh2m8+JzXiX1las5w/GdZPejcLpRR6WSMegpZ+TUSxBmuJqSvYWcWPZQrK4BamlHp6vVL5F6HA2LJQAJALQ93uPLmmEi+zfu0Dj7IpzxJnT5t8ci4QAxu9Yc2fzfJp6INQRItD0GvWGckYpqdhdAnboXHPD0dmTT8BxJ/L0WgH+HbaAVDElQNjqlll2ebH+Ycxb+TI9GBG0k9o3zYaMNKUMXONpht6JAI5tLJmAcRpow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:08:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:08:45 +0000
From: Alice Guo <alice.guo@nxp.com>
Date: Sat, 11 Oct 2025 17:07:50 +0800
Subject: [PATCH v2 03/10] imx943_evk: Enable USB 2.0 controller host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-3-313444548ab3@oss.nxp.com>
References: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 45403772-f138-4b09-fd3c-08de08a5c84f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFCdkFXcStIUHVrRi9XNHNwV09TSVMreDkzdncyYWdDcjFldlIxdXJEeFh3?=
 =?utf-8?B?TmI0aGhjVUt0QVlDdHF4S3JkckNYYlg0WHZKMzVqUEJHWUZRbHhySmtNV0ha?=
 =?utf-8?B?bnNlZGhvck1pK0pRM3UrNUw5emJVYktsdU9ScTFyN25JYmdxSDc0d3BoM2Zr?=
 =?utf-8?B?cE9ubTFwcEhLZS94blJXZGJLTFpWVzllaS9VK2p1eU1ENmtSOGlMeUtPbWVS?=
 =?utf-8?B?dVQyMk42V3FGcDhBZ0VCNGsvNGtmUzkvczIxSzVBZ0RSemIzQmYzcXlxeUhZ?=
 =?utf-8?B?Z2NVeGhSQVZDd05jeEV0ZWdXWnhkaEtmejZtL1NMbGNIMllnL29FZmFvUC8y?=
 =?utf-8?B?VVBiY0RwWUlIOTZ4Um9qU0VEVG4yMXZtQ1ZiMXlGMU9RdmFYS25WT2kxVUhW?=
 =?utf-8?B?Sm1FSkZHclRpZ1VQZlVFN3UwUUROU3RkU3VpdHR1cTZyVnZiTzltdHZyY3Nj?=
 =?utf-8?B?SjExZEtMWForSkQ2TktSQ0lLL1QrS29seGk4RnlCblR0NHVzM3p6WDFQaU1C?=
 =?utf-8?B?UDV4UHpSendCcVUyWUtBK2R3RklyeUoraHNpOE5mWGtGaE5JbDVQNm1KaTZG?=
 =?utf-8?B?UVBtKzROS3BDUVpSMEpwNEw5M3J5dkI3c3Y2M0lGbE13RmhZTjVueTFCV1dQ?=
 =?utf-8?B?bzNzQnozdHBEMXhpeTZpM0dYMFhEemJUVmZjK2lwMEp4VER2a0xUWkIwK0Nm?=
 =?utf-8?B?enJPZUN6UVluUllWOElNYVI3blQ2cVhIOEd2eWJsSUIrdnVzb3FHaXh4ODcz?=
 =?utf-8?B?aHF5RW9HdUNxcDVMc0JjMURMZGNkMXNJNk04bzljNEpBc3E5dXRKQzVzdXZo?=
 =?utf-8?B?YjcyTkttcERMakdzcUhsMUtkTEFQVERxODJjT0ZsZDVFUlp1bGRtcTB5dEVG?=
 =?utf-8?B?WThneEpITjBEVHZJcjYyaGJIb3RaampCekdnMG5MZklnZTUvdFNua2p1OUlR?=
 =?utf-8?B?YS9id0VMbFVEWURKRmRueXBHbTJ6U0NQa3IzN2NKSzd5VFNXb3IyM0Z3Y01z?=
 =?utf-8?B?aEJOSW8rS3hVMXJWZGhFVE1UM01nb014LzYySHVtaHpyaWptTFR1dlBXZW15?=
 =?utf-8?B?LzF0ZWQ2aUtWK3A5b2RYVDNLV1AwaGxJM1FtVkNSbG5Bai9vMjVZVDhEZG9F?=
 =?utf-8?B?eVB4MlRIejFFbDFIVDVVczFjd3pwWjUwR1pHaWY5Z0cvbmhLYi9UWGdveXZQ?=
 =?utf-8?B?c3I4MWN5WXR1SXVUYUJJOGFEZ3JCTHRka1R5Nnh1S240dEJVV2p1by8wSFJP?=
 =?utf-8?B?Y3BRYUhRZVNmRUFrck5VR2oyOHZJeFcyMDdrcHh0dFZ5SHJHMEZRK2RRcW9q?=
 =?utf-8?B?dnJHMWs3V0RFVGN5c3BaUWlmaTQzOTJOUzhqcVVERU1hNWpEK1BIaVh6QUJN?=
 =?utf-8?B?UDVmakdvV3BnRlh1aWRiYUFkYmhrRTZQTVRTcmY3clBkQXAvbWZhS3FzZUk3?=
 =?utf-8?B?cm5PVXl4K21RWDU4QnB5a3FYODJ2eGlDc3VUTWtVaTZGTGtBT0plWThBRFQz?=
 =?utf-8?B?UmwzTjNmRm5kZ3NOQ3l3RHlyZUcxTklucFpUZUl6Z1BLTjVURTFSemZFd2k1?=
 =?utf-8?B?RUdXb3VQR0pKOUFmY0xGUVI4MmhaZURJQWQ0ZzhxbDlMWFdWWWI1eWV1M1ND?=
 =?utf-8?B?TmE5OHlQOW5ZVU1BcHc1eUpocXF6RUx1T0QzUlZmUDZsazNHbENwQSsxM3RN?=
 =?utf-8?B?NklMRWtSbHVGTnBOMEt3RHNJcFhOK25DVHYzUG41Qm4rL1hvdnRkR202UG1X?=
 =?utf-8?B?dXdYeXRnL2dVTlZ6MXVpUUdwVXNLQUJSYithY2hxNFdlSHJIbTJyMkNHOHRH?=
 =?utf-8?B?RXhFOEtHOHpSR2R6dUJDSGVhdjh1ZURydjhmUU9hemdNcFNmd2FtR2FwS1pr?=
 =?utf-8?B?aHh6UVU4TWNVdzUyYUJiN3pocjhKOTZ5OHR4TVB4VjNrZ0NWNGt0TXdRQ29P?=
 =?utf-8?B?NzBuQjhEQ1NXVWQyQjhiaTYvcWo4ZWVBRE9xNjd3bGNrcXJkZHB0VUxBc08v?=
 =?utf-8?B?V1lyaERackV0UmExdHc2eXVVR3BqUytaTytFTFFaZCtzQXRBQWU0M2UvTVhN?=
 =?utf-8?Q?RnfuFv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdMNmN2dGRZNzhjUmRZT0xuTExXWXA1blQrWXc4bDlmTEhFUFQ4SFp0STVM?=
 =?utf-8?B?NFNUdXF5UWhDYkJrOWdheGpFa2ZTZ2ozVUlYV2lXaVg0VWJrZnJQNkxkMWFo?=
 =?utf-8?B?RTRSV01HOE53ak1LUGlibHU0R0x0aVZESnIwZ1ExRm4wR1ZDd1NMeVBCNkx1?=
 =?utf-8?B?ek8vTDJwMnpuVC9wbTdURVZCTUtMS25Ed2xYU3p3UjdCVkV1aWlJVkVmSWkv?=
 =?utf-8?B?M1pZSXVXOWR5NDR0Y09PSkZ5dVFuN2l6aUVQLzQ5Vm5wTm1WM09zM01UVXlC?=
 =?utf-8?B?VmJCbFBOYWxRaE1nL1Y0SVA5bGx3VE1iZHZwVWI3R3d2YWtkcFdrOXljclVH?=
 =?utf-8?B?NUhZNFRNZ3lzUDlKeFVRcithaGpyUmh4QVJnYlZPQ0RMNXVqK2g1cURjblhL?=
 =?utf-8?B?R01FL1BlRUIveFVacm5JRXRud1lOaVAxdytkOXdKTUgrMHlLb1cyMHdvbjFW?=
 =?utf-8?B?UnhlaUpFNytQOHFTdXNobXdUUDlTbyt1eWFiR3Z2T0lFRmFNdVVMbjhOSWZT?=
 =?utf-8?B?c0RCMDdVYlZQOEtJWDJqMmIydkorYnZLN0tyMnZtUHpvalErUTFETXdrSnhh?=
 =?utf-8?B?N21RU2RGTjF5TkxWaktLZWlxS3J3THU2TnlKQXUwYWVPaVRxTVhqdVZtcWJL?=
 =?utf-8?B?UzJrb2dSNldvZDVwU2VWUHNNVzJ0ZDFiWFFNTC8rdG1LMitjUEh2eGJLQU5U?=
 =?utf-8?B?emcyTkVuc3hNMXVHMU5IY2V6MXM0MllvcnhtdlVWbHJia29zYkszOWIxQWIy?=
 =?utf-8?B?YVhjQTA4VVVrMHRJcXVwM1orLzhZQnhwcnc2U0VHK08xQnhzRm1ZMVNHTm16?=
 =?utf-8?B?QlNFQXpYUytqTVdtejJyb0xNQmMrRVZOWGYyaUY4UHNweDJuUGdRQTZiSjZE?=
 =?utf-8?B?U09idG0ycGtGMEVWWEozWTkveGtiM29YdnVEY21QRjBydUJtbjRMQ3ZKTGUr?=
 =?utf-8?B?OGNIdnpCSHAxZEZ4TkYrcHoyeHY1M2tVanVRcjJrUUt1ckpDZisvL2Zqc2pt?=
 =?utf-8?B?eUJnRHNlT1RGMHF3akZQR25WV1RZbTVWQkVzYVhBUmdRM1VoMXppNzRpRmJC?=
 =?utf-8?B?UjNVZGp3amUzemdORGlSM3IyOTdsNE5laWxCZGsyZXRaNE9zQ0lPb3lKZnM5?=
 =?utf-8?B?VXVZaVZETlBDRUJjNFNrN215TEg5QS82L2hneFhTNHdIdkluNFFSY3FxLzVY?=
 =?utf-8?B?ZGY2dFRja00yaXJuZDBsdUJnK0laVFRKNjZqak4vOUdzVVcyZ2hVK25INWs0?=
 =?utf-8?B?dFUrM0x4V1NjNHhYQUxtRHN4MVdtd2wzVUd5dCt1WWtSQUZOUnNUdVZWc0Np?=
 =?utf-8?B?djRrTVk4ODFLd1huTWlmRGoxd29NOEVHMHhrZkNBMGUyUW45V1RiSVNWbnNT?=
 =?utf-8?B?WEVxdGFjK1h6bUMyVXNqR2d1YlVqeUlYdndvWnpqck5RbnhzWTk1S1A2TzVK?=
 =?utf-8?B?TkQvWnBTWlBKdVJrVE1wR2p4bTBRRnpJRG9RWUllM2xFQm1mWUNZalY3UGlJ?=
 =?utf-8?B?WS9zY0s5MjN1OG5QMlFQeXJtTklrOU1kV0M4dVMvOGhmSkJaYmdLVHhWUFFB?=
 =?utf-8?B?cStmNUM5dVYxenpxM3d5cGJtVm5ua0NlVDFmNTRsYnU3OTlSWkJLdmkvS2dD?=
 =?utf-8?B?SUR4UU9LQThXWXY4eWk4RnJ4RDJlbzNkakJIQ2dNRVBqWHpOWjEzMm43V1hM?=
 =?utf-8?B?dnRrZHNIQk05aDhwR2xyb3BhSEdoZ1BIU0xPNTZ5OFdpbXVQaU9lVDhwQkt2?=
 =?utf-8?B?RlBlTjFremJlTW94RXdaSjRGUWVraTV2Z2hpUFNJODUya2t5Ky80cndvQStu?=
 =?utf-8?B?N1pXN0hMYWo0aXI0N0RsenZSUU1obkcrR0tONXFXQ0pTZjFoV2hBeCtGRUZB?=
 =?utf-8?B?aVJ0YmFwWkw5K2k0S2JIR2s5NGdlejBLakZPWFR2cElZQ28rMUxaZTlhNlJq?=
 =?utf-8?B?SXVlOVY2akhyYUpBejhnNnNGQ2dwdW93dDFJUk9zZ2pXa1RVWWZiQ3p0a1Jt?=
 =?utf-8?B?NkN3WWgrbFB3RlFvWWZ1eS9Vbi82QnVwdS9vQTBqblZvOTNTakRGM1JEeVBn?=
 =?utf-8?B?K0pvSlpMQ3NDYWhuMzdFVXhKQjNzR01DWHcyYlV2b0hQYTdEcUIzaVhHOEU3?=
 =?utf-8?Q?E829msuk8aMGrYqFDhcis+VNM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45403772-f138-4b09-fd3c-08de08a5c84f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:08:45.8697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMFpw7JWYBrOh2/fRJnGyA8yeDD4rE+MnUAw5rLh0GhmPp+4Xs63f7IooMIVXKN17wGe//LetIo23Y0KCJcuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

This patch enables the USB 2.0 controller to operate in host mode on the
i.MX943 EVK board. It updates the device tree files to configure the USB
2.0 controller appropriately and modifies the defconfig to include
necessary support.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 28 ++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 5496385dc4d..e6abe7ed2e0 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -13,6 +13,15 @@
 	bootph-pre-ram;
 };
 
+&usb2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9c4882f7d79..9b2c1072366 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 	};
+
+	usbphynop: usbphynop {
+		compatible = "usb-nop-xceiv";
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+	};
 };
 
 &cpu0 {
@@ -192,6 +199,27 @@
 &{/soc} {
 	bootph-all;
 
+	usb2: usb@4c200000 {
+		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x0 0x4c200000 0x0 0x200>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "usb_ctrl_root", "usb_wakeup";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		phys = <&usbphynop>;
+		fsl,usbmisc = <&usbmisc 0>;
+		status = "disabled";
+	};
+
+	usbmisc: usbmisc@4c200200 {
+		compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x4c200200 0x0 0x200>,
+		      <0x0 0x4c010014 0x0 0x04>;
+		#index-cells = <1>;
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 27230ed3207..d308d29a1a5 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -112,4 +113,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

