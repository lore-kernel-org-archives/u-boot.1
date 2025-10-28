Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D368CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2610839C7;
	Tue, 28 Oct 2025 09:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R1eRhwo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C061383968; Tue, 28 Oct 2025 03:47:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADEC838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poe5qKuiLAugkasmPpBYTFd5yNxSaXLANJOWkAdbcsUASDwyFOyu79hX1D1pi/1j8Lte2QPR1/UsFnY/ZEwblru6qHOT4XhUia8sv/NhmuSV2jwimBB6FvSA/s76bgYmgpnQpk/enSx7Fziu97ewvpkQ18ieSo3hpY3y44+on/KKBRf9Ugstx5qERMkxrg6gCabfMh3w3uVl4UE/F3J2OpHrvcT2GU4u8kpGM6gizzDq1iCcPtnqwnOg/bZpoEoM13SlhxtHyv2/RYX81XSiZLeke6CZRtgouvyKEhvpw7VfV3YPSs+ecFjbU10g3o/1pFkX9v81Kn1+62YtSRmgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=MVJzM+endpc83q09b0fCJRPY0Iemr3e0c4tKZxMHDWEb3cfLHb7MT3HJSrMhUT5cLAEMU6NWcjhkKAWrhXqHS0O/Y4UgP3iFNjyu0Kers+E7cVG6pa6xHkLWtzkMkBgzv3A0dfw6K1QhIHALeCHvtvPJQts3ejIOsgyeIQIS5wUmR3rsVZaljvBBzi7hjBP027ud2Ga8QSzzQCJzP3kk1+rVd5Iqv+KWrpa381WhyCkLcfWUPmW6H3+G+eJS6EblTjXEg454VYB/5/G6eJCb3Q28Cg9yE+xPusN8FaDWZ1k2Rw9Rwe8LcP/Ai+a4+o9O1svyLlHVaRNrvl8KpS0ryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=R1eRhwo6nOCmnKJYQIB9Jy9e/OxyocQw0Bn4yLUO4uWUvE8vb6symO8vuOd+TL8FKqf5ISvE0jY/CLAD6JVSWuctmo2UMRk1SqLN7im/fWLTFT2qj3eCCd85YR63eSQq5sBj5edvqFM2cdUkDYWYf2LeosBb08/sRb2F95pqix2AE28VglpGt1sV04ZPF81SKVOl9OCzz6JPCK6ExUg5iqdFWqngxbB+5J9JdPSH99ZiUh+lmNzcvE7oD1s0O8T1fimXiPJZ2C+plKCfdBdN7O51Iendz8WRRRgit4CEWNdRiJ+1ig/aI00WPUS+ThlotXkfNERLaO92bIjhdW+r3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:47:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:47:31 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:22 +0800
Subject: [PATCH v4 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-1-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 671a1cae-70b1-4101-6601-08de15cc56cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEkyb3F4cUk3RGI0cFYvcURLUW9jOU1ZV21hL2pZNkdGNytHTk43WVlJMmhz?=
 =?utf-8?B?T2wyelg2bHlLUkZTK1ZWNE5hdU5mMHNVSFlidldwWTZvbXR3OSt5a0J0cFY4?=
 =?utf-8?B?R0V1VHdWTllRYUhxb2lCcTVoOGNFZisweGdCbEQ3Rno0RzZJdXFjemt5L0JQ?=
 =?utf-8?B?aDhOaHE3THV2eENtQ0R1MlloUVg1QTBxUTg4ZDZmOUFaLzUxYVhRbTMrbGNl?=
 =?utf-8?B?ekt5R0lzVzZrNi8zY1pqZ1ppZkVzZzg4akZaQjZtWlU2V3dJaEprVms0UkRE?=
 =?utf-8?B?K0VDRkJLVWFocFl5M1ZLUEdaRkhnUk5HZkl1bTJVcWRvaWhjeVVnZUxHS3pO?=
 =?utf-8?B?eHJON3d5elNVaVNJN0hxVXkwRjQ3Nk5odGhVMEFhcS8yR1ZXYmgxNnZlcnpa?=
 =?utf-8?B?RWF2V2lkWVB1cTJEaXVsT3RwN1VWak1VWE1GeVBOMUFLWEl3QytCQkFOczd6?=
 =?utf-8?B?ZlJHcGFiYVFtRDM1VmxuVm1rTmdyVUtlTzhVbVhHVlUvZTFacnFxMW9XdkZm?=
 =?utf-8?B?Tjc5UzFZQXFRS0ZWZ2k0MVZ3dkNXSm51OWlrbW5abm4wa2Ivemt0Q0ZvT1Y0?=
 =?utf-8?B?emVpSlBtRUJTd0JiakM1MHFHeEtKUnUyM3R3KzA0a2dlYkgzU3Z2QXRnSytk?=
 =?utf-8?B?ZkxCY3dtUVZOOHdiVkJzc2loUVhKWDB6VlM2b1lsd253WlZmSm5zelZVWmg4?=
 =?utf-8?B?NVBsUmd3b0tFK2F3eHlWbG9zZ2R2TUhocnF5d0dRV2JXVjEyTlNQZFg1TnlJ?=
 =?utf-8?B?NUVURUdmUUFYQ2s4M3g2R1FlWmZYaHBnWUNxY3E3K3UxS1dNbkNNRzJlSnc0?=
 =?utf-8?B?aCtzRlZWZFRTYWJZamdpQXNDS1FBdDZJODhHaXlVWU0zeFFVNTJkcUVjSUNy?=
 =?utf-8?B?bUtaa21NM2RDaVMvU1FQaXhSc0dFMUpac2VHRXdab01UQ3RLUi9laWNqZWxa?=
 =?utf-8?B?NFpaMFgwWVFXYVljZkJzaWRVN3hGVE03WXlVQkIybElUVy9hVjhGR2FzVHJQ?=
 =?utf-8?B?cDhIM2R1cUVxYlhRd3hlbm5pY2Y2TlNCcjdkVGVsM3krRHIzamFWbW1YQWhl?=
 =?utf-8?B?ZFBaN21FL3g4V3hmUTBPVE51alhMbTdWT1BMWkhpWkY4LzltdzBqYmNFeVg0?=
 =?utf-8?B?aE5NbzB6cHMxQzM4NVExazJXYi9tZ2J6Y2pad015OWJkYUUzVFoxektGNDE1?=
 =?utf-8?B?dWs1amdTU1lrSEI2V2xQNnZFSEJjMkFWVHdpalhqSHZQTjVwNGtnUm1CTFht?=
 =?utf-8?B?MnRQRkEwaXBwL1J4WVFINDd2a0xWaE1hcHRLVVE2VjYvVXVKcEkvbm12VGdT?=
 =?utf-8?B?Nnhuc0drMlRETFFYNGFkMUFCaXNRS25Ub0hjUUFacDR5YmJSSWdGWFFsWGtY?=
 =?utf-8?B?MmpkWTg5Qk8vZzRubkZ2SzZiQ20zYmlHSnJSNlBVdkRxZEl1TVBrNmRqbmJT?=
 =?utf-8?B?QUM1ZXErVU82UE5CUllhbXdkb2gxSmdwMXBPK2RmZGhNOUtHQ2JJQU1mNU15?=
 =?utf-8?B?dHZmWkUrb1Fwd2M3MnFVc1daMDRMVGJQVDlpRGNOTG01WHhTWFJYcC9tVGlK?=
 =?utf-8?B?WTUzYlNPNVBEbmlZUGpweUtWbUVCUlNsQzMvTTlSaGI1MGYwbmJ6c1lJa1ZS?=
 =?utf-8?B?K003ODE5bU9FQ0lFSy9UL21kUW14Rm1GYyt5OGQ2MUM3SjdtWThweWgyYzhE?=
 =?utf-8?B?NC9yWWVZb2llWTVCWnl4V2hrc0VHeHY2RFpraXFtYm9iNHZwNG9iamxPOFlD?=
 =?utf-8?B?enZYZGg3REh1ZkRWQlMveUVYc3dVVHZzYTBVQVBNRkhla1gybzFoUkZRdUVo?=
 =?utf-8?B?N1lweHF0OVpOc09JTVpOME1PcFh6TEVoa3hEOFd6UXE2WS9lWFdETjFSTW1z?=
 =?utf-8?B?ZGZWNStJbmh4UCtyZDhvSVIxMkJyYUI1dkRSQXpUT2pta3NiandOWjNjL1Vo?=
 =?utf-8?B?NWxjcU05ZXJxUmpOdXY2ZUttcE9oKzc4SVJjZ3BYNzRyb3R6S3gyTmhtbGtv?=
 =?utf-8?B?clkvWXkwRUpIV1UrOGJWTWQxbzExVXRkdUZCUGs0OWhaUXFYa2RxRlFySVY1?=
 =?utf-8?Q?whu4Pk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9MellzWS9TR2VST0lnKytYYXk1V1R3VXFzbE9vdFJLSzhKbmFlTExjcFFB?=
 =?utf-8?B?bVRKN1gzdnVGRURtaWlyMHNlZTFaTXFMazNmdmYzZmZQaGFNWXo4bDJCb1ZU?=
 =?utf-8?B?RWUvbXJVQTJkUWlTM3dPaEl5ckl1U3FKRXhtK0MyMlNsS2JhVnBwT3Z3QUtL?=
 =?utf-8?B?czhJRjRtMmRtMFdNbklWNStYZGVnWWdQSEdLdWZueEh2VVhDQmZJbllUVW1h?=
 =?utf-8?B?WUMrZ21PUkpUWjQza3hOSGovQjFWYmpMdUpqcHd3alMyTFpKRDErdXh5c201?=
 =?utf-8?B?cHgyNVR3SjJnakZ1NVNCRVRHbDZpaklZY01icGNMUmdZWVdDR1R4VDQzNU8y?=
 =?utf-8?B?bTRRR0doVWRGRzVucGE3ZkNmUi9ZTDJlY2MzNnFmNnd3bkIrZi9aelhUSkJ5?=
 =?utf-8?B?cXR5OG50ekpnWHpaU1ZNS1RCdUdOcVlVV21vM1VYMDdpMzZJNmlaRGJlNENI?=
 =?utf-8?B?TUsvNVRTNFZkUjFkL3JkNXp5L2FIVG9JaG9NbzFxOTBwTm1DMzNldHB1azlk?=
 =?utf-8?B?L0hWcG9WKy8vcEJaSlRZOGEzZGcrN1ZBcWFnc1QrREc4OHc5azcwekp5RXRp?=
 =?utf-8?B?M28xazVtZEE1VmFxa3NBcGJzMDVQdjZlQkZkRE9rSzJiY3AzVS8xNjVFSU1N?=
 =?utf-8?B?Ny9uV0E5Wkx6Y0pQTWtMNVI5elErQjlBSW93TTBBS04vRkZhYTFaNittZkR2?=
 =?utf-8?B?b0E5RFZsT2ZZT3hyUTFkVTRTQnlaUlQ4OWN6MHlqMFZ3RExoOWYxOVYxWkJD?=
 =?utf-8?B?RFhqaTQvTTFEQk94d1p0L21sTTVISkpPZFdqVEJZMTJmLzJocWM1bFZ2c1Uw?=
 =?utf-8?B?dEdOdTd6MmtLbEVkaC92ZGIwNW1kMy9qNjl0M1ZENEcvWTEyZ1ZxMG1CNU1B?=
 =?utf-8?B?SFZaaVkwYnV6UnhaYXFlMjhjTk9ubVFJYVZ4ei8xbmFaU2hDd2Fja0JOa0M1?=
 =?utf-8?B?Myt6dGZha1JrWTJqaUloK0M2ckFqOTRLaWwzOFlLSk1VMjlhbW92cHRCcmEy?=
 =?utf-8?B?RFdkb3BZaWdpcDNxbkpmL0swNVNVaUVmbllZcGtHUnFzNFE3SjEzREFjc0Ju?=
 =?utf-8?B?dHFjZkhvekhNQ0s4dnY1cjRSdnByYWRnbmFCbDJSeXFJMU5kdlJQT1dMRTAz?=
 =?utf-8?B?UW0vRUU3VzZoVkc5cHoxa3JiYVlpbmdObCtTaXNqWnNEdU9TSEZTM2NScGNz?=
 =?utf-8?B?WVU0YjBlekN5V1VqQTQ1NXZWVlNQcGMydHVNL09xWC9TUEdIUVo3NDE5R2Fa?=
 =?utf-8?B?cE9PczdVQjZMaDc2dWV6RDVRM21BZDRqVlV2blZSd3ZrWmZGYlFCK0VtVkFi?=
 =?utf-8?B?VEtiYVpvbGc5SEhYeTdtT1hZbUFYU3N0UTdDY2E0MEFBeXVXZmdUQzhKQ0Ex?=
 =?utf-8?B?U0xLaXkzOUwySEdpRlYyRjhnakI0TVduUU1VRmh5bXExOENva015TlBrMDhq?=
 =?utf-8?B?dnAzSk9laDZKTkR6aTFQK21oZWZaUGtraXNrU3RGbTdzcXh1YTliTTIybnJz?=
 =?utf-8?B?NkVnWFVuZVVtaG5wZUdaMFFCTit0VzZMNjhrNjQwK056TXkxWWRISmRleEtE?=
 =?utf-8?B?SFBFK01jMjZ3cW4yampBVzMyK3I1aVhDdFJXYzM0alpydGJqLzU4dWdFOFp1?=
 =?utf-8?B?enVYdktzc2o3a3dlRjNNbGszQSs0Q2cxUmhhRXlDc1dpVVJsQ1l2WUNBRTJv?=
 =?utf-8?B?SFhOS1Rwa3QrZk1HYy9BVFppdTBPV2dFR1NYTCtrTzZhVU9iSXRqWDl4RFZv?=
 =?utf-8?B?ZTd2cU9YTGloc1VuNUo0UlpLaTBocmhTTG1PRW03blJYRnVNMDRpY1NrV2dn?=
 =?utf-8?B?NTVBLzdvMHNLcnczbEdLYzZodEZZUi80bjFBS1NpOFo4YlFSMU0yMzk1eEU5?=
 =?utf-8?B?cXJZMDVXTWJPN2pBeDdpKzhueDF3YTdGbHJhandadFVFMnZWVlp1c0Erais0?=
 =?utf-8?B?TlE1azI1VW1VZWpSTENsU1I3K1EySTJpVVlnb0pNYXlqa2xtRkJEZHVjVC8y?=
 =?utf-8?B?SFJUSExOUTBVb0R1Y3R2dmVGMGx6WmhxSVlGUjYzVjdnM2pSNzNKbUZTblM2?=
 =?utf-8?B?VlVQZHBaU1JHSVBoZnI3clhRU3hCczN4UmJCN0h6T0dzRS80c3NwRGY5Snhn?=
 =?utf-8?Q?kxIesGQeu4tKd/kwjKgyfczJS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671a1cae-70b1-4101-6601-08de15cc56cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:47:30.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z88l9i8Z7Yov+SRt5t7KEiTlhivo0q953H0sN3THFZeaP78vvbUCvXrOofToq4kPGUH6nMrFgSRsVDmzrEq2rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2cf687fc4f3..427b62e934b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

