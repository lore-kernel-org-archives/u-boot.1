Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06BB781E67;
	Thu, 27 Mar 2025 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D160081E13; Thu, 27 Mar 2025 16:33:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9761A81DCA
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E381655;
 Thu, 27 Mar 2025 08:33:49 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DEF83F694;
 Thu, 27 Mar 2025 08:33:42 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 12/18] mtd: ubi: annotate fallthrough
Date: Thu, 27 Mar 2025 15:33:07 +0000
Message-Id: <20250327153313.2105227-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The UBI code uses an implicit switch/case fallthrough when handling two
related cases of bad header errors. Also there is a switch/case for unit
prefix handling (G/M/K), which accumulates multiplications.

Add our "fallthrough;" statement-like macro before the respective labels
in both cases, to avoid a warning when GCC's -Wimplicit-fallthrough
warning option is enabled.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mtd/ubi/attach.c | 1 +
 drivers/mtd/ubi/build.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 2ef8fde3d32..306da509ec4 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -934,6 +934,7 @@ static int scan_peb(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			 * be a result of power cut during erasure.
 			 */
 			ai->maybe_bad_peb_count += 1;
+		fallthrough;
 	case UBI_IO_BAD_HDR:
 		if (ec_err)
 			/*
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 104537784ab..50e43928af0 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1400,12 +1400,15 @@ static int __init bytes_str_to_int(const char *str)
 	switch (*endp) {
 	case 'G':
 		result *= 1024;
+		fallthrough;
 	case 'M':
 		result *= 1024;
+		fallthrough;
 	case 'K':
 		result *= 1024;
 		if (endp[1] == 'i' && endp[2] == 'B')
 			endp += 2;
+		fallthrough;
 	case '\0':
 		break;
 	default:
-- 
2.25.1

