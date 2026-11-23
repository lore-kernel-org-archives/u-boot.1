Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739D606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qpEAKujX;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ETjd2gYm;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=OE651Dtm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5D9C60606;
	Mon, 23 Nov 2026 16:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SwVRO5MQDbIs; Mon, 23 Nov 2026 16:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 085D860784
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795450705;
	b=J8nb4s0TMyeO8Bpu08Nl11vqTn2lqqnPBretjvVQ0fZqc93QW6x7BxZ2iqgE2lgDJcWx
	 SkSlTOTZLgiRECmqqN1OIfQoUMJCT8iegwlk5iX+hl8VXtkdi3wifz0FXzG9yQ1NVFhUN
	 sHRWy2foOy3mn64QJDQkjrs0a4cTjhcgrHEoaoy+xLw3I6Kk7t62jlneUkxUEZ1prbp6Q
	 /1EkmXz2oZ7qJ04z1Feb7JD0RYSWg35a3mPh64JNFoFr4fPpwU6dJfQ9k3t3A+9Bq1puC
	 nXO0tUGEcv1fEc1rZlgYFCuwKI2v4JyfG3I7GDG4ynicCXZVtaZ9qB4dkLmUuMXBVLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795450705;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GxDCmp8KrJQ4y4duR+0HprK7Jvk7QB13gmaklKa1X8Y=;
	b=pyQwkxnjNgl+nfA6+1eXf4sDOyz5F5sVmc4vquaW5XPfQVNjBnaDYAwSzAT4aiIOiFyh
	 QjjAYjFVueaunAF3rnQAAILHIJuK42JNWEhUdLSqKtfBLnMcMgKoXDJ4yANGEnWCFocjb
	 wjLgsQUZDFbQqo0eplxxAOw5Er2QYt9tGPW0Jsk2l2H3s+N5IRVjBBLELq9TNEjwiz2zY
	 L/cqUZ5sIx5vEoiQHAFk9P5i3UuNAuQsNDQyskdFwjKB+aUOGWMfVriy9C8IVbnOowF2U
	 hK/jVe4JT+3hDGzVLwPIbq81sVKjzHNO7QJ9rvjKcSYKAazYhV8U0qa3wAXZ2vuQwuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795450705;
	bh=GxDCmp8KrJQ4y4duR+0HprK7Jvk7QB13gmaklKa1X8Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qpEAKujX11+VPLYyHG+3nxng/fNEPufNV+Ih0tcmv8KdLKUAp1563SQ3z+Q2Bieev
	 xsiKKYe8rkWA29Q7bbj8x9HNDviP+KKZwimTZrv4rlmWAxvD8kK1an+Ql2/eJQeKA9
	 SKZUhpQnPZLkemPQJ9KF04cbWOwizwUjtJxt55C1B4G+61htGQiZIRAjCMlxA5azpz
	 JYsx/lLCcgHbzhq06wN2KUHkIRwleBq8E0Kq6MqxPmeEmEaHehBVY4o/5jQ6NfeK8F
	 8oxDqOg8QhxuOm6DzKKAhvBkBZJm+H3cHg0YDi2FGDpnfVOsWAwkhAg3AcCw3O2Xtf
	 eLCL3/dJ4Suag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 085D860784;
	Mon, 23 Nov 2026 16:18:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA63F15D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B6BE809B5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Rs9KdTzGaqg for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 16:18:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 918C480981
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ETjd2gYm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=OE651Dtm
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 918C480981
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:18:21 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ANGI3bU139508;
 Mon, 23 Nov 2026 10:18:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=GxDCmp8KrJQ4y4duR+0HprK7Jvk7QB13gmaklKa1X
 8Y=; b=ETjd2gYmuOovizTac97+y9uhlZ1xNhyilFGYZO+ZG+WJMlXl1D1a2VWDv
 VJ549+nq5PqBRklQqqLXtDsBEHPK+9Yh9DprvlA3ojO6Gx9MAvARMM7QXaLwqTY5
 XOl3/HRBl63/U/ePVOvmBTeXaf9s6OxrJd6dhUCWEqF4R+lcKwo5guPtNdLJpnrQ
 JdjmunOZU/CTgKv1ZyNV4dy+2Ge86MTPyDPp40urakKN6J3qgQpd0UCl5uP1dUlL
 xSh22CbOBojFvyPvuoApNJrvEzrHplm9HnP2Y9u+dPuh6R5qzJF4krGLGEppICeO
 /jJkNh7irY1eojlxJiYhpmbcXgXXA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j3x4sf1jk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 10:18:18 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDCmp8KrJQ4y4duR+0HprK7Jvk7QB13gmaklKa1X8Y=;
 b=OE651DtmSxDpJH37PVVL3tUkSyX9qVNC5l/ZesmAXNKV9ot/bRKBVq43ezQk+lYFJ46F+xA2eDYi//4o5uSLo4VbUIl4utABu6XHsfLQQv/n9uA5oHF0J5GYDGl4E7dpXiJpFjjaYUatFTC7VCeErKNSfj2gu/5asUVmMJvOHfs=
Received: from SJ0PR13CA0192.namprd13.prod.outlook.com (2603:10b6:a03:2c3::17)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 16:18:17 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::71) by SJ0PR13CA0192.outlook.office365.com
 (2603:10b6:a03:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 16:18:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 16:18:15 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 10:17:20 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 10:17:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 10:17:20 -0600
Received: from [10.249.33.32] ([10.249.33.32])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANGHJ4Q3002127;
 Mon, 23 Nov 2026 10:17:19 -0600
Message-ID: <71bf7f28-a31a-4ab9-85a1-d572cb9fe750@ti.com>
Date: Mon, 23 Nov 2026 10:17:19 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: dts: k3-am67a-r5-beagley-ai: Use dm_tifs for DMA
 controllers
To: Francesco Valla <francesco@valla.it>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
 <20261123-am67a-ethernet-boot-v1-2-94520ed74c90@valla.it>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-2-94520ed74c90@valla.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9af085-a6c4-497b-d7b7-08df497d6121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|261021121427099003|261026140227099003|4143699003|56012099006|261022075727099003|261009223027099003|261102123227099003|10067099003|261028144727099003|261026121527099003|261022105027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2kqR24IaqoG0kMWYAUwUnbQ11h9zGBlKWaZbLYJQ5C8JxAo7eVOQ7oZema7M2HN1h+btUYbudz8xOd0nlH427BTH2gC4SAaTk48oxlnjWWVbdG15RmBwWtNXsEAz/5mcmHo80gHDhAnYzfDueozGlMJ+f5NW2X0v+hkmPPl+cmRr8qgcodzHUqInhvzGHaUSnBJ5yZU35SnK2YDDR5g/HfWH54BYRmBUANrqWukL7yspLAEk5slfOiY0TvM8M+dYmHZ95Om+EKl9m3N292bDXfUhrqe9T0TASiQbB3Wz5naJ1AIzCTE20ErsJA0OGsiVus8PZdcXNZmRa7dWo+dqO8kyXMPUuWm/PqS8HNRlcdCcOFCwZYHR4C1HzRZbIMHyWzrTM3bUQq71iV3Q7/5SMqVyjoldfREDbqlGTmqCiQrlbBk59/sAUHf9kw9OMp8vnbPSksb0xlQqc/TqGF8+cBRzitbkiX3mo8HIBte0c4hvJEtA0mFjtp/2w273kv3IHuXMFpUTupjtdG3ca39F9f5EDS95jZxroF8CM6xQ0dPHf/Oc5izKIB0PdNSPMcr8QZ1y55g8owR23QA6HbUVrDIMWLmf+R7zzIoG2swM063SF7GhVB0HSLSSlihX4lCxPN+ohudzxK51o4REcM9Kv5JcO2UdxwAj36Doo71WO5cVD/yH3qbSEkHviNwhouoWytQgkL0mMJx5qDC7iBfAYw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(261021121427099003)(261026140227099003)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(261028144727099003)(261026121527099003)(261022105027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rHrp7KDfQn8KsD1RdCxqQZaibcmi4GYTOumLLAQcJKqQyxdlKegTDYRa4UMJ5qmxpwaQhQ9VfI5LX8xtlLBMP0h0KZJQfRTPJoS5s/CQ+wP+Mkuxbb2VwVPPWcyzDuzKCHoPiyj7PSrOkUWmCuTy/UrdT3ZrlEQ10jSgWiVdPWsxUatwr7XNZIaB7rRt3lhgIs7FfX70jf4jiU1F+dqIlyKq9oNeI4zQWXbgvlPpCGcIh5em/mwK7Y9f376we8aqDJWZ4DJ79LKSZSlKX4r0dBhxHoi6AjFRpnLhDOvqYNmK7lCo0rlXnPxI0MDw2PTONbOhzKfQiyyeNpap9cg8ZcMDXeIKWWPLnZM8sWbkWLH2yldpBZRFUpOjCN6ulp3ZFj9jRhGYiEsE9jrKl2a4wG0Fnjf5buiYEcAhmPr4MIQsIYDD+5rAZcHJSRkbM66T
X-Exchange-RoutingPolicyChecked: Ss3jqxnu4ba4PIfFia8wlOQBJvepJNELiJgJ2PspwtruJnEq4485jTU4CwfNEPPC7KdbnInNP3tuu/vBOHAkWCbMnkslktego9sD77+b1buWQRre2fGyvqG4rs6Pp7s/a82L4oIjahHjRF3v7mpt4z8Zx/HcPc0QMRQlARvzhcPibz4Vgkmx8u1R1rz+LXVLZKIENCOrOwMc0bbmrjcCwiT2LB7exe7pHphcG0NB+Tr3JcICwkhm+7a//i2Qapdy0O5kmDf8ZFrr2tkEi7Q7P8rmJA2jpgd3PDes1YQyziS/2nJQMHoURI24J1jxyLNCFc+5wINPepw/l2rh64YVMQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:18:15.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9af085-a6c4-497b-d7b7-08df497d6121
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX+HbUrpAvitFj
 nokK02a4xGY55/Qsb71Vu1Ekj5M1UbZBr/RptBkWOwxlW521jP5LmsfZQ+D79IoPWxOqjO2HqIW
 nkYiWeQDKLMDWZeQXyrC4UwLpTReb18=
X-Proofpoint-GUID: iILaGUyJ3Ia6WG66ueaHk7xO6Qd-feit
X-Authority-Analysis: v=2.4 cv=d8pgWhjE c=1 sm=1 tr=0 ts=6b04674a cx=c_pps
 a=yJkyEzHMNmsTB3XYPV+H7A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=Pfn-uzZgrnnfYlMxefoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iILaGUyJ3Ia6WG66ueaHk7xO6Qd-feit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX598+btYZeP0S
 dNbQQmNWYNgsin3MikliyhnmEOzrRMcwZWfA5sjeCya46Yz0HT8Ct3sn2owVlp75GquMohnB4i8
 z0We6SXykrlUpBD2zrJbo62s52YPetSZYme6ViOQ2TH2aISRQSeB1001uhoK2OXdHczDbKjiMEh
 cdzg05rh0JhWhq4IkuxiFBsw0zNiiFOX/AMiBIsXpyGK8YWpuqsWEB2cKsKaSc8+vb46BppUAxK
 nKmisMGPtE5KcKQDACwyjkvq2rkbTLwJS4J3qzNbz6nIah7cC9787nCtirsJD4ZAqTVBRUICbg1
 3f6gRbNOhJx9ACaBNFQkzlew+0OxpORGiGTIrkO/Sw3ZYWME/fvVxTn/kdNvuI/abalG+e69bQv
 2+BJIL0r0xQl5dPS2SZREeFZzqGVkuoUdEUJORDH7NaHmd4t7FNDhOYWJF9Q1jTGGnpDPdQ5gl6
 T2jp06T+/8Q3upo3HKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 5:54 PM, Francesco Valla wrote:
> In R5 SPL, the UDMA ring and channel configuration requests must go
> through the DM2TIFS channel (dm_tifs) rather than the default dmsc
> node, as done on the J722S EVM and the other K3 R5 boards that do DMA
> in SPL.
> 
> Without this, when booting over Ethernet the resource management
> requests sent to dmsc time out, the secure proxy thread goes into an
> error state and the CPSW port fails to start:
> 
>    ti-udma dma-controller@485c0000: TISCI config ring fail (-61) ring_idx 19
>    ti-udma dma-controller@485c0000: alloc dma res failed -61
>    am65_cpsw_nuss_port ethernet@8000000port@1: TX dma get failed -22
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   arch/arm/dts/k3-am67a-r5-beagley-ai.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> index 61ee75b74323..2d8147a09e18 100644
> --- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> +++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts

These updates would be needed for any board based on J722S(AM67A).
Should this go in `k3-j722s-r5.dtsi` instead?

In that case it could be removed from `k3-j722s-r5-evm.dts` also.

Andrew

> @@ -17,3 +17,11 @@
>   &wkup_uart0 {
>   	status = "okay";
>   };
> +
> +&main_bcdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&main_pktdma {
> +	ti,sci = <&dm_tifs>;
> +};
> 

