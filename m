Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E539C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 190A280C2D;
	Tue,  4 Aug 2026 00:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmHZcS8Yp7zL; Tue,  4 Aug 2026 00:10:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 356A280BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802231;
	bh=k151tGCnKd3adyLxZ1DjnN4jlh30h1UoLCp2OZfyrP0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaLVTvJj796jAgqzaUYJm1AFzX5ZttykvlG4CZ4XMjAumYK5Gix2e54g5lGQPDXcC
	 qqvHS9ZYf5IuPWaxU6IhzEVGIXEv4LiZAzeN/MpmsbZbn8XIni5SNpQoccC5zpsIR1
	 z6kvHTfMrsM6yVQyn4SgMU6zv4pfsm9H+5eblFrqrwzC9pgWXKask4BqHd57R5QcLN
	 8KuRR1CLbQ1kspqbULnojQGoFIhJfEw+EpSvopWY0k29qMpADAwL0Zz/vJvQtMJClL
	 JLFvmjlzxH78aTzXW9oSH8IPbTxSv4t/H81Bt+g5+p+A6LCtJJAO4wk35Yz+70XE1i
	 AnZzoJLXtWqmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 356A280BE9;
	Tue,  4 Aug 2026 00:10:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E27D282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F759400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJHq1IVZa6iL for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 44DBC400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44DBC400A5
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44DBC400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:28 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673JjCH6438770; Mon, 3 Aug 2026 19:10:24 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0rdbb2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsbKwxY3rMIiKbyKRC1XVuvNQlKqmZQYUN060FQF1pAdqPqhixjfdzaBSMCDm0I6rhwGHAckg935H4EUrSNK9/iC0KjfIyPUhTL2ZJwng4pOm7grzDZAR2ZDrC9ZIGs8qt3uAqxzXaQsLcd65RGwQoWvdJ5BUvwfHlnAItlJ2oNkyck5wZ/RvViW8qbsWEgKP7kLaZaNeArVfw3l7/mnG1rjag09p7uz90jSNGNrpzgpklvlwAMDSgCQNT2Xuk+cHrGjSemKFcMFEZrJJVlHTVINzZp3CxapQeBOeayoreK5kDMEzxgLu9+caisJnyHMvOoySAKhCJKZrNuQKUplpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k151tGCnKd3adyLxZ1DjnN4jlh30h1UoLCp2OZfyrP0=;
 b=nyv6CEcmBjPvp4aOjkc53phEjxT4TZiE2R7GxQyevoT31tv2TKNECUgyAaebzMmEv5LIkvqLUfKLysEKWwou51Ye9wK0uI9GrF1Exes1j6WhyU6l9nt9oIpfrgFniNq6LXWNmKOyTNv+FSbMuQybI+1xG/meG57RZO4AfrOoDE24pkESqm3JZCvJiLfgbIRlOGzrizTW4AeKYAflf1MDaz8Cnq2yuMpKQS9a40yabA4gi7eVBE2D8bj6RE+R9zZrCt9ZMDgsnZ+2CRiHa7Ya6Kz4XkRnufDC9gWpniuRFk45bgf0Jy2mmkosj4UBiBu83Zq5s8TUETfSvMQSA6hsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH3P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::17)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:10:19 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::16) by CH3P221CA0020.outlook.office365.com
 (2603:10b6:610:1e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:10:16 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:52 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:52 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409pq32655418;
 Mon, 3 Aug 2026 19:09:51 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:35 -0500
Subject: [PATCH v3 10/11] doc: board: ti: correct path to tcl scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6821; i=bb@ti.com;
 h=from:subject:message-id; bh=qVyv6Eu0ntIKybENjNnuog5i9ZvhY8QjUAncg+Bg2sw=;
 b=owNCWmg5MUFZJlNZVcvKhwAAa////v9tunenrn76/v13/75v/8m+zn7N7mqjbs7P9L7r9+awA
 RtpBimQGgGgBk0AANAANGmjQNqAAGgAAANANBoAaA0aZGmmTJ6nqPKGnqeU8UMo0ABo0AGmgyBp
 oNGgaG1Bo2o0B6g0Gmg9JoaaGg9QNA0ANDTajxQNHqGg0aA0DHTRoGQAaNDQaMQPRNAYENBo0aZ
 AAyGTBMBBo0xGQ0A00aYCaAaAAGQAIEcBTQWKTlYmRzo+TjmoAAFbK0IZhWSGG1mZYET5AXqLh9
 CLVSVFQLMI51w3AhmuJYozB4W910F1VYra2XCPkJxkAGRncJmQtA+uAi8+T2btSZNQCXKFaG1fw
 pTFsFa3wj16lmacUjobSwZ3swoJAN7LudQuikztaquk6w3NCtQbXfQZlufjmKdZAZBKYxRaDEUG
 ky/P8LiBpBoFEKiOMQGXPgHB+4OpJOqj/6sSph/AdggV3+y2Ts5my3u8+MGEySnjGw3sylzdGbB
 K9WEwk+2nVhlpS4EUre1RYBFtTfglR3PiwgRUZhDgjfAzY5bVlSi6bmpSvYfrn2kurKUK51vT3h
 4410WR70ADZvFM6i1G97oVhTYEeV+RBAbEQZt/L1QoRAJJ8srKMaEktC2L9JEBDGi0K0rBKOA1w
 4CTLALM/xdyRThQkFXLyoc=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6fd898-90d7-4371-e36b-08def1bcc37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|56012099006|10067099003|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: jSGbpOITq9p9/ctzdXe4/grw1zSlQCmv9vg4as/VVGZbKrnQzT0gOwp848IY1Z0c/abQpNjDGO/RjTJd2BCi78JEL2aMabYUy6Frub2cYmvXuGWx7R95bRPDQQrTIhb2cObjVzMzR9ezSVU3DcjzpgyC4foWrBvx4nH5XNsbDujicqqGNW5gSXw0MZq9Og6u1xEqglIxkvATTdPU9vR6k1eb97tkr2zhwu5dnbdsLCenQ5pVrrqHdHQmOdVvtYYZGygYcFGT7IfQOFSiy0c3PFVk1p/58NEEoi7i7CzPop5QhgJ3+T4D4YHctde5SHjm3F9lRomzr2DVLVhsvPjPEmTyh2oy/LExIjudglq90q+5W0CY+XMCZnsJo814u+Wyp4V5ba9Zd9bD8kQXlnRmMiaLcMYfHskkH72bGVi9vGK8G5osq2da0X9hVcE5eCtjxlGl4oQmHjjsrVzOE1KDBwTVwTpUvzQlV0YqKltsCnnTe6l5LxpREtoRHBsgCEZ8yQeK5D7FRLTRQnHot0FXC0xKjr3qNlI8LfFDlfcJ79EWTRGSWiCAQjTWV7bpMIju4uYpO+ZgdI/uKTb1iP3Sc6DyEYFsPiv9uTepUAYHds0O7KRNdbuXx9eg4NTzrxZ+hMA7hwaA2nuJOdHJCuin94vnfI6dD3T0704v+DbFs5+ewi6v6Rrf3YXZTWEUp4jnaXqCTd1dw4NsAdutAMiZxQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e/GvRc4fADahUcblN77pGafEl+o9mFj06U0FJVuj91Oun/WaU3LEBsne6JejsgVURr9ITzZ+P3LuPnGMpMYYKMNCgJGS4q+FWixmIcSGJy5Le9sTTspElQ38XKPVwq61QeRDxfHzU6GS4+iIiT0Y98rBeZSZ09CWQ05gZ5tp3/TI1QvhefYibFCVN5hpjy2fYlHmJCF4pyJ4PXsDkbLEYmHjL9qD2DNWfjx/PXsnzB9FEtyUXrF69R1DDTKoG159yldWiY9vESbLnjUhh+oCk1nJYOmG3YuULNpwTb3RZrgzrxr5yDykHVVlvEay9kbh5wsnyoI7L3MJJjTEmsAU3VO6wM3EeMhBl88W/IBWS8b/EsKxiZqTwdK4ZJoYjU2TMcFDGipWhCF1tkwSGJuyT9P3dD3iQSa2bEJ+drsQMUYJkcc9EynHyoaFBGgvEhfp
X-Exchange-RoutingPolicyChecked: Y1F2CBjkDx8OrSdcTnfKIFX4TottvJGqrbysv9/rBMbf0gWUXd/Jte/XtDQuLS+slHHC7paBAkXpVQekt+cTH6YkBgUTY7Fnc5MDBpW8humGXCAobU4pv450TJQpTJWT641KlinZMZNNUAIoAfeauUg8ApcaN6oHXGld/d+w0QLJYSlp/fz4xv04jfesTcgOq7DqvHmnrK1U8dWetLXvu+7x52kbO7McnXakrgELtOTWPGkqJ16s2k/p4o1RbLCG9o5MzSL9RCV4msXwOl51aod9bGFYazBHVt+CMTKG+ODWzq303YvOYbHMnotLcLaJDvMAZV36U0ZIe4YSRC/mNQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:10:16.8204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6fd898-90d7-4371-e36b-08def1bcc37e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Proofpoint-GUID: h2AUJXiJZUzJe3EgN6USF6Paj4rtiXHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfXwav3u9Jt+DBV
 JLLCKQ+qGe9TtOqn2CxXfDyzvqkoAsOGANDr2ZYiD9IbgdewHkvpOtobZAU7KKW3JWu/g9TwJQC
 Ap+KaDlW29GqEQStMsedhqdNfOzrCgoWrN1/WRrmFX8P5dX7Zylyxbfbbr8CeO+rzhtUW0FkRLu
 sW7FDFcl4pxyCRuuSb6/jngrYRz38C2ITtI5Phvc5N2WFYy7sWUBFaa5TQkLfcgIMstqiyZY3+R
 03jfinrARvnLZ/7b0ssTYK7XjkKoGILQk+PuhWpLGBeTmuXDhhE6nnFKZMkNzK4T63yoqde+TU6
 BKlvKzp9A7sWY5X0LG0aVcJuSKeJzbojJcDHg80L1kjSpRryimZYerGiKQYajx3R8GKbFPJhhVz
 ZTH5px+hCmNiAAqjbNR/Kab8RF6Pymw7vHeNx69+92t81ySthXmatGG1IXLKOM5K8V7x2xwtfuE
 OlD7u9UVoIvOalvSCSw==
X-Proofpoint-ORIG-GUID: h2AUJXiJZUzJe3EgN6USF6Paj4rtiXHf
X-Authority-Analysis: v=2.4 cv=eOUjSnp1 c=1 sm=1 tr=0 ts=6a712df0 cx=c_pps
 a=0CcWBAfodXOgQTORYPtXqQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=P7QV38PIZAIlP8tCo1MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX1mKboEPdi+f9
 OFPyCzD0BBankEUcygMSaTHgJuc6QZEakVxR9Lot2iJdsAT/T8fqsTblHqAF9cGiZ3f7ARzjOD1
 aPDJkku+L9Coe6nhrQehfkzrigyfDkg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=k151tGCnKd3adyLxZ1DjnN4jlh30h1UoLCp2OZfyr
 P0=; b=Tr7ZQnsOvRehJ2DpFbthW37wMa9YduQOQrVwLss4E/b9xoFKpm8hoYlsv
 8B19TNXsB3rxen2/z2/dvnfylD4ZnJbo6s0ZjuIyFlz4e/mkgWqFNUYgPL6DH34H
 aRKJyE3y+o/w4aYDPeJBzXtbiGStSDp80X6OCD0whykjuy2iS0H5jTWrj1LkHZ1H
 pWs34ypVSstEbqrleJ69O3R2+2CXIqaFY1lcKjpZ+7g6F1XkMsDh4HmsHHzBkiQp
 MEO8gAKlyc5MtV1TzBRtamtCgnaZ1SRxvX4HrhdiKDisOHgO+X5bV5yoaMr69V3t
 07GbZXgI5YcYgGYwP1+6Y8JtCXVyQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k151tGCnKd3adyLxZ1DjnN4jlh30h1UoLCp2OZfyrP0=;
 b=jlGoP07I1XRSXj//P7fyHApS2abNlsWRrOoB+A1aBYaeEbRGy6x9m78LjM2uGUITGrrKkdd4o6vIDVUHlQH+I6HbG4/FofdM+hR/BUfChcZzvd+NtQoCQBdM3ZwXEWFx5KMg/2LLTzG6M9rUpENWAm8G1M1BfA/4xCuZMzgo83s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Tr7ZQnsO; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=jlGoP07I
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

OpenOCD has moved where it has placed the tcl scripts for TI's reference
boards. Update their paths to the new locations.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Kept warning about which versions of OpenOCD have the tcl scripts
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 doc/board/ti/am6254atl_sk.rst |  2 +-
 doc/board/ti/am62ax_sk.rst    |  2 +-
 doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
 doc/board/ti/am62px_sk.rst    | 12 +++++-------
 doc/board/ti/am62x_sk.rst     |  2 +-
 doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
 doc/board/ti/am65x_evm.rst    |  2 +-
 doc/board/ti/j7200_evm.rst    |  2 +-
 doc/board/ti/j721e_evm.rst    |  2 +-
 doc/board/ti/j722s_evm.rst    |  2 +-
 doc/board/ti/j784s4_evm.rst   |  2 +-
 11 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 18a3520b39c7..0df058aee157 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -305,4 +305,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 3453ed339e7f..b04bfc991ea0 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -435,4 +435,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
index 0d12e3ec1476..88071b3e69d9 100644
--- a/doc/board/ti/am62dx_evm.rst
+++ b/doc/board/ti/am62dx_evm.rst
@@ -237,10 +237,6 @@ detailed setup information.
 
 .. warning::
 
-  **AM62A**: OpenOCD support since August 2023 (git master)
-
-  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
-
   Until the next stable release of OpenOCD is available in your development
   environment's distribution, it might be necessary to build OpenOCD `from the
   source <https://github.com/openocd-org/openocd>`_.
@@ -253,4 +249,9 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti/am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
+
+.. note::
+
+   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
+   same core architecture.
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 44dae4afc870..9d8b5ebf38fb 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -331,13 +331,11 @@ detailed setup information.
 
 .. warning::
 
-  **OpenOCD support after**: v0.12.0
+   **OpenOCD support after**: v0.12.0
 
-  While support for the entire K3 generation including the am62xxx
-  extended family was added before v0.12.0, the tcl scripts for the
-  am62px have been accepted and will be available in the next release of
-  OpenOCD. It may be necessary to build OpenOCD from source depending on
-  the version your distribution has packaged.
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necissary to build OpenOCD `from the
+   source <https://github.com/openocd-org/open ocd>`_.
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
@@ -347,4 +345,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62pevm.cfg
+   openocd -f board/ti/am62pevm.cfg
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index ef9425035cb8..2e4923f7a7a1 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -867,4 +867,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528c..6f02a1eef883 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
 
   For SW2 and SW3, the switch state in the "ON" position = 1.
   Boot bits on SK is reversed bits to the bootmode signals
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+   **OpenOCD support after**: v0.12.0
+
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necissary to build OpenOCD `from the
+   source <https://github.com/openocd-org/open ocd>`_.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am642evm.cfg
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 73ceef2e531c..5f75c01ec65a 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -321,4 +321,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am654evm.cfg
+   openocd -f board/ti/am654evm.cfg
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff83547..e5c29c2bbb7b 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -232,4 +232,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j7200evm.cfg
+   openocd -f board/ti/j7200evm.cfg
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8d..c3f3736e625a 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j721eevm.cfg
+   openocd -f board/ti/j721evm.cfg
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 4b5cf0275940..3d11271613c7 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -255,4 +255,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_j722sevm.cfg
+   openocd -f board/ti/j722sevm.cfg
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab908..54b4b6031f0c 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -663,4 +663,4 @@ following.
 
 .. prompt:: bash
 
-  openocd -f board/ti_j784s4evm.cfg
+   openocd -f board/ti/j784s4evm.cfg

-- 
2.54.0

