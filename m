Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3046606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I6GYWoRS;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0a8XhnvK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F5B760702;
	Mon, 26 Oct 2026 08:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UK_GDJ2xJfnl; Mon, 26 Oct 2026 08:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C73E960645
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002477;
	b=DonuqwxpIZWtICLZS/MntemcI6KQuWzOV0gdWaG/t6tDRWijiOqA8clQ7Hv0TXmrXyJ2
	 pn3yHiZjdrkIlFDJfIFdAzvG4sCU1xNF8YeDW/xzSB8ZrglT9nitoKHa//0KgiIV9JtSW
	 xkFdH1pKjxEXTVzogit9mrYBY5MemmbUqF90Q6Gj0bev9Jl+/vhfH3egBE7e49W3IYw4g
	 ttVBltGN3FRdBINLTgjO6TS/6XbRMIpuOjZAisJRZoM9nxs8II1XkYYDQ4+8m5hYELzeN
	 XI9R5pQ/en6SCC/6hMX6b1UU1UsItzIBBxLdd0nPeW/LmvQObNQlfqrtFbkrr86ZnaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TvtGeC7eHi2sSd4FE2ISOfeaUrPhqMlyg4cKQyd3ln0=;
	b=tSoYjzMbCPG2RlpN+2IB7XnOeCg0FpLI9Jms2HiYYTrF7jnBxGL8GWcXiw0D5V4qw5cg
	 TkGJrXDgYxvjKd13JwxcTnxFvX+3Bhim97M2t+1duKvCOJgz7ADaBp6nqAychn134D1EH
	 4rwOKHixMkDI8qgJKQk/CyqGnNX1EutBLvh65VY0FLd4WAlaX/zDgourqJ2Lr/vxe1X1u
	 9Hu8O8KrBBmhmFMtLsa2bnLTGaV+Jzb4SV4BhdxKK1aEfbVvhou5GZb2v1lIBrrtW+QU+
	 zkQwDEhs4+yo9UhjGnpQ0XJ7gZO482NQinfNT3J5Xn/z25auLdtI2XsaXJsDF3yvJ8g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0a8XhnvK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002477;
	bh=TvtGeC7eHi2sSd4FE2ISOfeaUrPhqMlyg4cKQyd3ln0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6GYWoRSvdHwLDsmFo2d0TKBHzlIiOAzNJVp0O9hpmwkD7EyCJwUmMeQdxjyhuvIC
	 XaEcAQnO8r/eSL93NWhuTf1Og1cBBh8tkhgt0K6YmG8zxETQDWV2Gpz8YV0IQiwg6K
	 Lx7+psBJW1hRatzzxI+02vFRwBYRZ2c6XeQ62QId35+9Uv4ojP5QAVL4Q186J5ZbCx
	 cvVFlGWszxEaxDx/hpSsw1ee68Hm6sjCujHhRZ4FmgvZcMCQ18yiuK2KwcwIh76Q5i
	 YByGsnkwdx1A1kW9mayyyYdwQiucbPCtW2OALuBtaLUHNn+EdgEQnJ1HWHivC37ivw
	 KS4cF0XhXRy1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73E960645;
	Mon, 26 Oct 2026 08:14:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E164F4D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D34426061F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWHf4QkKmnWn for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B85F6060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002475;
 b=P/ZHIT1SGr/VecnzLpgkMaU1oE1cXssh0PJL2JNcgt6px2C+rfBCLY9ct3KdPKLwOvSW
 k5MMAwXcdzNU+oHicB3zx8ofNEFjj5QRHU48oo9LiDc/NUUFnDUs1RqC/e0Vx+5cE+8PR
 LZwH9Fzgd4fCkVizIF2ZAMFmwDEOkOvPK0yOJauR9wYkXxaii1HVlvB6+9RZyk7kIGbp5
 HLGe9UpeppXrguygRw+Y1DXbiUUYpZ1/69npeRUGJMD1nlcGLYVtug6Yll9RdZZyoNvr5
 3DwnvqCyBKGUTNQDK+OpqN0LJoZiEObsjzv9heIhTNsCQX+LpeVmF/y6Vtmkm3sPO2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002475;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type:
 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
 bh=TvtGeC7eHi2sSd4FE2ISOfeaUrPhqMlyg4cKQyd3ln0=;
 b=sE7XqHxcgznDBqX12R+5fYuOH5bl6MD8nqMGQJQaMt76blb8rFNx5fU1+NsoRD+a8Jc2
 G4TRC8rsrkaMQI2E55uWJkAeBL6S8OWDJ25wkPv5F79KgU36twV+GYvi5XuKAtOZeCRna
 t/9IwJL4PlsAKdyvD2vYRs/8bPHkQJibfIaRlB1kvaTcIL1OKpWedXB/PghWWWyIN0ZXT
 rq2I03LnITPbhToYJ3D7a7729fW/gyVHmMZe7jKSF62HnKKW6U2epi9La+48lDUJInH4v
 yMjoKff58OlI6FulvczfFocm1QsCrKUFiTZXbY4oDpfUI8QVOG/DSBCWm7ZSsRaUcCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0a8XhnvK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0a8XhnvK
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B85F6060C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRagbagjqZ1gkO2vfzNHaP5ShecbeTCqmWWzkBq3CQIPVistjhxSU9/ay5OoMk43908Ao5SKrvY9hI6CKzEdJzhHJPJbvVwxOZmqYcgLfpTgBNkWJR6p6Qx0vdTpWuzRfdRv1syQTMfGjmj6jS4D0nT7ufpHK4JIuHudWnXJhCotAgKhXVAKFfGlSMlE0NCTs13/EOtDBgBf1LTKDYowY9e2bgy/VyyBKuE6cst3kxx6jvjxgGxXTQt/iJYZn+xr8nRUAAMqzjjrxKgPOZWgGSeAZu4CAZvCf2COIgMdvALPRtCdMbS/wQpKUqZ/39IIBagcaV8ms9/fEVXe3Y73cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvtGeC7eHi2sSd4FE2ISOfeaUrPhqMlyg4cKQyd3ln0=;
 b=ft+6gdtrD3PCOXSLd7nDE2byMYe6ZOe4edT9U0uaM7+FuqYzCuOR1vKejs32vDPuSQNqQ0e8Z9yKjMcZtAOk+ppDsjBaYdYDQ5tDvRZmh9jyHjpoY48nN0HNG/9M56RVGA1y9PN2kOkVlyhyudGsZYZEz0OYtPmvlEK+/sPRN/ibsDlA35vt56id2XoP4US7dyDiyERwTuzXavL+LRkREKOJXR+j1b7xwZjRTSQlAjSykEMSA3HAhSB6RjKu4/5+KNnG3BDR0EA+SVpsWO48DbP5abmzhcnxL6edTLB8WZb2AZ5xqEGCqImwrqyMfiKpgNjQyCibSjvIBsiAwdGH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvtGeC7eHi2sSd4FE2ISOfeaUrPhqMlyg4cKQyd3ln0=;
 b=0a8XhnvKebkr0YQoJeIIZ4ZrJAuNVC7gsrWGWS497Xq8uG6nf3nBpbHYBR6eWtSu9U/M9a4p7B4hBLOi5+ixza+prDGJA9hBG5RuamlZ4Bpiu8bWBV5NlCiQ9IMNg77+YtQHHBrBTvR6/bytb2rdyt33dVuUKZY6W8KMi+wVV5s=
Received: from MN2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:208:236::30)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:31 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::28) by MN2PR05CA0061.outlook.office365.com
 (2603:10b6:208:236::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 08:14:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:14:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:28 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/11] xilinx: mbv: Update stack, heap, and OpenSBI memory
Date: Mon, 26 Oct 2026 09:13:47 +0100
Message-ID: <f8c616de001d8df9e35f55019140b06562eebbc1.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2913; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8Nkz3hmNvr5u63YPxJheFLkhfS7/xwlCcBM3FVZGoRA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z7IbWyfoiLHN33ffrUs6+zLAQFFfLMfZKgFb7No3
 j/F52dURykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExkvgHDX7HI9+v3zrwaNEul
 QpNV8MWt44tnpEUt8V9w1algY+o+4yUM/9PPHLoRNe9R1UuOSoeknY3eos+7JavKFy194Fo4rzQ
 vixkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 8379e6e6-0af0-4884-6f89-08df33392937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1+Bs/nbDyJsJoiXJIuuhdtaRoTgwT9z7u4auDa8HxPX8tWN/8ApCM+Ehfv78eOfHkJTHW+1ClKHPkSmKtOfps2rpHfH2PlpmR05H1ChO/88HjcVEfedEUBZHSl8C4KlKFWnwlJEGB09daU/8aTI8BwdIOGXd7vPPd4TeIKkJ/vGSm+adI/X/R3dEYgYXZtTMIoalcAXldC/qXGA4rIw//D9YsbDCXvlvyyaV/3JIvTi4a2EHYtr64evmGhraj9/zOpYuyhTxREQrF0Vlozzt47eREIx8WPEaswHO9f0tIHGq2zdBYiU7nS7VDzM1SvaR9z7JoeIwpGAqAM8FDP3yw9L9A2N1B7mRywdpWOU3vgs/VchjMLKeA0Wg+PN/A+zyepUSrnw+ln8WsPyTIgFSWgI0sshynCQIsdQInXamhybeVd9FuFWYxDWNhhbLkgssahXmsEGLb6XDcYAK/XsNtx4kwk6tyC6yBxFJvtpshuLGKpy08OxkTPrBcy0fB1/7US4PCmb2rHFw60itcRpQRrZggiHmJzxB+Xy/X2aQP1O4ObzEQYyi4a685iCyi1CCUSWBMAqhXz1kQysyo+zwG16FKTJpOLvkJ8NQ53Xe391Tcbkd5LMa+ejOfK5qiCQtXf2sDPrjJF7Xq1PTgwyOKW0r365RRikJzsYZWMHPKkNWBiCRwUePh6ZcOHdWLyu6R+4a2FaOwrmz5B35+RLChg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zu42IDBoKCJYDLnE+iPNSSFvbmhjE7/Db0zPAVtj2oGIFJOCBZCTu2tbffaBhVHjasU8HgMF3Sq7VBMP5s2zCPO424kcX8kdx/KT54x6ykSPOjJMz6XnKR4a3pPJ02KxI3WT7tSrejtBZQRBYy/BrUBgJwtpftcMkS7fh9RSwz8BCQGSqgqy1jVfEpqpNX4OM5euqDdpZU+aikCJQAthgcg4MiuxBGsKI5lbs9Li3I7CFuehRDjISprUMuTr+tWRq/jdsWOEm/QJ9r3tE3Iw7wcdM4PJPtAeULeYzkjTWnNNOZ6OJeaJgIgcAipfmzgrs0sVo74Z7hTtObw73Bouygnvm3EjmngfgJSyvU0DuNziZ16KA5xiO9xgq0h/zZ1yqHhKihUR+lWKcMWaS1Nle9/0UIkSzHJ756v0s/SFMFVyzi/0c9Zv0MxzV6m40atB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:30.7114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8379e6e6-0af0-4884-6f89-08df33392937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

From: Padmarao Begari <padmarao.begari@amd.com>

A 2 MB region of DDR memory is allocated for U‑Boot SPL, with the
heap starting at address 0x80000000 and the stack at 0x80200000.
However, U‑Boot fails when using OpenSBI v1.8 because OpenSBI begins
execution at 0x80100000, causing an overlap between the SPL stack
and the malloc region.
To resolve this conflict, the SPL heap and stack are moved to
higher memory addresses, and OpenSBI is relocated to 0x80000000.
The SPL heap now starts at 0x8C000000, and the stack is placed
at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.

	_________________
	|		|0x8FFFFFFF
	|_______________|
	|  SPL- Stack	|0x8F000000
	|		|
	|		|
	|  SPL - Heap	|
	|_______________|0x8C000000
	|		|
	|		|
	| Full U-Boot	|
	|_______________|0x81200000
	|Load FIT Image |
	|_______________|0x80200000
	|   OpenSBI     |
	|_______________|0x80000000

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig       | 4 ++--
 configs/xilinx_mbv32_smode_defconfig | 2 +-
 configs/xilinx_mbv64_smode_defconfig | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index dfb0865a5c27..0573ec29df65 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -9,7 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
-CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_STACK=0x8F000000
 CONFIG_SPL_TEXT_BASE=0x0
 CONFIG_SPL_BSS_START_ADDR=0xf000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
@@ -40,7 +40,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0xf000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index dd1221a6904f..a72f13851acc 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv32_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 56bf0bdc7e4f..d7cf108692d6 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv64_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
-- 
2.43.0

