Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0249C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89F9E60626;
	Tue, 22 Sep 2026 02:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YD_bNHAoCsxx; Tue, 22 Sep 2026 02:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D271560662
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790043599;
	b=bpIFeofB1eeyKpajzxCeQPYu/NU9VpOAHi3m8nVIGfvwa+pA41j42Wel+blm7f6mD15a
	 QdIz9CqcTIi1QebM4XprkhqU6TmQjSOjwnUvLXtz+el63QhwuCNr7dOkA4uZRfuydKvgG
	 JxqU9a/pd8zyzZ8BeNz4io2aIfocbftsJbXLUvQ6V/Skr9DmjqZsNKVQH+kthw3TApRvO
	 5J8uvPiGr3pbXmOBmxnQ3SAr/w/xiYieWc89E8D0GmEVlUI0XmxGzfKocubFjo894GBJe
	 LIYGD1GPjrms5E5vasKSKh4eKwjM3NQ4mV/fc5h0+r9oGMe86wEVI5eO9z8Wpmu0dOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790043599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aLQ4r8ZHBSZlLMDTi4HuI8bDiqvWmKI0Q+lZdZ3RgDk=;
	b=J7mKMA7n4zowdqrw3jR99x3HeiNw7npgEGhK7QxNb/PvjJZAjm4i2YuDKt77itUa8G14
	 wRDnV5c3BCYyMhKb49JBtC69Qs87VR1d0enJqFSI8Qvjv6Hqg6Q+xbvEQ4yn9QeFKD3iz
	 ZWU7cybZVV43hQK8djaad88R8JVKO8yjGrcQ3z8L17MN1rOaMaidHDxWvsbFMo0KwF6m9
	 tTb8wcLGXhJ4IWlspNvr/sKAvPVJuOOikXQAmT1NDS/owod2+ElnMa8St2nx202lLydvD
	 6P0NSsXLvxMpjOyXEKYPBJhPpk3q3nrXeU7e2rb0skZ/RqwDHhspZ61krYYyOSigzlg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ho2Pc2TZ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790043598;
	bh=aLQ4r8ZHBSZlLMDTi4HuI8bDiqvWmKI0Q+lZdZ3RgDk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UrRotkElb0hi8QbSWLBJmbZME/ZjotfqzxeVqqH0sZWC4Hi7i/i3wzg4UHfnkQkq3
	 Gvy3qB1Mlah4Lcxum659IUO3DJ09x3VDgYF9J4gwzinJ/LPwryy2gfhK7DTJGa10b8
	 AdPUjSYKFi/Qut5AlBFiUoZXx4lWfX0V4n5voSpT68PZIy42d1YRImfUCTDkaj7dRn
	 swRZTBQ3gTHY5UgP6VitJZLegGT2l4Yf/dwl9qB2QbA4Q4nzfLVV9wyzzMYluo7yj7
	 YzViLh12LoRcNiNih7BomEVmESc4fFv1sNdUCB1MlGYHRv7fJmB9U/mberZOBDw5v8
	 jVoHeTZE1tFog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D271560662;
	Tue, 22 Sep 2026 02:19:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CCEA89D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 914FA60662
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVm1mTKXhe9G for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3996E60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790043596;
 b=CVbJ12zgKmv0GV3G/fm/7wazsO20YqP/7fmNtw8kwRDsTqlBHa4l66m0jDhr4BunvsAw
 2RkOHZSFNTH46yQ05jzok40jUEZjaXxiuO9F1dfucnqv9H++dYtzvRqjfi5ymFN7KA5j6
 nfgrWpaKfABx8E2c+EuD8ZNZ5v8ol5l+rrPl5e9cE4zwlaT/lQbXeaNzcRHjqTfClReNU
 p46eEtmEVcf/nHijhG6jmdGhBrXrzzzLZuhn8PX1VeMZhjlyb3EP7SfCqZEh1NdYHVJGd
 hNav0IksieSvNRYu/Vo5J+Vd9m9h+dpW/lqVGCkO6fUvQd1/DZ6N9QGVcWNdFzmnFvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790043596;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
 bh=aLQ4r8ZHBSZlLMDTi4HuI8bDiqvWmKI0Q+lZdZ3RgDk=;
 b=Upk34wwVQ/WSCwuQTp0YOxaKC8FHRffLMfiP95KHk+accxIv91SDPsc4BkfDNs8tToT0
 pY/BrH3WteTPpD4e+TFj9seOp24BCRGn0Mh/8uqTDvZn7wwkQhgqb5KZWNusouciHGiBN
 sewqNrlWJq0hdtWJRNigIHwCrhTbWQ3A//utJSjd2FBmm99U9+U/B8qK5KrCsWGqah1tY
 zdogqrCXZU2MQYaSrcfFwdWVNhZToMIwmOZz+Os8KeCU0CKrXXmz0J3rmkcuRoftv8+gp
 chiPUonQbJN+9V6gCiv32BZxQmJpFIXelt0rfiN0w3qZazx4YMORUX8xnxkJmnKsYlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ho2Pc2TZ;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ho2Pc2TZ
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3996E60626
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hheQOxLhxU7uX+ANWNn7UJDj0kAOZc86U6kt/BE9TgPGsRJJbVDAMtlnXjWgi/Fc4CLywkIk6ytXOA4aIO51p0OIIwwrcp4Q7Hw8ItnmSrWxvZM5J8Aji3zHOb8EeYpqIxImbAMMXDbhTH2v0mXRtDmrXo+gVM4zazaFEuaLBIQ1DFwetLEMeR06cTPuyzAQDcmFjWRQfE9zzSX0JCH4Id46HLB4Cmp9vK9TjIb9ky+9YaQors+7B22xXlQ39LgNg+4TowZUHEa1jM5Ocpevz/qMfzsuf32WBQRlH8IoYCQGdCfqKPw7d1yqtNyel5k9YxHFtBpXBCUeDRR4qfgqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLQ4r8ZHBSZlLMDTi4HuI8bDiqvWmKI0Q+lZdZ3RgDk=;
 b=GjefEilvQQzllc1djSRIuSTyt2+MkfFdcP+0WSmcS1NQN0fmBmpYg6Di3U24T3TUsMaufRlIYXe0nlCdN2W48nzzWoXoxPowikWXtkZTWVsnD7TfWPSl9aWq+US1PWaPS2Cir+hhAjc6/aianIWiijga9x45akD2qpPrCtb3AKHTEH/5rK80PYR4uZHZT3A41PQJmLZX4cbhqRUJyGLlj7+RgxjiSaMI2ThDA4A66PicNWgnWZZnJViJtXCaAP4EasSFLUH5YaLR1x1kh7SZJBHshAQYLsbipE81B1/9xs9pKuGd33Pf3rCEaXyle2xcPa1cRub5y3aEuRhMNqqk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLQ4r8ZHBSZlLMDTi4HuI8bDiqvWmKI0Q+lZdZ3RgDk=;
 b=ho2Pc2TZGwi85JydjWIxQHDcxlBmS00faKfYwYDfniDwNAPhJva5xg4TgHOJgcjgOejH7vzt6r8IwjohBkTAU+hP+W8RIDuN3WZOyTIuPIdYxeOHGtCEljTUohdUP2abyT7/95/dRXbW4fARYb/9PD1384pBqRSfqGmsqkJu+JYC9FKIp8Q6vlJtnn7QlVpm6amoPVMtKD830O/3R7Ya7F7y2SP22t4Y+dwcGlqbAp6wTq3XfJJhf0Kb22fdgsIrLBbQ8GMYdoVYg+vnyh1GeUfiO9M8gD9vPnkaFJdc6nA8tPwIqsjelzOgpTz6qmdan7SZ2kQV9//zDVgpeSUEhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com (2603:10a6:10:14::32)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:19:50 +0000
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b]) by DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 02:19:50 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and U-Boot
Date: Tue, 22 Sep 2026 10:24:02 +0800
Message-Id: <20260922022406.1838737-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DB7PR04MB5130.eurprd04.prod.outlook.com
 (2603:10a6:10:14::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5130:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c291816-9f07-4453-43f1-08df184ffa51
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QGqbRV6ErkyFWb2R2Y7XywMssl00Yxke0MsD1A+JWWImWNQC+gKBUbeWWve4VciH/UyvOLKsLxly11kUfhvFCm/k9mXggoqDqboNSyBNHn7mRgDUK+Ng0SFbYexerZ3Hcy/xQkDxGp2yUfk2RmuL0NewI+l6mwGUGYi1CpV03we2sPrQcWWCi8sdNTqlx1neH9zuDq1d8R+MclwgmYxTST49mzNtncAkvzmYaTR+rOs9R/eJ/AR8eR1j1AQ7IFu8JiEj74xAJjQeBw5SO4WjJqxdhagOFUz/QdAIi0T2iivQn9DBecxwtcY6dTwfujbZ+TrhJ3mCy3M3OuJ9nk0ZJ5qp16W0GMpH7fnO5XO0f3yea77nfgiSwqvDAVNuzh5RgQ3vQHZGHY1mv6OyztAM6YsXERSupI9U3DGg+pqE7icheEiGkG/JroZS5AfOSNKEBmvIGQMEajByIncgnHpjTcurq3iqMvIrUHjyNltNlPz06OLV74HkADEkLpz0nVI2EdE8I5ii7nMyajINOemoo6YglOsy2nVFx+n152hKt2X0DoRLq+HmtBeZcxJLKhtKNPRhaUrh4nWH8FFj8ezhISRK97MeVLFPHe/PRbpc8rOhjqSr3iNeAz8p9cXk+vmgrEgWk3Pb5VdqUQ/X477fCc24cgtqFtVip4FE4r++lDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5130.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2hTIswqPhntD116FqFf6w4sSRjne5UjlzGehitGbwgDjO6vRMsPUn5LOkKv?=
 =?us-ascii?Q?9g+xDHShQ57RjbMcswJrXVtE49FkDC785K648awSA5yevfXmFd9Q+AWgXOzR?=
 =?us-ascii?Q?SepQuUIQhhU/dO6gdQABizEe5y0/asYw7+u13pLG8ljHKiTSSUetpoV8cThL?=
 =?us-ascii?Q?h0TAapqPmAbSAIWDRXcD8OqIMKSAxCjvOtplVFicyEUnI+KS6g5gyxeG7Uqo?=
 =?us-ascii?Q?RyI2mv579dLmEL+MJ4O4zM7cHTVwneFeijGJvwcRDqBSfo/SVwC+9Dg30q/y?=
 =?us-ascii?Q?oSaeBrcTmU8T1Q0oujipV/MF+MTgJpmyAQIFAkYt2mB4J/PwGC5TjChyOK/P?=
 =?us-ascii?Q?JuY+0VegNcvPPhDw1V78QRaqgZC/KU4Nj/IE2XhQt2HSe/zCgyF5MRSUO1f/?=
 =?us-ascii?Q?ud1tZ0GkZynfLZtDGIgua5N1hzk9SXRGFtpeqdWP3dPYWE8h+1HuVvNf6hFf?=
 =?us-ascii?Q?GJDGxP1sMhpwWtvJZwnMdsivaiwRSO8hpdnznO0yvZpe/+6ki2uMgsAQwHgd?=
 =?us-ascii?Q?pPdJegudPJqgUSZyIdLc3UEDY/YhdRGwjpAsT6R1vuzOKulBOxj+bNlbY0Ie?=
 =?us-ascii?Q?yTeANmlLlfGwqBfPybREHm+fg8k2B4DUgKrgbNvO2vdNTdM2Jol3DowPST/5?=
 =?us-ascii?Q?z70bDosE8G0Mx0XPvRFaM1Z8wMWs9ijkG2x4HsGP3hEyVGP50R/4esL4bS3t?=
 =?us-ascii?Q?XPAJctBqU+MA9uXJjSbmG2LFwUKRn9PvTd8id+lU8EUB7Ja39L7Z66V37aMR?=
 =?us-ascii?Q?8tFepmWny6LFGWik3h+W7TJGRz4YYJP0P8if2Uqm6NIOOfdPnwep8S9AmuIQ?=
 =?us-ascii?Q?oXWrXgnSsDKqyXb82Uy/qiKbVpvWgO3r7TaJAjTR761tc9L36bQKCQyXKXr4?=
 =?us-ascii?Q?gKZr70shrvKY0a6JWSuHaiyhHVaTUzjM9863SDuTcpvjAV2kJek8Sa+A/1Uf?=
 =?us-ascii?Q?ArjRd69+UNpdtO5nq1owQbbxMJRWR0VKcyGysUOcscfZxIyKoUtS99mH6dfk?=
 =?us-ascii?Q?YT/hOfN0+PWZ+uyXjbVf0Z0Z5VG5IYRtYKwE9MmLSKTPlRn9xk46SApsUT19?=
 =?us-ascii?Q?YyEPXJxZJtvOBhUIit9fZotXLDBi79lW+WIODPqEy04OXXJKR5fXlonQWb2k?=
 =?us-ascii?Q?nIHul6W9pp1rGRPwt/SOx1NNC3MQeQnmcWzKmtq5l0H9tYBleC/dlJFyzdrZ?=
 =?us-ascii?Q?xsdQqWXGJO2zgaqcd3SmJRKSxRdbHlfpt9Bf7mQqRe/EDBmZWVVovfIYZok+?=
 =?us-ascii?Q?dW0pMnaqbUgsFxZ58u6Jzt+HG6q8FNfpcrqMWh/LwqOisYOMdopx7yCcMNcm?=
 =?us-ascii?Q?lTtvngk/+tG2dsuwAcXYHpLY7VYyTja4DtvsuclXEV0iDJn6cKTFLj+MOgvz?=
 =?us-ascii?Q?YL7RR+1LGtz30/lTBtne67m0DGv+lhGjfRNBscmfN6gakN7UbwqEpgdfz+7T?=
 =?us-ascii?Q?bFry5Qhi+HVfEutsErARsw56bi8Pfg7wnWzV7MhMu4NaV/nAvKdpGcumpKOO?=
 =?us-ascii?Q?qFyGANljC+Qfv64Gn+czbp0zn3nHy0JoZzCo8ZJumxNMJ0IaB7eJ0+eH1e9h?=
 =?us-ascii?Q?VNHf2Us6xaxwDFKJq2VyHN28xpYdmgBDg0r16tW6DALjh1i9CDt5eZcfMpUN?=
 =?us-ascii?Q?9t2XbV3stzBRqWeBH0snk5lgkiM80yZlGd3+X2/+1+R8MTdO2kUcqHHXv1/X?=
 =?us-ascii?Q?TbPmPTSdfvm6doskV/KERsNT8SVMqoFFl54pWKosmXdgnQL302ae2IwxSGoH?=
 =?us-ascii?Q?dkhBendu1WBYAExcQMe4FDyW9PhZhqA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c291816-9f07-4453-43f1-08df184ffa51
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5130.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:19:50.4227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olDT6K2YvGOo+7GMynT0+jRtrdZNiEnJjUv5jzxCCvrOx2letOrACe4KmEh1t62cCONnifkeIm1D71nJolnN8/M2AV861I89FTnPw5WnfDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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

From: Ye Li <ye.li@nxp.com>

This patch series enables icache and dcache at the earliest possible
point in the SPL and U-Boot boot flow for iMX95, iMX94, and iMX952
platforms, significantly reducing boot time.

On iMX9x platforms using SCMI, the DDR size is not known until the
System Manager (SM) is queried via SCMI during DM init. This makes
it impossible to set up a full MMU table before DM init completes.
To work around this, the early MMU table maps the entire DDR address
space as device memory (preventing speculative prefetch into unknown
regions), while mapping only the low 64MB of SDRAM as normal memory
to cover SPL, U-Boot, early malloc, and the stack. Once DM init completes
and the effective DDR size is known, the MMU table is updated to
reflect the actual effective memory.

For SPL, the secure DDR region (CFG_SYS_SECURE_SDRAM_BASE/SIZE) must
be defined by the board to provide a location for the SPL MMU page
table and cover the destination of loaded images. The first 2MB of this
region is used by default for MMU table. Boards must also move arch_cpu_init()
before spl_early_init() to activate caches before DM init begins, since
the main target is saving the time in DTB parsing in DM init.

Measured on iMX95 EVK booting from SD card:

  SPL boot time saved:    ~87 ms
  U-Boot boot time saved: ~402 ms


Ye Li (4):
  imx9: scmi: Move WDOG and GPIO init out of arch_cpu_init
  imx9: scmi: Support early caches enable in SPL and u-boot
  spl_imx_container: Fix verify image after SPL dcache enabled
  nxp: imx9{5,4,52} evk/frdm : Enable caches in SPL

 arch/arm/mach-imx/imx9/scmi/soc.c | 156 +++++++++++++++++++++++++++++-
 board/nxp/imx94_evk/spl.c         |   4 +-
 board/nxp/imx952_evk/spl.c        |   4 +-
 board/nxp/imx95_evk/spl.c         |   4 +-
 board/nxp/imx95_frdm/spl.c        |   4 +-
 common/spl/spl_imx_container.c    |   2 +
 include/configs/imx94_evk.h       |   3 +
 include/configs/imx952_evk.h      |   2 +-
 include/configs/imx95_evk.h       |   3 +
 include/configs/imx95_frdm.h      |   3 +
 10 files changed, 173 insertions(+), 12 deletions(-)

-- 
2.50.1

