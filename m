Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C851C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FE0480E02;
	Tue, 22 Sep 2026 08:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tx6kp7ly0lEn; Tue, 22 Sep 2026 08:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 97E7C80DE6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066798;
	b=lGOfAW+QJIL0G3GthUejtc6+p6oITn1ismf2CVkRRE5q67hXpF4MMnHr8Slrluj/62tu
	 Mjn3R0q5+YNHa5ez44+dQnxhQlPS0qBKdfvnmQcG7NuSWrh7itNGH92uFRQd7PiDVU0M5
	 X6zmsTqCKVJoRMpCxVww0Tqvl5xaERq7YUbsEN26C2/s22usFCNWodKe5zbFM3yF7PTTG
	 s0jTq9eugesY8A/eaI/w40oQetG2sUUY577NCkdBo5u8xRUcIbbwERs2XFtmWVADLhehL
	 x0R5EV1kspUJVR/7dRKBo47UjYKZetu+hB5vAjXzD7SKIN3JrJ2knCd1QW7Mg6DxS1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeqM8=;
	b=Ku6YOwwBNHjdwF0GxfNXyfNf7pSHb3T/FtHLKn/XxWpTY8iS6U4Xj9Uk/pcrqA9ZHebu
	 QdIviyAExcf6jMfLMnxBAnnoend6e2kDF2rFKOcXIiGTIYF5QD5lR9aQ0//O8K/Zz6KVg
	 rv1bQ6s1JTqR/g5/eZRjsa4tD+9MVL8PzJO7cXH3edJWXVxpVq/aFsJjq0bTPbkqrIZ+6
	 O50T5zxFWIkXMLTN25HWA/o/CeWaHDB9wQ+06UB++SVTypccLGZ3Uby8RvzcXzpux7yZD
	 xhXecr6ii1bU01wAnsXrsbgVAfNSIIf0awpPEh6A2CW5D886lw5k/4OTrE8FM0JslZQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066798;
	bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeqM8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cVZ5NYrB35ghsQgAmjRPpS8jkafgycME15IQ65CycupjL8/+jM8IHLkgEayqKNv9i
	 6lwZ0iIo/5d8S+euQAgkUNMVZdHnlpU8KhG28xwSfy0A+PpLNMlvfTzd+ngkzRxzvB
	 mlXjCjxQozPFfWMXR5Tv7G8ZKArBav0gwsnXT/hyXRlLa2ASk9y9dIqXEIDyeZq0Gq
	 UfZmc8UCWG+JvHNRMIfI36eyxn4ggGeoDsk5QBuqnN08rCN2EYl5MBte3tNNHNTqqn
	 /VruGeD8ERrdK4rF1+YDVxaDEiooZtgVq+gsj0hCNe3O8lU3sxLn1XQFwnSvsgQLRd
	 jz9OV9E1FmNAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97E7C80DE6;
	Tue, 22 Sep 2026 08:46:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B12472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A973840194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yFy_M6vsZgYU for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C383140061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066794;
 b=AL2AM3pQJ7a1ndOjGV3FYOFuE24he+dGarsFJXpW1Qv5JoWh/nli7lnoHfdU1gsqep76
 JgD+mx4nZRgYtz1iL/IXuHy9/fs725NXX5K7ciZQ46kVLFyXAlnSjuC1iBy0nl40qpaRJ
 VGWpmdbJOG1UvZIFazjKoRhW3O5O5kR9tdsJw34e9hChvxGMqkdSLO4SA6u+SKrd07cVn
 fitvIpnU1zeqQLVcZwlbUyC+QxXoLCEs2qPTF9gvX+n+S+BrYcraEKZWkpSQTC8B4K/Co
 BYHWJnp2p1LVXfyTleokj9LPijpuHKARlsXOPZ6w8KAZjpSgR7DeecCywQpU/4zNxoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066794;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeqM8=;
 b=LLDalSmSjJfbXt1oV8spJQdUGVHrlgv7e2UvHZoXK+6m6HdACtPQ323ZCfxjyZF1yiNh
 o+2lFz5JqsUU4Sn9/VGqyhQfKVXXj5bH3Dss/7VJe1BxmGX7MLGd+gLqCCVCOfH97Kuzw
 0PQ2A4Goi8/JqWBtFrsfplwALgSZ8AxVeJ8t9a0WkR6pXQoJ/TdKRSNJr/swvR4yp0AVi
 +RuLkNZ2Sv5nYVWftdxow/VH20CPJutEiConi1my0f5X2Uyd++3AsibMsqLuMHYcigP+l
 /GP10TJekWBDQ0TYb/k1Zc512ebDBQ89t+ewSTzEDb8cIcfFpHkc4AA/JQElEn+dPbw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=GnXOAFn0; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dpAHgmLI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=GnXOAFn0; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dpAHgmLI
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C383140061
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:33 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M7rVjH1034836; Tue, 22 Sep 2026 03:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeq
 M8=; b=GnXOAFn0BJ7Jjh0vltgi6OopIyj+Zr6G4g3Ha3b1KA43lqE5yHdAMrT6g
 UDMgaML0BM5bWSwoD4VYgxP/9d3dnrtJhYwolEzlpGnukJdDBVoMIebQlKKU/Rq+
 tazzx/1HrYL0zBJdDFxIQNUkrwwg6pS/ARr4Kkt5E0ncumq5PSq8FOCeF55THOak
 WylXFOAAiLudOfcF8ZqTJtIa7HNhZptrW6xi733nkZbzVVbx9EZWURUdc+r2G4Kk
 3yitYNssusP1psmXq+m6TYnXuO6xcs6Tv4e7NTHlKKDAzArUxPR63Fb83BO1D99l
 iq+gJ02Chym2p6eVdFvsis2E7+FEA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gugxm1rky-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AebcQuSZ7w7jF1w999rdkmNHDkfUS6/ER/d8p6p+GRVfEioowrAfvP2pt4mrf6QTQDoWBY/LjdcjIcMz5ebMecY5jFcNNRYkJD33NgnxeCedmQQpSqDEPHUZv4WAXiP0TbUDDEAxBrorWHzf3CGRzBuSlN+xSzha/X21q0Ani36bTU3Tpd+bvbnduPr2unc5D7xIwf3snWFzmHVaWrcQfe4FhfUeTEWLt4vAoD7W9ifEUKYV1ziLpv8rwKBqKO1V5hMR9GbctR/JIRFWhIG3FoQOgNS/qrCZlEHeFRs2rnHq25g2lqjMDXFeoMX6KAwkZT3kPsAMcC14FyBBSSFBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeqM8=;
 b=GjT+IOZBjUizIdazowvBEHUEqhEpd+IbEJ7Z8Fi10Bn3uPUeCy01WynOjTuYjfJ6ZHmenQU0wD7tRV9aonjYd//sD1pQSp2fl1t1994TUQU6JVqQQFV/FBr3CpXYn9a2zhq5opV3LBSesXKDTtCmp+iK5WdXGcWQRyZSHjn0b9ja0/IDj1Fmcn3sBPODz5ubXe0bwT4ch9P5z74/X15yOEdAljiDG6lS/w6hIURZ/W9znJjVRp+c6Hm7YobG5htaBChTm9+FJh3OfngwQZnJLE8puGSUpA0FTh7AW9TqJPaQox/X4gUIGw3s9vyaYLAmbeEKWeaBY8f9josDPdIUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6Jo7FHEju9LMt7kITBtL5DQZHbhF5Rv7dugEZoeqM8=;
 b=dpAHgmLIFGFHlOF/Abe5pObstKnbVItEVztYiUJaMqrdh+TE6Kzu36QEl7QyGkAHsuySCI+po+4T+/o6L+4S5KA7AJHD1f7JogP3V9kYgUIhKbAUYsI3+JIW0Wrz45arEyZOQgdAtKZ5P/y5+SIYam+/Jo2UVpnzKmbrvcF5BkU=
Received: from CH2PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:52::22)
 by LVTPR10MB997866.namprd10.prod.outlook.com (2603:10b6:408:3c6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Tue, 22 Sep
 2026 08:46:26 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::45) by CH2PR04CA0012.outlook.office365.com
 (2603:10b6:610:52::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 08:46:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 22 Sep 2026 08:46:25 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:52 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:52 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFM3813357; Tue, 22 Sep 2026 03:45:48 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 3/7] binman: openssl: Add boot and load extensions to x509
 cert
Date: Tue, 22 Sep 2026 14:15:32 +0530
Message-ID: <20260922084536.2477291-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|LVTPR10MB997866:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c87a61-6a83-4628-08ab-08df1885fc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|13003099007|56012099006|6133799003|3023799007|10067099003|18002099003|17002099007|22082099003;
X-Microsoft-Antispam-Message-Info: lXbLk28wFVxFwSonScAH8lzDRKkzYabQiuTjlv4DGFOjsqEBmOOiDPO0Wf8ebdObZSjHi5NpraowCBqBtn42gu8xmttZKO/UAUtH4eEaeUQTK9xerTsjF600mGZk0IOq2kNdkwrSqzwr2nRFmDydduOgHoM3kZfR4IqfPirM31BGMfzG4RwrLeaY/54p4O18DOm4MsE5xZMr9ePALJCh6MMWwaIiAzZBOXZOCRMznh7gb2axeQ4uUHWEsB0IlDsW5DWocLawj+Gdwy/3A5BgLsTIr8mhatvvhEqnQqgAd7mE3dAxXS7g1txGSV1UgzCWVyWXCW6c3RtehzZjx64Ypj8PGg24ltEKbh0ojP2IYFvvfEyVnB4va/DAQpILOrqZmwJX7OK8Mb3YkLKAGxZ8EpI4By3uDV9bTH3qVWzXQorhsI2JfBWj6OJQaZ143yD/AJJHXTepdJahktVvLnlpKVfJEmCt6O5Qn0lzPt3vw79TZqRQ5NafUjkv5qwuUPycI7XvQk/wT2Js0WkF5VNoqHtnugLSIdo/umzCu650oNGsgXUYmDnq42gffj6P1sWJyPV1tjxU9TdlJPc8ptomdqi19gj2YzVk5yvFPXRuW70zmoaP9YVEgN1qCcs67ijmeocZC/17ixn9Of1MOQCpQg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(13003099007)(56012099006)(6133799003)(3023799007)(10067099003)(18002099003)(17002099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C6L7PTbMLG+Trt3rjOa781zbgPHwWLIyDuixoYLi3c95/R1rIv/MChK5U6OXX1EBsaDy/RhEbbmvaIwssOGPU42QOPn72T0hzNtEUWmEKAArqyEwYrorY8WQq4rgjSNZp/hnK6ZH3EnRE01egrzbweuFmDzeLfYPiRaK459hScScw6cjVwwFMWzqheYcGedKqXIVx/AY+tXBg8h7hsikJiyVHprg/Og2C1zNsJYLdJ6kOkSoyFHT4n37UtTZgwAOpI4bPrqg1e0WNdWpvsqAkIQUZv9foUe+xjMUmH36YwFlqQF62+UqK81P2V1JfZNcZatxOwaS2LgKHCJzCtEmMSL4rJR3W49WFN+bce0AobF4MWNnoA2JiJCoNDgH3sG6uvxYpJXYPRu/3c6XAMbyiQfoBR5X8H3hcuEDoqE9+NQCb5Iamg7TqDVFWJP7Jj6a
X-Exchange-RoutingPolicyChecked: lg0heVOBCCIbTtTZDSco8dqdAH/U+R3tmwJ48+NyjmU85fD56CS1vCukKhUmp7zmru9DKOl7O+hxBRUTAmKGifozgtJpae5ECRPuE/u2RLlKpXZD79XnFcdhu7G80WXRwqqmSCMcqH5X/6nnsD/VXV0nU5GCPrfuUG0hKlHL3ZQgeCbx1Mn5hs0GULFDp6dESd1Y33qtOJtjPNtH7fTgV+/67sZMO/KRlUB+GyXjxwImjXIoOylxtBoZo/PIKovspXJ0cBwTz6b8JaToJXH1tPSuMxq6nWtySCswZ8nqgQARIXQzGGXmCDwaX1wk60vUbQcNdCYGmaOMMk/JPLXKiw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:25.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c87a61-6a83-4628-08ab-08df1885fc90
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR10MB997866
X-Proofpoint-ORIG-GUID: N695pwhrcVl9CS5SmnCToVc4XGkFup23
X-Proofpoint-GUID: N695pwhrcVl9CS5SmnCToVc4XGkFup23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX+uSc68gTJ7mT
 0aqJMxoGsNQdEcpZv3U8Tlxaq3AsLBrNVMUwPSEV5KDrUCoN20RIrOTaUVfRgLBELXBPKC5pN/B
 mEaOL1s+Kg9+Ixr/FjF3+aK11kEQ7lMcwLWK91CJjNRewmhuvtTdLkb5oASZp3JLLzcfw9u2nFn
 yqDxLX5jPvm9Gncq0q3gmwttKVDVQKoIu9XW5DmSN/9YnII+FUh5jvgp7ZP0mbTLH9RIx1JRinW
 2e7PR4sZRThNVP2mKO31nZtMrafBzaV033y7Uh1zqtaXnf0+s/MZ34464I5HYrtBOwejhFo7ggc
 Y7VOtQBiNQZTAyQ1q6CDkoOjCKQ1HIWrGNDX4Jq1jB57gmUrdv/DB2oRW/Ts/tddNfCIWkIuVbx
 H8IpdMMhQMB9S0lvM13jJ1hBkOw4ez0L9sHzUJ2NGUBY+HW+51LHLtprVS/4l9o1j4expbF3Go2
 u6kisCG7Jn75ImIwe4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX2yF0ApqWe7LD
 ia/iTi4n/Ek2vpzefiUooxNU2Igs3TDgH+t27wHXn926XByitU+9Q+BVKN4gX/An80KTrGO+eZ2
 nukLD6ysyz3GcenslmkCkbHZPRWvZUE=
X-Authority-Analysis: v=2.4 cv=INeXmQvG c=1 sm=1 tr=0 ts=6ab24066 cx=c_pps
 a=fgNoY2FrYBgJmLE9YDNrYg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=vBQL81K45hsBuQYaBbAA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220125
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

The boot and load extensions in the x509 certificate are required for
requesting the secure entity (TIFS) to boot a core. These fields are
defined in the binman node for each core that must be booted by TIFS
and must be included when generating the signed certificate.

Add support to parse the boot and load extension properties from the
binman node and populate them into the certificate. If any of the
mandatory properties for an extension are missing, that respective
extension section is NOT added to the certificate.

Add test coverage for the boot and load extension functionality in
ti-secure certificates. The test reads the generated config file and
verifies the sysfw_boot_seq and sysfw_image_load sections contain the
expected values from the DTS. The negative test verifies that partially
specified boot/load extension properties trigger an error.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-4-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-5-b-padhi@ti.com/

v5: Changelog:
1. Log missing properties and raise exception rather than returning
silently.
2. Squash [PATCH v4 07/11] and [PATCH v4 08/11] into [PATCH v5 4/7]
3. Document properties in function docstring.
4. Update tests to check the load and boot sections contain the expected
values from test DTS. Add negative tests to check it raises an error
when some of the properties are missing.
5. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-8-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add support to sign HSM firmware here in U-Boot.

 tools/binman/btool/openssl.py                 | 49 ++++++++++++--
 tools/binman/etype/ti_secure.py               | 65 +++++++++++++++++++
 tools/binman/etype/x509_cert.py               |  4 +-
 tools/binman/ftest.py                         | 45 +++++++++++++
 .../test/vendor/ti_secure_boot_load_ext.dts   | 23 +++++++
 .../ti_secure_boot_load_ext_partial.dts       | 20 ++++++
 6 files changed, 201 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..39ea4a51356 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict, firewall_cert_data):
+                  config_fname, req_dist_name_dict, firewall_cert_data,
+                  boot_ext_data, load_ext_data):
         """Create a certificate to be booted by system firmware
 
         Args:
@@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            boot_ext_data (dict):
+              - proc_id (int): The processor ID of core being booted
+              - flags_set (int): The config flags to set for core being booted
+              - flags_clr (int): The config flags to clear for core being booted
+              - reset_vector (int): The location of reset vector for core being
+                booted
+            load_ext_data (dict):
+              - dest_addr (int): The address to which image has to be copied
+              - auth_type (int): Contains the host ID for core being booted and
+                how the image is to be copied
 
         Returns:
             str: Tool output
         """
         indata = tools.read_file(input_fname)
         hashval = hashlib.sha512(indata).hexdigest()
+
+        if boot_ext_data is not None:
+            boot_ext = f'''
+[ sysfw_boot_seq ]
+bootCore = INTEGER:{boot_ext_data['proc_id']}
+bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
+bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
+resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
+# Reserved for future use
+flagsValid = FORMAT:HEX,OCT:00000000
+rsvd1 = INTEGER:0x00
+rsvd2 = INTEGER:0x00
+rsvd3 = INTEGER:0x00
+'''
+        else:
+            boot_ext = ""
+
+        if load_ext_data is not None:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
+authInPlace = INTEGER:{load_ext_data['auth_type']}
+'''
+        else:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:00000000
+authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+'''
+
         with open(config_fname, 'w', encoding='utf-8') as outf:
             print(f'''[ req ]
 distinguished_name     = req_distinguished_name
@@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 
-[ sysfw_image_load ]
-destAddr = FORMAT:HEX,OCT:00000000
-authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+{boot_ext}
+
+{load_ext}
 
 [ firewall ]
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..9573fab088f 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -59,6 +59,33 @@ class Entry_ti_secure(Entry_x509_cert):
               ( 0x02: Move the authenticated binary back to the header )
             - Upper Byte - The Host ID of the core owning the firewall
 
+        - proc-id: (optional) The processor ID of the core being booted.
+          Used in TIFS Boot Extension to identify the target core.
+
+        - flags-set: (optional) Configuration flags to set for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - flags-clr: (optional) Configuration flags to clear for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - reset-vector: (optional) The memory address where the core should
+          start execution after being released from reset. Used in TIFS Boot
+          Extension.
+
+        - dest-addr: (optional) The destination address to which the image
+          should be copied. Used in TIFS Load Extension.
+
+        - auth-type: (optional) This is an integer field that contains two pieces
+          of information used in TIFS Load Extension:
+
+            - Upper Byte - The Host ID of the core being booted
+            - Lower Byte - Load type (e.g., 0x00: Copy to dest-addr,
+              0x02: Authentication in place)
+
+        Note: The proc-id, flags-set, flags-clr, reset-vector, dest-addr, and
+        auth-type properties form a group. If any are present, all must be
+        specified together to configure loadable core boot parameters.
+
     Output files:
         - input.<unique_name> - input file passed to openssl
         - config.<unique_name> - input file generated for openssl (which is
@@ -116,6 +143,7 @@ class Entry_ti_secure(Entry_x509_cert):
         if auth_in_place:
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
+        self.ReadLoadableCoreNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -126,6 +154,43 @@ class Entry_ti_secure(Entry_x509_cert):
                 'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
+    def ReadLoadableCoreNode(self):
+        # Map DTS property names (with dashes) to Python dict keys (with underscores)
+        boot_ext_props = {
+            'proc-id': 'proc_id',
+            'flags-set': 'flags_set',
+            'flags-clr': 'flags_clr',
+            'reset-vector': 'reset_vector'
+        }
+        load_ext_props = {
+            'dest-addr': 'dest_addr',
+            'auth-type': 'auth_type'
+        }
+
+        self.boot_ext = self.ReadIntProps(boot_ext_props)
+        self.load_ext = self.ReadIntProps(load_ext_props)
+
+    def ReadIntProps(self, props_map):
+        props_dict = {}
+        missing_props = []
+
+        for dts_prop, dict_key in props_map.items():
+            val = fdt_util.GetInt(self._node, dts_prop)
+            if val is None:
+                missing_props.append(dts_prop)
+            else:
+                props_dict[dict_key] = val
+
+        # If all properties are missing, return None
+        if len(missing_props) == len(props_map):
+            return None
+
+        # If some but not all properties are present, raise an error
+        if len(missing_props) > 0:
+            self.Raise(f"Loadable core configuration incomplete. Missing properties: {','.join(missing_props)}")
+
+        return props_dict
+
     def ReadFirewallNode(self):
         self.firewall_cert_data['certificate'] = ""
         self.firewall_cert_data['num_firewalls'] = 0
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..b6028f6be84 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -102,7 +102,9 @@ class Entry_x509_cert(Entry_collection):
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
-                firewall_cert_data=self.firewall_cert_data)
+                firewall_cert_data=self.firewall_cert_data,
+                boot_ext_data=self.boot_ext,
+                load_ext_data=self.load_ext)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a0e8bde7901..f7c5abdabb0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7296,6 +7296,51 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureBootLoadExt(self):
+        """Test that an image with TI secured binary having boot & load extensions can be created"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data = self._DoReadFileDtb('vendor/ti_secure_boot_load_ext.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data), len(TI_UNSECURE_DATA))
+
+        # Verify that boot and load extensions are correctly written to config file
+        image = control.images['image']
+        entries = image.GetEntries()
+        ti_secure_entry = entries['ti-secure']
+        uniq = ti_secure_entry.GetUniqueName()
+        config_fname = tools.get_output_filename('config.%s' % uniq)
+
+        # Read the generated config file
+        with open(config_fname, 'r') as f:
+            config_data = f.read()
+
+        # Verify boot extension values from the DTS
+        self.assertIn('[ sysfw_boot_seq ]', config_data)
+        self.assertIn('bootCore = INTEGER:32', config_data)  # 0x20 = 32
+        self.assertIn('bootCoreOpts_set = INTEGER:1', config_data)  # 0x00000001 = 1
+        self.assertIn('bootCoreOpts_clr = INTEGER:2', config_data)  # 0x00000002 = 2
+        self.assertIn('resetVec = FORMAT:HEX,OCT:70000000', config_data)  # 0x70000000
+
+        # Verify load extension values from the DTS
+        self.assertIn('[ sysfw_image_load ]', config_data)
+        self.assertIn('destAddr = FORMAT:HEX,OCT:80000000', config_data)  # 0x80000000
+        self.assertIn('authInPlace = INTEGER:2', config_data)  # 0x02
+
+    def testPackTiSecureBootLoadExtPartial(self):
+        """Test that partially specified boot/load extension properties raise an error"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('vendor/ti_secure_boot_load_ext_partial.dts',
+                               entry_args=entry_args)
+        self.assertIn('Loadable core configuration incomplete', str(e.exception))
+        self.assertIn('Missing properties:', str(e.exception))
+
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
new file mode 100644
index 00000000000..226415f39ea
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			flags-clr = <0x00000002>;
+			reset-vector = <0x70000000>;
+			dest-addr = <0x80000000>;
+			auth-type = <0x02>;
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
new file mode 100644
index 00000000000..e90d27cb087
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			// Missing: flags-clr, reset-vector, dest-addr, auth-type
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
-- 
2.34.1

