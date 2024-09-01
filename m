Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21F5C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B44888C8;
	Mon,  2 Sep 2024 00:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BncQJMXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A17888C8; Mon,  2 Sep 2024 00:23:11 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12468882C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82a29c11e1cso96732039f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229388; x=1725834188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJquD5jHS4B0Xv+4s93mAVBfKZTdxVSirJaN+z86zDQ=;
 b=BncQJMXBHwzl+brhSwjHDMQZBj3hcwAZZ6t6b189S6lMcFVpG4zJqMM0Era8/lo0tC
 T99nuIigUSX31KFR52J22RZqUELEhbANxP19fgtRhIatt62xUgRIbriwFBZ5/mL24BED
 UQdf1Loez8ooWEpFhwnjy4lj92IeIL9IHWarY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229388; x=1725834188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJquD5jHS4B0Xv+4s93mAVBfKZTdxVSirJaN+z86zDQ=;
 b=cbQVhSEG/A94scmtOlUCSbmgHrEmgG30or8FtMxDlaaAKPkEewAHOGHSt1XdEakibz
 jUTUydpRb80MxNKJRbAUX42Mz/bNCtmykARcRElu31aN5X13p2WJ3zFKXFJhNI5f1e75
 DYH9/QFqVDSWEMu/+PmKwLyuh+1EEERjrAT0XjaLV5LAsYJGzlyGiah90WdqewAlhkUR
 N9Zk3LLc/0bHfVzHXps4EPTvPe4pAUjdWaZbTnK+pmOrV0lHnWgRsY83U6n8FUUYh0Ww
 sjUqEtf4G4wTUFNYjw+kmdXCaSZHMRV9KMiuZcIE598fyvvruZkQNk/+/QOD1r1GMU3U
 SNRw==
X-Gm-Message-State: AOJu0Yz3zsWljuV1nnJYuQKY4cOfxqJKoKmW1/Z7VOz7x+aK1vMqc8lL
 ozvZ5ItzZyjpTi5xG3LYRirqcMxklZveSwvmxhSlcEDlikWekxe5YAsSmod+uIrX9nQfTLbAEg4
 =
X-Google-Smtp-Source: AGHT+IHUFLOGFOQ8glCUVP12Xdaf3tcgnfOlt0vPQm+5fbCoS2XgbJe0+YdHZGaOc5Ds+5wkUuZ2Jw==
X-Received: by 2002:a05:6602:2c0d:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-82a3418c223mr676730239f.1.1725229388049; 
 Sun, 01 Sep 2024 15:23:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a2f0759sm213887339f.2.2024.09.01.15.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:23:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH v3 3/3] efi: Show the location of the bounce buffer
Date: Sun,  1 Sep 2024 16:22:59 -0600
Message-Id: <20240901222259.456932-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222259.456932-1-sjg@chromium.org>
References: <20240901222259.456932-1-sjg@chromium.org>
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

The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
lx2162aqds_tfa_SECURE_BOOT and the like) use it.

This feature uses EFI page allocation to create a 64MB buffer 'in space'
without any knowledge of where boards intend to load their images. This
may result in image corruption or other problems.

For example, if the feature is enabled on qemu_arm64 it puts the EFI
bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
1088MB. The kernel is probably smaller than 27MB but the buffer does
overlap the ramdisk.

The solution is probably to use BOUNCE_BUFFER instead, with the EFI
version being dropped. For now, show the address of the EFI bounce
buffer so people have a better chance to detect the problem.

Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
that the feature may be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address

 lib/efi_loader/efi_bootbin.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 5bb0fdcf75d..9779dc09b5e 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 		return -1;
 	}
 
+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
+	/*
+	 * Add a warning about this buffer, since it may conflict with other
+	 * things
+	 */
+	log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
+		    efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
+#endif
+
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.34.1

