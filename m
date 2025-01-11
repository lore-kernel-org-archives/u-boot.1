Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF33EE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD28807C4;
	Sat, 11 Jan 2025 01:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WpZwywV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A492A807AE; Sat, 11 Jan 2025 01:01:52 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E792080050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso187876539f.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553708; x=1737158508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpGQfZegeQI1qwELLZgZj7L1SLX9Cv3Hs3PbJhfiNDw=;
 b=WpZwywV6umDRKXegrNLnO6d/Z+WegoHzMqCv2qMxA13Eivz8izeNmuDh+1WlPDY5+9
 EIsp2lN6mDittKzacmQQEPGtNAdrgTgowPJUw9mmV2o0ynG03+F0h3CnN+eUw396dqDN
 JaTDurYTBE734/H5pcdyun2wVRMdnN6v+u1fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553708; x=1737158508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpGQfZegeQI1qwELLZgZj7L1SLX9Cv3Hs3PbJhfiNDw=;
 b=g2TxZk6vrXnFtZ/UeXYZqiNirykgj9LvN4a9gxqrktfZDZMCrM6H/addpA9oO5Zt4w
 jS/xHO6d/cQbwVRqkyp/EvKipCZBlxmLb/gCGCSjDO1usSmmxW+uqVVotXdLb/iVvfQx
 N3mc235dzgcMOPDutZ5V4bt0/SsVq/LZzCjdwVtN/YDVj7X8aOdPWGFvnI+xbXx9HnjF
 l6v2pyTrZWm57ZokgUDnV9b6ubQKcF8q1opueAqk9acaxGumM6I386FOVGVvLPQTxpdp
 tMymbfi1s2UxmDo4spq3kb4SREBSjbOAfE1uu01vLBdo8P/GkOsvxVt+vDdfwpixokdY
 kTwA==
X-Gm-Message-State: AOJu0Yy8j/yfKcewSmVuK/qZoosrRQn/2dcFKqFlMJyJneIqrYXuW741
 5fFDeYBHx7id/Ad6o5M+/7P47UvHYoFagv+GanHs9w03gYnCsyNdvVacnhr+NrEa3gdWbIyeQB4
 =
X-Gm-Gg: ASbGncvsmljJ29tgLRaN5UHftGmpJZ+nTGEqQPaUb6BPk0jTbVI37+BabiIcigafaBM
 XoF4QY/z7DJKlvbqszA+hVKNv4eZGIH3pfrqc9jSxzaUbiefXz50N6TwSSFMuKN7rhqaUS+NT/9
 uBzy4trBeehVyItUyskiOl57h31EF/gzn5LoVgyCrXcvYXgZeTN92dPgU5Kk4UVlAC8zbq5aVXs
 /FAS9YLpDRDnG7g5iT6nL0WGX5Ut15Fz1lSO56J2tBJm+t4Mynv9O5TW7pcNYeJN5Drgu679s0X
 dtZnKTmUUbLdKnzj5Q==
X-Google-Smtp-Source: AGHT+IGGE1trUfDx4ePxepyrhnaCmtsR7noX5E549suHd+VRzg2+CbRbJ68CPC8WxPy3y9hBBK3p4Q==
X-Received: by 2002:a05:6e02:1488:b0:3a7:a2c6:e6d1 with SMTP id
 e9e14a558f8ab-3ce3a93a83emr104870075ab.16.1736553708218; 
 Fri, 10 Jan 2025 16:01:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 26/30] efi_loader: Avoid mapping the ACPI tables twice
Date: Fri, 10 Jan 2025 17:00:25 -0700
Message-Id: <20250111000029.245022-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

The add_u_boot_and_runtime() function paints with a broad brush,
considering all of the memory from the top of U-Boot stack to
gd->ram_top as EFI_RUNTIME_SERVICES_CODE

This is fine, but we need to make sure we don't add a separate entry for
any ACPI tables in this region (which happens when bloblist is used for
tables). Otherwise the memory map looks strange and we get a test
failure on qemu-x86 (only) for the 'virtual address map' test.

Good map:

   Type             Start            End              Attributes
   ================ ================ ================ ==========
   CONVENTIONAL     0000000000000000-00000000000a0000 WB
   RESERVED         00000000000a0000-00000000000f0000 WB
   RUNTIME DATA     00000000000f0000-00000000000f2000 WB|RT
   RESERVED         00000000000f2000-0000000000100000 WB
   CONVENTIONAL     0000000000100000-0000000005cc7000 WB
   BOOT DATA        0000000005cc7000-0000000005ccc000 WB
   RUNTIME DATA     0000000005ccc000-0000000005ccd000 WB|RT
   BOOT DATA        0000000005ccd000-0000000005cce000 WB
   RUNTIME DATA     0000000005cce000-0000000005cf0000 WB|RT
   BOOT DATA        0000000005cf0000-0000000006cf5000 WB
   RESERVED         0000000006cf5000-0000000006cfa000 WB
   ACPI RECLAIM MEM 0000000006cfa000-0000000006d1c000 WB
   RESERVED         0000000006d1c000-0000000006f35000 WB
   RUNTIME CODE     0000000006f35000-0000000006f37000 WB|RT
   RESERVED         0000000006f37000-0000000008000000 WB
   RESERVED         00000000e0000000-00000000f0000000 WB

Bad map: (with BLOBLIST_TABLES but without this patch):

   Type             Start            End              Attributes
   ================ ================ ================ ==========
   CONVENTIONAL     0000000000000000-00000000000a0000 WB
   RESERVED         00000000000a0000-00000000000f0000 WB
   ACPI RECLAIM MEM 00000000000f0000-00000000000f1000 WB
   RESERVED         00000000000f1000-0000000000100000 WB
   CONVENTIONAL     0000000000100000-0000000005ca5000 WB
   BOOT DATA        0000000005ca5000-0000000005caa000 WB
   RUNTIME DATA     0000000005caa000-0000000005cab000 WB|RT
   BOOT DATA        0000000005cab000-0000000005cac000 WB
   RUNTIME DATA     0000000005cac000-0000000005cce000 WB|RT
   BOOT DATA        0000000005cce000-0000000006cd3000 WB
   RUNTIME DATA     0000000006cd3000-0000000006cd5000 WB|RT
   BOOT DATA        0000000006cd5000-0000000006cf4000 WB
   RESERVED         0000000006cf4000-0000000006cf9000 WB
   ACPI RECLAIM MEM 0000000006cf9000-0000000006ce6000 WB

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to avoid mapping the ACPI tables twice

 lib/efi_loader/efi_acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca24..ff305a6b13e 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -25,6 +25,16 @@ efi_status_t efi_acpi_register(void)
 	ulong addr, start, end;
 	efi_status_t ret;
 
+	/*
+	 * The bloblist is already marked reserved. For now, we don't bother
+	 * marking it with EFI_ACPI_RECLAIM_MEMORY since we would need to cut a
+	 * hole in the EFI_BOOT_SERVICES_CODE region added by
+	 * add_u_boot_and_runtime(). At some point that function could create a
+	 * more detailed map.
+	 */
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
+		return EFI_SUCCESS;
+
 	/* Mark space used for tables */
 	start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
 	end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
-- 
2.34.1

