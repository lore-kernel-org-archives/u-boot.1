Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA359606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kGiAT6GT;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yneIiefm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 945AD80DCE;
	Mon, 26 Oct 2026 08:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KO-osGj2IUVZ; Mon, 26 Oct 2026 08:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF08580E20
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002506;
	b=tKpm++LRgmcrWgqtk7h5KyWhbXeslihARRoXa9fQyZhYw9SDa68sMm3nfAMqk5qlubIv
	 dmAwtRduIzsO7AP8/i1zux5UQsAEg9jVnyWzQAVjGEsiKTPpnDwNjQRZAedJLimWevcFY
	 4aNDCTFNo8A9XjQmMspY/WG9rDUo8fI9EDQ9SoSlciCEqKY96Tyua01+RYoOfXOGyLLUc
	 nLA5e9V0P/Z+WI5wUpsKwuC89vkXy1+hH4G/847eYZndQRDLVf+WzgOOiEk10glX7k2E9
	 5JoW6zJsSmVuiRDGR2ccoBlLV5gKzUXuldmC+AaNL4h7WzN9z4jHQhPhdL43yNYUnaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002506;
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
	bh=O005SzyZMWAy+ABPG/cATbt7XwPNnUhsbTiHPic7TBI=;
	b=UblI4CC7LlsjYLTMXXmJ5DBPJMsgvMW5CieG3lUFuq+5kvEF+qU02PkfCykmECXWo8hg
	 p4P5ZHMMj8lu1Tawhpz8KJu8uHr08xEXrUg811Q/qZAZssAqBWkR/W94uB4wL+ObQW+ZE
	 FgXOdnzC0vIHEkZGYANn+QcGgPMJ9qKgr1io48j5jIJFCgsy17AdkDkldU7R0h/ZG4rCJ
	 8LiLhS6cb2o0GXeVcK3GXl2ELd6qAtp76p0p4hP+GfTibzKevrZHJvYOQ9g++Myg4AxTH
	 WVSymrqz+s9XknVmZAWBPjEZGjYQICwus2n0XHW+Wa9bzbLgEt7hkAV68X1ja3NS79w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002506;
	bh=O005SzyZMWAy+ABPG/cATbt7XwPNnUhsbTiHPic7TBI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGiAT6GTWSrnYiazGBXPKVcZZKh7nkFDgRmwL84X8gRraFjjvHIbyLHubSFzTZeyp
	 QUiYSc/Z+lfBaEMPn1MFdc1+uiydBxlwRiTJcD+e7HRjCmbkNu77d9OhLwlm9cjuK6
	 JYQt6Z9xoyMRWBu+p5345YBQqi60p3EPA3x2nUmGuZTCrWnv6ispQrnNFNIlIyaV8W
	 mdKf9wi5c+YwxJ7LoBhlfdWmj1pBo14BFMUOfJrmiWPhizAb/9yLk+SGMkgeAUbPCw
	 rbC+jTj7GSzNrH75CnEQ72jEJ0GlPPfg81XPJX6TVJNObjldCUPuF9SoHRLkZOoAh2
	 803EHsi0aMp9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF08580E20;
	Mon, 26 Oct 2026 08:15:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2168E334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07360606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cku3966Xa7VK for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A3B8606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002502;
 b=fX0N9uOSiryCFJGOU1eNXHwBVjWTXm5pkOJak13frV/3jXMsh2AZ2zdggVb/6zlOem+e
 Yzlx8wPoWx6f4/NsQJTslE/+/51JF9WgNMpt5ayLEydnyE7GOTh95fFkRxwIVwmTilGCn
 /e4cAtka0dK26CEt+HjMcNYRPnvzDoG3D/A6u89Jx9nps2WpTlz50nZ/i4aiP4GWWJ4yB
 yohUQKgR//E/vDE/qc2FiawZEa6K5wSxsc+eUYKDgaKc/9cZhYgjMKQ0E+axzeqyjQ+XW
 hUv6EFK9RNsc4r8aAfXYb4GMIm5Gz6kMqjg67j/tRBzu2SnGKN7oC8xJWafFLJu4OuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002502;
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
 bh=O005SzyZMWAy+ABPG/cATbt7XwPNnUhsbTiHPic7TBI=;
 b=iGk/i3uqzcpKD4HHdchpzUq8FoCA8R+/04JKCfzza8AFyQ1TFnOwJA8YYezMfW66+EWF
 suiPH+tLYL2V4EuD98EmAxaBZ6ciDL8iKYLMqRjeMgcHk5NTWw7f8dEtSb/fR/kHMBT6G
 +oDl9r1ZhI8jpmNl7F4/IeL1Pja+qpUSmVeN+vkP2StGOlFl8ulCKrJG4eE1IzYszda74
 cHYeiCdNhOZ95i8BeVQL9W5SIklpF+N14eXZAilazHfCBwaXCW+kb773QKXfqkWR0TZhA
 4hP0OT3aheLyhZsShgNwtYZ/Se1Idz/CP4GyrzZrfHluWD5MZ45hRVZsPhYVRWDOFUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yneIiefm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yneIiefm
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A3B8606F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAFT10mNhj4lYhAGZh8Pe4V84l6Xt5jQJNfrB+XRPxActtOx09ptZUye8JJTVQGEZoarI5dgEEbBoPLoKdqA7TdtZ1PJ1DHqTP6SY568KFfLY8bqwnajMvQ5vCOLXm7w/NkzxtXlOhY6XsNbWIlXQge2dIkYeRkVH8GKidzOZlQFLNHBfpH5WpbohgBoqcVnXfcPwUcrRmvqlsBqMP7uB0U4McrXrNODMTgXjd/JerS47hT2li4E7zV91BdVI4gmuLxi4c1i4vZvffIrWMvQablPu7nsgfCEv0+e0oVyP9oFGjFpX+d9zPLjE2dDTIHGhHu2+CqRZRth3+/o6+x6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O005SzyZMWAy+ABPG/cATbt7XwPNnUhsbTiHPic7TBI=;
 b=AfKQDOdnN0lMthXERK1kTYkTnrMDrSe4tBWyLt2Lrb/i1aJoLm8duDoGgzyOTI8MqQol6TuV1dZZMdpsG2RwOzHoQEYXx+nM78kMWZkmRH3UyG6/uLDgDqdgTr2MOBm5e1pMQU9v+hyq05kY92JNKXz3PBfog05FXk0YoqhjP+36OJ20zjli+uHF5XmfeDSSIEO7cqgTyNgGaTnqwczvnHIBWkGATY1P+BOVuVniLCbdjyqLB4CTWQT9zVHEEDdan/gUC+PsIaUI7fsgA+mW9SuOS/aigAYv/FvHgoiDLMKUm58jZmy7KiZNugJukbDLcVf0RuTp5x5CS7YJ9H5tNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O005SzyZMWAy+ABPG/cATbt7XwPNnUhsbTiHPic7TBI=;
 b=yneIiefmehxmaJRFn8uB2543DW7LB+DGXapSzTHbBokxbt/sBtWYw4E2AFR9P1oO7TDDYYrsFJP2va/x7WieTJM1ZcsF680jEOBqaEEwJbv6NU7pfNnrf3oILlvFnZ/bbVkWu8KDB5naweisXEWNxcvOMLL79agUKmlfd6ENkhM=
Received: from SCYP215CA0078.LAMP215.PROD.OUTLOOK.COM (2603:10d6:300:149::14)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:57 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10d6:300:149:cafe::aa) by SCYP215CA0078.outlook.office365.com
 (2603:10d6:300:149::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:14:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:54 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/11] xilinx: mbv: Enable MTD command by default
Date: Mon, 26 Oct 2026 09:13:52 +0100
Message-ID: <c095abc8a8ba15c4eb19e6fe8d1fc8be7d6b6b9e.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=625; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pAUjeSO2zvnFWNjSqtKIXtisRQkMAWOGkwZbmpZIzXs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z4adbjUwtQmZpcm97cl4bX3Sg8rdj2/3VPcGC/28
 tDOOf0XOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi37MZGbYsjfO+dClR8eaP
 zMrHB97cXLjLYL3hx3cF9gL/3b+cjchg+F+3m7Ei/YN5qtPVPnnmW+xXDrzIysu/1rjN+vfprx0
 stfwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b85a8f-1169-4d87-e1f5-08df33393804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q7D1OqzoYhQx2KUcZ50McHoiAnT3kWtctgO0qaJ9p3yupjLj8e5VGFpnR19vf5n1X3Kfha4KCEYwo0ivvAk1csLnp5e8wAw/s1a8WveQ5TUBE5LKeWX026cZ3nvKczVRzJPKv4ZftGAKVry+UgaQ/r4CWq33nTuEgbswrUNs/WfMpNARvFEIoSiDAz0ttLmyQiDbguuby3wWDQKExtxnjQ4LsvyQlitJP2ecyfe5wBQluaHYt4+mJkDpROWYqZP6ijXTCzYCWNb8DCtGtU5sMiMH16qymtYVpdoqNrSwbJiENvv3Ez7RBNM4tMTgXoz77E8KQIQ8ZIcjJvVGLhdcupGVSR4itwT106ujj/c6nUoCXz4ITTLUPKQbko4rL/Z6K3ZbyUQHudQmrh9cfX0YjOU1p0LlqNN24HZa/ilc6ExE5v740HCEyMGRiJQC5m+SC1Ke64Mk2RP+fETBFQgelfmuRWVXZ/5JkhRzLkEcs6/iA7VXV5VpDok8n+Fi6FkxNF4vsqvIR1cbEK1HSn8vC6YHmrw9zkNiJQqqvuXFwBSvixZvnQFbB/vo4fKYqPPCsZkBWTxjS2LotdT5xrZrfqysfbfM1Uqbhp/ODribLrFqbQxrqP8CwGyreWS5K7apnCvLk/IG6MejL9Xvgwi5HStHjjN77gSzbQtCTLXzVoS12aC+auoudug6pxvV7w898XlcEVR27NmHmI0N8lvj+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b6Vdk+sk5NzJOBta8I/Zx6eETXEIWEZcJniAHnwiLlzUbcGQrGuazCh/3DXZb0zc8Pa3WkbHiSf0zevKB/prBHjf29C72BzyGfSwVuYcfYnUQsR+0Q1W+qQi1MoIgXSi0vMb+fP0ZSymTErGVY1+LilhQXjItKBt8jPlx7QBhHtHK5tWsPdE7/J1obx+68RmXbJY+qDrSFR3luPqweTI021+m8X+BoCwXPHHCHqielYgQ4ZaMX42VaGULSzbUE8aLH34yDbVf3sWoOujkuXBzj50fvelBFENf7Hlx6X7HW66QzCX5kIsGKGM1879O0v227VVF5R9FzMU+3ymgK7CLxLoKrVy2GrrvImkMu0nmY/f94IVj//B2minPylrfLaGCkgbcuJitIe0SgY5Uqz5woeEZ4SyIWfoFaMQr8yUB5EasDtjXmkGG/PbIa9mFP/e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:55.5458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b85a8f-1169-4d87-e1f5-08df33393804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

Enable MTD command to be able to handle MTD layouts.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 712194c6b433..ac329ec65768 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_REMAKE_ELF=y
 CONFIG_SYS_PROMPT="mbv32> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_EXCEPTION=y
 CONFIG_CMD_TIMER=y
-- 
2.43.0

