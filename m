Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A26606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=07Nkl2NH;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dfaeAimv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86AC860853;
	Tue, 20 Oct 2026 13:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Udkd3Wvs471; Tue, 20 Oct 2026 13:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C89FF6081E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504782;
	b=fIK8apidBZNFB90F4m6MXOWz1WCEaloqmBU7LXmszkE1CmrLc/BKNNa5EAcsa8dXTaSu
	 87gAZ3hFoqFLIzr8Rk24pUFMrYYnmjTd6PQnYN8DW6mOFV5dDIx5RH9vW0jO7DF9tzYHA
	 K3nT3lB/E/9cSWnaLj11zu4z9ukejXqSGhZ0Czdze97bXTED6yZmEVIUt7ciP6oHZvp5b
	 GyTVUAeNiOEyes0Z/SuT8XF3e7IXlmMNhLIAhTjHzlPZ2mYi2oR2TKCOexskoOn7u9eLu
	 ad//BhOxzNiCN9fKvNkTrQCzDaO4mx7TixeLBCRUHbfj2jqVw5qX/eflI0ewklhu6zg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504782;
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
	bh=Y0Cvd/YVm5vP9NBvLizBwpE3ihk2hKGp8smSH5dfR3s=;
	b=DJEgpzto5R/+XW5ckWkc11jTcvteweyIyUmFgCmZZjgRn65M+tmtARVP4+zX0t/9CSgX
	 FtPKPkuFnqYawyxVoqBiWx5BGj3I2OWZ5TlebSlwYROkA5A7UGhXkvLv4G9eu4czGgAwm
	 hJ2iisJYxIwBKJhyIX34CPIxPCjoJoVZYpEyVApe2oh7hiFav4I7xIlZz4wpxbY5/WsBV
	 3ETYaGZvNSJ2RazIwQWCBWsm6eGIFuaji1PYSpMpm5Mc2NCZOu+HcUGrjABFtPT5QNUXI
	 juvt9Fh4MfmffrAQdPMf2dl6uHU/vG6kpmEJql0XxBCxzkkkaaUjamgR0KBLSrUdt6A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504781;
	bh=Y0Cvd/YVm5vP9NBvLizBwpE3ihk2hKGp8smSH5dfR3s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=07Nkl2NHoJMkSCSB/02EAahyrW5EFH/bhYNE2ceYDsUuTJSkMSwuuU+WnHPaERc9T
	 NyPPyhip5aMeLJjoiz/lLQNhzMC6QiyZ+sKYfyY7XdNuaHxjXVQR05XQ8G6XBedCKi
	 h9AXyWALYZbEmKi+Q6NG3RVaapwsQ5tKI7gBBl+vmGRC6fM9qHsGxFditZPKlBnMnb
	 5LzXG63VBC/JL3HvgUnbv16HpJKT02sAw8nv0MGrp0fZyDaDk6haEJKiqFxsnIGM2d
	 Ek8cXU1t67Raa4cxUvLDfC1axTSHEMrBAO9eHVufdK8oKEK3/+z9aJVO3VyQEx2MI+
	 jR4ji7tp2e2lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C89FF6081E;
	Tue, 20 Oct 2026 13:59:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33859255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2525C40632
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25VixP1EA3mY for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36FA140576
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504780;
 b=oXxxViAHLSBWBQiTXW0rryXaYsPYmg0B5FNsBmHKrjPWZ2+P7zY6cWpSDXNM2JxTo6ey
 9oIUcsmJhyhnuETnuVV4wOsdNiD5VWNTXVAe+m970pvyxriU3nBYAZ/eQpy4Xm812TR4C
 F4PvAZKFVJxCdbCEWfnBsnthrsqeQYtVdAszpPI9KklNxFWAYicNH2THcnTmz0WujDh43
 RXXKHtWhOo/ANOULwKAXndY07i8bKNq0nPHCZTXulveG2AhB6lj4hxrxaZkgajJ1yq5lq
 BAaib5doN/lQ7cKi5OY1Mphds1H5VR8PhdjDyWj1u2r3iAHDUxZi3FQnrAfBmiBmFLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504780;
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
 bh=Y0Cvd/YVm5vP9NBvLizBwpE3ihk2hKGp8smSH5dfR3s=;
 b=aCULUGUL4OEoZS3WkANbItGTp/63fljZoC6M+9VZ3skZoDjfOd2HfkBhJCu8c7UD1SG0
 84/1CXZryemKaKfpcoXXXbJ8OoqCQNzMWoYw4LqJkDQGtsPx4xBosc8Fo5jJUoi7XW8UP
 +tq9gdCKHHnO6xkOyjZf3WaANyJhGeVDq9wy73paQMJBzemh9roejwcHeePlHr9RR89Ih
 HbKC0hNMiM7aHbI9u9vIkXXz75OsvJs5gnwQfT+DKtEDtMnxoKATlgwynAqtOF+DnIFIq
 TmwUxWPMlDMvVwhYiSkpKEuzlCPjfFAWiHvyiec+OXfLOzjGk9L9KOHudE8poILYA3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dfaeAimv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dfaeAimv
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36FA140576
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh91c0ZEdylq8hCQaOEvhlIB5ukEH+3h0eSwV/++RwkSyIb3R27kuS5WXnJm7nf8NJI4fIdf/3dOrGsJTkV6QD9Hzqf/q3tZromSssIyjXGzvVTsS78qe5sBs2hqkEvEVL6ld3DkEVP8eOhmZ5eJY9W88Wn1SRuX2jMmmYcc+NU3yrsmkrhpcJtZXHOqcTmsYXujc2gEeRYXnnkYHITQ8n1tsUT34vfCFImC+GDBW/cppCoEn3rieU2af0nf7PY8+xGk+y5GHPBZHdS1zc53MhDonAC4wgUtG4PPixRsT2OkUaziQMObbyN8atj4P484nhM/yC0epJUO3j7ZkR6WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0Cvd/YVm5vP9NBvLizBwpE3ihk2hKGp8smSH5dfR3s=;
 b=aMBHrkc82OwYx9eLExDF5lZqr/5d7jrvSRM1Aivc9EgaYwSxMXj/tbQCeSLvaFdgHYMSKOBjn4y3h9QgzCH78Ne+68fbEtSRTWV9yIrqCR3MYIVtKhsUAZPabw1of4m9KYdZT5ethnE+NstpV/6JsqZn26hMNXXteb4u7QC5l7XwIeQNkiYdOQjB7oDD6wldSX5zH+fE3vrNW0EbH+a7yrAD5My10vFh5OZeLcZTobwzYYNC8wElwPn6oPT6aFVsFt5SDHLz+NBOyYP5Sqv9sLJKNCRvxUdGpTDDcxlJEoV1n2n12Nr7dcj7nl6wKcUr2J+BMS7YBiglFPfmFW0liA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0Cvd/YVm5vP9NBvLizBwpE3ihk2hKGp8smSH5dfR3s=;
 b=dfaeAimv0j81WoVWmuCD+5JJhXWzoK17ELTdSLDr/TKJiObcO25Prl+uQesiGWhKZLQwn/SHU9cav7j/CzGzreVFzkvYEC4xFqlZCMTPnhAZk257G78M8ThDm8zMHpIEz5tfJlNCW3TOADnvsIXHs7bKFR6yvLA95QyBXD7pO5k=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:59:35 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3c) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 13:59:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:59:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:59:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:59:33 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:59:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/2] amd: versal2: Disable EEMI clk reset power and switch to
 SCMI
Date: Tue, 20 Oct 2026 15:59:20 +0200
Message-ID: <9b1ab68d75bd4db0657f8298e79c017a55276710.1792504756.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504756.git.michal.simek@amd.com>
References: <cover.1792504756.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=iKTqb9PtSzRHdk5LLmqGyRkWmb0AAeKcsJmgIOq1v94=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL97jILhTwfWX7dOQU36pPccEnk88+EhX4/DeDx2nv
 ktKZn6a0lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATqWdj+Ctc2sU3t3jZ9K96
 aYIz57yN4J+aJ1/9ZMG71mk6T2TikiwY/vvuiequNj95p2DTLyu+nf8XP5rQ7H5wcb1F3++380t
 c3jMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d520e4-3032-48d3-3942-08df2eb25f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: opdFz6D+VJL8/BroO5GYPq5RfLdQHTHPQGKB+ddtc9jxJrSWkBV8PTCuRZbLiFY4u2GuUF6sUz2ioO/4wdza7B2TtRACoA/3idydRS86GKGoaX9t/t+BIxrd3nT2BdMIiwmX/kLWgV4P/xftA8b8NFgX6F+4Edhad9Wc2oedGCNroiEFGtdKhi9jS6PdYI+QmJy+OBrOUae//1U7fweWFpISjl58xzA/dCeCMC/wucXfCNYR6YZYgTT50KnXWU6a9Sq4ct/wD2aHOl9YI34pe6/MxwnYkjQTKYPGpS+IRnorCC1uF0fgMKCFOjnCb5RHyUv88IfYfJad3RC+zzYD2vCnBF55AEKC4T30bGXyBufto54JStR1SUCy5maN439SiBEDYfibG4ml2rnd9QuU2TvESnF9pzwSYyruSiAkzeT9gMULLp7tOhkhQP/OQvyowyfPlQpRsBrpMOU5rlcvbNc2zXVGUNyITUmLTqRWT1uzOFHm8XiWbJ7JIlvtSasxcmOFWIXMauuQtwZVbCn5Pzlx5gZg5sAcVa/nbDVrh+vXeYNZE8casODy6gWyBkcLENhNDWFdKR+Buk4xyZDbVg3i1E+M0coRQeHEawajgitDM3qJpXf+SWt9MKUsW6PvY97yyWT6lxqMKs9//7CT4quY3xCPhZUaY+vKTe5f4kWnIS1OCf8aMSOBgNWnKiL15QY+GR+6i2hfPZRvHw1cOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m355b6NxiwB1/dlgDEOBNR0HVTJcdR3IkxhRF1l4W5BeeybMohIQRhVyMgFTgpH52EHgbDWTKamuzzYggE33PsfKH4a/eV+cZiRXUHc4xJcnuMvyydjXdtnktPDuyH7nhFQOcP2ctqhA0VUkq81/rYSGas6L9GemtvFqyfpx+KQt2EspFDdzCXDgBtWxxJxsCgSygkm/1ec30rSejSy5entvPD9kK143g9cK76JosFgZIpibaCk119qa6mqj9J6FxI3B3jxnlQWbQ6t+DSe2TAB7AH5tQhovSLwjRc/qiPGTlejLgOUmMHOyp8e2sz/NUswMW6To2kBgsS/+Pykj/KDSgl+eEetS66FovzqADoExrhD56qZ4UFq7LVQDp2s29HKLFDA+vA3yZahgB/Y6+Db23YQafeO78D0i1O5waI/txHY1HTtPAB4l8ktnmbQT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:59:35.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d520e4-3032-48d3-3942-08df2eb25f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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

From: Prasad Kummari <prasad.kummari@amd.com>

Use SCMI as the only firmware interface for clock, reset, and power
management. Disable the legacy EEMI-based firmware drivers to ensure
that all firmware accesses are routed through SCMI.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 0d92313d6b00..f6f87df632a2 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -86,7 +86,6 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
-CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
@@ -145,9 +144,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_AMD=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
-CONFIG_RESET_ZYNQMP=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
 CONFIG_SCSI=y
-- 
2.43.0

