Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C965C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D59360C2E;
	Fri,  4 Sep 2026 12:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yT1ZgU0xKwkR; Fri,  4 Sep 2026 12:03:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E04060BD2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523426;
	b=AP+QtzHvgrlpJxbcHTfSlhRs9PqR6hHUFW/fkX5Qey8KMq+Va/E8Tgq6iJH+zIV6GFwT
	 WWHmroHbZl4lPWs8/NV4MA+NxQAeAv6erQvZU1mbvTU4xf646zAB4vg2UYjXGUgE779Ah
	 5E30qge3v2WzINlPgsAP9B8TqVvnwmR3uK4eZ3KAVSTgY2c+54FzwCvpCZP09xRbgwrVD
	 QISA5qhlVNP/yyaAdhriOvNEhycFaO+DMVElinr21uWmlOWPSiFlxapIfayOENlcir6EB
	 FiEBfULHiPVuyQqYu/6KxO7MWY6vidgihejfbj3MeNISnZo12E5dF7RkTwaGkpDRzUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlfHM=;
	b=S5KPv1EeAP7+gk4v6pUUgOf29cR0wEqTP7UKHMKrwZ1Uah/uIRrxGw4mOw7zmBwLdQDn
	 8lOYoH2z0DJBmEYlfFhYOi8Ee5xdnwlOoNvyOHmSJ2OO9KBfg0M2qoKSXUq7mxxH3otKO
	 Dalj6EHYdXymjdgFxsWtJBmPML5h+3aqea+IgcKx5s6Dm+Kt1tANmFAp6gNpyz33nxQt6
	 SvO9OrThwooa2/PPxxONeiEb4VYtz8T+meives96b5NqdQaQ0iwATIYeyBRpI01IZjmBI
	 jCimTEDI3qMl3HbeXf2+HWFVtKBNYAcnQzcDLNUxafkZT6+QG7OX50SV3rDnwKf/49Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523426;
	bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlfHM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PjWXvckmiJBKhOlfykV+O4X44Kt3ORjEY1QD6CceOV8nf+ikQ6X+AELDbJka5ZmH9
	 4do+Rj/BVqkhA/6uZP6Hynlc8bOXLmucg8Z560DDgwOe4ZR5tWyr2U/RUMe9B4fVI/
	 wJTWI2xZlhaUT/hndWPg/2cHdIAfDfoblkcdglQKMA7k9s7rAB71QRfglHh7Amr2Z9
	 3OWwpDO/YhyuDZ2s0Hj4u7n2yJVozPGB/unO3a9DmOiWIS6UsTQTmX+JFKa7rXAHqD
	 ReZgpuSkNLiLdQzC8ifrODWQ221v9XBe5nT3XbPT+JpfyQmgLep0d3pq4ADUC2ohvY
	 9TSK0jELivBHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E04060BD2;
	Fri,  4 Sep 2026 12:03:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02F8477F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00A8E40B7F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXJ1MIEk6FYN for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EC02C40B28
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523424;
 b=efggfk7EJzExdpwANT3b/6kxevEN922nk+s04BYSpx4wPUTYyha+Wgap/YGuPeJBcbx1
 KDxZTB9nr5MSj1oudbBHF3demu4NoGhRETHQwO2SD9pICilT9UsLUv0Gv81trILFe7tgJ
 8nx70ND29N7Qj/H58jhQYQbOEMgxCjmFb6Hk6DVFWSB47dDRuGgY7RJLoNfKzKV6b3N6T
 A3LXSHJr6oPfGBj8zjyBsu3K8f6EZaayLO1wRFxKecoDgQTbAngRJcFuH+XnyjXuDoG0U
 QjsW2lWaB/+9hNoPNCi9Ll+4dYAg/DaPHZ5DKSDQvn4MT7xsmOgA1Vp6KAECieRzMbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523424;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlfHM=;
 b=GUi5zwyne9lSBXUgDfghFnyKkfdFHnbrQUWK68qwaq6op/Vk1a7ekT7apcFTVsy1w4ac
 5WrnX++RD7T5xXNu3qdL8bbtr0TxSvs3+UbKeo99JdfIzmxLWtMAZkKPfD6qyqQ7o/Rxt
 D2WOdkVf6/qVvZ6Dgdov/+pyFVAjGJ6kheyD0jJlF0/m0jaRIObn/BTSatxDd+FxO5hsD
 O0elN6mAAdBODFz4MH/MTpKqLWzIe5e9/FUnl4a/qBJYBDvfRcHW9fEz64BPMNIi6goRE
 g9kuXE9wz/Mxb8kJG29qwl1O90mwI5Dc6qd+kMyoAhF2v4l5S8qvmF7QPHaxW8fm7wQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DQHSx1yB; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=rPCiP0jt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DQHSx1yB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=rPCiP0jt
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC02C40B28
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:43 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHCr23456741;
 Fri, 4 Sep 2026 07:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlf
 HM=; b=DQHSx1yBBH3t4Z5DChUms/QiB2BRnvOLd7H3REUH3xTxrU4sNaXzaVR6C
 HnWjuSC1wG0Kt9vohmR2kes711yro++CyBn/IPe4Ay3kuRCp7G/qXthqv6omzIbm
 fWkMKFbeXw7YsDOZk1GRXn0ZyqX0G2Ol5dXlS9GyeZM+OZ7h2hNYAZmTxWBFq6FQ
 CNlBzMV7G7B4aZ1t2rXjWy/EXHYvuBjRbTTeKAJvyohaHEVGoembLUkjK3j6aev+
 7pbCogPA74tq0KkOHsZpRFWW55irDTmDv0lnpag+7siISdzRgrs3hKVrHDJX3SJM
 heYuyzXsrwgXrKFOAuB1Y9/BXDiDw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xum6c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT6Om1psjI/sJpSOKbFd/RlApuQb46dITKyP9xCgZ7rDfmrymyVrlmpgWsyz9ceNnVckw4qFAMgjRkOuSOsA+j/Ln0NlHxqcsaUO5vhZFe1GJlmnBj4e8ZcXatTEcIhfaGCWWjLuKxJu2CZ/HTeFWASDZs1SUplBEx/rc2B5f09tXG6Sjd/UNRvAPPkvuSsPLDEDxe/U6WoIm8zOI57GbEiYSE9U+5q8WKmfzoEOl05zQgnkFRgW0PCEGUhrd8AQz54tpCAwtzx8X2D3kLzyRQbD7mnb+7Tv9bMlZnWv+6bdpaWZ6dtAsW6+VwfQgDQ/GCmfYW0eXBHezuLB7Uki/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlfHM=;
 b=BMn37jAAU7jsTBrMks0gzI2nrr9N72IoDrhcZaS38HLASP7viP2rXUGXMAkAui4BrvzDuvLkkKbIbO4aB9zRLU0UXno+i0+fkvJnApeXePN7PZ4xs3MjQwKU7TpARJeijSKcA5v7mwyh34E+6y9JlLQvXeZnVumKnZsN8JsK+dh2xT6TNoM+p7iYX27VO9nXWE8y7Cu1GDW+50uWpX3wdcJ0GaMw0DyJl8gTJp7gJTwi/0mLqU6BLvNaIiQF5Wgn6oxKzACJnuxdPttgHmrHEiJxGQMzVe2wONAR+iSxhjp9s4ZIIfXUf+XPhL6P3FLrkhLO8ErgJ2qCDzH6KC1img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF7SFkOiVgSPgXXNXDFWysRIiQq5QZavo6o9YINlfHM=;
 b=rPCiP0jt9v20nHC/3z1yESF7P3bAh9bpLvcWgbInzoFS7iy+O8WIaLJmBwCTqh9fbw0QLf/X/lIKxZ597z5tE/lODyJas+XwTpFUW/7PoNEgr23UQ312bv6smt3PcUmMs/KNmAbnF7ue8QQAl4yLF/meMrtk5q5vAWmtbthlEYw=
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by DS4PR10MB997599.namprd10.prod.outlook.com (2603:10b6:8:318::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 12:03:36 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::8d) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 12:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:03:34 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:38 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:38 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcK3456269;
 Fri, 4 Sep 2026 07:02:36 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 5/7] arm: dts: k3-am65x-binman: package overlay for PCI-USB2
 daughtercard
Date: Fri, 4 Sep 2026 17:35:54 +0530
Message-ID: <20260904120604.3612484-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS4PR10MB997599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c18625b-eac5-4115-08fe-08df0a7c8bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: /D+qH4qkn/vXw1rgytlVfnThrGOc7OHA8vN1B2Vz9gBbts0Umck99yXDN2Y1oJKQLpP6fzWI9S6Wej9mGKwnFyBZzcaH3fGmsO4k4zbWVCV4Cq6X7NNLvYQCGkHC+GB4TOARmNp4ptrcy0Od0iT8XX2btifkMczk0rjEpxoSWXx0LkVadPeZU73vDiCSmsQSyvWLNEic7AZREUoS9HGkxCFphiMlZE34hGVbNHU2aVw0QZBgF6vFYowGeF7JUPOyOGU8cFhXTWWr0YGZSIA1vnzyZMAG4v9o4uXND1u+KvFkmJUa26qAINBGpwcIgYNruU6t+4SxrFCQ3bupNOhEUlvgQsNhzBgjYpC0i5X6IC+iGv53PPi62cIfDhOG7q6vZnVVuWLy7gWehh62McI82I3Dest08rUtV9dfQRnJ3DBBQzeCG9fdDMXKvWPV47xZRh57o623/yw9RCZy0OqCWWWdFRjFH/VZ+zs6VQrd4W8sINp99GMVlC2onyF9jAehL7NOo11XmnvIwtkhvmuE1U7yBazW2R3cfFctqy5mlg2LKP3AB4IeWU7tV8ZumXBYbMMcWM9hI2vfBRb5u3V4TxvRBZCERZtu9cTErcYiS0AYcnpOHLmTu8EsD68Tsx6Z6y6hgElndGF4OPwSeTy9sQL7aE++CTzaYrGNkcIL8oBszp8A7o2FktXoC+8ILLVPaIfdd6/EnF7nkFgv3tn4BQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0VEWnfbZB3I8+ooAzK47yxbehWN5zscJ77kfcvMAg/oN/Ys5FtfOqBibTFUd2ZyVzbYv/ca9wYKz+JjhtCYGO1TJeAqGTc7sbVe7VAKPl1Bx9SCp/X3nWCIly5Sfb5sl4a1p4nwDHuUA0NekQ/41VznIyirQmfjnLA2r8NMW2dmmf83FL6xqQfMMe/blUGfZ7r7zdrPc3bPfqpemsoDe3tloATXv6tRqhj82X1ndpJvtlGpo8MFBAtxG3sYj2PovOtlHXOxs5OUkuVojxEGh4ElKC4C0KEPll2oBLHM5frYI8ypII3kjsX6/Fj67RMwXU+gS13nWqof5F73EbKbaI49kIrhgd/8Q2QUITg5V/pq3TTqZJGHYVJ0iMljyuFS3ad9BBlrK6eNspjckOU7Tlk9jWdyscySXuNrNW53X4770JOCqMjYd4x3KsefwrfjS
X-Exchange-RoutingPolicyChecked: XtbK7+kolf6sqYLjHWxydJjZzwU3Hj7b+wy5zRTbnGUa2EtXf0PKWApy5usyNbkl/S1L2sKtyH1yt+97GFCIA5ZWRSuCaWz1uUkffWB+QUhLCqxnyvs7kbK0fMSUKprs1B/BNuGWtn3jgqeUiWSnau01f/nLHznt3jPy7tlt0QR8NXT8wmYKNVhHFGNTMfnyTRektqDprrDfFKJXq9jG0X9oBnK4u32WP/ZPb40RnZFUedN27Opy6hSYKwFteL+5CfGx4u5+EpIBvO6B8cEqOIypoKW9v3yMO4JmclTh+TATG+WEjqnkMBJSN04IsBEPyKuLIdzviWa1PfT/LUYeqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:03:34.5410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18625b-eac5-4115-08fe-08df0a7c8bc0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997599
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX1ZuALbGdrca6
 5WUW8ROFD/96fpKzlcSGYRjrXBrRatG2HOc4sVjFqf8mbA7uj07MMOaXgkBI5drLIN5h1X6vcld
 ShewfCwiaR8Sb2qwU/ZgcFmFjJk3zDc=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ab39c cx=c_pps
 a=1s4lD5itHyb3CJ4oxNoLhg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=3aB4mLzFzoJxBdMkICkA:9
X-Proofpoint-GUID: 8k6FuhMqOiZ1j26CDDcEpvkpbYnSKVTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX5OseHC6Vpjs3
 P/p3a5bpvpgbl0rr5X9oORcq5KabqmVPA6RpWEcRh8LVQopO/7JGtJnk0soyQOdfl0ooPDDeylj
 toe2JsLqXaxb8P1HYzfM6377h8Ld7ajgWpvUkPeq/JGnSn0bvjk50UERe1avpvX0Jo2I1HH9hrP
 x4XPz2oXsTzdi25hNxQIlWcLlsiAPoIvyfV32rVhVKs00qXIbT6JYfLJiBM2hLu9y/W47Ov5oyB
 MyedAO+Ueawo1CiBcYpWD5iJ/SnCM6HYub2GO5Dlk2R+QuS0KPwuTLlFJhCMG0Uof/LrC9x4/Mk
 bRAeWWFlmT+BBA94La29TPTDeHJMoZQz3W2oPjmuZOqyTddMLqeJilfZYGpCKfUdTMsu7VpiVZG
 KcUdnoV5Bv7ehW92lxHFF5JR/Mx6VXoEgoijbdimh9RBh8XVo3jbHdWx27tILyzNoghUSoZdMkQ
 yzUF0xuE2PD5yVPBGtA==
X-Proofpoint-ORIG-GUID: 8k6FuhMqOiZ1j26CDDcEpvkpbYnSKVTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040107
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

The PCI-USB2 daughtercard can be mounted on the AM654-Base-Board to
enable PCI in x2 Lane configuration along with USB2.0. Hence, package
the corresponding device-tree overlay.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm/dts/k3-am65x-binman.dtsi | 35 +++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index cc82c8b5768..47b0986e65c 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -96,6 +96,7 @@
 #define AM654_EVM_DTB "u-boot.dtb"
 
 #define AM654_EVM_ICSSG2_DTBO "ti/k3-am654-icssg2.dtbo"
+#define AM654_EVM_PCIE_USB2_DTBO "ti/k3-am654-pcie-usb2.dtbo"
 
 &binman {
 	ti-spl {
@@ -199,6 +200,23 @@
 					};
 				};
 
+				fdt-am654-pcie-usb2 {
+					description = "k3-am654-pcie-usb2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am65x_evm_pcie_usb2_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					am65x_evm_pcie_usb2_dtb: blob-ext {
+						filename = AM654_EVM_PCIE_USB2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
 			};
 
 			configurations {
@@ -208,7 +226,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0", "fdt-1";
+					fdt = "fdt-0", "fdt-1", "fdt-am654-pcie-usb2";
 				};
 			};
 		};
@@ -297,6 +315,19 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-am654-pcie-usb2 {
+					description = "k3-am654-pcie-usb2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_PCIE_USB2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -306,7 +337,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0", "fdt-1";
+					fdt = "fdt-0", "fdt-1", "fdt-am654-pcie-usb2";
 				};
 			};
 		};
-- 
2.51.1

