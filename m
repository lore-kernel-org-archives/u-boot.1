Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0D1C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1D5810FA;
	Thu,  3 Sep 2026 08:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqAUoedgpKvg; Thu,  3 Sep 2026 08:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA41A80841
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423472;
	b=sR9JenkL4J3zWyGtJfgHw5PqsyX2kOutOoDuZ9EdShvghxnCpaGyxwSSOSbxlHD3xGPs
	 3ZeHaMg8RLDFkjpEUAOJyNd7KqzsxyyQg2XL0OBWGMaqa+WOmhVI40ilZ9wEK99kyU5Ao
	 /mV9ucFtLmbCIQeC6EBSrWZi5gxUALzI1x0tfkIa2SHcx55pw7rShE7sCmjc2imf1QN/i
	 va9O4pq/fKTHI9FHOrlnDGJEjZwyHWLm70qDXmTL4OpXF95w/GMDwgy3ZTysoG7a1H5pq
	 76uNJWgDshVv53H5SJ1peY3UlpfkF4solAln9MYnglH3SMIp/WqsLIl3Y0mdrodXUaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=cF6Ljpoe5AQ97S+7/CrQZhXMEwtRlGxOUgJFEs0Og/o=;
	b=XhOcOzzbv/7aLvHAoIKliVamvSvfKeTrV5H17ibvuhjYJTkTdcWP60WruU1sA6u71tjB
	 HQNukQiZdicoGRR8I1ohxxZlpj/GC9Vkj8TyAPJutkH5iLTHC6D1fKjsuObUMZvFFq5Ms
	 mufOhInUQGi7BiI4a6+YkXFJayAqlYK5u1LMB99fIMqRzCREIBUlO8avMvL00IqwJQ+JM
	 36ChB6UEd51og2hxYdH8Vez9nQcPrI88oCI5gzcRnI0GpJIu+IUiFDefugdf7B5SGYsLt
	 ldekqlHwSdpge9w0ymKNIgStppE8dbRWtFIsEO3XZUEkwJPcPwBvGtWd1CzjmERgplw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423471;
	bh=cF6Ljpoe5AQ97S+7/CrQZhXMEwtRlGxOUgJFEs0Og/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=au2skHSR2uQs8N4b/raOeu2YGPNLYmrln2tNhiqTHIAZ/W0SdqB7gGax7NQPN9HU2
	 Ss/BzirWDjA7KnRQypRjnscudvkbcHoW5EOwt/OhXGKP/lNv2Rt/5vLryPlwMGNIT9
	 V43xKN96+NyFSC42LNSPNolamjhqOLeL0jRBeYmOmCnZ6Zqmj+ZGNm+IUnd0k2M33x
	 HWtVEr8Y2cJz8iJDzNuV9kQETSyDn1d5lg+vC5v9e47ZOEQfSInRMQeRAWvBGqj7uI
	 xSuOyA68pDMToZhWmZQbRz9BgvhkoITHzWiRwpgWx/86y4BMpheUyAgTSiim/PRzlV
	 WG4CwW9IUz78g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA41A80841;
	Thu,  3 Sep 2026 08:17:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C319118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DEE46081D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOOIQARsF4zN for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C87DF608A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423446;
 b=pFzYg/acLGY0oo1dY081CMi6HU/672oZn85uhC6d2+c+qfiFoigFor3ZD1fux96JxLBg
 eE0qynlmbmb1vT/qb3Gp8t0pNqFDkU4ZAgzfiFi+6EZnJSdSt2KbNuyYWjWmAzzZxnzjS
 hJzwkZONIx9lxMcDN2Y5jWbBNEWtyNoTxYqgDZDPBBCi0Xq+sKw3slH97YpiwrECS9bVh
 1IT5RZh1RXTS3RIJP//CIZVWjDFPTPKnzQXkZf9UH4eQI+91x8JhPMwV4T8jPnatMQy9c
 Cedau2XHZBxoqWyCunRjaltgv1H0VO1ij2zf5QjxsYLxpvrqXddYFWCqXMLBOiaSw/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423446;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=cF6Ljpoe5AQ97S+7/CrQZhXMEwtRlGxOUgJFEs0Og/o=;
 b=lP8M18rBflgylZkRO0hUN+3k4pLZTVRstRwjOBySpKNjZd9uoaQDTua+MmzNDOlmYZIV
 A9Dtwj5QdNleneTIEAt2vCLg81xP0N18asicyJVMK7h+9snd9dlQZfHlUboHxbOWj1E18
 bXDn7kUcqIRIex8mlw+9KqdwpahlnO8nU+GErQSG56MvGxrLQN5dLMV43JR6iCdaCGpc+
 Q+SJNGThDmDuug96LVi1I7RQVQVfes+eDlTXXc7XhGk9NYhTeKeOMo+gSjvWEcEWxR2LM
 hnaVfhV7u1TpRn/cGo4A1sHgFd+GqmuZ89XjZA4dy4eutFIVneF7WyzuCv0v00h+0SQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qxGByHGG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qxGByHGG
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C87DF608A4
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srw+s/3GL3posIuzJpxgIG330HSrDTPMOrlLp/WYWZjd2v5L683yFTsAa/zolW92mFKLtuAoB2Gq3NKxMn5HwR/cetr1V56QFpEV7pxT4NAiTRPWZpL4DuyKlP2wLxH5fdo6Z5AK9K2wFrj5z5C44/334GdXZ6BgoeO8ofyGfYJYbvGNvryuXPwj2q7B4UNWFV5ufSJ9pNsPj2ODFA8rcAUspBYK+7NbGoRDjas52YPA6qVteV5VnikRKqMpSxSPh9WwiYi588FSRimbBnrnRlXzLTJZ7sGd03ZVaxjS0UZzLTELT3raZwBC8lOKZH6VraQgVB98V8azaJaqCg9fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF6Ljpoe5AQ97S+7/CrQZhXMEwtRlGxOUgJFEs0Og/o=;
 b=haqyCvtc5NYAgRiVEhy14OAekzuZsQ1MlMEsK3Yfp8BzczNn+vwENrEv3vTzz5RNkpFTmaoOdogEQ4niJmjvGH0i1EU8hR0n9M8UUIIseWvRdJHwIjUkWQ/eiLaIc99ZIP5Zggd57b+UB3JBMsdzg+VnJAaJonRQAK7sleZH+kYPYFR6ULlrlY1w8v3Kjwpxa7NJ65V8+UiHWm/3YD5Q+ikBVdnQYamU7316A1QWSO4qS1I46b428w0opKVj70dIZuh179MHLkMgcY+2U8+s98kTR9DED1fAJAfTqM2EHkjOAukr51BgyNF274YHArYpY6s2hwNfSJFcttO1mbUIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF6Ljpoe5AQ97S+7/CrQZhXMEwtRlGxOUgJFEs0Og/o=;
 b=qxGByHGGV3H5ntktr2ayRXK0Yud64NMSiiTjRaqvp/W+MPwqptqQQ9LtMPOW1/xKYW8saKgSNVdwNCRAMUycAg6Y8nuJifwHFHESGOmxPcasXl8F6IZI9KwUFsYjivsnCv1/xbZ+UKOOSA71+5xoTe12GU/OrDNiKFOc3FXzT8P139n6zuU9W1aplhaLP5wQyWjRYL+GkcWIy3Q6TXL5ekDLEIh8EVtTXi9XnmTPy34lUPbS/iP9nYB9YpokPc2OgAM6IIMMA90rjKzKrFuCDMW8VEVcK6JyLAVOBx8vOjF84UN/EBCkSUCMqqjcb1k5qodwk8BAtfUHeT9Xv/8a9Q==
Received: from PAZP264CA0137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::15)
 by MR0P264MB4960.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8:cafe::e) by PAZP264CA0137.outlook.office365.com
 (2603:10a6:102:1f8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 23E50201AE;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 11/15] tools: binman: pre-load: add support of ecdsa
Date: Thu,  3 Sep 2026 10:17:01 +0200
Message-ID: <20260903081705.12894-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR0P264MB4960:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4ae5b3e-5b54-435b-efc4-08df0993c49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|56012099006|10067099003|4133799003|22082099003|3023799007|18002099003|17002099007;
X-Microsoft-Antispam-Message-Info: 6C610QXh16BNB/R4kSq1Qlw/PwN97KPMq42keDoi/rx+sCMZuOqFmVnJ0hV3cLs+i3ptzGlsegQkuFL8qEZTMUWvX1pqdGrFxYpSw4F8WHUkFOuk5AvwkjRzjfvcMxZ2hPSGgrcl4l1+G2TgNLpAcubgBprKDhqACacO+U3w6RZ5oB2p7E4qvOxoRmT6vKsAzFsNi7b1d6tZzJkskqYYJA4OjCBYTJnqjQJ4wTFCHZrOJQpZHmq1Pzk5I7czIvEfbApu0pPua3avggy6iQqyrxplbSZg3TuurfWdqn4hyd1oGOfHLSDNRX01B9SPJL6HfaRdHT6Gyz0IYPckfZIj+djI5YkN0Z5w5VHqnMd0+SOj2XGE65M8qb+xz9y8mYSwfUiMpbopHEAiF+/3I3jaAUnllrg6YAdylHfgfpy0gasKVjbXzLHrWtnMRHSbse2G5bEsSkLJEtHzbmqDLy01QCCMAQ7BxfYuzj/t/5OuhsRb5anazEmLMOBMcQQG3FDR9N51Hbek89wsheKxgkWz7yvC+iFw7LQme/PlwHJ7CFv/G6XtX43GZz0YjcPhgiIlGjRlQfG9liM3mLsg5oBdp5YMUDn6rIc/MSc2CR1IC9wQZAAE3HWteHUKZrr51oHRbI8aomoltxjnZrn5HdhJPljidTtYpAXyXDD4DmC7UKBHHqQvuaoZdPX0SSwbqTU80UUc9TMv6UBucECiBmByXQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(4133799003)(22082099003)(3023799007)(18002099003)(17002099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZKDZDieMgkVaQ1fpqHVIp9E6Hr3K6We5seEdCFnhK2et5EfUn0xpCoejJvDjF5HKOIczR443/kIqVpjlIJh5TrBPRoDJaVob8SnmDgb6Mwbkrx+adQKwgU56ockUsPjz0v0k2sPNs7IRuenau+cAi9mkPqtm9JlZ79LNrq5SXlgmgHdEfNHIwPY67ytII5rYxvTkSyeXmEfmY90w1arxZ2grx5h5aP+nxBDYEaWpxLhg9p0r64wFt0jR22oO3Xd/IKuXnlmDrIdgMxjKqo3nch1yDuKLgWONOdRE1cjkgIr6wVrextW3Gkd4FfXzFsBJ1UqbZ/tPDspwfEdIYfp7vXQIFIoC5eFe6SE3z92fe+kvpEC5bDxd8iKhczGhb3oDnBc69AjQ9PI+5t1B6y36FBvgUpWGgi7PZzaaa47qtHoizAPe5sMIb+e8fLKORJL3
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.2885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae5b3e-5b54-435b-efc4-08df0993c49d
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4960
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

Right now, binman can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- merge patch 11 that was adding test for ecdsa pre-load
- add key size check
- use exc instead of simply e
- rename dts filaneme
- add a test to check key size
v5:
- compute ecdsa521 sig instead of using hardcoded value 132
- fix english: don't -> doesn't
- avoid line too long
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
 tools/binman/ftest.py                         | 50 ++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++
 tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
 .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
 .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
 .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
 7 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..7890c1c62a8 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -16,8 +16,10 @@ from binman.entry import EntryArg
 
 from Cryptodome.Hash import SHA256, SHA384, SHA512
 from Cryptodome.PublicKey import RSA
+from Cryptodome.PublicKey import ECC
 from Cryptodome.Signature import pkcs1_15
 from Cryptodome.Signature import pss
+from Cryptodome.Signature import DSS
 
 PRE_LOAD_MAGIC = b'UBSH'
 
@@ -27,6 +29,12 @@ RSAS = {
     'rsa4096': 4096 / 8
 }
 
+ECDSAS = {
+    'ecdsa256': 256 / 8 * 2,
+    'ecdsa384': 384 / 8 * 2,
+    'ecdsa521': (521 + 7) / 8 * 2
+}
+
 SHAS = {
     'sha256': SHA256,
     'sha384': SHA384,
@@ -86,24 +94,17 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
-    def _CreateHeader(self):
-        """Create a pre load header"""
-        hash_name, sign_name = self.algo_name.split(',')
-        padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
-
+    def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_name):
         # Check hash and signature name/type
         if hash_name not in SHAS:
             self.Raise(hash_name + " is not supported")
-        if sign_name not in RSAS:
-            self.Raise(sign_name + " is not supported")
 
         # Read the key
         key = RSA.import_key(tools.read_file(key_name))
 
         # Check if the key has the expected size
         if key.size_in_bytes() != RSAS[sign_name]:
-            self.Raise("The key " + self.key_name + " don't have the expected size")
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
         # Compute the hash
         hash_image = SHAS[hash_name].new()
@@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
 
         return data + pad
 
+    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
+        # Check hash and signature name/type
+        if hash_name not in SHAS:
+            self.Raise(hash_name + " is not supported")
+
+        # Read the key
+        key = ECC.import_key(tools.read_file(key_name))
+
+        # Check if the key has the expected size
+        if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
+
+        # Compute the hash
+        hash_image = SHAS[hash_name].new()
+        hash_image.update(self.image)
+
+        # Compute the signature
+        signer = DSS.new(key, 'fips-186-3')
+        sig = signer.sign(hash_image)
+
+        hash_sig = SHA256.new()
+        hash_sig.update(sig)
+
+        version = self.version
+        header_size = self.header_size
+        image_size = len(self.image)
+        ofs_img_sig = 64 + len(sig)
+        flags = 0
+        reserved0 = 0
+        reserved1 = 0
+
+        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
+                                   version, header_size, image_size,
+                                   ofs_img_sig, flags, reserved0,
+                                   reserved1, hash_sig.digest())
+
+        hash_first_header = SHAS[hash_name].new()
+        hash_first_header.update(first_header)
+        sig_first_header = signer.sign(hash_first_header)
+
+        data = first_header + sig_first_header + sig
+        pad  = bytearray(self.header_size - len(data))
+
+        return data + pad
+
+    def _CreateHeader(self):
+        """Create a pre load header"""
+        hash_name, sign_name = self.algo_name.split(',')
+        padding_name = self.padding_name
+        key_name = os.path.join(self.key_path, self.key_name)
+
+        if sign_name in RSAS:
+            return self._CreateHeaderRsa(hash_name, sign_name, padding_name, key_name)
+
+        if sign_name in ECDSAS:
+            return self._CreateHeaderEcdsa(hash_name, sign_name, key_name)
+
+        self.Raise(sign_name + " is not supported")
+
     def ObtainContents(self):
         """Create a placeholder for the header"""
         self.SetContents(tools.get_bytes(0, self.header_size))
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..a3209bb1595 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5925,12 +5925,62 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         image_fname = tools.get_output_filename('image.bin')
         is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsa(self):
+        """Test an image with a pre-load header using ecdsa key"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            'security/pre_load_ecdsa.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname,
+                                       self.TestFile('ecdsa521.pem'),
+                                       'sha256,ecdsa521')
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsaInvalidSha(self):
+        """Test an image with a pre-load ecdsa header with an invalid hash"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts',
+                                entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': sha2560 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidAlgo(self):
+        """Test an image with a pre-load header with an invalid algo"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_algo.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': ecdsa5210 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidKey(self):
+        """Test an image with a pre-load header with an invalid key size"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_key.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.pem
new file mode 100644
index 00000000000..ac1904d3955
--- /dev/null
+++ b/tools/binman/test/ecdsa521.pem
@@ -0,0 +1,7 @@
+-----BEGIN EC PRIVATE KEY-----
+MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
+FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
+aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
+8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
+srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ==
+-----END EC PRIVATE KEY-----
diff --git a/tools/binman/test/security/pre_load_ecdsa.dts b/tools/binman/test/security/pre_load_ecdsa.dts
new file mode 100644
index 00000000000..247b85aad4c
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
new file mode 100644
index 00000000000..be71edbbdcd
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa5210";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
new file mode 100644
index 00000000000..15d71cf0324
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa384";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
new file mode 100644
index 00000000000..1017707375e
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha2560,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

