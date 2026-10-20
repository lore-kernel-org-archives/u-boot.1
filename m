Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE1606A320
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eoAfETCq;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=elSqP7+l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C754360730;
	Tue, 20 Oct 2026 13:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cv0uv27tNVo8; Tue, 20 Oct 2026 13:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27ABB6076C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504330;
	b=JfmHr/FYypYQAtFBArVvHf9Y/ItIEPYFB6xkfkLcMBE5DFDdirxy7tqKHenFBA3+vbu3
	 hTYD8k263wtYP3k+IVy4EwvDBlO7qyJml++fW+M9Q52GDL5MC9aqqxXlcg0M1i7ClVvFh
	 dmR6RE14hlBHIiuB2xDwvswnIxIzgpSKn9zbJoM2zRbVYSErZFw+y6etX3BbOOVOCsFpM
	 rBevzNIW2MjniohxOdbn34I/L8L3T2EWFSs2I3vVAxZF5wRgWXE2/FSvQl7qfbaM8wBkH
	 +C8m1x+9gdzT/j7443zqUqy3SYJwrrC/9ifSg3w6T78CuLlblAmBmjoYoa2Br9bqM/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504330;
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
	bh=5il7A/+BGdyVTET3IP5WcoGkV1iVDcCWhUPjp53Islg=;
	b=WwKibStwfA6YxwO+cnRiQXegufFfoC7WqIQPrHqTfZayn/yBv8MEgrtb8qe+LSXdHAqV
	 NEOH3x6Ueh9EmrdzLIw19jZoKJ5Ml/SccpqlMIIzkZ1UCFZSObUg4SMMn9R3/iv0C4Q33
	 avY3d+ODtPf61nbpcUqaka2xdvEKPWS4AzqP8r+hRPCU70mW6CCd/+WAlzvTs6aZeNhtY
	 4ZDrtfNe/7qry6zszoiB/VkHHFuiUboR/ZmTwG5lgwuxl7saN3Tf1ZmRCVCKBxZJ0s+bf
	 jHSIUR5L6ljrxSB9AMuj7XfEyeyGb9u+xCiHQOkqxR5zt3qDCvLdmMTK93lTFKv4aLg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=elSqP7+l;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504330;
	bh=5il7A/+BGdyVTET3IP5WcoGkV1iVDcCWhUPjp53Islg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eoAfETCqONGbvbRZxrcaZA89lV3d1hHeFsVLSgZiqWf8hpfzg+t6iFaxOZ5yOZyBz
	 cjsE+UCVd0pNafcxrnRblZZx2JHcZK+JdqlZ02QaZpyaHB3j908M7npUHaVyJWpEgU
	 Zt4payw839z0Vk0W7ud/d4iBfjroBY44wQZBQ6YM0XmNg0Geb+dfxCwaFhqHf2/+1Q
	 KJOQLteY754WPdeB9KJ/0HiXYVZiXwOcR5rDlZT4vRIdwvLaGooi2Yekijr6gzFboZ
	 jIa6uJ+p2GEmIJzTC6b/WFDF+9rOCb7HpYdNcybaGjXoK8KxAER1Rv0Tf8jakydkDw
	 cJlrQZ13dNvmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27ABB6076C;
	Tue, 20 Oct 2026 13:52:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 488461E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2ECF96084B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oo8E5bRWelaC for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7689D60730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504328;
 b=dUW5YGiwGVwYETxzaEBw/ODFUhdarhsOtq2ryMYKhij0Id/TJqb8mRzgD5PRykPIUHim
 +Jpp27vKuFX1SBtZejVbqF+w9T/NNfvZYbNqfBhkiAhOQKt76nFANjheZzIFY2a8Wu/sv
 1/egIq9ZRpCY+zWqTx98XQTn5i4vtNI4yxLvwafjpvnczOoKaizUEbTma2tbmZRNvBSDt
 hsJ/407oILWpA//H6NbFmTWjX3UmZ0/YCxyIIHruz3x+0l/Irf5r0YPMHT1hGR3OR4WQ4
 A61W+0Bn9rUUlprpdbh60rrt2VxbBSF0t+e+LyXn8TEZZK+Dt4CpJXd+B0JQxyg7yPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504328;
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
 bh=5il7A/+BGdyVTET3IP5WcoGkV1iVDcCWhUPjp53Islg=;
 b=qRm/Aeu/O+bq2932ITwVRwYnzSQI13N1Ap9UdqO+xxfUEmI7tI0goGOTBs0mHLDFo8Gt
 rXOK/TPGYmpQTsSfGPt3SU8UUybbJvnbt4+vm1wy+UikjKmf69O6iriTJmcx6rUC5Gwk7
 dhVYf0KRS94Ym2JqBAQwFtikoV1mJIktPzDmwgWwXNPAeIEdvmIlyyEQ933zHMeGjwHyr
 t9YzM05W1ndWuFI2naYBH6b94C6T/ImalugtoRqQbWDRulyXl+rcZXujFxctfxPGldpBg
 CqkkJDuE3iuvqEuWKhGNg82JK1fH7Qm6VlSgm2t37S37v6Mj9AW4hSSCby8ES+t6oWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=elSqP7+l; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=elSqP7+l
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7689D60730
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVHMn4pBaJPfxdjd165w1ivfz7Zs5f06ZDNZnURqTDABYCdRpdu7g4HxrHIjhP/KGEH8pysCgN73UG2qleRzmuJjxZ4ocTa58nG6u4leXMz0tIOPNMV+oT0QLaoyCS2xfiqlvCIKJDBKJ199wcKQYUlLeSlrqvdmLe/WV2H09HviFCv0FuzYUiwu0VaL/JdyHXvQwug0Zd+q8za0tTI00W5PAMCXAp6cv+PXpAHJFch+zlb8fh7GN8sxEwEZrDp+H8+by7uWNEQ2cWeUw4M7DOpe8YvE/rhLOaPvsStlFY1feCKyX1Xt2oZ2HX8u1j5LgAMVOV8JrAp3v2o0QWj4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5il7A/+BGdyVTET3IP5WcoGkV1iVDcCWhUPjp53Islg=;
 b=ERuv92NuU4h3ULkz9fRFPANZSPo+Sop9DhYObkTpxmx+4h9gN6H0AfGbqyTZ4n1gGN+cCpY29NHc7+Vod+ZVeQTyzVTZZ8GJmt1IuyOceNfEK5dAVFASfrleCOdCnEsgWGWL4wjbvPxvgGCne9M36WIoZyo+GKpK8gP3cyBpi/xF1kVI7DjBjMVUBS1Xec1SgSE1wTE8kTk2A8AEpHWZ8sgLEcDdsHpe07181gBRvN+SG5QGd+9nvfGXcDZx5cPDuxO3Fh8SELYP4qBWqhA1lTtFWNpFqsG1k05wXiUFUfoKEEjK//cim6FczxT1UwzkviHdSjwIo4Vv3UEu/iAfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5il7A/+BGdyVTET3IP5WcoGkV1iVDcCWhUPjp53Islg=;
 b=elSqP7+lxj8/j2uQ4JuXmGYziGOubIlRoedOYjj26LC+xhEMJvG1M3sPNxtSI7LdJZE90s7R7XdZiZAD+dMOF98REuG581Zz5nBxEy6brAY/NwY/Chee2WkyO9NLimJRUXAG1hXcld+gbHRg+mblXczeJcaKjMkD5rLri2Njjac=
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:52:02 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a5) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Tue,
 20 Oct 2026 13:52:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:52:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:52:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:52:00 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:52:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Akshay Belsare <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] firmware: zynqmp: fix PM_REGNODE_PMC_TAP node ID collision
Date: Tue, 20 Oct 2026 15:51:48 +0200
Message-ID: <984538550e0da30844d82201b3eead312a3af78a.1792504307.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gTBJj8vpZHPtC8ean13ePXhJk7BHSa5xpKgF4Ly977A=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL/ybWnLjefZ/dtNFgnL/ZNXU12f43JWfU2hXVKl/V
 KUl9wlzRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk7V9Ghi/imX1bBc98yTPf
 fFmyfEY8oxt/lJLwN+HWNVVpr55KfGFk+FyxbbX96QklOitaAqZ2L9ItfZXyN/Zh/Q9rxXofoaA
 IbgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: f343152f-8c75-4560-7ffd-08df2eb15171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|11063799006|56012099006|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: EC0PqcUXIM9+R1/eCPy8q5VNI6VWFBbZdAW26VYfEk9VmsoVnrl3FS9cRHcWstirA6Z3Ox5Ae1n02/q9wuYq2oGef22sEy9OFUO16haXhbHduHyPh54UAvIe/xO02mas63uOf06IDQMmyop0mJuzq5aFf5M0tPsusBM5A+48vc/gwFoqTLZiSdhFhn3dhox/KVfFWQpaFi4/gXNvcaZWn0zv+95/HTRQM+lPACLFze81rli2BkB3r4yoiYfw3vqOevdtsthc4Xa1DnGvzsem8K4J7Msx04SLeBgxoWm1rERG19Jpv61K1Jd8m1cWJ6FVLhSxK12R8zZU+ntHblfzKYQwdJ9XwLH6G8J7HtyGFXNRQLmM0SpLHrdYVAUJOAm6xU8IJi1NlP8noEQKrL2t+Sf9oTM5Kv6npK5GAk9uvc0Q4OFyLB9qhvEOC2s/tB7YzOGYl7jcn+N+4zyvlhdkTgvokuqioiKd8TokFapZ/DswPo3E+BIX7ass6Ye+HIXsqQH00grTocmVBv4XuL6nQuFzyrlDJ/m3N4cQcuAiNVUfmLU3kBl7I1f7lj6g8OttI/ajq4gGgUB+oP+xtZ3d3Daqwnx5UCOgmAwjDDnGtQ62U5Fuu2arbn8OW/Z+9d+elvxzpqdWY6ukOqjqeZEvFmOCE5NhxWL/zC5LT4D5iryNzbxivBjczmhMqqvsalM+YAFE5yXjqD0Dhr46R/M4Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O+xwRaFJ5hIxbp5GAiELF8++no02BrNRllFpP42MSL+LIYv+pp+7EubKO5LsTJYsN7sHClHuCAuIE0oc/Ft29xLear3Lzppg1QsiEBXs/xZm84PhR5VOmG9UWYbXwp9HARKizLUHYqWTsps6CyIPLR6syzG1+HG9G1XyYItfYmu46aJjKR99g0HSGR3w6/sTZIBqD6KbDzgAfjOpNAPibQTcsa7qHaxoR5Pc8jhp+sgUSXhMAnmapegzjDgot8SnSgV1kIVVunrYpQ6dRTSsjb2Ut9+5FkvdOXr1GOP1GvSughvzuam2dqe4+7PJtErFM4Dx2TfDnZ0rW6fhmvUdhXzVg8sZhEj36AOi8SmYqkcbX/lyPclz/pK0hToR1vfG1u/xN8GmiBkAYlpLAbv6/F1TDlJ+IThB7ivyWU8lHNkBgeulplQa+GfQ3C8BPFOW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:52:01.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f343152f-8c75-4560-7ffd-08df2eb15171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akshay Belsare <akshay.belsare@amd.com>

Update PM_REGNODE_PMC_TAP from 0x30000005 to 0x3000000C, matching the
dedicated PMC_TAP RegNode used on Versal, Versal Net and Versal Gen 2.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/zynqmp_firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index a0a2ed79643b..87d7051f814d 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -540,7 +540,7 @@ extern smc_call_handler_t __data smc_call_handler;
 
 #define PM_REGNODE_PMC_IOU_SLCR		0x30000002
 #define PM_REGNODE_EFUSE_CACHE		0x30000003
-#define PM_REGNODE_PMC_TAP		0x30000005
+#define PM_REGNODE_PMC_TAP		0x3000000C
 #define PM_REG_PGGS3			0x30004003
 
 #define SRAM_CSR_OFFSET			0x104C
---

-- 
2.43.0

