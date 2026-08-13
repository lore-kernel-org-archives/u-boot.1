Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD30CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 766FC40834;
	Thu, 13 Aug 2026 07:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hpqOKC949vls; Thu, 13 Aug 2026 07:23:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7E964083D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605823;
	bh=t2C6z4QrJLid5igUDB6RysUu/u4KzQn7mp9GdWSSZSk=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zBGlvZWE57NKL0sK8UwaG1cae0aNIsnzgWRT9wsobBSNFpwakYOeOVUZnHxQpb5YG
	 aOGAF5GF2dx838Aqx0nncyBjfS8bYp41kqKWBRlnEBfFtLYRk1cvi95xOC3bFvZHhz
	 rtPsfOLrCHyrGWJcTH8SiF/96V0z7zV3ZI4BjXMRZMx19kLQ4d0w5m10RxEymmkM/g
	 /bXfT85VXVdYg5pENezzna5xVtwDtxdjJe0Q51j+v9t+2S9YPLdGvKsXhtdC1AzsJV
	 R58HpCH9YDd+Lv1UNZ8OQUpaEI4vy1s6CiAGK4UZg2QP3ZhVdSatS2vh+jYSQQ/5T8
	 Yoyi5bOaK0tWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E964083D;
	Thu, 13 Aug 2026 07:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7777E109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 695A74083D
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKnhWnf-TJrZ for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:23:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9080640834
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9080640834
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9080640834
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiHeIZTLMw5sBq4bhapa1NZNZ9HkCoOdfOSw13f3GRlu1D1HIk596VGB8IrHycI6NC4/F3I5ZeILtMmEzeG2i4GxvQdIDl6wKdEeQjJa0wGFydtRFNcdw2rObSBdTUwNQKXfQ//IeefgHag5iEBIUCtDloHS82bcHO096OiRqQ6UV4IpYkdn4509kKgQw7CIgdpvfE1C/AlrpoU87FqUI/OglqNK66JAZgkgVmUtOOygxYl3L+d2ifR0RF9IjW2f6wjVyWK50zCbsEGzYX6O77gwFdDUnvMINJgQmxDL0zzd54xBzfhWhkETobnSb8rU2ccpjpswMJ81TYXaZD6hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2C6z4QrJLid5igUDB6RysUu/u4KzQn7mp9GdWSSZSk=;
 b=FZ3PeKEtZEviePABW+f9oqaxofCJYpDzUQAzGrBJw4BSIhft9wf9OK7xgkXVvY3oYY8SbGYeiATAAXk9hpImcGPVKcFe+ZRRHSW5jn1qIBYMQzCGolWKPQqQTQob7BpUMACmeohNcgTQVI4yPLnBYWACYKaha2gsTjefrWC3e4ATQCAgXgoycavxsHwYztJYjTwdSkl5C//sJhLME/WnZvDvgva+iZtQQ23xTFEgZyr2XCgOg3XHifTVLjVx16uuiUKhxvcvy/VY5gB5FIGH8FIgfu5tsacai4byLsq+vWS1HhzHUD6odd4ve/tTDjUvjBaUpQvDyhAo+/OfxVjw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CY5PR22CA0019.namprd22.prod.outlook.com (2603:10b6:930:16::26)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 07:23:37 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::ae) by CY5PR22CA0019.outlook.office365.com
 (2603:10b6:930:16::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 07:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 07:23:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:23:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:23:35 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:23:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Marek Vasut
 <marex@denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] MAINTAINERS: Clean up AMD/Xilinx fragments
Date: Thu, 13 Aug 2026 09:23:21 +0200
Message-ID: <cover.1786605799.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=600; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/Ha95/T15wxR5vdTPzlZ00kxVWpVj/2SOeWvsBBYySk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTVFnzmd4mrXfv4yvPPGj9D2Q3P2k09n3zdc6fwdV5HW
 yMeiZp5HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARrXxGhslXmP23f/qWrHhN
 9sNu1WUazD8mr+rx3HZDel73pQ6mg/kM/4Nf/jwmbydQaWRQ8UKxSGbS0S3x/evnXjhjL/nyfXP
 SfGYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1c02ee-c594-4754-7af0-08def90bca7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: VVVJosL3qC3DpTEetRSD0+iHwSfE6Dl9bFfUFnik4ZYPrsC8uvKYZwkvGOqcc5eGdOKff7B+1tQsZd7SPi95UVDXO8OZfMpDz3AfQCltk/AucQwi+ulvQfGzDQgsp6jA5/xZY96LupSRuM4Rs/tPQ9/qWAwXIpfYEv8hCTPYnFtvRIp6XLtr759TUnZ+yMDebFSL+NJyFBJq/wYDbdco2crYHhRMB50fKUtzAHp9rHg8KeLmJD2Qp88jZJsNOEFhKiiYh19CtVbk4fM4Uxub2Ad4ByCEEPxHdDo4YREMqNNnazJu9I6NRgjDuWxqh4VP2Izp0Fy/pNp8QoCyuI+IIvvcOXIVaMeGnv9cIvJfKjCtKAKJVCt4q4aJDIpaA+NwmwE4VAKfKJnLCgvcrCS0zigTeUkbHDj4FwZjBZ8osK/A4vTwk7hYM+EabsbFgIuLXKXXoKhAxniHq5pFqDBs7Xw6+bSSZdXVvTZTSvXgORPZBsSFiwd8xMsllnlehYS/EdPKoj432AfsSt/n+Vh981gki71hsomryOCuXgDN82ZoURBlj4XbKPW84ocLn8cZF1Tj0u3uSsZxtkST1aDbe2rhxtzobXcqRzoPMfzOn96FzbFWK3fVz6kdk46tsAZ5wnxwTkKwqXT3tnQIDpS171GymZr0RXwbZXKMNCueqTgasSPDA+vD90fmKmpq7mDE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ydjNxBWLwrtyBpTPWkR1qqzMykMNC5DoaWj4CPxnwHIzVTDMIM5gzOrpP3T5IYadD4/1H0HwnCI4jjTW90RJN07sglUWJuI33K9qf8udynAPqjCSj96awXVGYUGvRvXzvCbsDQdLp/ci4kwsa9oVXRhhXAmSy+KhOAOGX5OQ9WKZOzeda0oHeumWh6D23Wqmq+VcDhA2/Nq+Sx/zNYYP7fd5LUNd2B6upxqwRfeIoiC9HYRWMW8IypDrl4M+q+JN++0wYblMPGD1YhcL2BllW+GlCoen8GbxLZ/H2rJ7rnQl814fVK4D/2OcjEJXpHn31+dDIrJh+qihAK3O+HFGkAFxyTrS842VngUS1Gh/wfTVI2o3TGD6D0wr8dd52h6Mh9qCunhoPT9O7X5plObTRgHU6RtqULgiNe8YqbPtG8MVGGwH2QTInbqT48f4ld2u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:23:36.9361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1c02ee-c594-4754-7af0-08def90bca7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2C6z4QrJLid5igUDB6RysUu/u4KzQn7mp9GdWSSZSk=;
 b=R7HRukLi1dss5Mof2bSFvLi8o3GDBe4niHZ4Y7psmeZePU5+DN+WYN8k7bqHZdnQ/aAsZ6qXgi7Z/9RDXmMAYP9QiUQ9R+SXQzfPIwKydWwHA2sG+Dx83Qolsqlm6ukFyFcib553cHaBX5DKVy/2XYiIZ5Lcg4MI5uFIOMxZQaQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R7HRukLi
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

Hi,

based on my discussion with Marek I have looked at my fragments and put
together ARM SOC to have only one entry instead of more. Also found that
move to u-boot-amd is not covered that's why also created one patch to fix
it.

Thanks,
Michal


Michal Simek (2):
  MAINTAINERS: Move u-boot-microblaze to u-boot-amd
  MAINTAINERS: Put together AMD/XILINX platforms to one fragment

 MAINTAINERS | 74 +++++++++++++++--------------------------------------
 1 file changed, 21 insertions(+), 53 deletions(-)

---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b

-- 
2.43.0

