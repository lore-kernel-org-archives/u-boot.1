Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B1CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 11:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 010E680BE8;
	Tue,  6 Oct 2026 11:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cIky85LBBHS; Tue,  6 Oct 2026 11:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4178180989
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791285099;
	b=VIcC2Hleo2ZuUDNpvMq8RRJ9vuIoBVDZq+EumnQYMgPBblYfAVD5PHKCO9fueg0sUSIz
	 YIqoQpbf+z1F+bh3/SjCeMR0KxBBgZ/M3BFm1AFavvQCtlApF2H0y7/8qYCldP3TDKyj0
	 +Lwchmo7cMLun9BDdMPh47c84itfakmx48oWJeoVEsSexB7bgTQpPdbMjqr6ew5i/D89g
	 3IHAptbwDTEbbyv9S6lXdW1dHXssXSiWSIcabBpdCWlzyjdO3ac0vtxwSHWZr1MnjiPxc
	 irhtJWquqFgIr8E6blhCa7xJXCxAouvWntqVadG86niNKYK/Z7W34KbyJIalTJFOqvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791285099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=TSM3a5amqVgX705tUlklNFGgZiP244SAkycoml88dtg=;
	b=EAhfd8XXZBaKiLzpukGYdboPBdRgH3PJWuDiEFtPIM9wlHDkpEdnEEgkLN3V6m8odp1V
	 v5EckxGF5ZEuOZDfC9UOqtJJA0CFwGdcvFH7CpCX39LEaiN4IElb7bNcd9R3cTXiJjMel
	 y5fKA2GMibkcWxM2Vnz1wn6h82Jh4VgxmXohdPCvuDxXCreZYbbpw3qmyLPVsQt50w3tP
	 4x9jTAbvNADkxFg3fPvsO0n+tFgCvT1/Lckhuchm8YL90xu8do4dWlDc+EvlT0o8JWiqu
	 mSJvXDziZTvm9EZZ9kgfcputwBdIDrP9ZXYQXOh2VrnnAjhY694Tb8IJYQTT7pgZl6A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AY71YZuf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791285099;
	bh=TSM3a5amqVgX705tUlklNFGgZiP244SAkycoml88dtg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UQkN2r8y9MGLPvtbaB6/7lCbYdjV1APeUOtZ45vtGixoG9vonj8FNP3ra+tBIXPUc
	 2BzgxQX6cOTocpmX8XdjjehxiARtgWh+/R5g7Z4Wq7Avsl8Wh6T2kvBSrmC5n23cCf
	 qhur0GWtlf6AZ2lEI6N4+QE2rj+FbtbfTsqAQfjdI67BeCzZowxapx4pZGlY7AxQgB
	 9XNYk02FqseZIGFGpyWtJTAkksmkDEu1slaIzdqfqf1q744jSD8p+AurmmgGF2lrRR
	 J7a7mjFMtRPAIVk3TEHEd09nZNOGHYd5fBg7txoo/6GbF0mTbGtP6ZGZxA8mhB90c5
	 un2X5bKPJI8sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4178180989;
	Tue,  6 Oct 2026 11:11:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 111BB341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0219480BBD
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2FS4ANJH5Ea for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 11:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D5FE80858
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791284994;
 b=Ee4oY+5NdZ0L+sFqR94vfnHLViaL6yTIcEInxK5HxuiAoly2qfpOKEUHGYcHiouE/yBO
 XHLFKZEwYGwujMC69+05ehU1UhvrVi5Xg8dfhdUzOeiYWWhJmKuJJxdiQ9Oyafqf5mHMa
 LuSVf6W03MOOhqPkrHwLA9Ay6S3w7SKWmXpdthMtWnlilMZl2wx2XSRJ5BP65d9T7gtmk
 R0shTpm96KmIU98phuOo7ANC+HQVDTR5U/r2NbNog3mN57ALB2yVaondcV7M35jgaShtM
 I40ZEX7e0DCRJnlDf8QgwLLTbrIl9KawLcZJSWpokIYLmV7TfQBdKdnMpPMQPrBxcEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791284994;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 bh=TSM3a5amqVgX705tUlklNFGgZiP244SAkycoml88dtg=;
 b=A7kBSm66ueDAoyHbxsg5eQgOo0iEZwXARg8L8Nn42QL7ahioWLCePRagh9aXyAJAnZK8
 P+Jw1I624GKPLdsDaquPRBBgSfcXXUXcHCYSbiZho5fQBe6AybFtAEJyucLNiBrD/V+Ix
 94+ffV0AswA1itQg309K8qY9lwNwTHMsyYxHQ93G6QC3QMI5vWuix3QdAq58GDd5P5F8Z
 ZDMHgelEo8AUJHrC/ds7OxAqGaaajHY90e0rBu7ZTH7KIFxPiN0NcpXIQhITYp/quxM7E
 2FQJtMZjpSN8YOq64s1gSYkkjDssw2guaux2cQD1TVsZr7jkA5si+PlPjpt+dtfx06g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AY71YZuf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AY71YZuf
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D5FE80858
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA3TfuRUIsDtzFAPn1HypORGxingJZlG77mgtu55gDm0Pr2LuiMCiEMXFDjxn5na6DYw7TYMXXpXwWCn5kB6ATzo3u1iZ0cTIPXa2/0LucTzPThOvCNSOMX8TKp38Uuudek+hxS9d+qWB7OCk9QQkCLYUfqzd4ok+pUt0KvL4Ny/qSBB3TtxSWRRVlIi7nEj264abQ6PtcdDI/kv8Isv9UfidS2oQzflb4U9o21rrjTdDVV67p31UYrrCSrzcFVnaHc9nia3mfJUyTo9ZK/ub4vYKv7QycJPZqr7DJrREp3+kOF5hAEb3gULoPnaM10p2Bo+03PuWDvYXjFGC0ohIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSM3a5amqVgX705tUlklNFGgZiP244SAkycoml88dtg=;
 b=LiIOlRKvhAmlsjKza6wE3Zblu6YLaKAtVLTPqD/VIT/mfFhw4YIzV3i3LJxJh/iG3cqQKkDZF3FYI+3AhZcp52vYsctQwCt+Ofr6MilQe+I8eLgu6FOioguvxAEegbgSf7pW6S9TjT+87jGqH8QxTz1xEb6we+zXPHOS4nOAiY0wySVkRjWMFOvG9YMej/Sxw+cGuBqq5hfl7N75jlTptn5GrG12xrTMkI6qv6s1QX8M742/7yBcYIjmDWSIFsHIi6t8wsonOkh4oqbCuc1DAKIdg3TkDBZ+qd/REhjjEyziZyOia9pd1YKuutNo3mDkrZekkS9SBRia6B0dWkSS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSM3a5amqVgX705tUlklNFGgZiP244SAkycoml88dtg=;
 b=AY71YZufYFWdM8TSbmBOlOxvHHrv2y3RFSytZzejWz3OhP/E+UIF43RAuS/GglN59zNLi/WOHWmV3cU0YYS/tJAnJZ8o9OTiegD0E6CZorzM1soaulOA4sQ1IIZbbpUAwsHpgWnr0LuQOKiwtLMQhbEOOL143H9Lwo/cVY5W6SM=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Tue, 6 Oct 2026 11:09:48 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::53) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:09:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 6 Oct 2026 11:09:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:09:40 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:09:38 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <trini@konsulko.com>,
 <sjg@chromium.org>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 0/2] rsa: fix rsa_gen_key_prop() buffer-sizing and
 zero-modulus handling
Date: Tue, 6 Oct 2026 16:39:17 +0530
Message-ID: <20261006110919.396293-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 504d50af-220a-422c-f377-08df239a556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +F2CvsuYIPx2g+ly23eIxX6wStmxlqZSLIQHlDAaD/S8zXv1r2LQ8KBs1byxBEh8H+tlJvFrTp/fp/fbbfZ8plxpw+Jq5EYc1ghewPx3lIcqxlNj3FhMhcMUPfDayNz7Zyoeh+p1uS5eKGYj8TLuEbqCFD5AnudJNzlorCnePyFhbXVyIySV9UM8uflx4QLd8BR1vId/YUI/NpWr92wsT47aZhLzIUXsecVoe640We2YmjGsiYjvumeRJ97xBK9edBXIEX7WujNusWO8mPRlsA/Kxn+iozxxpqoLTiD2EEKP+ibFuvtD9we2c2J6uRo72NtEgLuD1l9247qmK4mLMO3hDmk1V7YZ79B7yeDcLEIjFl8xoPtvt9VynxJxzm9WsTeEQ697CzlZxAg3JmxcMHFunw8IkufNIUQ+nsJKAlZmO7ss+dsMi1wCUMta44A4DbaJSBdIUQXdgQXZ7j2DNOf2BC6H6/h/TghTQO3slznyR8PckQqRhDEtIwPfu5UqjIRJUz6VvvC92yW4ovNEVdORNHvMdHzNFf4BjTLXvcc89Bg4ku4tGeHycUkkiGrmOpK8zQWxLbN+pwlFU/r3AzZbXBaLlUEC4Yt1OlhGXHji19vEegRKJFIQA0aI4+NX2havBlFqloTcSTwx9Oq/BdM11gPIxofNWb4h1MPpLKSObkUoIgn2LJosMcU5odshpmRBCY+p74/gAzU1s5oo9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s9tX0Y1unF0GcUMoEZOogCRt4Aq5/SfRgstae/dLhuchCeeisgm5kN+1COYLycuJBs5C6wkI25L6aMwmw031MBtbN+M70mNjXuKbI1dnuDdbn8QQPloI/2P6PwvoCjsC00u8Eb+9a3NKMCbyCr6KrJMZEh7paEp0aFPiBCLO2gpcc1L3D1iaTy6np50h/4CKho0y70+z+3sC/LlLWZxP7BW5V9R4G3Wh1wx5DANTLAnbKGtb/2rhc+Tbh/cph97/rlLA9ifjEDCHFmvUwlGt3l/WjrjiVANQ9Nj42gVWjSC+fE3rdgHjhNmaW56LJz2e0uFdMz2YkmhnjCXBePm1dFa50JLM01XPFZdcQF0lauuajEx9zcTS2Mo3Nw0qZ2JR5Eay0QO2j89Sn4Hs0PbmafrhjKen/X2SJZyCRHVvJEOQS9N2b28zlTswefo+eWR5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:09:47.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d50af-220a-422c-f377-08df239a556c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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

Fix two memory issues in rsa_gen_key_prop():
- Correct n[]/rr[] sizing to prevent out-of-bounds writes.
- Reject all-zero modulus to prevent out-of-bounds reads.

Changes in v2:
 - Patch 1: use DIV_ROUND_UP() instead of open-coded rounding for the
   n[]/rr[] allocation sizes.
 - Patch 2: new, addressing the num_bits == 0 case.

UT: 

Sandbox:

=> ut lib lib_rsa_keyprop_oob
Test: lib_rsa_keyprop_oob: rsa.c
rsa_gen_key_prop: n_sz=258 leading_zeros=1 stripped_bytes=257
num_bits=2056
rsa_gen_key_prop: n_words=66 rr_words=130 rrtmp_words=130
n=000000001c135890 rr=000000001c1359a0 rrtmp=000000001c135bb0 (FIXED
sizing)
rsa_gen_key_prop: br_i32_decode(n) done, n[0] (bit_length)=2056
n0inv_input n[1]=0x968b6a4d
rsa_gen_key_prop: rlen=4112 rr zero-init loop wrote indices 1..129
rsa_gen_key_prop: br_i32_reduce(rr) done, rr[0] (bit_length)=2056
Tests run: 1, 0 ms, average: 0 ms, failures: 0


=> ut lib lib_rsa_keyprop_zero_modulus
Test: lib_rsa_keyprop_zero_modulus: rsa.c
rsa_gen_key_prop: n_sz=3 leading_zeros=3 num_bits=0, rejecting (-EINVAL)
Tests run: 1, 0 ms, average: 0 ms, failures: 0
=>

Prasad Kummari (2):
  rsa: fix undersized modulus buffers in rsa_gen_key_prop()
  rsa: reject zero-bit modulus in rsa_gen_key_prop()

 lib/rsa/rsa-keyprop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0

