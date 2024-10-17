Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7188D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8097289266;
	Fri, 18 Oct 2024 01:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TPFi8Emd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211458924D; Fri, 18 Oct 2024 01:25:04 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83D7890F4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83ab6cbd8b1so35388139f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207500; x=1729812300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmmpgrs7TBP6tWd7J4uKNWG4NPC5l3NNGUM0JIYsH4k=;
 b=TPFi8EmdP3eUcodJi4qqGRvQ+7NRUMd/9h677mBSItCye/LcjeOQEGu3IWQkoxtF4C
 s3ahRKRrtJ36pPynzN1ovGtdlOhjthbTIjsipAIzbiNuP2SZO8XttG9r4xc+n3FEfFq/
 sKjjV5s/IO+oyshhjLwAwaSfBO8QOqrTDjxig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207500; x=1729812300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmmpgrs7TBP6tWd7J4uKNWG4NPC5l3NNGUM0JIYsH4k=;
 b=uOGYUSEhzll+PemWAyq2IIO4H/7zzyYyXJG1ojt529u5vjA4uKBrewOx+MAmz4RvPm
 8JvJXhP21gRLrUMFN4cFlzJ8KQXkDQaq0mBixW6EGxVeIQGFWqStWShQrhjkLfVrkt6c
 6kTsQevOFSJCIye5BF4aobr26LBlSQuEA/gVWpzc673qAiaXby24hAS/fq1oGCV/ALXD
 0pZ2+L6MXD9BGpdvGcJPqXXav/C0evBfQZo/ObkNUA5VOIsFR8vhfp3C7DItG+1CrpYv
 Z6xiBy+8Z67JPiZkXJRsqh4a5888AseROGm+GNYc3gei+9f64R7B0cjOKyz88c0A394W
 Dwgg==
X-Gm-Message-State: AOJu0YyOPV1CFYrQM815L5Zk1z1vtbMiJtchGfAPVJFgeZDgNYFis5Md
 jjABB5Jwekw8kCunLFmxTmYLy0cqAlGmJgC3+TMl/bnLbVnXYR95zByK8apqb6UdjfiD8IbUDpM
 =
X-Google-Smtp-Source: AGHT+IHdxMYdgLn15WLDIabTtHWMvnPl+G1ceGnZAyyue5zkbLd9Mm+GfZ/OIAHRw2+yO0q4EazVTQ==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3f40b531fmr4160205ab.21.1729207500561; 
 Thu, 17 Oct 2024 16:25:00 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 20/34] test: Drop the duplicate line in setup_bootmenu_image()
Date: Thu, 17 Oct 2024 17:23:59 -0600
Message-Id: <20241017232413.724808-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

The mkimage call is done twice. Remove the duplicate.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34..9166c8f6b6e 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -208,8 +208,6 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
             cons, f'echo here {kernel} {symlink}')
         os.symlink(kernel, symlink)
 
-        u_boot_utils.run_and_log(
-            cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr_fname}')
         complete = True
 
     except ValueError as exc:
-- 
2.34.1

