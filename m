Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0B9C5DF85
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB22260904;
	Tue, 18 Aug 2026 13:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3SflmIWYP7xP; Tue, 18 Aug 2026 13:06:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47D92608F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058386;
	bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BEP3Renadj12Pm8NUpCgeJ0VQWCGuAXLf0YHMi4uNaHfob9hrZh2+Iq+VhOp5IU+w
	 ShpeAbXmCwcN0HUwjvSrKWrwGy2/TXDK9RLhh63FDFnm5LWOrY6/voeO9ygRzFLpPB
	 lj5geM4IYGcF2ENlhT4nzYi6zSh3ek1N4DPPpO2WBptdOd2wrAzf6WJFtq47ndYUjq
	 a6SGh95nnIsPjjaY4sPa9XKXLol5mcV5J7o0N9GiF9B8HKSVe5XEPNhDm1UtZUd1Y5
	 KUudMAq52+VaDco+GOGIgQ0o9H4nEoMNBbiMTyESycG70ofjFl2DIC5caV3kF3SOxG
	 LtlHwDFUuh6pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47D92608F6;
	Tue, 18 Aug 2026 13:06:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76036282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73A0060878
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swovoH_ZwVCz for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:54:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4A261605CB
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A261605CB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hZvy+x4L; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=BW+XAf7S
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A261605CB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:18 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67IA6P4p3322538;
 Tue, 18 Aug 2026 06:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9Nsgm
 G4=; b=hZvy+x4L0fb8kz9wUWShZn8YaokJ33y5zRJgU4aTkddXfisguX75meVFv
 DQx77P2yRuOrSHnwk2Y/HIXZySVm8Jdvwb2/t+qRUhejpqZbFOIUh16QdZ4xVPrf
 EFUuceIcpj8fhGEO36Hoyd51Cp8RiHiUXcYANOM5ONQpegaErF/ooQwqvMrkDvx/
 7jrB/ZiGCiaZdmgqfZbYyJw2WbJIXfJHn5FRJfyVdwkZQ9rx3B7XLEgOL9vr5eSh
 YlbeXJWOUphmEYEih79/i6bcfvRUDPug0Eue12R8Q0ZMEiQhWbMtV6FboXoYLdXR
 cOjNuDHkVNWpkP4zXEbxcg931B3gQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g40dm7txk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:54:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr0eN4HfAnQOKHK1/srS7y/mjyhqVa4IgU9nt/VWUCHKSToRrBdL5X/Nzv2qj9hx/x1S4mZpAufA7Q6qd2wbJLNRWkdD37JGvXyuZXnrDmnZdinV/lOkKm9sY6669+1Vx8MDcsoG4cLqrHXCJqJY5EyCt64uwu/Bg1zZV8Mq7mK7DLs/1OQgcXflf77kxRyWirGRNgqhL5jJIoi/yrLTBmGmgi/lvCm3ikaEP4zaAium9VQs/Npv0Ouwi4eZQPOmRflHRCjOvS0yaZ0qg13Z8HYexbK+jGGtIu4lzZ6NreJ89DEatGceq808a4+5lKdMLyr6r5mEM3FG5Jgtp27ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=KFmqWDqldLJz4s7WCUmwSdu3zQivFj8NSiUWHxBjN4vMEgJ4GwYJ15RIKPM6JKEoATH7CykaK/c6rRgHlHGCcqF1fkNpGpmAjMhJgx3K9MWJckzBEpfl13YRaZXPBvqCsKfwdHPLQY1Ga7X5Fm5TtA/IuqcA/esKAP6jIJzDXAjOGQotwBYXtPWjo+c8JQMz2mou5EKyeh/XwdF5MHuYXOGJ6ASlH13Zgje2+E7swtDvTeNVa8S6xyVLkmR0KIYRLdT5v1IvfO5GWpdMZBAvI1cjCaHy84DcYaTv9X9pfosoDRmVQQob2HxloHDzLWfhOs4hkfmngI49/DI7x0cMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=BW+XAf7SZYFL2VnYDaiR1nld1yQEPVEkSyXYxTecIf77NaGNygzst9Ct0GCAnIus5AdONxsFLoZOKw3r96x281MMM1iCDc5Z/Lf/eelaxDLOFsIJ1avJ4X09+4esfN6IOq2SIW2qY79JQ4UPXO6PwG2GxRUEKU8AgJQJiDXX3EI=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 11:54:13 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::26) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 11:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 11:54:11 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:58 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 06:53:57 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IBrY3R1372974;
 Tue, 18 Aug 2026 06:53:56 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 2/3] arm: k3-binman: add tinospl.bin for direct U-Boot boot
Date: Tue, 18 Aug 2026 17:23:21 +0530
Message-ID: <20260818115322.101705-3-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818115322.101705-1-g-praveen@ti.com>
References: <20260818115322.101705-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH8PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: d52af1be-b329-4b51-dba7-08defd1f6b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MLn3mTEJJvZENu9nHdvqkWv6A6WHK5dbvfv1biHSk3IhcBAszIjiYHSljGfMDQ+Lm+x3loaQazKbs5dQ6hodwcHo8QIReZ6a/KvQ8wirrI8oxF/JSWosZac7uFFzYa1BLERMq5/0rF+DPbmB5h04cyM5AqvRWEWSmWIWq3GESigkW1PT2Z2jIvKOBeaSH2TrdWOJrp4pc/laALiuW6lGccK0PsBQCKyCrtHzdtnlXJGjOnRrHBSz7II/lCL9DYOE9e+VlLkjJVU6JZTSTXKreFjwww5d/bd8i+joIzrY2ft/u0QvWWiHbl0pg2TjIzRbfcLzStWZydA7w/DbGGzBAOkYcc72L57xYrxwhdqxBqZuXqnsj07RRrZNU0o/tPUSCpnQL0N25PPQ1V4uPmEROzOgWveIidodtm3zhqIoQGQmmMyJHHFOIxPHBnN+Paj2wEaDbkRljfut9OurDHiqZ3/X34KD/F0v6fj25uMXp4iVevjdR5Ji0TFp+SPN4aYIRlNJkSiyKkee7kMKFV29CrzZ6J2NNxVcjan0UVWL9mWSCdwvy+A942gyTuGobVTjbjq522XoKBwg0Aszl17VZxKalaFfHQurJ5n692ZMqDaPS1JXCT8G1bgXzBWRT941rK2spi32ooHEBx5mZBTVINYaMXPkStIZvjYrheUs6rQja4W/lsQi5IBFfYQjw3yeVlr/d+zaH+YdPclDViNQsg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b36OVA6Rc7mLomBFB1SNtugUXsIV6idZLJqiFnAU4PpqD9czP/bBpyWgmRRyWUAre/cPfQWks7+j2aH9v65aiw0c0Mlei806Evr3lh+3g9wyz+76FgKDXYMBcsurta3pGXoBJBLjuaLTIFmK8En6tgzJTdlTGGqCkVX4u7p/fF+MPRKyaQyHr5Y+DnPbQjlHpi4P7Nft36LJh7NUyEq5cHrDId+i1jjEodPHBJ5Ah6D+vU7S0o1yKUF5EueDn7ly3K4hSiNh09RkI/O3ioB5c0JHQ7qC3E5sfLt4Wk6JAKtDKkzHVGsG8F3ZQpAI5X8/8teBzeV+nOYOX+zSlSjGFUhzq+BqkcgDxXcZ1JLGvD7LFopUjiap0xAsgdkUun7PluR54MR0DPWYSWstXNN/JP5M5jPTKgO+pSA95Oxyh/hYxScDA7S1aD56AJ3N1171
X-Exchange-RoutingPolicyChecked: JEp7VnrgJ+1epp27VG7ptg+iOG61lub3/rKWLME0rQIvpNHC59Plwe4MrO3JvTce4fYXpxwl9UJkp/nTyVN2EHawyXzbOHPA+uwTEhqHf2iGDYAYPUp380zCIxFW4vZb9Z2DFfUmqi8Ssa0G80LnTsYcZ7/Czov3EbJOwp4vMK7oYBXuzhKJE+XDP3a5vsL2lRi7sBHaZiRDLhkAZiEiuB7o7oNt9V/8PEc6nnNlFjfuvrUH9hkKwFgKdpkN9lLRKTPYHwRkb2JLV7VXElGVMClcvWi61zfqM2QypfMN4u4qS6ppq7ftml3JcxGj7wZaELxdx7uj4H8lgzpaVjWubg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:54:11.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52af1be-b329-4b51-dba7-08defd1f6b61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfXyd5eatLOACg7
 ZQDq6DhGLOQPaW5y6cyS6oPfQhfjqRFGfWoHWpTSJR29h+dx7zZB+jnakiCwVS4tIpGMy37wBlJ
 aH7lTyowSnose2kvHh7A+VDPMEf4Y/Efyu6BUlL8F6ZKIJ7mJQtGQPi9ioAqLFDZGDrrPYUKEQD
 UQoOy9wWcqYc0/RNKmZAAPc8NIynKdDF0ZsPiusC4flICBZTvyullPBuWnzOLqy94/8yO0Z6uXi
 1URV0XWkEhLfq8DMpIVVuU3q5EwMp6+Nuulyx6xlCCIxCWNkv7PzmWceWGtCo9bJYkidSxU7ZFl
 nF73pChZ24ZH0uphcl/5Y9sUk+RRbsdwh+DzhqLUAydzSLf2hfkL+qBDwNnldGCDEu6hRrfBzRZ
 ac1sC0FwBwZQ/oBnn7QJrfGsGCBSH/LQkvGo/EyiasuPNUPq5lr3yJl9tOXBEJg/1YnW6g3pLTf
 kbOmPYcRYcDws+4U4Aw==
X-Authority-Analysis: v=2.4 cv=S8bpBosP c=1 sm=1 tr=0 ts=6a8447e8 cx=c_pps
 a=UjDdpJjQ9fE5FDPsVaFzsw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=d6pU8RGRqkria7-D748A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX+xMoYR6zqt1h
 tS8FKUbVBornCZCT1bUEdZiTlOgMGLou2jR43TwYIBonjzJKlEgxwNE7EPZDOBRmFuS6Yp99PL5
 XPO/fZ1Pk7hPIQv+pMD+JwthYMNeWkc=
X-Proofpoint-GUID: 64ivaWAcrCbkVppHWRATGTgscE-OuYXw
X-Proofpoint-ORIG-GUID: 64ivaWAcrCbkVppHWRATGTgscE-OuYXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

This patch adds creation of tinospl.bin for J784S4 EVM.

The contents are similar to the existing tispl.bin but the A72 SPL
and its FDT have been removed and replaced with U-Boot proper and its
FDT. This binary is used in a boot mode where R5 SPL directly loads
U-Boot, bypassing the A Core SPL stage.

This reduces boot time by eliminating the A Core SPL stage.

tispl.bin   = TFA + TEE + DM + A72 SPL + FDT(A72 SPL)
tinospl.bin = TFA + TEE + DM + U-Boot  + FDT(U-Boot)

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 Makefile                               |  2 +-
 arch/arm/dts/k3-binman.dtsi            | 47 +++++++++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     | 65 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 14 ++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6253670a94..c6723d63f59 100644
--- a/Makefile
+++ b/Makefile
@@ -2556,7 +2556,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw* tifalcon.bin
+	       imx9image* m33-oei-ddrfw* tifalcon.bin tinospl.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..aa8479bc0f6 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -543,6 +543,53 @@
 		};
 	};
 
+	ti_nospl_template: template-16 {
+		filename = "tinospl.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for no-SPL boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					tee-os {
+						filename = "tee-raw.bin";
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+			};
+		};
+	};
+
 };
 
 #endif
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..0dec4316d6b 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -317,4 +317,69 @@
 		};
 	};
 };
+
+&binman{
+	ti_nospl: template-17{
+		insert-template = <&ti_nospl_template>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+					};
+				};
+
+				uboot {
+					description = UBOOT_BOARD_DESCRIPTION;
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					ti-secure {
+						content = <&u_boot_nodtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+					u_boot_nodtb_nospl: blob-ext {
+						filename = "u-boot-nodtb.bin";
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&j784s4_evm_dtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+
+					j784s4_evm_dtb_nospl: blob-ext {
+						filename = "u-boot.dtb";
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "atf";
+					loadables = "tee", "dm", "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
 #endif
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index cc0b562d27e..fc6f23736ae 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -87,6 +87,20 @@
 	u-boot-unsigned {
 		insert-template = <&u_boot_unsigned>;
 	};
+
+	ti-nospl {
+		insert-template = <&ti_nospl>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
 };
 
 #endif
-- 
2.34.1

