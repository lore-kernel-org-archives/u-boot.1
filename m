Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338ADE8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6588410C;
	Tue,  3 Feb 2026 14:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472A483FF8; Tue,  3 Feb 2026 08:31:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9E33B83FC8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698DB339;
 Mon,  2 Feb 2026 23:31:22 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9433F3F778;
 Mon,  2 Feb 2026 23:31:27 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>
Subject: [PATCH] mailmap: Update email address for Sughosh
Date: Tue,  3 Feb 2026 13:00:46 +0530
Message-ID: <20260203073046.328159-1-sughosh.ganu@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:53 +0100
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

My Linaro email address is no longer valid. Update entries in the
MAINTAINERS file, and add a mapping in the mailmap file.

Signed-off-by: Sughosh Ganu <sughosh.ganu@arm.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2fe12e76d0c..89a61a09800 100644
--- a/.mailmap
+++ b/.mailmap
@@ -140,6 +140,7 @@ Srinivas Neeli <srinivas.neeli@amd.com> <srinivas.neeli@xilinx.com>
 Stefan Roese <stefan.roese@mailbox.org> <stroese>
 Stefano Babic <sbabic@nabladev.com>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
+Sughosh Ganu <sughosh.ganu@arm.com> <sughosh.ganu@linaro.org>
 No generic patch CC mail please <noreply@example.com> <swarren@wwwdotorg.org>
 No generic patch CC mail please <noreply@example.com> <swarren@nvidia.com>
 Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index a0f87da67e1..8007236a7fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,7 +1250,7 @@ F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
 FWU Multi Bank Update
-M:	Sughosh Ganu <sughosh.ganu@linaro.org>
+M:	Sughosh Ganu <sughosh.ganu@arm.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
 F:	lib/fwu_updates/*
@@ -1629,7 +1629,7 @@ F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/ram/thead/th1520_ddr.c
 
 RNG
-M:	Sughosh Ganu <sughosh.ganu@linaro.org>
+M:	Sughosh Ganu <sughosh.ganu@arm.com>
 R:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
 F:	cmd/rng.c
-- 
2.43.0

