Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A12CC6B19
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436E280CEC;
	Wed, 14 Oct 2026 04:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4Byzcw3hffl; Wed, 14 Oct 2026 04:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8525E80D07
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791952357;
	b=k8abc53Ing1M4zB5vxDB0fqCod263HSZYk9vtH8tyhZedhIlXuluZtVf14YksHZtnWAR
	 28qVFEe61xJ8Z8NfG1qUKnD+ZvFBJfgqP6LLmPg2Mwd7Sb05C6R+uXP9yPVOqAbnnIogB
	 L3cisgC7/Qe4SqB3TDbAHL267hf3pNVAEyPVgLQ+eASlVK/mIkvuCZ1I1ML6pNniXWIlw
	 9Lhi/z3AtITEcGdvSrMSF6vIW5fQvBlun7tkwnpwZbrCOWxDwyZ97TWH+d4YbDPKvpg7M
	 Sno4XgRNiv1JqccZaX+LcJ3BDGJsv8F/+FITzd5x7QINgOQsplEnAZiMLkktpj3l6FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791952357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:DKIM-Signature:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5+KOYs+dMblR3OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=;
	b=LiXMxTqFCsqVPO7aONiaURLusyKaqF9MveFBcvwkwu0DnCjK2e0P66e87ksJa6KuIns8
	 EPXKrLKh9YUgi+PNhuqrbp8Z0l6JNfLmdSTE+9Cw1u6ZGDqennywbgpku17owEkzkGjZ9
	 EwHTcwdu6HPIBfAjdjUU0AdokmMJloZhtHd67ZpL+5YhLmoy4iZPeTEK1sex0GrXET9IP
	 9cS5EzauqMBywDUVQGRZSP7I9BmU5BqJZ3wCxRS/onY5kucDDpUuPECW9VmQ/2nhifjhy
	 91iScr/VE/54WBUvcFkDxDYy/HFpByx93/ubVQ4xyatCOK9t2AOZC55b3jEsUMeM2NA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791952357;
	bh=5+KOYs+dMblR3OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xw1MBsohaODuoT3C/XA64cO6UU1TiA20/hOn7AR+jxWbH3hmWZjsfUwlh5Mw5GiKu
	 LejdV8o4aKq0ZNhUQzs6PGF0nhsCRMeB7inNn6MKqCUb0omxgq3KB23zM9ZmWQtd6x
	 4jq/POhGWVuht46StxJmgD4cayBpZgdVDsi/EXwtGe1nMTzZAHAINl+mXbnIpmxwdb
	 WoSMp0TVB09fBadE8mvw20iO6tbzC5iXxdXN4Lor3B6dl0V7vlC7KeH36ovcD3liEF
	 xbQW12SrJEPVfSgnzllxrnCpFkJM+506GjdWLPx3l4SzCtjczFuZ95bQLOyvB5UGxh
	 lLwJTfFwZU5hQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8525E80D07;
	Wed, 14 Oct 2026 04:32:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F3D52AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1151F607CB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pg70Wa_mlvaK for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 04:32:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0BB3605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791952355;
 b=T1hEHkkzOIQaxUPzlAAWAwYIY52fm6kOi1IFN53abWG01bzNtgxssSnoKLbB5OKKsYvN
 Uc1W/gVq9S6QwkZXEGUwp9XB+xlmKXa80ZcrhQvxrE8dxyKEHDsRVGAk90EPI5AoXcqEM
 FuwqBNHAFHUoMbBiJLLi2Eo0mb8Z4PY2xvRII1YQejdBANH6F4U6rgeCE1JRwWFWl8KKW
 vpn9nkQFzHScosYCol1Vh7XhJwX3cWlS5TDFF0TGadqDV5mayf6HLBS9AwUBxpiQ1gxPG
 AHcIaoQ065e40+u1OmdZYtgHKIt3XJyENUI5bySJ+OYBs7ZHH3cxJo4vET0sf1xnb7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791952355;
 h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5+KOYs+dMblR3OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=;
 b=WMRA4yzPx0I70mNSj93O8p25v3BsMZQOXB+HJ2dgxmpYbpObXBqeaoUNgKs0SGa5VYAP
 XPs1hl1c7bleMCRt4N2+un9CmRzBf6MUaiJc+R4lnjegp5Hae7SnjU7laT/r2El4wZwvD
 qKDwDh59oJU5TwVYA8VI1K7/NLIioiOogitY22AztDhcTj4y+BjGFwC2hbxE2SfSZ7o26
 T4rThTtkzbzi83ji1lEvFImVtMAuTBboXPw3r3AasWFeY7v54BIHLperqbGus/41wfus9
 ePLArQ0TnTGDYz9kejwJapHNNeYC6l7iVjRs9CJcdrVbxawaf1i+ejZCjPzEcxHYvIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nq76x2da; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=TtAvu8zg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0BB3605DA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:27:53 +0000 (UTC)
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nq76x2da; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=TtAvu8zg
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69E1Q25C2155418;
 Tue, 13 Oct 2026 23:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=5+KOYs+dMblR3
 OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=; b=nq76x2da2Ec9Uc2wIjhHeRDUhAEHd
 RghR4m4dVevahQEid+IrHErPbBFnWDOFyBPXnw3jNc6L3AmReMpRoHcKrSVAXPgY
 Id/aXjOEadN/ZIJLzvG6w+UEnMINKJqtx5KlW0RoP0th5WLGhc8Lu9CAL2JzSoXg
 j4XLBx2yLtRRj4/beANpU4LHYWMeMAoqaDvpdtLI6T3H55h8YEig9ZjKHnmqvbRy
 Dl0ioYztLPUXOcBUHBnKc2Vu1qrzFfVPDoFEPQsxRQNjVvsRhUD21+kkAwyvf3+5
 cpbJStvzyRIfaVsLqR68RbYuTddUWr3ehMrfh8bbMc7xgeshOjjqXfXMA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ha02r8uu5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 23:27:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVuk7ikJ/UIqSivnv305Myu3Ammcz1ZBBUXNQZ8HgKFr9DUlJyB7a6Jlhw5P0hPruBelhYZ69bUGbF5ODAXMYM1eyk58PBTMgsXikFFQ/hDBuKjkTAx/W0LhG33c+tThB/1W+NRI4LdJfWf6x09uuPAj2CRd0NwrX9SXmreTLJnTc3IDZxelxTkDcAJMpi5OlxSQIf4V5wmJqPuVGvZFWB8mx5xKux85i9IhbDnfiHgCJo6XcpzNcyDBNl55uYQbsS/xamlXrj2oP0ptnZ9EWPttAuTpnAKPwEtYAXEVS36NP3mCnpvLhUne4vfmgJEPrpQTDX68XIg8bgIWJNdvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+KOYs+dMblR3OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=;
 b=x83W343cNbaJ9RmrciuOvaXgkLIJajDqG2N59h/ZODd/XqtkH9qO4KHSfUuOzOGRx1iS2MbNwyFsCs20KxztTXAyqPXJybPmJFa9RdOjejIaqJHFaPxL0j29dhiX2pz1KW4waV1SsTaKyTNMFzlRNqaaN1rIG/YuGYZ4sApl/xqZzcCm4gDgH42GiUbj761F1WMcdH89jzLeqxXOABY//n/ae3Wx+SOYj0GsV6NSesHqug30/EgTYBq4hTcgRIU1lVvNlqxCDU1qKiCti+trXhn6tv87KsoCawa6JT8ln7oUg1wFOyAOcppUF2h279Vlaf6rkQC3iaQCt0oOpPZyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+KOYs+dMblR3OyZm6ZqMDyJDzwq1tZpxDLJXI1hQsg=;
 b=TtAvu8zgVLCnYkvWsl/GdEIXI0fpsJZOAycTnlC3yzpsC4uHE5R/INeeopQlxtwTM7fFlvA3asr5U97at9WESGaHNL4WjLWtXJ7JXpupYKAZHJSIvbClcVlrCAG80J6E8W5XCpVLBk0xUpDzNiZFp8SIWBMBIYsMG4/CcxL07M4=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 SA1PR10MB997965.namprd10.prod.outlook.com (2603:10b6:806:4f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:27:49 +0000
Received: from DS1PEPF0005344C.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::4f) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 04:27:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0005344C.mail.protection.outlook.com (10.167.23.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 04:27:48 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:27:47 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:27:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 13 Oct 2026 23:27:47 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69E4RjcB637024;
 Tue, 13 Oct 2026 23:27:45 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH] board: ti: j721e: Remove HBMC node from DT when OSPI mode is
 active
Date: Wed, 14 Oct 2026 09:57:44 +0530
Message-ID: <20261014042744.2017446-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344C:EE_|SA1PR10MB997965:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e3cf6d-ac17-40c9-aa3b-08df29ab809c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|10067099003|261009223027099003|6133799003|5023799004|56012099006|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: SCZeEmLXq8VKOINkPiVmq2zl0yKLW8LJ8PODy89tpR8WuR94LxFvsFKTyqxPpyv+PhEJqWZdIIqy+ahYgSd17DjuYaxQJ3utt1hRlzVnE+7fULYCPf2TllsNv8pSMEOfjsvd5RlPtBIiRdjTquiX5fkDALLZBeIuqigUQ+6SkdluJOJ9WVH0c+ro3Ni4p1eKoZAbLZUKVBXPbMvjJ0HDJzBbw47pSMpG9VR4RpYhVVTfTX6UZdT8ChpyCKfC1n/45qP/KiXVq9CORHL/UCag7jlwRn2vQs9r3VvofBAsLE2t4+x1t9u0zMd6StgmPBoN/C3ffAhBrT3rCDAu3webSxBxySv7XoOzJgCI61JT1SQuzUwqQJUcraeuovvKWRL3oBNkU7Jv3RKhYR1jizV/f33wOG8AigOyhAYw+fJDRRV8eg4xGtxBTAaaOOq40pkcikzF3fcbMHxDeqXIpOahZ+craC5pH+g9A1/Jv78Za3t/TbI/tiQHFmjxJZO9HzezIT0h3p1IJp4OrSGAgmdZpbYyyaLetFM7T/7pYjdgncCTWeEtgMtxvDZuSyxubbE5mjRvovfakrAPa4Fnk6OZwmnuM7dOr1LvSboC6dOyGCzC5Zx2Xw8/5kk6vs8dyj3z1Vzc8NsdSsWaFT1jTlL+lD7IUv/tvQ4Wg+mlQYkMhOY2SWrEUofJ75u7Qy+ayS/bLZ2l4B4DJ7IWeB4kTZIPjw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(10067099003)(261009223027099003)(6133799003)(5023799004)(56012099006)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qLTNuknkiz1vkfd4XUzxW3jaiektkP2JdSTf6hDK++iplU9RuG7C6I+R+e9awOb70P+L2PvPlwhyQHAObX4adHpG6Ce1NBq67cWgO+6oRZZqfY2G4I6rmar9H1JUux43FVOrMbIAMUPYd8WCrt1GlmL8D5Ag+iRvKdjCUjKcuMRBxAw3GW707DSAloIXpDPHGKMJ5kiOK0JaqAym1ZKZP/wW+Lcs6VNdPs9Qx2LcyQ76tMIwmXJFGPpjUB6fcYBLavoPm40s3hMTL8GkCnZcOKn6z9b+cU2NfxuXfsFvOjbJGNOSZ8lWZi3jsSHIErzf9NRigRKoinfO0xk6o3cRr6h4S4+jXB9p4iujGI2tkkwyneZEGUH/1fLW3r0cAhOs+IKAkk2FiHCYpUyRDTehuvxIGIW4w5GnTshsrQxU1qiAZNfQ/jxvoybsrsxrvHNF
X-Exchange-RoutingPolicyChecked: Ofw6L4ud+c0Rdqf0khQPBnhcT90X6tYgUfciuFoDOg/VLVJMH6+2meI6eJtVDNT6GAaoE9pAvxWaOI01GFVdonjTjiMmpZpTAV2+DXT/x/6amQ8hsggKKF9H402y1OUG+zlYK+IG6iZJ6+k3CPxXGCQok7TtpT5IF5ESS1//mHKHV1pu6DP94TvNwtilf7bBhUFaVtaCxxLE/7aUPiLOW7qNF8Xp5hWWHAgMY4F+XED3XXlDBXyyN6nliPxANwpNBZEpJRXEYb9XzJypOb5O01YSM8WBY8CZqENgYKyS+CSouIev5ODkAzVJbbGiBXQNWn3kOE8pjJaXJmMPNUmarg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:27:48.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e3cf6d-ac17-40c9-aa3b-08df29ab809c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997965
X-Proofpoint-GUID: G32zON_q0BYLXzu6s7rw1N3h5BMOWgDK
X-Proofpoint-ORIG-GUID: G32zON_q0BYLXzu6s7rw1N3h5BMOWgDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXw2tIJ7J9jqEg
 F6NcobnmlAKOpRyry4Gy8Ux1olNHLCWOIWCyV7fqNd+4LfPbqmEXJ0jeZn+MFPpEZWROTcXnnOJ
 5oD1fNeajjvwvAdmECVgLdg714eQzak0RGMwZ0cBLMDkd7FT941Vz8NJQB7qHjBPOSmYa0pZgfl
 PyK7ZnXmuNXT1cL4cJy28z+evynrEDEX84AF1P8ipQFnDCiKOY0pOeQOHl0td0FW6tCUhYCVVkv
 2ZE25IAXHgfCXr3crHXv1Ns5uhgGqG1/8LQKs5JtUiNNSy9zFt/MNuEFwQAAjLEFU+rcP7zQRJY
 u6lLNOIkHym1ubkG+JmM1mrCINT4q1u6Ro9BJrt6pWBB2DRYVDVeJHI9NKqrvaOLuFTTLdo8HGd
 SNzV4A2YbIn4EbqZzzJ/dLvM9IkZPnK7yZgG1c1A1NsQaRTNG/SFGiyW7wX02IlFwkHDhZdIII0
 kECdkFdXGjuhRMs8IoA==
X-Authority-Analysis: v=2.4 cv=Vcxir1p9 c=1 sm=1 tr=0 ts=6acf04c7 cx=c_pps
 a=ZfP+Ya0swgQO+W9lSFUZ5g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=Kug1W-v-kM_Fcey0AzMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXx4nGyZ+geuWg
 JgMzJQR4uVgVf33Mkg/QqhrRyOGr24nKxVfKcOocrwaF8YIlsbHEJ3b8rTT5ywm6hCo4wZ7QUAh
 R2a6YIGu/ljjxY79u5lpEGOOEJMmoH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140017
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

From: Anurag Dutta <a-dutta@ti.com>

When the kernel boots, it invokes sync_state() on the HBMC node, which
powers it down. Due to a power domain dependency between OSPI0 and HBMC,
this also disables the AHB bus, making it inaccessible and causing
indirect writes to the OSPI flash to fail.

Fix this by removing the HBMC node from the DT when switch SW3.1
(WKUP_GPIO0_6) is set to OSPI mode.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 board/ti/j721e/evm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963..8e2b8f3d47d 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -102,6 +102,7 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 {
 	struct gpio_desc desc = {0};
 	char *hypermux_sel_gpio = (board_is_j721e_som()) ? "8" : "6";
+	int offset;
 
 	if (dm_gpio_lookup_name(hypermux_sel_gpio, &desc))
 		return;
@@ -113,14 +114,16 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 		return;
 
 	if (dm_gpio_get_value(&desc)) {
-		int offset;
-
 		do_fixup_by_compat(blob, "ti,am654-hbmc", "status",
 				   "okay", sizeof("okay"), 0);
 		offset = fdt_node_offset_by_compatible(blob, -1,
 						       "ti,am654-ospi");
 		fdt_setprop(blob, offset, "status", "disabled",
 			    sizeof("disabled"));
+	} else {
+		offset = fdt_node_offset_by_compatible(blob, -1,
+						       "ti,am654-hbmc");
+		fdt_del_node(blob, offset);
 	}
 }
 #endif
-- 
2.34.1

