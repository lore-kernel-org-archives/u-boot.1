Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256C8CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB2E980E4B;
	Mon,  5 Oct 2026 05:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMwIx2I0a5EA; Mon,  5 Oct 2026 05:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 163C980CC5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791177201;
	b=LUNmMTmGalFp9wzGqXBk9GEKT4oZv02pnbujrijj3SKmLPWku3KOtppCCmkT1xNW2vv3
	 S+5XUsU76Vi070+x6cREshpnr7NsnTUI7PkA/BccKPmmA/aNHRGlUkPPewpnkY250FYkb
	 uf+o/d/B0OfduNwlVu28OxzqmVtDx1rOlr3HSsmZzUpcDSFJ0i4FGoGr7SjcooLaVQI2G
	 UVlgmZYRUHGsUhQCTssc53od5lKgD+NiTWIyRIOIeU4sUHnuBtKgruBAxMKUwmOQalWDH
	 W0st33GIyEtGXr7wB0eqcy0RvQrzCIAHDvzclY15x0oUQUjqQhDMYSzeGZyksGhGe5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=RRAqfrV9n6zdaxKq7GMS3+cbtkwHTGvW/FtQnK9QULQ=;
	b=hj9cObbeFUZ2CtO0p6Z3hYc7gA2wiv08wLlwcCTyqTREnIrJ1wM/Uf9cyi2OjnL9lWT+
	 IOkJcqr+CfXBZGimDDkKKGzsJa7soKdkf4q/MMivQKuGq/qvKINSMyAC566QM+QoR43mC
	 DnkBHjsrFYnUZZd0eWBDa1FLDwUy6j8BEPgKCmwK2Kk7Lv6rElOmEk2dIZeq0CTl0/v8E
	 cBI5A1qEaSHcw0auvUr9CLinI3nywWc8AjnrzFGQ8qi89ECgBrEPukVyePJmZl9Wyt26w
	 TF9gD3SenoWddFZD4QVAt06t2/JkiJV+od3qaYra3b97AZI8JE6nrr0aP+DZ9R969dQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177201;
	bh=RRAqfrV9n6zdaxKq7GMS3+cbtkwHTGvW/FtQnK9QULQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mAB8S+zkPwXG8DYgbuUdN2jAkWIN+sl3X0TXuu5MdasdrtQR+DYVrrChFd0jXvZN7
	 GJdFgfZFGHTAP1WHf01k6JGVbrlMe//sjh7izBsvDAELNpbLMawEU1Dh/eb+Foiv+5
	 tZ3DmH4XShynF3po5BcWYjGwQXSBR9QhfUOd949K3KV1Kpo9soX/MGN2FgJXBC2tcY
	 tYr6t8TQ0AYnFHHVT+YPz/2FPavJMDQ2m8sD4xKU6Nr775SpUOHPFQDrnjrH63MboJ
	 6Os4eUU6l9Bjz/pEBBk6ptJr7uTsIb4NF1qO5q9B0Jw36igBpbm2yeDFm5tocGfILm
	 yCcVbbmNkRH5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 163C980CC5;
	Mon,  5 Oct 2026 05:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA2134E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F6E64007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFwd1Vlf6pKi for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 00:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1C97A40004
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791161435;
 b=A7WKRpB0eXeygScYSITKZX1J9Z6SrWv4dBjhwn3lnD3PpNA7/XOuVYZQRrxp5pAPbNUq
 B2g8RDVcRDIPVzH/KXqFxgUOVSvd9HIIbkJeJecwyvHF9u+HGEY6C3YeORIVwzL0Rsp28
 H75I/mjQMYnJzwgYyR0wU0ErwikIy7M0Dhyn2tMtXaV8AbSC86VKNEBSWlyFjZoduB9qK
 tRDPVjk5q6KIgwLY1zv0qyapk/X/Thm2VcEI5h7sdaxySu+N3zizXLrrDwDEz5rXGXbiB
 /f2y8xHd1kig3eVyu6kbERzOFAls8uHpNXhZryFWVoS6o0AZZEVFNoBGEoxLIZddLrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791161435;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RRAqfrV9n6zdaxKq7GMS3+cbtkwHTGvW/FtQnK9QULQ=;
 b=NKFUOVy31j7ltjsM9Bvccj6IJGKmUh8jK+6yZBGmrnYORX+H/mY8N5348zTKChvi/T5y
 PX1AAsv6+9sW5imqC2Z9yRI4R0S0cWFD9iISgUSkAMQ6qPwL2Czc5m3mzebblD/yc++N+
 mqAeuEyuFUm+LaAqEqTsiKWvfFOnrupgZ7mCXgeT+Q8Rbb1DMqc6Ebd43GZ37rhAzZR2s
 ffiSAUsY3OBOb3PRRRO49C7n9Mh7UOpWjumChpYcTpdsjr6qHAva5Jacr7yeGmeWNaGzA
 I8RkW05geQ4jDjc+p0JzA36fJ/xFLlms435PZ48F1BZxZrUhQ8bh90coZ/a9cR7K3aQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=processmission.com; 
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b="OG2PduL/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::7;
 helo=tydpr03cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=OG2PduL/
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C97A40004
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcNr0/Nn7+q7GK/MUS6uShhkjCXZwYq1t3G1zWc/PUvzpG/273zH5UCHdPds6Iu4XZJeeZ7zU39zaj11qLz4lN5vtlcdxFoZDAHXPjs6tB38Ooo+pVONFm5aes7sGoKOTNY1EWeP64zU6zAmdG+k70cIFweQt8jouk6QUsb5MdQjdqgiGa/Jeb9WSexML7RsPMMg+Z3tiCsV4GuCiWl5uLnKO42bVZJmI8pfAW+NNtx0bjDLBJtec7YVwCl5331mcO2UF+K0niFPWJmhh4MPU43zw7YsUe5zBuQ8obfrwmPTB9b0cCwtqT2ojyVwtK0n7MQcE5tobRsTjwru9cb2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRAqfrV9n6zdaxKq7GMS3+cbtkwHTGvW/FtQnK9QULQ=;
 b=yGACEVNFeaLTPkX0CgAYiA5HpUvhl4a0nWDhPVe51jLdl9nkPyV4y89+YwuKqfC5R2FPDBqn0eiEoRCHpegxQOIxXU2S5y01HF3QBgWVWJqYvI/AI1afIjGY0EkkbHbKYncpbrFf4LgGUwuCQH3uT3pnlfvBL1SlM42eohPKJOMoZaqLLuRKPUmTWGuBLD9YBXFJVtWnFvAsh0WXep3xAxenQtgp1eBXh6O48+/BiRcGQLG6SaY1fRBBHMVo1UII3WJljrpx/yar5vkOaubzupLEHVUBUpk5x2579++hMoD3APjjmsMbkPEvPHouacroAMarU3n9aKTx5UDKxWlW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRAqfrV9n6zdaxKq7GMS3+cbtkwHTGvW/FtQnK9QULQ=;
 b=OG2PduL/NUIIXcCNy3YJFsn1v+TMulFDvkY4xdaFeCKLz0tyOSEFbHZNxKyEahJ7WHNCVOeKcu0KuAMtFfDkMm04JZeaG2nw3/c/udzVeiqKpyfLQm1TkJDkVgtuullVzY7Wttgs+63GXfYuuRx/Z0+4bE+byPhCGsrzPRvEvhgtcbaypI8RfBwMhJqgu0hCYvAM/mwYYL+ovnnHUINCZ7ClbIU7mNIDp3b3Ha0E4umBovlwhQ5UKeTaqyKjvjL7ZOccvXxoS4u+qvZX4xnQ3OHD6zIun9bU51s6MGWAp/rgjLfCM/AWmD2+R8JQEZZwMH/RK+LlipheXnXXabjXrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SEYPR02MB7361.apcprd02.prod.outlook.com (2603:1096:101:1e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 00:50:26 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 00:50:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: microchip: mpfs_generic: Allow serial number read
 failures
Date: Mon,  5 Oct 2026 08:49:01 +0800
Message-ID: <20261005004902.3441895-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::9) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SEYPR02MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ddedc2-74a9-4e0f-af3a-08df227aa475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cHowXG/V0Pgqq4hn0FtM0AUW8Z5mcGzwSKW8E50/XTVLsDwFZkSRGVQoLZcW/IF4yYbenMvsNw88rVO1zUV0/BrDhuISPG+TB++GzipGd+p8f/UOBKdsJ0nitJwV6C5eJI/WANtlQJvFgt2QiEWLExJ8pPLRZnHupXTeM3mc7R1BeyaD6aOD+VkEzDKSXiAwmg62byPPah5Ge+CXytOoo7pOiTo/hV4HQrg8bGBko2aXgNpbC2vS3wYPGN7Ql07SMbS68GBydzUydYVzjkP6Jl3EgcAGUIJBcgTX9iFfrb8aZMH0FMzRzjmUqHlwj3M4v7V9RmRDxUp1ERcWFIbub02QATFAlAjaqm1RCI5XfNDQabESvjd6djDrbe/BB087Hg5BJdzLuSjJmLzA+gm/w+2sPExwhl0rYb56LWib4p9I4pv/+ChHETvufhjeLCpZK7KPG+owJmz3obwFdQtEC9YdFNpXJkSa9EXB76p0ha6B3hLI/jdt99mWj6AnIH0rKrBYs9vpTu+zUyZl1hLx3rKq4iqt4ZfTm+/mhptpS9bzDsr6ei7h2EJsWdfJ6AVcwxF6n2wxTX9dgbcUZZcC8/6NwedvhV14dVWCQGhQYOQPl+RZmif0f5rBP7yjIjT6uZlgE/GBKJIMfSfL+0v8+Om8FbixY9fIYX2D96Kgj2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rh4RoblDEppLqrRfxjUs8AYr3O1wznc+3LXgviFv6YCqJNDRx+EG/HIOnxu6?=
 =?us-ascii?Q?XG/Ux8dJvgN0Og8GPHwIDALOKuLVmszKZ1/Hgk/aKBAe+2s3I5cfrTVV0w7u?=
 =?us-ascii?Q?etp4k1B7dsu5cu+DFSq7csPQepRTv2+06LRb61o9nGDUuZuIDQ9pBDBUHbEC?=
 =?us-ascii?Q?xJpEpVop208yBruh0z3UmzcxVStzhcwX6A1mdSFIQjxXCJV2Knld3+n4bxFj?=
 =?us-ascii?Q?Aso47TbEppa6FFOxM1NvC3A5PWZtzC2nXxcp0vQeRVhzbWUPcmwpV2QpxV1+?=
 =?us-ascii?Q?v3Sta00DjFQcnDQTTCpXpSxohrY6lerVSUFpEGnG3lPdfsm12V9VxpPh9iYU?=
 =?us-ascii?Q?/uUjJALbJXTSCKG8Ri6rjPB9iy/kZyFQ7acEt1k9XQicqWmxu7NEcVhQ8a/J?=
 =?us-ascii?Q?UV+XuQhZ2V8isE3gGkb1hgFBRQoP7FebbZRURuDCILvr6IrRKzL/B1D2O8bl?=
 =?us-ascii?Q?ldgLPVQMJCU3n/+PXAEnjVqy6bcOjKlpH3x0p+ZtCsNgzBU7IWxyw6W/BAg/?=
 =?us-ascii?Q?YFUpY4IurE8ZqqTiDbEGJW9Qzhwdz70agUdu47rTwIyPtGV+xavOSM+Kvhqy?=
 =?us-ascii?Q?4NaK0pbNEdtdWNL2T5yC24p74MWdUN0ACSfUnsXgV7fN6OH0OCLdRJ3Ygxfz?=
 =?us-ascii?Q?DXZhSgwfSKEflL+E9PmGsjb2HFe5nU4tUMf+Y+qLIZsj48EVZ3dZc/bZuSWd?=
 =?us-ascii?Q?6GTUjVFaKP5nBLlOVbvibeDl67ci4gM8UMTSIXBL7jD46RCn/zw5im7k+7ym?=
 =?us-ascii?Q?LbVKLiY+LVTjgX+PQ2kOTrasF4PwtA4UKUhip0eiymgTe8jmdNQ6I/Ds2gxm?=
 =?us-ascii?Q?jnYynPIHOhXAIxGfQ933/I1W1FVlI/excay3hbf37riMuu0cfLHs+amKDWxh?=
 =?us-ascii?Q?JfFWevt7kIPKw3hKlVHYKwiOwRh5lDuDvqQLOqWn+uDM5yblfSKWZVi5FI5m?=
 =?us-ascii?Q?4cdWe/qhqr6cXUbAqsKVMSQGZdYvIpxh4udtBE0+LADZ2DGuZwC/cCADJRHL?=
 =?us-ascii?Q?jjH8SxVe2LqppCiiYWG6VvobsvLZFEh0hqIjekP/O/X10eWfGfqIJ46ynQm2?=
 =?us-ascii?Q?yrUGWgFMz5cC6npXGQVQvgz2842OoC1tjHQEHhePTBIGm5eyxlFGmUd6vfuC?=
 =?us-ascii?Q?1N8gLoje9FMDlSt7Uw07a3Me1k8G404qfC5AhUVeji95OoAq8nIjAyM7IqQw?=
 =?us-ascii?Q?iJ5QIOSA33VwKMw0L31BcF9U2WjnEx0PJCZtJGhzs56PBZoUQFNVm+iF9e4Q?=
 =?us-ascii?Q?xrONUbe8K264/BwUd5LrFw82dj9fsyg3Banm6ELnzxQglvJypRHmkJ6Pv/Uk?=
 =?us-ascii?Q?8oEc8F8Td5IZINe8Rf2+8qtfMfN9QFqursIvDTqVrpjdO+XIfShC5ol/IOuf?=
 =?us-ascii?Q?Sqjt0Eogs8BxgYTJUYvpFL7P3gHxMJjq2R1E+2xEg56hebiQxfwRd2SMyyff?=
 =?us-ascii?Q?ES/MHzpk5lBzGBVT7UPRWS0f47J4PsFNwSeHn4O6Xg4RWwC7V2jxTnf8NpPx?=
 =?us-ascii?Q?w5xCu/Iv2MsxeYGkaaEbWGNuXGleRrFBypj2tS1k0WG2KqZicNlLy3t5uy54?=
 =?us-ascii?Q?mclkJLQfNwvLDnClaA4Ky2sUJbJfUXN+RHZcFg0Sjk19RoS5WlC7Hd42CW+b?=
 =?us-ascii?Q?E8flOm/OF5MsCp+FTIVylfOmgaJr6VFVnqPLlL/HQf9VEYRIUvsqsgRyiQGx?=
 =?us-ascii?Q?wvY444tBIu7ENcXdizT6ikw9kK2vbxNO6A8KmLAbcoQdFy9UVp2APf0jaG6U?=
 =?us-ascii?Q?li5OcTTiruXi/b5T8XOvOk4jOi5uXbU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ddedc2-74a9-4e0f-af3a-08df227aa475
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 00:50:25.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaIIKqluqZPwBi7pIhlGYHdhrrRi9ZabuHt4p8ICgbW3IbwOm+LErDEM/nifH2XFIBWNA8isYsfydopmRai1dG165E8yleZPeoBEkIps9Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7361
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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

The device serial number is only needed to derive the Ethernet MAC
addresses. Failing to read it should not halt boot.

Warn on failure and skip the MAC updates while still processing device
tree overlays. Track whether the MAC address was derived successfully
so ft_board_setup() also preserves existing addresses on failure.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 board/microchip/mpfs_generic/mpfs_generic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index f57f5f4046b..c100a522888 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -19,6 +19,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define PERIPH_RESET_VALUE		0x1e8u
 
 static unsigned char mac_addr[6];
+static bool mac_addr_valid;
 
 #if defined(CONFIG_MULTI_DTB_FIT)
 int board_fit_config_name_match(const char *name)
@@ -140,8 +141,8 @@ int board_late_init(void)
 
 	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
 	if (ret) {
-		printf("Cannot read device serial number\n");
-		return -EINVAL;
+		printf("Warning: Cannot read device serial number\n");
+		goto out;
 	}
 
 	/* Update MAC address with device serial number */
@@ -172,6 +173,9 @@ int board_late_init(void)
 		}
 	}
 
+	mac_addr_valid = true;
+
+out:
 	mpfs_syscontroller_process_dtbo(sys_serv_priv);
 
 	return 0;
@@ -182,6 +186,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u32 ret;
 	int node;
 
+	if (!mac_addr_valid)
+		return 0;
+
 	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
 	if (node >= 0) {
 		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
branch: polarfire

-- 
2.53.0

