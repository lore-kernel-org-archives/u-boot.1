Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69160E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C9B801CE;
	Tue, 17 Dec 2024 17:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vi3fVwM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E499801FB; Tue, 17 Dec 2024 17:22:22 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBFA80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-468f6b3a439so13458221cf.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734452539; x=1735057339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qt2YB+6vGQbtPpsbYbu2keNRHQTg1NAA93bng/0vtj4=;
 b=Vi3fVwM+mPIKe86nSzTPQIaepGRpV+2hNIdX3QgHtDkLO5T2L5wjCQoB7EvFbaewww
 vgMgCtHuMtZlUYbahnW7L0gRGUKbAvckIPilThVlp6CSP9pZJPX8iykQnNnNhdFyAXgB
 Pv+yb9Cof5rc2wfmQuPGa5feJ4EIy3qtp7Seo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734452539; x=1735057339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qt2YB+6vGQbtPpsbYbu2keNRHQTg1NAA93bng/0vtj4=;
 b=EXf1BjInG/nMkSpq5M1oKAPUvxXG+sa4G6UmXSZ690WCcKV/ySizQhd8sqOoBQCF2W
 kYShJm0VbHHDFxh96h5oamxM1Vjl1Q7Vc3Od+Esz1v8l2LExb7dV4Bvhccmuxea/17ev
 +h6zbiDs7WXPsQqGb7j6V65p7YM9kC5rml2iSJVtaCudbc9PTtxWXjvn6wQQ0HS73s4r
 gNjRh1BXWTRFvJVpxtKBZqBDRrc+nYA2TApXanQaie12SUVkk8BUbOR+0+TKoXX7TP04
 8XfMVv0eE+t7grCsYgNuwY+Of3LvzkGxeJdcUOiL6yiEE9oYBYE1SzHGUDQcwA6WzkRR
 w1+A==
X-Gm-Message-State: AOJu0Yw0yGrBTeLkk/Dqn+3+9dC3YMaKR0KZwAlCdfIBJXXNWgXOVK9C
 oQk1hS/X2T3+R5kxaieU9FGClX4dHFj9ir2pIzUbUQrE7XtEYNzgxpVzXXbcsNvYTmLGyr0dJSR
 U3B0=
X-Gm-Gg: ASbGncs+RzWG738ggt/L2BHTvVbkb/sgyFrOCAWRL+OK9I2v1Az2b0ZkiS0rsTAlPKA
 Y+6UvtPMFcw9NdnpIVJXZXH6na3FKId/7/KfMbasFzMRcvis6gjOTpRFA2pX6il6rgJD2jmkgAv
 wsgJDUbFjXSNKzrvf2t6plB3VHDS8Z/plUD5sFztXPxKVmgGx6BuGEcjcgOLnZIu4h5r2dj17J/
 GnFS5ymcGfd3jN535k0iilbGWUwrVCpZsKJiAhriMdjdPdAwUonsiLvrFmDU6AaTwZ2r2FCp7oh
 bDg=
X-Google-Smtp-Source: AGHT+IHZ6yVxUfw9MnVq018mVA+EQtNixLAmUz81fmZf+soncgY7nv+8l80Wx2y4AVfDsgR5+HnUUg==
X-Received: by 2002:a05:622a:1450:b0:467:6e45:2177 with SMTP id
 d75a77b69052e-467a574f879mr269603071cf.12.1734452538773; 
 Tue, 17 Dec 2024 08:22:18 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ec33f5sm40762731cf.74.2024.12.17.08.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:22:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] chromebook_coral: Move CONFIG_BLOBLIST_ADDR to CAR
Date: Tue, 17 Dec 2024 10:22:15 -0600
Message-ID: <20241217162215.3210121-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Reading doc/board/google/chromebook_coral.rst we can see that at some
point it was intended to put the bloblist in CAR, rather than DRAM, at
some point during development. This is fine for TPL/SPL stages where we
have very minimal information stored in the bloblist and so we can set
the limit there to 4KiB and then expand it to 196KiB in U-Boot proper so
there's room for ACPI tables and so forth. We also update the
documentation to use the same location for CONFIG_BLOBLIST_ADDR in both
references.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Looking at https://source.denx.de/u-boot/u-boot/-/jobs/978027 this
brings Coral back to just having the known TPM issue to resolve wrt test
cases.

Cc: Simon Glass <sjg@chromium.org>
---
 configs/chromebook_coral_defconfig    | 5 +++--
 doc/board/google/chromebook_coral.rst | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 0fb730497386..b4f7e61ad0d4 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -2,6 +2,7 @@ CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x3d00
+CONFIG_BLOBLIST_SIZE_RELOC=0x30000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_MAX_CPUS=8
 CONFIG_SPL_DM_SPI=y
@@ -44,8 +45,8 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
-CONFIG_BLOBLIST_ADDR=0x100000
-CONFIG_BLOBLIST_SIZE=0x30000
+CONFIG_BLOBLIST_ADDR=0xfef10000
+CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_SEPARATE_BSS=y
diff --git a/doc/board/google/chromebook_coral.rst b/doc/board/google/chromebook_coral.rst
index 1eda769c7528..b48afb279386 100644
--- a/doc/board/google/chromebook_coral.rst
+++ b/doc/board/google/chromebook_coral.rst
@@ -243,7 +243,7 @@ board_init_r(), as per the rules, and DRAM is available then.
 SPL sets up a bloblist and passes the SPL hand-off information to U-Boot proper.
 This includes a pointer to the HOB list as well as DRAM information. See
 struct arch_spl_handoff. The bloblist address is set by CONFIG_BLOBLIST_ADDR,
-normally 100000.
+normally fef10000.
 
 SPL uses SPI flash to update the MRC caches in ROM. This speeds up subsequent
 boots. Be warned that SPL can take 30 seconds without this cache! This is a
-- 
2.43.0

