Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56F606AB0B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=auhkG1i1;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YN03OUUG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B8B760856;
	Tue, 20 Oct 2026 13:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDOc3weZoIH8; Tue, 20 Oct 2026 13:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE47C6085B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504517;
	b=jrJD7ykFE1xD2CbsSmhOxeJkIAGnpVjmWHpUMA7nZTyPU+3JAQUKaCBbTxXFHjhPhqQT
	 8A+Gd+qA/A/MHTUoYqIx/J/RhdFr2zDApQ9w7FzT5rgaxnMEuwRddcOw7wZz0Rpqtuphx
	 ZSbEwyKFzdcYlt1iMwpqpu4qq+1s3kJoEGCIRBb3Z2agkRfnXCSrFSAi7wYTECkRnSjLo
	 Q365eX2/nfEuGCpXtjjoMKqMmeTFAvSun0rsbs+ilJUD04Hp5qfA6vuFtpRzBNncpgHjQ
	 rFOg9HrznOUg+H945TouN9dflF3RLbvAga9lU6O+sunt9PEOTN0PgrPpCTjGESxBVIg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504517;
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
	bh=7ukOxN2hISaoxgNDVJ9eLB5ZVmbhhJSbQrjBE88GG0U=;
	b=mb11Ifml3JxZJSjPmXxiSX8xr6G5TKuDrJpc5GQbXLWNeiUydCTS48GWITkxCwufOH6m
	 VV6ns6boJPxoiTWeKnh5QptvdTzFAmFnCcNaEvMsnaqhaPY7TZZt1l4Yzv7DOt5RmKr/V
	 ZzNSXumIcgyyELbPATkn9ExgnVcuE+z7rU3TuMDWhSkUnv/KbQNyfrmNqZYiZbBrCnOqN
	 iPuU8LTGNtJ9bJK1gI5DGYb/pMYNlcRhHzSSAOeztU4tYu8n+ZjdzeLB+23Bsm8VEf7vA
	 7Ce9YS9QJ8waqMaO0b0MbrooNb0o5WuuUjKBKDfkG9PaeHUrbSQfBl6g6oviEEmHaNw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504516;
	bh=7ukOxN2hISaoxgNDVJ9eLB5ZVmbhhJSbQrjBE88GG0U=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=auhkG1i1BzCWk8kBrHvtDWZ60OSsDv2mTj/EBLa/TGAPzxsU+72h56xEUYj5sCdmi
	 3syALSHjfGioGGXvULMAdsDulmbO1OuTvnl7uwWT5m6+FK7CLxaU3fWJc+uUpyOq3h
	 ppspCIUx/kf1K/p2/d/JCDdvjr1Drj18zn4szbTgbtS/BabW4W4eqUx4DAeCmAOMj/
	 n9dsVw7Y3uNk6Ibsb9jGv8wMInCKDa7hdeuYL88+qKzexIWIq54If5Rvc4qVmnArTu
	 4vYpWDwCk1rTKOsWt8r052bb9hCYVYAxuR14iE2UTohWXu4jGVrA+rVNHfIBJh74cp
	 ioeYTZqIr+HPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE47C6085B;
	Tue, 20 Oct 2026 13:55:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 338A4255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 254F04035F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoffDu5RzJ4l for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6229B40359
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504514;
 b=rpQS3iefMMOmorabBVcT8tczAhAg5+WlA9BghLebhYnRmw0wIFYJMhrvnaTRvVT3dd6L
 F1z9mEXPNmZQojFcnQqYClm0vlo11Wq+unidlMR/BkElPYdbH5NXZBAlcNmIoIqjcCiK9
 1WbJvUFL9j7zhP1HJVF0J+Kb7E5bcct7xon1knQAIRSfiq6RyDqTzOji1kTf0GfpWDj59
 RKyKFSy44QaCbz1fACtymj7mr2kumS27elxxjponybTMF71Ly8pU8DERM9xNs9kl7KN9U
 0TvBzF1YdDg37KUscd9wbPowKdNgYSEVdx1r2Dui6w2lqc+i05j/+WKg3WtTMPnjXFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504514;
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
 bh=7ukOxN2hISaoxgNDVJ9eLB5ZVmbhhJSbQrjBE88GG0U=;
 b=iQ+SgKW6kBEIpWyCvqwgCoXn6+ZqOfaakcouZVAuFjIHTUHFPWbv7OgX9f4r7GcsOqtp
 GI6Xc/CS3yaWHh6bpb1kcW4qfW//aycGrMSQdf5mWfLRdad9hUyRtGuXPug02Byf7WbM2
 c4DKG/fm6TmGPnFzqx42OblGLhjZ7vcFQjErRM2GSwlPWGQEWeOnZ4R30b7MU8B3XI8UU
 Zq+XXazEPLHepye9cpV5zZhDm1RgVKuh5w5yHpqZLpIWMttKTS7FOa2jXLCauJoxv4BcX
 26NF9+0lkMaD8APtylVoHpJLA/p1Y3I5i5GOFdCtt385ClbmSGesfUZE5rTQ4fSCNVw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YN03OUUG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YN03OUUG
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6229B40359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1JA0VB/Ci6gtO65AOnCnyjk8IqSFuDGPXECbmCP/KhCm4pEgVut57hxsi+h23BpGYrZbW8C+QqOTbMSPNndva69qUj65eBLmp/15Al1XH+DWxVZAPg+7rNwd3k0jM8BiwVzda4PnFCgpdNMn4N6msO8f5PqQjXtLkErNkfcMuDzyM50Wq7NIkSZe8t9RVXr57abmUCHUO8zbJF6WCjg4Vw2i0AFdACxV9j5zgkPMPnWWnUqS9UNWPz3r4u9i+ywXnyCwqydQdb+ZbtK4H3/4cgLtd86O+WtOo7ZgosdWDQ4/mY6g4GGDYOO7gHFv22R7szje9yWvENyWnNL8HBqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ukOxN2hISaoxgNDVJ9eLB5ZVmbhhJSbQrjBE88GG0U=;
 b=TxA6mwRuzlID4PS5d1PVupup5N6tsF088jaQmF76BJ6Epr9de+H11wUyLj81YoXc+2zNJzvnSM+gvHEzLhCW/HNB4bT/FWynZk4D+9+GauOKq71kO3fT3Y9KVvzIIpqHLkqrV/053Q+WvX0eqfK7VxOalNZxAAaHc2tHCUe39MHfMMFAeiJt5AkIwoE+jWEk4j9wP4wTRGAQFufU4jGgwkHZrcWWZeircaIAY4lbenh0EOaQ+glcWyBUNsBQyi2vXU/FHf1hm3H2ori0DrdR2/EmKhBnUwAGxm9uCKtC68NcbUDs6SRC6UnOialvrSUEKhXkbtZY7pp2ajAJZWaSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ukOxN2hISaoxgNDVJ9eLB5ZVmbhhJSbQrjBE88GG0U=;
 b=YN03OUUGMSZjrJWGIrR4QOqu8fAeUsjp35jcxv2MxRhoqHVJHevo4A/7yUEXIjcrOPEnObCF7cYkLGkzop3U9AdGmi5c52YVQWgGr1RU869aLUuaTIWqcDbpXVmSxqJ3Q++OirGeQz3Ln18GEvsVuPlXwi52Tn1g2D4NsRiCYMo=
Received: from BL1PR13CA0447.namprd13.prod.outlook.com (2603:10b6:208:2c3::32)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:55:04 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::5b) by BL1PR13CA0447.outlook.office365.com
 (2603:10b6:208:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 13:55:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:55:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:55:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:55:02 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:55:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] spi: cadence_qspi: Fix double reset assert
Date: Tue, 20 Oct 2026 15:54:48 +0200
Message-ID: <3de50b28f764bf47bb291d4523d55a347d42b20a.1792504486.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=w0CJLjFkGdJgTgQoZS4s85UsGz6Pjy7KJU4YFEFGMpw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL1onGd9wSrtqCU/iwWWcAbd/rHQJDLj9L59/f9/if
 p+oxrR3HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRs8sZGebrBi17tfdF78/J
 7Bwc016aazJoRCbw/Fg2P7At5GHVaw9Ghr6gHfUyCy+bsHNnWG61CX72/O0iq6krTv9ZX7P16bK
 q/1wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b5cd26-4e4f-415e-a1ff-08df2eb1bd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|18002099003|11063799006|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: 4iJIOX5U+Wpkp5Ojd68gEMsg9mnLxnK5thvn0SOOHFakyocr94CpiT/dQbhLpSk95QhADYfrx16CyQpxfFefkh5BnIfh02/oZfvLnMXAcZobzh94otIZMFQuv6xI/p9kRTFV9+UQJnE5tbiyhF5M0l7ZH6phFaxY8J8/uK9EYyFG0SfbiaL10hRZjQahnr6Mekn9GSFWj/Ih0u3+l5c98Co4tSfivZtDVz3Y8Q3UT1xV8lDarT8thZkNYpSUS2yzz4RwVMqGdyi9s8D6h0ZHoawtrh/D+pF8pOYbujn2mI0qRti0dL80AUO/JNE7DNhfMdH1QyT48TGA41zhVh3vE5O/rq3XAjItIQKd5rSmSKQzS3Gvx8q3qdID9wIUJ6LcPiQDikC3FP7p894gt+CS5gMnOSnw2Ube9c410lZhYBM9OBQiNOTqdK/CKKMgIa7d9c8JVrLmEG2k0EmxyEt1dQ8JyjgZXob7zXmCNQyj95yyJjEw0avgTLYa9gsAEzFWCXXYsyTXzMZffuLorU56If4AzOaGUsrPo/6WqSEFWTpY8CETJHvvDxNzeWPtu4OiEExmMuDai11MAy6uk8pqJMZfxERbtZnHauhTsfuGU2+Htcqi8BRyZ9NiVIUvucd72dmqfS6Yhuqdo/Eoa4DMxscs/kMYbJn9pel22iZeKMNogke8e8CyiZDKyfV4NflrWwudpQg8CNVjXC/8PPJT5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(18002099003)(11063799006)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DcDKDdIyJM7nT5js5QvbhUadMTzqpkBco8TOHcah/E6t31SdmUtzXWPEorno/YZF+PV9OY4Rg6/3DkId3jao+R4AbWuWkhKAVatwOhD3nAgTdjVnand72zTMiDk4P+q6ltlJEUUXrXe04mg9U7wLp513W3avhedzCGxnhM429gQWfr/bHX1QhVT34tPEJBFmXTrN1pD8vUmAl9qX2RrxWr/7k236nLrpBq/s2jTzzZA7P2ztAWAqEkhwgDo8fL8WLJLJszUZ9W3rt/S6xx7VUJHr95manqufz9ODMcuIDa5iU4aaOBIA0POerdoEsqVrU6s3yHINx7gUjAa9AXzL+tcZg+SC9iNeuWK7bIFjbpUKjCGwbux/qu0vXZjIO93svh58I/e6Qcy7tP4EOa1rvV16HcxYCWGYwAbtMpYXXZmhh62zDZoglYF7e25SXVVI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:55:03.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b5cd26-4e4f-415e-a1ff-08df2eb1bd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

 drivers/spi/cadence_qspi.c | 10 ++++------
 drivers/spi/cadence_qspi.h |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 4d13c373aca9..ff6819864962 100644
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
+		ret = reset_reset_bulk(priv->resets);
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

