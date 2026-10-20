Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD5606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jGBuS3/y;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b+CsGwgJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EA7F407D9;
	Tue, 20 Oct 2026 13:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t357CkxqJc7o; Tue, 20 Oct 2026 13:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F5204064F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504788;
	b=h1yRKXcoUCMYm5UKWO6GYPE09KzeYDbhtyAzN5tMELFqQPgeTyEulKBSXBZqzG+xQyGg
	 x+l2G6BQjiQPXGmyMEoLsoMbFXfojJdZrEtwmb0P7wnRCx5XiZiT1C10WtD9wkOYuwBsU
	 IqUnSLSNO/PrM9hJmzIAZIng+YBo/oz4e4tYmP5HChptGDbU0F7mUERfUdbzZnh2452ic
	 K2VxxrLwZQQiQNATveHttVnk/Ajy2BE0R5DSMTfAMdvP7gg3Oddx52MO2Qy3aJi7beGqn
	 MdFbq7BtbmavizyChO49QKiY0dQ7v5KpQro3qxOiyLIE4piQSB/BX9QIvXGm8H/gQlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
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
	bh=fledUu1uQhzh36uNql+cK4Mc5Z4pIzTF0YPxHNAAtmA=;
	b=Mnjgytbcp/X3N7c6KEr0t/5bZAd4kXTrcQOY3nQn2afiMF1EOtvpPPlnb54eLGcKWTzG
	 u2etfUDPkWbNkC+aXMI/p8/ivLPo2F4LDGQ6R5Jr7MdT8t6G6wmjawYPvrGrHPbWLtcA+
	 o6NV06c6IJbKYfp656fwXQrRlog9ckFpfVG8lYn/HyrUCjqytaNSFeSLsJ96O5JJWGnEE
	 K4Lo9PVD0Ps4l8Yu1UNGStqpKDiVsadvprqZO5OWwNazFI04P6kW7LxkW1jDUqcqGZJzp
	 osVvKqC6q2SNJFuDZJ9K+M9McJxwVF1CB/JWMOANIRMPwFG4qXf0qb/apIuiZ/mwfmQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504788;
	bh=fledUu1uQhzh36uNql+cK4Mc5Z4pIzTF0YPxHNAAtmA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jGBuS3/yS05icRlecOGudR42KxNH3mvtTjjexzcKvbotJeC9mUtDquogCw55Qlihs
	 zTLeVtFeZTAMo81G1BY+67Lg+NhYomzIUKW0OInsAY8/KJe0tU9TEmyrz8f00nOGIr
	 hr6K3BFa/9lbOI7Ip2H7QxLJvgjcVMiKuTE4p8PMLs/bem5lyyD5eAW7+V8u9yLXzP
	 6bkLi7lP67sNJeY0/kzFHOZQeqNbl4yb1BeFXwEU7QsorIGmVkAhyUjhV4A5/TG6HS
	 K0NAqRKp6zxR1HenUX+IhWrZ1b5D7ZRCs8jz6P5UV/SXy4OSUPoMStDPxA/xpgG1z4
	 /KU/JynjnaYoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F5204064F;
	Tue, 20 Oct 2026 13:59:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C629B88
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E67280D80
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AcI0dMwFj6qe for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:59:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF01C80C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504786;
 b=Z0GlCOVZu2/RmF32GIYeOtaqZ+taEx5525b/adN9dJ3ERczv7ZMZlSkZLnNTAEB1ubeT
 +FlTpnlJpzhg/p2PpZCN0aebByn66bPcMXGxSkbhbee4IJxiOKZv/AELX+uVU3m+ZkUlr
 H1oqIPrLe+GTPV1n1FPKGI8IYiKC9La3RKsOS7JYOJX5uaHwLHMP0a7pEGMloLUXHqg6k
 /zfmaGau2KLREubc5GX5xzVY3HiZWf1ZoCvJhCrMEqBBtQtN2IJfl7Tz/+01fA4xAujXs
 HjnojeHsUZ2kMcI02OH3Rn3wMXgYdEcFzXaCg05Bu3E5JK80bZ0/gRiHHVyVVrNMr8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504786;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fledUu1uQhzh36uNql+cK4Mc5Z4pIzTF0YPxHNAAtmA=;
 b=SpVp+4dFZdfGi5/UBRH9TFmIzP2ZI+povfzAqWIlPJm8KWH6xAMJ4JCjj4GpWgB084XW
 +T+S8PHLo2eOWArOc0/rtuVVnLLs+/JJn/fncCnMw8IagCaOXG7wuhKGU/tO21RGTpevx
 Dh/iACX4RTAo9wJ5wDVefbnnb0Ej0hsTp0wsDNye/sz8J8tz86nbTO4MxIZM0mFWLOFGn
 F/JkprcGnLybUzhFm614tRL38oXxKktShWz/nRPu07kqvf0Uj8Vtv7MvwW5NMujplqiRp
 t2L/6+3aWaSvnjFp7hR3mkeXKscPd1osLrHIcfi0F3qWYeeT5NCmumrjwZFao0NrWxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b+CsGwgJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b+CsGwgJ
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF01C80C26
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ax5dlnzvp+oRu5IyXw3NjxRmMlu0rVuaTZYAYJIN/flAm3sTj7UEb60d9laHH1F1TfZ9Vdfa31mPgqeMTYPYZAtK8Xwi/8tPnIdUnC4lZ29VPcLCRb3Kt1m6XIxB1pf4pC6f7jMAs0sdqfw+sN1c+ydoE1dXJxkwx17ANiM+IZV+sEeSVDzKD0NQTQtUjdRhVQXFF+0C7Pyjalj6jk7bmvhlhix7Ke3IE8INFZpD9k36JvdMGYSpuRZA+0b6GsPEzbRFWltNKeljvwZYFzNgp4MokV9mgsNPBZ8ylDjgVvqjI6g39zXB6PcYQWtrR7FIYH+fGu+Wo2NWGtw6PVoQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fledUu1uQhzh36uNql+cK4Mc5Z4pIzTF0YPxHNAAtmA=;
 b=UOLOp7YGqDAqNbPCKX7Qav7LQt8IlZFfRE++aF+R0nKeQgqbhX2Nj1Mm1b63iefUkknNf57C1ZM6tpNga7M83QjvxqYf2cdee4WTNNI/6NDzF88pXsNIafOmEC4+Gye3nYV44dCCNx1OAjoD5njrAcTNbJMto/tj/phavHrn86Ymi7n6PIeNjYuq6jLqBmVDI98wDSrdUfgBZml7VLAak7jNgcIPhr8n3v59fYOpVuTidYgVFAR76Hz/RulzH26yesJX+mcwa3axH/bOWu8ZCPkDyOGaxZRzEpbOF36xk40F90i8g+wyQ9ftQ3/Rp2mA2RAmjhwKlIoRk+zakoKRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fledUu1uQhzh36uNql+cK4Mc5Z4pIzTF0YPxHNAAtmA=;
 b=b+CsGwgJt0gY6d0cDZfbrCnBgNM90mgUMhJw4Om0EwkLRx8eifMgSWfHZEZnXeMZbXWXKhn9tzta9bHtim9bpeOUC+ApU767vhGGKtN5LRAWMmwWOFX5r6T1gti/C5hVa5mIafK7DL+plItuGac4QyLSu9deOdfcWxyvu0I3OV8=
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:59:29 +0000
Received: from BN3PEPF00022BD9.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::9d) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 20
 Oct 2026 13:59:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD9.mail.protection.outlook.com (10.167.248.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:59:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:59:27 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:59:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 0/2] amd: versal2: Switch to SCMI
Date: Tue, 20 Oct 2026 15:59:18 +0200
Message-ID: <cover.1792504756.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=467; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=u3MQbpQ/p2py/vniEXqlMyk1KqdqigPpHNrUbf9o5kI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL971oiVHY2f/rB/LNjVcusluuX3WresLUnRDtp1SE
 mSJfMkj3FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT4c9l+B+ys+4v9+MHuWHL
 Us+yO272sWjbOPH9FL/lEdobjAuvR9kx/OHm/2fb2bc38GxpwFTu2R+SWEpuLM9XFdFtXBTcmvT
 mFgcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD9:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 03714476-04c5-49e4-a547-08df2eb25b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: hYDCywF9V9wzPL9ShTNNhMW3hHkVLZdFzZqyF3mK1dApvbLo/0u1qA5+ToXicx3GHjERxvfc4kMAV4CRC6nlrrYqVXu0zvRNsE5LASALVDmlJVEFqCbX+FpsbJqjmHgVcyvH/gH3ls5Tet9mHxrWfmmuIRt3/ulDxt5cTf5dSmpMXtB7JwDDtuU4tO3CKKRFWtMaW4O9kl13zXO8LUBVJ7/5a5AVcPuu9MDT7XU0ZsvwVSJvxTLescrGB5ruq72SPVxdXrI0sXhcMgVdFdCQQnkJG0lqoL1r6qJ3izimpMXvrfVTkPHGI9yZTMuN/c42ejQDoeRXtN0lmsDQy4TZCExafhG5dL+6uHMf+hXzqdVcRTZ6WVQHKVkB4bdpNwcoeKaYNsw4LWgq121bSy/Yo7oXceXJdYE3yFZF11t0LlBsSAsfJHtq57Es5ar7bagib1n76LldoolmCmgmdGNK01K5AMKLo6ibb/uvKtlbpL3gYRmZdbUbWQTXXVFaeHpDgw8oXfBRzlsNOag8nFIQI7GXEpO/n2YccegGdi/MqLDtn3veHUmlDHtLUs1ZslAJPWe0G83HH66JLQHDcbiBYW1TnogpAomCtW7PYDJSw4LlT9GoXUomPjyCgp7k7A6lyesyeOV9kVuWuPjSVVTvYddQDHTrVhQXLQ8vut61CvElVuMV8CD0c2ubPFDdfur/k/TjgoC4irTcmimf05q8Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tsRB6Ns3ZkaBNG5GpiL8UKAcX4mf6cszV6yCyfiD9aONZaairHPp18NABbOq8Qr6+J/hXIuvmZnwWed9OWbmAHS1NoRDOm52bq9KLBWfuHRt6C12EOjOv04DNb5+GSjjgK/h6uTSZZ4+v9gAElpN0H5M9ueJWY/Z5mUV26nIJdVsqhFU0ibyt5999WLaaNbpmM+aa3JAhgU3Ar/f2BFUxN9wDV1VRTIMY7ocrjp33gEptmeJKYP3XB7A+eyRRUKxRL9AQdkzR31GTd1MGz+hbK6rvL5v6EwFHM4vhS7ENqKngAYaeh2pxbJUGUlNzTLzq8yfIUddEzpuqj0Gruuf+zDm8LofQ6J1mUiw2UCowsnyQ5niFQ4JOE8nWAduC4h2iVmulDM7/kcz8aERuAurEoUtHmYfROcLEcqFBbOcMm7u+WWnNMW5Cp+OELmR71cr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:59:28.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03714476-04c5-49e4-a547-08df2eb25b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Versal Gen 2 is starting to use reset, clock and power domain via SCMI
that's why enable missing SCMI config and disable firmware based interface.

Thanks,
Michal


Prasad Kummari (1):
  amd: versal2: Disable EEMI clk reset power and switch to SCMI

Senthil Nathan Thangaraj (1):
  amd: versal2: Enable SCMI power domain support

 configs/amd_versal2_virt_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

---

-- 
2.43.0

