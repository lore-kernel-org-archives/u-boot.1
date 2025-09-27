Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88333CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 11:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5195836A7;
	Sat, 27 Sep 2025 13:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SsGKXmsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E214836B8; Sat, 27 Sep 2025 13:34:18 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2944B836A7
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 13:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8cf4f90b6f0so229877539f.0
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758972854; x=1759577654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+c6WgccJ3936X70SznO34un5IzfC9EAqw46Hng2Fr4=;
 b=SsGKXmsyc/VWHLlPRrgqEl17wRPAR2tkW/S05Y39I2kFIlIvdhu26D1d1MZv6k7lkc
 6h66QGLmssC6D6Ttwc5Gdfry9s/sJnD/kvbQTAxVreWQbGOf+f31YiW7Kb09nHpcfkjJ
 wtmv3AaRAExVIBhMwq/fZpp7WSoOx0qGr5Pt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758972854; x=1759577654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+c6WgccJ3936X70SznO34un5IzfC9EAqw46Hng2Fr4=;
 b=rOxlbHKiabxQ3z26vbxZANN5P67skLgTFG1DxHyU/Z5JLlVX5QjIM41fivOIrjZqCz
 jDksGTjs7lTRgchMJ+wYZQQAGOye1WbTLBtB5aUDOyRfa71lVQ4kuSPg1JH4/WeG3Y/S
 GWzp2oNJj9GWIVFJk0fTOWoJmEry39dta0Ds+jDxx+7bLlcXtF9bnyRyKlYuVOYVfLjP
 ETMopWCUI+zSCjuxlDXcWbi8KbA78PesBsJg34U/vyd3gZDN3Wy06o/J2iu4FLHYVt6S
 Jb5pi2Un85MJFh7XNEvg+akpEFibE8xvawDrOrt0RQB4w3EUQdHcxaJojSsR8aP6Z8FX
 HZ1g==
X-Gm-Message-State: AOJu0YyZWaKTaQrYyxVj5KGyfy6RDcQGEEaItMDsjaGQqYzQToESXUmX
 VH3dD/r5MwiQ92GiyxLhjQYfUgFtnPVLxbHmi5ZVwuyYvDjVERLgj8bSnfFprAlh7XgjBiM+E/T
 XpeGjeQ==
X-Gm-Gg: ASbGncu/+BN8U5kE9GHbdDhUuiHTuAnesTd34BnXV1YgJeY8b51Nvofaj6oMNS17Tes
 kveDr4ed8JaMetvjGg7q0RjOTUaq4NQKKCR8CqpmuAfDmElYYtDT3rFGBhCgNE/RgV1rFVRQf/t
 E22ElZQtcMl11Ppsa55bhJHrxLNZcqpRnfg8/npx8gBNKpXtrW1nALanlKlASJYLzUftrZqPdF4
 F91jACKB/Z4yBnJw6ozGQrpCijxjyVFIdDNKp77yzyIKoYdkqXWZtrNRQMoq2wD8uYN9ALGVN1c
 5KhTNvg52TTHE8xcmoCh/pYNBLJfr37X/3irvLj+Shp5H7BzkCyxvsOtnqbpCqbNJixVB187GO8
 qeNJspzs8Cr4Rc5R3GrNo857PgyM=
X-Google-Smtp-Source: AGHT+IHwNB2+y1r93arCIYTvXKLEH4JaREJH6wUaIo2yMCNomHWstMCKfna7iR8ehG596IcGLa1pPQ==
X-Received: by 2002:a05:6602:6421:b0:913:48f3:27ac with SMTP id
 ca18e2360f4ac-91348f32e15mr777531239f.4.1758972854292; 
 Sat, 27 Sep 2025 04:34:14 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-9040f54c16esm261142939f.19.2025.09.27.04.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 04:34:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Fiona Klute <fiona.klute@gmx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Stolpe <martinstolpe@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mauro Salvini <m.salvini@koansoftware.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 1/1] rpi: Use the U-Boot control FDT for fdt_addr
Date: Sat, 27 Sep 2025 05:30:15 -0600
Message-ID: <20250927113019.2863093-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927113019.2863093-1-sjg@chromium.org>
References: <20250927113019.2863093-1-sjg@chromium.org>
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

The fdt_addr variable is used in extlinux as a fallback devicetree if
none is provided by the boot command. Otherwise the only use in U-Boot
seems to me efi_install_fdt() when the internal FDT is required.

The existing mechanism uses the devicetree provided to U-Boot, but in
its original, unrelocated position. In my testing on an rpi_4, this ends
up at 2b35ef00 which is not a convenient place in memory, if the ramdisk
is large.

U-Boot already deals with this sort of problem by relocating the FDT
to a safe address.

So use the control-FDT address instead.

Remove the existing comment, which is confusing, since the FDT is not
actually passed unmodified to the kernel: U-Boot adds various things
using its FDT-fixup mechanism.

Note that board_get_usable_ram_top() reduces the RAM top for boards with
less RAM. This behaviour is left unchanged as there is no other
mechanism for U-Boot to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G
---

Changes in v5:
- Rebase to -next
- Drop patch to add myself as a maintainer

Changes in v4:
- Expand the comment on set_fdt_addr()
- Update the commit message to talk in terms of my testing

Changes in v2:
- Drop patch to allow expanding the devicetree during relocation

 board/raspberrypi/rpi/rpi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1b0b664fa2b..6f96c1ebc96 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -3,6 +3,8 @@
  * (C) Copyright 2012-2016 Stephen Warren
  */
 
+#define LOG_CATEGORY	LOGC_BOARD
+
 #include <config.h>
 #include <dm.h>
 #include <env.h>
@@ -354,15 +356,13 @@ static void set_fdtfile(void)
 }
 
 /*
- * If the firmware provided a valid FDT at boot time, let's expose it in
- * ${fdt_addr} so it may be passed unmodified to the kernel.
+ * Allow U-Boot to use its control FDT with extlinux if one is not provided.
+ * This will then go through the usual fixups that U-Boot does, before being
+ * handed off to Linux
  */
 static void set_fdt_addr(void)
 {
-	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
-		return;
-
-	env_set_hex("fdt_addr", fw_dtb_pointer);
+	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
 }
 
 /*
@@ -608,7 +608,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int node;
 
-	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
+	if (blob == gd->fdt_blob)
+		log_debug("Same FDT: nothing to do\n");
+	else
+		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
 
 	if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
 		node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
-- 
2.43.0

