Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B303BE83F1F
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D4F83B1E;
	Thu,  5 Feb 2026 16:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SQiPJhHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03D183B1E; Thu,  5 Feb 2026 16:15:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B153F8341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MosAxLxOVAkZ+gBChEPyAAQtZ3CUbGoibJc0oRTmob4fezVVbTdSyhxM33cwi3+aGJcsw3TJOipoKG5RZUENZZoGmTNEdi39g9Tslat77oYwG0fopMiz52BCrpwTUXUlyjrv+PCZgRoAC/R8bXSNHXfVa++klPKG1o7Uz55YURyEfHCvzlNLsiJbZ5r9YH3Avx48oblFPTUO+E0BMoYMzBMeZHPqOcJkJstnFLywOZNUFGTzkaAi3vK0QqRCFFD4FS7mrY8pJWOAuzfLC2PxG/82Z4XyLBq+xZyH4YkB/o/hvoCaZjp84FGGhGJygO5NoRk1AyHFG2SW/C3eub+HtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPYSUiMJKgUWVwz6sArFjJzp/M0PGT/47xLY7pkwdsM=;
 b=ZvViZaOvEyxUIXkBFqbhxlVO2fkv9iRie07OT+Y65zKe61qWww26GicUCk5bw+YWZf+i2AotqMOamZpH5kDyzR/b0ZC+UPwnKQwDvBOUFfxrCom62pf396IIG9V3kxo6Qit3pZvjo4ektj2bvfVgdE3piqpjBQtKPf8vliXTn5EOXd4DdclARen4li99SX3/fVjmTwoKeGUh5Imi9Ta4xdq4wp/0MwHE1T2AZkT4yX6MSwh92gr7BGH1H5ZgMG+Rzb577FQQUgS2pEDJ/DUVdYCH3N6jrGxGkcCoX9J93mW030uAT3PcIFNEg5lL+zJ8dyXll/UatczmhBEJXrPw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPYSUiMJKgUWVwz6sArFjJzp/M0PGT/47xLY7pkwdsM=;
 b=SQiPJhHRsDVbRx//TEbLI6GwgypT6nn00Ml+JGnlxRgQyLIgXJs3McEo5VrkzrznvVlxyC24SuUYmtR6VozZvtmpIWg2zoBb9H5VT4u+V95GZR2WORS7ttA0QQMvUVCbVqL8emtVn3DTWItdLqKOJNGVC9NNQpiz4G3bcpNt2RURNlrr+X2eBLt0qShCDXfQ//gezNmw9ZDVaUDz+w1UwIh/tHBoy18l+4WtEQvzZoBfkSpJdbuerEE8t7fltP0FytiDkQfxQ3STpCqG3Fmm4hBiFvHv0slk9glwg8VkUC9zEmYvjdfvZkpJPMTwinFZIaJwwiJl2NbuTmjiMXMsdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:19 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:08 +0800
Subject: [PATCH v1 02/12] imx95/imx94: Remove board_phys_sdram_size from
 each board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-2-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5142c074-d79c-4223-90f4-08de64c95fd7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T01ySGJKRHJ1aWtzTmlLZnhLNVlFZzRNclU3OHBSdDhIODZKMFBscGRXMThs?=
 =?utf-8?B?L0xEUEFWbC9LbkY5MVMxT0krSDRpL2JMSW85M0RYZjJKV0NFV05ZN2hsdVAv?=
 =?utf-8?B?UEdXWnhMOElqaW5wVHFGbDBDZ0sxbDdzZFFGWDB4UGpEeTNBZlJjOFozODZt?=
 =?utf-8?B?QTBzTVN2clk5bzBuSGw3UCt4UXpkV0dmVFc3dVVxOGZ6RStJSkxiNnMydkxr?=
 =?utf-8?B?cXJPYmt0eWZoaCtIZUhqakljRzUyaFUybWkvZFU4YUV1dGplTzFvZFdnTFRB?=
 =?utf-8?B?V0phNjZWbzloMkVoUlZoOW1rdURLdzdzWHRHY0NVTWRKbWtoYkNZbjRzY0VD?=
 =?utf-8?B?dEpmTlhkU0Iwdk5FNDdYY09IYWxZL0lyVzR3YWwrVUJBaDBYVWNXbERYbTNa?=
 =?utf-8?B?UDVXRkxsMit3WmhhTStEdk5vb2xYcFlJb0lJWk1ObGN3VHhjaFVGdFF1eDJW?=
 =?utf-8?B?MTUyR0poZ1Z2TVFxT2U3RDI0K1AwZ3k0UGpuenlUSlkxa1dKWXVmNEZ4SUpY?=
 =?utf-8?B?U09vdko3VWpVb01tL0pNZmxoZGtzV3BtMzNDZEJoOUNCVWVwVHBVVkhRSk9Z?=
 =?utf-8?B?d0VMUUltS1RYZkZJRUNLdERYeVRoY1pjdXllOEVjcld6Rm4yKzJSM0FkMHZt?=
 =?utf-8?B?T2NyQ0NCaXZJampJNk03bG51Z1prZVZ5NVhLSHYzNlIvV2NrV2tlN0IvSTA2?=
 =?utf-8?B?VW9hR2ZkSlRSaSs1aFlUaURsM3Q5THZpYUE0K1hqZ0hlbTBBcHdGSWFMZldH?=
 =?utf-8?B?SHoycTFhdjhaQ0RGL2F2RFlGcEhpMU04dEN4S0k0Y2RQQWN1RGZ1MFNJYkZl?=
 =?utf-8?B?MXZaSGxvOE5CWEl5VFZlL0hQaENSVGp4WXIxYndxSG5temF5RnhvVjVHUVl4?=
 =?utf-8?B?em8vZ1BpeVE3WWFPdjlKUXQ3S05aVFQ3ZVp2eWdqb0NHNU9vemdWOUc4dTBl?=
 =?utf-8?B?aFExQ1lTKzljazMyd2Y1NHFocXdoeStBS0lWbkg0ZFg2UWI5ZFQ4eVJZWkQ0?=
 =?utf-8?B?UHJBRTR5UjRwK3hxVCthSHBReGdSRTQzb3c4NlRIMmZVL2dmWGRGY3VFNlVP?=
 =?utf-8?B?bDJLcUxlSG42VHZFQ0lIdzhnRE8zMWR6WTBDbFVNN2gyZUlIbDFHQlE0TzNZ?=
 =?utf-8?B?OTJTby9kMDE3R2xkR29yZDlMaG5waXUzVWJYa0NnU3ZvcUV2QXk2S0ZZWUM2?=
 =?utf-8?B?bnpOdGZweTgxbVR3WGFyRWRUYXZIUEFleVFjUWdxOWNnYW9HTXRYL3h0VFhS?=
 =?utf-8?B?TkVzdDVZdzk1V25hdDlLZjFYdDRmelBRa1VNSlJhUEFrRUN4MndMMzNwTHdv?=
 =?utf-8?B?Ujd1SDh2dXRFazIrOWExTVJyVHJpQS8zZU1aTHFGOWtmb1hUYUNjSFM0WUpq?=
 =?utf-8?B?ckxrNG9MVkpsZjN0bTVOUWRtZEk4K3J6TnRVVjYzR3I0dFFtMFRiLy8weXJW?=
 =?utf-8?B?NW5KdFNyakoxMkRxT2V3RU80M3YxeUVRVUlBU0pmWTNzU0ZjRDYzRnI2bjh5?=
 =?utf-8?B?T2pYM2dIcXJOVVJmUEl4SzdxeUZ0VHUveFVHTXVxYUFLOHVXN2FQUFJ1VG92?=
 =?utf-8?B?Tyt2VzhXYkh6dWpkVVdqcTIxbFR0WG5yMWo3NUM0STlZeGZVUnFrTEdJcm9X?=
 =?utf-8?B?MG1vbTBlR056bjFlK1RGREZrZW1OV3Z3dDF2cGZjcVVaL0NaQmtCWHJ2QU9M?=
 =?utf-8?B?MTVPR0ZlVEtkYTh4N0xOZDJUbkxaTWl6eVl1MWZWc20vWWJMelJqWEl0T01y?=
 =?utf-8?B?WFEvait1N3Qvd0wwWlBHUHc0bFZXc09jeUhQQnprVHcyQUh6YU1uNlVWRm1u?=
 =?utf-8?B?di96WTRJRW02QTFoVUlPaTBGa2NkelNGV1ZtSW5Kbm5jSTJsUzk0VHNRUFlL?=
 =?utf-8?B?TmhKRzZsa2wvTzJaQnpUV1puUjA0c2hMRFdvdVZPVkVMako0QTVNSEdpVlJQ?=
 =?utf-8?B?QWJiaG5DTS9JRzBQTU1RNHllOWVxbmtzR1BYZWpMVmhiVHltU0haak9vd0R3?=
 =?utf-8?B?UzZ5ZWlQeE9ieXg4dXpyZFBKUzdTeStZcldnZkF1ZHB1NENXYVdGbzdDUlo3?=
 =?utf-8?B?aEQxNHRIdEdNRkg1Y0x6M3MzMTF6NTBXcHB2dlpqVGpPSzFlNUNtR09wMXk5?=
 =?utf-8?B?aU5rK1g3cTRtdDBtQTQrajFSNWgxczdqM2duS0M1QkNVcGZrUDZpUnV0c0Rz?=
 =?utf-8?Q?0/wu15/irvDQhqBJ2Amb5nI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdaSTVxblNydmZMOUxVSUloWSt1SHNjbmdpK25mQXJNZ0Ira0h2bEtiSHJM?=
 =?utf-8?B?SFVGMm9qVG0zaVZZT2NLbVgzZFdLVDVFSnZtV3RibHQ5ME9Hb2VYNk1BZDBJ?=
 =?utf-8?B?MlQyWE01dmduRUJmUDNodC9mQnJLQTR4SE15YmlFWjJvUDFraU9VQVkrRkRj?=
 =?utf-8?B?Ykh4TVB3aFY4UzFsWWZHVWhLSHVDYTBEWkROWkZic2c4RndSaHhnbnZQdXZu?=
 =?utf-8?B?OWc2L3NTMGRJWlUzdjZjeHhHbGJYRXJ1clcvMzZENkwxT2tqUTJBeXM3L01D?=
 =?utf-8?B?SWd6djcrNVdYSW9mR2daTThUd21tUVhFQjNTM2lnOWYyUXZDNVFEYlRQc3RY?=
 =?utf-8?B?TWVUYlUrLzZMTUNKQWRzdmp1VUVSbTBjY0pmQURINnh6aVpmU01JNW9MNGZr?=
 =?utf-8?B?Y0taK2k5dmVQTm9CdXZuTEF2blp5Qnp4OWxueUtCZlNnanRLRE1Fbi9VckJZ?=
 =?utf-8?B?QS8yWjYyemExVS9TWEdtbjF2d2xNamtEK0dyYWF4dENQY3k4QkpGMW5zeE10?=
 =?utf-8?B?L3VOUzF5UHowYktlS3BhMFJzN0RJS3cra1BEa0wxWjZUa1Eyd25IUUx6Mlh2?=
 =?utf-8?B?a1dVSzh0QnZzS0FJUkhnUlJNbzRmbS9jaUk0c3ZyK3JjWi9QS2lVTVpEYzcr?=
 =?utf-8?B?aU1IKzdUVlBOZnhpWE5HbGsxU1Z0VXEvVHZGMkJIR1RaWDJHMk5OYzIrcUxG?=
 =?utf-8?B?ZWMraUE2MGRUOUdMdVN3RnE1N25yNTlKSUNwMm82MllOS3dXQ2tueHFrcGxF?=
 =?utf-8?B?dFJkSDUxK3BtNVZoVzVGN01tNkdQMnhpdkdpV2ZZRGxIT2lhQ2JNUXkyZzFa?=
 =?utf-8?B?TGk1TUZFcmRUaGNlcE9pNWczcVNZS25JUVgyQ3JlRUN3TWJvSExCNThpeXdX?=
 =?utf-8?B?V1ZlSGVsZGpmWTRFTDdzMXRCb0MwSzh3Nkw1VmRJWXExU3VrV2dESU9HTnEy?=
 =?utf-8?B?U1JJN1U1dlJ4bG5BQ0cyVFdBcmJEb1hhU1ZlSExldGtSbTM2c0F0NytUQXN3?=
 =?utf-8?B?UWlNajRRZ3BHY3FGWGNuTERPam5Hc2k2UTNJSit1SG45VXN6MVlZeCtLSDlC?=
 =?utf-8?B?Q3VRdUhNMUZhWi9nclQ2Sk9DcWNqWko4elY2Qi8ycFdGM0l2OXJva3Y5UFdq?=
 =?utf-8?B?NCt6eERvTUZ2Z1dYSnRQd0RwWnI3bnBURnRGWE1FOSs2NHlSQVRIK2dLNHds?=
 =?utf-8?B?U2kvWjdFenY0Uzkyd2IvRk1vaVhTRzBNWXFVN2NKUklWMXlYWHZhT3g4WmJa?=
 =?utf-8?B?bHJnTGZxLzYxMUNUM29HVGtValJFL0Q3VHRRUzJvS0VxalhqRWVrNDRiaUdP?=
 =?utf-8?B?WDVIL2RtOUtqKytzMVBzRVAzK0QxUW1rOWcwR0REdzZuVExnVFJuekNOK1dv?=
 =?utf-8?B?R2ZjV0FWTjByMlBvNkNWT3ZTZGxwd01sdzlrK21MQ0dIQ01QWEtuS0E3UmNn?=
 =?utf-8?B?V3JzZXgwdWt4Ylh3Q3V4eFhYVkVSUEJXa011bVU2b2NGUG1ITlB4VTBNTHFC?=
 =?utf-8?B?em5sb0pVMG5NWlBmSW9Ta0xwZEtXZXFmb0NUNGJid3ZnWVNodDNvbXZTVm84?=
 =?utf-8?B?R0QxQW55WG1LWUlkS0ptb1k2TXdGbUxmclVldXVBTDgvKzEvdGdRMzJaR3RU?=
 =?utf-8?B?b2wxSVF3ZE53NHp0THhteVFzeHJEUVRFclZ2d0ExdXZWU1FWWGpZZkpqM1VB?=
 =?utf-8?B?b0I5QXBHaEthQ1psYXpZMFVrTUdQbjd0cVlyNSswSkZub2lZdXhuenRwSnRL?=
 =?utf-8?B?dStIMmdiT1R3djRqR2ljVFRFQ1duT05rTmJ0alF0SnNqQlB6c1FTRW1uK1Zt?=
 =?utf-8?B?TjlxTVFBSDVxblYrek1YM0JJNTJkQ0VHZ2N1MzEyMDJQNXJGT0RVQkxDNFZL?=
 =?utf-8?B?RWdDM2U0MjVrVkl1SWI3WnR0b0JiczZqdlQvcmF4aGV3SDVXVmtHbGdBVWRD?=
 =?utf-8?B?dnhMbklJNmJEWVN4T1JvcFRQLzJmb0NrYXJKdUtTWjd4NHF6S3VPOUxhYVBK?=
 =?utf-8?B?UTdackE4Rkw4UnViMS9ZWkJ0RWxtVmZ1R1FSZHYvaUVGejR1dngxMGplYmx4?=
 =?utf-8?B?MVF6alpyWlF4YVc5S01pWkpzckVXS2F2TXdBekZOWVdEVnFGNysvTkFUR3Vu?=
 =?utf-8?B?VC80ZmRpVDRlRHZtUkZ4cHo5UmN1VXF6SjBlOThSSkFFYy91ZUJ2WUdTWFpa?=
 =?utf-8?B?dEFvVlcvNkVwKzVRek9HQkpObDA0eW9NbjhnMFVkWElNcUdJbS9NSWNQQmpP?=
 =?utf-8?B?SEI2ZW9TSnk2UzhVbS91b2dzUmx1UTVOczlzdWZUc1NqYkg3QzZjQWo0b2tK?=
 =?utf-8?B?RjhrQWNPVGxyUnJRclMvUDFmaXBYWC9KMnc5S3dFV2ZQbm1mb1BQQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5142c074-d79c-4223-90f4-08de64c95fd7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:19.4861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2kryYwIgVEYqmKct1v+QKEcIouhw/TZW8xHwrE8+v4aVqvdbSdZJZBPzEIWGxCqeNZuDJfq0HDyKITsk3/zZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

From: Ye Li <ye.li@nxp.com>

Change to use default board_phys_sdram_size implementation in soc.c,
which will call SM API to get DDR size.

If board has special implementation for DDR size, then board_phys_sdram_size
could be implemented in board file to override the default one in soc.c.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.c | 7 -------
 board/nxp/imx95_evk/imx95_evk.c | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 588aa7548d4..a4b59bb7cea 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -32,10 +32,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}
diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index ca1d916deab..74a6c14bf6d 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -22,10 +22,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}

-- 
2.43.0

