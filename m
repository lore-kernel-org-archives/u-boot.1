Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F59C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A94C886A3;
	Fri, 26 Apr 2024 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LLm4H+cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F30885AF; Fri, 26 Apr 2024 16:14:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C14885C1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD89E3FE6F
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140839;
 bh=HWTOXFdVOpsXpwb3C7j5ZIr/NZBV6uVjLSE49RT/J0w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LLm4H+crYHdgEsefAANJV2ymoDIwaTvQYXCoWOfAvIaMA+L3si0Ewpkr4IL8IOfPO
 aZG/wg1XW31K5xPXtxU9xPBZ+xkteJHhm94w+WqDHBFOcpM3o3lCWMhu4kn7kKBGiG
 HK8OJB6cfwsDmS6GNXRC7Lbi0R0GrjWODroO7S1tCr2sZ+IMHdg0kbyjI5vDHyLprW
 iaMVYMUF40cIAfRQu1NKCvwoipEWQ4GzSQ/aNF+Ik2aCy0+0UI7Us+/kGfkpqgVEMN
 MgM4L/29ZIqTUgs6nbVFmcTqdCC80vN5pQ9ZKbAjOHAdw8uy9I37zmm8eL7sP1rsTA
 9jxho5dFc8Hwg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343c7fa0dd5so1388034f8f.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140839; x=1714745639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWTOXFdVOpsXpwb3C7j5ZIr/NZBV6uVjLSE49RT/J0w=;
 b=bTvuxn6igD0r0ZNGNPU5bxlPU7DfNLdXsggVUVG8tQpMMTT+SvkCMXzCcZPTSNSTD7
 ukAJ75/b/22rCoMccJgDkvwzT8Cts7Y0Je212xeAGpi3R51dRtftSFSYeVypaiZxTLS/
 HbhCZtfH6tvXECKQc6dbyzJxDGtD0NFgFLCkIufupvBWA2IO1r3EXC49XRE5EZIe9feB
 bKX779nHNeH+nBhpO45z2JU/XxYACIdExhEgkx1t+SSvXDNvPcFtKIW7i6PwVriR4G0U
 MpK25UaQAmuMGmtfU6zpmqNcgAd/xsPm5AqUs6g+0TwHfpvvdD8+qmnqny2sCMBCrmKI
 g3Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKuKnzFi3j2frm6HlM8CjVBlpWDDwZv8Cl6Lxw4i84790a/6kgcRU/V+neCHveQHtDFLrA1LGHycO4C6IXreYAsT/1VQ==
X-Gm-Message-State: AOJu0YyQgyFt4/0ugSojt5lSIXWiFQ5j4gFCK50hnOK9gftm++UDalaZ
 chcwg+rxMroq60lzxby8V4e2X15cPdgh9dyTMaCQGZLGvr9aHORPVHR+Hx+7hUCH2+ku6hFYkcR
 D30OfnvHp83mUd/VvFHD7X90UZRIoUbDvM081XJcfoiEWpVSM/O5jXCyK4411iP5fyHQ=
X-Received: by 2002:a5d:6106:0:b0:34c:77dd:b1b5 with SMTP id
 v6-20020a5d6106000000b0034c77ddb1b5mr564841wrt.15.1714140838794; 
 Fri, 26 Apr 2024 07:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+WbAVoyD9ZQP7ui/aV88O67RkQH0l9Ye0J1zA7NdrUcZhgHOaKd/0NcpCxDO3Wcohb1FJdA==
X-Received: by 2002:a5d:6106:0:b0:34c:77dd:b1b5 with SMTP id
 v6-20020a5d6106000000b0034c77ddb1b5mr564816wrt.15.1714140838435; 
 Fri, 26 Apr 2024 07:13:58 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 13/14] efi_loader: export efi_load_image_from_path
Date: Fri, 26 Apr 2024 16:13:20 +0200
Message-ID: <20240426141321.232236-14-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

We can reuse this function to load the device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h          |  4 ++++
 lib/efi_loader/efi_bootmgr.c  | 17 +++++++++++++----
 lib/efi_loader/efi_boottime.c |  1 -
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index ed2b517b130..0bf325fdc4b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -664,6 +664,10 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 				   void *source_buffer,
 				   efi_uintn_t source_size,
 				   efi_handle_t *image_handle);
+/* Load image from path */
+efi_status_t efi_load_image_from_path(bool boot_policy,
+				      struct efi_device_path *file_path,
+				      void **buffer, efi_uintn_t *size);
 /* Start image */
 efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 				    efi_uintn_t *exit_data_size,
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 3d58a928b10..9ae948bcf08 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1265,12 +1265,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		return ret;
 	}
 
-	fdt_lo = load_fdt_from_load_option();
-	if (fdt_lo)
-		fdt = fdt_lo;
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		fdt_lo = load_fdt_from_load_option();
+		if (fdt_lo)
+			fdt = fdt_lo;
+	}
 
+	/*
+	 * Needed in ACPI case to create reservations based on
+	 * control device-tree.
+	 */
 	ret = efi_install_fdt(fdt);
-	free(fdt_lo);
+
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
+		free(fdt_lo);
+
 	if (ret != EFI_SUCCESS) {
 		if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
 			free(load_options);
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 33f03c0cb0f..50ce8386051 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1996,7 +1996,6 @@ error:
  * @size:		size of the loaded image
  * Return:		status code
  */
-static
 efi_status_t efi_load_image_from_path(bool boot_policy,
 				      struct efi_device_path *file_path,
 				      void **buffer, efi_uintn_t *size)
-- 
2.43.0

