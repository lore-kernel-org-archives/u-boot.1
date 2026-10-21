Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427B606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FuWe0xgh;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KZohAHmp;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KZohAHmp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DF8F4078E;
	Wed, 21 Oct 2026 09:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWRIFfqKynaU; Wed, 21 Oct 2026 09:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 027C8407B2
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576340;
	b=Fl6z7fCepToHJvqIw6qb7Nl0gBwIATdd83yji7zogUf8hcxToLKWQ+4WNwULRCvjlVtu
	 5gQRIFdw43K/wBEWffUF+sswK+K7SatDV4iuO+a3v7/8cA5xMzk9op8/fjoyj5anpkejF
	 LpKiNsWts0iwMXGwB0sMkTUgTP/4SY/Un1rhs1sL6yeDofVPYfNABnSqNCeuq5VQkiZEG
	 j+i2bOOd6GbnQIaTxi+6hQJQkHzRtSBRutoHI51ZDrAsbsjCgmA0klmb3/zMAAF7Zq5vp
	 zms/2ZMsvhyuhW5W3LGvnAmfT1951qWnPmjCr/OLc/kzXEUbRASO6/HlDelSfw/GUuw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
	b=GDzX5XKBcnq8qCPVD2vk173MZIYjG2rAGBcCQQwaD7MmB94MSJ+rMxNVcgvSVBt/wIZq
	 SvQjmJQDCW9401/KxTjjtA5kaknbiqrKgwlhT8jt/BVR6vbMlagym5GV9BPgSwXkv2hao
	 vskAo52BHdmbaS/u0Tx0ujjdsmthyNCP+cynOOiV/q7V1Bm4RYJoygqMig+fTDyEgwjT2
	 FqMdY9l4ecqGOlHOFlQRzsNc6jV3bJ3hl9CHNLvulELPIvuLN+ZYR+wttjKMjWXC3jpwn
	 J2/3H0K9gnkdGo6m/83bdnPLJ8Oc64/pA225mg2429ylpaCsPD3AX/YboI3FsgmMSuQ==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576340;
	bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FuWe0xghdySgJCUGqBwJPs/cMqfC1qJWFyuKZow7zLzQDCnxSxocCuNOl8/DAblUp
	 6X4oGaSvZo8+LlxWvlgo4xFlZlRR3mLAcG09M17cD88E2YjAQeUQpEqL9uOjvPnxu/
	 lisIcBpWvSSJ0SIkFRU8ORff7sQ054JVpNv8YVZG7zRO4AkMzq2YMyCZuG7yoOeQGv
	 5277hogvNhSVGNk3HfrGrGyhaYtl2LeZlmZ1Qfb7eG2xmyVzDGf53ZB5wjmkmK4dNA
	 jO6G9cZN4MlEh8Gbc8hHLCepurIolJTDJNkLGvR8RRdZXueIQLMT9PuE5cXqsGiOn8
	 pUKbngO8TZniw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 027C8407B2;
	Wed, 21 Oct 2026 09:52:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A051AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5CFA40062
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjHnzjQd0Jex for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42F5740060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576337;
 b=BP3myc4TSdAPKz8qI5A4CYMgAPE9/ZBhXQxP4+ByJ6JE3yQINqyjUxbdsLO4TDC7XQyS
 Ub1ho4cyva6S/VG/B5c1B2GqsJzMwKxTlEgTKKIkAuddx8inc0c3cNVHXvrG72CYya6hY
 SbwWiOe4kzS/Ot4NO6VHVXoye9iC2j5xNgABmIJOUmOjHyTW4ejextcvtzzgw6GSJCe0K
 ajiXAj1z/iExHLiSAI8HeQ055krtGVbTPVhcFs3+sDHv0PvZnooitdHPSJVOr36bSG+7H
 YwLlHpQHUQsu4JdyTqe1Z9FrA7zQm22SiSMsq3rE5pzUFWX5b4gymqIXQBjZE/mYdzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576337;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
 b=PADKlrsPYMDqtzGZw7CDiCqqacW457hXkpTP1KrIr59OhQlCL11zzzpTWh3+VseBzRE5
 25olWOCkpUdcDApZBgXaT37KpFpgBKKwmPatf8vthWr2Ca60848Z6tEtMSh/bArVMr2/A
 C/2cEgeC3k17cYDBxJlUSPRn57Ev2qeAdRLt/kqZCRxQgi4llnVds2t0vDu1yH0/UaMdH
 xrUAYYL6nLpYCl3acWboTdm7S468TOGyO6SzmPdlg9f9bg5dVToq3abZfZtciJWSwkW/c
 sHAq1R5GRLwOK+NXeMoRX8Fk3gyafliwpZf+W+e4f0P0oClCgeKQIjktmJMdDN848EA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=KZohAHmp; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=KZohAHmp; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=KZohAHmp; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=KZohAHmp
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42F5740060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Gt6009FEIrUrLhYD9QIjLk36rR0+iB3zrxAc4BOh8PRFfteGbfzZeKm6xM9F3GgsvOd9AK6ALpBOmAJIgZrCEd360TJeZnVacM0vqfbUYdHuP+txT5qH8Ue/YtD3R0xE1ZEszbi4p3H93Ea+ZpsdF2bK9kwrUH0jHabBxrwOmu9OJIkd+QDr9Y8TzhHGrD9M8JsHVFDCJsbVG4CjLPHfNvYrZNB8xjaUYS3/hgLPwnC9RYwT9xiBLyv3GbdyUMbsvp2rUeNQhvtsoT8SkA993rI11hbFOpK8PS/GoyUV36gU9m0cuDkdIN4/3N87jta1vhvdq/HJ3yUpM0vJAqxHEA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
 b=NV0252Ye3O8SCDtgLeramvCUY6k4wzs458mAyUfCA9I0fOxbdaiCwmg1cUkkI3JoH2dk6JAQ0YbnPfQjXDd5ceEznDXdhfXPSwC9FganuKglJEK+0/814c5boXxlhKLKqAovDlBImHH0SUK8ttgPwfS7irlktgAfhqMHnChsY2C5tOvAdilNPGJi0RQKhZ+qdO+5onzDt9/I7AHhNtuUAjxUxmnUyu1lnNHhGb71ks+M3j1mp8e/AmKNSJ9Ukj4hIrJZJv7cTdOLZ/6H+EIZo8kwNON2CYUVqmJXky2wB4+yTFkRMxXdEG5K/egALtopH7U7XgE83LDlf6XQ/rj39w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=pa.msu.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
 b=KZohAHmpdCUJlldTaClnKETOQxz9hu3jATp7vP/HjXTpKkBotrV8L5CcXxWaCFZOMaPZu+QbqU4sKxFTi3Rt2FLdYoqtG6tgPIyAHsGvaO5IX1oImYdv4aSvku8eU1Ur/Uvm7MAx+wZo6udT8M6S7WdvD+yK796qmtCvXIkW+LM=
Received: from VI1PR07CA0270.eurprd07.prod.outlook.com (2603:10a6:803:b4::37)
 by GV2PR08MB9326.eurprd08.prod.outlook.com (2603:10a6:150:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Wed, 21 Oct
 2026 09:52:05 +0000
Received: from MI3PEPF0000849A.eurprd03.prod.outlook.com
 (2603:10a6:803:b4:cafe::3) by VI1PR07CA0270.outlook.office365.com
 (2603:10a6:803:b4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:52:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000849A.mail.protection.outlook.com (10.167.240.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L97W1vsEO3bw+f5wjIU9tv/0ZRStuaGthCcuSBims57odmFNPFQcpF6TO/RP5HK/gPc/mqWNuG5zCKGGv4beOkWaJWwIQ497cwg0OtuX34swgPedims5qJBx8E4qh+b+8jaSVKnWZ7qmphMs4pja0i8tD50JFPgDZ2frklO9f6kjJH0Ci33w5QVEDGirqU0EHxSbYMrx1QSPkuglUcanKbyY1iQa29y5jJpLKzCiC1TzhQ7L+xa3crnrbYuIrKV7zlTzvbFYe3+ewVmAjpEUUdjxF5Zdh/bYfhjqgfmq3UEcmUPn6Rxrmx5bIrn5Eye8y+QagbV5/zfAl7PDXxOMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
 b=B6oJ99NeVT6AdMkAS0MK1nL5pcevCDh4/7Isy23oRDfsUUIpE7OBk6ax30RHSAjSJenrufaXff6BSA5Khw2EDjflwouqM/Hq3NqyKvf64b64SYvKQAWTxyPgyPSKQsgbVZK758DHZ6Vg9g6OHqInYjEL1ccuMYH7gEefhgZMw1YWw3a4Ychpsu3mgdErBRqGDOvPxe0WEUaszwzo28KvtiD6Vu+CXtnTML0XKGwnWbRHI1MhcKambW1agZZ60FoZH9V4fhZZAycy8lmq17YxtzikbaRzZtfcTHC+6vs/9ac/Gvztthu9p1uDMh1C4GdYVfEjx2bc63t2xwS/fx9w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a70yYoW25wIkeIGfJ7awloFVPjiKcqFzoriDwHLOabQ=;
 b=KZohAHmpdCUJlldTaClnKETOQxz9hu3jATp7vP/HjXTpKkBotrV8L5CcXxWaCFZOMaPZu+QbqU4sKxFTi3Rt2FLdYoqtG6tgPIyAHsGvaO5IX1oImYdv4aSvku8eU1Ur/Uvm7MAx+wZo6udT8M6S7WdvD+yK796qmtCvXIkW+LM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9977.eurprd08.prod.outlook.com
 (2603:10a6:20b:636::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:29 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:29 +0000
Message-ID: <d3d44d0d-74a1-40e1-bb06-153f3e03f6a5@arm.com>
Date: Wed, 21 Oct 2026 11:51:28 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] net: macb: add 1000BASE-X autonegotiation support
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: u-boot@lists.u-boot-project.org, christian.dreher@nanoxplore.com,
 claudiu.beznea@microchip.com, Conor.Dooley@microchip.com, nd@arm.com
References: <20261015170233.56389-1-nwhitehorn@pa.msu.edu>
Content-Language: en-US
In-Reply-To: <20261015170233.56389-1-nwhitehorn@pa.msu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9977:EE_|MI3PEPF0000849A:EE_|GV2PR08MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb461b7-0680-4b28-fcac-08df2f58f5a1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Co+RgPw+4Buaoa9vkt4bulG9wrclforRbKGVOGleKrpJcEhLitVwFftvBaaW47Iy7O7aWsdbO6jxLCu1kjanp4CpimM4/6kAxTmRWyVzYgriB3W/vN5/PhtaQPOADNCXTNmn+RNXZBdfglDyCOp52R05xbBEGcks9W/EBy/TWn5e90Ih+DWgUfRjBPnEdwCoyXXRwetJvC0HeH+azRgfIf7cI9zsK4CC4GOtQErFtJrcUGQ1x2oDzR4nZGIb9qXbmtmEqQ55Xo5w6NVNyl7G9VB2Qo12hvETuIaAk+07neAfZEkeT+t4H6JvRj0BaYS29OyQ58LEaZ5Y5PileyhQg9Vd/GzFov7xxGyUTB4vOlFkH2VRJW3bmB2g0wshwo09HfaHQMITBwCAhZzT5c6+Nz1xi7TGSvx8ZOB8Mn9qEgZqyg58KnLXiCEAmQJfxacOv8tzTnnPTPKhUvRQ+StZMi61+6Rr5/9UX+h4aYt85lotKDLYoVoIilI8dRtojaMCp4BorEf3ZWQbGmBC4479WcTgYil6rPwtkKJn5HDjgekuVYgplvURvvL+T7bZcAd1WvShrwuzGfZnQgGm8s902ORxGf2frSv5v1uMliSsMTyKT3o70yH7JatTVh3K4yaF
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dWr9bDQXPA8P9+I8TP9VJu1Xg5KpHQ+gh5bvfZlik+oroB5jEPEGBrav/HHWXfZjJrRaL3oZ8d59s5YmakHxFM0uwGVT9ElUUu0Z7XqyUCS1ubVP8Z/xTmMbhTO8H/RncAjJJPwaDWgedWOYuUKyNTZqhIizFB24bGSaI099C4qlZtCNTR6Ub+AgtdMbaPFFu5qOU3jpO4pcXq6Lj72t3zFMXdVwcz3Ov3V5ePG/zbBru96fF4D4Hu/5tv1Y9NYKrCL5Qjk1CIiECG5KTv/OQ1N0mTMK2uG/a8IKp53pu27q9dD/dMlW4ZwWcomzAQWoccMTB/ghYUeB30odNMacTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9977
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000849A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: af58add9-5b3a-4a04-99df-08df2f58e182
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|14060799003|36860700016|376014|82310400026|1800799024|10067099003|261009223027099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 11CftPC0dx5gYgHMJWI0gIO9CqA9X/3nAqKL0lbYmM23VUK/NlD5r3HG3acHugNLBMABLnukQA/aAgk4/E6Qlt5iUp852FX0lhr15/A1X9718BgIVnpP1BVvoHZ1HvEmKbbIfXmvEAebAo8U+fsYrlEf7wpLR+6tkgZ3UgBSQwDGqJEg9d2ax5Y1o7g1B7GvLDrWfTflqK5+pBsfmvy0MPlxtkPz7sCx6ZpzkT6D38ZcjN+LakTyuID6CGzVJZTTX1eiygKDv2grsNX0MaDaB1HtpKI7XAin7NeykfQwO6vXpI8EAJV12syBG8CahoqOS3PUmh5rDonrukWG9QDaDxJx/P4+E71X3Zq+/2Vx+layNlWpEFQyH4FE7ULC/Jr43DLLg4xfcEgXW9+QE6sPh7C7RdPecrebF5bl6YsJBkJmeEmCooky9qwBEhhgPtjJ8llBAHANUK0Cj/4pcXHvSODVqpCnPb9tReLX/Yb9UQuM2Ao5RRbaI5kxwHfB/s5xUynkfktzTDzEp0g70DKZTkIcC4atODAwHa7200442M7mIN9/b5BFbKPG/SyGzUdwsFwId2nnQSviWB3v3ajzGjXSyi3fDXWJr3Ub9HFmo7fcZApRUPw3ivntEkDoBh81QqX7WZmO5Ohi4JN7LgISyhttQzF7SjDRQ+R2634Y9Pg=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(14060799003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0520xysym6W2r8gCVL4R4/JFqYSokVX3TTKufEtMzJsv5A62VW+TilUtdMDBJXRc/EjAaOZhXF8uMLVvLWOdWIFTE/ouw6qroSQit1MQxmjUgqICiItJ/mbsHw1FOebeOZ6HRwHWHeH7204BJ1qNpcv5BKSqRMRvYIN6z2F6rrJkDc7Msdu12Qyrr44iE5GygA7+14IMwSYMgE1b24S4NXfIPq1Ij+XbCK7+13tln3bNZ7a99lOeOsP1sD4YenALF9IfV8QIpIxWH/JacKio8o7JjVKw9D6OdK4r8k8mjlol/IzJ5HEgSrhlQ2qEVsPEhuMCYMMI6GDSAzIh9/WiWtYaeI4vdZiRjnqUovUkgCHOgRjPUMYWFxALkSQVbBSSL49YqiX/VNnzSQGYvhhwkISNhxybq8CO8Y/CQRt3jHsLboDlVDz3bOTvv8TwGC+R
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:52:03.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb461b7-0680-4b28-fcac-08df2f58f5a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9326
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This works in two possible ways: through an external PHY or through
> the internal PCS. The existing autonegotiation code is handled through
> the MAC driver, even in the external PHY case, and assumes a copper
> PHY.
>
> Instead, add two pieces of logic:
> - If there is an external PHY, use the interface mode of the PHY,
>   as distinct from the interface mode of the MAC, to determine
>   how to adjust the 802.3 clause-22 autonegotiation registers.
> - If there is no external PHY, and the device tree signals to use
>   inband autonegotiation, use the interface mode of the MAC to
>   decide this.
>
> In addition, add support for use of the internal PCS without an
> external PHY with autonegotiation. The internal PCS provides the
> standard set of 802.3 clause-22 PHY registers, which work in
> standard ways, so provide access to those registers as a fake MDIO
> device. This unifies the external-PHY and internal-PCS cases, and
> provides autonegotiation with the internal PCS for both 1000BASE-X
> and SGMII devices.
>
> Tested on:
> - BeagleV-Fire (SGMII-attached copper PHY -- no regressions seen)
> - Custom PolarFire SoC hardware with GMII-attached 1000BASE-X PHY
> - Custom PolarFire SoC hardware with internal PCS in 1000BASE-X mode
>
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> ---
> Changes for v2:
> - Include test history in commit message
>
>  drivers/net/macb.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
>  drivers/net/macb.h |  1 +
>  2 files changed, 55 insertions(+), 6 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: macb: add 1000BASE-X autonegotiation support
      commit: f6b2d87fb22fe70e5edf03f212360dd781cf2da5

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
