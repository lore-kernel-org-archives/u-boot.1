Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04323606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qzd3/lrj;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wD50OggS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D64158104D;
	Tue, 20 Oct 2026 14:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yl0vVIFmJgpw; Tue, 20 Oct 2026 14:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2391A8100B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505413;
	b=VZ4Z0sYs1Fbvv/0oyyrpWsX+VFx8jyGaHYoaplevLu/DK/6Pa+tuiuwLuSzwB2XaTrNK
	 hkbyAispgvFMCY5MoOT2wEPU1ocKY5iM72Gdi4BDwhi4PIGy+x0kH16oYHvIrSAktMuZr
	 TB4WihcoMwp/ZzRmI/VZu4heUhnHWLdvYiJVZWVOw+EyrD6+JuaYmLyDZewHpbYUbqE+m
	 KHZTGGFYB2CMRt5rP5LvDd5rqTUROesunhZC3gbPxQ2IT7b4a1bhgTV/1NhPYClGwn/qV
	 OqsC45keDAv+ivHNUIJ4LVTOVPumZnBtPuy3VR6piqZpy0qv6I4yDx9e1YKyoGjCEPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505413;
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
	bh=0EospVIwbksVPrFOI5qt4qtsF4Kb/6BJd1papjjHaAA=;
	b=dxNuQcsyS6/q2XJHmWTqhoaBqgckA/R6c68RXmwgAO+q1jqPVCG0XdcxUrFulOd4LwgS
	 8F+2q721spBlqq7fZijkSlYoqFlJreiXAh4zvQhwgS/BGVF0Zivm9xGP5H4EXWwR7rjQL
	 ObKOXOu7UlTK0lpayw4EfH6BuT8qe93qm9C9NT0FM29gxxzAXFlqgICoaWwX5HHBVuGR2
	 +VgJH/G2Ax2ggDDdvKKvRiuT8uf7Jnud0If3wWPYq59UnpEcptmFj8muPaTtOcs/meUXt
	 AfEUheJYDwOV0UCYRLxQ8k73c2v5BgYoQfW3Apu68BMi4IjN5BHYhJ7zwzcX2mVYqTQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wD50OggS;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505413;
	bh=0EospVIwbksVPrFOI5qt4qtsF4Kb/6BJd1papjjHaAA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qzd3/lrjEEz74kCSnUiBWJXOd2jwTMvisrtvCEwDlAFh2Kj498+SqenQO4NcM2ESn
	 HrkBlIbYrDHx2a5khpBvn3kmM1Az6fJwW29ClkT7hoZ+4QUPpNvFHZ3MrtZQXzszzm
	 FQzV8f92yo3jcXhRCqp/UTlKIHr7YVj4EQe8fNlK6ywnLv/JlPcq87/ufEXKxS+PnZ
	 fNTIzqgwnbPeisfZyJxluw2DxGgFJ7w3ZlK3droWObhvJEvM58tYPZzL3+77VkxrxL
	 3A1Nj5c93y2gR6EM0kF16sMFJPyqcyXp4t6goIArK4sBrSsV8rmMIWjLFbF1kKwteQ
	 K5sdmBVbizhVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2391A8100B;
	Tue, 20 Oct 2026 14:10:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DBE3255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B62F8102A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAMT90haUlZU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C000580DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505410;
 b=g8fGrkUPeNVsBtxRxTFohqyV7wXktSso/GkGYoBXrwWhNWw9MyYeGpJbupWhW+w4s/On
 r0obRlMl5femAKY+FZQBA4+fAxYRGpJLU6HSrAkyarjeEmo7Ay/z7ag48gmitN/tTyVwN
 bGrjsuia6Cy0ciELSQcOLaAo+OyGFbDJIrCBrQJUugi5qsYPczMzAJbJLHPqx3UP+1dbT
 sfrGbUy4GfLhmS6wCcykK10QVutpdj8sKD/ZfZ8K7MhwFK7M+KuZkLcyO3XLcZW8qC+Gr
 VRboVolcTbkXW+VBxrD+N35eTy0h+IOaKWhCdKgBtny3Xx/IGPBOYJqECsjlMs8UBhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505410;
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
 bh=0EospVIwbksVPrFOI5qt4qtsF4Kb/6BJd1papjjHaAA=;
 b=d+BKq8okCYxY1/an5xvk+CgU1W7peL2irJUQ8xm0rZeTgWYg4O5fpo2aGbPWpAGu/Pzc
 7dqGQ4jlBBQeqZEOYpDsSIEgH3Joz1Y/8NBx7coqsh0hv+3bW3m7peYpu3HX3IT6vLe6g
 RolohxxH496x0EcEXjKEcbMZgBfBsE9Ewk4o6l+ymfUMw1sutbUmFXR8T2pvfNDkOVtj9
 07xy7KplwYEXBbRRlwa5SXw7WC+1Cz4jN+Q0PIY1Mr5Q80TRkWn5siVrrz8OQx0FUjilM
 y5a266Gwg95fKKgd4o+xFYbOmGnWv29L7ZgcUhv17roJM4ygy1nHoFtP4J9V8ckvttw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wD50OggS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wD50OggS
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C000580DF5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2DUH9AFrsrM+l/5EFuRx3hVI4jhU0Nw/rh8dvMVqpt8Rg4Epq7QJRnNFygASvhOqsk+cK0m9pY2lRtpbPnQQjQKiIafyhAjdWF6aAj1tBqMwyetjifm6nrLfkjM97nIQwI6WFvib2T0U7owLAswhV/QCLaZR2iS3IY6DkwnzsyvQQ44uEOwJHIrbgaN6k7r1rMu/faSWNNiLEBZRXrQeGDYBnkzSeyMkz+2SE9GlGWZaMn2eA+1zVMXutWkswqP6UeOT5mc6sxN5v7D4TSk+YZtEiAegsYZKFeXBtaiFsYbN9UUZO7vkqpCDvwD0kK+6prgxi+k4tEDS0gD5+2gPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EospVIwbksVPrFOI5qt4qtsF4Kb/6BJd1papjjHaAA=;
 b=CLjf2Ry25WUkLwBT64+sGWVUSak9Duq1XKq6i0zPAcP1EVyoAA+u9acHHBbnWDeYrsZqJy0IvFTfX4VhztYMtNUNNJM4tQCpSGLh8zlLrKNdm4+1cgfzATywT6lxvV6xxP+zu9Ts0eWdQF2fhndHgs0miSQuAfPH1YbpnzjUSOyS+Cp07HLrqDicY8kwfKTIxfeg47q8/GGVlsoDFmDgZsBXQfkZTL9cCrDdXXede3vXvp2Y0TP/S8fepQLgYL6+V3sls/K5IK0wkw9U33T+UltKDfVfquVMtGTxw3Q6eOnU58lqmYkoNLT2rja306V47bI+ewooBPv2TnFFp/uQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EospVIwbksVPrFOI5qt4qtsF4Kb/6BJd1papjjHaAA=;
 b=wD50OggScUfvWCvVTx1eZmzSIgM7tsZmCFQuJwnCRD0R6+4YbhNMg4RvAzE44mh1TxWrCOcJzNaReF/9goWBbWHKaAvjzcoXNz8hTXB7/oyn9+T6VVRBL6VHGCpRIFQQ3uKSWYI8b+xCRhl43jAwdQA/dXsciHjji5Oo2G7XxQ0=
Received: from DS7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::24) by
 CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Tue, 20 Oct 2026 14:10:06 +0000
Received: from DS1PEPF0005344C.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::61) by DS7P220CA0036.outlook.office365.com
 (2603:10b6:8:223::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 14:10:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0005344C.mail.protection.outlook.com (10.167.23.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 14:10:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:58 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:09:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] xilinx: mbv: Enable GPIO driver and command
Date: Tue, 20 Oct 2026 16:09:26 +0200
Message-ID: <a1ca2b1d179717516b13e80ded16b89f75a79176.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BStor8ztJxDXclPqXjUWnzHN7fcR5MQIOvtbuY/3990=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5O5cc0xR8TzXPGdBQE3s2VDHz2wbZmak/xuT3Vls
 O4+oX79jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiIhDnD/wKnCTpz10WLrEzV
 Cp70em3QhDex4hH73Xm5PvDzJG+YvZ/hD//SwP2bfY9+i/3pfNhquYa92d7tLT/LXl5XO5L3upD
 HngsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344C:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c18f2d-fb83-4228-3e56-08df2eb3d69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0Zf74YBrYZjxNAD8qZYHCA/303ADD8ONcXTqOUufrigeObNqcyNqK/65R3sJJXPwBkApNPXVo7YSjsNHO8CLEb8khyFK0gDKv68t4vwG7G0HeTXejVXbSQ2mmgqg6xlS3sudy+EOrNv1wtTI0c6U7Udxa1EuBflCgKPd+eDupf7V+f38n/WJRHo3LGu+pbM6BtO6I/u57jvsjvLrqflVCMw4PwZZ0HxuSx5pf5MtQZd2lJ0tOFCoYeUMlcK35lR7+DDijSvNZxpe/iTPjZFVpzyAB8HJGawQWMdIW1AcaLxo/5pchLkOB2x3izoAkyn9wjJvDo80JK1DzF22C29tN30TVFeiGF0yGgzHrVspABF0rG4eLS9wU5rS1Dk9qMa80bhej4MsmOk3BSCEfgKNk02kUc90t5ExhJDgzxVnImmebaHLO1DrVFHVkUPoPXFF1AAwYMFULXMW+SJY0R4n4wnUw3AGyLSmx7zXIb4xfDcpEHfFl1ss8Ljh4QwJ0moT1/I+H8Zbe+FINzBmcHuoiOKK3yk16/8GDAl9K2+KRYTfgCg3Sz4cD3cC7Zx6ixRpAnDkH0JrUggz6pkLXfOUKx2oJRQAPP0+ghHgnrFtJq2dubM5/RzuGdyf+i9qAOZEyeP+qJjHzv4pHcyfY9AC+h/sNGSGK0Q1Mw5bFcwuJg6H6v9LdoO5NzMNNEgav4tiAi2Kq+SKeg+zF6kRBum/Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iv4KwkTsvBsYK7bWRHNrOnivVR4OlJ8LZGCDzHnd6d7/WYq/cPdzeFcEo/R16ELum3BfNBc/gi49gP6Gj6cK7XQ+WV4LWqDZUlPv/JuOJJmzv2EctJ0Cvsa83iXYyoBgyJZKadeIHVL+/duTymS7N4MWIllNUgPJyAVTkTItGXikESuNRI+A1XoG52MvQpxViGIAXeZqUYgRF5KFXgb9fkyyJm5ZOwvlpzED++i5TslU9Yu1xxiN8nRLRAEt78nHJKyksxq+bUJJco5iZ0v+6vmJSDFIF/7VGm5TVgohHewAHkiLxU1UEg9bp/yU+UVfrYxWXi+ISdT/gkTddULUftfSi+VOyFjLZmC3L4nh7vZHifDh/59mRnkXgmqFsboCa24zF95fgOKMauv03s5YyU+e+FVc0cEye/i9QEvH7e63wvqtmIj1JrIs1020/v/2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:04.4291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c18f2d-fb83-4228-3e56-08df2eb3d69f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable GPIO command and Xilinx GPIO driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index c84b1a41655f..a65ed7966af5 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_TEXT_BASE=0x0
@@ -43,12 +44,17 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_XILINX_GPIO=y
 CONFIG_DM_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
-- 
2.43.0

