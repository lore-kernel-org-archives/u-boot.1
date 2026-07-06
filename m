Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7126C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F99846FD;
	Mon,  6 Jul 2026 18:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gxKetjpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 049308494B; Mon,  6 Jul 2026 18:06:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0D2846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjM4DXc7g8qf9Fm/yY0iR/xaqBIArxHlpY22M0HDhIK0Txlf+5OPD8dF8dZ+3VhdlxI1neMbPEpO6AV02w0CFr0PAAxomqf3bym/KzVmgvxce6qrEWF4+bHvFKR5BHZudkxdnSdkI/lxT4hrg2RLuoeMFWf8IJMC0X44cpKty3VRejIa5DpqmYMFr0hZ3OpJwr0BWgOLgILhanfzmdHo1ys2M9VRZkajlZ00rO7sFfYbxwGm7/zfuk8NmyKTJsSnn/u4rYLWyVPOAlc9lWLllvx9nhD0fztfFWSEADozWhVQ90XYrNjdKIyXoy4dAitYujUBVlHza/hMbaibbX3Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kthnY2Ev6t1lxIe+18g4mhQrVE/Q2ya2Iz9uoFOzPs8=;
 b=qw065SeGdZYVlGAQ067YC1HAjZbK1NLRe4J98HhYQIEM5zS3gQvPhL3ICK2JrZjbni60vTvz4IK/IWUOlC3ROU6YW7yDROXHuJJPwtd0YfPcAtZXNDDylQIU2Lx5vVXy3M8ezw+Dwc0Z0avmXjGWWzzhEpuvkT1Aqu2wqRFsP2j3u6tvYUFXxpKWnnVB2CNPXjsWkfWNStWuzJSTiXENlBBgaDwDUSkzUVwZudY0gUKJlpXQ5IpGwAu7EwMykINoKZmfEC+IxMdfSWTKK2oHxUilJ9wQBnI7jXSvW23hGVTHIkWnpshnrO9j89ZT5jCKu9CbU9PihJwmSHEjP1xqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kthnY2Ev6t1lxIe+18g4mhQrVE/Q2ya2Iz9uoFOzPs8=;
 b=gxKetjptYUSZwEQzicPkFv1OSnkiZC78/lWsgc7k+P93JyyKJ2uevNV60JVsogvY87bPqEWR815AjP9BVkBCePXqF5/txMEQr+OKkEJRPjKcIlHM6zgKJx6n3rMcStI0OlmErBUqMiuaNc07xkEpJdy9m6WtGAGQaOtrfCZe9iTqXzkY5cwMgRGNg/Ru7udB1xb+EL/X5vFoPEnc1EN/hekxp8alIL6XZR2xAzBgSHcXigvh3nnPZT8eNDMwNdS0eNlkgM9OqbhyX8PtCX+NTckqs+1UvEJGDphuDW5gphKxmvtg61QPZEEwKuGbMIE+wkvdbauA8pXaHpxA4UwBiQ==
Received: from AS4P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::8)
 by GVUPR10MB9680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:35b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 6 Jul
 2026 16:06:11 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::74) by AS4P195CA0017.outlook.office365.com
 (2603:10a6:20b:5d6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 16:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 16:06:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:10:31 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:06:10 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 0/2] cyclic: update and optimization
Date: Mon, 6 Jul 2026 18:06:07 +0200
Message-ID: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/SS2oC/32Nyw6CMBBFf4V0bUk7vF35H8YQGFoZI5S0QETCv
 wu40cS4PMm958zMKUvKsaM3M6tGcmTaFYKDx7Au2qviVK3MQEAsEgHcdD019FQ5TngnzO3QcoU
 VhrGWkELG1mdnlabHbj1f3uyG8qaw31TboibXGzvt2VFuu/+FUXLBM8CoSISUOgpP2jjnu95H0
 7CtMcKnJfhtgdWSyiQG1FqUMvm2LMvyAi6ndWMQAQAA
X-Change-ID: 20260702-optimize_cyclic_run-ecdc46f12829
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GVUPR10MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b120b1a-1fea-4bbb-e6df-08dedb787fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|13003099007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: sRMcBlgG2FwzCu1Z3k3JniGXK03f142QH9rcZJxEhto4jHGKkOHkR9B+Gd9P0kZZKyb464W+94X4PbMztL512LTdWWcKlaRnJJeMvtGichWslsKd59W44nHkwXzy67lYODxceRNTm1ScfauakCT7qs6Eu8Lus8siEO+CubKeTQdJmcWHjQYrNLTsYIQlaaW7coH7fWMXF1xoL0X8fhIll3guK9ypRGaY7VmUUaf4GvkedQuDzhMA1sMFi52UePfsRNK0iiXOrrD18IWInw75A7ahYvcvnmyxNLR2thR/08918tsW01RanYq6Ht6ha+XSjB8qsnzqrDseX9ZHmzbEisZi3BOJO0fTo85uHZ3uwn6uYDpDoFgA0KbG16bRdf9iv3My2+FjiuEtpeyM7EgEqqGGQi/iqk0+xe/J+7zPXArWRkmoElKlOSe2nTwUdg2+uG4WD/QuDQzRRJygbxyxk0GxvUuGcS2VTww+WFdXQcEUVnj/m8HGpIasUwv6rwb+ZMSZZez24MZuUia0+D72wp4TEVPR77D9eUdquJ+gPdesscl+Up98Xqr6CT9LZ2l+wGnzMK7Jsj8MG0bDBXI1bBaXTFZsmooUl1MaDCG5hL+eeKIv4n7l/QEnC0kS0jCZYCgvRYlFIKWFFGnHcEnZvyCl7M7yx4o1Gd5HUbj4INs=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(13003099007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XgMqH8ujPdQtTVmSu882DfqMiImMhIkZNvixEDeIXPYo3jQ0JBnElEIPL4aXOAPfJ9fDQK8qiA1qeCfywpfOalqrGNq3oQNk0DAd1FpBNMnvEgh/Ggsk3+blsdXG6G+Vg36mG7OgCOPOoylzQxvZQfRYJKK91zqg29jFhuzNyXEBJKnFzmFIwQGbZ0dsFqOhzIrGASis8esc/Q04jODCcDMZhZUSPbgeNRfpqGqET2u4yLGd0XMC7XSA740h6MG9tM6tStkyVKAJqrwyRbRzGQiHqAFqKfkXqcm17LLCPLa04lSbIPbtPU2VI6lbmQOIhhLzcGJrHohYBECK/z37ZVwo9ZFPy1CS3QU37uvHuh8oLzPrAybvCcej2YUnQmaRKO0AeW3rmgoqKTG7WcsO60FYy1KHHQ3ug0PFDUG/s6bONQsbt1I+/fSpb3gJJh8f
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:06:11.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b120b1a-1fea-4bbb-e6df-08dedb787fa4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9680
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

First patch is replacing uint64_t by u64 as suggested by b4
Second patch optimizes cyclic_run() to parse cyclic list only 
if a cyclic function's timestamp is elapsed.

To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v3:
- Rework cyclic_run() to not call get_timer_us() on each entry.
- Link to v2: https://patch.msgid.link/20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com

Changes in v2:
- move cyclic with nearest deadline on list's head.
- Link to v1: https://patch.msgid.link/20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com

To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>

---
Patrice Chotard (2):
      cyclic: replace uint64_t by u64 suggested by b4
      cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()

 common/cyclic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 1296a428c67cf103eca482d4a63349661c1b799f
change-id: 20260702-optimize_cyclic_run-ecdc46f12829

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

