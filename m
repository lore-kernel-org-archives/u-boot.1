Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F213CC79F9F
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B324C80C2D;
	Mon,  7 Sep 2026 08:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tq4yw7F7A0mT; Mon,  7 Sep 2026 08:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD5AE80B9D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770560;
	b=sN5d7/J0zE1VGmg/kjvXscJQEW+apH+nhx8bpdI0p7V3IPsIAtLppYpmLS+M3cddkC6J
	 LY9psF9rb8v2cfiJRCU96LIEezjZn/ryGf+PHPTbfWLNMwxWeCRl30Bh8TsbTpAhQMlU1
	 3MvalTReIYdr5Eq2ZJEjvweWuIgM1fWMtkDJ4B+lkk+mRsX6WpyzsT4gq4OyaeIfbN/xL
	 vMH2polZLrVRammZCgYsWPpgJa8wLzr3rKPn5e8Upj4Q6DL9nH3Sl3bxY5D2IOHJcjvFE
	 D8mgOJYq5+YTHYtvC9YalKKc+L8+leegbtlSBD2ttZBABclQpq8rmGUMfdGnQ4Z/Y5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770560;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rgAk=;
	b=Er0R6Pp7R+nv46Ri8gV6LuHrtVLX4V3hCnvgegEKTiyxVTx5k/5GLPu7HqCLdEzWAtue
	 HnZXZlJYP19RaoUjbURUwrnuaRtbh6fh+jWR3DaYHTiHcqutSo4pHTbnSL12NjFYYDtaQ
	 cx4qu69AJNOWrHRC296veeqOcnjQPT5uzx13PyCy6UCZ0dlmpXEpv1JX3rL2PQ8gPsGmK
	 4vNTGlTT8R0Z6crpwOsXAc39B46Bygi3S3UQ4oPcLObhZcubk+SrspPSZrvvRHa8bJzrK
	 O9zyMJY94b2g3qzZmHEZfQiRNl8XvLWvRoh2zmd+G/NzixkrjQxMjW0Las3JraFQivw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770560;
	bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rgAk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bcfkR14xl3bwWkcr2lBHDby3cuVwn3H6AL9x4AfyReNJhbLm0ZVjcSYR4KRMlpi/3
	 qGK6I5oE2rAW2ZMvLP4p+gRg0cV7jcpqlyuogHMH59fEzcVUJxyiK2uieaPIZ5RjAo
	 NDIuckECqmBoR9FgDn3E8Xkz1E4qwhH/3AFK2leFUe+qtwEH7w6DWcUAaDv3LCcM7o
	 T0r5K11k5WxEelg5ZkKHqqNh5gLjPWz0C9vdhE0MzL7rKBmrKXoRl3DaIfjZhliItb
	 0UgJKy4pBGYGnZPp1CeydWyaOCGQasYGboXvtyB7Quaa4grUYk7PW2eJK7eNlAC6rL
	 qfqRU8pPvcyrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD5AE80B9D;
	Mon,  7 Sep 2026 08:42:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDF5A9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB5D560634
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdHfu4trdc9F for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DCB8E60631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770557;
 b=SPhsDbroqq4h0ud8uRu5oxpacd/ETCjHjvZEYMQy+eBN5QA89aIHMzVY1TGGYznf8hks
 0O1t0WL92opWWf1MxsdSgn2Q58O4/IeV57CuKeHoAnXinDmi/9tNtAc3JKhNHnEn+LGwb
 zazKL/qlpdvny0kD1mhG7zYF988tZ4U8B4Mhlso2X2kSK6Y9ofeszECgFy7jPKyeOLSBo
 YFOAb2gse6GwyIo7L4e6Yr0axhwuBpliW7ULAWj7/QL/77G9RGTNmztsnMLIE42vg9Cjg
 NsmJXu0r9hSAKgWBxw9ozS3PLmWuqvFuAYB8nwSA905884POlVmneEi2oB3UOHEBwdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770557;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rgAk=;
 b=VducKOA7UrofRb6CjZFZMAnhIy5AOB+5tPx1f9ulk2YzpzmuoKCCr7oxuBSxL/slBRa4
 jxj4231WnLXrBVTqkKPuhPX+PTdDmkeQM2BWtbTCdyIGDgn9YtVPUL6q0hDQNztLOno2T
 psu2k2nSyKVHEVkMtkni1DFLtoo2tLGAZTF2c/ADJybgAn8TYLSOGdn/yOt4Hq2/5UZko
 7YtgXzzDcp/mgEZRPvlkfSy2UK8f9fM8vvM2pEzj3Fh+NhfhPwFXXIJ7IHADKYjZbsFKw
 Fl3tQmb4kkFvO+jzIfpg3gQgB2bXF5a/rnL9QroNuV8/moJC0Uf5P0UcaRrLC+UVJJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lRklbd4b; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VYckQvOS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lRklbd4b; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VYckQvOS
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCB8E60631
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:42:36 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687768G92415379; Mon, 7 Sep 2026 03:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rg
 Ak=; b=lRklbd4bN9NZ/9eN5BgOV63QAOJCpI/ACooBi1VHSUI52nlElrQJayohC
 Z/D7yNw8dak8y8ka0at/2RDDoujpJbfQZlWcL6PzONNlbPi0nznVmmD9JtvlQg/o
 /CpUGWTvMkOlDoZ7ODM0lTkq3qK4eOKqH5n1OK3SWRDR1Snt1v8w+oDyFm0DuGKX
 mXFwLs0Z3hR58+BpSpHIKZgXjQijuqdaS+tX1TckUJo3dq/2ez+tk3qI+DMejVEE
 X8mBy7guRc1b5JbLYIgmdx7WN04hsSfk/dGQpdePGHnRnjMx+8uTZCsRu5sCyA/u
 3Gkb5mLatkTlHiVMvS1iO6e5ca6fw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh27q4w8r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:42:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMu8NsY2wUtxjgOBdvOZKEtbPpvXKAW7jSCYSYUq5xqRlXo1Vxsf0ld1V2sIhPQDrpJ6GFbArU5gcMB0bs2k78ktZEr80eN0VG4Adl7PwfZEJYUwu8APuY6VloOEFfyimiRbpu9Lg1qslA8SWAeve0nYhKeSkjyTP8GB//kseO89WTcS+sC6zjpSKqXYo1Nn4ZV7axSPKBj98NZc7mx2CfFI3eiTjiERILBJNxEQ+7Wi1YH5FiI7QOfL5Z3WcxjpvE9Uew1JPz6LUETkyvABH0r9Yta6W05MsPbSFmUK4v5QzAOl4R6Y2vrllChuzTs/InDebC+shMbjBv15trj96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rgAk=;
 b=AGB5HGRDyP+d0ealaYMtkColVrRWWiIqfweWF7WpPwx70e/Q6LR0hl5Iy6yOEUNP2zpiH6rqPqGQJCuu/PfdQfgaOHQKgwIJ7L4JFZ327XYGbYvGCCQbtIh5iB3qTqrNq99HNUXNWz8IDxpqMSIs6JjEU3Gh8BoIvSm2QFqjv2A/Z4iFrJNyAwUYIivqQVNHIiglWj3H4Ch83WhfZeQSXA/nrDZo04uWDR4ntz09aT6C/v+UBUyAanR/6qbEVukYRmDVx8BZvTT+FLKr7iTCmWjMvkdtkJw9DyQqgLS/Lbzuf5qYKuv9WzrdCvSH4/kCM9ziOMV+1XU0sTVaFiJyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnvQqtzwsQJUaeMjVjtZ8MxHNdqiWtIao+JjIW2rgAk=;
 b=VYckQvOSmOwLG2I6/bFyePkdsn2NjH0l+/5TeGEbLHbJmx7EfR1gBt3x3UlXsnjNq5DwqVWOhpVBFp2BfgLc1f0bZGwfU+kl3UtdTYhyjas5CWBQsEvMkSjPYEucOl5D1/5GNtXntqdyeUSudDxChmsfTy8o6mg78buvN8ltpvs=
Received: from CY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:930:12::10)
 by IA1PR10MB7116.namprd10.prod.outlook.com (2603:10b6:208:3f1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:42:29 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::91) by CY5PR17CA0056.outlook.office365.com
 (2603:10b6:930:12::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:42:27 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:41:47 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:41:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:41:47 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878fgup1178144;
 Mon, 7 Sep 2026 03:41:43 -0500
Message-ID: <3c1303d4-6213-402a-87de-c9dba16bbd6e@ti.com>
Date: Mon, 7 Sep 2026 14:11:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
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
 <20260828135730.1565643-17-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-17-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA1PR10MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: ed19bf12-0fe5-4d13-5dd6-08df0cbbf2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wAFwTrzjr3sWUsiCGWlbxdhVVIn1uWwjSoCz6/KdAMcby3OeI6E9e2gq+s/sZYxScirqyo3vAkyzUxs+202f2t3TnZlFDP19oiEKtTJcPiKclKB+SXV0JkGhwNnw3XUf+Fw3QualDrN4sbmHvpO1iZIfXNUD6F2LSYt7sOL5SHJiMX0cpfB6oVs2ogQWPfrfsADLZmlWsYBWICyf8p3b8LHGN3Tw5ArOOYO7chYg+KPOZnqztILcbYJwzdbjk5Kr0kTDZuiuhlKNck/fo/tAdrWNdn4mre1PP6L2df9hJu8kparLzZ3Kh+El/fC+KOKvjppzYiQwRzOKWPviock03jPHkt6NgF/Gdv2I+UnHFaEU1ys8M33hYUuHb9EJgFy3+KZWNaecI71lg8IyWe4twRw9cxI/SFz8tvn9c6WkpwMuspSbcTBRqsRxmkbOZP79LA7U6vp2dHhPMx10FMQOABMlLOaQTcRTJ3sC1ihQ6bYlxYUZmr21mLHuqcdvjMM8UndxyN5Bpi8g4s4zZ2noVBlA4kMGJViBb8eFHDe/yKMAMkDOVZV1XGvuW7REFKVpvBwkdUutGvVxFDla4YSzfCoUxGRexdo+8Cr59cuSZa0k/F4IzyyHpc7liLuMHxfpAC7shA8X8VX7NX7bRWOpUe0lZr9Ek82fKsJHtQ3FI8te34hkkLJOOJk4gNpbVy5ypGC5EEIMh+dxqyDkIQtdPg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a8U3fuHuUvYxCUo7L1GiF5N8UNQ9GMTwzx7XES7eZJizGeJSGc4barIjAvRXM5MMkn4gGBkchNALATRW5oKckxDUQKdz04OU+cW+MdGTP5pvIPJUimDOTqd0o8dgpIbS0qa6Mf7LpUkKuNiJFvv8qRaqitYD31ZSEUuQvYnfIz6x/+3VUoeY5ySr+nr/gN12xim9lsJWsDpGg2/UL0bUfk0eWAkwmuz9sGYO6ZyvReWXJ0HCli20OQC8URAneS3r7jM2QEtNEDryxZXW4Vnnkhbr+dPzrHdpAxmnVQ3/xbK5gXDrvyovmlyeBoCdShtCMduqaXpQ0AoJ+P9+7Mmtp/D2VicjMmWsJhKpWZSk3UOipdJV/CYWfYSaRQ6QdDyh/lQmla4VOWxoLfuB2FS/h6PM/fjeoTW1obCPwOQlckZ+5+hLcWFC1wjMz/mNrdvt
X-Exchange-RoutingPolicyChecked: DxxTA1LP6cqQKriaOAsjTKozY6obAovSUhkUD19O+2EyopwYKdVC6+oHNVU54GG2H4RCmuAkEom35pNBZCSg5kjiGURNqEwUDp0uSYvBPl7H2dbqlAqDZatgbFH0LvgsAOJzelka1yog59cmoGdu2nnp8TCAzNNrLX4erNxWtst4CUAueud9mE1+KFe/S/sr1hkrXHw0rpHKAad9VEtlLZttxtsC6puaR6DeEdcpA/B5xpMc5Vpd+L/X2lBwmX9I5fixH7L0KCj5Uzap3bsvRfEQg6gK4XRQldARNUvyMeOVJYex16mJy/uIKLVgeJ0LjpeJd1GeVB7qQWTJhpCHtQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:42:27.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed19bf12-0fe5-4d13-5dd6-08df0cbbf2ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX6uE28jQcjXSS
 RsvwY0RdyaDWOk4/FO0QqEcgc5O5oWBxXVzLJvSfudCctu8XjOmNKfujQUuy7CDIoQ9sVNJqEqV
 EkuUabIGUyRKODssINp1JsphceK125K7LlxikUgLTipzXyA0HaOUOzJEwl1yPo3+VDfJCVns1UE
 qCGI8FI9elTg/SDgOYWKKar6PXq7s/8ru+64HkHTw0IsbYASgxmfONbPXiSvQzMjI+vV3vVUElp
 EhOaOSsxuv0luEBDAZh/VgGXONAfN1Nbz5UsC8HhaZj+hgmoRkB+9rxSbmhhoj5gdn88y1wK+Zz
 labn/KBFPzJFjMIMzA5QyDoR7wHI19zcTDBCEEYSldRbjSRMS1EJp4iX9cYmsOcAKfsOVe0/Byg
 NW+jGzfBurjGIQk2UjXb8ix5gyp3yuUkqiD5LEuoJpADc+J5DgLCSwLt4FD0NGG1AVLNnO036jg
 CrVZ1AXokBWIatztQKg==
X-Proofpoint-GUID: ZKEbR8sgKQn9fc8YYh373ZgQv-wAwf-g
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX9SAY/x6Gc8gs
 TEmguEi9e0H2jiZgPfoXPZFgWfHtbedZIsZlB/cGIEeRz1UcLVc8G+EHiuxQclGhS5XOM5Raa3V
 ARaiuKBIj0gp5XckyDmLIkLIsobIaqo=
X-Authority-Analysis: v=2.4 cv=e/82j6p/ c=1 sm=1 tr=0 ts=6a9e78f8 cx=c_pps
 a=RBuBYZrARuxyk0NLsDi/4w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=S2P0J4d9R83pPK6WveEA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: ZKEbR8sgKQn9fc8YYh373ZgQv-wAwf-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070094
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
> Add support for resuming from suspend in board_init_f.
> The resume state of the SOC is identified and lpm resume
> sequence is followed accordingly.
> 
> First, add the board specific part of the exit retention sequence for
> k3-ddrss following the DDR resume sequence:
>    - exit DDR from retention
>    - de-assert the DDR_RET pin
>    - restore DDR max frequency
>    - exit DDR from low power
> 
> The self-refresh exit sequence is performed in a loop for each DDR
> controller. (J784S4 has 4 DDR controllers and J742S2 has only 2)
> 
> Select the number of ddr controllers on the basis of
> CONFIG_TARGET_J742S2_R5_EVM build flag.
> 
> Then:
>    - Extract context address from devicetree and send to TIFS.
>    - Power on the rproc cluster.
>    - Replay the certificates attached to saved images of ATF and OPTEE.
>    - Resume sequence for context restore and rproc resume.
>    - Image entry to DM firmware.
> (All those steps are done in do_resume())
> 
> The context address area is firewalled by TIFS to protect it from
> other hosts.

Please specify at what stage TIFS firewalls context area

> 
> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/j784s4/j784s4_init.c | 44 +++++++++++++++++++++++++--
>  board/ti/j784s4/evm.c                 |  3 +-
[..]
