Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F189606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v0cNe3UL;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zom/tkB8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FCCA607ED;
	Tue, 20 Oct 2026 13:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHFvyjzsrvnC; Tue, 20 Oct 2026 13:45:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C620C6082A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792503957;
	b=LFPtd8Tl7PpIrG5ENPnh9M7wWcGsdXlSZJZZ688Ki+CLIf4xLmNphAsn0c0TI8Q1k2mL
	 WxrILt4oFQ1rDRxCQ20HqxgUJX3cAoXWlS/dP646hdle4wi8bznI6ot9ksXqTsFa4/1Vp
	 wUKh8w/qA9nDezVH692Mjyca8GNhQi0UrVCj+KB2YhUFOYcM478YQyNuMJBJzCFNFRNB0
	 ctta0FZ2vVLnFG42F8MMKTI7CJxGZzZb4q2SzN8dyX4mWs3V1Y2Y3gxqMnT3187tEzECB
	 y1SMgariXz4IG6geJZZPps/s+8N3zRAux4cU6EhLV2iKxKQ0DS5Ma6oaj68Fga346wQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503957;
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
	bh=U8f0qkiWA/Z2FJqVOB971JGSOHZaY27ol06AuWqFiSM=;
	b=fN/aE2DT78Pp0G9QuTEYbBldARhyH8N/rSpStwPRAkXfJGldOud8spzyJq8SP8YbPXjt
	 T5O6DceBPuKhHR0MGy4GJbOJRXWBlMMFDRCC/QXszz6lhoZp+hlieY7MhMQg4YOJP/B1Z
	 T2vlGdlfYpmB0OQ1mcH5MvuiILGW2UdLWBKrxbDzK9k/28nkOFuOp3ySWqYfzjfVYd6po
	 PEnHZknv9MJnGaDLq0FPHkq17QsLF0cwYcw1+YfBPSm0zYwyb92mwWo25BPyGZauartz6
	 l23g6PklTjUyUts3AlbuGIWcSBPrbBoHatvl8tIMfTtz83jMl6FIEg9KZdMNV+sjNcA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792503956;
	bh=U8f0qkiWA/Z2FJqVOB971JGSOHZaY27ol06AuWqFiSM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v0cNe3ULnoxdHWO/rF2tNG+BeHmgOu84m8rYi2BUx0tOSKTvQF2igL6OpvXnoZAfV
	 OFZnbsleEzuLlOuVdOHhn7QShs+e/V2kIqPYhmCUjb5levYioFX2J0V3acyTK2mYTc
	 msmRrWYWnay5TSPmFpUyStevmz1xhdJBaPs4sbxkEFBVUpZtLeslXytNigLkLvKG/c
	 y6Vv/ppzhpdzIK+xs9v3uZCtnSB/pjp10zA5bRePLEPEry7FFxROJqqwiwH3+/RYJF
	 B/O7sVo5uS/Q7WiM4KKd7KW456zylJO+gA+SDKtLLqK9KCZDfRD7EwXLb0HuCay7KO
	 CSOu2Fx1Wiz4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C620C6082A;
	Tue, 20 Oct 2026 13:45:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DA54255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F4BD80E44
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0BqXnOkoPbh for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A066C80E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.62.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792503954;
 b=GoPun92/VEl+VYpXrKMqP5IkRokWN9mvKevqB6L8ctmklFNPxk2T7DSyqqhgUpA9MfUP
 NcBtu4Ny0zKjBQP9gGn6QaYK6x+8989RiQFyNnjyCHVt8vSeUJXwoScGIqR4lUI88xvUj
 7EdcKQga+XeDW6xIkNqN19lfcMIfRr6PpjwVzMpflyjQWeJ8cMHPW1JUxy2svUtquo1IF
 hdalGinrf3FJauQVS2j51xzloMQaFhl1SeuP5GL6084wYoMH4+NI2W13WCnzAhmeveVK6
 m/6adWO3GAlr12lcImSKV9ZiKxwRZqOmcpiHxruoxYx7T8rETLZ/t3bLlq5qIbxw5lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792503954;
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
 bh=U8f0qkiWA/Z2FJqVOB971JGSOHZaY27ol06AuWqFiSM=;
 b=N3G86FxIPKR6JBZ7/z81uxVw2G9NQ0DaeH3LwUXqIe7mbGD5afKXV45tC/8W3/38+uk7
 z7MimOpV2RB2aXRlliDfxO6Dz1Sdl/wnm482OpoFMInlURweoFPTjTl54vXX3ckArfhrv
 tJwkFgnmUbFaTFW1l1wbUtHhvVXJFATx8bvGWPjfgw9i/MxVn+K6gcwISOguvawuHOApB
 cNoj97pZXzQREKFtdpgubLVSpEp5ai1JjHIyS+i1ER0OGmru2GVK7L+Hw5kNplMkKlRhg
 ShSokWwCTHVN537dQnjMnbqnX9l38QSSLle618TdWZrc0byMsyG++oUlDFhqCmE7w9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="Zom/tkB8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.62.11;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Zom/tkB8
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A066C80E3E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNrBLZeD0mphKfcL4RlDm+8AB66fMH1a+UaX6ai+SEiov9bp0ZfwcwPSugJShDV7LMma51N7ZhWZN37x3yD0V6iahLlxUFBgMBsT61bA8Ev1k67LDJppv1wqWcQ/+7ahX04TK/PwJj5piooParKBwqw3n5avSK7FBDfxtoHDWyldEPob3/gnZKx2duSUlSlCdvjWc+Xvt2j37hSgP67TCMuyDNRcehZdgmPh7JS2EZuHjWNc2aZ80KLifdhnaymQajcEfYrUienRBFzfTx0TmtxbdlsTnC9T0C3+ILt6oS9FR1EzZmOc32qxR8CtX1GefnB+LqDasE2Pd62xTHofQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8f0qkiWA/Z2FJqVOB971JGSOHZaY27ol06AuWqFiSM=;
 b=BKDKvaFjEFxFzR5oJOcw8MlkFpSV5Bu+qkKnJsar4C1pBLIE8IEovVo7E5AUytIMRebzPbXkOTkwSgakEhmsA2so+4WnqnrLy3w3FuU7WpRAodu0RgcTEOQFGBH7jKvIBWiqe8nkdL4zQjQTGGwgqrQnWSclvncz1aMACOFVSDkPD6aV0kSxLU1VTHjCZ0HqecihfggSc7E1ZOxX1YUYeJlJ9r93GlwH+SrxVqsrRY8juzd28Lqe6TbeX8EJ49K/DR9V+yYOZ5+aDKRPSlrdmoD/Si/kviTICetCAyiGQsI9E/Y+Jc8nXdwihBbmiC9Zok7HrxIbfS0tCu4f1wRG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8f0qkiWA/Z2FJqVOB971JGSOHZaY27ol06AuWqFiSM=;
 b=Zom/tkB8eIJGD1OPqj05CWUY82t6Tja/Cfe5qDDJFfOxCvI1IlXjrtICrjy7NfBs/WHL86hlYsCDm/YlAzjqOKtrjnkd+YhVTbDCqkwRzZCmr8lPsV9jBM4CpvITLbJz2nbf85MtCeb/L9SC0Y91t8Z5V9DiufRS8mbOLDPrM84=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Tue, 20 Oct
 2026 13:45:00 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8e) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Tue,
 20 Oct 2026 13:45:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 13:44:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:44:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:44:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:44:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Akshay Belsare <akshay.belsare@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Peter Robinson <pbrobinson@gmail.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>, Sriram Sriram
 <sriramsriram@linux.microsoft.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] xilinx: fru: harden FRU parsing against malformed data
Date: Tue, 20 Oct 2026 15:44:45 +0200
Message-ID: <cover.1792503883.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=659; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wpgiiadUThbKr+QEBiwtQ/2LljY27qsfYJptPiSGCfc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL/CP27yec17/zxMd52sTmauZF8TWzVAx07zplOXCW
 RWu+fx3RykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzk9ydGhgXhCp63vuS/O3eJ
 iVnWd92x49amhk+jr1wveLbJuGZ3yXaG/66mq6oteSL/9i/8/Oyk8IvirFPx/T9CdXa+7eVmP69
 ozA0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: e45fd408-df58-4709-644f-08df2eb055b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261009223027099003|11063799006|260925021911599003|18002099003|10067099003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 1PnqVcnDEfEjQgI9NiGYGHiJFUdCAoGUpwzj+/xpH3w6T0PM8RpZuJtEP4HyPGp51jzkWX2CMsrL2D9PfINdzdT228QvIU82m/CUyZqXU04MJjJF/7VzaXLj1xxFeT6yUzDUsQyyOXFnsqhYBK7PnDeBxt+Sqg6+ok7u3qtkubmjZDL2WqDjuNftEKD7oJ33mXxGFUn0Oa6WenB6Gsvc0YyAMdt71PYY4neXsG+yHPEINpSjQIoOtQkK9sQiGGNzX/hZzVX1XbDiLFw3Df9IHqIr8IoMJCq9eAmL1M0OO+JBzOMPIJVuZHo51DYBxIzLH4RZ+WvcpT28DmSpqWodaAwvvkVU1bOfp40gz+cvm8hnjjBVCuDhpOgQ+EYwA3T3DqQAuvZtydPf0yNZ5dfKrWYAQZBbj8NRLZgoGOI5DJb3Tta/iqoqlLJexGIcde1rKMxhhzuneuVPy8Q8tSCAwVjqy/VHDed1NTSd6NOC2/cJ0PmYG9gVN8Z3nkRHFeqfqAmF+B6DCXR+k1XdoQ8eJqG6WukZlTIXnCsu1SU0JMVf2JbSaWfjZUujZOu5GbotBP7FwDbQhxxuFtXUMiv36jkmcuQMBB83XPN1/GU5ZRupf6ygcv9w1F7W2wrwOD1kRote5rolAnT4eZDaeK+J3xR97VpvWkotNPjRsDRuY/++9scioC4Ae1Zrb8WA5JsTn+qb81q4e/YkJbMfdCJUhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(11063799006)(260925021911599003)(18002099003)(10067099003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GGWGox1WwM1UR6et0S+Pbg5AvkOyXRLfTSiHd4/op3toWvmCRL+gLQMlaJ2+1Ym35073uabilkXPyOqN5eIwWMCIn0SN1MtADF840zPScgZuDjUHd1mYkugKNMlMq+dwa/iEpLLxbIadx0GsnKOeaWKzbbniiGh8SOi1rE0rmFk/J0Q5Dz/T50N0gdoVuzYJpYlsYimeuAaYUvTx0UNjYjFFRRLXMWh+WhONQYN1WxMFl3/6IYnyNpeJ4RMubCea53+j6I5TsQB5tj2I9YSDSP2CvmvQoK4Sbg889w8eDpYxfx5QFmXbmqpya9FEL3LYgGx8FrXC8GmP+ubOWWkIOgt6g3hDMgjIx4UzG6qGPL3QkOhg+ZdYL53yBZd/DmJlWyJBsKHsjU/7ttGBbMU7sYNDH0tZL9AHy/BhG1cbRXh25uC8bBiceiedvgthY0lX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:44:59.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45fd408-df58-4709-644f-08df2eb055b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

this series fixes out-of-bounds reads in FRU parsing when handling
malformed or corrupted FRU data.

Thanks,
Michal


Pranav Tilak (3):
  xilinx: fru: Add bounds checks when parsing FRU data
  xilinx: fru: Fix wrong argv index in do_fru_capture() addr check
  xilinx: fru: Use sizeof() for board header size

 board/xilinx/common/board.c   |   7 ++-
 board/xilinx/common/fru.c     |  14 +++--
 board/xilinx/common/fru.h     |   5 +-
 board/xilinx/common/fru_ops.c | 103 +++++++++++++++++++++++++++-------
 4 files changed, 102 insertions(+), 27 deletions(-)

---
base-commit: c859517f0606595da489b5762844292e28c948fa

-- 
2.43.0

