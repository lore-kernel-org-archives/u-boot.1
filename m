Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E0606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UP5QNNvM;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=m6tr4j/w
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 040774077F;
	Tue,  3 Nov 2026 13:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0LmcFMQEzkE; Tue,  3 Nov 2026 13:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FF2740762
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711097;
	b=jcJLeyzu7gbXMHD/lug3t992jnVBxhzrCpL+ms0Yc2yjF2lN1SoN6bcABiUR3EIfwWWU
	 PucmJxc0MAiDvjgbwtN7YOLxWQQUe0ZzqeXgBSJQEVGX6o+P3Bodzo6SGZVQyiakBbPGZ
	 LpCjwCaM13dtmm5r233Limu/xAC7WjdvAOaoK67vnbZCoW/AkG4OvVnR9GwS43XrNLJLI
	 bv9ELJ1A0kRUnnDHinPr+O67jOIjrfxP2E3SUF2Bdws0/LG/Jlbu/Ts4LKMwpMt1LT1yW
	 kH1ISNNZLoBeh76O/4Vo3I0xQ2mHqBA2/Shu1nBn/8yDF57HuJkApND1I8rTE9rlzQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vskcveY64QMu55LxuWADvmqCBH9/RtxGBMxm4vY7P6I=;
	b=dXZyM9s4Tj6fsRddpS4lPXRghxHerIYlsV8+dGLknMNi4zQr66BqTWPTOhBMSDUuHbmS
	 IWxM7qQFCH51y/FklaNhSeOvBMbImxOetzUAt4Vb9b3pBbTbU/R1yhMAer2Yx3G06oIjd
	 bE5OYL/GpTY/Bw82mxokNSQWVsv2m0OvkKZhdasYjcD5glJwf0VorwKEGMUKMT8jdajrh
	 sfgfHe/Oc9pBg8yct9CIMi1/qNopTbGCUNfyLuIcFtKNG9ULEn2Tb3xYtGqKbFnz/hG08
	 ROUYpxiyZpxdDhB0kAA1BpZvUL7s7cNeRBrVfZfRh4wOj5hYQpkyh8syLKg4PSoZyew==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711097;
	bh=vskcveY64QMu55LxuWADvmqCBH9/RtxGBMxm4vY7P6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UP5QNNvMkQOUY0NyDbyqfmi/hL5WhN9HPF9nGjSs+tchXMoGuc7P/OscYu2CUnc1q
	 WKTccAV2L3B2/Ahzp7IlIxRPsk87LD4rSvnvo1UTORLCCeVge6x7V7d83pL3aHQ8Rw
	 Zy+akha8KHNVzaK2o4DR7jguaniQOeMmPbUNJ0j7Injx58LoUsncR2+gR0/pJ0Mdol
	 nb1gDHnaxqG3r13qW6854GzGF5p0uYv3j9UiyUcJeVc8kfeydpohnq6iQ/hfXp44DT
	 XA5N8sqcfvtt3oyNhPT2datxTr5MHHPW71q8ADxzLIETM4xJhRiaYU+Tln/3imswpt
	 b3bdG4pNWYOfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FF2740762;
	Tue,  3 Nov 2026 13:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D93A356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B0A0605DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsnZzXKClyVG for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7EB4605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698437;
 b=Bv9ptHSmnze+vzig9axkENa9puhM+knWzIQImVryf/7wDtSmz5gfM7dERBgyQQQiERwF
 BieVG56X0Fnfxz71yRrLW02O5G28Py5o39kHaCtXeiRBY1pXC5+Da1nHnv2DXTwNolTW4
 0119jwtVtsP9lS8rGgyRBJT9J+zjBqgPRRc2D+vqBuaQjNC31sR26PNovmGtSC9o4bspw
 KqNf9VQ4/709cH+nBenXCzOwgipBSKhZDP4o2V8771/B03bnyszvH9a2gS9lSCa1DYnh+
 8JzkDj5zMZJxfVbHEB3TARGCs32iNMYjuBa3x7QhrJVAYvR1+0jEzuNA+zsu7tXfelQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698437;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
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
 bh=vskcveY64QMu55LxuWADvmqCBH9/RtxGBMxm4vY7P6I=;
 b=Z0sqtAYBRU67PAhiSOPnDzIEmq/ZDOeFXgGi3dMkA9yPFOBZuJm8rLf4tTgACZUbXsuy
 J3tcNY05VFUvIgj6b2fTsxP7+L5iH5sTxMW1UVjgLHT6fyeJYbaOl5NF+HtQOJ67DDRM+
 tAr+aGmtPcrM4edHifyPR/0/dMJWUb/m/DqoAxsMhfoA4m/oCH1u/SgUGadz1zq/5xrC5
 /UFfwPIpAN1YC+h9RMqxPZO0+k1W+dLYlb1tECpYit4IriQzoZlb7/YNXU5ja82WzmmPU
 l2O5kvCiLzCV9HXBjopUioaUcpVR+qcDpFS4LW0K4bQKwkF1ODhZRuzxgQSYSZrzbpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="m6tr4j/w"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=m6tr4j/w
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7EB4605E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2bIigcrM2lNqodoSSW9uz2vEErQWazq3fA80vPhWCYthyQ3hC7di1cDxIX2MMxcF2tooh2VvRdmF0FXUEafkJ2/F4EpIikClVg2ZFngnt3mqQPFuH0WiB80HRDveMO1t7BouNKJJo+P3dQgj/l+n4rTMBCEp0dpQY8pClO9ZkBE+q/r8WYtK+AB/RuN08tGApCudpZLXycmdtJvupkSNNmN8poyAxUF0sDzaC9qiWwqzUREeevc6oJhzBLpcHm5T8+I4mp0nOGLDhgFdiaZGUMrxisr9xHVcGFklAWu+FNSo13lb0WBJpANbs0CGqWNf1/CJRYvHfjqoLodx5Glsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vskcveY64QMu55LxuWADvmqCBH9/RtxGBMxm4vY7P6I=;
 b=Y6FVqIj58FHTBfvT91Xx/+VujY9YWE2juLbCItHm+J18CxuAzIn85HGQxiW6EhrSakk94jnva/nq/vJ7iMeoiC/c9fwipfMHfed/aKSzQgJeLpaKGOpbgiCj/yTgoD0568ALZrLGXXXfrVweIm6toJ7fEHkYW0EdbOUAzAYLj4OjYbi4P3bM6ws2FLKpgFPxRzLznJe9Cof5qqaM/GLeubH1K636WFzhV7f4602fiwcvMoCPs89SLCcC2O7JaHiIvUgj0hFnlhVpbMsNPMNmYq6Lx1JkQpAM/aZQX/JjMN34H8bd+1a/7FRCLxnuG1CXoIOhpY3jwdFSJvPIT7xaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vskcveY64QMu55LxuWADvmqCBH9/RtxGBMxm4vY7P6I=;
 b=m6tr4j/wnxzff5H7USu/SVX4S1MvsnJVS1wfZd7UqJCRP8maFSsKwU0+hMcYuou2qk3LKNbxQ6F1+3v8iwEh1Iq4srKqUtmk564RrEi3jLrXlqig4XB8YESj5WqJOJpqkDMw8OJAO7/EAfUL49NjIeNgdeT+Dx3XYL3MbTHGayBBg9ayUN6mJhGVcnml1rVfPk6wE+vINjq75iMI+mi+xSKzobZzULOjkvY9JtCqiqZnLDLRDLWnkafTMggApNMvxqRmop3oxUZjdBtWshLaIy/M76nUVTPQOjQhqwwc65dbhd+KpUX6MhNJpCQS3kSu6IaT6AQLjBfVTcn5FcX4tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:33:48 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:33:48 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 sjg@chromium.org, Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 2/3] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
Date: Tue,  3 Nov 2026 10:33:37 +0100
Message-ID: <20261103093338.963328-3-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103093338.963328-1-felix.moessbauer@siemens.com>
References: <20261103093338.963328-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2f5e40-c2b1-4835-659e-08df398d8fad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|22082099003|55112099003|3023799007|56012099006|11063799006|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: NS3lnRX3VZvGUoL2myQ8Wc/tNvUVPOZYHCl52rNysshRwqb8ORlrGuGMnx7RRovKGcFDxSpCsP1W0cW0ATcmm9Pyc02qoUBxK/tksyPZmt5/b+FWrJd739qfjwQvZRDPJOwBQIi94WsZ52BC1GFdpWf1VtwjsiZekCTdKaoaoQf4yVOI07AjJ7jQbCPUoOqq730vsSOkqlm9ktS1NOcHWCBrba0jbLomx7lHWfQ9YdDfRa7xeNWUSstS3fFtZ/JvXnIG2V16Ry2byb9peWxIEplZmqAaQWvw25Vgrt7qBO+drQmHZSivh5xhRp81ou+JAyL+pMAm0Dc0Fd2x4SW8cEcKw9y0hV2rTSPIblQwPt00lHUg9gZGwTCbaDYMwDsEQUOo+KnkRWjdeWwLnvwL3KHvZLVl+1rMDGiyu7JcOtX7+3gUZgUk4fAD5SN0IwJE6mwGhx/0gfCOw9oskeQiVY79LtmOrrYOu9oEbKDAeRmXJ7zkcEbs1+nb3g6is5bpmeqrBoj23B9ucnS8J2dkKtConVVa2DwwsMzmn4pfTrHehPVVYxXeU4eU0P0MGINIUS4alo0Q++oZFkO+4i+mVm02f06etrtA6rr3R+ur6vXb11Xg9f93VA2vwDo7GJBRgAO0wyW0YiRBgt5BrHepQGWBln1R1ZgL7mMKiN+WsEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZAZkHXcpb2qyLvDwa0ruH+13f5YyEVz6UEFyzpi+3Yk37Vr3BCEInUu0eXK?=
 =?us-ascii?Q?q4oHXWadlhYlBvO5ceiCqD1Nfi9toFcd9coT/O/0DgAB1oaXw7Knkx5jH651?=
 =?us-ascii?Q?4JM4vatemSIuZxTNrQoIJ8qb+bM1ZH3VTxe1P4et3hEu3RPyNefeCxcf1E2F?=
 =?us-ascii?Q?5gBZrShu/jXnJdumFXoE/Xq/n/dVsrWtHpBHHPBmnsze5qkvdeq+XaxKtzhj?=
 =?us-ascii?Q?BSr1Zs5G31apUmjWCFVtzoc84WuL24ZM/zyGCSEMMiYMaPUIV/RljWkX5l+u?=
 =?us-ascii?Q?GcVZzBgeIFOsVla839Q72TiE3f+WUtoAVzz7F9Tvx35Jp+JSSytMpb6FFaLl?=
 =?us-ascii?Q?g2EU6/O4AbbLnbbyOGahjMlW4Z8F5GtsKQyoj1+uXpnzLyPOVrlfO+Lc5Qfo?=
 =?us-ascii?Q?Nvpds9BRYIeeGJGvDYL0QGKndLrsPfWQcHId4xcs9S+pQF4/wovwNxK8KG/L?=
 =?us-ascii?Q?E5deowORRVQD+KXRUf4lFWsslxvUifohPs8Qg96x6cmSfvkhdXmVTS0MaWve?=
 =?us-ascii?Q?Y9LogRPKejnNyl1jkQiMQSTpcR8L8An9KwBGvoqv7htpkvEGbsTJypId/lpu?=
 =?us-ascii?Q?hePYCmVWDyr9rNEvu6PKYYDcFvJgLZ9jnKyOsjxx6SIUQ5NiM67f1PJCX6do?=
 =?us-ascii?Q?QOs5orZKPIM9Z7b47BvUdyxaGE6ARih0WuPAEKRok+RKt5wEeLvPyEMJWsyS?=
 =?us-ascii?Q?o10wF3bzstU4HPz2QB+MAFS3mIXuItrby8ZaIxYP0R0QupZXxK/O9ylOGuo3?=
 =?us-ascii?Q?hjI319ATbaF1rPtaGXHRanHk1uW31oAe1gh/Kk98TsUoKkwwjTOD1X9o5PZ4?=
 =?us-ascii?Q?FclYp7SDQ9gLaeDhZq+wxLxDuny40rM4qsszuAz34Sj4DgsFZ4bpPnFw+0UC?=
 =?us-ascii?Q?Op4s83lhTRaotyl8McGunaSHh8OcimqWg83NdvivJ2xnsejySBkvBmzCRxyL?=
 =?us-ascii?Q?/lIDMX1boAa6yBkKWJU/TkVoUmYpTciGKOLT29nEPGqxOkelxRcArV/X9UWU?=
 =?us-ascii?Q?5mAeP05ThDxgb3n/jMyu1sf531q0N2hTHw63nCiQ/ozvPgOZ5aEMUxvpt9YA?=
 =?us-ascii?Q?+0XDtzrcUfxw5YGiR0fKEkCmciuD6T6homiTXsQA1w/nAIwX6txLNt6oA4sI?=
 =?us-ascii?Q?zN7buCufbRerOGjeVRM1zXBYChxDA9USU9hlxbSmpYQ/YVu8zV8tgQ620W3w?=
 =?us-ascii?Q?eTYkG2rRkBUVNAcpNGVWoD6MPFtPvTQEoHfvL2GStUy1hp/DweKVDcxGH8WG?=
 =?us-ascii?Q?eBIE3lE3q/qGbbX0RgZnuk40o03YDBUqLBDhCL4YfFO3orSb2YwyU3gMClup?=
 =?us-ascii?Q?UxM0K3jW2ed9w7l0e/ykkq31tWSz88m94plA1b3UwR3U7SnrP73QMvAlC25r?=
 =?us-ascii?Q?tiEKDlyyainkibC8aWbcBcfuoW5X3a+m/a3o5eDMUv7J47ObsPyaRiQ7qhar?=
 =?us-ascii?Q?lUom7EpmqXZGKLATraPLCKeSoBPBNJAdhzJAMmCodchDVJV+pg5YuYLxd2a9?=
 =?us-ascii?Q?M1Ii5TdXUogKto2okLOVJ/YSC2CYPQ5sXqG8+bZwxlqdg+YEAgpoB9qCFsIR?=
 =?us-ascii?Q?hHX0VrT6+Be8aTkmgJ57du/b7BJvkYEmT9NOeYaayPjm73f4TYRHgr1Vty/w?=
 =?us-ascii?Q?UNXitAkox+o8LEavmSaRjUhHDWs0bCMHvyaSCZNsO8nQgYrws5/W7IzKbEsR?=
 =?us-ascii?Q?TFqyCeWDg2gPusPbLy2yaijq2a70fKDJmF8si3fmW6/srLipqjnGXI8QkBmJ?=
 =?us-ascii?Q?mCM+g5bmibgI+WXfuzGcVY/u8YJSyUE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2f5e40-c2b1-4835-659e-08df398d8fad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:33:47.4515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13JnNb9O2lEb1AJJ8IUchxBxwAXc9iKzVoQrwzOG4zbEbkL5GViHnnV0doUSP3D9HeuR10dqOrwwONK/S3ANabFzh5x2wjluP8k99QmF0uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI applications use the reported frequency to convert timestamps into
time. A wrong frequency results in wrong boot time measurements.

Check the reported frequency against the real-time clock by counting the
ticks between two consecutive RTC seconds edges. Using Stall() as the
reference would not work, as it is based on the same tick counter. The
check is skipped if no RTC is available.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 lib/efi_selftest/Makefile                 |   1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 142 ++++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 9882d9f2748..552eeb071a7 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_selftest_rng.o
 obj-$(CONFIG_EFI_GET_TIME) += efi_selftest_rtc.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
+obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) += efi_selftest_timestamp.o
 
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 obj-y += efi_selftest_fdt.o
diff --git a/lib/efi_selftest/efi_selftest_timestamp.c b/lib/efi_selftest/efi_selftest_timestamp.c
new file mode 100644
index 00000000000..577622327b3
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_timestamp.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * efi_selftest_timestamp
+ *
+ * Test the EFI_TIMESTAMP_PROTOCOL.
+ */
+
+#include <efi_selftest.h>
+#include <efi_timestamp.h>
+
+/* Give up waiting for the next RTC second after this many polls */
+#define MAX_POLLS 3000
+
+static struct efi_boot_services *boottime;
+static struct efi_runtime_services *runtime;
+static efi_guid_t efi_timestamp_guid = EFI_TIMESTAMP_PROTOCOL_GUID;
+
+/*
+ * Setup unit test.
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	runtime = systable->runtime;
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * wait_next_second() - wait until the RTC seconds value changes
+ *
+ * @ts:		timestamp protocol
+ * @stamp:	receives the timestamp taken right after the change
+ * Return:	EFI_SUCCESS, EFI_UNSUPPORTED if there is no RTC, or
+ *		EFI_TIMEOUT if the RTC does not advance
+ */
+static efi_status_t wait_next_second(struct efi_timestamp_protocol *ts,
+				     u64 *stamp)
+{
+	struct efi_time tm;
+	efi_status_t ret;
+	u8 second;
+	int i;
+
+	ret = runtime->get_time(&tm, NULL);
+	if (ret != EFI_SUCCESS)
+		return ret;
+	second = tm.second;
+
+	for (i = 0; i < MAX_POLLS; ++i) {
+		ret = runtime->get_time(&tm, NULL);
+		if (ret != EFI_SUCCESS)
+			return ret;
+		if (tm.second != second) {
+			*stamp = ts->get_timestamp();
+			return EFI_SUCCESS;
+		}
+		boottime->stall(1000);
+	}
+
+	return EFI_TIMEOUT;
+}
+
+/*
+ * Execute unit test.
+ *
+ * Check the properties of the timestamp counter. Then compare the reported
+ * frequency against the real-time clock by counting the ticks between two
+ * consecutive RTC seconds edges.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	struct efi_timestamp_protocol *ts;
+	struct efi_timestamp_properties props;
+	efi_status_t ret;
+	u64 t0, t1, delta, tolerance;
+
+	ret = boottime->locate_protocol(&efi_timestamp_guid, NULL,
+					(void **)&ts);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Timestamp protocol not available\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(NULL);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("GetProperties(NULL) did not fail\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(&props);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetProperties failed\n");
+		return EFI_ST_FAILURE;
+	}
+	if (!props.frequency) {
+		efi_st_error("Frequency is zero\n");
+		return EFI_ST_FAILURE;
+	}
+	if (props.end_value != ~0ULL) {
+		efi_st_error("Unexpected end value\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Align to a seconds edge, then measure exactly one RTC second */
+	ret = wait_next_second(ts, &t0);
+	if (ret == EFI_SUCCESS)
+		ret = wait_next_second(ts, &t1);
+	if (ret == EFI_UNSUPPORTED) {
+		efi_st_printf("No RTC, skipping frequency check\n");
+		return EFI_ST_SUCCESS;
+	}
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Could not read RTC\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Allow for the 1 ms polling interval and RTC update jitter */
+	delta = t1 - t0;
+	tolerance = props.frequency / 20;
+	if (delta < props.frequency - tolerance ||
+	    delta > props.frequency + tolerance) {
+		efi_st_error("Frequency mismatch: %u ticks per second, expected %u\n",
+			     (unsigned int)delta, (unsigned int)props.frequency);
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(timestamp) = {
+	.name = "timestamp",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};
-- 
2.55.0

