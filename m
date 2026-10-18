Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BA3CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 21:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 634D7605FF;
	Sun, 18 Oct 2026 21:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7fBBfOuhLuK; Sun, 18 Oct 2026 21:34:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5DD960607
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792359295;
	b=A0yPak9sKXzbqTPNClIkov2MzJs1/s1vpV+mdsJygw6F2EFgONnUVSUxeH6LySDfWSVn
	 NnAhWYoSP0zK6+SavnZR0yFk1AksbA32Sb0MLucbXloLF/88Mqz9usUtD0InQvlP2ZEs7
	 aaNFxVhZWzOMov6+laCfDtTaozv1dfKaXnoOuF85A5hb5HtAOxZoc7I4HpLIBcBab81Qb
	 gm7IcKI66swA2PCcdt9zNiTD3Jtgx59wJ6QYOG4BZP7HbKkpqDLmLhq3A4gq3HBG3ExIz
	 twPa4btjbyDAFUzFI3JA858zeWJ67uM70cFhmbYtLCxILwaVo+JWztK8mjxksRzqu7Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792359295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8QOV8TZT2aLLqNPr3q7qwuDkRjPnEKRa8xpGAQwjsUA=;
	b=pKReyZE8Dka66z1jHpF+7fWo2TgMdLctfN3mYmc5iwYe0K4eXSaaCC25vuvTqkCtt0fv
	 As/0k4Jv77hFSiSNwp77zc4bGmbPwrvMVtYI7BZLw83jpfWu8MEXNrSdmmF6VUqyHVcEj
	 yq4M+S5LYCCYHMIA+GtLQOGiz/80CP8rbpWCAGymXB7KsOpPQeKgzhVQj5pimeafImqad
	 ez1aPD2GdOJJUxOHbLPk3oRwkySm+d/SmWVQquXWXV3FFYJHRH5f3Z8LtTm6M/X9tMgy+
	 snL4o3iqhfTFUnObZjKVJPDeeWM/E1uQn7hjQHoqN/lsLkOGYCjzS2IhM5QBoVu5jqQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792359295;
	bh=8QOV8TZT2aLLqNPr3q7qwuDkRjPnEKRa8xpGAQwjsUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZcV7O9q7loEomLHLiLQqeAHZKE1MH5yPTqatoiaZ17CYdilzB7feHMSk7zA+tu9B
	 T9PFiVxj0dFXQ3jhVvcoHfZHhcWQxJNRyXcvbutaQr2co1M/uTU76tyf+YAblo3ouf
	 yuGT68C1tAyz60l83EVbzG+tZo+u94+uslvX2xr/s3nwczgCYUlJ/oLqE/jbDrlNm0
	 UfhHi9uhGXDcHVzMWcoacJTYG7LYvaWKPDHgsJ7hSnqa3l64ouKWAB67GRW8v1iK1N
	 E2jebgsB6LGBen7C9dhnyZYYt1zrMYWKlzJ+Y2DYWrNIhQO1RKKUtN84FflBs3Z3nl
	 rTnx5QC1NE8Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5DD960607;
	Sun, 18 Oct 2026 21:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF61C2A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 21:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C539980F76
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 21:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdl2FZVoWAQS for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 21:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07F2280F6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.62.25
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792359293;
 b=sxNhTnugPRSIAQTwPOPaVCIaYUe4eJYlkKd1zIjXvvbmp7znvwCGpDpxzuOwZUeWCLN1
 eJ0DgETOA0oeUYUNk2uk9L7TwMKa/DL94m+ql/HePUkkRgC+tlC6CFREQKn8B8UvA8R4v
 IY858IFRthU0ELF/fSwOBwFhXolDRL1glZYkPdCXGoQdYY7tbP1HLOlR3s9Bj8wCDMnMU
 mKC3l+6pZbD4VNt4dxuihYe4xIqaqG+2MI8n/YFtavlYEfFX7EWNgFvdCSCpewwcp2k5l
 JrzaZd8vnUqYpO1MnWI49MkLRML1RaqJUccPNg8260XuUpuHi1O+rmq6+NhPBQ9ir4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792359293;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=8QOV8TZT2aLLqNPr3q7qwuDkRjPnEKRa8xpGAQwjsUA=;
 b=UeMVjeOfTqmAnbKB0iU0rEo13hfRoSwdrwbpQj21UqRHdlJRVUi3AogA1cKQMUAQNbAQ
 Jn0ZevNoZzp37O9xmWhhlaXI0ZUDDGIK3erlADE/fbmeL2akieisIikmFgcrt28PdAWJY
 6m2TAYU6Wlnd89SwMI+4/voZK8PocCazFC6bIuw2X/l1gTLQjdmofUAQCUDR59mc93Q8Y
 k/GfVnXE8MHU8g5bNBY6XAnjAK/SOPmkIDtklh+W1Md9tH2yoqOYsjA1RZ5DFdSgBQw2p
 ICmUlw3aMbDX0nrG20YUDfnTqBwxkNXsh652W97xmW/4AkS0fqENfMOTaKqxBU7g1Mw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=O4nk3gA7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.62.25;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=O4nk3gA7
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07F2280F6B
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 21:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q60/7pOfcHep1j943/8QDy9rhs/cbwnthgvP5BC5SBjgVGCDSERPmF/txokDh4T/oBkUJaoE/RpKba454kVX685J9FRVruQm67Tf2Gzpy1rgD9EwEexj3nv6sF5xwe+vu0+8T1FFifCtu99I1gvocwxxdT19QvYvINxBnXLVu16vGFYMBCoCW2cODnlHmAPNz0mL5ch0D/8GcWFLMMELMAllDHAWPIk8ccZP+VD2xZzsVUOmlYRlrE4pp9LFyfkazwjsC2era+86ZlLYAUhPz/yGSjg7GSidDG7YAT0aLQauWT/V3EKqudrBTr0+5ZdXd6hhKPAcVjTTwm4uoVIPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QOV8TZT2aLLqNPr3q7qwuDkRjPnEKRa8xpGAQwjsUA=;
 b=qhfIxSjWxzmfgvw0s+HdlpChpgRJYhhaTFmzyLtRyohnACSJF48XEyUrW5UPEAtQU+nZejxIWSzbkOF3/NpQ4YvrRyLR4TrdsvW8oTu9h32qUovUZ3BgUEfy1FHoqKwD6nm3F6ojJNPA00py17Ltof4z1zOoWBU3Y3rd1eQ6i1TzDK3umBBLaTdwWV0osCuogiRJzO5lm/Xd5zIgea86qjiv9gU1BcCOACGCHiqKE7deVe+nvxKIBPktBf18+LcOQpWGIyytbniVmhcf2lJ3QDNuhGXJWuIQLLL+3ujIv2JBMWheBEeTtXX6Vl0VuhNeyQGz6xd+rKR/RHi0Z47xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QOV8TZT2aLLqNPr3q7qwuDkRjPnEKRa8xpGAQwjsUA=;
 b=O4nk3gA7OAfKnUddAzRp4eCrll/cIO6nxF+TaMFMsQD4fc3MhqQ5WaEA2R7wgZb8IxoTg+VMtyXa2ixCN4YEc628AiUbRAdoIjx/qVVZMYKslsza2sggTOPOVrkNUlY3UP5XgzbF2tVsYVpUpdZyKQQDAXAh5mDGTpQ6UteIQsQdEgQBWgeCXPvII0aiGsh7T3NI6s3UGx9HfU1p33Yz3h+wKYvwIO8YKAFAMvcPYfyAUZO54SmOQTrLLoT7xYhE4LhEcA0S/DURv60suUNK56JHw2l7fTiHrTnn8ypCs15vk0LiRa5b14jmB9/aj4YQYV8DKn2xoR5WfEt08Un8Kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ2PR03MB7474.namprd03.prod.outlook.com (2603:10b6:a03:55a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 21:34:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 21:34:04 +0000
Message-ID: <cc682162-56c4-4143-9fbf-a2d3b5dc25ae@altera.com>
Date: Mon, 19 Oct 2026 03:03:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Yixun Lan <dlan@kernel.org>
Cc: Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, Eric Chung
 <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>, Hung-Chun Tseng
 <alan.tseng.cs@gmail.com>, Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
References: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
 <5cf65034-e7b9-4d0b-9a72-5d771e1d0e80@altera.com>
 <20261014213155-GKB65630@kernel.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261014213155-GKB65630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0117.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ2PR03MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 55985199-f50b-4c0f-61da-08df2d5f8739
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 4ddBUh2sb13XcSC1a2sXhPDNBSasZSyg5PQ4YpRLHpEHbLEPGEz9/Q+u+2AfUng3OtVXeDf3rmmhHdJLdvSIfY4ch6UkaG4IiwTHKl7YH6IFUeSELPnv2ngQArSqDftxYbJ4f11uBj5ZBKODsXhNMFmcMLPk0IqQPm5+c2ftjWFfuDvvmdMyIZSwpWO564r62/ridwMSOD3UTzIi2FDM5CJqm/pC6VsW2cx7f0ee4sIsn1alw8j1lEyXd8UcUwu5chXf4Hcf6NXJ4CBGyehTmla+2WJB5MBJ+ZYSEEqFVz/Kz+Zc2daWOaOSTPygQ9WQO8TM+YH4qXFoS0jCAzHkafRkpoxYKaQBR/MOUOJ0yG3hQytYpmwpS69mdAUA+t8jRqxI9xX0X0CiBj6dxYIwiqW5JJd9njSMbEf8LfHl2S/3jgDg2UixvPNy9GOpnOVvPqVs39P20ZKE/GMsyG9fI/Bhn9uyHxnqR/BTGrgD7AOUigpr+l18QoGAr0aL0quQSYUWf8tNT7Abw+FmEMV9s/PEPHdvek9ESwHa7O9w74ze3CclGDnLu7Tmc8foqGoqHoOzMJz01IdTJCjxG/gclprIZ1x1dYOyZTtPZx/YSIjv/B8H167eFm3m/qHOW4nPd/yuFpP+5yjqOmvaB2VyTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEtzUFNBd2RmUTFKbFBkcmhLMm91T0J1MklUOGxuU2p4ZFNDbWw2WVc5Nlk2?=
 =?utf-8?B?dHQwM3VHa0ljTStCdTIvd2VYQkZ3aVpXaG1oUnhTNFJHSEMrc0pNU1M1eXlL?=
 =?utf-8?B?TDhDRSttS3Y2bERWd3dqOS9ZQ0lBV3BvM0MzNjRibkFSSVg2WWswK015bzVQ?=
 =?utf-8?B?a3E2WmF1eHVvVzhDU1ZVUHB2NVVmZEZ0cmM0YTUwMVpQdTlGTFJ2dy9qcDU0?=
 =?utf-8?B?NDZTVk1lV0NGSWUzRHVvSFQwOHI3THhvbHFjRFpXTDVWT2lOWmNobTZGV01x?=
 =?utf-8?B?RTl0UCs0NmZic0F0emdxNzhTcWxNaWpkUzdmRmE2UkNLZFd1R1FwZkhwU0pi?=
 =?utf-8?B?M1Z2aFJGbjVVcU94ZHFlVW1pcGlXQk1FMmtUaG9KRmwyYWwyWVdXNDBWSzB1?=
 =?utf-8?B?VzBYVi9VdklSaHozNjlWL1IzS2ZIcUZzZVl1TFl4bG5OVXo1YXkvOFQ2MEVZ?=
 =?utf-8?B?bkJKZ3NBRWlKOVJHQktXRVh4V2huUEwyRjFsUHlCVktTcmx5WlQzcHpEcmtL?=
 =?utf-8?B?N2xNOFpQVGtlODgzUEVUTHRyUm04R05yYUs2UWVnYzI1UXFoVHZZNnpiZ24z?=
 =?utf-8?B?YTBldGpOOTRpZC9qYWxrQmlnSVFQUUNwSHFTd1FxK0daWFVqNW96Mk1kWjhp?=
 =?utf-8?B?c2dvZEZycmRKakNDaFZBV1NTbi80MFlqY0dUQW9DV3JsVVd0WFFWdjBibDdR?=
 =?utf-8?B?ZjV4WkhQbmZ0ekNJM1c3TDVORzUwc2dMOUd4REd6SEtZcDFWK1FJYkhpWDJt?=
 =?utf-8?B?UWJqenNvMDdCSlZnTTlEa2FQYTBXVjdwaGtuTk5WZHpwZUFEdW94SENQZlZx?=
 =?utf-8?B?VXBKcW56M292VzgyeVRwaWl0bUowYWlEN0kwKzNDaVRpRGJSQmRNYyt2c25x?=
 =?utf-8?B?aWExTitoVE82VENoN2YxMkZkL2YvVXRMcm94c0VwMlZIOFdraENIYTZlRUtH?=
 =?utf-8?B?TGxDd1hIM3BaZm56RUQvSGI0NjBvbngvMGxmLzhtU1hwbG9MbGZMWXlOdTFC?=
 =?utf-8?B?QXF5cXdZMklBVUsrVGRqVGxiTHdKSEF2ZGZoT201WW1SRFBPelVlOXViTjA4?=
 =?utf-8?B?TkQ0Wmx0N0pLT3FFSThZR2ZQdFB3VkJOeE5kMWt0ejhFNW9KYjZXUU1BeGhP?=
 =?utf-8?B?MXM4L1dlWXZQbTdzd0ZsV2J6TWFPYlZTUFJaZFVJbkJQY2pCcVhYQnhKMWJz?=
 =?utf-8?B?ZVE4WHBWYWVkMjdQWUpVT2p1N0lTT0tmZzVPWjR0NjVVT3R3dUdyOTBwU1A0?=
 =?utf-8?B?MDVKVXhUUUhmU3JmR0hFR256RWNMck9nM1kzT3BZUDlsRmZoSWh3eHFEQlpQ?=
 =?utf-8?B?N3EwY1RDYkVwSWV4SW1WRlJ5eStwSmR0NFNqZU5CczkyNUowRWhYK1lKMy9k?=
 =?utf-8?B?Q1hLcmJFd2R5UkdMMlRMaUJQcE02NG8yWnRkaGw5ZVZBbWdZSWRRSVdzV1FI?=
 =?utf-8?B?MnEvVnAzN2NFN3VBSjZsTkNrYTVvdDY0cW51Z3FJdjJNWjdmOUtUQmtubGcv?=
 =?utf-8?B?Ulk2NzRweXRoQXlPUE8yTEN3LzByUVlLN0RrMjlkd2YxNlI1b3lnZitFTmxm?=
 =?utf-8?B?T3BucUw1SVhGWXdFY0ZDbWovK1JIcVZJOHVLNjQxSG9SQzh6bEtaY2ZlNVBY?=
 =?utf-8?B?d3hhbjlFeE8zZ2xRNjdYK2ExWk1pSXd0ZVNJK3gvQzBoSnRkbmd6OHV2UHRv?=
 =?utf-8?B?R1RETWdHeDRob0xaZnJqVDYwR0dTbjVLVUtYNDZZcVpKYWcvS2hwTWRYcDFV?=
 =?utf-8?B?VGNDcUd5cHMwQWducHZaSzd6eXBId0JvQlBZamw3d21yTStrK056bXZId2g2?=
 =?utf-8?B?T01PMTJCYzhrRXdVWUdjQTR4dE9ScHdDU2JRTmt6bzF5WTMyVFVheTZ6UHJp?=
 =?utf-8?B?WGJudVlsUkcxUjhFL0lNRzB3TXZPZlY0akxQNjBGNjAwUTRBQWwwV2tuSTdR?=
 =?utf-8?B?N1JVTnh0WVFJMnVaV0FwRVJQcmVxNHJVR3pqSDE3bnFDRHp1dndnODAyVW8z?=
 =?utf-8?B?NUl3d0gyUGVhblpKMUFkaGNSRTZPckhlRm5nczhqcFQrd1BFa0lKM2hLaWJM?=
 =?utf-8?B?ZjAvZnladk9tcXVzWTJMMGpnK1dyc2docklHU2JNU2ZwV1JIMnRLTHlNNnh2?=
 =?utf-8?B?L25YS200YzNja2ovd0c5VnlROFM0QUYwakJ5NDgvTUZVcUtsMDlnN29WcjhQ?=
 =?utf-8?B?VEE1M0xzbVozdFl6cWVKcFRtL1VYbklYVlNvZTJCOWM3VndXeUpmaTliQzdp?=
 =?utf-8?B?M21vTit2R05OZmQwUE9JTnZpNVFJaVNDVHFJNlBzNXMxWE5wWVIyM0FVeTJs?=
 =?utf-8?B?R3VSc1J4VXZsSzA0RUZBTWhlZEJtcExpTEg5QnR3OU9vWlZtUUVHUGg5VlFY?=
 =?utf-8?Q?XBwmDlu3sPUg6HIE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55985199-f50b-4c0f-61da-08df2d5f8739
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:34:04.3350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml+DsELdUVJfxYkgVs47dXs+6QcmrdbW7fKL3ZNjIY/HoPAWQRYmF3A9gAGOF61QDJjzafqtIR1pel2Drmgv1Y0qALN//afSSxq2PuBB8QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7474
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


On 15-10-2026 03:01, Yixun Lan wrote:
> Hi Kathpalia.
>
> On 02:04 Thu 15 Oct     , Kathpalia, Tanmay wrote:
>>
>> Hi Dave,
>>
>> No problem; that is understandable, as we all have other priorities.
>>
>> I am open to taking over and respinning the series. Since I do not
>> have a Banana Pi F3, I would appreciate Zixian's help with testing
>> the new version before it is merged.
> Thanks for taking over this series and working on it,
> I can also help testing on Banana Pi F3..
>

Is the K1 SD host controller documentation publicly available online?
I tried searching for it but could not find it. If it is available,
could someone please share the link?

