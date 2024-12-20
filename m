Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A143E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FFA8036F;
	Fri, 20 Dec 2024 15:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JNJ9LisL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0148037B; Fri, 20 Dec 2024 15:48:01 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DDC80243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46788c32a69so22491361cf.2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734706078; x=1735310878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yXnl+Y++NanNiL7Vjsq/kuMNnrXNAVMGw0FPnc1xrDU=;
 b=JNJ9LisLmRtCIFpgyh/HS003nIdRcMDg5egJ/4IkwTaC/mtLgAlrFJOO1RMhoMZfsY
 5SqlIQO8i/LNQOowFclxywXn4Lp+EbYMtuSb1CFUs47yGfUFjKsJDiUVpZjMl5uzxs3V
 9Nzr8bQiPI/0oxO6GoRzRM2bBy/heBwMpcWeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734706078; x=1735310878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yXnl+Y++NanNiL7Vjsq/kuMNnrXNAVMGw0FPnc1xrDU=;
 b=TfWCrPkBnPejSd8G4bWQgEHinXqscmdwLY/ZTlcL245fRL8F8ef6B3qPsAhLM01YhM
 L4r3tqtqHqL6dY/F3ZA2vozQ87fTJR9huJj83iRhMg4QU5xI3gHgr48kM+0qHl2/sKWo
 bk7LyfMHn2TOPpa1XD4mQBbK8grT9xu3/EqKNxOGGrM/Jxpjd/lqw2oAOT/jqMjFJILt
 NWR6tFXW7sm/qlWMU+2jmyv/bn1ZHopXP4nnjbaiWwCHxVchiKWj4q0o5YUxxSQkNuv2
 yqCoKWU0LeYRdSKbHrmwY691sbLhI6l6s3vvng5qC9VyAnI1oZGYzoac0+9YA39931Tz
 9OtQ==
X-Gm-Message-State: AOJu0YzlNP9wOZO964IY8CKBKfsb3jAGKWRL5KsGAtXmD9RiUX8RZAj5
 VcKSjaS4AxyL4pvFKXPm7bcKrXh1msMCpyouAqkZZfGq2B03PiupFlLpcF5YfDgbRNvKaTQwLiE
 OiEY=
X-Gm-Gg: ASbGnctAXHlL8S4dnLrbGLhwb93BqxpQ9446ylM3V/g8M8dKM3I+UCOABe1kagZGpRW
 B2vEzVCiWg/KiWqF36ALyYIARnP/DsXb2Ej+kIy74se4wl6ItB2DHKf6GBCk6PA2KcgA4xOBGu8
 8gt/zbH3Q/DMRnvIgH05IxOI97Oy037Pw/u3/3J9qX30/nGyS3hfwgu/duZsx2zHd77j7R6zN3L
 qbPhkFtmQSRHaSzF+poC+xwIBjF7Ht0pHahEqF5qTmYKCmBE2ey1yGZUQ45wKnUdYEcVTxlCjGg
 1FI=
X-Google-Smtp-Source: AGHT+IFdEEC4HOxUmKVzQLKg+m8izzCbUCL+EjWaTBYKiO7bZdSye4fWam5mp6U4Qn8XJggc9PlL9g==
X-Received: by 2002:ac8:7fd3:0:b0:467:525b:e540 with SMTP id
 d75a77b69052e-46a4a8b62ccmr40826641cf.8.1734706077219; 
 Fri, 20 Dec 2024 06:47:57 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6892ddsm17218421cf.29.2024.12.20.06.47.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:47:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc/develop/distro.rst: Better document upstream locations of
 extlinux.conf
Date: Fri, 20 Dec 2024 08:47:54 -0600
Message-ID: <20241220144754.3734519-1-trini@konsulko.com>
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

First, the "Boot Loader Specification" link has moved to a new location,
so link to that directly. Second, that link does not document as much of
the extlinux.conf format as I recall the old version doing at least.
However, the Syslinux Wiki is the current location of the documentation
linked to in doc/README.pxe and so add a link to that wiki as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/distro.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 637bc27fc2d7..d80c2eff6192 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -68,7 +68,8 @@ Boot Configuration Files
 
 The standard format for boot configuration files is that of extlinux.conf, as
 handled by U-Boot's "syslinux" (disk) or "pxe boot" (network). This is roughly
-as specified at `Boot Loader Specification`_:
+as specified at `Boot Loader Specification`_ and more completely at `The
+Syslinux Wiki`_:
 
 
 ... with the exceptions that the Boot Loader Specification document:
@@ -440,7 +441,8 @@ way in future u-boot versions.  In particular the <device type>_boot
 variables (e.g. mmc_boot, usb_boot) are a strictly internal implementation
 detail and must not be used as a public interface.
 
-.. _`Boot Loader Specification`: https://systemd.io/BOOT_LOADER_SPECIFICATION/
+.. _`Boot Loader Specification`: https://uapi-group.org/specifications/specs/boot_loader_specification/
+.. _`The Syslinux Wiki`: https://wiki.syslinux.org/wiki/index.php?title=PXELINUX
 
 .. sectionauthor:: (C) Copyright 2014 Red Hat Inc.
 .. sectionauthor:: Copyright (c) 2014-2015, NVIDIA CORPORATION.  All rights reserved.
-- 
2.43.0

