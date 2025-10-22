Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D1CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 00:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FB3800B6;
	Wed, 22 Oct 2025 02:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MM/dp/wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6E282B20; Wed, 22 Oct 2025 02:48:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C6280077
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 02:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLgjCvYWq4/lVBdDzEwakS65xI1D+AT2dCb2FCpc33r+9WnAiESqiSMsA1lyXsW7Txhc7XNMPViiDKEulgURhkHSG5NpO/Yzbs8hWFBZGhSCcReKx94ZxLObrmbx6I+BjPlYOaLIijPG00fHdNoj7BvZsQQmZ6+yDJkC1A4mG8SEW4W1HdOvKvRuDiZbYcKQ+KJBaWgC5UaC3gy8hFuJW0Ca6pdTKY1un+1MYtUuAtE0PGh4MIs+wMLS6GJx3C/WSb3u9KL0PpM2FCXM5fIo+u2zxUY0QeaO87c5iwj0PvfMIg0YUrXU7LbYaqCb261cRdrFdAc/3fzs5Os8Ys9XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTRyz1JNbNrv3G5ZcQ8rbm+R3GpBmAxF7EW3B7WIcXY=;
 b=qOVBjMziIzMgMTtMsdmh96FYAJ7ACNgkFdzMyUQsfTp3W6gp0FUnKQUCQb4N9bmjpz2n5FF4V4+zf2d8Txew+G58yvwIgyKXDGGjPC4+f3IEdWoCso+QCEiLl+sPXRVPK5mbrfHMSAxL0e68ewDdyNDpjV8EXCAqHL+ufYn4k0GL2zl5RJT1IuygHtBr7t71BqhH5hl9CMxAfi4HMBQhMIKgl9PmxHEQfcLRo29XlHo0JE/evmr1JCiN2MTdcIpIat1mvRh/qNF3YhKiPhEjnX7Iqjn7zFfceG86qMWCejr3LXRZHFE0TOrwBLsxSC933rRJWu/qwxliIm6vf2/Whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTRyz1JNbNrv3G5ZcQ8rbm+R3GpBmAxF7EW3B7WIcXY=;
 b=MM/dp/wPRoC01uUkhLb+RpQ8iAbM+UiOcvrAnENBELT774zwfzsEBCTmukeSefvw00JkkLnGyFRkP19rJ6Ng9rXKT9/SP5JX8CsAAN/YriEGraCMaLBNaKNp80OpL+pRynZXWX0VHYysK8Med5EBBPpcJAgWm65gXZqwW+7G/J1EgBG9kghzzlEtcfTlYRqwfEtgSQVEDv9124mefIE69YtGrDQRJbkfSbDj7HQ3QH2TfSDWOGabp3FtdwMfFWHydW2OAqriWHj1weVX5w9grRqfweeKEQE1O6Mevaiyec+z4WwyUv9wcFS9ij/Ci/wiJmdMyE2/uDjEuC0rtszvWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8027.eurprd04.prod.outlook.com (2603:10a6:10:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 00:48:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 00:48:53 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
Date: Wed, 22 Oct 2025 08:48:26 +0800
Message-Id: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANsp+GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3czcCt2igqL8ZN0yY90UixTjFNM0I1OzFBMloJaCotS0zAqwcdG
 xtbUA8UYo3l4AAAA=
X-Change-ID: 20251020-imx-rproc-v3-d8d3d5f256d4
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761094123; l=3424;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=70wcafDMbr7sduTEsxCN6E0FykKidts0UoYmX/VhqZ8=;
 b=D4JA7G2cFOJmWrzphxEIwB0N4LaNV4Pef5nkIHWJPIOZ/SVGkv4QyfJKBuyhA5oIpYB1UptOy
 3Eo04qmdmI3A24yatdcYsPylTaP8QCsvVuaVql7gAcfHlS9jSFojDM4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a97fa1-ecc4-47e9-30e3-08de1104c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3dUL1NTUFU1OTBmS1I1ZnNJc2xtbnBOeXQvKzFuRFdjK2MrNS9wYlJ0S3Vy?=
 =?utf-8?B?Vi8vSzFFRVZOQ09POWJVUHJxVkJ1dUh4UiswSjdPelN4NUdJcHJ1QzVraS9T?=
 =?utf-8?B?Mk5Ia0trMkgrZENHM281dTh2R29PVDFFZUlGdVdaNjMxVEZWckpXM1k3bTJO?=
 =?utf-8?B?MjhrUCtITWNvS1VIWkMrM0pTbFZTL1orSXk2S1BxZzdOeEwzUGlkc1R4R3Iw?=
 =?utf-8?B?WFA5U0ZEQ0Nja2h2bVFFdSs2TmE3Sk1LT3NsSzdBZW01d1JFcDE3d0JoT3U2?=
 =?utf-8?B?eThNM0Q5NDArWU5OVDUra1lDTWdxQVRvdTcxcGtELzJqWmhHSDUxdllEYUVp?=
 =?utf-8?B?MWVBOFdCU0IxYkRLZGdPQ1JDc1ZKbERwNytSQkV3dmtaT25lWW1lamFQSnlh?=
 =?utf-8?B?NHNsUEwycnhsQklJM3V0SXVVV3VvdnJnZ0F0WmNWZWlDNmRqYTV4OEkrS0py?=
 =?utf-8?B?OWh6cHhxY1BLVG5ldEpRTG8zOTNBRDRSdGtDTWNLamhpdkhjb0swRk9oMy9j?=
 =?utf-8?B?WVRWNmF3K2VZbU4ydmgyNkRxR0R2L1hlMDErVGt6UGMwMUlGUkV3Q0U2WnJ2?=
 =?utf-8?B?WGM5WTFrL2p4R1V0OWZGUmdrYk5BUnJnaVAvNnE1RWJCUTYzVHBzdWF0ajBp?=
 =?utf-8?B?a1laTEJEMVlKWkFGYnBEOHg0REU2MDhoREtpNGRFeklidG5ocGhpUTBhc29j?=
 =?utf-8?B?V05QTE9MWnNONHlhU0hiNUx0cjVlZVhZeDZPbG5udnJJTmJkYzZZOHJaY2gv?=
 =?utf-8?B?cS94S28wMDN5QTkrNnVOdHorY0U2MTJqR3oxeFN0QkhuQ1d3bmsvYjdHSlZp?=
 =?utf-8?B?TWFhc1UxUFBIUmhqbVVVRDUvV3JtN1ZoTkFyd1IyamJUQ0lLRzVTbDNSMHJr?=
 =?utf-8?B?L1pXQ3ZPWTByY1NXSy9XZElyeWEyblRySFBXd3RVS21KME1td29NenhaS0s5?=
 =?utf-8?B?Z0MyU2Q0ckY0VjFqOCtiMjlaMkh3ZzhBeFNFWHVSV2swNFZyNW9Sb2dkY2wv?=
 =?utf-8?B?UTcyTkVwVkMrbWFvcVJwam5FdjNHQ1BDSlhZcGlOQjIrMTJzVm9aekQvTFg3?=
 =?utf-8?B?cTFJYW1nNFcyc0RuTSt4NnNGckhUWjBodmVRZFFRQnYzM1JxRXFVZTBZakk0?=
 =?utf-8?B?czRNU2pOcVRoRDFvUFR4a2krTWU4elBCNERuRlRyMm1LRFU1bHp6TVFwbjFU?=
 =?utf-8?B?b1V3R2NiUXFIdnFzMnlpRmVwa3Z6WURVRjU4TXV5QjdqNjF4T1hWVmZuOTFr?=
 =?utf-8?B?ZmdyaVFmNlpkaCt6NUpMWVN3Wm0ycy9GMFRPdWNGS3lXRmRxaElFWWFsQW9o?=
 =?utf-8?B?TkJXc2NLc0hHT1JRMUtZTjB4K0poNDAwZ0JvMXV5YnA2MjJzWkozMnF0RHZq?=
 =?utf-8?B?dzJxZzJ0S1Z0KzlUbUptR2hWdDY1TlgxYTVrUDZYODlFelo1c1RTd2NxY3hl?=
 =?utf-8?B?T2hYSTlmVGZmb2dvVFp1TmVQRTNSM2tqWWt1NytwUS9PNmRTYTNoUGp4bld1?=
 =?utf-8?B?S0FGQ0dheEJwK0x5MHVIVmJPK2pVYXZiZWNMQStDb1BMWS80aGZEQ3lKckc4?=
 =?utf-8?B?WXQ1ZzB1c1U4a1NKeDVieFd0MU00a3ZTQ3N3RTQxcHA1cTZCTExHcjJTN0Q1?=
 =?utf-8?B?Q1Zxa1VNVmlUUWhJY2RwekR0YUM2ODJpTUFzMmZPVjExRUc0czhYbnZVbDk0?=
 =?utf-8?B?S2F5MmtiZTA4bzVlaGNtOEJGNVBZc2hpUU0xekdIVnRlZHNKYTZZV0VMd2Zw?=
 =?utf-8?B?Qis0bHVkQnhsZkpXT3o0aGhEUGEybWJXY1doNHdsTGRFd2VudlNHejhoTXBY?=
 =?utf-8?B?RVN3bC82aWUvNDIrVjZxVjY0Tnh3RUZaM3VjUXhlT0FyeXUzd1BQdkNpTXNP?=
 =?utf-8?B?NmpETGo5TEFkYi9CYW4rMi9odEFRYnNrRzhrMUwxMElVNENCMXJxZmhPRC9m?=
 =?utf-8?B?bmJVNUVWWHg4aDV1S096TkRVa0J5NlMxZ0dtd1Y3djhvSnpZVXRhODcwc1Qz?=
 =?utf-8?B?cnVGWjFqNzBFaWYrSUJtU0xTalFNeE5tSTVGenBSZHRxcFF5amg4QWJSZTJz?=
 =?utf-8?Q?Ekyj4O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlsVGo1OXFMcjdtUGdubXVnVGZLVitRMDlQN0JoQWZ3UktrZDVZV3BVeXdq?=
 =?utf-8?B?NjV1KzIvSlhobnhFQzVjTGRQVG1ldTdid2dUdE1IL1NWNmlLSnVadXp6TTdK?=
 =?utf-8?B?ZHFZSkhFMDY4M2hxVDlIUFd4YlVaRHZrOUE3aFdIeFhGdzFKcmZZUWxsbmEy?=
 =?utf-8?B?dWhRQ2VsblNTaUt6amN1cFBKd1hTSlp6Q0ppdTluSmFvTEpaN291OVVhQitu?=
 =?utf-8?B?TmVHdnBZVmhYWHFUbW1LTkVjdzNJenY5TVdzN3g3ZEM5eDI5cjhKZGNwMm15?=
 =?utf-8?B?OEkyZjdObE4xY2FDNG95UU52UWxjKzZqOXVOMGZpb0l2V0FBSzd4VmJhbkZY?=
 =?utf-8?B?c1VPNElNQ2dzQ2UxSm45ZGZRcWROaHZMRnVPNVRLN1o5ZDNONkhDMVd4SWg1?=
 =?utf-8?B?K293aWkyRitMRmdUak1MZzdXTlExWWlJN2FoaUtYd0J3aTVrVHpFcDBTL1Ey?=
 =?utf-8?B?Z2pqdVVTeHkxSFdiWm5oZFFpRFNGanlQR1p4ZUVwZ1BGV0dtZTloY09uMjZV?=
 =?utf-8?B?S2JVL1RqamdCTTIyZm5kUDJxTHpZV1dGRjltWVdnQXVVTStuZXEycTdVd1VB?=
 =?utf-8?B?ZzEyVzFKdmVUblJNelhUSUc1eFRieFF2b3VHa2JZVWM3L3VmM2FzaVk2Y0sx?=
 =?utf-8?B?NjZ0WklCL0pxZWtidnkzRmxDbVNrdHNWcnlTWHN3S3p4QndndHFSZytsNUFa?=
 =?utf-8?B?NVI4cnJrTk1tMFdpakNCcmVrbWhiRUszSVJ3akw2cnN4MEd3dXNMNzQ0UHFk?=
 =?utf-8?B?Snd2cmViV3FXTDRjb2k1MCtzV1R0SEVuYktHU3M5ckwwbVVBMGhOQUZmdnV1?=
 =?utf-8?B?ZG8zSHNIeStnR08zdTFkSU16bVBFSGdyczFKYWx0dHlBamdYMG1DM21mTWpV?=
 =?utf-8?B?YmYrZlcxK09hWmV4S090RGd3YUJiVlJ1Sk80UjRhRHpoTEErRFlJSW56T0ZY?=
 =?utf-8?B?clAwYkpEVlNUdTQ2QS9YemN6dURnRmNOL0d5MGZQcGU1QitHbVJhUzRQZktQ?=
 =?utf-8?B?U01LWXZwZE9QdW9scWtFUnUxenVhdUZXbmdlNVVrVUxzTGNwNHpmb1pHNW5l?=
 =?utf-8?B?ZXdza1BXZGNTdjNocnNubmVxWStyMVUycGNuNU9xbUx6NzVIa3V5S0lGekZD?=
 =?utf-8?B?elVkd3VwMGVEU242TlBrTVNlOUI1WFk4K2tuM0pRdzVlM2tCYzFoejFocmhN?=
 =?utf-8?B?UXBFQWV1SDZWc1dZbEpzOFdOYittakRhK1N0a1E5eXFPMEYvRjdvd0hoRUFK?=
 =?utf-8?B?eEppTGNFT3hWMHdiRVEydVNSMTVPd1Q0VjlyOGpjbHRQRHJOVm1rWFdCZG81?=
 =?utf-8?B?a0dUZlc3K000Q210OHR1ZjJUNGhDNDJRRlhsV0tXMEJRamxDdVlQQmlERFVz?=
 =?utf-8?B?VEo4elBqRmRWV1ovV2VFSkREWTFncjJuZ2FtVzFOeFJ4amlkeSsxWm9iR2Q1?=
 =?utf-8?B?RXhLT2Rrc2tGcWsvcWFzS1ZLVjdyTEZHcUZSd2Z4Nmpyb3hCejc1NnNNby9v?=
 =?utf-8?B?Yyt2TEpqZ2kzeGdPTmlVZlZhTTQ5VCtmY29sRmZESHJwejhBTTZTdWxDcTQv?=
 =?utf-8?B?YmxORVVTVDBJeTVvejkxd2VyWkpHRzBmd0JmZ3k3RDMvWHB1bzZyb2xObVVr?=
 =?utf-8?B?K01lM2M2U2E5eWxQVjRIK2hGYkNWdG9ZQXlNRlNKRzY5L1hVMVd4SU5ZMWZQ?=
 =?utf-8?B?SHhoRGtuNXBiWmFVQkF4SThTLzVTcGIxYW5wTnZid3g2UENIK3l3VXdoSHp5?=
 =?utf-8?B?ZlZvR1pDS2VBWHhLTVlaU0xLcTNRMjBHZDRDdkFrTk1NSjNWTWY3akFzUnJw?=
 =?utf-8?B?b2hEaG9MVDg2bVk0Y3VEYXpHa29WcDJUWjVSelhOZE1BbWlPaTV3UjVURFdF?=
 =?utf-8?B?dGI1cXk5RFkxWU1LRzhoalZNWnk0dVhjVUl6cFd2UXRrV3pQUTZIbWFORUFh?=
 =?utf-8?B?L1RseHBjVUtkcDdTdHhQdUtRQ2FIc3VoU1F3VkZVQkI5UEltTUZpclZtMVZ6?=
 =?utf-8?B?ejRnWG1qcTNjcW1nQjB5ckhSOFQ3b1ZDbEVuNm5PVkJnWG8rbStvMlNsUVVy?=
 =?utf-8?B?eVp5VGNuSkxQVmVxU3AwR2FHL2hodXp0WUpVVnFxSUxGSjdOaUltN3FQRE9J?=
 =?utf-8?Q?mzjpByN2FrQAwDCiUUe7OCDIx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a97fa1-ecc4-47e9-30e3-08de1104c59d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 00:48:52.9813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsvix9NegT5Drl0Ml9YcLZbvuh4zZtYglMYsfnjgvunHMwGSNnoW3zRnMQdAwiJuWWLx8DkftE9XwNP/2WByFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8027
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

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=21

This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
platforms. Most of the i.MX-specific logic is ported from the Linux kernel to
ensure compatibility and maintainability.

The existing bootaux command in U-Boot only supports loading raw binary images.
However, this approach fails when the remote processor firmware contains
sections that must be loaded into both TCM and DDR. To address this limitation,
need to use remoteproc framework ELF loader, enabling proper loading of
segmented firmware images.

Patch Summary:

Patches 1–2: Import memcpy_io and memset_io from the Linux kernel and enable
             them in the remoteproc subsystem.
Patches 3–11: Add platform-specific remoteproc support for i.MX8M and i.MX93.
Patch 6: Temporarily adds Cortex-M nodes to x-u-boot.dtsi since they are not
         yet available in the upstream Linux device tree. These nodes can be
	 removed once they are merged upstream.

NXP internal R-b tags are kept, because the patches are directly
cherry-picked from NXP LTS tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Add doc for remoteproc

Changes in v2:
- Drop patch 1 import memcpy_fromio which is not redundant
- Link to v1: https://lore.kernel.org/r/20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com

---
Peng Fan (12):
      remoteproc: Extend device_to_virt with a is_iomem parameter
      remoteproc: Add imx_rproc driver to support NXP i.MX8MP/N
      remoteproc: imx_rproc: Support i.MX8MQ/M
      remoteproc: imx_rproc: Add support for i.MX93 CM33
      arm: dts: imx8m: Add remoteproc node
      imx8mp: Enable remoteproc for i.MX8MP EVK
      imx8mm: Enable remoteproc for i.MX8MM EVK
      imx8mn: Enable remoteproc for i.MX8MN EVK
      imx8mq: Enable remoteproc for i.MX8MQ EVK
      imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM
      doc: board: nxp: Add remoteproc guide
      doc: cmd: Document remoteproc usage

 MAINTAINERS                           |   2 +
 arch/arm/dts/imx8mm-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mn-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mp-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mq-u-boot.dtsi       |   4 +
 arch/arm/mach-imx/imx8m/Kconfig       |  20 ++
 arch/arm/mach-imx/imx9/Kconfig        |  12 ++
 doc/board/nxp/index.rst               |   1 +
 doc/board/nxp/rproc.rst               |  69 +++++++
 doc/usage/cmd/rproc.rst               |  78 +++++++
 doc/usage/index.rst                   |   1 +
 drivers/remoteproc/Kconfig            |   7 +
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/imx_rproc.c        | 370 ++++++++++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.h        |  56 +++++
 drivers/remoteproc/renesas_apmu.c     |   3 +-
 drivers/remoteproc/rproc-elf-loader.c |  94 ++++++---
 drivers/remoteproc/sandbox_testproc.c |   3 +-
 drivers/remoteproc/stm32_copro.c      |   3 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c  |   2 +-
 drivers/remoteproc/ti_k3_m4_rproc.c   |   2 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c  |   2 +-
 include/remoteproc.h                  |   3 +-
 23 files changed, 708 insertions(+), 37 deletions(-)
---
base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
change-id: 20251020-imx-rproc-v3-d8d3d5f256d4

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

