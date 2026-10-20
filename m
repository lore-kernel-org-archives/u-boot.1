Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FD606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iMGv6bLw;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LcdLXeqE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E78C480A65;
	Tue, 20 Oct 2026 14:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r29c4zp415GP; Tue, 20 Oct 2026 14:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F0CD80B7D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792507228;
	b=b54nIm1rMPYP83x59SDSPk5/VpS5Q3swnEgOIDJM9RQ8+CcncWv0zdjthHftcm/7YecT
	 xgNGY6SfIJr8LdunUhftnwe5vWQvmvPBN+Q/2IlblrOo0ejN9Y6/58eA+rUMr3tjnghLn
	 M2Mt+sbVhDZyONE9/1KoFetThf9s11T/myIN+k47l6ZLBtDug22OAOMbyAY4yTreFryh8
	 jCwD582w/SjaLoV2OVo2CfsC3m84sVOAAe2Y/+up/7WC7WsyBN8O4RX1gGRBvjaqorglK
	 2aw5DGjiyUSyltKzHUm/8RItYrpuUOjts2sT0wyac8hewFPvuho7yKxk0J+yn2VHcqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792507228;
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
	bh=bU3McetT2lUHAcBnS4Opnp5qO3qv4kLmOp0b7OazLTs=;
	b=G55C7AUUNN9Rw2rlcoBTKQw/6ymYSe1dbDOKme5er5NfxfHW1Muzt5KDHWGMg7mdLU79
	 bpauOgrsKnZjkXU+nxTTxZk8sN5xrZaCwaYUi8cm2AVoeoCscyENy491/+W0tfdYjvduU
	 DFRYP1Tac3UWc7DPQczklWbFhSB+whm8uwFlB4BII7E0wQLvrTJAZGU+rX1qdJ88ntne2
	 i6sjwKk9z5XMPWSK1mqv7vtL9vtKI5K8jNquGwesfaqc64wHPTz4rphXW83FoNjjPzhoS
	 BuCQKK6x9Ko99TqRROoBne4Bw8XpMwRHLTfrydjgQ5KR5h7dMp1eJGpXx7TgMVQNfwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792507228;
	bh=bU3McetT2lUHAcBnS4Opnp5qO3qv4kLmOp0b7OazLTs=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iMGv6bLwTsQx1lk97aiH1YDqx1TPK0enUziQnvH6YNiAMXVVt4F2f8HGGBdYqIqrX
	 hAfrG3IrXgvxNKJqeGr/nayvXvumuRVQ/ngluV1MB/6/cPW9MnEJtN+BBykQB2QGS6
	 0cZni+sthebXoG9pNWW16RMzNceecvTBT1wwB/Gz/CKq53azqKKXY7oL+S0cABMeHo
	 EYR/qKa8rTFME5NsYNj8ENV7qF02ub2DAK/LLJCIvQYpwiBseMRzPnEHwBEmt11Dz1
	 LbhCPhfn+apwftgZI/oN8iq9Ny+pOAMigzomvqczb2MO/5W1uobBKb/KbJ/DkdgplD
	 UBEG9r3Ol/Fyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0CD80B7D;
	Tue, 20 Oct 2026 14:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BAFE769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38EE94035F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlZstXy_MTpr for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 394C44034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792507226;
 b=e9FH8TLPnKYk4deCKZFYSntJD2Gj+EhgKG5ORsQ68wY/DIkolpIQbqgHM0Jw8ZDIf5Ju
 BIeEpwNYZjzpMTvZPgZr2zAxzmD3qEofZ8EJGOw1zY+mny2Tc4V1Wig/dt1Jg67vk6NtI
 gMItoBksFvlUIV6iCBSpP945hD971CFeCm6snluxakoK15ohp++Xzn0+MJcb8oSXovK8F
 XxrBJUryu64aJUIVEjW3Zdo4r9rVUOTJWeU5Z6Ui9mH7+k2xgnH/0YD2A4ngXKo4WImiY
 q+SOSBG0N/d6yPmTIH2w/Zk8KpgBwgQV8K79CZXG5e4jtdwmGf6zUCLi5fROKqrI6sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792507226;
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
 bh=bU3McetT2lUHAcBnS4Opnp5qO3qv4kLmOp0b7OazLTs=;
 b=r/6b7Jn436jA6Nmqnk9m+8YL8N48x3su9HvrA4Dmko1KeXfZqXs/iNXuN61aBr5RO08J
 5Ulq3at6roewOcY4BCJ6G5GrVabqsVsaXsI5wkwEbej1ghGzU1sGudSGM+hA+1jinONg+
 c680opx6W733G3FWF7F20gYA5HRhsp+kVHUUwH9Ks1vVMR2Ugw4DQ0h5MLFADVqB+qbcb
 SQaLn7uBh3ZfjUPhLI9SN3qHKTqqSUgtY0Lg8AKWlHz82qgeUgXX8vcFJCuBkqSUPgsjM
 By++qAU2pHw/O9ipNizkhqI8yzMUEHORUgQOr63bsxHJMuebbAg2I266doM5j4rdGXQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LcdLXeqE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LcdLXeqE
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 394C44034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2UZU5xgnNMooWVSSPFfzKd5EHQmn7UTfr+/eqj6OaUI6og2NVgporQ+8XsfxRQoOPmlekhg5qHNRwjKtDD6/XVjVVj84egWrhkGKQn5P+zhKJLaOgXkk7Xm1lFt57wD+2nlOkSsv+8lYwIYe8m7Bo6qjVAbM/YQrii2f55SE83SfKlDELwnNQ1QiDezPnzdgi7cEiLEN4oQoCb+KB4RkmvZFpEqRtFR9j/XmR7M8WGOi8uI3c0hL4USnAp9qKGjBdjYfb11vZnQuWxSS5g0TokTf/LMBiRem4KPc92QwBAW38BTyVQae6uUF6V+gMYegKFnFvqNK8U1MkRuNl3kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU3McetT2lUHAcBnS4Opnp5qO3qv4kLmOp0b7OazLTs=;
 b=rYWbM4569DtpUICILZs0XjU3PZGltw0xLWRD63oruOGAZSo825P/tvAk9K39VDEbGtbNBMK8e9vyBZtBxbhCzd6JS2ESuA/T/FEa7ZTMPOYymwi4+AyHlctoR1fsgTOzI4kz3BWgaiKGjH9xIK/KmgU+eBKi6yp1iaGcU1PRFHIkaz1Tosop1Xib20439GZTLqHcfZuhOlhDYcOjJ8pvdqBg11sOTeu6f5latGMfp5Znz5YKUScgQlQUyZY+/9/pUiPSHdQ3YuDuBiYySSW+ziypY0ggzJo7/wGXTMqAdWKC3tNNcJ/fygchlIf3YPFJEXG/xLmNj/CB1PpRDrco5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU3McetT2lUHAcBnS4Opnp5qO3qv4kLmOp0b7OazLTs=;
 b=LcdLXeqEQWD+uVD4KCKQiz7/Sr6BPqND0JlDOvYltAIRYNj2RJrJLdUu8kB7YOhD0ttSqWK5J9bXIk6lz88YqJVaIaGblwcCnZvACO5fZm6fYcQm511lFlRSHQsUzmvh/0IWB8naCUssWVI0hsflKKja5ydzlDjvGGceZFKqAjE=
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by LV0PR12MB290932.namprd12.prod.outlook.com (2603:10b6:408:60e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:40:21 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a0) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:40:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:40:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:40:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:40:18 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:40:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Shaikh Mohammed Suhan <suhan.sm@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Rob Herring (Arm)" <robh@kernel.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] arm64: dts: zynqmp: Add post-init provider for USB424 USB3 hub
Date: Tue, 20 Oct 2026 16:40:02 +0200
Message-ID: <336b15141bb982a7db19721b81b95a4a9bb7513a.1792507199.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2944; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ev/CIgYOhn9x4ptRCX3NVRPYfFiWpATlu5LJHbHpnkM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdr/UITZlmm7H/j4dvWsHxdlPW3x9LYi/f9S05s3/Cl
 OCktWmPOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiKu8ZGR7HZAh4Xm2s/TFf
 9nDBC+XPYnJ2x723BXiJ9XPdrF5W/oThf+mLUGOBgn3f1SWcON+0TO5y70ubojNnWoxt8C7hide
 ZuQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV0PR12MB290932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd8a6c0-68bd-48c0-f044-08df2eb81141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: wul30N42WjdpKFbd1vbo3ffdbzT0wcuNkHsv0+H0Ge1+FiXA8Wsi8h+gkhmvYH5UhSHN+ShQZjJkQ8RQ9N4Xl/oEZvh+/WDDYwAuz9Hjis22thKGyxosNJcSfJBmVjJSqb2q8tyRlJsXCvSfzhAPKVdjXQJ1Y8JA3pXHrJZSx4HoP/UvW6vgr+h/uughacT0LzhKDPJTT+0e241UfEJzTpE9PFRpKLiRLSPDv3gJYA0DaQQ5b3dPEQSfOUq25wPPuW49zPVUqOL4NlfT8PT1KaC7iDJtRVl7+T5CDmLbr9QWQo5x5yL2S7DtmAerMbvAG5KdZuZW4lTHfOdhCNdL54kBfdb8lNubGmfZEtkue1CnGDCGHAZFeXSjC5km795dMcdpENh6yM/8vRYQO5FAs9LkkEoYJ3u4QKEg5NTX3itGBDnLXxmDJwK0mVMKlHuVglsugUYpCVH6fXAeWW3KGJMpIUJ4x5v/9KzsScqDEG8mvj/2mzzRFUAQK97Ke7rsoWY1lQKDXiwmJQ1mhoWToQQMIl/wxXoV5vr/OWoSYxHBRs39zIqVm1nveYK5B5CUQQ4J3MxIDZYogp4qTdTPVgl9ummvCun+0GN16QplKfZDCa32tycSh3v1AGbrmmjL0hmxjIlgFZ4aD1oXgNH7Cpxt/fWGBV6yeAagzFQJznc4WWl6qumb7FNeZ11q3Oa65Wv+xK007ZjhorL+2leEJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fUGw8fUAoRkqsUXE4g2LWyjG1DdTB0MYmqqUEJgwixuyrtnu/DAItkXcymfTp+V4vPoFnir00VX8VLc17T7ETS8SE8ieYZU1TqV1u4T6mLghMzL+IAvSsfsbWXY1kTJ24LGWcZalsSquBB3y7/J/ezSBascdNRlImoMrlOrs+SNDKWuglBHzeb2yBks/cM2JA5u38mYy72BCRtnWlHcU9WeUrp1uF5zvruq6m7D5QP4n+3Rg1ZbO7SRmoCa5vKFo5zN5SUwd3jOzGV3GfrMBQe5mgcx2dLdZZVgGaJ9g26w3TjxBKhUvVlSl59KnwZSPmOcnz3zzN5Vu3W5sRDTR+Rv2aXGUjWwyxAUNjgZrVPYImpd/ZlGoIdDhfKesSqz5FZRx6DGNfy2FC2AIUlwR6Vncttpq1TekbCnAg0SXcW1Q6+XDnFNKGPDEk0Ke6ugf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:40:20.7012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd8a6c0-68bd-48c0-f044-08df2eb81141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB290932
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

From: Shaikh Mohammed Suhan <suhan.sm@amd.com>

The Microchip USB424 hub is represented by two peer DT nodes corresponding to
its USB 2.0 and USB 3.0 interfaces.

Both interfaces share a common reset provider through the enable-delay
device. During fw_devlink dependency resolution, the USB 3.0 hub peer
may not establish the supplier relationship correctly, resulting in a
device-link creation warning.

Retain the reset dependency on the USB 3.0 hub node and add enable-delay
as a post-init provider so that the shared reset dependency is explicitly
represented for both peer hub nodes.

Signed-off-by: Shaikh Mohammed Suhan <suhan.sm@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index a32073fa0404..ba5d761805a7 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -152,6 +152,7 @@
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		post-init-providers = <&slg_delay>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 31b3c3582c27..3a47beb9f995 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -225,6 +225,7 @@
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub_1>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		post-init-providers = <&slg_delay>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index f1114a35aaef..ddcee42ffbfd 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -225,6 +225,7 @@
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub_1>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		post-init-providers = <&slg_delay>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 967548744d5e..45396e420433 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -197,6 +197,7 @@
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		post-init-providers = <&slg_delay>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 0fa5a990adc8..22faec35f793 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -185,6 +185,7 @@
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		post-init-providers = <&slg_delay>;
 	};
 };
 
---

-- 
2.43.0

