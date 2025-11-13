Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89768CD6E41
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CC983DF7;
	Thu, 13 Nov 2025 13:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="usoSQ8S/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PLkfZuzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D846183DE0; Thu, 13 Nov 2025 13:21:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDB783D77
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d6fXM2QzHz9v6Z;
 Thu, 13 Nov 2025 13:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gmodMtVE077NVdAOreIUUAtR4TUyMO5QdIloA1HvRo=;
 b=usoSQ8S/5CyVsLBpTX8CjjGJYAVnSCixSlNAlhLZmDdKqJR9i0uHciouHX/lfiM0YECDjN
 NOlZ+Jr9gZHuwyk0buHNm0VZYORruntIB6g2cC0MeUph91aV4vC9Q5rmAmHp4jZ4oMf1fy
 oHYmr0XhP8faF6fLOAg6RuuSoOpVEgRWNCsgDOxVqw0jD/9OaerJksVJ2z3RUxu8e9dZWm
 yFytMnbrJy0Wj3MK0V7sdo/2ZpggK+bcrgzMPvbORpJou2gNsQ0UpeOJFlQZbM/5U2Atiu
 kWoFTADpMZH8zdaqZ+wUigQBvoSqcRoccNqUhoqgTpgsvSbSmJRBB3uJ/BWNNA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PLkfZuzc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gmodMtVE077NVdAOreIUUAtR4TUyMO5QdIloA1HvRo=;
 b=PLkfZuzctZIU6mVPEl7JQ3QoUtsUzq6GQdmAgGO/0X7EPbZofX3G3JNyBTbh7sU+WsioOP
 kqZKmrOKbkbc8ga3seUQ9VrB/V7YE1kJRgx7bzU8ylE94wHaJh9UVgUF+oWn0LPHhJ1E0j
 6heFUnL4LeHO7XOwEsE68lLSDp+dOlGzKu2+m2GylB/Cpn9XubFJy7ZflhzQfJIDAMiTkK
 8R8obol7r/oFdl0R04d6ON0RWYzUWSVwsP0n3zBsD4ryfkb1n9Dt1QTSnpzkLVaC944Hb2
 6Blvw2UJTNZK1xbe5gJsF+u2UdUeasP5qC8FT/vW1YvLGvUURwqymsxUrSEUyQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] Synchronize DTC to 1.7.2
Date: Thu, 13 Nov 2025 13:21:07 +0100
Message-ID: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 756ce0c5d42fc337039
X-MBO-RS-META: h1xs3tpkbk184t5dgfqcmur646tdp7g3
X-Rspamd-Queue-Id: 4d6fXM2QzHz9v6Z
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

Synchronize local copy of DTC with Linux 6.17 , using commits picked
from Linux kernel. This also includes two fix up patches to make the
DM core work with new 8-byte alignment checking in libfdt and another
fix for NULL pointer check that is missing in libfdt.

This depends on the following patches sent separately, which fix
various 8-byte alignment problems in the code base:

 - boot: android: Always use 8-byte aligned DT with libfdt
 - test/py: android: Point fdt command to aligned addresses
 - test/py: Use aligned address for overlays in 'extension' test
 - sandbox: Fix DT compiler address warnings in sandbox DTs
 - sandbox: Fix DT compiler pin warnings in sandbox DTs
 - boot: Assure FDT is always at 8-byte aligned address
 - arm: qemu: Eliminate fdt_high and initrd_high misuse
 - efi_loader: Assure fitImage from capsule is used from 8-byte aligned address
 - MIPS: Assure end of U-Boot is at 8-byte aligned offset

Marek Vasut (3):
  dm: core: Check ofnode_to_offset() return value
  scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c
  libfdt: Check fdt_offset_ptr() return value unconditionally

 drivers/core/ofnode.c                | 384 +++++++++++----
 scripts/Makefile.lib                 |   4 +-
 scripts/dtc/.gitignore               |   1 +
 scripts/dtc/Makefile                 |  23 +-
 scripts/dtc/Makefile.dtc             |  18 -
 scripts/dtc/checks.c                 | 686 +++++++++++++++++++++------
 scripts/dtc/data.c                   |  74 ++-
 scripts/dtc/dtc-lexer.l              |  38 +-
 scripts/dtc/dtc-parser.y             | 109 +++--
 scripts/dtc/dtc.c                    |  58 ++-
 scripts/dtc/dtc.h                    | 137 ++++--
 scripts/dtc/fdtoverlay.c             | 214 +++++++++
 scripts/dtc/flattree.c               |  70 ++-
 scripts/dtc/fstree.c                 |  26 +-
 scripts/dtc/libfdt/fdt.c             |  84 ++--
 scripts/dtc/libfdt/fdt.h             |   4 +-
 scripts/dtc/libfdt/fdt_addresses.c   |   2 +-
 scripts/dtc/libfdt/fdt_overlay.c     | 386 +++++++++++----
 scripts/dtc/libfdt/fdt_ro.c          | 100 ++--
 scripts/dtc/libfdt/fdt_rw.c          | 101 ++--
 scripts/dtc/libfdt/fdt_strerror.c    |   1 +
 scripts/dtc/libfdt/fdt_sw.c          |  26 +-
 scripts/dtc/libfdt/libfdt.h          | 428 ++++++++++++++---
 scripts/dtc/libfdt/libfdt_internal.h | 141 ++++--
 scripts/dtc/livetree.c               | 156 +++---
 scripts/dtc/srcpos.c                 | 190 ++++++--
 scripts/dtc/srcpos.h                 |  31 +-
 scripts/dtc/treesource.c             | 319 ++++++++-----
 scripts/dtc/update-dtc-source.sh     |   7 +-
 scripts/dtc/util.c                   | 122 ++---
 scripts/dtc/util.h                   |  61 +--
 scripts/dtc/version_gen.h            |   2 +-
 scripts/dtc/yamltree.c               | 235 +++++++++
 tools/libfdt/fdt_rw.c                |   2 +-
 34 files changed, 3128 insertions(+), 1112 deletions(-)
 delete mode 100644 scripts/dtc/Makefile.dtc
 create mode 100644 scripts/dtc/fdtoverlay.c
 create mode 100644 scripts/dtc/yamltree.c
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de

-- 
2.51.0

