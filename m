Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56728606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x5jOthmc;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=a5xKQNMu;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=F7NeHyUo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B8B280FFE;
	Wed,  4 Nov 2026 12:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLdMv7DJniq0; Wed,  4 Nov 2026 12:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E43AD80F46
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793797022;
	b=GTMEroHdWf1ce8YlHojWKpVrExWdJDjmZEXJfFdt9Jr4OmobI6j/3zRSRQr2q7riQqME
	 NYA8J1xK8tBnsHnxrrbFAjsQTlqy4jQaiNE0R7od7jt/8YACLtGXPLrWDd49SSjPuX404
	 7jJA0QSrrgxh+mpjBKMuW8rJSJyhfknLmx0PZ6sAGW5mABaUiyKk/QGB4gcsqUUqLK7V9
	 DlQRNrFeasDr1Aw50vL+iAct0KXCYGUr7thdfq8kzlO3EB5haOvP3g9dCznSbyO1kUHf8
	 kjKlQ96Tqn1E/OdslCGjMia4JigAXRQLW6PbweAqmvqU9iIqEmPX5NX22tdco5hfI3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y0w=;
	b=K9JRAAvWWFUmmb/9FTMpDAQz2au3mLsBtvVx1FYfWPAvNJCfraVQZ9bgph2/caHmMaMh
	 1tSbTDxjpcyE69FNavDU6jDf9Fs0uyWyVxNIPCAS82sDBpi9n5eti4Pygs5mpimcL0695
	 DYpLy37PtO+o28gjv6zjrg1tWZ8c4m/zhAf3INho/Le1BjjFvW7v4BSo8/XqCTULRCNFs
	 PSEYiVzCtP14zRzPwU2/HxfIngIkUY41N1+lC0ioC4zWXuJFwu38Qv/sxLoj5yRnPAlTv
	 o9RZcdO9nOEmn5E5qMvtDYiwwkDLsOh0xxXueah7AAjQKqPgsxgFP628RMkzwlAKPFg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=a5xKQNMu;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=F7NeHyUo;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797022;
	bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y0w=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x5jOthmcITybgvx+o2hPi3Mx9kAKTJiyLNHiIn6iCJy1wUtHaplWBq2SMqL93CnHK
	 eKDQussy8oDGj1m93pttqNc25dbn5ySqcOIG/XvuEf4d8ajCHUnwOFomMlRnPDNyAA
	 bLs8dBZEQsfJjyG7aGVfgQS18Msc52D9CMVRxhlZxVLWON8THZCL9WFPGpPUGidTcB
	 alk0RcwFgRpWSuZodcr/Wq09QPBESI5E8El6sXf2AVOf3S4EvGhpYd76mAszaEqeEw
	 JBe3TzDnzteulv1uEzR5TOYLwYR60MNZCJrGN0EsNo7XaY3SkOjfFdm+Mzu2fGRm73
	 EiFjb2Q8ZEYDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E43AD80F46;
	Wed,  4 Nov 2026 12:57:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFCA334D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C076280F46
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SID00a2FFT2T for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A673880A55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797019;
 b=G5WPgoSnPX5iAYQDHEzF8bW/XzEO355KXobKZfU3MExW4TRDJXDwPpa8QFvjmD62y7BW
 sGNzC8qW9VpqTOmmDvhQJrXNpPtvfPE04MYnGfGpJuureRFgBSK7qHxPBLcU9/VoBI1tf
 gwMyaPl03jWOb28HHrR4RtX6OX/Rpgs8mZ642rQTeWmWm47i35hOE47SZ7+wKX20Q2+Wy
 YzJGCKraLGNWhQ7Jjw8HEJHX/0Mroe2y2m+7jGefh13t1T+2aZxBDfC97hVGCTrfSPGqu
 Axu3V/7QlLP3tHxWOqgV+p0Z7jhqvXhA/WhjjMH9PUs6rvNNZybKcjLYXUx0zkyXWdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797019;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y0w=;
 b=isgUQJ9viRnhNwIXUP7dQvq491lSJOP7vy4pNHchs1n33zQ29A4lkQ/my64aOdn1xTgq
 pZr38BycMEK362CyPkiGkTkp++hVEdLcszmdSckvvQnJOC2pzlk0r0VC7ypc27ZNJXZ0A
 b7XYjfyjj+usYkWEFwVbyoHyt7MLqKM5orhSDm7jlaQmcbjTgaqGwRl8p27al1SiUOIbO
 jOggaIxu/8dbZY0O4of/MECQE/IGFtgtAfJMCnqlx/XK6leYv99qzRWtk6ZUPQcMrjhjj
 KH2Fk6VhQVsY8HNAOipgQyW+ePTUVSiaioOA7M87EUXAprYOsXWzKSvNQvwgG3Vo5Wg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=a5xKQNMu; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=F7NeHyUo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=a5xKQNMu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=F7NeHyUo
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A673880A55
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:56:57 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Bbl7W1677314; Wed, 4 Nov 2026 06:56:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y
 0w=; b=a5xKQNMur48m3hOwX4uEOhvlCpL54TfKLpqA01ND8KE2NRSnTxSozCZ9c
 ZXvqgK4TXlYm/uRcya/Wn/UIQ1jd3sBpc6PCVXDfa2qdB1U6EcQszOOjwMX06Mxh
 yI1+d29iT4cTHPV3VnOX9Yn+ZcMEuU/Q/AAgyzTBfdhlXcPP5nB130OGnHDr0wE2
 jn8/lrsOSqmKEX+tqgSSYn0y0K9Is5w0Evoykax907WnE0JkCj2bS0SFbT48GxPe
 Pf7LJpiIk5NuwRyLpFvJzddGLh0QTKJkHOm68YbE5uXheaXIJYB4SdwbWOwp2CuW
 El9Oi3QCizfiRRY+G10ZEywF4Bqjw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hquyf2ys6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 06:56:47 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbngVaklMNGC7lC2o+CDFUA/xXLUjm6Q4yn2ov7RnnbiA1NV37JetfomRsRFbsubNO1TOhmcOL/UrgoBPHQ9MEUd5nAVqllZ+1xF6PNH6Bd9n8QJpXCGAE73uVfLVv/9o8cM4UQcJqSHE1hp6chH3THiWpaGvAPTm1vGR/LLoMh4i9U5lrgyYVc60Gre6YzHH6GKDXkoyRBAv9J4BrshumCbdAi/4uTxNbHFyplFFcDtV7p9ZV2Pu8WuFD+CKzDUa0svrD6LymlGo0k2BzHvAZWqOc4Bm5rJVayPYr3NeTEaWff0ZtnymbCzXX0EagoyArYxzdYSE6PmJTPqbagtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y0w=;
 b=nbDMusjwqhCViRqD9uQ960QvEjGCfpagP40ILPxwsQsCwmvn8kqw+JO1HJuQ+w48SvDL8sEYunylQWp+mj04fMExPKHjNmwdJaWvpPqGKIUwXrwei2PmFjqVzH/m2TQyokrQb8YINZLq6GWb0+VP+D6ElZL+GBX7oLV0Xh9ZsbUa2zU5oUwTEqsbnrFNV3YS9hFygQ5fNTLGZcs9aYWf7w7WQKeRm5MqlxNBY+qUGtHlOsUTIXmBuQs2iXpd3eFphuBeMfq9Ibv3c8kZhQa+huqqNBX5eT9QtcrA7yrpggvlIGOPSdQWQ5dNvCcYyZ7NOaN5r+Ma7AJnnAQ/2Hj55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=basepowercompany.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yWe2Hi50xdM1qzqE089j2b7A3DkPgcWT8RtLSW+y0w=;
 b=F7NeHyUo5sIhCAhEuWFPb4H4Xo6HsrMuYcwDArWZXE3bLvfnyguPZhIVrQan1+RUqGIhEH+Pd2TRLQHIsTXChlKpmb+Hryc+aW0fwgdWsiTO8hasTITpgls43fvjUmeBbzJ0AFI+56vinzu1RqB9BXi5I3PrdQKNxQMgwR9bKRI=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by PH0PR10MB5780.namprd10.prod.outlook.com (2603:10b6:510:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 12:56:39 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::60) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 12:56:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 12:56:36 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:31 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 06:56:31 -0600
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4CuCdr2180519;
 Wed, 4 Nov 2026 06:56:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 7/7] arm: mach-k3: j722s: Wait for TIFS initialization
From: Neha Malcom Francis <n-francis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Daniel Schultz
 <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, Aristo Chen
 <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Parker <jparker@basepowercompany.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-7-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
 <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-7-e211cba9f3ea@baylibre.com>
Date: Wed, 4 Nov 2026 18:26:02 +0530
Message-ID: <179379696263.3643704.6549516340385731516.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793796972; l=581;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=DzNp8+7E6Crn7PsFgFpyDU6wRW19kdnrZ4vX4lQNP6s=;
 b=suenTV5PFFuIsHmxuQtVP1gelw/LtTnRtLFrXynmOIZ/YjlqqlhO92BIqxXi1Ok0+/Y0NaZwe
 o1P5ZkhYqYRC1kSoVR2VWEHO+weXpNdr1tHO5Tzyou69g8mhitAByJB
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|PH0PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c5b861-32bb-4500-e7c9-08df3a730fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|6133799003|22082099003|10067099003|18002099003|56012099006|4143699003|261022075727099003|261026121527099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: STLPkTKaTakHKiZRSC2+I00CLHtmZ5XRD3uENQ08Xm6i9PP6/wb/itCpPzMzmm/E/RNIXK6+4h6f2CIMeEoVsoZUTz5nlRHWTtz8e6d00vh+SNcbcnLJAarYl89MmAyHvr/cIVRP3BdEM5LhQra0JbDGeofKH+ybg1bybVzWxHxJQSgjyaVh0rs24gLr7JFq6q12ZN9p8F+k+rb0ioKlla5UxiJ/+H1yOmoICn31BHDmmrjRxZ1+bOQJmdo2H8kGDAgfh7zZAvYTquiNt43W1dMdBIhcgTrljM2rVNDsYsb8uqW9pxO6Ff0ux5+ybpgRvNiSsIN64hjFswU68tkrmhLv2KsAc3WpZFAy7/2zplr7I3PtdNz9w6ZTn7eAiIvyHN9mnmjOkTDwTM67DACuQfbRuM4Sfj2hNw4AcYHJIHgLfGsxBQ0hvsg+K7K6YLfsyC4yWel7MV/dSlWYu457g09EL84hoG9UB/E/elJ88YtZn1pf8s3FptTiITsDvLumhdOtM6/cVyxbDNBDIbsqbvOmIUIdzKOCYEuDPeRbFUvLJy4zf7rtNL1S4MjD8UCj3puCPC3GmjhoiWUxOzdImjArUVzlL6FFsp6J1/OJfc2d0T+ORcHMl/3sLKLwxA9X8GN/oSu+pnsGeG0uh64NMpfbPUQ5aAKXUIC0QKq5P0daoUte6IJur8yosW3PnIfXf61RGVbimabRbxaMQG6fxw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(4143699003)(261022075727099003)(261026121527099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51AaYDGdOjr4BWiz4Vrku7jsOcJH7sod2X44eicVILHEIaaBZq/pSga5ULbuRPynju1qfDEvZTGmnD5rTYsPu+6aL2RYPI04FEdbU2V3tqdFJujT5cESp1XNTS69k8+aQSe5833xwPiRp0aXNv6ooy9WJJzCLeh7x53KV4KtFtkJpaFV8UnefiLIZ8x7emj/Jhxom1boqGwTIHEXUVzPYgrkCzfHEWPtStDsu4cOKhM3pnqzhmYmAXdcTjNVuTtqHqcIBRUklncmTJh0bB73FY4BxtoF1cSlBibBaiZh1DvPrEivw4DlaCsty4qEYrrIGfe4RBDG4D2XV/Xh6eZFE+bzwT6fnval+9RzwkCFdxT7Gi+J2pd34zSyccMolXH7wB+4RdYeYpTUsSHOb8VVm5fvyLEXBOlCV/SgfKIQwOR2UxiHAg+pLeiVb/vMOvV8
X-Exchange-RoutingPolicyChecked: y0fxGcRa1xwbsjQhhfKTTa44UAeLeot/P1daSrPx2UBPuFkLp8+46QX7a6yQnm+I2JsLQEy+7cEl86Yg1pToXF8fprJua1upTctyFeVPdseacJ5bEbPv09THhd3EBQ1S8AZOd5EZV3cgCi2uKjfPLLcNqzh9oWh3/PmBTJ4FI7fEURG66SFQy6x+VvxSpWaOMdOzZzoIgMxDeiluLlh3CgRH8pvLXBnKBMS+V0aZWduhgzHsr7Qp4E4IjVeHZdwrrqalCq3/hDfk8r8GSclMKCvFUvj+P1SRWHE8VK4HCUCSNK/rH6XNw/lJvDm0CaSeCWX4epjV8QlqzrG4mR4Dug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:56:36.9835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c5b861-32bb-4500-e7c9-08df3a730fd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5780
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX7SSORkFKsetE
 4105+nhbgcMl1JMOugD6YjDYUT71plpZTLsrN+cvzWm69GzvnTg4ebpjOAXZJCkf2blR2Z1BuxM
 eVTh/kROvRPRxUoH3KrLjxK+nOUWry8h1GabEwVDypcDWwrblGbsX2/RJ9sgmkR+PfutwgHhc41
 KZ0/m7lAYVHyyldgx4hKEcU+wro9FGhDtmQN0M6kBQO6EohR+xfOX7sJLxtS0GPZXWgwxXMHhFO
 9cCgJHNy1ZsCNPolIkqc/Y3xH0SnXkLscVS/Q7lkEErU4EjzHG16g0RVvBYKKQ9f8Am7d0NLbm6
 IRdX9DI+ZWwnqKzcHW5Kc3djWA6OWZAr+4lS0ep6aiyFSS0KOT7nr/F8SI6g6qXO6YEbnChQIpH
 HLZ+7jccjfVdhq08FXzQLNSHm1ELUvL0Q1gCH+mDujEnOFcgGHB79Ls39tTe234lO+N9UZvlxgi
 Mn+aA2u+xm8pW9yOJjw==
X-Proofpoint-GUID: 5n09Hgl42SkvJ3BjmQ3YNGvfaJnYKV1y
X-Proofpoint-ORIG-GUID: 5n09Hgl42SkvJ3BjmQ3YNGvfaJnYKV1y
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6aeb2b8f cx=c_pps
 a=DyUboiW8/Fjv5kZUpInndg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=kml-I0801DVgoifd8qoA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX6dAAtQQ/rPoQ
 q2229kPkDYS04sk7lDclE2gsrw0qAcqvHYkMP6qZAeSPlldNYAPAjRWzxcm/AE32dzKkzG1Zb7k
 O9pTSJmofoCAYNk/hj9l3Ry5SxXE0Vk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:58:25 +0100, Markus Schneider-Pargmann <msp@baylibre.com> wrote:
> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
> the firewall on the registers at the end of initialization. On HS-SE the
> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
> leading to a race condition. This leads to a broken watchdog since the
> signal configuration doesn't succeed because the write doesn't take
> effect.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
