Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D1C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C4682786;
	Mon, 28 Apr 2025 12:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JbnyHWFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCBE825A6; Mon, 28 Apr 2025 12:38:47 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1458269F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3JrgJeBlRiNVJcSnTKFd7DPWdfDClUXQGtwjfBYg/atkT1JbpigxcluAcS77ZO/EXX1vu+EiJlaSsw4vVQKDIU4ahEFcYLGHayYh7VnvnS6RMFkKKDyODbjqdZix8y27pdSKMjKDDGrAaXTsHYYMdR4iANj/+lWPrI6xqIJ8jUTv7+YINZafxL0wSGfaOrzfpM7CjohxZGWSJxA0AGcrdlDj7JxCoWgHAVPV20aH60H7rD0OqNUeNlg8S+YB0BSlNrsnNENPfDWmoCLsANj1lJFZ6yRaZUIf/N/lVXM4XPbTDeCByVYP4djPfX+dkTnAbQYaz2qbpcxWx2GZiphyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RofmbV/+ODY9aTjSQGzBm7y2iDvIF3IzdnKnA6ZPFGo=;
 b=Qf/VvpU69ISyDwwaBlu7YNoBvZ2uyBG+MwzIadYGlsnlc8WQZeCD7V8210/7E4cm2qk5mQ8lk1qRcSJbqw853m7JVxOM4wUUoDCE+pYcMHHL0WFfNsXiNhGm7uz6PuctI9BBF7cEA0YQzsSn8wCekwRRAPtUQKSowKq5JeZBgfr/lsdV0nyhJyrv8FAgvnnGLRzDkR/vTdDdi8vcMJpSR5BlhCYwwTC4IW2DcwYzCCZLem0AfWfgHxW4BOqtXlew6nh+c0PO65pdIeFo/cJYVoH5Ix4nrXNR6zuI1+JJxBRj4Jhha2Tl/sJXhOqXT9OZcNbpEP92lGytnN9qlDnWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RofmbV/+ODY9aTjSQGzBm7y2iDvIF3IzdnKnA6ZPFGo=;
 b=JbnyHWFuJHYgcNNnDNDnOXuqEfEYFcHR9LdeIDLXyiYwOVP2ooRRnbfAA60QFf5UqyEyIRwZIdNxB2ezHQEPN9cfM42Cb3LgA0SMHdvVDnNLkDV8brez6dw33c7+6Aek0TxqiZXjroocV+/OCDUzZC3LN44ch/4pW7rJ9NU1z8Gek1QogPhiqG31jQdkDkLAYc5cP6SppVDBZIn8r+hDQMO4eNGiycIvcRgyruWm7erx/xzsmTX+lAlF+G8G+k+1l6+vw4IDLW9l2hOLdXo4LmM7KOSHOeOvRfSAT+eiAhr4WD+fYbqvmFraJMZqrnT/ryTgpjt2WlNI09DsI88sng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:38:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:28 +0800
Subject: [PATCH v11 05/21] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-5-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: d412cf8a-112c-4ed9-6a45-08dd8640d8f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUtQNHA2cmZ6bDI2T3EyK2FRZWRmSGdDcUMwVlZTRHFxWFIxVXNKZ1FVU3Zo?=
 =?utf-8?B?R3ltVG9uNUVMaGtHWTdKMFVlOGFOeEhvMFNiNGJQM1dRY3BTQm5aczZCdWJu?=
 =?utf-8?B?elJUREpXQXZXdXl2aTdISS9MOVhQZVB1bVB6YnVKcFk0eHJMeUhaY1V1ajUv?=
 =?utf-8?B?eWY2UDJUcTgwcVZsblUxbzRKQVpHZWhPSlQrSlRjU2RqcDZ6bG94YlNYMkk1?=
 =?utf-8?B?aFhhL3FnSE4yQU5lbEw5enhaWWhaaTlnMEcvS01Rb01MakdOZWFSS2Q1bGxQ?=
 =?utf-8?B?a3VSa1ZUSVJVRnZnWGE4blBYNGJLL1hlV1MwWkVrZDByeFNwYmhiWlM1YXA0?=
 =?utf-8?B?bE52MW1PTjZWUjZBRkR5MmNpaUQrdVRNa3lqODQ0eEJ1VTFJSE5rdHU2NzJ5?=
 =?utf-8?B?azhBdmRoQkE5UzRqcmJZRElVaWVvQ2NiZ0ZJMmc3aGtqMi9IU3dWZlY5SHdh?=
 =?utf-8?B?ZnE2cmFZU3lHS1dZWHlWQmdKUkxwbFhRZkZ0VGhPbUpIN3hxMTVjeUpqUmc4?=
 =?utf-8?B?VnRYMXNPQzNIVXM3NWttb202UnlsTHZia21ROGZmT0pvTUxkc1JaY0tLeDN5?=
 =?utf-8?B?YnJ6UHRxRHZYZFdrckJCMVBiUG5pSGJYcnRLTDMxb0dWYjdwdlVMemtBU1JB?=
 =?utf-8?B?VGY1WkU5Wmx3WVJQbFI1bDZJeHhNUUN4VkdXbktDS2UvU28zSnBMM3hadmxS?=
 =?utf-8?B?Mjk1bjJpR0JZNCtveDJZb1dHdlJuL3BkVTI5V2tHK2tkR096Qml3Wk5GRnlz?=
 =?utf-8?B?dHUreFdWSVVnL0o3NjNDNHJuOVQyVU5jZVEzbk0ydnl0NkF2Q0plNDdFNW13?=
 =?utf-8?B?a2lzZXJFbU5pQkp1STZMc3MvbDBtUGlVVWg4TjhOd25IUllRMEVHY1dOcWJD?=
 =?utf-8?B?N05hS080SmVEQmhSbVdMazFVY1A3SWJIV3E4Uk14c0kzY0JCbng1dmx1SkZn?=
 =?utf-8?B?NVNRbXlWemx1ejZRRlVqUitwcHNjNHUvM3pPZm9ERjZyOGdJdXg5NUlTUUJZ?=
 =?utf-8?B?MTVWUzkyck9tUEo2YUNuM2ZLNENRM0ppVG9Qam1tOVBCK3JaYUZVNG16YVEv?=
 =?utf-8?B?QUJROUZBN1VDMHM5TEV5aFdXVVhtL2g1dWVEMVI1WGRBaSs0bWZTbnhCalE1?=
 =?utf-8?B?TTl1ckJ4dUxJL1lBdC9OSUM2bDU1U2djd0Q0U0h5enpUeEZKcVgveW04cTJH?=
 =?utf-8?B?MGI5dklCb0YxWW1KT0F1bElKZUdLcVBTVmVyTUlBM1hpc09uVmZWV0ZUME9X?=
 =?utf-8?B?RmM2ZEpaSkRzcWZsSWc2eFVDVksyQk1RbEJlbXYrUjdLcUVmQVllMEYxcVNo?=
 =?utf-8?B?ekVNZ2l6ZWNkeGlIVld1eEowdW5RcDhBL3VkYjVPb3FyTkM3Z1ZUME5pQmUz?=
 =?utf-8?B?TGFrQUpZMlIzc2p0eEFzenJVeENWVGtBQ0tLWitwSmF2UWJWSkVjQXdCWVJK?=
 =?utf-8?B?TkpGRk02Tk9sdWZYUEdBZU5YSURFNUVwbWRBUzVhRW9nM3BZQmk4dzNWNElx?=
 =?utf-8?B?RkRDMm4zQ3lwajdIb0NBUlJQUXZPMjZCL0grbkJuaXpjNjBlSERjVTdDdzg2?=
 =?utf-8?B?RG9MK20vNjdtbGFnRUFyN0pFbE05QWk5WU80UHdXZE1ueUs2STRpMXlpMVlq?=
 =?utf-8?B?aFNkYUVLblZsaXhHLzBxVHRlSG5TZ0VOeFRsSXUyaURPVGh1RXo2TUVaUTBi?=
 =?utf-8?B?dmdGbW5KQVdCT0dvY3JNTS9xemNTQ0hJYW1LcVNnc01JdVFDWlFva0NLeGls?=
 =?utf-8?B?QXYwamg1YnN4akFmbitQTE03RXVOYXBZMWFCUUhRMERyQXdQeGhqdlkrV2po?=
 =?utf-8?B?bVJVeFVhWUF4N3lXQ1c3VzlRUzRBak1sMHIxZHF6NnJCNDl5eDJYYVBRNEVR?=
 =?utf-8?B?TUdjdC9xaXhTeCtZMis2aGhobnluMWdrdnJNc0ZqWUs5aDRuT3FIL1YrQ3Z1?=
 =?utf-8?B?dlJ5LzlaSDJ5dTc3UEJxVktWQkt6dXVoSlB6R0VkSFoxZzNjdDlxK3JzdHFv?=
 =?utf-8?B?Z0FIOThSYUNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVqR3lkZEVmd0JMVDUzU3ZHWVBQeW5HY09TR1ZUZGwvd28zSUl4UG5oNkt6?=
 =?utf-8?B?QmdNOFdpUTY2Q0FqQ3luc1RZQUFTc1M3UlJGWXVwbGtucWpmTm1KK2o5R1ZV?=
 =?utf-8?B?YUoxRVd3YTdZVUxwb0VneHhzdG5jYUxuMS9IRkFtVUpIdElsRXZKVHdDdUJV?=
 =?utf-8?B?SlhGaUJlaVoxY2laZ3BIblBLdU5TV1JtK3E0YnAvM09jTXUzYjJXZk5YcG80?=
 =?utf-8?B?dm9GZUp4dWlHS2ZWWUxSakFxd1lDanlRYjdzNkhIejdFVnBSNUpaUFJMYnU5?=
 =?utf-8?B?bGZwbm5JMGt6ZDQxRWt1QmwraEh5bFh2Y08wQ1NCaXFpY3I5NDI4T2FFcTha?=
 =?utf-8?B?TGhSenR2SzI4Zk9IZFhUT2dFTVpJZEs2alZUSzdqUGt3U0FXV3lnV1ZFczdj?=
 =?utf-8?B?M0pERlRmSzZWRllIbnQwaFdSaXpWZ1cweWRlSkcySG9OUmJSQ1FjK29SVkVG?=
 =?utf-8?B?WFZqZUFwQ0JIUkJ0RE9zb3RXOWc4WnZjdnFwbjBHeVVGV2RLNHlqbDFqSUQ1?=
 =?utf-8?B?UStzcXR6aldKMmh6b2tUTGVXaGljVG13K0dWb0JoMmFlQURIcTEzamwvaXY2?=
 =?utf-8?B?d1F5VkNhSHVzaWovTlpJTDRhQ05LYm9SZUZXV3lHTHZMTVVtTFlkT2ZzN3N5?=
 =?utf-8?B?Zm1sV2JXUDBWWng1bnRyd3ZFZC9VZU5vYXBWRFd5RElRQmRvZDZ4Mng4UDNs?=
 =?utf-8?B?WVc1R1JyTGZuUENNYlFMdWdwZWJDaWdycmRkbU5YTGt1SjB0WUNaV0E5eFRs?=
 =?utf-8?B?OHNlakhyZnhXaGxQNSthV2RPMTNvbDRxcHZheGl2Z3ZTWWNkSDI2NGNtNWR0?=
 =?utf-8?B?QXZMQU9wMU9CcjZWTTdDMGVBd25TTkdCQkFsRVdBOXV1bTRHcFNhRXdTVnk2?=
 =?utf-8?B?UzFUbXQ1WVQ2VVR2QmxmcUJYRjdmem5NcldvekN5VU5iYmV4b2hJU1lpTXRl?=
 =?utf-8?B?YmFoOUQrMDQzMFRjSTNjNWRNak9WMFB6c1dQUjBoMVhmeUpLVkJrdERwV3Ex?=
 =?utf-8?B?MkU0ZVViaFZFNDBqYmljUUZaOEZRTVg3TG1DeU5JOGtwdDVyMWdWSHlxRDRh?=
 =?utf-8?B?TXZaOW9OdnUzRUpqOUhNZlZXTEJxYlZ5ZzFoSmFDV3ZDb0xjZE1GSzhHc2tv?=
 =?utf-8?B?TVZYbU40QnNuVUFzMWNxTW5XSUVNcElHMm9OOEdyMkVyb0IreWpiSVhGS1ln?=
 =?utf-8?B?MHlTY2FESzhZK1BMRFFQZ2JOOVNqTWFVWUp2UUl4c1h1UTJJK3h3bG1DblA0?=
 =?utf-8?B?aElhWHpWWFBuVm1XR2pGYjA3dnovbEJTZVMxVWdqeVplUDJ0SS9MOWdOU21H?=
 =?utf-8?B?OFM5K1NnSXZpdTE1azAzdzhpaU9RNGc0Zmt4UmFJZ1VsK1EzMUd2NmQ3T0hx?=
 =?utf-8?B?ZTBzL3B3RURWdUl1UUxBd2taZW1ocGhLNC94cGEvVDVOQWRSYWNYMGY0SzRr?=
 =?utf-8?B?bnd2ekhlTzk4RFlDZGI5SFNnU3Q4NlM1cUgvdzkwZDJiK053cTFOV0x1SlZS?=
 =?utf-8?B?c3paUFBsZ1FxTEd1SWFUc0p6aDVCaUFiSDFYZ2dSdi9rVk01eWU4dzZmU1gx?=
 =?utf-8?B?YzNIa2ZDN0hGQ1htKzZKTTNZOW1Xd0t5QVZib29pQVpsSXNmaysxTjJZc2sy?=
 =?utf-8?B?Tk5kVlJKeEt5RDh1YU8yTWprd0pGb0cwN2lvdkdVOTFvK3MvcjhLb0RNUzZm?=
 =?utf-8?B?OWdwbmQ3QklnQ2FMaGRwMy9WNDB0bDB0dkdFYWtvNlVUN2VjZFdISmNBenRV?=
 =?utf-8?B?L2FwcGlTWkpGRTdiZGc2OUdlZU1XVFJFV0FIZGVTMWVzRkZKNXZTRWthOUlo?=
 =?utf-8?B?NmwyZ3Mwakw4Uy9ObnpNS0VGd1poNmQzRnNqRVBDVjJkaHVkYnV2cHdXOGpo?=
 =?utf-8?B?aDNJR29sOE5iSHhnMUxCaEdjZXMrMlFETmJoYWJBSG56ZGIwYXFZT1h1Zysr?=
 =?utf-8?B?NjNzK2hqeEhRWUNvOU0rQWUwUEUwT0tmcVdRRHRMOUFWUGpxTFFqajdva1Ru?=
 =?utf-8?B?YWNLWWpRVDBsZXh3N1g2YjFBS004eGJjRCtwSi9OZFBEaGFzeEpoOUpkYXR0?=
 =?utf-8?B?QWRESE55VzJiblA2cmN0QXRpYlEwZEI3TWZOeXoxU09pWXlhUTRZN0VHdFYz?=
 =?utf-8?Q?URus9W9zM86DK/bEtrjTtMFOj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d412cf8a-112c-4ed9-6a45-08dd8640d8f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:43.4497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M35uvWRyVm6zE+y2dEqHC5432IwRlfM2fwnC5Yhpkl7F41vFL8tLyjP/lGNyP5mfD+FjIy45N8YQOC2bELvAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Peng Fan <peng.fan@nxp.com>

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad440..06de4a601f8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.43.0

