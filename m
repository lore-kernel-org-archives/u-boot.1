Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40EFD49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED50489451;
	Sun,  1 Dec 2024 16:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lzVnP8tH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863558911E; Sun,  1 Dec 2024 16:25:35 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508DD894B4
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84194e90c0fso226518239f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066727; x=1733671527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Wv9Paw/PEpcpfIHYWTey/o8HkcvrjY4yap1Ff6+Re0=;
 b=lzVnP8tHKFQc/5E9pauk0It/erKu8/OcGqYfGqrriN3laewGDplNBhABmNiQf6dFPr
 nwdBmh0aWF/tENziLFWDf4bRPhL9RcocpKP1sV1qH13eywvsO9UjvtR9N5ofF20GFh/D
 ckDi/V0/0MoaS0ZrxSAZDGBL7Bh2FaNksAB6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066727; x=1733671527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Wv9Paw/PEpcpfIHYWTey/o8HkcvrjY4yap1Ff6+Re0=;
 b=ZipqH+NWl1zf5xx9oi26hHEprB1GSVB6JxH2xKZLLZOFhUDqvVKCI/zViG1Hg3yrV6
 Q6pmnbD5yd/Bz83wI3FB+wOU8xV8u2B9VG67jKN/bmVjeEQGkJCRiNP2PYRxyIW6oqUM
 LpBbKA5U1r78gvyhUzZAJGkE0wxXIRrSFK6y/+3NK87KWBt+RVl40/fzf433pK8gtgMg
 lXXmpPzQeMFEwpVTb0x3KeMGJzyeTVle6JZ9U4kFBSiLLqLBhZzjcRhde30s1IkcQkSh
 fuwPZW53Ac5fZczfw+f978/bubtR+7QE1nhknuUDUswno/isNv5HAAlU+FxXptDCF9fk
 okJw==
X-Gm-Message-State: AOJu0YzL2LHWz4iZCucFbjMKNWTVyCO54cnx1jN6besV4MVk25asy14J
 rY/QBqo/TQOgGmlcU2JsJTMFWFddKggLqUxM4XRxllVCp6uqmatvanjXjdbEXdsJHPGyLF6i3Fk
 =
X-Gm-Gg: ASbGncun3zqtfHEMLDrnjp2Vn1h+/WJE47qtn7BL9K8qw761bKLIlb+619roYCc84fm
 KHyasAhrDbSyJJZEKG+6EEeV+6IcnqopAnU9nya2eS8vrzHTILyRFYeN3cqWEXD8KdyN/DAC2rz
 5QqptrTDBdUnB4/AS+3rCAXg4msDc02Ho3alCBtbwDbc9rbn7tTBIMAXJtT1RuRASAtKxEyxh6w
 mSpGLufOjt0/MN6LE5IG2pE+v31/O2DDqWk7Lt0si6B
X-Google-Smtp-Source: AGHT+IEmfpbA7uqtEug+OAh3uoAvXDb2PhEFSXu6RsZ+VDPz9VzxWuG1Bwls6c6K+Qk+9uEwszyVMw==
X-Received: by 2002:a05:6602:160b:b0:83a:97e7:8bcf with SMTP id
 ca18e2360f4ac-843ecfeee7cmr1701170939f.11.1733066727597; 
 Sun, 01 Dec 2024 07:25:27 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/25] efi_loader: Show the resulting memory address from
 an alloc
Date: Sun,  1 Dec 2024 08:24:24 -0700
Message-ID: <20241201152505.1666789-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

Update efi_allocate_pool_ext() to log the pointer returned from this
call, which can be helpful when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Show the returned address rather than the pointer

Changes in v2:
- Use EFI_PRINT() instead of log_debug()

 lib/efi_loader/efi_boottime.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..f27b3827ed2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -13,6 +13,7 @@
 #include <irq_func.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <pe.h>
 #include <time.h>
 #include <u-boot/crc.h>
@@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
 
 	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
 	r = efi_allocate_pool(pool_type, size, buffer);
+	if (r == EFI_SUCCESS)
+		EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
+
 	return EFI_EXIT(r);
 }
 
-- 
2.43.0

