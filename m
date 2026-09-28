Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A0AC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B1B4405AA;
	Mon, 28 Sep 2026 10:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A__Qu-FcgBJH; Mon, 28 Sep 2026 10:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8B188405AD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790593133;
	b=pZ2oA9eAIcLl7iLJkwHIpYGcJH6/H5th74b37HZhCervdnS3JjFZWrC0nTcb/expdapt
	 yWE5zhg0bKYWAi+1TBEz3TQZU7C/Sagj+Q2epactmaZgxELiKP2YhIb+is1PTHW/cpBCc
	 1BIHSy2Wz+u7c3XelSCv45UKA5ZTPqvAHCVtHa5pDyxAhK2RUHanl/rBSrr+nrYpj7FHi
	 mmgsyDdz0iujdlfewuapuSbCTbA2Vz54aP0B9HNj14VgLx9im8k34J37/oVoXj9qObg5O
	 k4WgtH1BjG7OQuIvMLhZQbU3dHvhCIRYy7gnmHCiHpnGxyMAfGOn6kwl9tHzPVsE+FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790593133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bSoGtfdwPOkjeh0LzY8fdN/WOUY1m1hUrKOLJ2qu/gQ=;
	b=VoXDYHFFchXsYuwfc1aUYvNEcpv8fAOxC7b3r/ynoEg1ZOCyAqdATzvNxiZk+2rceujE
	 Xa9o+aZRU+N+90IgurqJQ7idaPNz/lZoycpuX+R4FGX76T0tkIJ8BlfezzFB9kgpevyVm
	 tkc+cR4qu89rV/SSov+C9WAocbF921aYAhRuoYm4rp2mAyGgSobYiSWisxOxAryK66P8b
	 l3+BruYJ3/0WJp/vYGCje0izNNxL/XbPlebQKCoj/rn7kxIYXBBNaZnDynHYoSZ6P1smr
	 CwacQJJmZct0G6OnWzlrQ9EB1ws5a7+IqD3gX20WU3okPlmQd26ldbncew0KcqCWeUw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790593133;
	bh=bSoGtfdwPOkjeh0LzY8fdN/WOUY1m1hUrKOLJ2qu/gQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OR5+rtpCCQJGZXRsnWOqD5/f5WiFRqMxTj/WNvhquxCqLM82En5hCa5BRMojP6Oql
	 cYdNymlzNUEjIcscbBEthvinztQm0QSEQPehbq5ImSqHkxlaxhDRYhmGwzs48iBDfn
	 +zjg0kAtEhoS+olNoupsMfe2RnDJk/9Jph9sMWvifDrfjR36xUBv7z6ZD1vLKha1HM
	 nAehmttJwRSXOmVCguirDHM7Cdd0PMQ58mHj5Ud3LlNAYivGzWMbK5ZDwwNk6hBcJH
	 6ul0VhRoAgPRYKaOK01H2I8HutFB/CEjJNXTKJacamDGZA4GcDI2cE28DK/wWP8gYc
	 8uMh/e4GJnAkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B188405AD;
	Mon, 28 Sep 2026 10:58:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A28824E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FC2760661
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toQe_yixpxu0 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 582BC60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790593130;
 b=iaA3ZkW+JAO9I598sbeZcI+SqkxuiYgfmTYcH2bo8QCLLmTBGIx5JWKTMjd1gddnyA9Y
 cZkLf2S0LrXdDl5QMbxpLzHUkCpg61yxVkQi3NaCeQezMTDq8Ly+3X+g3wJsAdjlz1lBj
 SmqI9Pss2FpPmdVNaVK/aGMCQ6PpEZNs2/4WeoBfZ3IJ+gf5+vzMi3zLZcIlBPIB3dxZs
 mHuP4OX8iyww0fCUotj7Ago+sMV7toxLz1gYOp4jP9EZOrxMV6rjuYSoHMqCP0CEvULJ9
 SSHUVJ9NnmlBKis7wn0jNG1JdvmQpSG/NmyhI9TrCZcAEWJaEYgrOTPsApwJbRfNITw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593130;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=bSoGtfdwPOkjeh0LzY8fdN/WOUY1m1hUrKOLJ2qu/gQ=;
 b=Wlfa7b8m22LmI/x2ZSJF6OmNRdNqABT5GkxJKM5plzeSra2ttpFJfsZR/DoolQxPwO2g
 F1kx1GzA3kqD8M515j4gSruo/AcO2e5QRaTAargnBsnR0wbsx5J4E5xlrMrX/WEITxa3s
 8vyEK/uummp4U27RO77bblZEH8Mc4cqiQcTIYxivQw8IOntNal8PYSIl405R6lAQyDU3I
 vRVHYKyH8hwiJ4vGDH2N5XCKLrNzcIE3QH4PWZG0MB7JV9Kgvgs8TqzgdQ5tyEqMC7RQz
 0mFAoHiTjQ1fU3uw15sm7V+RjNZTByIniNxEs6mIwS23MPqO88PbwDVJL1+xIYsdPsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IYQimAgG; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IYQimAgG
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 582BC60603
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:58:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84BCB844F6; Mon, 28 Sep 2026 12:58:44 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E57D83642
 for <u-boot@lists.denx.de>; Mon, 28 Sep 2026 12:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
Authentication-Results: phobos.denx.de; dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="IYQimAgG"; 
 dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq0rMNVf5c2Uz8TfsFjO7djTPLCCaVQ7qg5NO79mKR23NN0M2dW9WaS3aul5uX7XhntUZJIzOD1pTE0nhzfytRPvBXZB/0+Ki2dngcYm6Hcmz//Fa+PgzPfksg2vP/z1j1yT/qC3XV2qX8R2YxppDS70fWfAJP1wutP8neHtjr0Yrw9aqnl8EneAB+7AzGCcMKm0U1kq0edM/KPZu9efW99u79r3FE+xXiXhnUYKCpijTcPih5JQ0xHGD+rbABTRxSPWt75u3EASA1yfrgq14xwr9C2EJ6wEbAJdFmk6n2l8iPf1SIvNI9H5Ij3PFo1Gkcfy7B6YGK7LFDKLDFVJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSoGtfdwPOkjeh0LzY8fdN/WOUY1m1hUrKOLJ2qu/gQ=;
 b=vNoloDB6EQ1dSUET0hBnvGwz+yCeUuOLafDAl0zwOJqmIkQJpxyeFTwhsZvN3uANl7H421Od2pcyQqyM4rkEtBVHtSlXf57ip6YqPjNByX3dveJ0eu0eBP+zpxNNiMljg5t+s6ExEWyVHdoIAK00tlBWGQhLQFwZisznXBEwnAlFfh3xBTZNrskPKZ1hslWd7CFJuqE8gg0Dg/KrfGJhpUCzSuW+uOK4qGcOcTVqYbRSmGQ5/VaUON2HThjWJTghjeYGOn2tHIkNB35KOm54SNK00mbPAn4u00oekO6cawM6KOhM9d3h0l9Ti+qHx18eLHKxIjPfBW8IgdKOwrC/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSoGtfdwPOkjeh0LzY8fdN/WOUY1m1hUrKOLJ2qu/gQ=;
 b=IYQimAgGx4SzUutY16fDmW8e73wYGV1iec2oBHOS27VaM9ZcNzd5L/RMuUOCNvjKSHaWWJBlEnv1UmLhl1zo5kpPeWfiJ6phq6AmKxwGJ4nTa46ZtC1/9RB8uZY990TW4KszQ7Yxs5uLja+++3iw+sSpMELlmV8sDCk1BpLGvhk=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:58:37 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::26) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 10:58:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:58:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:58:35 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 05:58:32 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>, <git@amd.com>, 
 <mohan.dhanawade@amd.com>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [UBOOT PATCH] fpga: versalpl: fix OOB write in
 versal_align_dma_buffer()
Date: Mon, 28 Sep 2026 16:27:39 +0530
Message-ID: <20260928105742.86144-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d456a19-cab1-4774-b219-08df1d4f724e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|13003099007|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: t4ta8G67kuoIwyySiU1vOeVx3N9xj6gY0RAUggD/xXD+8mYdHgPwjTANSjTE4JCJfvb2nlHm9zV11PKUitmxb06OlZT7ZhLcQErzHW7Lb1RuuQvfeE9tRp4Y4OWNWSHLSPaoGygWPOzaxXv4qMeKxeb1Yu8YyyQ5OCDArnRqwXawL//VBylViBWWozem1ake/lf6MMl76ZYxTtH5CrVEKkTumulzoh4AzNKEzVdmOiKGYC+wqPLe29dTgUB3uGTKw9UJKyDPuLDiIiwPRroT3Ev/TgADU+xfjc0wCPWiDUyNS78GHreSxBtk2wnFunEEatyABYONC+V9GzQC51ql00bqr1b6tWxXE1oJHN04nVqbI6xyZhvczPtGxa8+h0JnOZGPgleBTz0Dn/ppdO03C5unTxvDpppEVCszPet2FdMOkbAgsVFpPJ68x7hpmHahnHgYh0q64DsGhpoucHQtauPXLlaD8KIIWgro5xfdqaQOj5uMkEQdH6Qf/feXQddTkZE2zpS8t6Lg6Ao2LHHTPUaKhNmw1+kDaJhuJhIZaz8oUpGxIDCqXbiBs9HW7yaEzLKx1KJC5szLqlOstIHtLxoXFqGqir6ZTdSk7CdLodDvImuQLPHrBVAGOFSE6mfTtzzBvE9RYk8UEyDON5obfJ3wAYkXsnckxHOqBh3tu8ytpkz06WXAP1wrSNDqUTbotfUAkyK3xoiOhoDyHOAR6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MaF6a1N1dMv7NEso7Aitvp0xBKHuQ9Pt4Ehv+3dc6zWmE6v1rMqz1/t9Lj64dWwcPOHRH3TKpnKb/4CRJx3/XKeKoI4w36fVBGNr5DJutAzElEmYyTckOVpbiP04m1hBIXGObMj3pph+JX6RbDltbJrwGuKfx2ZUIK/rytxGfFAwKnoUDvd0FVZ9vn+kvygCxJOzsHxoe8qqoANJIm5lHz1pyvWKX6J5Ak63eI0exw+JrSzGBWFEC9sQrrCimN/6dcpVGYt4mAANTLe6MvTpY6y2bKdiT2bu9SaIRkCKxN7a7XwJNGqr+0HxrrMz3riyGowm7hl3z551WWrlGubHWdGVBsJrxCU+b1edcNVzaazMDMrQdCmUNi9PGC1WhC/JAQ6+U7eEriBg7gJrRPnsLa9wTMeylZlJy+++4J5ib9W6GNSmrIV9FBJX8hKl26vH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:58:36.6847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d456a19-cab1-4774-b219-08df1d4f724e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

versal_align_dma_buffer() rounds a misaligned pointer up with
ALIGN() and memmove()s the full payload there, writing up to
ARCH_DMA_MINALIGN-1 bytes past the end of the caller's buffer.

Allocate a separate cache-aligned bounce buffer via
malloc_cache_aligned() and memcpy() into it instead, propagating
-ENOMEM on allocation failure and freeing it after use.

A misaligned buffer larger than the available malloc pool now fails
cleanly with -ENOMEM instead of silently corrupting adjacent memory
as before an explicit, diagnosable failure is strictly preferable
to undefined behavior that previously went unnoticed only because the
caller's buffer happened to have trailing slack.

Fixes: 26e054c943a7 ("arm64: versal: fpga: Add PL bit stream load support")
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
CR: CR-1278219
Branch: master-next-test

DJ:
http://sswregress.amd.com/job/GITHUB_EMU/job/REGRESSIONS/job/U-BOOT_REGRESSIONS/912/

Note:

Hardware validation was completed on VEK385 and VCK190
 - Aligned buffer, existing fast path remains unchanged no bounce
   buffer is allocated.
 - Misaligned buffer with a small payloa, A cache-line-aligned bounce buffer 
   is allocated, used, and freed correctly, with no memory leaks observed.
 - Misaligned buffer with a payload larger than CONFIG_SYS_MALLOC_LEN
   (VCK190, +72.7 MiB request against a 64 MiB heap): The operation
   fails cleanly with -ENOMEM, without crashes or memory corruption.


┌────────────┬───────────────────────┐
│  Platform  │ CONFIG_SYS_MALLOC_LEN │
├────────────┼───────────────────────┤
│ Versal     │ 64 MB                 │
├────────────┼───────────────────────┤
│ Versal2    │ 64 MB                 │
├────────────┼───────────────────────┤
│ Versal Net │ 32 MB                 │
├────────────┼───────────────────────┤

 drivers/fpga/versalpl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 29d2a389fd9..1c121919db7 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -17,8 +17,18 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 	ulong *new_buf;
 
 	if ((ulong)buf != ALIGN((ulong)buf, ARCH_DMA_MINALIGN)) {
-		new_buf = (ulong *)ALIGN((ulong)buf, ARCH_DMA_MINALIGN);
-		memmove(new_buf, buf, len);
+		/*
+		 * ALIGN() rounds up, so an in-place forward memmove() would
+		 * write past the end of the caller's buffer. Copy into a
+		 * separately allocated, cache-aligned bounce buffer instead.
+		 */
+		new_buf = malloc_cache_aligned(len);
+		if (!new_buf) {
+			printf("%s: Failed to allocate aligned buffer\n",
+			       __func__);
+			return 0;
+		}
+		memcpy(new_buf, buf, len);
 		buf = new_buf;
 	}
 
@@ -37,6 +47,8 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	int ret;
 
 	bin_buf = versal_align_dma_buffer((ulong *)buf, bsize);
+	if (!bin_buf)
+		return -ENOMEM;
 
 	debug("%s called!\n", __func__);
 	flush_dcache_range(bin_buf, bin_buf + bsize);
@@ -45,6 +57,9 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	if (ret)
 		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
 
+	if (bin_buf != (ulong)buf)
+		free((void *)bin_buf);
+
 	return ret;
 }
 
-- 
2.43.0

