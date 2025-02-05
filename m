Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072C7C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 891978078B;
	Wed,  5 Feb 2025 09:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="M7g+IqYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F420880207; Wed,  5 Feb 2025 09:02:22 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C73807E0
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygi/sxY7s8sZVpVrXHN66zD4miwzqCV4xpv5NQdfScmxmsk4nSNtHhwlGYRWSaOj32KMKBgBz+I46rfvw9m73fzbDNuAm5YqO4XrVh3z0HHwJbVYcc+sNmSus20ifvh0QeLz/cW30Ep06tnonbq8GmeLjncykZAUb40V62BJbT9spDRqliY2/s3V1eKQGv7RyZxPW+EjFUASmW2fkaHxL7eFOQij83CK/veWFuU9+H5wGPFpWXCnKUaQz8t3SAhs3dElrqv7SHoact59P4BKBaCEQToj0s4hycoiP8ffZduq9d6FVXzfEZ4MJAT9gp/o4+Epc6jzuwam8xbeTCda7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQJiYUZ6RWitoqLik6aQh5V8aRTx1C3g9MfT8dserdk=;
 b=ZRbK8XJ9z2f/Tq3wOnD714WV0MEFn0wT8x7gcgS+voOuBSbU6XZu9XGcRuMC4m4lEG+RiAzyIVC8jXGkl6ruAhH7DInbieTJUi8GHqaHJGJhll+pqnsyQBydHcXvAOJ0hsE0WK5A9inhwq+4w5Hg9DZ4mOXP3urpy6GI3DtFXN7Ga1Nlz3inSrCfYrCf/C3SDvrve0UF6yBdnPnqujP72CCnjX/lphyjEksPw3esxUjyjUVxJoFwBoD2X9pwBy269+dhHIhV2PjUMJxtd8Kbi67yzr27pM4DCpmAXgPMmQOBkG/7Q7dSz9sRuFL09dv/3GlfIWJy8o/3ldJURKbWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQJiYUZ6RWitoqLik6aQh5V8aRTx1C3g9MfT8dserdk=;
 b=M7g+IqYWtRza6Q+HH7+BR0qXPwq6Fbk5ysETyc9ylJyBGn2e/MEv6s5cnhzZkob3L5DK2eqvmyyW+3QqFO0cr6bwpK22txnbXr3N+zZYICHIbBPKZo+AUyGb5/hbtZlJQJTfg6CIxeiNaJKp3WSD7f9hNblUuOvLUdg/uDTXm0NySSjREAylfzHoECenEKnwszoUp7AVW0+O+MWRuBG0itaFWEucFWto0VI8oe5X0Sb3F7ofQ9LaiM62zmYMMb4ENPcNSD7bQ0b0zdY5PvoJfXsq8UCZ6klemXSeeAuZ05P9fod7+T8oGkARR5p7BH5FJrYsxD5jus32AQ0Voekc4g==
Received: from AM6PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:20b:f0::43)
 by AS2P195MB2274.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:591::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 08:02:18 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0:cafe::6e) by AM6PR04CA0066.outlook.office365.com
 (2603:10a6:20b:f0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 5 Feb 2025 08:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:18 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:17 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:14 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 03/10] board: phytec: common: k3: Introduce
 PHYTEC_K3_DOFITBOOT_DEFAULT
Date: Wed, 5 Feb 2025 00:01:39 -0800
Message-ID: <20250205080146.1944928-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|AS2P195MB2274:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b2f578-262c-47e3-d22d-08dd45bb698f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlFlTB10VBPtZEx/wIzFwMltFvfSfz4VoQ7xneGIr7uw1YtBSvhSP5SIddM5?=
 =?us-ascii?Q?FVVMnPb51mH0DMuxeY4NapmRsL55o/UkC79cUIl2L57vXaYUSiFGmyyJ4ZJz?=
 =?us-ascii?Q?pZCt+O/nrCNj7lCmB3WrWAbpqb2bqwMngANw08ule/UR2NuejEZlCtYkvtSK?=
 =?us-ascii?Q?A+LIDsxaIZ2e3lXWkbKlAgloni35h0DJDrzAFHsdTT8wO4SioxgHuImqslGN?=
 =?us-ascii?Q?V7WrgOGRveHkIdmNLTrgGEoYP107ligKJm4nULvTS207gMH3uIhT0QHRunFc?=
 =?us-ascii?Q?1pGumlFKngPN36E9s06DvEBqq2zXmS1FzuKqvTJkh163cLwYb6Q/EpcsJakM?=
 =?us-ascii?Q?Kkga9qnuJYBqADOHr1nW4ADZDK/+knK4kOlNhNlzucifihNVSV7ugdvH9HuN?=
 =?us-ascii?Q?+fSPgCvH242b0URMyXdpAUXbzyijF+xDguRnkY7/lEh/naPkNV+GVqr7Rn8D?=
 =?us-ascii?Q?LDEPUsaPLro1EmSu2y8ceTAjdhmhyLuFTMFvCF8nhXeu1mMMdUSj3tPOf89Q?=
 =?us-ascii?Q?RjlqXAWIr3ZwKCPC1qJQU2CPdVlI3VQejUhGKgBbuGn3/H55udXXd43i4j+n?=
 =?us-ascii?Q?I8in3aSnkfSGn1wFKvgoFXYIjoUaPyg06LnB+Y+XMYbTd0rShKAw1vS6BuA+?=
 =?us-ascii?Q?yz7lJfrFljxmm/EdTZZYNP7gohK3J/wsHPpwgQtmuOgbDbU6fHNOwX4uskCC?=
 =?us-ascii?Q?fH7OtZYCng9qEvhoU4bvroiJT4Mk/oMYp8+I+IVqu3W/qrJkoEVxLXxes8cS?=
 =?us-ascii?Q?EutNx1oaNB63kZP3hgQiezNLoD1z/RgCxNtgVqrwFx+Jp14dTQFlCNU0WOuR?=
 =?us-ascii?Q?B4AoIc8Lf0PpxNNoJ/CZzNuRkn5BkfjpkX3LDjrwpLp6O4E7pXZJ4lvgxwW6?=
 =?us-ascii?Q?ZoOS9Gb7xSzoI/wX6RJr5/Fi0EZrou2TY7LCiR6a1/puFDiVjhMxVP7TfN0V?=
 =?us-ascii?Q?NISjXhQDM2EPewS3sso3JHWPlbyischbtRU4NHjrVknuAa/7BEyjKPQPNtEF?=
 =?us-ascii?Q?iL/67SFeXTtkDguEl8E+QO6Za8O/jpqf7IsC96KkL1oSzQx/opqujtbt9ltW?=
 =?us-ascii?Q?rzRHp5FznxCwsIj0PnVKGJUi1wng7/sZnK9uaBcow958wH965QsQlPz1ohCp?=
 =?us-ascii?Q?pKRcax8NqrYxBtL0avPdFs1bzk41pndMQ53sDN04vATqwOznwV7ks3wS3ZZn?=
 =?us-ascii?Q?UNatpxLRL9AqED3ntfZ1r568Pffieg80pPycAcB/0pq0Kjq8hYsk7q9mLVPS?=
 =?us-ascii?Q?g0h1KvV/3rCLb0+jlrUVrrJBJkO9Q9CCwTwtBvL7VhJLMiEc6R/7lU9BHaRw?=
 =?us-ascii?Q?hYPEbF3lHq7HalB7r5ZJCr7o0cSo4QlZSzzQ3MVH/jKWARyCszWfua194zrw?=
 =?us-ascii?Q?QacwDjI/fq6s2pGCUcg8bvea9JfFnCuIR6USGI1dium0zEPB9zfyC3qSbSZv?=
 =?us-ascii?Q?d6oP2iwpC/xiIl06V8mW4hmKyr32/z3m4cI6q4QO3oYb8Pc19UzPBTG9Ohcl?=
 =?us-ascii?Q?IAvSYXBdrHuqV1A=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:18.8243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b2f578-262c-47e3-d22d-08dd45bb698f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2274
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Provide a Kconfig entry to set the dofitboot variable during
compile time.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
index 3404864c39b..c2996016395 100644
--- a/board/phytec/common/k3/Kconfig
+++ b/board/phytec/common/k3/Kconfig
@@ -46,3 +46,10 @@ config PHYTEC_K3_EMBED_RAUC_ENV
 	   Provides logic to select a boot partition based on environment variables
 	   and switch to the other if the boot fails.
 	   Includes include/env/phytec/rauc.env.
+
+config PHYTEC_K3_DOFITBOOT_DEFAULT
+	bool "Boot from a fit image"
+	default n
+	help
+	   When set to 0, the system follows the standard K3 MMC boot flow.
+	   When set to 1, it attempts to boot from a FIT image.
-- 
2.25.1

