Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E80C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 10:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4120C87702;
	Sun, 23 Jun 2024 12:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CQ0sYJS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0518487DC7; Sun, 23 Jun 2024 12:58:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD4F8751B
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 12:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB2A13FA5E
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719140310;
 bh=WroRLectNBOzXGoy2LqOuvTOjfxcri5nE/pi33N+Gjo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CQ0sYJS81HtOmGqZl09lJchFR2xAPoBnh1n129pfy5xEjO+iNciZnJkhQ382d7fwo
 g2AkF7m0qEyvQmROKX6BB7xmorgnloPvng9HmCzH15TlKml5inGQw/g/jHJ5LvcaiR
 LrF3397IrbFwE9KJN0WPbg731mPb7THxz3uetZ3jWPGOEapuhvsEGAhCYvt0wFaR14
 /41g/hpzdfh2BNHuegiH1eHwBEJkt5F5TACzThuUa4QvqOs3sZnMh6HbGn7z6YbsbC
 LMfqwdWhJGrestPXzg3HWoJm31kVG0Gqf65eKuDQhvmP+E7HZnXLOF5N5BKorug6Fd
 Y4jbcsBUZsQUQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-364b75a8194so1589435f8f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719140310; x=1719745110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WroRLectNBOzXGoy2LqOuvTOjfxcri5nE/pi33N+Gjo=;
 b=akPoy4th8EHY+0M2PeJlrUd9ExHwtzu0rzQZCJCsFYgfwRCpXyj0EIZlJH5V1JeXZT
 4/cWkgi+pGargiFuspLfEJzQWxwtkuHf2VdgWO0s/PXXPQZR+O++gYX1Q6mzEDFydOWj
 JMO36dXpHZR/ocqGbR4SV2ht/o8AiMfvxeeE1BIyxb9J4oHIEB71cADPtqUATv6XxOyb
 cupDYwAjGUnSoRTRGMPPD1hkb+pTF2zh8SN+NuBmIpo3dlWFFax5o8tr6fv/YitICXVd
 tKjOf1YUquHbJR3bhdlq6WAq/YobmwkGca91g0KguitVxXsdNdl0CqUSQjUy7likun4a
 ob5w==
X-Gm-Message-State: AOJu0Yy7+I7vQPPmv3SbVLpo7YcohLZpi+SNHSZaDBKXw+wwEjtJTRxB
 hT+EUxY2tJFoRntGehzt972+ACLJED92qw+DJ27IZ9LSKLIGiikvE9BmuLgemm+gH4/STD1omx1
 tBf/as2DGLFczQgWhn/xvhTMsB69zCs6WqJ8CSGbqd6axPne9wlv9JyFPkOeuNe5AGdU=
X-Received: by 2002:a5d:47a9:0:b0:366:ef03:a8a2 with SMTP id
 ffacd0b85a97d-366ef03a937mr489705f8f.54.1719140310511; 
 Sun, 23 Jun 2024 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTmLVDZL6vHfWtVzNFsOBh2GMff9YpxwDigbX/9eVTbnQ7cBG8aKU8sTsAT9MosQsLgR2NYw==
X-Received: by 2002:a5d:47a9:0:b0:366:ef03:a8a2 with SMTP id
 ffacd0b85a97d-366ef03a937mr489693f8f.54.1719140310106; 
 Sun, 23 Jun 2024 03:58:30 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f670csm7070163f8f.11.2024.06.23.03.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 03:58:29 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [U-BOOT-TEST][PATCH 1/1] travis-ci: SiFive Unleashed: avoid format
 warning
Date: Sun, 23 Jun 2024 12:58:15 +0200
Message-ID: <20240623105815.62434-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
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

QEMU expects the file format to be specified even for raw files.
Currently this change only suppresses a warning.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 bin/travis-ci/conf.sifive_unleashed_sdcard_qemu  | 2 +-
 bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu b/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
index f3c3da1..e84ce7d 100644
--- a/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
+++ b/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
@@ -6,6 +6,6 @@ console_impl=qemu
 qemu_machine="sifive_u,msel=11"
 qemu_binary="qemu-system-riscv64"
 qemu_extra_args="-smp 5 -m 8G -nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/sdcard.img,if=sd"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/sdcard.img,format=raw,if=sd"
 reset_impl=none
 flash_impl=none
diff --git a/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu b/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
index e28bfc4..56a7a0c 100644
--- a/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
+++ b/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
@@ -6,6 +6,6 @@ console_impl=qemu
 qemu_machine="sifive_u,msel=6"
 qemu_binary="qemu-system-riscv64"
 qemu_extra_args="-smp 5 -m 8G -nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/spi-nor.img,if=mtd"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/spi-nor.img,format=raw,if=mtd"
 reset_impl=none
 flash_impl=none
-- 
2.45.1

