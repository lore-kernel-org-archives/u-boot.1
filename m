Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15C3C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71CB5841F2;
	Thu,  2 Jul 2026 17:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jcGWH8jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C27847C3; Thu,  2 Jul 2026 17:24:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B838407E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2904qopeIrW8TtzUOtV2Bc5EO7/tNcKxshRef7WziwkRTo3yJ0GyPkB9YxSAUtRJ1OdEInOvarXeb5e+VdEIW1pfDNati22vt1EoTE0ZAD+/hqxLYCUPyahjbC7ytKpi2Lf3V+RWzbjACBj2wUmHqea126W5Gg38xotm5ny3zJ6HS51su6E/3G+5hRBfQ95ZSWyNDlmXw4+Rf9ILvZoIbep/JBkGdMLvYuQ1TtPuWiZ9BIQ8Gs3VlF6xwGuEEpeuRm+sWQjyiRVmLkkNrt7cWWpjcT6Pjdte3HV00f46WCnCu2QFUa05b+LntjcaDSDdpfPPN1LSU3EG+rgNLFFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkXF80j+PxeLC5pk0z5uVe3dLvT2spR6xPeGINBV2r4=;
 b=g47JuQ30/me09aPc1yYPbAvGumZFIKy8MBG/30kcgniH5rTWlPlnm8+hRdnzeVp193sSw9k+u/n7IkG/BG5KCiT8bOQ6r497r5yF2bqvGGt8pG77EUItM3+qPmIMtWxPGhgKbK1av3xvxr94PXiXPFZj6TUHQIZMS72J8oLPCdfSeYxwLDCI/OmWcqHXHd3QBFROtRVE6T1HGMjk1eVh+HzmaZJ6FyH5i4ts0TxWcIPyLabgFOOz+S83UKCm5RvbN7XVPIMvApZNAjthfhjtwvKFPnl8TMprd2u1c2zImrpFd7440IhLA2JxyOiax7JkONFvAF5yMW4jf7m4YZq8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkXF80j+PxeLC5pk0z5uVe3dLvT2spR6xPeGINBV2r4=;
 b=jcGWH8jKZHjYuhH3aMeE2jmrgABa6xbJ65ud9T+qhDN4BJUwyulNPcdi5FEsE7FKP02BMfcGFg4MmNxUUKc9BROP0flZdD5JEaBmm1ceXs0zM6KmTRlAYxQDDaJfWZ/M21vV6mRUwqwJQik2tlovdmTnlA9YdtUchFAfctAeV9PtXptf0X8hIVV4D/ZCDJuAkkCYIXAwhhtEWjKuD15DV9ogKvG3n0OuQIcedI/htCKxdp18Wcz5ibJePH+wLPzGLA+Ln1QAntxudyt1AB9x8yKvy8tlmFvgfJ0VDUq+8rktwPlON6klEKtx+wG6wpok7wZmSHRWGNliXqee+k+PZQ==
Received: from DU2PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:10:232::10)
 by GV2PR10MB9908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:342::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 2 Jul
 2026 15:24:38 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::5b) by DU2PR04CA0065.outlook.office365.com
 (2603:10a6:10:232::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 15:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:24:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:29:24 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:24:37 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] cyclic: update and optimization
Date: Thu, 2 Jul 2026 17:24:35 +0200
Message-ID: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALOCRmoC/yXMQQ5EQBBA0atIraeTVhGDq8hEKIUSmnQjZsTdp
 7F8i/8PcGyFHWTBAZY3cTIZj/AVAHWlaVlJ7Q2oMdZvjWqaFxnlxwV9aRAq7GoUU01R3ISYYAq
 +nC03st/X/PPYrVXPtFwrOM8/XPc0L3cAAAA=
X-Change-ID: 20260702-optimize_cyclic_run-ecdc46f12829
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|GV2PR10MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fee00bd-ea3c-4d27-be9e-08ded84e0806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: IaDNkkSXAnUeBFQhe5glUjbIoTsHcuvi5JL9Ynvw6dTS8xGDQ30dCsAo5JA36ubAWQ5faDiriKsEbfYw6c0li/QjsdAUTnQHArYZxR2/8NJyvihe6GZxrj27cXnD2fdG/OMBc52AQ6kdrFWDd2VTnWTjr8Q2lw6OzyAIFWWfcKR9vIJUk2U/WKfsL/x4SZ9Zz1hTaTmJyUMFyJrKyM23+0peiZaHZ9r1DP2EeqE0YVrU0YJ/kbve+H+L4Lsu7P27ZftxOwqZn572AtH4wTBLXY89qr7rZ4xwJAJFT8Pz76a3R1vX/imAAjRWLOhn+ducDUhOem0BQxilnmkvqeNykYuIeKpZSN8izS9BHfOnZ/J9xeB6VFir20dZ6w/z9Ee1tE4E3YrGxnRC9fhOU+qRtmcKVQIBITMyfmeEQABrj67KCMdC+d84/l0449dpYIUdv/i9QC1fgieoyAfhy8SxjyRjxAmh1dKm8WXPXF345GZHL8AnztgHOc81JsiDyomUJxJzQIb3pIOuubZsjT65yCxzK140adq4mYGvjPy2XLkzWICpy/vqL8ZNOuwE6QNb22mEYU3tm4KgLkPwmKCCf9OJX5jB+MkWDnELuPlUXwvWF1NbGO03qWAaHFHNYfaNG4mNnzAZkbr6+3obJ/WB52qXb93BKDBmHblyQ5znSzqF1YokVzAMDhm2+KRhc+EAXKK5EfX7kbi2ljPZ+Ne1RA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WKCkX/yCxn93xl4HnAcnDaQ1IrRhB5VBo+k68LC0exUHyyED+l70jXA68NuiTjYq6banl/LY9NqfJxet8gCpbL+JQvhbj5roRyuityFt6ZAqjNEcL1tZDC6qZz7QLBUXmpSPVQ7L8+pTW4mQyyOcM+N1RYFhuCHYe4z5+GASVLA4/yF4r5mDt0dVa2MTcfXw/BsLlU+CooCUZOh3DMMaerRsZznfQnYz6UYPWSjqa80iyMMiDQ6LX1sQRqf7uFoR/9KJ/kY730miPYllAI+lTrW7Wg9tQ5fwNYuyZLP2PU7N4GgH1lkVsUcXifLy4veb8FNuHX82tdTPMFDDekZ2/NcxIs4F+wmfTMc0KMyc8CP0eYS/5qh0vDGo9mTgzzwswc7N0sOlVic1TkwQnfqywuJ7vJ1j6Qjv8GEDytWbChgYvkLLpHnZZdgCI7NBd+sr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:24:38.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fee00bd-ea3c-4d27-be9e-08ded84e0806
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9908
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
Patrice Chotard (2):
      cyclic: replace uint64_t by u64 suggested by b4
      cyclic: parse cyclic list only if next cyclic timestamp is reached

 common/cyclic.c                   | 16 ++++++++++++++--
 include/asm-generic/global_data.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: 1296a428c67cf103eca482d4a63349661c1b799f
change-id: 20260702-optimize_cyclic_run-ecdc46f12829

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

