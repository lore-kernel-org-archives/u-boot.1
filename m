Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A7ACA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF35E80EC1;
	Mon, 28 Sep 2026 17:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmbdQL3xQdIN; Mon, 28 Sep 2026 17:04:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 406F480EC6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615094;
	b=Ueu0uhkNEgMsDVEv6eraonir5rKaegoc5Gfrj7hXiSK/lDcwDfbuz2wWw7Fx2x4fl2gK
	 v+cs0I54C76fwNiOk7xpDKLuARmYV2574RWjYjH321tWMbhvOCwPIOU8aPaimoMjtDzls
	 jIJ1fVaxEbx0Mre3HjWrOmErO1G+6idvllqLzHaMTZmw9kfslxTTG/e9fK3mwpJS0W0R8
	 HAZBUa2drK2XM9yzxXmTZyOxWVu0q+F/0yrr6+TlLPVVKVNwlT0kO1yJcguwezHsEeIat
	 ikGoQS1LhZmIUZteit1uG0VnvnlGEEuSRXSZm4fB3MiZsoLuS/SmlHoYt/dcSh4683Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KjwQLrD/vsFdm3hwxZEl6QpsuQ4csMglk5oJV8dMWeE=;
	b=ExbYcp6jrWAny9qZrb0/Ix1nzk73LyyryYVza3OT7ripaIJf1L5XE9j299WXYInO/E5Z
	 cKlyEwP9nsTiYGL8aXTHceWnSvj2oPs5nr7Sx6GTP4nTsHue7v7X7fL9ioaJvr46Y+x/r
	 Vp6FtEb0Z5SGFTHZBohje44IfTfy2NX7BXTZemvVTntMpdQcQeIFgH2Gpg6uKyH3DWnQ4
	 7B4dDR+xPAcfCu/Kpye91S7obFQ3QjFvSlwz8nhy0NDeRFB4cdQK/AK3U2K4TuAoge5jZ
	 lwwRj23aVHKo/mUpHyMTFWLE67BvkKFsCjEZXODE6o8PB3K6mOV1bh/B6bIJ/v/TE3Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615094;
	bh=KjwQLrD/vsFdm3hwxZEl6QpsuQ4csMglk5oJV8dMWeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rPuKMCHMc3KCq7ni1KXy6qEMzkKzWffRogmNYd3Qz5eGFIjR58cp1fApkQSVrZGeL
	 vVcVyb5pVD2OI10ZJaT8uyyu+EPi7R99qOkA+3yePkZ8Yq6YU7Cq56N/yJGxsyTPSg
	 dLUkz8ed+yzN5zg31yO1wVlNYlLJLhDpqVSNWhVA3ZImreLcxNooj0PVEmISw43XF0
	 0aS7luMvXtJ8Cz/gXQCpANdAGjfZ4KC4/qJFlZPPgCmXZgnOdmm69fKzQXl9RIOOYH
	 laNH32CXcl5iqAkIVGAC9+R4d9G3INgx76e6b2ZE5KwHGXNIHi1QCF2BBWaXOmMwqi
	 tem9ugknJz/Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 406F480EC6;
	Mon, 28 Sep 2026 17:04:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 920C332F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C448606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwb7paadDiJ7 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:14:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6045606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608471;
 b=o7qAhj0Cx42/Z6y4i8JJM/mtyHixuqfz7dEfaHPAiSX2GGqBlZe/iE3d49Cy/yjOp2re
 40cmtWQzzPcMqyoBQN7N1u15K0C9XtJO5SzbXWo+p2n/TP/MdLn+EJJ+/z2VQSgDpGYHT
 fQmroeYORLZ5cdHXQDBnH9GzRTCTkY6hHZRD9i97IijnoEV5KuYRXhfhF/n9X89pFt3cu
 eXH1glO8L9Ajb+fajQU27RNVVVnxgBemqhsqkbH502cC8Y9ZudMQ6VLHi+Q4pqihHoBh4
 Lz0eLSNL8zWdmDqyqzS0eAIFkal5TSsvGXpeG8zdb0daTthPUXbwcWMPxPB3FOTp0+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608471;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=KjwQLrD/vsFdm3hwxZEl6QpsuQ4csMglk5oJV8dMWeE=;
 b=qlj6AOSQYa9vrCVB2AEuqQ1cL6lTQ4WFujS+2bBil79Cm+9vCALPDVRtHYqDYDqRrO0G
 MVSk9F5izrv/ZCi9g2L6XMRyc5ulPlDP268oZGfkSEL+UenT6+lH1l9Rpl+ujDfiTQbWC
 XtJnDfw+PKYm10ggTrqYj98SUO9aNrlvYqkchil7CqhdhgjkZII8eB1+x7cy5EnpSPqln
 eMg+qWCg49qwAABkk2pQw1kYHuNnhzdt0wLj1NdeY0CDuEp9YiT+nYV859i1SsWaFUlgV
 lC/lpKzcMBYBSWsHB1ywn+sCVtun+p/B4FcHzBPQ2SObD7vIOPIfIIwn5qZ0bs2XbgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FvFeQ272; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FvFeQ272
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6045606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wank1XtzNR+rHYGGaNlIv24w7TC+7SLMuBSXnsKeotypcUNCjqbJsiLUE8licVSEN9OXJ4pSjU9Ob0G7bTeRNQfDJX+u88GEYqQUk3hr6JunHor5otIm1sySbDFoMXCyJk+udV5qtL9acZLjT9Ggsu5D5III/YMflz5Wm21dLX5zNK6ntiLaQx6xcd2Z27BtyxIIj2ydZFeIeXsbIC7ki92JhSqXjfWX4jLe+S3gQSKKpWMA1CSM8+X+QOWPQ8hC/fxu5wVRTtH34PrU0AUzcCF4va3FWOGXkw6WyyOR/1Azi3IYCBA979lKATuDGxbPyRQoHBbtwNQMqYGBIN3vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjwQLrD/vsFdm3hwxZEl6QpsuQ4csMglk5oJV8dMWeE=;
 b=megbf/E9wHMOI7va/FxtYu/WNCn3DrFHOkGfyKYfUgvaLZNuck0nWOKLalS08t0jDi3xand9+HxfAuCcNAz1tF0lgzFsO8yU0cyHAIcpI0h0LYyIU2zQ/7W1dwDNDm0me4hYfMwlUmRnR0RgU0VNpsbdO6V5QAo82PXtq+eCmvdax5RygaCn5Fc277PPI5KpnOZ9uVplHS44nZUzfuXFYzeeTtJamzmGeNYeoVZhp0S/pqC935abgJ9UBB50oOSLkJT8vXB1Ot2EoqiOtzbPVJ81Ih0XTzwDryKY5oTblqz4M3beFvMCzu8xzT2DJEAkslkhGgomXUX6WCpf/ywTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjwQLrD/vsFdm3hwxZEl6QpsuQ4csMglk5oJV8dMWeE=;
 b=FvFeQ272V93ZJZuMessMBqbgeQw21VLXPDCHBN9n8on7AbefQCfCL9LnwP0K2OYdt1chv0oA67WSs/eBzJvZ+7kAVc6WqrkgF09px8yWXyalDoZs5Ba43MyB20gPltdeQDNfYG1LrjVj/0a7gsmaGOHdlgtWGx4l2fgkUFEsTNs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:14:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:14:19 +0000
Message-ID: <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
Date: Mon, 28 Sep 2026 17:14:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f3c121-08b1-4b14-8956-08df1d732b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|4143699003|5023799004|10067099003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: dO1nteVphFPe4XliNM870xsZ9ApjIoXINxW40Bz2oOamr9pnIrZu5ygeGlMZDpIiIDbCupUWI5fBMciq6VRN+uaafJsCDAGx6m0wyBYXA0RXSTb2v4bZpztJTeQJeghIgx7QF2UnrQps2ud5gg4kkS4GpHsz3Hgg4Sg0YKoC8JzrSaVP5CtbReK2jTp9aPItlfxJNbNmBYUKP2qoeKQ23+LMlRdIyOeLCW6zmRoHuviCQl5VeolCQ91YyDFYq8f1LoQDXG90nzSRE9wweKAEyrlqYis6FLfrZtC+2TVT0YFIsWdLs/1alILrvu1rz6LliE+tqCJT90w7zXYSJC1WWtr5hqAAeDRh50FzcAwxJ9Oz+ZGBrKihuZLkBrfyguI8EoR7Ftdf2YGL+rhMRzhensLHOcP9TTm188/azef4x5bxxSz7O98ESHnyx51J0ShxZOTo2dtNYPTLNml83wI22GyxHJtj7nBMOY0x+t02iR7EDembs+F4c1wcpxAIqWBTD4/AchOJNh1bQAHGPMigPYxftfGMJ+eODSgbsxuZ4MMfbotPIk/pqe0qESkWwD6me+UKds2HLxwnMex9BNHtNevslUXtwAApPOvVgnnRNRxe0nH/K4VketA+g+jhfrxN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(4143699003)(5023799004)(10067099003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZkTzF1c0lYNzZtdlVVVURxTFBoREVESEtmSm1RTzlLbFczYXVxbzVKa1FJ?=
 =?utf-8?B?RG9NdVdzdEV5WVo4NmYrcGUxUnJPK1ByaExoaHJpQU5RWXFtaXJLSlNUc0FM?=
 =?utf-8?B?ZW0wc2U5MlNPUGYwem9RWXBXdmhXVW1PWTJ0OWptWmx3cG1LVFNxdUcrL3cv?=
 =?utf-8?B?a1hIcWhXbmRhRlRLa3FCTFdycE9UR080WDlxL2NHelhaUGtXY0x6RHpSNXlo?=
 =?utf-8?B?bnMvd2FhOVN5WHNOUDFXdGMyUE0xN0ttMmZQRmhWTnRLZUdTRGprVU1mc0Nh?=
 =?utf-8?B?ZG42eHMrRHFmaW1iRGc2UFNEenZyTmJ4WjRtdzV6ellBVkNWa1pEbXI5MFJP?=
 =?utf-8?B?YWUzTU9WSXVQQjBLQ3dDN0dUeFBWbDVIMlNEanBIdFZMRXFwSmZHZkp1ZDIv?=
 =?utf-8?B?bDNmcHdNLzRkUjY3dDlrRENqbTZoN013emVUOEtlaXdibmcwc3BDZHo3a2NR?=
 =?utf-8?B?TzllWXpOTC8vSFl4ZlVQYWNQKy9uTTJVcnpKMkhoWkNoZEM1bjREamo3UEZt?=
 =?utf-8?B?Qll4VlJlVnlCYTNvY1RKNEdnL3RBZ3RrVFF4cmwwSnVPdmFBOUNzaEZKbUVD?=
 =?utf-8?B?QVpjd3VnMmJheGVHM3h2OHg4ZDlNempUaGU2aHlwVWJzM3UrZUlHVWdlS1hj?=
 =?utf-8?B?WGxkYldIQllCUXpCMk9FOFdmQTA1L3JxTEhUcFA0U0VsTktGSXZFcXM0OVVi?=
 =?utf-8?B?RWtteWhOTVVZTjNGWGFReWd5NXZHc1NwZ2U3ZXorZFllWUFCdDBMNHV4cWM3?=
 =?utf-8?B?Q2R3SVRkQnNqL0F5NXdmU250aEoyMVR2aTdBZjcvUzR1UjBhSGxBM2IvdlFP?=
 =?utf-8?B?RVB2UFNvWlRGcnZoZjRZbzJwNHF5SGg5UHRBSTU1YWJQQ29PNGVYOHh4Tkdk?=
 =?utf-8?B?ZDRKTEhlNDd2QXJrVGVDc09ZQi9sdVNWOTZXNGdzeDkrb3VBeTBTL2hRYkRn?=
 =?utf-8?B?a0swV2c1WEp1TnlTaWtDSXN0RE5Rcko1YndmU1dzengvcm10Tk01Rkx5Y0ht?=
 =?utf-8?B?SWpaY29KeVdhYzB5Um5DREg1eFozMEdpMUdpQTM5TUJDTlkvbnV3b0xJN010?=
 =?utf-8?B?aHd6cE5jYWpmYnp2Rlg1emQrOUJXRUxHQ0p6TmMvNTBMQ3BuNlV0NXVlZE1D?=
 =?utf-8?B?MldwcklBK2ttUTdkZ3RFbk9aYTM3QytSTm8wUHJhaXFsblA4U2FnaU03d1hR?=
 =?utf-8?B?RFFQcnNnVWp3NVZHcVRBQUsxRENuMSttQU5qd052WVZ3RFhMN3RMV0IzQWky?=
 =?utf-8?B?bFJqcU9La3owUWFCNkpJNmhsUWovQUxkY1RFZk5QcllUb29Sa2d5YVVNQUEr?=
 =?utf-8?B?cjFvZXdMd2xFR1NwY1hHQUIreE1WdU5rUkNkbGJvSm43UWMrL3c3cVl0VDhn?=
 =?utf-8?B?R2EycDk2TllsdDE4S280bmY1STBsZ2hBYUswWWNwUCsvUU1PdFgwRmF3ejhU?=
 =?utf-8?B?aGJ3dHFEQ0VRU2JxMjZrRC9Ea2kzUTBoOFp5SkdDdll0ZmUyeURydzRsMjFz?=
 =?utf-8?B?WGs1ZUJRd0tMK25DaEl2ZmMyMzJKU2o2QzBURGdjTk85WlY0bHFuQXc2VjJm?=
 =?utf-8?B?OC9KcFpxaWRQOSs5YllhNG5mR0Jtbkp1eDJWSWU1OUUxYVpSNXRXV2JLK0pC?=
 =?utf-8?B?Y2dWTDdkTW9KbU1KbGlIYVo0SHU1dlAyc1BuUG9XWlVDaDFBb012dVpIQ1FS?=
 =?utf-8?B?Y3l4dENFcVNwaldERkJqb3R5ZWZZNzJkTFFnQms3dTVEQ2IydVBNUW0zdlZD?=
 =?utf-8?B?V1Z6ZERvV1VabW52bitaS0dvOUhJNi9VVnB5L2QzT3VKbTV1cEtvY3liZDdl?=
 =?utf-8?B?WitMMW9CcVNNUkNSam41Uys3UzFKTUg4cndPMFZobmVKNE1yMlVwYWk5elgw?=
 =?utf-8?B?eGRkK0Y4YlFab3loUXdnUTZzNDU1QVpvOXFzVVcvZGR6NGZJcFQxWlVHdVVV?=
 =?utf-8?B?MlVJcFNKQkgvdDRSdUdWZ2ZVcjFoYUpIR3puN3ZZb1FPdUlRYXd2QmdrYW9S?=
 =?utf-8?B?S0dibUZ3TEJNTVdjOWFhdHhhVVM1NjhOMlhnSEgvQVlYbU95WVAyVnhVZEpl?=
 =?utf-8?B?ZjErb1cyVFJ5bEtGUmFzVXN1dXhRS05TSHdyS2Nwb1FnbkpuL1BkeTMydkNB?=
 =?utf-8?B?MS9NRVgrYVpKRWx0Y0lXUXdJNUViK3lQUnVFMU51bjFXUWIzWGZlS1IyRnBa?=
 =?utf-8?B?NlZPWVdtek1JOTN1QkxyN0VRNXRHb1AzOVRpVjFkNC9lTlg5VWVjSlVMN1JE?=
 =?utf-8?B?QUZsak5zMlJuN1d1NThQdHNha0xRZEtNcTQ4cmpMSnBpR05DNFJ4ZmxJSXMr?=
 =?utf-8?B?TFRVaEwwK0N5bnhFSTcvdnZDcGtReUpvbXI0QUQyQ2VObVMraSthZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f3c121-08b1-4b14-8956-08df1d732b2f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:14:19.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJX7QYouKJo21So7/p2I53kRnqSaCKQ+BApzNpy9t6+jaaUc2EVI9HK4lT8oY0b+7Pg88rlHIp1gwZDBlt3mCnI7cBn5djnbrwRG6J+hcQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 7/31/26 7:10 PM, Alexey Charkov wrote:
> Modern Rockchip SoCs such as RK3576 require TF-A to be running to provide
> firmware services to the OS. To enable booting Linux in Falcon mode on
> such SoCs, add a binman template for generation of FIT images containing
> appropriately split TF-A and TEE binaries (as is currently done by binman
> for U-boot proper images), externally provided Linux kernel and optionally
> an initrd.
> 
> Any FDTs provided to the generator will be pre-patched with a /chosen
> node containing an initrd load address and size (if an initrd is provided)
> and a bootargs property containing the kernel command line (if provided),
> so that the kernel can be booted directly without external preprocessing.
> 
> A config fragment rockchip-falcon.config can be used to enable Falcon
> mode boot and the building of TF-A+Falcon with binman, e.g.:
> 
>    make nanopi-m5-rk3576_defconfig \
>          rockchip-falcon.config
> 
> This will produce a FIT image u-boot-rockchip-falcon.itb containing TF-A,
> TEE, Linux kernel and optionally an initrd, which can be flashed to UFS
> and booted in Falcon mode.
> 
> This can also be combined with the existing rockchip-ramboot.config
> fragment to obtain images suitable for booting from RAM, e.g.:
> 
>    make nanopi-m5-rk3576_defconfig \
>          rockchip-falcon.config \
>          rockchip-ramboot.config
> 
> The resulting images can be uploaded directly to RAM via Maskrom with no
> storage or USB loader required, e.g.:
> 
>    rockusb download-sram u-boot-rockchip-usb471.bin
>    rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
> 

I'm sorry but I don't see the benefit for U-Boot to have this complexity in.

I already find arch/arm/dts/rockchip-u-boot.dtsi difficult to parse, and 
this is not helping.

Moreover, this has almost nothing to do with U-Boot, except:
a) it uses U-Boot device trees,
b) it concatenates SPL with the Falcon FIT,

a) You should likely use the kernel Device Tree instead. Even though we 
sync regularly, we still add our own stuff and may lag behind. The 
Device Tree used for the kernel doesn't have to be linked to a given 
version of U-Boot.

b) You can simply generate this image ad-hoc with a simple cat (taking 
into account padding). Also, this doesn't take into account boards for 
which there's only an SPL, in which case 0x471 binary should be SPL and 
not TPL. While that is already an issue with the current code (which 
would generate an empty 0x471 as far as I understood), it doesn't 
improve the situation. I'm worried about the increased test matrix 
needed for this, how do we actually make sure this still works and we 
don't regress? We would need a gold kernel binary and initrd on a 
supported board and test that.

Honestly, all those concerns could be alleviated if we had binman as an 
external (to U-Boot) tool, then I wouldn't need to care about what you 
do with it. There was some discussions about which tools to move out of 
U-Boot's scope and we started with patman but binman was also on the 
table. Neha Malcom Francis suggested it could be useful to other 
projects, c.f. 
https://lore.kernel.org/u-boot/f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com/

I've provided one additional review below that may be useful for the 
other patches.

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi     | 204 ++++++++++++++++++++++++++++------
>   arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
>   board/rockchip/rockchip-falcon.config |   3 +
>   3 files changed, 225 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 4ba6a87e78ab..5e23ff761751 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
[...]
> +	fit_falcon_template: template-falcon {
[...]
> +			ramdisk {
> +				description = "ramdisk";
> +				type = "ramdisk";
> +				arch = FIT_ARCH;
> +				compression = "none";
> +				load = <FALCON_INITRD_LOAD>;
> +
> +				linux-initrd {
> +					optional;
> +				};
> +#ifdef FIT_HASH_ALGO
> +				hash {
> +					algo = FIT_HASH_ALGO;
> +				};
> +#endif
> +			};
> +
> +			@fdt-SEQ {
> +				description = "fdt-NAME";
> +				type = "flat_dt";
> +				arch = FIT_ARCH;
> +				compression = "none";
> +				load = <FALCON_FDT_LOAD>;
> +#ifdef CONFIG_USE_BOOTARGS
> +				fit,bootargs = CONFIG_BOOTARGS;
> +#endif
> +				fit,initrd = "ramdisk";

I've just had an idea now but can't we use &ramdisk here? This would 
avoid issues of typos between the property value and the node name? of 
course we would need a phandle for it (ramdisk: ramdisk) or use the full 
path (&{/binman/simple-bin-usb472-falcon/payload/u-boot-any/fit/ramdisk} 
(and the other one, as we cannot declare a phandle inside a template if 
the template is instantiated twice like here). But again, I don't think 
this is a good idea, I think we should rather do runtime fixup of the 
FDT based on an initrd property in the configuration node.

Cheers,
Quentin
