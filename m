Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C0606A321
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tHmFQ+Rj;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bDYS4x4A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFF4F80D84;
	Mon, 26 Oct 2026 08:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C85MTaDNrBlm; Mon, 26 Oct 2026 08:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F5CA80D39
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002014;
	b=lU0iBDMB+8/96KnWLIH2NxYYZKuXgEIOVjf/JRdLVyA+PcBPZ1MgayN6RBeJ968B0m2T
	 1LHZh0ec55PUvB4/foYDg3qGpO5mblNUbudlDliO9dJV3hFqxGxvoBpK1rtX1ZRJItNqy
	 6x0HHdiCaN4RzzDXNJ4/7/EDVQmKlmsid0oj1AP3BefFdJcuDDypCiYJTTVpwX12UD0Vq
	 Gqw1D1BNMo6qwQUqWKINwPg93/jgtc92wtS+eKWHl4UGX3KmI2AoDj4NC3qAD6uyUwyRl
	 d3+NfBXAIiYadXQvix7s7x79uBGFI8x7g2Q4/SfA7gvrWur2W4qFbi9jVBs4dQSAe4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=SubbslqOaymeZ2mfAu/XNZWD+P8RNw53Gy0IhgeFr30=;
	b=ZeXjCBZJt3n8JChF+2abBeyIHqYmJMMvD2sSFzWkc+Y206wRPAEN5Eegrh5ShfCMbDIp
	 C54p2G2cP/a6Rw9IQOmoR4++xj5dJSpehZiQ3b5r/a70Jbe9hpurAPIrfgDFLWICt5GBN
	 Xq0OoM7BfJq3sI803i5PjVwmrvwOs/G4hcaV5qe60/dZZirPkdol1PO5njxhvOevSmDsg
	 4vDHSEwDB25Fx6UIiHJnUqFS3P0rfZCQtTVB84SkDs8PFgqCyWr7mf3mWezedkBVT+HtD
	 lX7JlnB1W3hDCjjAj+f4Mtn5LNSJFjPlOn5mS6L0SmOWQZfPOaroVXrO0bCjsr9OzIg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002014;
	bh=SubbslqOaymeZ2mfAu/XNZWD+P8RNw53Gy0IhgeFr30=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tHmFQ+RjpQ9Vc+30CBC1FgQ2CR++zhes3N6GFCni/Kur7J2tAorosCexA5wdC0q17
	 OHXzlb6prb0HXp6IGHqXsEf7LWIL5qUuj61MkqI9qBwYO/X11oeVrSVv9sdmRlwYGX
	 dwbq3f0d8fx4d9ZC9mJyRDjeZfCdkxzB93nDaOvn5LVRo2hLzHxHsZEw6EyQp4g85r
	 mj0SxdxgASxpNmoogyd8RpmZcJWbr1GXg2xKVqWbjJeGlX9lfCp+jhqblylercEGMP
	 7V0djL49myyn8gFon+cCpekHZcm3WPUDzMmyreT88l47C8xA3HbGfdtjShxoiPqFiq
	 Hpqm2bZdRVK4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F5CA80D39;
	Mon, 26 Oct 2026 08:06:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BAAD235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D79C605FA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJlFYGKHkg3P for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:06:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3691D605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002011;
 b=kfvA+Mjx8ZMdN8Vsz+RPKYDll+gowkjl52YbsK5a/mHkTAiJi5UhIQYFvqJyyIilowq2
 OugTzWIrMz6OlzKG6Xtj/mepeScXqWYSXr42AH0PD0Ots3XRP2VRDvVk99HE3td1K3mK3
 3B16jVP+7TqBrVWNtzY3r0FQw5obmydo6h1oZ83iepb4TVfsLx3OZXyk4kzbAAqlK3Mzl
 1LZYP5Bka0VcnQJ5ieOx3pjeG3DIjbc3rUv2FDN65PxYXrOBgTl6UvwFaLkJMjmcrzdwF
 /B14tql0TIMsGFeEy8Ibc6LTIeMzCGZuCL13Ps/Ui4fYBHB2uvle66gQIwNoEi7taIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002011;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=SubbslqOaymeZ2mfAu/XNZWD+P8RNw53Gy0IhgeFr30=;
 b=AVkuU2ja4UaIFl3rYc3i45EaOeuJmFw5VIEN6ubjGER0ibsLvK0NmYZftpE+rCLf6cfk
 RdLRB6ZjTxFwd7Ed7cbxinmvjHrkWc1/QXhzBcWB6bXr5ZyiH6fc6DwgeVeNwyuDb334R
 XLGuifZDdoJSzejkeviMGVKt4DYUe9XPv9TxdUqm9kjzt/ZndITFswB7AELCFoRcp25Eh
 /q4mmy5i8LvTc+q8Nfka9Qd5j4Agq1wRmaJp/SS+9R0s93MteDVpeAiFpDGcwtTXgSv0E
 gid0lcOC05yxnxKpjyHv6JULA/tYIVt1W35kgjkGVW6gh0OkLg7WOcyBucFYVsskFaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bDYS4x4A; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bDYS4x4A
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3691D605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1cl22a9yjN64N2WdPGUL8hy4m7iL6byXXq+lGX4JHFsB4HonEhgVZuRXjmeBCQ2Kc55ypUqwFJwErmj0u8uIvvivRxJyZ98QfKCNkTb6otPA53HkuNMTUtlNV6YQOzU9h/pDAwr9p6VfLLimVYTerxDRwuB3jfoifs8KmKb9znCikuLK3xU3cnN+VGq3egQf7d0tMFqPRKm6dQi6MV9tThAbSyHJ75xMT+fo6Zk/h79GB7ifHPo4HKdOXKQ5BCP78SFYE7hewcFDNqDks86wqutgp8DmUF+uywvkxxWPmn+BDL5J3nAcNDNAasOZ1ZW6qeVS36+Ubabg1/A6jh6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SubbslqOaymeZ2mfAu/XNZWD+P8RNw53Gy0IhgeFr30=;
 b=x6UnkBFxnVR4o6thkTsRTrS3Y2edFXkLxNf0Kbhw27wkBC83lRr6v/RVLU7ESCQ6Ic2Tm7QEFbQUck9nXNDKOW8qciauIV0BQbiX4X8UAFcq4BEidVkAmj3CTS+dJJl8NHihXsEmOMkfvegC4umzCrdbmHxLW/RSfj1Xnk+REW0paLEDPL0B9CLGNUWLBONsnoHGnp0a2DM1TSASZz92HIrsR8kMF6p48Vu+Uid5c/ubLmhHaRx7o/uYIFnxPbAbi/FehFnavU3ku+byuTsuxClM7IXoRYw0cvRbscj6EJGD/IRvdgMJQCkauY1thCxKRJe6OXESxzvPqtIm8drvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SubbslqOaymeZ2mfAu/XNZWD+P8RNw53Gy0IhgeFr30=;
 b=bDYS4x4A90BR25JeulRODzKHYmhmHWjt47wgWLNq2JV6PW+2z95SVOtCvr9pTVgpfk6OuFfD6iqg9w1gyu+JJMQJ6Vl3xcfC5LCQxm2+TYT18iVj5BxA6yCbuPxBVWEKPIGsVlXrLw9SGmILPpQHJEKWeRKk26DAAnWnmQWiqtg=
Received: from CH0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:610:e5::10)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:06:43 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::15) by CH0PR03CA0245.outlook.office365.com
 (2603:10b6:610:e5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:06:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:06:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:06:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:06:39 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:06:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] spi: cadence_qspi: Fix double reset assert
Date: Mon, 26 Oct 2026 09:06:27 +0100
Message-ID: <840df4102aeee1108ffba82c74dcfefbf0fc062a.1793001986.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dx+d/LoWmj5ppmLfC7fklkq5qokmLjpIRdt1PsA/csg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5+K0W1/mEOB3Xyr1s8SKE9W77wkaTnRoyvxwpoRv/
 dl5/7ktO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiO3oYGW6+/bns9nbdL4ti
 nzi92h5zZa/F0YZlniFHnqpIdd6fuLyAkeFjRuyL+Z3NO9d6O6++NW35M603KRGpwg9cPZLezz/
 6IosXAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: e47cf984-ca10-4abc-e763-08df333812ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|56012099006|11063799006|261021123027099003|10067099003|261009223327099003|261009221727099003|261009220027099003|261009223027099003|261009221227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: nb9JKM52BxGhbLz/1N/GiR9W/yFtoygF46EebTwmPAOlKhu9YMA/60mUM9KPxASwBBYFVaFwC9P6F49e/HVSJQVU2+LY9ninNCmrRNpoMB63cbdtvA4yIhMN8K0adZ2Hx5qJYANVYPBjdqN5NZd3pkpEvD1wADWO0wNSyWTGYB4B1TGaborHfuJPF6tPPIejohvxzn/vk2u1wB7Q1g6681YMOAiZm6gc6hQKxN0M8aRX6j517sv0lapWRKKcdkloXNDBELJhDZixYHks79ckHR7sabqulGkJkAwLBU0NaQ2W83ySG0q+pJw/FkOSLx1McBQ4eFJrzgsfJZvfNW3BMG7HsRpjqfSfdibJk+TLY+o3b4G55HIbMdpEKNGG6/pm4eO3+uFPHmcqEBUKGnUDWPSceHEA6PUxO+upBmth359hgJUmHxqia82tI9ozmtbjiwNlicvS1T90WmnZiG9jTJUdCizJuRC14Q+jSdSJFGU4wGi8lHfzq+Pn/+GOUcX7oGH6hdgJcGPtP5zETCagID9ac6nTfFuW6UNE7njS2xOGb8QE+3O1V4zxsXxfXrewHgV+2OnXDcvbysi+hTW+fgQPVwFePVLzSDWRaQVxV7jaiMFA2pRfcZRjzMpSmdO5eIDH4DAF6K+fEmaImhC/i51VkQRsanOlSBQ5eKCX1tvy0VDa40I8uk/1cXVM3+iU54M8f6aOpO4iniNc8DlSvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009223027099003)(261009221227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SWVA62666/76/ZFr6xpg5dvv73goh7PoBGyRQ+A7Jl/q93JFiuPJT9kpMTmIsYvLC4EVh5ot87ku2vPAUH5y5bgmJn9avR5JWi0RhAhwS2hJdWrfnsip+4tCCpRzxAJIVf3moxYlY+jpfPePNZ1f/Dqh0+l30j0t9UomMSIcnLCuQxS/7Dkaslv7KG514HiByI9DEEc+fVJ1sw+OywQt1i6RYPZ3ayjFQs9KapIO7zmrvdhrr0Jrh72P6VB+yKjMyN70VbM3bjBOV6aCG4B2eI2DEI0O08ZMihoa7B4OcuKgKGw83u1qoQWByiKtCnD+3/Xt+y6wmJdk6PLmH0048Z9B6UNfrXxMlJxH+v7Y5r0XpC47Zhe50/OKSC7msahC5CrBaEAOUzHN6xDfPvOIN5yAJzTaLy8QM1zTDveLP7//CPL8+jtTvex1NGR+1AqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:06:43.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47cf984-ca10-4abc-e763-08df333812ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

The resets are requested with devm_reset_bulk_get_optional() in
cadence_spi_probe() and released with reset_release_bulk() in
cadence_spi_remove(). Because they are devm managed, U-Boot releases
them a second time, automatically, after cadence_spi_remove() returns.
reset_free() does not clear reset_ctl->dev, so this second release
asserts the reset again.

device_remove() calls cadence_spi_remove(), then turns off the power
domain, and then does the automatic release. So the second reset assert
is sent after the power domain is off. With the EEMI power domain
driver this is not visible, because zynqmp_power_domain_off() is a
no-op and OSPI stays powered. With SCMI, PLM powers off OSPI and
rejects the reset assert, because a reset is allowed only while the
device is running.

Removing the reset_release_bulk() call from cadence_spi_remove() is not
enough, because the automatic release still runs after power off.

Use reset_get_bulk() and store the bulk in priv, so the reset is
asserted only once, in cadence_spi_remove(), before the power domain
is turned off. The resets stay optional: if reset_get_bulk() fails, for
example when no resets property is present, the driver continues
without reset control.

Fixes: e145606ff293 ("spi: cadence-qspi: Make reset control optional")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- reset_reset_bulk() requires 2 arguments not only one

 drivers/spi/cadence_qspi.c | 10 ++++------
 drivers/spi/cadence_qspi.h |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 4d13c373aca9..bb8e7004a343 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -260,13 +260,11 @@ static int cadence_spi_probe(struct udevice *bus)
 		}
 	}
 
-	priv->resets = devm_reset_bulk_get_optional(bus);
-	if (priv->resets) {
-		ret = reset_reset_bulk(priv->resets, CQSPI_RESET_DELAY_US);
-		if (ret) {
-			dev_err(bus, "Failed to reset OSPI: %d\n", ret);
+	if (!reset_get_bulk(bus, &priv->resets_bulk)) {
+		priv->resets = &priv->resets_bulk;
+		ret = reset_reset_bulk(priv->resets, 0);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (!priv->qspi_is_init) {
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 6a8f9c58e4e6..92f3c7f43986 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -246,6 +246,7 @@ struct cadence_spi_priv {
 	int		read_delay;
 
 	struct reset_ctl_bulk *resets;
+	struct reset_ctl_bulk resets_bulk;
 	u32		page_size;
 	u32		block_size;
 	u32		tshsl_ns;
---

-- 
2.43.0

