Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68180CA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2434480DA1;
	Tue,  6 Oct 2026 13:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7T1D_V-TOvrp; Tue,  6 Oct 2026 13:00:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 610CF80D29
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791291631;
	b=iWP96oQiTPaTSHYJTTGzX4QpKBzspmOM+ODnmj/kYYy5L50J3JjNiY5/ErlweaeiRqAj
	 i8Iu0zrSigwE/5fZG2HvryqOOH8Pp2Wo4q8GPaO7K3fN923DHIMNDKLaIo3Vg0FLcRyy0
	 MWnNGfft69IYPQ5TWJvVJZvGI2NiYzBoC5qbVhNr8/XzBtzImya/vr6LPj7CSXKvyZhLw
	 fI031alunpVm9G3MzP+LaI9JEU7x58wotnuofEuM+SW0muRmWjmy7lec17J7gM/wtoYdu
	 ytt40EY+HrUNrDsIPrYNgiiKnpdmotFqmIuR7sGH+Jp3oaEIBDhd82LCLNUnb/Xg5bA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=qD3WqD6zFJX/5c0bQZYai8mtdXmB68u0VAhRiH2uw6M=;
	b=UX65i07I4mJ2uGv0ouweGF6p+TycwPGhNpMwFQi9uQcinPV4GLIy32lMnlddwLK+TLP2
	 PxXUCySkepxRyr43x/Y1nw5G5fDlDfXmEJ8EOzse7+/jlGkrV0fyV/3ax+NTWrj/zgK4P
	 eb+QropbObnnDeXOPt8VNXHGh9mn6l448td0I2KL4VSNJKjvsRSQerOyA9tohdmbnZw6X
	 TH3pJrcSJWCGSxt9C1pMKCIEclqxlJm4rVyoH6jnEabF4xr9WpdyXL82uYjQ6lKRvW/tH
	 mJSWdYST8FyUQxx0zBRwgnynGqMCHNN8GllG56UrlhvDUYwTeGCaWCTJPTzqSdqB17Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291631;
	bh=qD3WqD6zFJX/5c0bQZYai8mtdXmB68u0VAhRiH2uw6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oj65HD+ybOilDwfRsoMBTPsdwvv6aMaLoLgI2QtEK9utn7845scM8kRgxX9iTO8tP
	 MFi17ak35OwtSz5+m5dMgtO1+tDjJbHjQu/DoTQaaDXEf534d4z2eh8GcWBNJEh983
	 y0dyaHCUr81KhWgDZA4q4rwGF716Ns10V3V4N0WyvM3VIEnyz8NnIimbLowqurwUDR
	 DIFXOtr2UH3TkRkRHtpWJyUJRtUActFZHsGVLreIBEivxmgJR2AhC3ZV6ZhnQR2fhE
	 LTHOgamBfJSnnM8Louy+/8cnQIiL9IK+V6B+GyzvNu6WWxvzcQijnkn5YI40ZRipdS
	 KlcOoerFKUAEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 610CF80D29;
	Tue,  6 Oct 2026 13:00:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EF042E0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1435040553
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wO5PQU4RBaIy for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 09:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA6444053D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791278934;
 b=ZSVdKqs9o8F54RUWBpPcwCnHVYzvOGYML5GDH6q90ZdFMWaXeWNXeq6Wn9IhyGG0CMN2
 eRBkxd4VQKSQw2o7PESSLCkWTN2D8+Q2N5ZXbTbfBXt5GLedao7v9B5Pi3hGGB7Oz7kXM
 DZat8JA7VhXCP5URZhLONBNY5PrlhDIRgWsp4ubkJ9ib8HzxvixMTf+RGQYWdqJniRmEQ
 npKZ1W0g1zYsR0H4WwmLqQ1ARjHEHvbIxlCMFoja+wLjW04tlgxq81SrBaVTmlNsXUtAP
 1IxVFZTULuQaxGIDmJNdKdkG6huU/pVRzkbqZv0RuTI6txFWCLLr2JyTVlzr2wOvzTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791278934;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qD3WqD6zFJX/5c0bQZYai8mtdXmB68u0VAhRiH2uw6M=;
 b=UIhOgJvILcaFudWkemF4ptw7F7OrOZPivTNVQ5UlztEnR1nx5ZO3XjrAqcyEj1dnE4rc
 4J5l5lWV7qE0SBYWiWXym3L1CBJLZS2xOHVa651A2Vn19eFKweCFL9iub/SHlILbzphdC
 H2M4cbCv1E3sRo890TvvHF8Bf7NCt915GB+QDdS6HYM/n3sDuY36WgwsW/4Q17YgzmMXE
 hBdSY1zixVJcujxsc3fGj4CflD4mCWy9EkOlc17rcx3iROHHtE8yZ1hXhFho68T/y5VZ9
 ov+4MMH3MT2xOxQKshMDOxRncO/XOeq/f5tBuuHCGcNzbuD0rzt+fUntPrY4ODH57yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=emteria.com; 
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b="s3ebBR/u"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=s3ebBR/u
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA6444053D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocxaaoVceZGvkPNm1eRnNM2h16baOlY0lhgMvH3ljVWsa8SeV7cJqDTHvsy2SeiM5SaB0ITFuVwa+XQ4/qongZXb6KaXesZen3tGRKoLD775Skiysx6e3o7PvQ2V6tQe5glHiJZ/s3XZ2hVbPgw/tBgOKVPcZv/BtUdsK6BK+RpSbMtOSuGLx+F3KEiOHph5lVVhFrC4CSwHjpaoW8UZZIRdQGFP1xsj8kimy0vNoyRnNz1rqnHqzzUFYhx/fvME30iE6FBm+ZcXXod+51acQQzA5PVulAv5mswPrDfUBrYNv4H6LHhxDstlfiFUcv2y8NdOk8o4i4b3oUjEM/3VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD3WqD6zFJX/5c0bQZYai8mtdXmB68u0VAhRiH2uw6M=;
 b=AqCcV7/VK2si2cJPBvMZiQNGGFw3VnLhoHe33+Mq9brlOVlfLV343JPggzmnUJp5czxa579ZAcD2aREQjOgCMSoALDieh1k5kL5qMXOlAZNqjfdt+c0h09kKtiDuNdoaz9pYtVDWr81Fcz1z887YbZY0nc+VI+IgG303h1Ga1nM5cCnTvJSFqCk5965CdwkPoNNhLMqRY3HgM+gA8uKWKzqHaiwbC2AewmO9xifZtLVvEZVKK3yxMjpVJVDBwuCijkCO2anpMy86Rpyqq3EImo24vfz6XzsngnIIYV51YDX2qwjTG8m2z2yMqFMpOtbdUDPXyp73W2SeabCWggsonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD3WqD6zFJX/5c0bQZYai8mtdXmB68u0VAhRiH2uw6M=;
 b=s3ebBR/uLaYdEDNIik0YFxlVico4IAaB06pD+IR8bCxfMx1dTI3YuGrL32C8ghByeI3hFdISEA4OSlTJ60zLVWISABgt3Ef2M/u1l1cboxhPx4RtTPWjP3mjjOZEpZ4mhxL7p+tJJ4OVJUNJ5NDa8WeQmP5xX768k0rBkVF5ENc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by VI0PR04MB12007.eurprd04.prod.outlook.com (2603:10a6:800:314::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Tue, 6 Oct
 2026 09:28:49 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:28:49 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v2 2/2] avb: Take a storage interface in the AVB operations
Date: Tue,  6 Oct 2026 11:27:31 +0200
Message-ID: <20261006092732.3577974-3-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|VI0PR04MB12007:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a4d5c7-996b-424d-aff7-08df238c3a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|10067099003|56012099006|5023799004|3023799007|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aiMZJGe7joG+9smUZ0ptIyFE3Uuxa1VL65ZNoDQlSCv7Zv0DvkfwtmSmPad+3Lpgj9NgyKoBHhrR03bARLX1Y7ay4VglIvdh1DRHLzSIrIC+I5+Z5N+LC9+coJVjtDntCyXXEXgppOR9rorbpVxYIcJLXxNFvKOSrlFz+cXmyE72p3TOFFE1KgU4giOIPBFKrFocz5LTynSaxEy1UQjLIIkZwyUDvAuiMaDpqhwyLYYgW0bOceC/3Pzy4Ehx5dch7wOoujANq7Z7rdRoDQbVWCyfOEGtgTpLsqmdJ+UDiYDOe5EEmZHZBxVQ2tQwCxI0dHOIKSfaL+yDPaM7+22sxuS35iqO79Lav/LfqeV4IxioELF4M0hySpGf4ZihdbqrS6SdXF2qVf4u6PlNZXAuXxBOqllKhzkNDWZ2T9UIUnCBdIFJn9mNmzPN/4FQuvVE8ki7UTZifFP1EAVeqB4+RuIqEanUArmjo7ZwujykXIQEtCGLSxlb8oE/s9WVqiuranZcD+QbXs7iyw/ZE3ch6jAIh9j7ZAYCZi6LAlh9fJOT1MluR46CqURSBJ1QjrfF4KqHO+u4e2wXJS1JayeDvdMmvrWIs0ObziHvM/z/4qTZ1IKZqMgLtnnBo3I9sYpJdo2OrzGgdlsFbCWfBo8OmGLXwJ1v7sPhU4+yqBeaGYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(10067099003)(56012099006)(5023799004)(3023799007)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?msN6T3isoq0ctIReezsxhbySrK18kvFx845KFSt4ytKp+UXEv6vhgawRziAI?=
 =?us-ascii?Q?cBvN+MyRG7+UOvk9FS+XWYxSLMHr/UCAibsmRL3GH+4INUIdy4PyT+xT0FpL?=
 =?us-ascii?Q?mw4FIWvslisdV2OXj83IxIzPCmlcUjNP0z569gTv/N00ADpP/0ae97/PPzTF?=
 =?us-ascii?Q?nPBf/bhiSeAuXKXxKykufxt2veaulX5n9j7jSv2UXh+hU74/jDgQXErMdc/o?=
 =?us-ascii?Q?kmghf66Ble34EtA9Tfcki2XxMlYPjLQgKqA6PJA8JOHDV7/XQ+rIRxPHntMv?=
 =?us-ascii?Q?djhIPYvF7C98P26FnO37hdhtOZWAOY7WbtP/pAUev41yJA9Aj4njTfvtySy5?=
 =?us-ascii?Q?qCXgEqXNbQZFZTrfnKj0dTIq5asytCBAA7Cq5W5qq6O8sGagg2l8O8eWsmPr?=
 =?us-ascii?Q?45KNeSavrZ+2lwRNA9WOg6e7s0oOR62yH8A6jiwEjkVZz5i9RZEwbAO+f0FR?=
 =?us-ascii?Q?9riM7wEcUI/RrZg9Y1P4I8HwwtBCA6Wc6xEgwQWkaBDuTkfxJwYznsRbxzfo?=
 =?us-ascii?Q?BclMI12rAlAPIPhOJJ0k/GjgcWBdY2Ivr7/Rhz8OitWijl6VSFSzVi8a7NrQ?=
 =?us-ascii?Q?23npYQPJXSBM/cSe+dJml5Dzbk4FudUV+Sv3Qasd6OvdpOWsmupyliCnFXCg?=
 =?us-ascii?Q?i9zQTDyUDaSO4dkPoF27o6qUnS1n593f3Vkni4vdCEGLSVJAnGS4ja+ylsbe?=
 =?us-ascii?Q?v68Q5EFbZQlLpQ0kA8zm6lnj4MUd+FtGyqmLVOevRXsnlrp6lovzjoRHJj5G?=
 =?us-ascii?Q?jPkymPB1vt6JXFYNs5TfloXDiK/VlOUwCRLKYXN8smPwcaaGnrZnC2mg3kbI?=
 =?us-ascii?Q?TPBwTTwhkNcK6SUuN3z478tqr3PIxbE/Qf05R+Bu1YqFMn7XulIb4MrHwE7G?=
 =?us-ascii?Q?0YS+7r//MHITY7QsjdbTkqYhrC9Ir/Zarla8A44KIXLjuOvVZ8gVlNS6YDTc?=
 =?us-ascii?Q?zM3lbP43WimJfXA5D5WjLcVaAZ4p6XeSsUg7njoAPUsjwSrANRH52FLDWmHH?=
 =?us-ascii?Q?li1SGSc35F3rZO/cb2PraG/7opK0pRHo8/Z1vsG2abGIXh+P7rJWFsTCsech?=
 =?us-ascii?Q?Fpsm9dU9zKxzZhwMF4u+lK3lu9pSIUoq4mDRhab44cqVAbquV66HN2WUJp75?=
 =?us-ascii?Q?iFGS0szIgwuJ2/JMQsRiv4qVe2SNhetLYtzF/65bd/xY/2d0Am7sGNnUDqFr?=
 =?us-ascii?Q?WrnRNk2SVXlx3zT+T6eWxJLi0d3ewt4XIbuPH04SOFwKcwPZFQHsEEAAjYi4?=
 =?us-ascii?Q?Ebpyg1hu59+lnX6e8AS3+Vq6QIanmKuECrZvrr8c2LC8jsjPOOXrgrgjye4J?=
 =?us-ascii?Q?0wOY9BN427sEcrzR+nv1i+gZYOs2x4BHLcusxEFutdSG8Go9ZrB7zWpTxCft?=
 =?us-ascii?Q?cH4N9zUpAaE6JqaGGyekvTr6tZOgy5aXguczfFI8DW1tyX6AUAPIT9Unno4S?=
 =?us-ascii?Q?V2WRVxBiYBYBTzRZBqVsNARsBsx0ORDalhQIZeArTorpUXqzBv2tkvwcKAEA?=
 =?us-ascii?Q?J91fJZy5h09clABgahGqJ/qE6j2GHvROUIjQrt4YDogQxX5MxOyQ8HCs+vY5?=
 =?us-ascii?Q?xuPmqu7qJ65saN8MPWEJ5K0t/fg+dvUsfajOKySzM94NxH2JuZDofyyvRWoX?=
 =?us-ascii?Q?sU/hhCdpqMsf3Jt3Eia9z4g9H75hyS07H5AqCzN5Xw+n8tddsjc66KEPMK48?=
 =?us-ascii?Q?fGMF77VGqFaQHFtEkb7RhLSZOFrU/wbgAKSNOR6mp/ZHxUChiRMMTY+EBJep?=
 =?us-ascii?Q?0ZPHFXqLUZaVg2Yx1vJ3XgKOy0g5fmx8lZtm9/tAIqATxlGYiGEhLZXLNwzv?=
X-MS-Exchange-AntiSpam-MessageData-1: 6RoFfMtLwChuTA==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a4d5c7-996b-424d-aff7-08df238c3a6d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:28:49.3602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzVocv8+tBfOTJQkTgSdZxaNf3HFjS9+2uzuxidnEGt8MCfApqNTI4a0V1uY24SPxha9DtyZkJ5JJRfkMco+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12007
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
number and get_partition() called find_mmc_device(). bootmeth_android
accepts any bootdev but passes only desc->devnum, so an Android bootflow
found on nvme 0 or usb 0 is verified against mmc 0.

Carry a uclass id alongside the device number and resolve the block device
with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
partition switch on the mmc path only. "avb init <dev>" still means mmc,
"avb init <interface> <dev>" selects another bus, and both now look the
device up before allocating. get_boot_interface() returns UCLASS_INVALID
without ops, so a caller that skipped "avb init" fails rather than reading
mmc.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
---
Changes in v2:
- Split: the renames moved to the preceding patch
- Put the "avb init <dev>" comment on the branch it describes, by testing
  argc == 2 rather than argc == 3
- Drop the single-use part_num and move the user-area comment next to
  mmc_switch_part()

 boot/bootmeth_android.c                |  2 +-
 cmd/avb.c                              | 24 ++++++---
 common/Kconfig                         |  7 ++-
 common/avb_verify.c                    | 71 +++++++++++++++++---------
 doc/android/avb2.rst                   |  7 ++-
 include/avb_verify.h                   | 26 +++++++---
 test/py/tests/test_android/test_avb.py | 28 ++++++++++
 7 files changed, 127 insertions(+), 38 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 0db08d4f86..ae05c08488 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	bool unlocked = false;
 	int ret;
 
-	avb_ops = avb_ops_alloc(desc->devnum);
+	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
 
diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a..4c1f56a33a 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -16,17 +16,28 @@ static struct AvbOps *avb_ops;
 
 int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	unsigned long mmc_dev;
+	struct blk_desc *desc;
 
-	if (argc != 2)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-	mmc_dev = hextoul(argv[1], NULL);
+	/* "avb init <dev>" keeps its old meaning of mmc <dev> */
+	if (argc == 2)
+		desc = blk_get_devnum_by_uclass_id(UCLASS_MMC,
+						   hextoul(argv[1], NULL));
+	else
+		desc = blk_get_devnum_by_uclass_idname(argv[1],
+						       hextoul(argv[2], NULL));
+
+	if (!desc) {
+		printf("Can't find the requested device\n");
+		return CMD_RET_FAILURE;
+	}
 
 	if (avb_ops)
 		avb_ops_free(avb_ops);
 
-	avb_ops = avb_ops_alloc(mmc_dev);
+	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
 	if (avb_ops)
 		return CMD_RET_SUCCESS;
 	else
@@ -428,7 +439,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_avb[] = {
-	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
+	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
 	U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
 	U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""),
@@ -464,7 +475,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	avb, 29, 0, do_avb,
 	"Provides commands for testing Android Verified Boot 2.0 functionality",
-	"init <dev> - initialize avb2 for <dev>\n"
+	"init [<interface>] <dev> - initialize avb2 for hex <dev> on <interface>\n"
+	"    (mmc, nvme, usb, ...; defaults to mmc)\n"
 	"avb read_rb <num> - read rollback index at location <num>\n"
 	"avb write_rb <num> <rb> - write rollback index <rb> to <num>\n"
 	"avb is_unlocked - returns unlock status of the device\n"
diff --git a/common/Kconfig b/common/Kconfig
index c739225621..5590fbfdb2 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -885,9 +885,14 @@ config AVB_VERIFY
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
 	  * Helpers to process strings in order to build OS bootargs.
-	  * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
+	  * Helpers to access block devices, similar to
+	    drivers/fastboot/fb_mmc.c.
 	  * Helpers to alloc/init/free avb ops.
 
+	  Only mmc is initialised by AVB itself. Any other interface must
+	  already be enumerated when AVB runs, either by the board code or by
+	  a command such as "usb start".
+
 if AVB_VERIFY
 
 config AVB_BUF_ADDR
diff --git a/common/avb_verify.c b/common/avb_verify.c
index fc29433c3c..b898ebb78f 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <image.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <part.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
@@ -386,44 +387,68 @@ static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
 			  start, sectors, tmp_buf);
 }
 
-static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
+static int avb_init_mmc(int dev_num)
 {
+	struct mmc *mmc;
 	int ret;
-	u8 dev_num;
-	int part_num = 0;
-	struct avb_blk_part *part;
-	struct blk_desc *blk;
-
-	part = malloc(sizeof(struct avb_blk_part));
-	if (!part)
-		return NULL;
 
-	dev_num = get_boot_device(ops);
-	part->mmc = find_mmc_device(dev_num);
-	if (!part->mmc) {
+	mmc = find_mmc_device(dev_num);
+	if (!mmc) {
 		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
-		goto err;
+		return -ENODEV;
 	}
 
-	ret = mmc_init(part->mmc);
+	ret = mmc_init(mmc);
 	if (ret) {
 		printf("%s: MMC initialization failed, err = %d\n",
 		       __func__, ret);
-		goto err;
+		return ret;
 	}
 
-	if (IS_MMC(part->mmc)) {
-		ret = mmc_switch_part(part->mmc, part_num);
+	if (IS_MMC(mmc)) {
+		/* Select the user area, where the GPT and our images live */
+		ret = mmc_switch_part(mmc, 0);
 		if (ret) {
 			printf("%s: MMC part switch failed, err = %d\n",
 			       __func__, ret);
-			goto err;
+			return ret;
 		}
 	}
 
-	blk = mmc_get_blk_desc(part->mmc);
+	return 0;
+}
+
+static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
+{
+	enum uclass_id uclass_id;
+	struct avb_blk_part *part;
+	struct blk_desc *blk;
+	int dev_num;
+	int ret;
+
+	part = malloc(sizeof(struct avb_blk_part));
+	if (!part)
+		return NULL;
+
+	dev_num = get_boot_device(ops);
+	uclass_id = get_boot_interface(ops);
+	if (uclass_id == UCLASS_INVALID || dev_num < 0) {
+		printf("%s: no storage interface, run 'avb init' first\n",
+		       __func__);
+		goto err;
+	}
+
+	if (uclass_id == UCLASS_MMC) {
+		ret = avb_init_mmc(dev_num);
+		if (ret)
+			goto err;
+	}
+
+	blk = blk_get_devnum_by_uclass_id(uclass_id, dev_num);
 	if (!blk) {
-		printf("%s: failed to obtain block descriptor\n", __func__);
+		/* Every bus but mmc must already be started when AVB runs */
+		printf("%s: no %s device %d, is the bus started?\n", __func__,
+		       blk_get_uclass_name(uclass_id), dev_num);
 		goto err;
 	}
 
@@ -433,7 +458,6 @@ static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
 		goto err;
 	}
 
-	part->dev_num = dev_num;
 	part->blk = blk;
 
 	return part;
@@ -1111,7 +1135,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
  * AVB2.0 AvbOps alloc/initialisation/free
  * ============================================================================
  */
-AvbOps *avb_ops_alloc(int boot_device)
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 {
 	struct AvbOpsData *ops_data;
 
@@ -1134,7 +1158,8 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.read_persistent_value = read_persistent_value;
 #endif
 	ops_data->ops.get_size_of_partition = get_size_of_partition;
-	ops_data->mmc_dev = boot_device;
+	ops_data->uclass_id = uclass_id;
+	ops_data->dev_num = dev_num;
 
 	return &ops_data->ops;
 }
diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a514701241..cef49d3e0d 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -29,6 +29,10 @@ integration in ``common/avb_verify.c`` and the platform port under
 
 For additional details check [1]_.
 
+Only mmc is started by AVB itself. Any other interface must already be
+enumerated when AVB runs, either by the board code or by a command such as
+``usb start``, or the partition lookup fails.
+
 AVB using OP-TEE (optional)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -80,7 +84,8 @@ AVB 2.0 U-Boot shell commands
 Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
 different testing purposes::
 
-    avb init <dev> - initialize avb 2 for <dev>
+    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
+        <interface> (mmc, nvme, usb, ...; defaults to mmc)
     avb read_rb <num> - read rollback index at location <num>
     avb write_rb <num> <rb> - write rollback index <rb> to <num>
     avb is_unlocked - returns unlock status of the device
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 8c97adbfbf..6dbbb39a8a 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -7,8 +7,9 @@
 #define _AVB_VERIFY_H
 
 #include <../lib/libavb/libavb.h>
+#include <blk.h>
 #include <mapmem.h>
-#include <mmc.h>
+#include <part.h>
 
 #define AVB_MAX_ARGS			1024
 #define VERITY_TABLE_OPT_RESTART	"restart_on_corruption"
@@ -24,7 +25,8 @@ enum avb_boot_state {
 
 struct AvbOpsData {
 	struct AvbOps ops;
-	int mmc_dev;
+	enum uclass_id uclass_id;
+	int dev_num;
 	enum avb_boot_state boot_state;
 #ifdef CONFIG_OPTEE_TA_AVB
 	struct udevice *tee;
@@ -33,8 +35,6 @@ struct AvbOpsData {
 };
 
 struct avb_blk_part {
-	int dev_num;
-	struct mmc *mmc;
 	struct blk_desc *blk;
 	struct disk_partition info;
 };
@@ -44,7 +44,7 @@ enum avb_io_type {
 	AVB_IO_WRITE
 };
 
-AvbOps *avb_ops_alloc(int boot_device);
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
 void avb_ops_free(AvbOps *ops);
 
 /**
@@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
 	if (ops) {
 		data = ops->user_data;
 		if (data)
-			return data->mmc_dev;
+			return data->dev_num;
 	}
 
 	return -1;
 }
 
+/* Mirrors get_boot_device(): no ops means no interface, not a default one */
+static inline enum uclass_id get_boot_interface(AvbOps *ops)
+{
+	struct AvbOpsData *data;
+
+	if (ops) {
+		data = ops->user_data;
+		if (data)
+			return data->uclass_id;
+	}
+
+	return UCLASS_INVALID;
+}
+
 #endif /* _AVB_VERIFY_H */
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 137d83e1de..4c5b3c6f59 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
 
     response = ubman.run_command('avb read_pvalue test 12')
     assert response == 'Read 12 bytes, value = value_value'
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_avb_init_interface(ubman):
+    """Check that 'avb init' accepts an explicit interface
+    """
+
+    response = ubman.run_command('avb init mmc %s' % str(mmc_dev))
+    assert response == ''
+
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    assert response == ''
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+def test_avb_init_bad_device(ubman):
+    """Check that 'avb init' rejects a device that does not exist
+    """
+
+    response = ubman.run_command('avb init mmc ff')
+    assert response.find("Can't find the requested device") != -1
+
+    response = ubman.run_command('avb init ff')
+    assert response.find("Can't find the requested device") != -1
+
+    response = ubman.run_command('avb init nonsense 0')
+    assert response.find("Can't find the requested device") != -1
-- 
2.43.0

