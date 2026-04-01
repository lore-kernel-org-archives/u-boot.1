Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBBD35171
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502A383CF5;
	Wed,  1 Apr 2026 12:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gC5CGO03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE46184020; Wed,  1 Apr 2026 12:25:12 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EC783CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoO/csXTm8AsqxceYlr4tixbJsqGxvaiv65b+0UJ2XygXUjZGocdvEIgpGUzsaRFpJ451Pc3SouPaitMDUqHvtB6WEQNMW3o9DEzmiCPi6oXgEZ69WcUgU9fXTkht0IRFzPWouyOvYwyITI0alCPQLbZIVKnUSmkS8v/TuYUcNuKL+khOelxxQ7lsbDicjliHOZzd4v+F4R06CQlTS0OTR7XFSI8Pjq9d97y3wCLsIyMLl+Pg3t0Sqz4pv9qCudDAoKUEgNOAMcJq0X5I8sksaMYrD2f6G1Mlg8A88NllMV/pxR7/YQMmDaX3PbuQ16C02iw6TcFNFWaL5TKCuxoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+f9FFuOwzdBzBv/Q9yTKU5iQRFfLS4zKNOtVsFyjl8=;
 b=y76llPbWWSbPY5bZ6hPMKG0tcfJmxqhi7/dqMlm5NvpETJ25mBjxjYKGE+LqbjJWG7+B0O0KqGzY11QbcI0QMtyZfLY5JGcTlg5rXrrOerlpjdAl82WKz0TPJCFHcJA3sZfDRzl7wyeB6aZepEG6WC30mvx8jVy4x/El34h3thjTnubonsDwP0D5z1/YZprkd2+RxY4BjOsXUhfIIcGT5OR6iYZ9AR9oQb0duZOvNwtfRXz5ZzGYVJF48AEYwOxCbx5MKK6DAurH1B/gdXGJaPc2L+uba1BLllwhyqPWO3BLeQurQCKOb/5A1Q8NOi9n6RtelpTkZflXjJdijqp5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+f9FFuOwzdBzBv/Q9yTKU5iQRFfLS4zKNOtVsFyjl8=;
 b=gC5CGO03EP8lD/GZ+YEBZYyaW3ez5Ay99e+OXqj89Kh3duGmH3HTzezbG17zGB32ZJCLdVelY700nJe+naNZCBgOScElzdeKfOaCsZel8fkpGZ5o4SvqxAJrjOWDpABBKQHd/zRd9az9UBYbuKDSesZwtYtXlT5FIViV9h998f4=
Received: from SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::15)
 by IA1PR10MB5924.namprd10.prod.outlook.com (2603:10b6:208:3d4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:25:07 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::40) by SA1P222CA0189.outlook.office365.com
 (2603:10b6:806:3c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:07 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:06 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:06 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631AP5dM362221;
 Wed, 1 Apr 2026 05:25:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] fdtdec: Deduplicate iterator function
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <marek.vasut+renesas@mailbox.org>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260331080117.2370092-2-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-2-ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 15:55:00 +0530
Message-ID: <177503910095.1968416.2027095657254228780.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775039103; l=599;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=WHWIvkPTeennLvAgUkT6SZiUecNcVLNrS0QFGgTJbBE=;
 b=eJM+Oxvn9rFvGEDUejAJAn5R7qrcc8SXpiHAFhbPyYmOMmOtT52ZlL6A1EIkknMarWZjN76PE
 V+GDIyeNYKNAL1VejRww9TG/P9m+j/DXfinNdp59TMJsvgTlnuhaRv4
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|IA1PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 47451ad4-efa5-488a-4fa0-08de8fd8f22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TQGz0yGpg3GKhU1i4PzuxqWRkoEgopHKy4ds8OCdxQEhdo/bGOdPRroqItJTEW52hHaGjj9y6y240THpUxR0632Oqhe80Ml5QT0QgpA5+aG6S3ItLKT5YDfmSnly0/5RR1atXpHfoF/4eNafsZTz/5qS4+RCQwbLPS7QVPHCFMLIkBOCnhXBFYzwWzKFzRS3DsndjwEr2sKHOZ/9kdibxrkJmTsO2i1WuGV9AF91YVZAaP25bznEkuCRs+QlM1QLQj2vE+j9XdN7CXteb0Bi+cLD73JEpCxyRh7wlfe6mU/n2ikZQGj9jH3TuNI8x0/dibcZCZEfq+k38d/+Er8WXQHFcZGRbG9UY23M5/qRLgzaCl41alhFKGg4YiI4jRIdt7HdzIeN6qOi/ucPXuDoa1VmtmltPHZaUB2rdWRmMvlIEPLGsmYT/3zZwZC30v0GPHxVP1mg5llxDigF7447ydhbS2HX0yV3S6n1IIWpaABfavjJhSaM0rzXUvfr10IdGF2hVMwFHi7aTWtCxkRncuXG7BC/exQlDcS4sGBx0w09db9HRPF2unInLfCKYNQ2Iut8qtSful3rdaM/126szNBK0Xj9/JYHTcB+Ke3L5GEyWiea/wdmmOqbIEleKUN/4q+Qfg/Q6UukhSS12stUcYtVbWWFTcfkw+djGY21+AssJOaz7SG+jRB976tP5PYxntE6lidGlXLBq6FEw+b/vYRBJsc8NuoQHOpvO1duT/tiTeyL7FcqAkywCMj2SBqR5GsoxL9gkqa65sEWtetscA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /JBwzSsZY4UytOopEbWDKO1sti7EKXskRtMaYBb3pYuoairuk+hGkxH/W0Q0TgU2Qtqaw+oLHWjfkrwMAnstgPyAT0H9xZ3zPBDRIBNfnhxikTn/4aGxnuXumfKgFxECx8bEyaIjylOg6NMP588QXY+bMI9bc1QbhkJ/q0nRGGNl2yxlBjflgCyfALzd7SsLcV4jBnohpwc3WJsMJfm4HXPjh7teziEekTvTPkifcE7mL78LCBV5fDLtMmamN1VIa8eLyI/vg2dRpa4//nfOjmHA5DUrjpbP8gBXC0p65GnilDYbOLZolXy3VlXbXQz3zmkWPck7Jfml2xgZcG5hUT6e/2ECj3KYpCfkjKf61lvefnUumAzyfbXpU3DNVGGxEvsJ2glV0W7GPn4hHvu2+4RFiHvU/yH0nynEtbIsAjZuzUZz586UOD05x7r2yPps
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:07.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47451ad4-efa5-488a-4fa0-08de8fd8f22d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
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

On Tue, 31 Mar 2026 11:01:11 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
> implement the exact same iterator over all memory banks, the only difference
> is the body that is executed for each bank. Deduplicate the functionality
> into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
> function pointer to a function which implements the body as a parameter.
> No functional change.
> 
> [...]

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
