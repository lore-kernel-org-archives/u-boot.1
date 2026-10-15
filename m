Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF55CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE3E060AB6;
	Thu, 15 Oct 2026 13:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oeWNsw4WkCs; Thu, 15 Oct 2026 13:15:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60B5860AE7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070111;
	b=MhmnQLlLyzyoy76/sjX461bhShJC82FD6rmnZtgFKumXBp912KBIUk05clIAdyeiT5N8
	 AOCfcX0jkJXcbfkHVjE4leHzVSfGKbkxXXEmJuoxhsHRYHUMYIA6mkExF3XjmbxUsvdLN
	 aCMkejvNTKtScvxXrl8XL4n5KZex2fYMEh+avecAvaJY+TxAIN63oDjuHxAU1WXqtYN3s
	 sAswuzc1zJNGW12ZqJKHS+Nm/OZ7LSFvzEgwqR2Gc5fDuJX1oql/uyW1OCO+M1Cc9Iwhm
	 a8pmpSg8rypF3tAq8CoLAVDPpiYDfPQQtKdk9Qtgee5CRvEGS50PWxPycN5k44z6TWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070111;
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
	bh=2d2V14ffQw5onkUsFsYuOp+oXg+1GfXpelEWUtAhQa0=;
	b=bpb1P8UK/U8/pxk9rD/mtrDJbdnVLax0ZCJZ4/jpw+GMu+8u59CCFKsqeSQgyEXwmvXD
	 3t6KjpW1UR9LUCBvrwDT9gzkpJiAfrwV473p3Sg2buYoSXwcLLaKuzhEhipvZdryU0/aw
	 58pNpVJZO6gbi3Z9bnP/6QoxAKzh7qN+78WY6soUODEF+eMFXeg8MVsC9wgODeENmPQi6
	 GiSRGc0NjU+hfcPwoJjQfblE5zgqxKqR2Qg24SOiIIVGI1gImo80ETd5y/R0n2QA82oTi
	 6kUcOHvP3qXUoM7sZVb1CVQyVnavdnBZOpdth6Bi4W1p4NHRcTWrFvzGSrDHHDCGgYw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070111;
	bh=2d2V14ffQw5onkUsFsYuOp+oXg+1GfXpelEWUtAhQa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5ZwTqyiRUqT8bVpwoeTaz1WzFG66RbR3Lv5W2Dl6z6oX6o4J7c6c/JLPjYyhM9+c
	 EZA1ER2I+HLfdt36tidciskVVnqBtlrnQeuqVpa4VJp5lM6Dj4iBZBHstz2XMIQIEu
	 SDtd7feSglrS+bkh/EAoIBDgdFUNTaGtAGpLMpwJQGlgN5JWNaTbD77OlFF2GTW4iF
	 sBzJimLIjFmE3WT+LegVnCHxnbechjHPN3YtXG20rJXLWkVq2adWHoVOer9Mm2lJg7
	 fRRuNe2Itv+X5/ojp/dNUfmIN1QRddhFVGH6qPnnIk/EzXDqvuGmk26COgZULqvUPz
	 2/1cUQPjwtz1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60B5860AE7;
	Thu, 15 Oct 2026 13:15:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1E74A58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C845C40838
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWCePhYR8VfF for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD42B407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062838;
 b=bgL6EXhWw/isKFtHbIOghfIgIZsy/k9YgGA+50N8Z+vXOUcTq3XwJ/zEdg2vA+aMVHWX
 BjqekXJBLosuBKXG7DUH4PoNet45z4eZnomV8PkjQ+EWpFqgN3JYZgwwc7EHfzgeZGf+7
 9vKDYF/nkUX83x44NnCzDnla+jL/jhWOup2UglOczqzgKoNBVkcJefG0PeVN2bXt+UNrW
 rB9NN1TxVXPjCr3p8ufiosszgDFPmCR8ac5f4pQtK+ce0AsiF9EHmFxQCu0ltBPcTPJ1V
 fr+EgZoiW5MZteCRuT9/+u4Z/acRIWvbCMSFPvahkyGfYueWSOQ36yO46v5TVY5T4FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062838;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=2d2V14ffQw5onkUsFsYuOp+oXg+1GfXpelEWUtAhQa0=;
 b=i900riEfpedRirxirF0vmjCnRzBJ0oJwFVtQZsf96lD68Iee10fgHvRCfJHz0AMmRV5o
 3uHqpQnGrCaQ1fH2cElHl2enSFKWv2/PhBR0ANyXSWke3Ezxq/iV9AWrMSw1Ai4Vi003N
 o/InbTaoXw8L2CGsEGdZpDkbusipsfA5P07S7brri/VVrJNgG/ZDWnTOULfY++CzL8L+h
 ARQdpEqp9aa5nS+ItZm+mZXpKkdPo9EHyNjQLCVKA2jl+rPRh5cCjHCs2DZBoefg1TbhO
 peGu1ADIad2Hqg1idyYUy2vnpOuywxzch4l/hALIP8mNHOvwyXRhARNnT+W+tXFXEZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=vsbF6SYd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=vsbF6SYd
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD42B407F3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxCh/qlxmgskc3QjDWD58LMq4QlygUtWh2EIFZazSKY+lLSc3xlA5/22GeUMVdUZgM8jQPHAP0DusdTvczKzpm41Oxq0iAgSMVIikG/HlQAt9pGXueBHTZBB7zf8NSmqTr1eX4/j+ZVWVMMC1tVZqXMBkwQJraIHMgaShhHi9b3bI1Pt1MDjs6GKNx/s2TBXyLYGKAX/UN3bdudYyeoKQNe0QWz5tQQC7/ecMlup6qzwtszDLv2Dw2z8kIdoi3a9uC7k3cm9RUGOc6ChHfPyyTK/Lxq8G4YARMIBDnlauL1OHaR9zVchSt7heiGvbVZwlT7HcOrwkLx7k8y7uOL1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d2V14ffQw5onkUsFsYuOp+oXg+1GfXpelEWUtAhQa0=;
 b=O/vDbXyYIdIsjo02Ua3QRL/o6RIaknCdmJiE0d0DdWTOkOnwQUm2WiScWiD3nryf0FBLaoWfDnOq/KF1Ro/BEVOlSO+Dy1e3GWqUALaCoXI+Bvx0XLURzpkYdK4PQW2LGrlrYlSy9NTi3N3Gv9GCeVOgEGGeJEBR5gDQjP3NZiEhrPbE1j1cwxTH99ZNZ2IH+FWwcgeWlcn7ggjxAQUPCS5/h6fWQr/C69u4Px9OPWgOwjsU3PkPrgKaj7dESh/Q5Buw3DPEM7TbLioidJNvOakqPiVbPp81x3qBf+SROwNwpttI/526SG22keywAHN9ys4q/br1G8Cig2njfjTRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d2V14ffQw5onkUsFsYuOp+oXg+1GfXpelEWUtAhQa0=;
 b=vsbF6SYdc3aZHaU9eaSAG2jMgcsxJe4NusarKNaiVjge/6ZkEB/zeOKYtmKPXBVYeMp6sA6pL5mPx5wbG9XJV8AOZSbArd9KU3d0No6aBvG5dXjosa/2wmJvWVeY0U3MrUY9Yt8aPwzO056wN7OfGxODcz3AEXFBsdob44aUK3sxKHfmVXB5utgijE1HZzi3bgBcf0R5H2q5H24XDiFbHKA3Jvt3DUoduvVbhgRhuQ1XdTghwNu0NYwYebfn+MAc9irwTwgtGOseXy6Eptvr+sttbLEguX/XnARSitXoPepo3StQWQQwNrbsPzCgEKHdF+sqcN9iEnnavh0iKERFaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:55 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] virtio: Release virtqueues after device reset
Date: Thu, 15 Oct 2026 19:13:19 +0800
Message-ID: <20261015111328.1269775-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d20fc0-b7dc-47d0-74d7-08df2aad6696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U9wu55LKwWe+OxdznpMX8Cz/cTUa3ofyqi2+JscrEJw+R0IngKdIGzp+GIzE7U3x5kZ1FVhSIf6sRiBgcoekYE3hJkHaWFmVhmmAN/3HvQKW1SVdGCI/gnh5XDiXsmoACiwKgcEqYcKpb63frKuikvPNzvckfSP2eQMc8sXLTIAfNd8/Nj7NzL3jWd1+DcheQ9vHOXqQUDc+pfuqylOi9IYMDEL4KsqlLVyn7mer/KwULJOFcuzRNzwbNNKJG4fHprMQtulibANsqEaTxRhHmJ8nQzQCuGPbX9IX4VOFG/sL+BmhaYzkfJx3MiXHN/wC1tzyFY7mfEUiFjcMv3aVRH5MyEWJV+Dc94jO6Idws8nxxtl8gy3fAzGIJsy/x9MJ4SSyTE8e2VoBNuinwNuUDzCEBKgeSPG070hmeNyazs+1jA8Nf9fYWGOqfMAnkOn9KFpRM4hiafwnJ9VDAaNjsnEvVYWsckHsjQNhQkhut2bod5L1Z1F+dwTPllPOH+BpddoK9daKT16zHPOfp1aoik0FpZyQE70jEJTm/jmF9m15g12j7ldAWnVve+OwXApap9IWQGZpuq/+dyJGtX+pEsnLjJvkSYcpTePO1YPIkkhsaall5xzW/XeI/wEG2RkdHs1cUr9WXufQRhqEhFJB3C9N3fDGH7fMEHXHWlexyeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1c7pBJJ522nx36FowGYn1R4dCWfF2NTizVKNzNL9iFlj5H6OBDwr7xH5jvK0?=
 =?us-ascii?Q?vXhzIpQyxm6bMVE75m0XdfZ4Ha8o6Hiv+b98e6+4KhURHdiwY1EKIdLp0Ec4?=
 =?us-ascii?Q?PIxktCJPXr0/qhyL9x0mNbIOFhn1sD9EDw2+LBpaPEwbdjQqtPPu4Aycqg3u?=
 =?us-ascii?Q?WOcU/HACO4H8niy3OfULwo9LH9o+p+bWWdak2+iQ1Fsw9YBHS/mZ/rI1jva4?=
 =?us-ascii?Q?x59va9pfX9O2CJVMMhiH002IqtYtE0oHoVkj0cYUnl5DWRZ1fyT5hdBKtUQd?=
 =?us-ascii?Q?fQO0ZbJJ2JhoHcxmm8Gs4P9jb5hGCwKskDxtkRPDWP8XD1mmT+QUesqhFZiX?=
 =?us-ascii?Q?hDuiwy9WO+TtzrqAyO0uKDVbJjftPXlrNAZ+SzaBsjh4H0Md6iNSLVm06kKq?=
 =?us-ascii?Q?OQ3aKuKVy3rQKLAmoQBCjUS66xWt1DqHLGpB0gfogxtGBl/DJrh8i8dtI8Y2?=
 =?us-ascii?Q?T62VEpWvsfxyq93D6k5IlXQhKAGIPhqpJWqmvzpTcu2ef+nwvJXeI72zctd9?=
 =?us-ascii?Q?k4xhRl9Y/dBfFJH2/onYRFTiOMRVxZ9TYXUsrdVsmI5Ip8pzhn3xTc/zTYj6?=
 =?us-ascii?Q?fXGDB8CVk/etxdtQ4rBKOFvSnwsI03hwZ3ZYsJ0S0oE9mjolQwT53goIi1LG?=
 =?us-ascii?Q?ola7ACiYzn/gzL4fZYKge7DFBQYDQMCwc7yAa/eFKYj/SJw2qpZap1onbjlb?=
 =?us-ascii?Q?nU/pguFBeUxxBT6eVUpXE9rIXLm5DQytQaLWJwqrpBS4nqQtpqUA2ZdwAmkt?=
 =?us-ascii?Q?TGx2XPDvYSkbB4XCPDYpOSwn1vKU9d80Z/GDSBTNUoYSmU9Cqw6mE+LJhIGJ?=
 =?us-ascii?Q?9wapuFmjj/iufYehTyOfMQpS6a8NW0AIL5rqilZJgzmnwBg9zyBjYJ8Yr3NO?=
 =?us-ascii?Q?omtNxwisLtRUA8H6lX2Tlzkmk7Hj80n1TJz/ZboahFjGuJk9MPUddAfpHOhl?=
 =?us-ascii?Q?Cz3oGIQXyC1HeKt+FNwqUccU8VdYbfoIzCZuvf42jAMTHFeUKBthwgO5lxYR?=
 =?us-ascii?Q?wFeBmK2/9YYYg5Sb/BNXLnHEm7OmepGO+P/YJ3Aqk1F5C+KEfUZvoJCKqAXp?=
 =?us-ascii?Q?8snvUlYOFKWhPmBiT+zT3+EbV7LMEjMOeFKqJ49FF0dKpUNAZxOjWolb5WrL?=
 =?us-ascii?Q?+gOeyNyNh1gZHejzsyTS5LOl2/dx55ZCnxD2ogWgDUnrkeHObMJ3+yGUFWua?=
 =?us-ascii?Q?+8b564pRQB2yPJnhzWfhLYSTNNu7/AsDCB4Y7XP7Jo/YHS0gJty6zREprk6N?=
 =?us-ascii?Q?31eq2CTta1wIeiHeZQS5IMRo3Tyeq17G70hNxNZ8Xp8bKB/A613h9cTegfTs?=
 =?us-ascii?Q?0Dresgux23vROtoQ/eoMzXqhf0us9VhDPV5sPgJS5NQ1gLBI/G9kWEjWor9A?=
 =?us-ascii?Q?GoA8lPX5fY4ZZGaw+fIYbOkHMCqvcLv25/q9eUn6IMPU4ZlWMZwMBJE5mM8a?=
 =?us-ascii?Q?1YDrJ9aMVt71SgKMMN/DXcVygxgaC+8k5ggZ6aElDjammnRBP3o47yy/HRTT?=
 =?us-ascii?Q?v+LxkPHjxbZEannAsEAmk+IAyBPX0oso6KTuky1ZLwZEOYgev327Gxx0+BUC?=
 =?us-ascii?Q?zId937tUqLyMCtIiQn3OU9Qu+UVqoC/SpA6KVrgqfBvdqy7UdGyZYvpd1sg0?=
 =?us-ascii?Q?BdO2ePfGws6X6CiOhhd5LP/abObiSETMR6b8enbwJk7AjlMjTH3cBl975hjq?=
 =?us-ascii?Q?LMMwGG6ABJ6sOn3+gSPLX0aJec24jqexEiHRk/QRNMAahpBGirsOwlZ6FxR5?=
 =?us-ascii?Q?ReMWUfQAXXeHKsVA2XJGWigB5CPnmdc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d20fc0-b7dc-47d0-74d7-08df2aad6696
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:55.0037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrlKYWfq83uqi/bxVQdpjscZtSGo/vFSwn6bY8BpYiXmiYYtCMcX9HUIOnfRsDux7K33DscJEfngHA3V2ixrWSShrcQH/5RZqUD1bUC1I6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

NET, BLK and RNG remove their devices through virtio_reset(). Only the
modern PCI transport currently frees its virtqueues during reset, so
MMIO and legacy PCI retain queue allocations across remove and reprobe.

Wait for reset completion and release queues in the common helper.
Keep transport reset callbacks limited to resetting hardware only.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio-uclass.c     | 18 +++++++++++++++++-
 drivers/virtio/virtio_pci_modern.c | 12 +-----------
 include/virtio.h                   |  7 ++++++-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c163b2fd7d5..978ef0d1ce7 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -25,6 +25,7 @@
 #include <virtio.h>
 #include <dm/lists.h>
 #include <linux/bug.h>
+#include <linux/delay.h>
 
 static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
@@ -85,10 +86,25 @@ int virtio_set_status(struct udevice *vdev, u8 status)
 int virtio_reset(struct udevice *vdev)
 {
 	struct dm_virtio_ops *ops;
+	u8 status;
+	int ret;
 
 	ops = virtio_get_ops(vdev->parent);
 
-	return ops->reset(vdev->parent);
+	ret = ops->reset(vdev->parent);
+	if (ret)
+		return ret;
+
+	/* Wait for the device to stop accessing the queues before freeing them */
+	do {
+		ret = ops->get_status(vdev->parent, &status);
+		if (ret)
+			return ret;
+		if (status)
+			udelay(1000);
+	} while (status);
+
+	return ops->del_vqs(vdev->parent);
 }
 
 int virtio_get_features(struct udevice *vdev, u64 *features)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d309f9a9dc1..abc0163fa82 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -14,7 +14,6 @@
 #include <dm/device.h>
 #include <linux/bug.h>
 #include <linux/compat.h>
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include "virtio_pci.h"
@@ -350,16 +349,7 @@ static int virtio_pci_reset(struct udevice *udev)
 	/* 0 status means a reset */
 	iowrite8(0, &priv->common->device_status);
 
-	/*
-	 * After writing 0 to device_status, the driver MUST wait for a read
-	 * of device_status to return 0 before reinitializing the device.
-	 * This will flush out the status write, and flush in device writes,
-	 * including MSI-X interrupts, if any.
-	 */
-	while (ioread8(&priv->common->device_status))
-		udelay(1000);
-
-	return virtio_pci_del_vqs(udev);
+	return 0;
 }
 
 static int virtio_pci_notify(struct udevice *udev, struct virtqueue *vq)
diff --git a/include/virtio.h b/include/virtio.h
index b981eead5d7..30e5005e9ad 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -160,6 +160,9 @@ struct dm_virtio_ops {
 	/**
 	 * reset() - reset the device
 	 *
+	 * The uclass waits for the status to become zero and frees the
+	 * virtqueues after this operation succeeds.
+	 *
 	 * @vdev:	the real virtio device
 	 * @return 0 if OK, -ve on error
 	 */
@@ -288,7 +291,9 @@ int virtio_get_status(struct udevice *vdev, u8 *status);
 int virtio_set_status(struct udevice *vdev, u8 status);
 
 /**
- * virtio_reset() - reset the device
+ * virtio_reset() - reset the device and free its virtqueues
+ *
+ * Wait for the device status to become zero before freeing the virtqueues.
  *
  * @vdev:	the real virtio device
  * Return: 0 if OK, -ve on error
-- 
2.53.0

