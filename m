Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74365E7719C
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA0D806DC;
	Thu,  9 Jan 2025 16:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhms6tdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C113B800D0; Thu,  9 Jan 2025 16:03:21 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ACC80713
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844ee166150so31085839f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434994; x=1737039794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMl7ocdWnHRpDGtY0F3vVZPl2FzBAJk2UXeov3aBZGU=;
 b=hhms6tdb2U74Ptpisor9ONnPdWTD8ti2kG138dwdWDle8LDzFv4GD6I5GslPxaYtd+
 aw4QUsqB2xaA6vcuh5O1UZEaTEmGXNhIam/VE1fisxob+n1KLwGPGBSlbOcae4QTbx43
 PSy11uF8yVG6R7CzWuYttOtp9ccvfxWUXKuHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434994; x=1737039794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMl7ocdWnHRpDGtY0F3vVZPl2FzBAJk2UXeov3aBZGU=;
 b=Rl5alsOiNcXWW/x22aCOAjGVCmjhUCA8MdZxdGPdVQBZcsxDA6RaJXVop5zx6sw+8X
 gq3KIIKBh2Jz2tClXcpo7CQ+FuCy6ilJV7o2EkWja54Qa+86oL+4KXLshU64QiUXK0Bx
 xz5kW10yMAZVO1cIbLJ/O1xNN7vTj3J5rWN4wDLlh7H7lpn6K1PKYdsnqRsU7GrBzI98
 toHlXTa6PeapgyFc8eb3mSQGSpP3CIvIVe1VOLVGU/OI2eaao/ysCBr3bqg1WnKT31yP
 UYSpaUqobHToOdi33lxYWNQkxvkXTuPtF4oa0ip1AbX3R/4lz4IKJN7hvoMHXEPBIar7
 7htA==
X-Gm-Message-State: AOJu0Yx1oVDDctdawiN4iJdW8fqiFsG2WPFviUPJ9nYsleA1JPsI7X+g
 Tst61SLhTzVCCV9HMlpbwkOsFb1S1iYvMTVGEW1Uncu0lsn+OIKjgQVUYp+w3+7lazZ4nRIWyWk
 =
X-Gm-Gg: ASbGnctAwp8PvhrHxneOIjAB2Esj74S4DnrnFpt98B+WGUuo70Tk9nIsTzTx8Y1/sGJ
 l0Ud6ScdkCVou1rMWl7OEWAgOnzmKlxJor//1PpAvkso2RY8dRnGs0Nu153+797GCQQ1o9kyeeo
 q8by2EJr6PqCzznDnDeI0GY7EQBMy1oWe3AJJlamuGtVpyTThAGANNEkOMHwIOFoIOoFfedP/ny
 70P8eYwusdgfLXcv8sytw16IBBQy+zVir9AIaWvN3sao6I9TdBTK3LRua4wRvmbIxwku/wQzxz+
 aEMyg8bgkLX4cY0bjw==
X-Google-Smtp-Source: AGHT+IG1a1dd/7wLXYC6O+ARTWYbiG75mZFty9Am5nV6PR97t4k1/iYmk7FGoYZoiUFhVx92HrfgfQ==
X-Received: by 2002:a05:6602:381b:b0:835:45f9:c2ee with SMTP id
 ca18e2360f4ac-84ce00f6671mr755710139f.4.1736434993816; 
 Thu, 09 Jan 2025 07:03:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:03:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 7/7] bootmeth_efi: Support PXE booting
Date: Thu,  9 Jan 2025 08:02:44 -0700
Message-Id: <20250109150244.141173-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109150244.141173-1-sjg@chromium.org>
References: <20250109150244.141173-1-sjg@chromium.org>
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

Finish off the implementation so it is possible to boot an EFI app over
a network.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support PXE booting
- Rebase on Tom's tree (i.e. without the pointers/addresses series)
  https://patchwork.ozlabs.org/project/uboot/list/?series=436241

 boot/bootmeth_efi.c          | 15 +--------------
 lib/efi_loader/efi_bootbin.c |  5 ++++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index fa7f66c9a0b..de7ae2d2ee4 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -210,6 +210,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (size <= 0)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
+	bflow->buf = map_sysmem(addr, size);
 
 	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
@@ -217,10 +218,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("bootfile_name", ret);
 	bflow->fname = strdup(bootfile_name);
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
-
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
 	if (!fdt_addr_str)
@@ -294,16 +291,6 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
 			fdt = bflow->fdt_addr;
 
-	} else {
-		/*
-		 * This doesn't actually work for network devices:
-		 *
-		 * do_bootefi_image() No UEFI binary known at 0x02080000
-		 *
-		 * But this is the same behaviour for distro boot, so it can be
-		 * fixed here.
-		 */
-		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
 	if (efi_bootflow_run(bflow))
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a4f6b4264fb..e99ebabd206 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -302,6 +302,9 @@ static const char *calc_dev_name(struct bootflow *bflow)
 	media_dev = dev_get_parent(bflow->dev);
 
 	if (!bflow->blk) {
+		if (device_get_uclass_id(media_dev) == UCLASS_ETH)
+			return "Net";
+
 		log_err("Cannot boot EFI app on media '%s'\n",
 			dev_get_uclass_name(media_dev));
 
@@ -342,7 +345,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
 	ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
 			      &image);
 	if (ret)
-		return ret;
+		return EFI_UNSUPPORTED;
 
 	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
 		log_debug("Booting with built-in fdt\n");
-- 
2.34.1

