Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790ABE83F1F
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9574F8382A;
	Thu,  5 Feb 2026 16:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YwwLtlmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099F183693; Thu,  5 Feb 2026 16:15:10 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AF783015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRms6ss+thLYyzL9fck4GgAaKc+WLxFnz1z18P0/QzA5Ppx79DNEk3wdLi35sh1MGX7mLMz4pzoyp9x2piw0JmGmZQNOHDOShmW/oLftq8zCL0AAxZ5zgpk4FQtczMHi4ZsoKRg9tb/XvqGRq0b58bC5GEpe8sgjia0k0zdzxv9welJnsrVpMUdzIUokcIvz3Pc/i+xGBLgpTM1OtVNk9EqLKmxQqULPj1T/HTKX95trbOk/VooNYPzPIF7ct0sgcQbJrvXuJslpuybZpigOCdT0ZpBDDjLfsgPVRUz5RdPxw8vwosQP153sKK69i2nCdwLohTJZjLA4kBScprdCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHSmQt+rBF+AVplQB6HKTiXpG1TNChwjIgwDdBd1bHs=;
 b=dMya2ks9/js5C90HJYICI30fLGpdJeCG+qyE7UpvUOfitBshbB4uPb7XGd+08A4w3X+sXOhzZX0Z3BZ+LH3mIITXhFGz746OGdRm6JQSl3ADBZQKZzjoiALXd0a4ejQqBh2S91ATvpZortVNgvY1DeGrxIurg+0/8n+M1ihV5Svp4mAYSC2dWAWRnaZrPa0goNVkc2I8u9ODN/KFN/YqvtZ2gB26WHGSpPQO04/AM6tAOnny9vf9J2IoKofZgzWl6nxU5ynAd5ZwIUcIW0gTlodEU2TuAuHIOkbFtEa53r1Ai4D/1rhboX2bfw1Pgy7LM0Cc5IbqrqhSUDXiyc3S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHSmQt+rBF+AVplQB6HKTiXpG1TNChwjIgwDdBd1bHs=;
 b=YwwLtlmC7oZPzw8n6SPL+iN3g/TR84hzvTfCzEOcxAeCq9qTuBAqurktp0ININl3p5HzwsLaVCPJyuQ/Vp+MuAR1C1UV5hXAc8Se0f9xxtbOE7nTmURQn5lQQh6C+snSyyWGilM9/fusKyF/PHjbe2ATDQxjfBOzzo07Q+dC3Ic9jeVSynpB+OKkW8LP3Z0NiwBJOiokQLXYQhmOURgcWIRvJdiHrNP0To/oqEwTvihPcy0DabGibgW+xWvSJZ5NBeqI4VHICG1Zq3gw71n4jIY34FhF4TWDh36NMHtBGL7kSeVfCeU2pg/gnKU7diFdIIZLp7NolHo94NebKuuHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:03 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 00/12] imx: add i.MX952 support
Date: Thu, 05 Feb 2026 21:55:06 +0800
Message-Id: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqhhGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNT3czcCktTI92UZHMTMzOztBSTxCQloOKCotS0zAqwQdFKZYZKsbW
 1AKGTGPBcAAAA
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
X-MS-Office365-Filtering-Correlation-Id: dac8a1f6-8d82-4b1a-88a3-08de64c9564d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjdLa0Zqc1B1K3JGOFpGWDd3SGpSU280alZqS3ZNZTlvWDdhU3FqRzZhYzBO?=
 =?utf-8?B?UU4wZzhUeXlrak5OdThCMllLY05PS01JZk5QNVFkbmdVbm5sTlkyVjR2SzVO?=
 =?utf-8?B?eUdyeENvOTc3aE9jdW5jVzdQU1VDU3JreTNGd3YwQ0wvYjhyQkNGUHhzbEtB?=
 =?utf-8?B?MDJYUVJSeE9iL0E2ZXJEZFpTYkdjY2tWSlhsRnJ2ZE1tTXVuK20rcitKWnBT?=
 =?utf-8?B?Y3FCMFNqQWE0Q2hWbmxkeW1SVHdESmJQMjBSVlBnNkhmcy8zd0gvTDkvc1BJ?=
 =?utf-8?B?UUdpSHBuaVFya0VteTJDV1NlQTYxemlVN3p3S0ZsUUkzRGJLVDB4UjNRTUV4?=
 =?utf-8?B?cURxUWg3R3JXRTJlU0JuRWU1bHhhUklERDdhSHJBSzNpUHVldFF3Nlg5azdW?=
 =?utf-8?B?TWtBQzM0azlEMWpFYXJsK0RXazF0RWo1d3lvK25NSjVrblAwMVgzdXE4L1ZL?=
 =?utf-8?B?cDdjM0RUS0JLbFVmc3l4VmxLNlFBRjJlL3AvQTRxVjZueFQraFozOGVWeVRO?=
 =?utf-8?B?a3dvMVU2NnY5ckJhZ1o3ckIxaDNyNTRzazRhUi9obTNFbWM3WnlPZlFHclps?=
 =?utf-8?B?dHgxb1N1SWJSVUUyVk5iLzZ6RzI3dUU0S1NUOVhzc01wMnVreWtHd0NyVGpk?=
 =?utf-8?B?bUt2U0NmOHpVMkdiSVl3L3ptUkIybWxITEk5MXd5OGNuSk9aUGNPT3JlbDJU?=
 =?utf-8?B?YnVaQ050QVZJTi9HNm9uOTQ4TnFYQmFmcjRHVXlpdHlFQndqSWozOWVRVEhR?=
 =?utf-8?B?Z2dGYk4yWUJ0QzBPY2ZuZktjcHlVczYwSTBwZHJDSWlwZFhpYnBkZ2d2WGtM?=
 =?utf-8?B?RzRML1FKRklFdDdtRG1aK1hmdGwzWXJweGVHZU9pWGFGTER0bU1iSDZ6alV2?=
 =?utf-8?B?b0pOdzNxZ0pQT3FQbGNxTmNDeUdLYXduenNZSjdFazg0aFc4RHJrTGtDVWI0?=
 =?utf-8?B?U2JOWnJhcFBiVWd6bGxFeVh0M1R1M0lRbFB2K3BMSUIyK0FmRXVuWCtiVklt?=
 =?utf-8?B?THd3bE9Vd1kzdlNabUlSUWl3SXdiUitCSmpCSFJNZXpCS2xkVXN3eWVZRHFK?=
 =?utf-8?B?aXROM01ia2xrYU91WFNlcTNCT2syQkN5NGZWMTJibXoraG9XUlA5V0NuQWlS?=
 =?utf-8?B?Nkc0S2tESTF0dDRMYW01K2xobDB6KzlPaFdUd3dvaXYrQmVtV2VHZWlDNjMv?=
 =?utf-8?B?aU9iTGJyKzNzRmlxTFNycGQ5ek1yS0RsSDlHKzJvYTV4TEVaNEtqTTBBVG9Y?=
 =?utf-8?B?WlpneTFhdzZyY3hvai9ZR2Fya3RVUGlIWGU1R0dWWVZ5NmFBdEd1MEJ0cC9O?=
 =?utf-8?B?dVMxcDdTcEUybkJtZWZoQ01FVkF1R3VKVENKNGtKZ3JmTlVVWXRhbEt2NUcr?=
 =?utf-8?B?eGNQYUgxUHl1bWk5T3FMdzBxU0ZQRVRQaXY3SkVNdEtjcFNMUE54TnVJOVM1?=
 =?utf-8?B?Tkw0T3p1aFNjMVZZbEhjV1Z1UW9RYWhLazh0OWlzVjUvcGhaZnZ2YzFWbE5w?=
 =?utf-8?B?L3VBSFNobkRTOWV6aUNSanB6ajd5YytnN3dzaGdobjFpOHR3K3ZWT3Uva1d3?=
 =?utf-8?B?R2RySlM5UGJYNjFTbkxzTnVET3ViSndrQkVVMklUNGFBT1B1YXI2Mm5TUlB3?=
 =?utf-8?B?bVg5N2tLMTBpb1JiSFcraDZtVFREUUQvbWVtQWZTYmdGRi9ibHNNR24rYWNG?=
 =?utf-8?B?ZkZqOHd4ZFNmVnB6b05INnlHNGRqZVZCN2ZqUnZTbld1ZisvVGhNVEZBWE44?=
 =?utf-8?B?YmZIRVY4SmRpWDE2cmdPVnVFN2Y0NUF4TER3TGc1ZXdmSUtBRXE0U0p0ZVlH?=
 =?utf-8?B?MVlpTmNjQUxsVUtQTWVMWENSTnovMm1YY3Y0aFVlcm94WEpuS21jYkZENVFN?=
 =?utf-8?B?SnBMMmo2R3Y1T1VsNHhOcjB2WDB0VVlCQW1wajE0WTVNVWNXdWY0MEtkVnYr?=
 =?utf-8?B?MDIzV0FTMmxCM3k0V1FyNEY2UTdpOTNvdXlQbUdXeEFlVFRFbCtkTGlGbmJm?=
 =?utf-8?B?bVJESUpRQVJGdm9aMjVzR1NVTE1zT3ZJZlgxKzgrdldPZWFTOGxNS0lxRHlG?=
 =?utf-8?B?dDYrMWJiS0Q1MHUvcUxlYXVrbVJHT3l0bkp4NTZaOGRsR04rbHp1N25kc25M?=
 =?utf-8?B?S2tlbUZsMitSTkJNcUY4akFoOHU4am5NbHRnc09Xc2FqK3FLc3NGMDBvWEVo?=
 =?utf-8?Q?tNFTUHLxkgNdo57vpJ5vztw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG14M3YwdUhXczRhdXorZmdqTU95VHlXNTlaTG5kQzdBUFZOaFlNbXlBY3ls?=
 =?utf-8?B?cjg4OE9MaTFhQnFHcDZ4MmlqWDlEMEtKeWt4d1VSdzhFK3FjVks1QTVVM0V5?=
 =?utf-8?B?S2p5eTZHOW1VUzNLWVNiczhvOWZQQ0RLaElJdi9lOHV1NmN5VUxZVU8zZ3hv?=
 =?utf-8?B?ZmVnOUgxOUU0VVJab09iRHhuendibXdHakxRd09SNmVlVTZFSUhDZGN2KzNk?=
 =?utf-8?B?ZUoxTThXV3lUZEdBUXp3dmE0TFpTS0cvRnlmQWNXMkFlMUMvRy80MmJKN1Vv?=
 =?utf-8?B?eEJsdGVYSTJlZDJjWkpJK3VQVWFMdWQ0WXBCeUdyQ0MwRVg1NHhLaHA4eXg4?=
 =?utf-8?B?bURxSHJqZkgzdVRoK0lvbmFkL1JHYTJTY1hSNGxlTkFrcmxqZUtwcWtnQUo5?=
 =?utf-8?B?eW42WjAxNGFOeWxZQkdVcCt1eXlIVWFrOHJnY3JndTdKamROcFZ1VmVja3Uw?=
 =?utf-8?B?bjQvOFM5S1R0NVMzdFlhdjdWcUpxZEJLQkEyREJjOXQ3MGQrYlU3aHd6a3pv?=
 =?utf-8?B?aEppbGhBcENiTGw0VVhMNTA3bG5ON2R1cm9tbHlEZlBiWjNRRlAyMDN2enBC?=
 =?utf-8?B?OXJLbkVGZDNWMEVzSkcvQzdNeUNaaEU0TkNSNmR0UzdNeHhqMDFuMGMxNnpC?=
 =?utf-8?B?VmJnWkFWVS9PY1ZEeXV4OUNQVnB2by9pTjFBSzRCVGkxVHVsY0xMQmhkYlRF?=
 =?utf-8?B?QXZzRVJ4L080RWVRL3hXeU52c1VaOEJ6YWdNSlBpZmZqWGxVVVZPbm9aZDJP?=
 =?utf-8?B?TWJ0cDlGY1pOMjV4WmliM1N0OFpwNUgvR0c4c1FXamNqd0NvRG1LbHlxY2V3?=
 =?utf-8?B?RjBmNlRCeU05ekQvaHRHc3pDT20wb21SUC9MQUlwYXM5RkR1VGdONmlQQXFV?=
 =?utf-8?B?Z0NQdjFralROY3Y1NHZvNCtCdVJsV1JOekNSTkp5elljR01GVEh5NkhRSnpq?=
 =?utf-8?B?MFZZUTQzSXR4cVBPRzJJSEVCOWhXNmcrUzIxaUdpWHBJUjl6TFZ3amdVUnZt?=
 =?utf-8?B?Unl0elJ4a1RBU3RDLzU3L1I4c0cwcG5tYVo1Tks3QU55SGVpSE5ONVVETVBS?=
 =?utf-8?B?ZXJWSjZmQ0dzRVhRU0tqUFBocE5td2NES1VWNjQ0U0dTK1ptUHBjV21UWk41?=
 =?utf-8?B?RjV6eFVMZ2xJQlZaT2QrNUZ2d29lTjNuZ1pscWFXWnlHSWNJNmxFSzNDQzZQ?=
 =?utf-8?B?OXNuNW5hMVFoMmlzNnVlaytxVGlCeUxQbEpONVpabHVHeWtNZ0RGM2JZME5Z?=
 =?utf-8?B?Y3pDMXgxZ0x5QThUVjBLMHJsWG5kQzF3SVBZRHRMZWlrTENFUzJkbE5nSzZi?=
 =?utf-8?B?ZU5zRklTV2Zvb1Y2NGRSeWpTem44ait1eHdMOWVRSmtiRVlrRkc4ZmJlcjFK?=
 =?utf-8?B?cTAxTkNtbzc2WDJhY2ZLZkd4b3dPY29YTXlrMmpFK2JORkNkZjdwVG50NXFG?=
 =?utf-8?B?S2R2cm1ydCtZblJFMEJxMWhOd2k3MkxiTk5Qd1NVWUZDZ1huT2UycG1kUlM2?=
 =?utf-8?B?bFZDN2N6dm9qZFRpSXF6QktMSXFqODAvWkVqbjRUbGlIODVmQmszM1pVZFVZ?=
 =?utf-8?B?VUJSakVidHhIMnZKNHJ1UFF2ckgvYVY4SGFCb2h5MVhKck5mWTYxbTh6VFBq?=
 =?utf-8?B?K2ZkTlJ6dlVWaW1OWHQxVENTUG9jVGVBSGJFajFySTRCSlRXUGN4dmZ1ZlJr?=
 =?utf-8?B?US9GNU5mSUpOaU5CYWhzR0Y5Y0htUWlNWWtzYjFNYk5IT1hINVBVS0IxaVN5?=
 =?utf-8?B?ei9YQXN6MFd0azY2ZTc1WnRRc2dlZHlCR1IvaEs4dVVQb2UwNEtvOTZIUXhh?=
 =?utf-8?B?alZreE5QRGsyVHF3ajB3NmVMOVlYdGxjTGVySWh6QmZJZ2MwWks0ZXh3ZDZE?=
 =?utf-8?B?REZURmJlTnVaQVYxbzl1UndiU1hyRW50a3pEenZ1NFEvVG1rZE0xS3NoTUVi?=
 =?utf-8?B?WEZTOHZsa2Y4MThWWmNlL2xhallPRkNsRTh2aHlLVGx2bGoyQ0QrcnVkOFlr?=
 =?utf-8?B?WUVMcjJ4N2xFS01aOFR4V2xIVk51ZjNMR0w1MWgwUEhHbHRELzNLTFlsRFJF?=
 =?utf-8?B?dEJTY2hIWm43UWdBUGtUOHQ5K0JpbzVPZ2lLQStHUmVDTHVVYlAweVlJUGsz?=
 =?utf-8?B?Y3RBWllFQlF2eTUrano5RndXd1BQUC9vUHlXZElWU1BqTmNEa2FyNC8wSmxV?=
 =?utf-8?B?Nm5EaXMxdlp0RUtoUExOR3JrOGRzckFyT3E1Ly80TkdtRVhtb1RFRnFNaU9X?=
 =?utf-8?B?OUZEVGpGRlJncUJtbDBuT0xNVDdic0N3MXRTMFJ1bVF5cGZtOUhaSllRWHhG?=
 =?utf-8?B?dGZ0dGJJSURWL0JhR0VwNUFvUWRSZlg2dUNNL2REUTVBOEU1OTc4QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac8a1f6-8d82-4b1a-88a3-08de64c9564d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:03.6626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDKJdXpAP+hB+M2ga5PPPMuKst6wuR6GmyT7eXwlroJCDhryYxzxrlSqB0enCttANCp3RIfV7FT7NUGDxjipWQ==
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

CI: https://github.com/u-boot/u-boot/pull/863/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (8):
      arm: imx: Add i.MX952 CPU type support
      imx: ele_ahab: Add i.MX952 support to display_life_cycle()
      imx: container: Add i.MX952 support to get_imageset_end()
      arm: imx952: Add watchdog base address definitions
      arm: imx9: Add i.MX952 SoC support
      cpu: imx952: Add i.MX952 support
      dts: upstream: arm64: freescale: Sync i.MX952 device tree from Linux
      arm: dts: Add U-Boot device tree for i.MX952 EVK

Peng Fan (1):
      board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x board support

Ye Li (3):
      imx9: scmi: Get DDR size through SM SCMI API
      imx95/imx94: Remove board_phys_sdram_size from each board
      pinctrl: nxp: Add i.MX952 support

 arch/arm/dts/imx952-evk-u-boot.dtsi               |   58 +
 arch/arm/dts/imx952-u-boot.dtsi                   |  327 ++++++
 arch/arm/include/asm/arch-imx/cpu.h               |    1 +
 arch/arm/include/asm/arch-imx9/imx-regs.h         |    6 +
 arch/arm/include/asm/mach-imx/sys_proto.h         |   11 +
 arch/arm/mach-imx/Makefile                        |    2 +-
 arch/arm/mach-imx/ele_ahab.c                      |    2 +-
 arch/arm/mach-imx/image-container.c               |    4 +-
 arch/arm/mach-imx/imx9/Kconfig                    |   23 +
 arch/arm/mach-imx/imx9/scmi/common.h              |   10 +
 arch/arm/mach-imx/imx9/scmi/soc.c                 |   78 +-
 board/nxp/imx94_evk/imx94_evk.c                   |    7 -
 board/nxp/imx952_evk/Kconfig                      |   12 +
 board/nxp/imx952_evk/MAINTAINERS                  |    6 +
 board/nxp/imx952_evk/Makefile                     |   14 +
 board/nxp/imx952_evk/imx952_evk.c                 |  297 +++++
 board/nxp/imx952_evk/imx952_evk.env               |  137 +++
 board/nxp/imx952_evk/spl.c                        |  115 ++
 board/nxp/imx95_evk/imx95_evk.c                   |    7 -
 configs/imx952_evk_defconfig                      |  178 +++
 doc/board/nxp/imx952_evk.rst                      |  112 ++
 doc/board/nxp/index.rst                           |    1 +
 drivers/cpu/imx8_cpu.c                            |    2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c            |    6 +-
 dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
 dts/upstream/src/arm64/freescale/imx952-evk.dts   |  596 ++++++++++
 dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
 dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
 dts/upstream/src/arm64/freescale/imx952.dtsi      | 1266 +++++++++++++++++++++
 include/configs/imx952_evk.h                      |   31 +
 include/scmi_protocols.h                          |    3 +-
 31 files changed, 4404 insertions(+), 34 deletions(-)
---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260205-imx952-dc74666fd4ab

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

