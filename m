Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D880606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ruCHablG;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=pz5pOpns
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0803406DD;
	Sat, 31 Oct 2026 21:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNsKjNcFjaPF; Sat, 31 Oct 2026 21:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7E12406AE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793483719;
	b=fzxpnlLBnh+sRkFSKl9G1+VbddH29a5JLNTBmVKc5q9qrXTwc2uUgB+gcqNwHlN7ETld
	 X8TaYtbTNQ82hSWVVoDBE83qIT8l2ykcXdmlJpocsTiLW/7ug9+babpen3Rc7pHMbVdvw
	 jBgB/mG43ubJLcDVZdVQTsS0LHrrcOj/WumBdqA5qpXR7zrN2yi4GOk5RH+0YCcKXKKM5
	 FjeMII0QZK/ixEPvf6mHT1Cvv2qxw/gqCpZVLRzSLw3O+ntoXG9Nh9jt/rY2YBrdzVu+2
	 SElUgr9bqr1gPpGFLoxeCEnC9VaF4Pe08kGx293Qb5F+ruRRdyPDTuQKuP179dBVrDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793483719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=2hWdqm+HlXSaKZs10tWuBL6LhGfnesW23sC0jRKcwBM=;
	b=JL0pCbYOR7PHgL1jirlG4XxSh/x3D+1mucD2f1owyr0coJr/kbHju/JND25AZ4exSrWw
	 msli9gWY84aSf4Wiar3wKCL4oxZgxRq7v3HdTvaHg1LPVQtd8U1Zmqm5J7axsR60CQh0N
	 kgWbMuLD85TALA0o7/mHH6u68OgYUeF6SOMT/HCkIa9IAF/1EOBDD4U8GrBan11jGCMBr
	 7J99nu19qaNCbUkslnu1UfjLwxgOT5LOpRM778GZd8ZWWq90DEXx3PXbNWTeTvfsm/VmI
	 k5DgJlWZaYd2qVY6Dk5DnW1VJLWe7DMSzflnIUL4ZiC98/MbsPD+ydBNbpbeREDLVRQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=pz5pOpns;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793483719;
	bh=2hWdqm+HlXSaKZs10tWuBL6LhGfnesW23sC0jRKcwBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ruCHablGpumCxjxRWpuDzo3g3eNMzh0B8MwNdaJmNPAaSBUlOIAlVza4XdEs9jif4
	 8lEo0gw+ntTK/7KmSC0FAZkAW/8HElKOmJKpdCbC0B4ZAa611X9tcJwiZH5tSzhmsb
	 oq6jVXluEpOdNvYHzaCamOpWaDa40C45KMTspM2lr8j347UBm2bz9Gl2zqKTJ3Zpuv
	 90SZKOaQP1PBYaF2zYQJ2D0TtNZvhQvxrjHUfcSL/PC6RR39gm2iTL++PlPxPwkjIX
	 jP60H+ysTZusk/jAmEFB4ziS0TM61S5nMeihOriFmzOqOubM2HfDccbsSM134Kg3aU
	 2b7CQIMKQ/91A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E12406AE;
	Sat, 31 Oct 2026 21:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73AC6156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5990C40640
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jjnuci7HNYeE for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D0004059C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793483708;
 b=akMJWP8U48gXRZ3aKsJXG/Tth+5MyMPCGwOn++Hdl8tgUy54Y/uuSWBjtWd1+Btoivb4
 f4n1R85yMlQbSAz4cmW+arKaN18p9JDiocaRvFmF47+rmnIt4+abmzti0svH6+sJ/xZKy
 6y0x3iXH+S8ai66qS3gWdneYo+sXkvlpo0BvZoU7AajNeDdOwVYG/eU8JNkEwYA31B4Lm
 OqovWjNKISfAyx5DOHQcX/4a3lyIE+wuPsnM6j/6qc3NfC8dAKqieAwtDT+AFay8cag+k
 qi+8GcHu3nTgHhE0anRnnJ2sak36+WW3KTH+NY49YSfrKajZD0SeLf9Bs29nvDS7Pvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793483708;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=2hWdqm+HlXSaKZs10tWuBL6LhGfnesW23sC0jRKcwBM=;
 b=U4kUa+XFM3fHX5PXgrCzXp8EL9qh6LSecWAvDG1AkRb3ovsni0WENhpDnKQPgzkLpI/k
 Jd1abNU3W/YHtqexYBTh6xksXlCzvYxkFoa2vnM7uAT5+Y4O6dDuDFsNYhrDkj8Qb4BEp
 1QSDCr+iBV5QE4xOzV9XiG6f5NDLW79pbOH/y4xv/q4YINyZGOr+ZJGBMS+3c0tR4lnW7
 dkfn82xLVAeDN+mRIY6pOL0CL41L32NBgn0stcAEbY45MRdEeELH588bHpc6oOiHqlUmp
 oNun1pXWbZ1J0qcDnXtWx9l0ekTExiNSXMMgC42Qo809gKkAj/s5iTvU/q8yla3lv7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=pz5pOpns; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=pz5pOpns
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D0004059C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp8D72xZjhlGZnkN+8QmPThD9nsTF2UfknfdgE0zubrmyNSlSZ0huIjJps+nGTrrDYv8ga0grwz1Eu5UGKpCXcMZ22iARQRUa7r+ZLkcgjE7i0mYCXdzL26uCNb3+YEC2OhZ6t1ohza8F/yrsluz3u6kYI+5p6l6QniC+np65eowiyNkB/RtNKPMxbXNViT87GZbsZikLW9D0WAYFix19+AsohI1uHC1aM2u3/9/1A6YUKl8+YJB2z4/EIClwzXIvgD6iRhSBYP86MueFXQeiloJ40+cmg4jPI3BsqNG7Q/mAsbY20MDHWQ0kf8wFP0bzLz78izW9iAxubNPbpflPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hWdqm+HlXSaKZs10tWuBL6LhGfnesW23sC0jRKcwBM=;
 b=ByvcjuLwiLqarMHCdWTjUKPZ3S4dtb4Qy2WQFqCx7fe4PTUEudzM2feNePuqDpL1xjcBO3v9V+5917KDbt+iGZtaT8BM+xoreYR0oxF/gLgHzmPZt4Qy8CRzNMX84XYwCXDnVPKKroysPO/l5fI+ELds8v5e9Kvyp03Ut/M/d/dd3hbN1sJPmNpFrBCIKpXuxxG+nHu4Ni/w7s10I6cabR63SYOTxjn+x1wAlWmsdtNHr1bCWVEXqEUq2KqCewATXN/tXK8Fd6FO0kT4Tv5GceIa1TN7WDIncllxW6MIGLtZRIU7au491wSolRqhHK4nYi+4NjlWhxYLopAdWf3pyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hWdqm+HlXSaKZs10tWuBL6LhGfnesW23sC0jRKcwBM=;
 b=pz5pOpnsrxx5R2yownfJ7mxnss+k/Ow9HdP3tdo3rWXR4w+1qKQEf89O7WeYBY9YvhadATplB6QT73LPpTwXQegAca36AQcTnpCQkLqhwgDr3o2oBfKOF5r5TyqyUp9cikWKucsLQzDiOjzHIhxT7YWOnKQaUKXspOFHXuZHFtA3vesC5k8XHOqPF3s/bmTuwatvvDCVUeOcHGcpvtxAvl6heH/EqDkasL3XzFJETkRkUrhJm6IS06GIlxwzE8HXqXfGPkEWSAFvLgojT0w8okz15Is5kAqnAa2O/v0j6GDfk48LuBUcdAaWUl6GOGbW0kvr2T1HTW73OzFfTaaV7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 21:55:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 21:55:04 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 3/4] mmc: k1: let the SPL read SD cards more than one block
 at a time
Date: Sat, 31 Oct 2026 14:54:51 -0700
Message-Id: <20261031215452.16013-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 93848e0b-d9c6-4efd-61fd-08df37999e5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: PPkHWIq+XSgeEVnQPEnubDu7iXAI6DofpvRNFd0GlwS2NLVeYd3hsb/N75l095jATnyf+RtI2apWQVvU0TncMspNd1VkLAiywmRqu+cX4JLm31DDO2gz8AC7et6QAEZCCbgs3w+2hsPnzXGaD411LjtCUVQe1TSbfs0Lnfe6OFuVGLH+7jHcvYIxO2FQrRV+Q8Lc4XhIKinBzlwCSdrYTAhUYospFarHQWjw9jql/etxUXx02kvVGvbEb2YMi0G0c6AQ4XrrSCRWZ7IjRknvD/qgcRcPdJcgLMNzndXC+A8QJPv80aFLTS6USCnl4r1UmVIyJweIaIRUO+fGSZqWyRYHGTb7KwTLCwCfwg/0A61eNlSPRP57p6i8ofu5fy4VAjtj1w/b28vT/CZO+oB9AgRV9LgGpM7ywg+JwTpqKSMps/bC+NFDnztrMBFBQn9qcmDSae7sBcOs5La7acJZvikn43cfRihP/OIadZJWXRgx/j0Ra/SG4Us9Qf6lrzNCh1zizTmgX/vDoxtWIdY5HAsEMdV6k0akJrokMyz4/EW0H4s6vIIL9bQ4qSza/tWOR9z56hUasbWYWmW8ihm9WxuatlMTGXg0LwWuiNikYA1uL3E1XHKTgIOks2DzTKVwGDsLaA3nzbsBt8a3s+2tmDAKjsErai2Cznw+vxgHGUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cItrO5lh5VJucxEvtv6OVw0pnKQPz4WXO/onyfkOCPp5CTygdSBk04u/YH/6?=
 =?us-ascii?Q?jN/NbeRbPuiWIusi8pphJ8OR2dD85WdlLNGOHtMNdY7D5Zz9t7p4KxG06VIN?=
 =?us-ascii?Q?+LmMmyH0JDTqXK4vljvzYE1cavBSMprgDHOMMEFNtR4DPQm3sOvPlPYkwMUW?=
 =?us-ascii?Q?vWub7wlic+b6Vg9IWWMmH4LXwoESZCD6eQwKOFJjkNFJ09ghJ0eLzZVfD6UE?=
 =?us-ascii?Q?6PteFVALpj+YSqVhurbw6tCGeSn1AVV4pWIzh3NUMV4PfkSVpEpBuWomhbYs?=
 =?us-ascii?Q?T4N+JShIcwktXNF5N9nqVJ3MHbBaQ7DEDBmgkZmLFrf7aXL6nkA9EiuNNsZ1?=
 =?us-ascii?Q?GQWdLwj87QiBnE/bztacVcrqJyhIKphjhBeSEj+lcOJRoBr/orGyun5X4r1g?=
 =?us-ascii?Q?+DGy1DpMixWWuuAYf1xKj1Rar3KbP7ZTCDmRzbrCASHmICfFzU899lOizyzt?=
 =?us-ascii?Q?ul8uI8NDNMs/gmDQzpWTdMfI8NGUBtelNu661l6U/Sx9sCaIGkTvAfGDvO6X?=
 =?us-ascii?Q?H8HN8LUgTzuDzlGa/bKHuoVJnJJIBZrj3bbiITsoAoL6gYrNaORS/mrIQMlw?=
 =?us-ascii?Q?7LIUUcb5ISd7FmqZRlb5lvf6Af0HrgpzUuLBWMrMzlwigOApMj/4lfA2Ilfj?=
 =?us-ascii?Q?PrjKHd+3BQ+GYOgq41AO5RrthQeU+guKdFUk+Ujuw61C0zkuoF+nnGmQ5h8c?=
 =?us-ascii?Q?+aKELCHXWlHLTn6PqPuYAv+6U6dFYxeL5WbnQqvx5F8H488ZOdHoNkb1A7WB?=
 =?us-ascii?Q?HPlXQdUA4ZIBovo+p55nS+XezDL2LWvAIr1ELPBhxmy/ujdO9HpkIk/poxJv?=
 =?us-ascii?Q?PUruU98S8x87vfsEVqObwmTkJkOdbj9eBv/FykOnLiTyRVfRTwjOq7s3BtkE?=
 =?us-ascii?Q?vcElE/n26CQEVRhrVl5CSgeN3Q4077kzrEMtZd47bDYVH7UuXZFcTzAaS3Kv?=
 =?us-ascii?Q?odHfwSae1d5TwJ/T7c9ORtepiWofbw2TBmhmxdyldnHt7rsYQeNQRdv4pkLT?=
 =?us-ascii?Q?cDHPufC51mGKQzn1vMbprywT8rdLL36a8nzR3jvTG5snA8huII0FD9Pkghoc?=
 =?us-ascii?Q?Ll6cnbi6wc1jZ8Skn9pUg9Ma/pApOTsaFKiomKdI8RglxUViJf3pgQTF68HC?=
 =?us-ascii?Q?/N+JMsKnAII1NyhaE3xo9cqvFmhFyOhVxlNfbn2wnY5yV3W9TMF0/MpvPZjM?=
 =?us-ascii?Q?zNguZENU4pRw55zGbtBLBOjmM+qZbE8YbPvIQA9EQYK3TQO6rE/jx4jnIw5x?=
 =?us-ascii?Q?+Cwuglk75b9QV0ovXYPah6IRLyAGz/8CQKOLlqFfUZXIoKoNmY6zumdb9I8/?=
 =?us-ascii?Q?mkyTmOvNAkW9OGyKumCHSeHWubRiSfcXKlJYOxQcvGYL/EtgijPCKL1arTFg?=
 =?us-ascii?Q?VylUim/sd8M5A/1467k4/CjW29C7a6+v7rHTFplf1imP8K8+D/m6WUjzgm+j?=
 =?us-ascii?Q?rtrKhJPw9G1JzXAlkkB0udOJZWtVLfbtAAzOQWPDCX8i3IrHcz+aYjtiUWdu?=
 =?us-ascii?Q?d0ovafNKR1SCyv86mnG036JuiaYeuVXphnzw/pVtF2OcoYkMnO2G/sUez5Lh?=
 =?us-ascii?Q?kc1HZxkn7i79l8ij2nW/7B3OCkWBCk04K3nsHsVbDKJAIqLGTeO0KEY9+iXY?=
 =?us-ascii?Q?HqlSAhNgvIq/F5C1PnFflFVUE7ON/72f7+RGH1piWIv+hPye66DRoMA1Gw0Q?=
 =?us-ascii?Q?Q2QwBCuIEWT9DkuHnbh1tcv94pUwYSdpbmkDgOOPCgkd0dPf776862OQRaQU?=
 =?us-ascii?Q?OJF7uBNOOr1EaoqINkup48BwBPyQ45M=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93848e0b-d9c6-4efd-61fd-08df37999e5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 21:55:03.9700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrWHSLVa8yz83oA3CjHZAc70i2veti7aJDmsCp9xonMTjOwyV0JTEVpztjkknln7QLRZNfWaq92EKMU419dfQNBNI5gb2nkZlR/c2LStSCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Klotz <DaveWK225@protonmail.com>

spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
block, so loading a 1 MiB u-boot.itb takes about 2000 commands. The
limit came with the driver without a recorded hardware reason. The
driver uses PIO and does not advertise MMC_CAP_CMD23, so a multi-block
read is a CMD18 followed by a CMD12.

Multi-block reads in the SPL failed on the Banana Pi BPI-F3 with a
Data End Bit error and returned no blocks on the Milk-V Jupiter. Both
failures came from the SD I/O rail being left at 1.8 V; with the rail
at 3.3 V, multi-block reads in the SPL work on both boards. The SPL
now sets the rail to 3.3 V through vqmmc-supply.

Drop the limit and use the host's b_max.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Changes in v3:
- Commit message explains the BPI-F3 and Jupiter failures and the
  CMD18/CMD12 sequence; code unchanged
---
 drivers/mmc/spacemit_sdhci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38bdd..d3748847e48 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -324,16 +324,6 @@ static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
 	return 0;
 }
 
-static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
-				    lbaint_t blkcnt)
-{
-	struct mmc *mmc = mmc_get_mmc_dev(dev);
-
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
-		return 1;
-	return mmc->cfg->b_max;
-}
-
 static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
@@ -574,7 +564,6 @@ static int spacemit_sdhci_probe(struct udevice *dev)
 
 	spacemit_mmc_ops = sdhci_ops;
 	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
-	spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
 
 	ret = clk_get_bulk(dev, &plat->clks);
 	if (ret) {
-- 
2.43.7

