Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D6CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18524809C1;
	Tue, 13 Oct 2026 10:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOM1ocy-zUck; Tue, 13 Oct 2026 10:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1734080971
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791889179;
	b=ZLI1LCBEZZ7oCWT3P3DMgHyIgd4LVVEvwh/dKeZQ5pXVmFHVwWAeCg30cLztVuLYo3a6
	 S7wiT732g2w5sjUY5D4sZOokl5ouifwgj0JuXi8G9W27ToprOklLtLfZ3mMqxN4Xxj4IX
	 39cI9aRb1m79KzXbgppTTEFlKpsvEcqun/clbeH0NwDW6vA+SgKkRY3lwUH1lNSij+NAm
	 K0gcgDXyy/+CLLd5JK+qD4o0MfZ6JefxWda9wMj5796WDVrHYKKu6zdq+F0QKlNDDkImn
	 PYqeXcHiXx0Y8sFDFvCrkgZo5639/R0nw5fIc3pg7YlSycjem8NSggq+KmcjZHyd5bw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
	b=muVrmkzjDGUcaOThlQdca23JFAJ3iw+ORE0FdKVr8FnAPO8QyWUznAEbnrwujnALSwUD
	 V/uFczWXy6l47hG/Hd1xwOclR81AeMcUw+XJaYQt6mLynY93UDQfMjQCGcgdPbWtC0w4A
	 TX8FRFvz5RfveLFvquZUpNbm+wSIExfEAVvi5aiaesbjF4MzIgBqT8JF/cUFDoWjXO3ts
	 YzS7pUPpKRh2rkzJGTcK2Ec63FvuSz88pUnpc/SzvMNksGn4dGPbeu9WPTvqVeUWDeFV9
	 hJN1gT7TwExaUzzD3sX6SXMNWSrblRhlNTIZq8V06hPP6JTN49shJJOJW5swVM26DSg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PEe56bqx;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PEe56bqx;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889179;
	bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJ9vr0NOsJGG3VXP8euOMN9M6QSMqJ1wQRgkmiKEQPaoccqenLQW8uVepjnYs5Jjm
	 pQmx8VQZW5h1IJb1EwmoesZbFE+268SwGYtzsYKrcKzlrxkTvrsPN/l4Y7/tVEwD2E
	 kCA7RUzhhSTVfdJD8sJXQQc7PE7dJWXPJdFcnZ4FQO+SyDy75FCJuTZj3iB/w+JG5H
	 5NYCWJ7X9vA3txQVeQT7m4sLJNgn3SgtHtr6iQS/NFz+fJw4J94zduBSMEfBvsyAtc
	 pBkhSpnWR70nWIjWdy2vehkAW488YCPCVWiKr8reobb/k6mpbQ5QpxJNSZ2/TETYMX
	 JV1apw+j04n7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1734080971;
	Tue, 13 Oct 2026 10:59:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F340ADE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E19A280971
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sydo3JEC0fR6 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F4018096C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889175;
 b=CaUUisgBC8Xs2L3m+ZogeyZ/WxVoMPEQgUe6b8BiOrFmmbFbYNiFDL2jjIGBaqjccyp1
 FBOWzyeNoOb89U5vtFLmZHPuPZMRAU9TU0MTuVm+k17xVUGWC4jbcKF2pFU8RhrGvV7my
 a51AvAdwGDXnGWOhGmSC26XeGihdJZjPg2g0rrJJL2RsKXTZwz8ZBH6L/Szp2hS0Hkx+m
 VPAIuHylIIvZuLJ5Mw7TkOgRRmjtE5uXyMcw1YSfXvm2r7mM86lBPivELOgsAMymFwDdR
 ChcrKf0tP5lnn2cBVUPvNLU+wWvbGwy/nHjedCJbabifiphCJ0PLFEZw2hJG5pC2+Bw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889175;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
 b=IHQpe/oy5fEBUdxPpj2nGdHzO7wyNekEqaZPkfx3v/qQD4rzuBEpLPFdtv+Lsm9z1uLT
 s7HPBhdRhFn8qiCEtvsE4bmZ7qmOC+XAL7sqwR3bdtmBzq5feA+2WDZgvjahBaqYS4g4T
 7sY5cREYJvG13NEhB4C55Y5tzbc+EP0RbaUopAUMkpXe/bdmnJkDEbIzxaLs7O0gRCcWA
 vqINpKrHRjNn9WD4daZvilaxl+BEQZE1fTIvwkVA1kVPXeVy6nj8F3oAZ4aQz+RIbs+4M
 2msOgSxyZYxz+o4p3q2YdUSVf9xk8hgOmNklzIlkodABH0L49ZWyvVkNcjYCCKnMAAQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PEe56bqx; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PEe56bqx; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PEe56bqx; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PEe56bqx
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F4018096C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:59:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GoqCCQK3H/4cSmP07hfgjL8jjjXzb3+n5ixwDPEWS4ci54bcxk7JW/qaik/EnBHRqO3nf8FrI6yj2pyidNb6KKJvvr5fcpt3ikKw03Lw5P49wFDl1yF9MQYZaJMNJguhyMP+d7LCsGFiUmnLwSMAw5sYSSP8ZZTdwgyiesFDy+bpUnhYU4smxFLM19kCFPYarPMEwPOXBixGYMLd5V5xFqUDUJ8PO4PEbdN+EBExkW5Bu9C/cUA9S5E2TeXbTjbIFD7HoszwFMz4/4XlgE71SlS0108gnvSYisQXHxiAvTEmVITmMZ6K7bUrmzV/WlnqTvD5JD+J9L03f60th/08aA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
 b=XpwfDoF+0Wdv5RAmCM7MaIH9+7tNHuT03nQsskl/I8qOUbcB4pedsWBGLmcU7hXTcPmLwjaXPQBG/11lwi+/bSuqYLmqerH3A77AxavoIJy+KjeGutn1ElBEjErsNH9qs/xZlyIUitocJqauPYXZc26AStb+ZT5bP7fTUCgsWy4UaRuIpgS6yw/sMINoUatb2R9lBcE9uI4c8hfrBqX5mDazcGzp5XE5zoQs959Urc0+H63wcxLV3HNrQk2eroP3T2NfzgQG1Y6hHaY1/67uBMger65DrLvXG0adf3Uk6VEBrrrKmbJupPzwl5ys5SRry/xwuRMjG7AN0CczcEO6QA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
 b=PEe56bqxnvU5PUbEAUyXo6Ne+Z3OxlJDk4GqwX8tQjcwv+hn6bz0o/IsjcmR/+A4TTt8yb0gktyv3kdXbkWanx/AAQQi91FlsI59r96jQXP746ijr3bsSwoSxKdMxI/XD4njsW7bBPnDIqhGjkvgFNeze0bWJQ3+pR3H11o4aVI=
Received: from PAZP264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::23)
 by AS8PR08MB6357.eurprd08.prod.outlook.com (2603:10a6:20b:31b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 10:59:27 +0000
Received: from MI3PEPF0000848E.eurprd03.prod.outlook.com
 (2603:10a6:102:239:cafe::59) by PAZP264CA0255.outlook.office365.com
 (2603:10a6:102:239::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:59:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000848E.mail.protection.outlook.com (10.167.240.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 10:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7kIC2D0PjdEiOwKGQLNj8Esr6yjgQ3fHOFUyBDROoqgbSSxksqY575uARs0D0gPqIwhOqQwUOTPLN2bMHHOf4f9D8frMfDXU08MyL+6gH/OLVJzlKS5Yb21ItNYzEvrB3wdyTKvWFJip3oknwP0Get7UZyI+ZT4ROvslNShv1qwFfIq+Eg1DVOZ/HmBg/uiiaQbXX6d8AjkfLo6gr2jQPcmq0DNqCBKy4QpfcrWoC4fnKjrDPhY6ruKTXEEiaye2onEfeMbWV375AUCB+NWVI8u5A6FMvaRrENoR5O9lKONLn6+0u3hdPKQOs357A7s22k37DtqNzKVF9dZyoRzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
 b=adKNPr4/RFDcex1b4VUYvjO9gnKeFHjGWfs4oF9HaSxnSW6GEFzd9lNDxNhOkuL4JKtNaXI9Ls336Oc/xFG/Jts3cP5qY815KzzhWO9AGWbEsZ4RGBoHli+kJStqQWp10VNVbEkz3EkYzbo4O5NMvQ0R4jcOUn7gcGIJNHoe2o7HCvYaeUuPtmuP4tw1Wqdg59ILbPMuoKPY5/D7GACPo3hocGQBn3TcavUC00Bl5oaYLemBwE8DiHtYcgAAlpUISbFs84uykcwIajKzxeSBMXd8yWDd/IwsBeo/UaicX3I0n567RSbSkFBMQYz9gGqwTGHbrOY/acr3MpyJoMQdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/xckeaWpSBF+m4o0NvAWJuS6q/KFq1ukE/N3K2r5ws=;
 b=PEe56bqxnvU5PUbEAUyXo6Ne+Z3OxlJDk4GqwX8tQjcwv+hn6bz0o/IsjcmR/+A4TTt8yb0gktyv3kdXbkWanx/AAQQi91FlsI59r96jQXP746ijr3bsSwoSxKdMxI/XD4njsW7bBPnDIqhGjkvgFNeze0bWJQ3+pR3H11o4aVI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB4PR08MB9384.eurprd08.prod.outlook.com
 (2603:10a6:10:3f0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Tue, 13 Oct
 2026 10:58:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 10:58:54 +0000
Message-ID: <db62be85-6a41-4468-841b-c0048d49e758@arm.com>
Date: Tue, 13 Oct 2026 12:58:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please pull net-next-20261009 [corrected]
To: Tom Rini <trini@konsulko.com>, James Hilliard <james.hilliard1@gmail.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
 <20261012200814.GA3799261@bill-the-cat>
 <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
 <20261012210300.GJ3722450@bill-the-cat>
 <CADvTj4rP6nobpBD=N2m+babdvwVHCK7kHWpVuDix=oZNFh_gSA@mail.gmail.com>
 <20261012224532.GP3722450@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261012224532.GP3722450@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB4PR08MB9384:EE_|MI3PEPF0000848E:EE_|AS8PR08MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fa5205-0059-4861-9f0b-08df29190cd3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: szHOGj5c8/FOXOEVVNQ9LgZAm8KNqJloiWYiGLTUI1sbfpDWxshx8Cq3+A+vax2O7xyS3zaBqQcLmDlDoyc6b0ioJTyu+9TDdsrIJj1XhKaCDM/2X4/uaWoydUoBKDF1YHGwZT43MsrPaTpqKANbA7X4ZESSCKs1Eo1hJyRpLf0tnFQJ0bIYdgi2XUsQFSchmjJTc55yW9F0SX48IKc26AAdjWzAlCIbu77Pn0p74NzyqySmBfUQKzpwWVjGe4s0Hwf4Mj4pqtLJxbe34YwfNOt7DJabWr+HyymL6isA//kXVZJ7HoryR/8TOXMlI3nMts76NI9+p6J8r/iepN2xiBdOWs4pvQtqy4ENnLLW+261EaCtaHBO62Ai9CZWwca2/0Qq7fe5IFaApEmlndqov6NMAj2vKZUyzq55uHtLIz1rgV59rogdCxcjvOCaG6oBdtmQKjiSDiHLprlHMoDmCx/h5IYmzZwKLWWdZmwD9h4aV0zvlHw9el7MNVHDB8aJmbtLCxtA5t5vhvWeqM99i6zYf71MHcJbAdhdDk9/So120iYtg8Mwlkz9afMuohPynpG85b2zRauBx9Pm2XyGs0BBsaZbzTL3loZ8YKHTzH9PIQKD6fVqivkSowt3Mgpp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: tLQLufOzJ4B67ckTdt87maioF28ghZ5y8X4GyOTuHe+B/PQ8e747ugw2nZMhoDC9kk9c+4AYuZO7p1hnHzuX6NgwLe3RBZ8KUmChh34JnEOmGwwGs50QqSYjoLqUCueAgnCUpuQLMuJhv28IjchKwPTvsU4OF3P9p4YA/O6XEtghN5v7vfR9IBfoT+UA7ZAIq5Soht/RzJqik95uy/ky2rHJPEBItp3RXd/oYLwkaLUD4yvaSFDKDMK4Xek7BnFDdMh42rr3x13/MwWwWmV8t35VlCTPXFgAkOy6GQuz4Nu4HSo60Z3/+TQRxHANVf+iCQZhYAOhDZ9auwGHgsB5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9384
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 462991d2-b9ed-4c9f-78d2-08df2918f8c8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|35042699022|1800799024|14060799003|23010399003|82310400026|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: EMyu2WeOT1LFuCYw2Yp3MShegTr8mLO6oilI485fEFiPwzTF9/2suXaP2Q31E0XEjbGMNA98xcxv9x80HefsQtX0k+2Cb0hnBqUJ4M2DC5CcNCSultl56Lpd97iRno2ScQH2CAqXNoZS0Az71PLdnLGZERGBasTtpknpDZU4JUYbE88Ca1st51P0ZVEKeozeqnXY7LldH7uRy9RJdppZcQeZWUnMIhlJArZkw56ttB9U4fNNr2f0DJ8TMX68vxksnemcEalZoY5zN0bBW8e2/DgqLEJgy6+yDUE6ScB/MYZ39fJWiOHD1ReKGFB6M+kkmFrp5aVq+meyL4RJeJ/stUFXqpxRPsUL/1hKEYG2RLWHJhiiCq7YBve8MAxscR8APriGaGSHG0AUYrDEoqfCZeNPHCJ+60JQTKH4Cn3tzKhSyHQqY86RB14f3ubKdizbIkQbRROFak9ItYVQd17jkSiJPwftYa0fSZR5KGkstI4IR9PHTJ3RHEpUyleZTwKaDMsNzd/wNI50LmxsY7jAuPCBG7mluhLQpPfeAl23YUtZtSVwpxy0CdaoSBRiC86Oa0IhnTtwGpgKvX3OwBGaHeoclBKJ/vaHQr9Le5/NvfO39fuEQnsNY/vHj1gnwhxfMR4+enhxe2CVBtTULTLcfA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(35042699022)(1800799024)(14060799003)(23010399003)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sM9XfexQDubvcGXZ+CjGLICx/w3UTlH8eTSvdc/DyECaBQPnvKQvnHkOWBU3TmN6+vX4yjSaCkyuKaX9AQeIuPAwVBB2Qzpe8LqU05UGeCg/tQAN08omy7jkMOGJN0los0Pjv1sVd9S8F0yzqT0NzQSzzKWrTC1xdxflHgHW9AZaFIGZgLQHyfPzPE9hNivcwqvfgxFUTHzvHBMZJNJYC9RuWPGaqyRCHVe2GdLInrxxdNoF23YUbJdqMpKG+k59dXCtOXBDLNNaeM2P2OIkaFBzxWwn8CokPTksZU2BDv7gMQS4ilUI6pF7Oz7rW4NrAqWzXPRDvo2yYdlKJfHJeWCHEkxDvSJf/KFZwub4YwGiBPyWEqHzWS2P+wAVm+TZkxQO+MuNIC8i3b6ENk1Xilo+xAtGU+HqpcFi4MhQFqm4S8GiPpCLfkuxRX1gRYao
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:59:27.4388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fa5205-0059-4861-9f0b-08df29190cd3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6357
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

On 13/10/2026 00:45, Tom Rini wrote:
> On Mon, Oct 12, 2026 at 04:43:06PM -0600, James Hilliard wrote:
>> On Mon, Oct 12, 2026 at 3:03 PM Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Mon, Oct 12, 2026 at 02:41:42PM -0600, James Hilliard wrote:
>>>> On Mon, Oct 12, 2026 at 2:08 PM Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:
>>>>>
>>>>>> Hi Tom,
>>>>>>
>>>>>> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:
>>>>>>
>>>>>>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20261009
>>>>>>
>>>>>> for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b890bd:
>>>>>>
>>>>>>   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18:58:10 +0200)
>>>>>>
>>>>>> *** Please note ***
>>>>>>
>>>>>> Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
>>>>>> error detected by CI that would otherwise be caused by "net: e1000: use all
>>>>>> RX descriptors". I did NOT send that one out for review to avoid delaying
>>>>>> this pull request, but if you'd like me to do otherwise just let me know.
>>>>>>
>>>>>> Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
>>>>>> initally failed CI and I incorporated my own fix (see the commit
>>>>>> description).
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Pull request net-next 20261009.
>>>>>
>>>>> Now that I've fixed the sage lab in CI[1] I've found a run-time failure.
>>>>>
>>>>> [snip]
>>>>>> James Hilliard (20):
>>>>> [snip]
>>>>>>       net: lwip: finish DHCP before starting autoload
>>>>>
>>>>> Fails on BeagleBone Black with lwIP enabled, none of the network tests
>>>>> run and the log output is:
>>>>> => setenv autoload no
>>>>> => dhcp
>>>>> link up on port 0, speed 100, full duplex
>>>>> =>
>>>>> and we never get an IP and so can't network.
>>>>
>>>> I think this should fix it:
>>>> https://lore.kernel.org/all/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com/
>>>
>>> Are there likely other drivers with this problem?
>>
>> Yeah, this should fix them:
>> https://lore.kernel.org/u-boot/20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com/T/
> 
> Thanks. Lets drop this patch from the PR for now (so please send a new
> one Jerome) and take that change along with all the driver fixes in the
> next one, once there's been time for people to review.
> 

Alright, new PR is coming. I had to drop the whole series ("net: lwip: restore BOOTP,
DHCPv4 boot policy and PXE parity") because removing only "net: lwip: finish DHCP
before starting autoload" resulted in too many conflicts and also implied changing
the tests. For my next PR I'll pick up the driver fixes first ("[PATCH v2 0/8] net:
return -EAGAIN when no RX packet is ready") then apply the BOOTP/DHCPv4/PXE series
on top.

Thanks,
-- 
Jerome
