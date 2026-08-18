Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E931C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 15:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F0F9608F8;
	Tue, 18 Aug 2026 15:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqlOZhEr3hnG; Tue, 18 Aug 2026 15:12:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52D4A608E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787065923;
	bh=dJPyZaeZcCZjUdPu9V9qLw0DZxsGcHS0hDSyCRsljhI=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=If8AUf/dS8uX4N1HZC65eZRI22UmMc+PNjhhdh9vTKOa1awbf0jb7KYrGUAChUBAQ
	 WPuwMOp411DSUDRmrXDJaZ/M14HW3PHyZm5L81gfk99zQvq7XEzKxN/fj9RPY8FHR9
	 v+gnkRShO6LiYKMT5ONv4xXvbBMCbK/3jenRgomfAnKFSatzv8BYyGg6Mw5OS8w3bE
	 DXlJ1LtoKCwJoyteJjMkMy7wVTbdmIVNqOiNnnvpUp+VfUIRcx4x/tcRPLHImoV63+
	 MXOYzHL9+hWcJB6oO7rfJ5je1+wWRsRZhyI74STbOPhg9JblZEwlrTkFXj+eztLCiG
	 6EsZHc/wyGjtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52D4A608E4;
	Tue, 18 Aug 2026 15:12:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAB9D2EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 915AE608E9
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuLWVriyPQx0 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 15:12:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 34167608E3
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34167608E3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=RVT3R1kg
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34167608E3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3i0KLytkDd9d1YU1F4umJAnbGJDs74ic8Sir2b3g5l8wSfgJzY6jWci7HJnkVgGnLA9xBuvBE79edsPLvJZ6dUcDRs06Hkzyf567B3B1AOrkppTfswnNOZGeqjZWulsFFvDKIQZWlANjv43f0bgtWUTHgmA3IHGbiGXX3EAIjseGmQTjx91f175CHU231NOSKfO8UHBf1VTN2DGpmnbEt7GxSdQ6EjFlHUqzOUEqa5SWQoX0jQwOYowDFhcQ7L/6TgB/jkSADjMIApgK5mkUy6MCdMXQi9KWO8/sfEUrKLj08d8vIOwdKRk/82RpRnd2Rdrq1ziJV4ycUroKkmcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJPyZaeZcCZjUdPu9V9qLw0DZxsGcHS0hDSyCRsljhI=;
 b=MbnzkYXHU8HgFyzsTAcRwUl2KvWitG6oMtkbC+RKeAWt79aRJsQ/f/LrJfyCZ8J0h9vZ5Y6e4CtF6ekyJRly4F4PsXtkoZ/o474+bWO1YqLWxjlHzFGTB6YGKxAZvdxMTSWzug7L/BFKIgmo1Sz8tuXljyCS7kerWdAbuSRx9MmJDRww+4+7swlGR3KA6K9JwXut0qbNdD4aLmxmWCfPj+KTFuRMODcaHD7ytU+8V9jUZ/sgnubj5snNEiAjVy362ofMAvGbu10Hx0FPrV1apSFToL0W8IWoJ0ClkUFRx0F1HBURxL0yW6CneYnBeu1jehvICrr3kwBwKcwY1bBbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJPyZaeZcCZjUdPu9V9qLw0DZxsGcHS0hDSyCRsljhI=;
 b=RVT3R1kg3JBxwOJUS8ZwGYnbwW2flhulF/wdUi3hTgS1+azTfR8C4zJs8qplIeDs1v0/+SLGn6/+qKb0McqE6Pk6278v4maWj20dUf7OdnRK48Qiw6h0XMuNj7tRz+biiD+UiBYptrQ9OFB/i+TyvN/bu7mQRNv+ce1IZme906odhbYYzJVAO3CoH4IjX5VjLMQSJKmfFCQgqGa8yx57REk01pmGA/49rSBmz7eV1AidNJXMwc+aFx1GPs/muC/RsTSZLksfuFUs0ydMWVmNdBjHZYcWOtXrajj3MAu26Q3jDm07FD7XdHqjIMJnJF+HAPQRhLWZGDiD29rKG6sqLg==
Received: from AS8PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:20b:310::10)
 by DB9PR10MB5739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ee::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 15:11:54 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::76) by AS8PR04CA0005.outlook.office365.com
 (2603:10a6:20b:310::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 15:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:11:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:17:27 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:11:53 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] STM32MP: Fix FWU related compilation issues
Date: Tue, 18 Aug 2026 17:11:50 +0200
Message-ID: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZ2hGoC/yWNQQrCMBAAv1L2bKDpoRa/IrIk3Y2u0qR00xoo/
 btRj8PAzA7Ki7DCpdlh4U1UUqxgTw2MDxfvbIQqQ9d2fTvYwQQpmN00Y3iv6FPKKFRwcvoyKQT
 ljMRBouQaMnRmIraOXO+hJueluvLbXW9/1tU/eczfBxzHB9i42ZaQAAAA
X-Change-ID: 20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-d7edde1ada6b
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|DB9PR10MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e9e2de-793e-466e-d75d-08defd3b09a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: UEhku7cWjdC7e43BrF+Vxvn/TEDjCNc8AghjJR9+CjLdiHRyCOtqUiiLXi7nyl5Sd+uQQcGXeMtG4BY16vFTrtYa0oJzI80IbC0BT4FAmAsx49sl5TjTs3ognCyHUd3JeCheB1ChHq9wJdEAjE6G9bMdtVB/ivxsC4yiQ/PpkfwAPSsAGSc6AavHL3Yoy/OCi5hkPSr+VH1X5BT2dd1SX1hBsycStoWkzIureMNMI3Hw5Ql0jsD1eBUtHxhm9WIQSzcltooAc7C3qVJ660yuOWnwitOTKIKhQqlthcadxRhor4iTUD++B29kyQ2hdbBkWDWqLi939fAWEiZyNdPAysqj9NNMnnaoi0F+T+Ph6zXD2cgpOJbHIEVp7XzOud6+3uGxYTXYe3vANGRTU6/33X4c8bJmRosYzU5LJjGMZUm6/i6Uf9AXioYVOE7Tvc/9Kh+9QpiyIu/+bQSJu8hwaiL3FKbLp6ZHnxXGfQ6JtpHBr3BRJ8tld6Ys1KaRyQrjfQFYIttPs1lS9gnggFZkyyjwSMY+DZH16kREC7UmT1SWsFAVt0kdX6pqiyesYyggRfdh1PSFwVN/5XfHAxQb0EHg7LqQquK3ifo0SNmfIijYr1ysUJ273TWkGPz27Y48R7pRer816gvlzjp2lxGLNm9CoqV4JvIfNLQGQnoG/7oX/4SGmcE0JdtRG+hme9qGp1OT9ZU0hHWCg9ku3sAVdQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PF9WRwbZmyS4M1khl/tMuOY+E07qQgBHu7kOwrCWj2EgYpy65yKFzAiDUsDmBv3jNeYsOEL26a/nbkFvfc1BOEzMtLzk0Jo8yJSdzpA+siFkmH55RvqttCuq/5lVDfh0+06NSBYYCpC2SVzRp7wXgeo2w+h7Tfzis6Ba/5BVKpS2r+3mufjqGbRQVsYQiaR8EbSqEDfuP2qm22xBs6kz/cJBXmR7MygqaPV52nEi6zvQFomKVbKjArqQamj+07Nct0vWRr5g7J79V+3StCPsBSHeKL4fysuYC4pdP9RdIezuYaH7QjIB9bHPigKZmTsIGP8jy3GMlSlQT2rU1boq2g0DeY5CIXLecel/6bMcXFlv48fnKyRAcqDzORv4oNiYHdtLgh7snZnumXKns8DUlJ/XZIqxSbKfwG9c4n6JYHbNOx5FutX114hTHPsf6dMT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:11:53.9303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e9e2de-793e-466e-d75d-08defd3b09a8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5739
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

This series fixes compilation issue in board/st/common/stm32mp_fwu.c
when CONFIG_FWU_MULTI_BANK_UPDATE is enabled.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET definition
      board: st: Fix compilation issue

 arch/arm/mach-stm32mp/include/mach/stm32.h | 6 +++---
 board/st/common/stm32mp_fwu.c              | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-d7edde1ada6b

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

