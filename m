Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43940C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 05:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBBC980A9A;
	Mon,  7 Sep 2026 05:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9zlNRY1q7xML; Mon,  7 Sep 2026 05:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D5C380ADE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788760170;
	b=bjoN89Pvu+GYFc7Ozv5g4bpvlvmZCmNVlPWlj6N4clX0e4nXWv/hMx/FoAmjJ1ie2GxT
	 QGXXjsz8BzFHKgh1pSSj7rtehbkZJsWoE8tvJXh/1qbKUOB5HXHjelTNIZPWKe/c/vRDN
	 p+O/kkdI6vjVhLbkFV24tCJjsV6NAlDReiiGw73U6O5shptAzrARoHh4AOw7KSBixF6zL
	 LL61e5RPCsAVEAGW9CVAq4KWe7fdvR1EfaWVBQdfhY37O8rBrWxIDHGEsTQgsiuY2XR0z
	 ycZ8dDfaYscSDfJo/psJIJlZnFPUcl4d2i35cctTUetgDXFCF1xf7Bb7NZIxK7aFSwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788760170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXrTs=;
	b=IrZKcdRpPbQm/e7bADGYCU9FZkRyb9V1znZopcps7VaJTmpB7qIJqtTVxy4P5m4XjtCl
	 MJR1DS6VeiGwZWTNQOqP29oI9QU9cj7kJb8SucLkcmEkavXsDz4AkIeKUEfp/O7tlBGny
	 XRT9LqqZKp645yoK1rubmjR+uG4omhCtMkrTzTwG/b3TE94oJLXJT/R4C5PMDGtLg/6IR
	 SmXND8Xq+6vbs5t+V+yANopfwlBthAMUAuWr250352aAsZm7jPayyrZj2s1doUeevfOdg
	 g3Ds1chVdNau3h/Rh5bYNCAhr363CKdfKeM0/0IKtxaAlspeQ/8EzWDNn7lw4KIShLQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DLvwNBCT;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=VAzfxkc+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788760170;
	bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXrTs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qcaQQqneuHAMWS/UCPF5pRrG5ywpD7xL59IuTvSRXWC4HH/00b/Y2lQ9sSH1ni5nP
	 gXS2F50EkUR6kXfOcbOUkyk8FNbPMRIz3mhe3UmqVFoSuN4zA8NbTsz0uar0Ezen5T
	 oREcFGN9nfs02HnOJctUwZkQuyZ/dC6O4/6yo8lJCRQ9704DIofPJAmqjzuFwNTChF
	 8WHOnpR5u/jRRNewAQG9WmZGNqOnhVeZ+otIYjRPvfCsgfsrjSSwgDcc3Yq3JDg7a6
	 9/Z7/fz9qGW5YaD4xa/le7mv6Uydf4YqHI4BIc2qalcHdvBRnr8DodfCSOEPOEll8Z
	 w8Pc2nJUZW7tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D5C380ADE;
	Mon,  7 Sep 2026 05:49:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E935118
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FF1380ADE
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NroctPyBNa3 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 05:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C3EA280A9A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788760167;
 b=bOlP+SFFP+uCOeHOKCsGy7uK2BgA9OwKy9htcMKZ6rLvsyOo5nrFe6D7smkdmHMA2k55
 0aG3Qt1OzM1UFrjAnFn6auvUqJpz/Vk5IBbiHMpJuZ5Cp2oNS5Nixznl8M8L9ic5/ITDw
 +ilEK8rPJTKUtax9kBLsSTdRJ7VhMv/jtY2GxpMSoEzfHueqWOk1pVMy6cDg4baM+8mnR
 qtimDwjW6tSFKLdzx92YB5aQd87OpvYbfH/aPBPNyBuoJdYCY1hufcJNCqRWHJRAJwRqc
 xzOgfrQ7guPKOpv82FKO9KgeS/mS3PqF42lAQ7cEFbjThYFRxE/3WXTxAa/U+7xEZpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788760167;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXrTs=;
 b=fdjNlSDw2/wt209KGUJAXmJ3oexl7nWZPuTB3ws/2wGF69RIK2sSA/ueGYFqJKVvByk8
 RVEbts5j6p3+ti2pRiz23olpNMV41bRaAgWn1LtJfJ4ZI/IUpY/s4CgQy/N1GRtEmiuK7
 FdxcwivrHnda+T917RUsXJ578fvkz9gk0yofq/VGf5aXvjuByV2+PTFHpPsdpUFtsZCiI
 mXnLK8i+rBTVXFv5RuANVoFTuJObYF65qD/ddVuZHZSQgvkryYi+k+ddLl9YvEIK4rO9C
 PALBDj4aoF1Y+kZ/y28spI4LDPueXCpuF3SNL2W0Q0HbTafleVgt2zWqK8PHbHuhyZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DLvwNBCT; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VAzfxkc+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DLvwNBCT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VAzfxkc+
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3EA280A9A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:49:27 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6873ihqo2218852;
 Mon, 7 Sep 2026 00:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXr
 Ts=; b=DLvwNBCTLxFQr3THX/cXfBvmieBDZEPM6cnINquglbNHsX0NZMSkxg7+L
 lbb3+rtq5nT4HoHNziSqLX8jX8yN3nP3ap0L5JNaOYviNTFBIsk8NM7yAq49MqBk
 kRHYWS67so8T9S3DnKtPZ4DWeFV8uALz5XgySoQ+G7gtG93xGBNrtmtaXSqJ6zOf
 oiOuycXV3+49sPRYWzuKNmD4cUhokOqKU791mxxOKRJudc2JvOsXWfBjamUrB498
 2qV4P2tsHaJY5GAJPR9kzyMEfKOsjPoNNmYxA97ITXKbbfiaLH+6mQo1Y0XjzzNL
 xK1ILiAy8Zav3PrxM63pi3IQ8e9TA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n3ppa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 00:49:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE0aKXRjiFdKguBjXpza9qrTCfHvnmHjMidgVbiNuFthp0T87MJlWbCyhhFuR7SnLA23FIGFh0j9YASFeqUQO3H5rW/jc+qPcErLwJ5dgkJmNxYs0p9Odixt9OX8ENHXDuPZt7pPqMX6G60hzogpfuV8qW8jElO8BaF6WfXF3Oi1viy9COVM1EwEH2sD/pY9Goelx9Ju3aSsO1dCJE61KH7TalVI81Sa4dJQ7StzWU6pLDevr1SyzAPMiUHxV1KuBufSSUvY6aH26fLy4kB1RdW1jAS4RiKGRKy/GpbdWlYexKTEWv0f6dq1dnCK2nvd/qZsinPgiJYAG9QqCp78HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXrTs=;
 b=r9mtOpn/OSxyC9DujINER+HDbkvKS0hviqlJJfqTSKZ/hfHNvLNmvLB5Bip21TlzT73XCOr/Aj9tDPs4CObJROBunkN1NgZV3TKpx0eVneu3u0+fKmrXWuZKRrhj/63Dv+qZiu2B1NSC8Xy8LpNSDW+7Nt0gUDP3Dw4kTqM2H3/CjxBiBaaTJ6+MlROac/eEFHlyAAB3n4PXgxfoiLPhJWR1uLBkS5FgN6y48eoyDAcd/Sa4BJfHwwm2yy+GvJOr3wqiGN17+b5LowqZ+ak/Xn5vC79PCOsuEq3fhPPrStmmdhdaoxcfekPvxUCMvQyoTkX8xfmAn6jGeqi+aox2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjTFZDbXBsP/POJEMuT8RWeLmcOSG/rKkvKuu7QXrTs=;
 b=VAzfxkc+EkJrYwBfibjjVAbW5njzKQ1lkDTo2e3lGBfa4QULMHFQxCzHS3LaRTr1Mo/Om9B7jDS0+rR5ur+9kIEJfVWnHnnNiKPLXI+DswxGeSAiQw/hyPsCiJwkllEoCPJjHaqzTfpXbMDLgRt9+Di0daMUie0vAXz11GmxJKg=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 05:49:16 +0000
Received: from BN7PEPF00000095.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::93) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 05:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF00000095.mail.protection.outlook.com (10.167.245.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 05:49:14 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:48:26 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 00:48:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 00:48:26 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6875mLT64103994;
 Mon, 7 Sep 2026 00:48:22 -0500
Message-ID: <3f44e8b5-b165-4400-9fa6-dabd552f3464@ti.com>
Date: Mon, 7 Sep 2026 11:18:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/21] global: k3: use gd to store the resume state
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-6-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-6-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000095:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: e59138f6-ed95-48bc-b6a2-08df0ca3bf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iD07XTdLkHKQl5jV2oC2emeKru5NYz0tFER6RtYYsCLcHP17x9GpmfUJGEezJUyxx+KZNvEU5qTnrLXZ8k7zfxujvc8MFNqtlDs2BpLzFnQNazoMXuZ/N9EsNV38xZpNNDa3sra9W9TOEAyoR8XQhSdTKAyThcaf/s2RJ/9c3Lof3AzdiUVnoSJPCM5Ie14msB3G2WAosnucltBw1bZWp7mpAQL1OGyxg4z191wst0I2VN4v/JYo+8vvNvZGRlwidVPXNlJ9DJOwZSdN45b8xjTAcPQd7/qLnjXfrb+SSr+vJvXcS8yRhK2J+b5ZeHM78iTCveABPFz14mCQVDEESiDn3NSFWuUWfzlywSeTPAZnDYgVtweSE2pA/lqA2NmkQrwyqYr1ZplCzMUCdzyzHdZXvE6af1RuH9IW37EdvWuY3Qu1AGmpsNcQYqKFVpOnYtM0hm95PDdeA3ve7E1mUGCbKwV/XFim6OSWdUzpIfdhlaUamj5/WoNdrb52Jcph7tVu1QmG6VypW5TTFTkk1uFZV+mITwjGZnfenGMJGirEymcs4H/wIXRj+WQDtM2uTmehNxrpRN9D5etDqlxZTUKhBJuknZMBeHk8J/HwJoplA6uEUldDgSdLM0Ep8OMjADQHAxb37lTzstdtw9Eu6HOY5QiqVIzn2btChUZg2vnGQ2H5fbmA5Vrip1RZTAR0vEEWYiG6FZdjVOJlmB5W6A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5OujCSeYxSSlVl2L9jpQ4bW218NzGlUrNGjsQQe+Yh0BIxIdEV0awe0s+rAPPWamuPRRb+87KXISqt5Xnj5AWegGPOtvFhlnPWFlRfQY/8eBOdDuzWFNhRtE87SDTVAND+AwtliFXbkRfWjfaGjy3skRhp5i3OYz6PlnGc/hPb0g/lMlEIiSHuOVUzWxnBEn2gomyeODk8aRkQlyoQMAunoAY8+/i8jC/zaIu/Ek8YZ6EVISiLDadra9yvgmMewbT4gufMKPMcGHFyJDtHiC2590svufZZ4JqtqJeoWEOc9zP9fY3H6/Ndm7NgZX29FljVVTu1g4JhQ72AQUXjGZc1MRhJvgiCTZm+nHSN0VyrL7gUtphPWNFreuGIH1QUoZ2nadkRZ12tD4AvbhcfCU3PChHtA0nfuVdTJOw20re67QMMq3loaeSzl0N5OQhEVv
X-Exchange-RoutingPolicyChecked: YGTEDp9cD4PGkG38QpebJXabt7mfYLO7Au3Ww3OQZKFdJ5BQZpjHlUWru+UrhaLsGNUTfCPgAXcgauoJhu4FmriyjApNnibYICfmtXc7ozdMPIj3KWt/95JKg8HUe9wpU3Be+HqJNjDwqtGx2iu5STJe5PlVZBEka1qAynjzrQx1E5tGtnRSrCosnfg4EDngKDsXzIDLmZxgsulObUdPmHLuK8fcEuf+fHU2hAk3mm9gS9ipgC4knpuWKNalZd//9IqDlyyt/qCPspC5y5QS79EoRkeNLNjYipZY0omCX04eBFdkkp/vdGuB48RzYuJCO7uTPhyIqQ4wcc5EY5SAQw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:49:14.1148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59138f6-ed95-48bc-b6a2-08df0ca3bf84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-GUID: mdjGkJy6Gpfuce7jf2YtlXsBQaTSgv5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA2MSBTYWx0ZWRfX1x/hxtaCYSf8
 PC0KI4BTMZXMSraIbu34h+qKz6eCqqfC4z0anrkrnqybzUOiAmnShNCgLu938tVTvIvY445q26Y
 pND54eOVMzp9voMN5aAy8MXt/3NPpow+GUefrc3ADxbBIEwI9GPB7TrzKwjFI0uRih3TV43UmW1
 kWdGlIlWFZ4aHAEdw7V8xy5Wh6AhQ7NGJrdm94nF4P0z+WQ1bo/4sEX62bJHwn6LMlq+DYLLeJ4
 VwPEShrfPVj4rQGhgsd/Fe7tCEOKb0K1HlwBpez7bFYRbtwG/yMrPVE7+M6Sc9s/s6nfCEUcgen
 Yw/xQPA1ZgfRkxR0zUBPZ76LWnBDvLo5+MR+JvFCaAjSNAjp2EabDbXXLt83l+14UTAfBE8u5Xn
 FYvoh2Rj3ger3WpEbWYqqaTINPt1pr8jBEyAMzj9KX3AEriYW1cpZokSO+2Vl5/D1HFodlN0mAU
 siMYhHsTxNkExJPgAHg==
X-Proofpoint-ORIG-GUID: mdjGkJy6Gpfuce7jf2YtlXsBQaTSgv5v
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA2MSBTYWx0ZWRfX+Yq3QlCjZF91
 /H/DYo7Zr+iA0aNnuDXMA8GEPDM/Lz00FCcwGjCQGsarFiEve3iViVLpixT3IMiAFw59rptWbJg
 9KDEffx/5PQqyK46c7iwsbe3eK2sfDw=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e5062 cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=cm27Pg_UAAAA:8 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=j_3vchKpdRyjPeCjxk4A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070061
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> For J7200, J784s4, J721e, j722s, j721s2 SoCs, the everything is shutdown
> at suspend but the PMIC and the DDR.
> In order for U-Boot SPL to know that it is resuming from suspend and not
> booting, a flag is set in a PMIC register.
> So, at startup, U-Boot will read the PMIC register and deduce if the
> board is resuming from suspend or not.
> 
> This state (resuming or not) is consulted at several places (in
> board_init_f() and in k3_ddrss_probe().
> As it takes some time to read a i2c register, it's best to cache the
> information.
> But, as stated by the README, in board_init_f(), the BSS is not
> available, so we cannot use global/static variables, only stack
> variables and global_data.
> 
> Thus, we use gd to store the resume state of the board.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/include/asm/global_data.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> index b2ec450f9002..a146206fdff9 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -14,6 +14,14 @@
>  #include <linux/types.h>
>  #include <asm/u-boot.h>
>  
> +#if IS_ENABLED(CONFIG_ARCH_K3)
> +enum k3_resume_state {
> +	K3_RESUME_STATE_UNKNOWN = 0,
> +	K3_RESUME_STATE_BOOTING,
> +	K3_RESUME_STATE_RESUMING
> +};
> +#endif
> +
>  /* Architecture-specific global data */
>  struct arch_global_data {
>  #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
> @@ -108,8 +116,19 @@ struct arch_global_data {
>  #ifdef CONFIG_SMBIOS
>  	ulong smbios_start;		/* Start address of SMBIOS table */
>  #endif
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
> +	enum k3_resume_state k3_resuming;
> +#endif
>  };
>  
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
> +#define gd_k3_resuming() gd->arch.k3_resuming
> +#define gd_set_k3_resuming(state) gd->arch.k3_resuming = (state)
> +#else
> +#define gd_k3_resuming() 0
> +#define gd_set_k3_resuming(state)
> +#endif
> +
>  #include <asm-generic/global_data.h>

Acked-by: Udit Kumar <u-kumar1@ti.com>

>  
>  #if defined(__clang__) || defined(LTO_ENABLE)

