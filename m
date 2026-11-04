Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D701606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HnToLoIc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fdcXUTap
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D3CB80F97;
	Wed,  4 Nov 2026 09:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pm78riThlx1r; Wed,  4 Nov 2026 09:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71F8F80F70
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793784093;
	b=V+MdGV/4ciNdaH33vAa8QA5jIMJPZHJApYtrrf1Gu4vLN56FOJSPQgtNUwkfchh271ln
	 RHoM8JAnbmL8WycrF4Gkdhf88bBF6ZFGjtk4EqPBnW1paMlTF47c7KD1lz/YLJlTxIjDI
	 MiMaRvYQ4pI8zgMglwE4i5AADH3wSvJyebKCW0lEnXRd31fSgddLSz1qsdc33qSRc6a+2
	 KX598/cWy/RY1n2siFZbpo/drjaJvKIz0ANQeSIZ2XV8mOmLq0i/rELVmwqpVY0K4/dQy
	 Tjnsf8+D+1M4e8nKypQaYFWyTrs9LnxVzo5WOGdAHa57qufbkk+eYgm7cZvTTV+W3Ow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784093;
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
	bh=nWdp0NflE7PQKypxeRG7hxyAF1DLKR3D1+yEoPChCtA=;
	b=Y4l6ERvDR2RU1l/M8epIWTXg9ptlIgU1rNCprXGchbRMPYkkzxpN5uaa7I8ZHLMiHW3H
	 mqyN2Nqpw0SykddBZMwujC69otMcBH/vJE+q2M2d8/KwHHdWZES5txk5MiKVI9vGZ6hrB
	 QMYfyK0tdn2jc62PXodCFpOpKv4SySNR+ZNn+/GIaUeM77Rwh7NwvK8xNFiPa7FbBztgK
	 CGh9TWaCJZTSn4C3TP1w0SOn4K+GPW6PSnrEmv4XY8SiO9mtGLJPNFhtcxNSeHXYh5tZu
	 v12o/3KtAUNUNKV4uYklJJUj7uf2u9NpuPYLbfEoAsD2cgeX1uaCAykjJqoDqldy6xA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784093;
	bh=nWdp0NflE7PQKypxeRG7hxyAF1DLKR3D1+yEoPChCtA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HnToLoIcWdZAY1JXeNINc5muOBhoa/Bk6X+4+uDxSbBrbZclq6crGDvTn60LZ8wQW
	 SJZtz6HUjTyZdW7K3YlqzFXxGFl72JVZlJ152Kg4BBVqNXKQq/l8/hdPEhB9lZuoqI
	 EwThNEQ7c18XypfW/6GLKQciZs7dgjYP0Q2k5FOtPomAdf0zhQnXosUHIN1lwr4lSb
	 AFiE40zoJRn2Tx0DTDcob/M2gGPSSM2muOZrNmjLrLPknrvL+iJaJvEfmoNPFjEprY
	 wvIeC4nJayuUUi2eIScUpr59OwS1h5ud1zYo8vRKKLna26gERuEZniL/AmT6PD+3tJ
	 JYolPl0S5i9Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71F8F80F70;
	Wed,  4 Nov 2026 09:21:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8826A2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D55E60759
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qim3sB3F0nUk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 067E46074A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784090;
 b=oUJv/G/Xg5l8Xpiu5ELScjHhB9eOluJb4jl3MJ9jGYLzNUT/P7RZgf3W673VHqu5KE5B
 iwpPe/ylpAFQOkqwwRtjDNFaqsXQaGhn1PvjbEBv7YyXYcmGy7bKDrFT2OV2pNBr6IZh4
 EWT4IJApvQ8wO8mXkPZ/JEp0vUonttjV9pDf/Kc7v+BYIieCa0KIk3wpSBlmYbP53Rqhh
 LbPtefAi06JflfFhkQkovAbazqHO26FfCw3+5264PIiCXCfL9khGvt72z7UhHQZuVM7Jc
 JV25eimWWywSsFcOJe44IWMloLcKkqhokO9k+pZL6upGYrnuvqNtVFXhELa9uYPY7KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784090;
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
 bh=nWdp0NflE7PQKypxeRG7hxyAF1DLKR3D1+yEoPChCtA=;
 b=V0ZZKaA8lzs9B3b3V85oIjNGYknP7Ugp/HVsdJMy5pdpVw2MSYCv2IP5GY1R/UHIS6CY
 CdMiyO9I46B4HPRxY8OYhOgFtDb9jpJCqgU/Qy6uO6Ig9Dp5XgqsFClkvCeZDy/3Eixb5
 /pV89iKoEUnwhTmTvmrYKZSsTNF8x/dUKwfAlRCTt//3s4THYk0cGAXGWk0nxe1iKVlI8
 Da8kY0X9QcFRYFOpPlHJOzAothGCPSCQ1+0jxMOHG4iegAtM8VSUhJH5HbwLC5d2ZHUMc
 D6SD/DdIY3GM/hDmuP9sRcY58gSXPXHZOE7mOgOObo8qS67NxNFYgXKb3Kl0fQVWYQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fdcXUTap; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fdcXUTap
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 067E46074A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXVRY6anUsU5jU9phx761JRYv7cngOsYBDn94UJnBPvR2VD1JmIbupsbfo7nJVguvCee3Q+GvNrxrDECvdcItclcTWI0+4bWGDCp9S1z0lJVb/g8mLUFrCDhEuCNQ0zuhAETlvzN5VuY/FQgx2GljG9CurT4ozhnDMtOrywDtp18t791coEqBlDluWhL9iCqeuRWb00Q46FhW0EYc9zL/15KOm3Xq0Iu5LAD2VP+EG3WpgD+tWgPHhLWeEgarOrDkzF6cvQFESkr8n1sCNIfAyf3y6qAlIhlXkXxd9lTzFKd1qw+XF1iFEfdTbcYjr248uFUgm8mcgOcw+S3kcuE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWdp0NflE7PQKypxeRG7hxyAF1DLKR3D1+yEoPChCtA=;
 b=GBx2+B/1B90gN6/aiL/ZuaQYyixM6KcP+R8SsrvYflyAfsauJlnRxDt10JEj8TEyX8kkTeBEjPGioxDWPEuJ3R0PzeFK4oUEpB98atgPJCJdGyMGSo13zKYHW0zo0Tezcf10M478kRldxOicLLva48Nym4koqfjt0YvzH8hI8gAFPvN+y5EE8hixftWu3jxULfNsh7jMn+CCQZkdg4XnBsv5rdEchd4DXfRMeZxjt3y4iOj/8txrQ+hwm73SZ7tGDGMttf0Gl2/4MYylvc8bt0wIf02DVShz95B+LBDHMipJrNRbg/X2RW8XJWyB8YhIvCFCUdz8IMe1uKhd+TJqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWdp0NflE7PQKypxeRG7hxyAF1DLKR3D1+yEoPChCtA=;
 b=fdcXUTap5ftg8bYM0sBcHp/Z1xmbSiBfH1tEtU4c3qTb636yB9tmoUx3/hnOmRyGf1HkbxWcUnzcArimH8u1HHz673p+DfRqOdYcj6y062tSFb7QfcNp+QDJPKZBy5mR05hSdwu7VJiRaTqPdAc7usTnDPt+lWJRkcbZe2ero5s=
Received: from BL0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:91::37)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 09:21:22 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::33) by BL0PR05CA0027.outlook.office365.com
 (2603:10b6:208:91::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 4
 Nov 2026 09:21:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 09:21:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 03:21:20 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 03:21:18 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v2] spi: zynqmp_gqspi: Use the device's chip select
Date: Wed, 4 Nov 2026 14:51:11 +0530
Message-ID: <20261104092111.3906459-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dcdf8c-8504-441d-eeec-08df3a54fd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fx+RM8d/fN6/5z06Ga0iGl1Ef01kLZOQKWeE+kMlKQtJVU3kgbOueXI2NQd1k+JtL0xOn6+rJzQasFQDa9hPllINlNkPicM0v7Tz6USf0JeHs1FH6pkVIID8TbSA8X//URHIBD5qY+ATD0f/r87+pahMXOaNjIJ+c+tWKNxPS7jYwYbMDBd6nrfSb48ALvaPmYoYW64L9rY/5QgMNqAbim6YwW3NdblZRxKrlO1flhABSI2oI8gWAoTJUFiq6cG75qx9C9hVT0j/AEfFeMJyZVdcRyrZHF6y6OHDmFYmKuDw6TGSQnG+YyPWP3AokYnNK/hY4ko4zoMhTyTozpjKNS0+aLsV3Pb89KhPS8LUNjH8qp3WJ1Ay8P09akXvJHSQHrh9dYW6XRsQIhH8ZtChv9i6tYvUQ4kqJWIOnBltYTxWXjAR6Zj3jF3FfgW00QYMawELdDvYE5hMySIdUvAChsoYt14M3evRBilTCr2A5YcVfauTRvXXAZvZYHtngLZBGf8jOdHMo+EFyIzqulozcIOL6w8PECxGfZLn21DQb/MHwVtQpNnG3ydNlymglocGotd/O660thBbmrFGme91KBFEa9ss8l2k87nXsMchDqapKsh9Vzl2Cgzzln6GhMialdpXa9bsHOr0pGYFi/m7IVbUa27qxUYOy75QWjhlOs5nb3NowCMRc6Z/N6UrYivrcKW15jH4F9YLz70F5WRW9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HpR/4EaatUwLl147R3OjGSLdfR5evHLYiU3cGGWhqOTN/ry59QWsz1Y1c4DI/sZWSCLRXLhM3YNV9sCL4fc6cTW81Ae9hKt+inp+DxsOxi4iqRJgqPRQG2BX1T/SOGDxWVoRjQTBBWJmoMBAB/uK05UneMpsUs983YDXmSy3/CihUovTcr1UaaSanAO37yHVNxVUU1cz0BBFbklaZ1zU1Yp2OI9xwnTSNwFREVfWDFIzWVSLDKy7sMCfpTAZiEedMbZCy/DmKpHz3epHQ/PVNCCYDcWRpA0t091010cR+F+nAH2fp87kc+0yMVEYELBqmNpR9aVk4flUUS8c5srBcA8EDsyAc9AzER6CWZ+v3RstaOxFClXtLVG0yxDQ09DzR4pzK9ZogXpaK2KE9+VsE8y9/KlSvhbJHB0JIzAa3+arN4xgPsYEHXzD/Tz76jgE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:21.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dcdf8c-8504-441d-eeec-08df3a54fd6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When SPI_XFER_U_PAGE is not set, the driver always selects the lower
chip select (CS0). spi-nor-core only sets SPI_XFER_U_PAGE for the upper
half of a stacked-memories device, so a flash node with reg = <1> that
is not stacked is always accessed on CS0. For example, on a board with
two independent flashes, 'sf probe 0:1' or 'mtd read nor1 ...' accesses
the flash on CS0 instead of CS1. The same happens when a partition on
the second flash is part of an MTD concat device.

CS1 has never worked for a non-stacked device. Before
commit 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support
in GQSPI driver"), the driver always used the lower chip select, and
the 'u_page = 0' default was added by that change.

Use spi_chip_select() to select the upper chip select when the device
is on CS1. The controller only has a lower and an upper chip select, so
any other value, including an error, selects the lower one. Stacked
devices are not affected, as they still use SPI_XFER_U_PAGE.

Fixes: 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- Send as a separate fix, rather than as part of the MTD virtual concat
  series
- Rewrite the subject and commit message to describe the general bug
- Compare the chip select with 1 and add a comment

 drivers/spi/zynqmp_gqspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index f572f2b3f15..06de70de733 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -878,10 +878,14 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	priv->rx_buf = op->data.buf.in;
 	priv->len = op->data.nbytes;
 
+	/*
+	 * The controller only has a lower and an upper chip select, so use
+	 * the upper one for the upper stacked page or a device on CS1.
+	 */
 	if (slave->flags & SPI_XFER_U_PAGE)
 		priv->u_page = 1;
 	else
-		priv->u_page = 0;
+		priv->u_page = spi_chip_select(slave->dev) == 1;
 
 	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
 	    (slave->flags & GQSPI_SELECT_UPPER_CS))
-- 
2.34.1

