Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5D606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jSI4vpfB;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fHZiWkje
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5CD280880;
	Mon, 26 Oct 2026 08:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFnRq2GnOX15; Mon, 26 Oct 2026 08:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9715380D10
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002457;
	b=UG09VzGG9syWtWNv6ztVyLQHH4aOIvoYs8icaxFC8Bwh4BmzecjMJUpofIOqExsCpFeC
	 KQjaoo7uu4ZGNrnDBTqYFs/MIVJbgbKxAgjeE11UQtuZSliWUl4oecLRBmcSsi+qpOLuF
	 KgLhhMXnnegACs/wAOneupK6Ief5hkZlhqaE/frIbYx9wrLdJOJLq9GUxd7g2+dQlNhxI
	 OqOalG/hUUVzc2xd2dBO2uMkX1OwGa4/lnbJVRP6J89rL87LAj6ZfNGEBFIW/IZzfDsWY
	 VxHhwz0hSAkV5Z4g+DTDXJCkkY8Ezmlxnddtxvva1EpvdG0NzSuuhue/HbKK6vmHp3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=YAUXao/XZcNy8A7h5L+7L7I30TzTp04ljUHccn5DcJc=;
	b=A/aOp1k0ZliM9wYSAwtZxVONAKbVfsooZMCNadZjEJo5z1/0iAkkjt49EM1l6j2aswYu
	 6EC74PE+yeSklY0jWAFAGvlbdtAM0lGU+KYp5dHjEi4ypzRLV1Xg5EfqK5P9dvGqlc/fm
	 BWLpjZySXfVxFcVh1nmAMHZa13az+LoxUvMEiDHeFjYNOMrx2JJlDU9ENszPFH/rhbwLm
	 NSDrOBMMLXpW0L/pJJIufkP3AxBdizXN6wLawzMWRmf6wzFn3gREblwM6opFGLp1nvqJk
	 YyEh0PKKSKSFHi1cBrI94ZYYTaGOY67vUAS2JwFxyGzpSCuW9ulijYEzW02ez6W+D3w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fHZiWkje;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002457;
	bh=YAUXao/XZcNy8A7h5L+7L7I30TzTp04ljUHccn5DcJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSI4vpfB96XnOxt8UoU2kg4iJHWSgkkKY5ODzHqebvVnxQKuS9YeZamB/zDyyBLJr
	 7Xaqn79MpaDAvMNy5wOtnBPAKC7uccyjHFKoYBhrSuvJDWCbV1iy5XvOObrn4zhs4m
	 GVdcQDB9RLm/IdFze6j/+lfsKUjJTmxm1y7rmrH/tURZAVQHZRP0qEJBQC46cxnSX5
	 1RkiPfz5KkDuPOY45QWYqnTuiKK9hgnbUacBSINaGVbUqOPPGtlfBlDn3NThHpxXrK
	 7sFEdxgYvexjW34EBD4gHB5DeCdnv4lnoIs7ColKjYPCZEUPTf+uQtrWfu4CMk1I7F
	 M1rFEDLxS68hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9715380D10;
	Mon, 26 Oct 2026 08:14:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CDDD235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 678BA8087B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlH6C4CvSTfS for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 107F08082C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002452;
 b=g2vNP5x9G9B+k1vNfaTYPSWGhVFM58JEigeRtj/2x1ZKjvXVmXQHcmC3qPsN4WFFWSuG
 USHrAvqVC585NzE9jjLSMnFIC3yMWl/CDQ5vMH5QUNY2BFTiDLYv46ngT7T+sh/myKYC3
 XpCvBOGBnXOPej9HanK9wF/NmCwFf/hZCMZNlUpmcpg5U7R7uyxyBECweAR5XHrxyQEOr
 oMBPD7KDttLaw+80Kex0momZY6AYW+wrS5olWkpmapl1m3ODsy5aXj6PUUHwzmWvoaDxy
 RCPx6m1BSKBDpeZF94EX1xVAFbseIzajBxiHOE5f4loLVHfucZf+m9l0w/2MKf/d6oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002452;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 bh=YAUXao/XZcNy8A7h5L+7L7I30TzTp04ljUHccn5DcJc=;
 b=QjaC4wj4PnPboTfauu8YSpMnD+hbL8kyu6X6izgB11ThzHWMFByro0hiBQg2nhKbHkWO
 9lZr6PxGRn1bK4L39TmejeuITO+JE+SLvtSyMUgxxyyw1wS/62iTXYjp4ENuInOxN3WDR
 mhvtZkKDeK1jfRDuKip1koAtgpi2w+zsRYnq/qdTb2Z1YCl2GfAzsBO+IfApnmUF1FDkT
 OeVlP/FrsJMhJzahhhIEORWCCwTd2B+wduKoDVQHIqsTG2bGjMC58ZZhvrqqUuYnscycy
 TQ0O7w/Zr8l9wIwslSytBicKxLgIYf5KbZkdatJIzL4QFrVje0xLsl/kUqTImJL1wAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fHZiWkje; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fHZiWkje
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 107F08082C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM6wvpaOt0keqp83B+9nlcltzRwnp9mkiH52hvSvtXjtQmFk76tPikJ5gw+0K+JDhoxb80BIWB8soJFCaVA6vFDE2D7xvTrr/WzLE7nHqkdea7/abmDBqNDZn/9KXvra3USuIfoqJTjMGOyi5p43ELSQaj72vAgPTgoIFGKehmuDbCk1l66wqi+4ubrPH8QHNsflbmJDqZ2TfEa6OkVoqPkULVkFuOeTnWtbX7YFPxz1T4/GdcePHwKGPaxP9E2NdY1ckwvOUa6/c8th9rzvH/AcGvk7tHeix+8FZCHhuGNLrs9BlylesiRmYDXYNfWvn9uukPiOea09wiyUHHxG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAUXao/XZcNy8A7h5L+7L7I30TzTp04ljUHccn5DcJc=;
 b=nN2xhXFVBwKJ2hxIjz4Mm1pYi3GMUvvl6dkjb17RT+oVab/dExTkgXiJmv4dArApo8lnP9AiD3+LWcVRrgrvcgPUqNlOiCCaKf7esv642/V7hkyds2AGqISOB/UvutZ8jdNuxZ/QSD6y09Ywnx6bmlPnsiecSF9DCMNpMzHJX4qP5xbhINT4NRN/YtmRC5Ufq+8wjYkTdav55lo6TVE7T5um3dlcaf1C3jLPFuazF8jmsrw4upkRfsvoNS8SfLCs+jykjpa1mlb5IJ7sItLbJWKppoLVXXOh6QTJR6mwGbh984nrv2vQVSNnoR5OzJUEroHKvES6fr5SZ0OIZO1lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAUXao/XZcNy8A7h5L+7L7I30TzTp04ljUHccn5DcJc=;
 b=fHZiWkjeDDIUbcIUAxbyyptgVjyo7/5CXQvg2cauN5pXzogiY9JvRCkYioIXzd2mGN9e+Y81wZ+9nGD0vHcQpp4MoXhX1oM5yB74ZYoWiCWEVXcfrU4M99vAI1MkfBbsQcrq3cVco7gcfIbsm3xjE2qXL1yhvNTX75Jyfc27l1s=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:07 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::a2) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:14:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:03 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>, Leo Liang
 <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 01/11] riscv: dts: mbv: Update mem size to 2GB
Date: Mon, 26 Oct 2026 09:13:42 +0100
Message-ID: <6e20bd95c7eedf17444d6362a6e2db2ab0d88e43.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=XN/COGJi1XbXMRGE6ytfswOZBYBGydXBVVcNwVnawKk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5947g9s3eR838+aThUo7F1Sllefud/13UnXLL7WnW
 897rCh60FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT0bZi+B/Auu8S+9VeyT0C
 CvaPVXd/nfA8yaf/sWbWezaNTo159dMZfjI+6rfmvOu+erfpIU+RWy96+XRLXt9eIiM668+zSza
 mq7gB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: c1919322-c3e2-49a2-0bfe-08df33391af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 14gyED+KM1+tpWZYX6C1xakA2JqBbn11FNHA1n8R2CpdNyzrttR557yzainFEKbtibT43enO1lDHjXQDOKfrgkfqdfRaR0m9PUpGB2VaDMF/Cv2xrcvrOi6tjXFjfDzZgnaRpYdf1/xcnQIQDEhs7k3PDNbRhgiXaYndb+uaSnDjEntZ0NjqBas1QWBDBdXHCH5X0gMFfETicllUjfJsEEwDHizDOXiO0pkaxUBgLpKShzgM4MIOknwSKt+vzaqBWceDK9f0iIFrdedP9hPlEXTqYL2ovLUygvl0kFaaU5j5rXagA6auw9nM0bDU3l9MIYMG2kZwYKW/e7uDGfBR6bFD5rCAaXh238mYDbxfUbq9CwH02lbWpL7ReO3dYCgG2aLI0zsChRj5mI9rRjJqWgXrbLGlc/0nYIqZhEzMNENzhWGB2L5C8CjUeu5wcgFD5C1VLKdww5Mn1YlrBiLmShaZgJMjYxhhH3By3xZhs6Lg5mFMJvPteQdKd7k/bERcAL6erMCJKZLNr5LhNjYWjqUoa4ZJeli30+MZbVSaOj3qFHtSdrTPwjL//TH5roJG3jND5aYlcwsFzelbYZkpJ35b51A0+RqRufo4vpmg/TCOZRttiGRjZ0fqC9iB8+dVue1wYiJg+w8sVawJUrxXgz0rG3CyT668JJd22GVUmRwQI9hM34b1x32IG5OrJgkI+u3AB4hvt2GQ+3PFSIbYMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aH1BfJAfn8i1clLU/cq3rWrbN0hEv9rPphQlM0J843iorInp96/LFALaakQJRXQ9rVcfy54vvOjZ+EBGVDUdqbvk568SjVVsY2v16+Yo0GVnBlRPO7BStWkqsdNszsYM8ACAYqQZNkZUCeHPGdOXBlhm5GuCWhKpqUFBzVinaJ6uye53b70Q+Ocsuh2au/I/dmwy3mbeTp5NJzUz7kI6eAx5hifpFss1mIunneJCyBU6qbqJXJjAwjxml2ikAbCuYyqc7KK0uiL+JQw+Wt+eG4wEAFXExUgEF0baIxUfTdclEzddgJATypJ0fEPqOinMXpWVGPBvsJXUT38EYNcNCkI1Jp/0IIfi+u0TKUzJ5yvK8jtcsX1l3oq099xY2mCM5yMtWuppdZ/h2X+NS5lYi4Qcq0oE/yT05jaPcJn33ZmB1ZvdN+pAhu2RehTLGND4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:06.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1919322-c3e2-49a2-0bfe-08df33391af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

Currently memory size is set to 1GB, increase the mem size to 2GB to be
aligned with uboot-test-hooks setting which is using -m 2G.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 arch/riscv/dts/xilinx-mbv64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index e6235ed2f525..cac7f65cd569 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -47,7 +47,7 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0x40000000>;
+		reg = <0 0x80000000 0 0x80000000>;
 	};
 
 	clk100: clock {
-- 
2.43.0

