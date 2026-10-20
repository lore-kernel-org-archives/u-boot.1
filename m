Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C2606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QX12gD2m;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XxXItmLa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A1B4073F;
	Tue, 20 Oct 2026 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_cQtjOzDufm; Tue, 20 Oct 2026 14:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42A11407F3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505436;
	b=HyLkLzDxFWSv5eCMN447kzZJrkjH/Hufp7t8eACrkykyExwCSHlG61z6pGF3hoOttkIP
	 9lSBRivKjLbxkHYfCdpXNf8hx03Ynje/n0KmoP8cqcTODunnC8ZkRq32/NdHi1TVUn4K/
	 6rxnjNR+eRaDmqihW5opgVfiysGc29kxTfvKt/ji2krvx8qszytSB6FtY14t9va5bgpqm
	 jdIYd0x8AFS8IewTK4y15Kp+wsT6KXlDMLBsFn676eD1fa58G1TUUrCubOo4rWdSHlPcu
	 H4lgJb/kvnPRQPYVtxsGD1PZmYb/38sR18lxLHnuxvMx4ksEn26RGMS890IJxlbraRw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=jlI9IcrT22oMhYdWEuw5R6a5H8K9cmtSpnfJDm7x0N4=;
	b=YrGjog+zUgCZJzz2YMDXf5pboJYMmEM/O9gXvAYct2/QXtj7V/0ZImypL+kCwwYjbkg9
	 0Nz97CupEgzVzVAr3AKiwqVYF8FBdhhNMmZ+DBJRq6cXrMwEn2eHEqYQEwyRB6Ts8lrPO
	 FamxKQk4cH53fdi60w4K5/z34t881fYagjmx0tGYX9vx0j/SaNApX+TqrM3y0Nf1A6xEk
	 D/tzz5uiIICtXDVLPwuEpgfnbKmNu6o0ZKZL39IDYsFvbhMXA0J0BgCsYvTVgaJfKb96R
	 ClM2/XI3VjbZEOe5MZGqk1q0/YcGIRvmMce6s6WzFirW7mbaltsDVe5ZussUZT6x4ug==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XxXItmLa;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505436;
	bh=jlI9IcrT22oMhYdWEuw5R6a5H8K9cmtSpnfJDm7x0N4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QX12gD2m1uo1XsVqy+pf8pjpOaPWscGCEewVEDbNZVBpjcf8yCA/LIEjpU+TdKm9L
	 J3Fq+1zf5QuQuTNDJjri4Eqd73IYlY09sZutIW3z2clbdQYK8RLw4SzH8pic2G6MS1
	 b+Q6EMtdCwo8whBK/WGpbWQujFLsSwohcqRECdxu/29jPiLT1w99l1i+B7p45xycSf
	 P79dchTLiOeNkgAgvuaIp86CRt6opSKxzNOKnU3FhvID2IBVikPQwmZK4Kmu5uPpWh
	 iskPEnLIHxBKZw10ZcyBNU/wxfLucsd5fHEhxBsLlDmu1S334/caZI+/ybbaLTtc4/
	 UU7qhZUMRoVRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42A11407F3;
	Tue, 20 Oct 2026 14:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30530255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15CDE4073F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ji2RqGl_fXjg for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67B8D40294
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505433;
 b=niHp9aikDsBOjucFFQOL4WCuVs8h9CbTy38x7NhSDmNJWaKrnP1xaX8NTVqQgnnlUggz
 9Fd6wu/UMLIpMMVAoEXMX+BJEM0l6zlnHmyqMEH1PqfuRo5bFdTD0X0uoQegW0dP0tgod
 2UZ0VnfIdmCVBUh+oepLAjUnFp1ZzqSU/GkUuuxC8B2itEFKdM+86TCZlPewASItnvp35
 Q01El4MeY3gXz3JTJJ7sIyfS3Q0hI4kQbCS4lhQ+ZKhzPjV5yAJThTB2u1NHovvP7MFH0
 3Ka5At21PnG6ugiUvdg77cq+x4NIOD5QOv53JlA3j36+WaId4Vl41esZVXsDd7naXeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505433;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=jlI9IcrT22oMhYdWEuw5R6a5H8K9cmtSpnfJDm7x0N4=;
 b=SPnYbkpNM8fI9nrWQvwdZOBt3NWyH8h5OTkXcg/AQaTERKbkvyjZaYGXxmjD2KWJkaaj
 OrU16SnEP+SeUWsAVtBo9yn2LFAJJn/iXZXxWjdeznUQRSxmXb8fnbJa8GUrAL9+reUFh
 dSETJYTbFugmSDC9YaG6YMznTEeEEdoeEK7EXkRoGRwL9UNx1VLd27euSItnB02liQxhn
 7R+jhfPzSjC5/5aXx/GLAEO5kOnFh/llQLWiXE1HS9gb/AxD+2vZ/3Z+8YDRgLKxFKekB
 MxnSDM7ePPQhI9tS+XCvHBBTUV/L9bU05bDyKydgVtbjKXoGn3H58Ht9Av6jPbpLufA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XxXItmLa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XxXItmLa
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67B8D40294
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4hyEhTIf8smCAV5HtuhnNv/xV/9ysCh/EfjHnA3K9exL8j8E/YbU2Yp0HPS12dpg8jR1yjkp7W78nJbj7QnCB5TgRivgHCxir8o13xcMabT7CHg1eBnbbeTGzh/IH0lQmX1uEn4abQmdgtccIX4LCOq0/2Liqh/VqfWSZCkB+ey9sumwPIbfY/1fKVgdCcinuzlTYv8XleGkaRKqBJ7Qc1yFpxjPeSxYBaNgmq4B/e3W4jv6DfWBCKRSl5qCDwBjuHeTl/pkXXFbzJKKNQQ5kdC6I0by9mB3V47RjTu2VjR+mXvVtQ2bZCL1fTnHz40OSPofC+Uv9EfH2B9a+95Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlI9IcrT22oMhYdWEuw5R6a5H8K9cmtSpnfJDm7x0N4=;
 b=iKg4mJTkUyQRH2t5gHNqxun3kDY4geTiVLez+0Sug/iV5yZcRbL0u0LdgE9pYnGcloc5tbPLTe6JMoiw5yBRDxibSEEY5KKcHpT+eXxm6fV693KFmIc/RmKab+VZSWXzTZisyCnUjFeS0qX4LYKrs8ssuP/B5Hmy5AXXij+faC+R1GUb3FGIbgQZd7VEpcV5kYPBqSm3VNZKQFtva+k7YbSN2d9DiOlAbHL49fh3qdhgJPT5qDnllFKpob5UX74sPNHsgLYoVvle/rhK1LB03lkJCxUEqgLx1Xmhrg8BbVCFY6mSsHsU7LfpYSUWUtjuwSa4KwpN67ctH3IleWwxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlI9IcrT22oMhYdWEuw5R6a5H8K9cmtSpnfJDm7x0N4=;
 b=XxXItmLa9a79PLHcKpK5ggwswBL2wxLiO/vQo5SH69raFQc8fljmBSDT8mz7T4obPRvvSV6Zh/N6kaYt5j3LyDp70COySEQPiLOS1nbQODikKzxLqkkR5vnDCsieGLI523lygN+dOeYiyhwcMExeO58v9ikzZVOIPw2ajFth/b4=
Received: from DS1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:8:452::11)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:10:25 +0000
Received: from DS1PEPF0005344D.namprd04.prod.outlook.com
 (2603:10b6:8:452:cafe::1e) by DS1PR02CA0007.outlook.office365.com
 (2603:10b6:8:452::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:10:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0005344D.mail.protection.outlook.com (10.167.23.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:10:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:19 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] xilinx: mbv: Enable MTD command by default
Date: Tue, 20 Oct 2026 16:09:33 +0200
Message-ID: <bd951b95a554e573a8427c8cdbde971dce439864.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=600; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TQGc9se3sHSdwKAgMQjDoLAkyyO1YeCvBBtKVmTb4Lo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL1M0CDzztvb+fD27ZOHgFMOF/Ibvf23fdlmM8VVb8
 r5/NmfjOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiV94z/C88366l+/bLc/7Z
 azSOLt39boqk+wul/wsVc3xiJ72+zG/MyNA6we3F/ULT7b9OnLizN/zhxTvxAsa7XvBVBu3pLmO
 ancAMAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344D:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d090b7-80b0-4fff-fe83-08df2eb3e155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nrdUW5e6gmpPwyqBIBHUuolEARcmEiVyM7Nv/VEsaLFvdHHw03CtIcWGSTiePLiQeIdZYxWbVHkb2x580fjyyN8ajb3P/gaLlof75YmurDqQ2LU3k8XxPZRkfhLywPqzxGtlS+Fmh2tDA4dUGb1J5JmSAlJ44hgjTqnLdyFKm22ImoZJHZoKSSGNzkDsUeIV8QdjsbWJfDl8xyZjPH7vY8P8U2AjWn0S3ZlVTobTwdp1d72VmnHN799/JBJZl4YRy8WH7Yub5wmuekp6nqNDrpYEyxLpxhD56Fmg5yxaD0/XZBAHqBDsqpSv68vlFuuGR7kWRYY+U818KneLJUXHdsYCUjN0awYPT8ij6XyPQK66cMmGd9M9kdpvoD2vjOAHCpt3U0ILWuQAESLUDa0baruAEL4PtlG95Hhd30F+tGTWFB8gbhp+1sdivG6UmfZWYbTRqG48mszdZftcbWJF4cBw9WjrBAs1QAh/lHzyhY5IDHYMo9YSLkauNRe9suGgJL1DwQczxczDruXuZa5lBVWVbrEnvBDsND0ytbgpEeGMyZx/euqOclQffAj23EX9gr4MRjY7zhuaUx9gANp9s8KT7ZsOCR/Du90m4oD35/y9Wd+Dz+KBUlLVEbjxf4JhuMGBjr5tmPwYXeTZO7T1tA5rct/0xZvEvwkojwEagUUHu6T6ro9OIXKTl5VzVFItncmgEe/5aQ0j07YgAE2BXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xh8guTbAztP9IswDbPKS8PrfWJFPAJWL14hUBEzLlaBnRXHH3Epqgr2NQdwAINZ6ylkMW5RRlzOXOOJ1w4ZizhZcAcgDC2J5JsPPspf47foTPhe6jszMLppfc8cvUxM2zNxhYYFAPWyPXsMNqbugXtc2dCUe2T1YquGay5/j+cTP2K7pBCxXlAxZIRDNkEGZuzD1GkX0RzLT13lT20sqzuu8F1hjE4H+acxK5MsjBMX1wVEzXqEtECdmRr3HfqXUsamiu3uWuKRWmENQEdfWYfpzQIBceueKnxbSZRVxJFi+cjoOUcr0oBEv+mwME9QqwU9XUvmFN53qaT5yDaFcO7KKhd/9hdvFCsG0K24QhpX1Cqbi3PpUcpZzDS7vK94VvcRgLbRYg7WJQzl/1q/fTsgtlBZfNHk33VyIBSIBKfQsdmuMWIsdkJJgWsO3hMhp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:22.3655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d090b7-80b0-4fff-fe83-08df2eb3e155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable MTD command to be able to handle MTD layouts.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 2fa464ae9213..6d5f5b5eafc2 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_REMAKE_ELF=y
 CONFIG_SYS_PROMPT="mbv32> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_EXCEPTION=y
 CONFIG_CMD_TIMER=y
-- 
2.43.0

