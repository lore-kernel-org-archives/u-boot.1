Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8EEE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B6E8960E;
	Fri,  6 Dec 2024 14:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/CPvoSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B246D8960D; Fri,  6 Dec 2024 14:11:33 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752708960E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 14:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-841a565f871so74632539f.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733490689; x=1734095489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NHNPOBmneMlpnrqKbC2l9ccoH/sJYNHBp9d3DNIA3Y=;
 b=a/CPvoScDj3YqgrYbHsEb4ja3z3qb8UqMcp4OdFmxEv4gTIwUxS6K5km3G9ejYQ9Oy
 AQ8vTK0FilrSdFpn9RCHdoJS4Vay2CWXUz/uI6FEvjNnd7yUhJAaigHR0XiIqc8vkSJp
 uOjYfWrAb4091pdl/XTxt29gJ3L/csiP1sa84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733490689; x=1734095489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NHNPOBmneMlpnrqKbC2l9ccoH/sJYNHBp9d3DNIA3Y=;
 b=kiJJLBZTr13N3XH7Z8NhhqzhtKNBqvj3fTFGU3MhNOHG2bAm2BumZG+FeH8+5hQ8dF
 NWSdiWbwSCMsDiUI77QcYw3tx87P/YJp4Cb/tYPpBrlSKIPLYAjPFX6X4Yk/CNYl7Hkn
 DRRq1ukYINqzoYktyY/OYUPGcIQz4Mg/wSfvAvlPwgkwsNA0Fqemx7tY+uJ9s9eOrReH
 VRm+iLHVQzuwe/kwB0iBU47l48iLkQ6z9hgs8n2LLLLak+00m6t4Za8LNZ71kUOs4q16
 T7VWRpAZbiYzHwZc6LQofle7qtb5x9Dn+J3Dd4lYeDkqv04CS3nesMprgEe1n3aeAm58
 kNyw==
X-Gm-Message-State: AOJu0Yxi6ZiY+smuiauoj4QKj/53HYBG7IWqiKYJHrDY4+fD2OwGyLKz
 BCy6d2iWcxeAnSIg8bjY+lIVhbEWgUewhYhze3x+mwbo+0Kjlwf0gQekenQoBUjqOcjIAx0A+q4
 =
X-Gm-Gg: ASbGnctJjK40AcIB0WWF2BrNMbazCCCYJ6o0dfvBG0bcXUgq7c50aTH32P4b5d7uGNh
 1ff+GHrleByjFllKNcAFyp85Jz7ha2EAOn2vk5TxmXfWsxvei6N7U9rY6e79zNgP2vmscSPbr74
 P+52NEnrItKUuqjt7VKGhs1LOBlVe/+4ZKdUDxrPOucOl9AY/0/AKt8lTBTfZpmN7rzLuTHn/nb
 kZ/5sd1Rup9H29tlzVc7XMwVENDF4QnQ0PeOMXGuVLiqENbI7sSn1CaY/s8XcfacLw6sFIeIaff
 y+C7o6B5hfg=
X-Google-Smtp-Source: AGHT+IEOkf6MavGf0UnWv1XiUoNNjRiZ7TLFfUMIHKmfkXYbouIo9t1/TCbvgA9wQfcYqZJPkY+L9Q==
X-Received: by 2002:a05:6602:6b88:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-8447e21c305mr463466439f.6.1733490689360; 
 Fri, 06 Dec 2024 05:11:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5b3b9sm97382639f.35.2024.12.06.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 05:11:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Francois Berder <fberder@outlook.fr>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] rpi: Use the U-Boot control FDT for fdt_addr
Date: Fri,  6 Dec 2024 06:11:13 -0700
Message-Id: <20241206131113.2865416-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206131113.2865416-1-sjg@chromium.org>
References: <20241206131113.2865416-1-sjg@chromium.org>
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
none is provided by the boot command.

The existing mechanism uses the devicetree provided to U-Boot, but in
its original, unrelocated position. For the rpi_4 I am using, this is
at 2b35ef00 which is not a convenient place in memory, if the ramdisk
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
---

 board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 9122f33d88d..8f6ab1b1b9b 100644
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
@@ -325,19 +327,10 @@ static void set_fdtfile(void)
 	env_set("fdtfile", fdtfile);
 }
 
-/*
- * If the firmware provided a valid FDT at boot time, let's expose it in
- * ${fdt_addr} so it may be passed unmodified to the kernel.
- */
+/* Allow U-Boot to use its control FDT with extlinux if one is not provided */
 static void set_fdt_addr(void)
 {
-	if (env_get("fdt_addr"))
-		return;
-
-	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
-		return;
-
-	env_set_hex("fdt_addr", fw_dtb_pointer);
+	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
 }
 
 /*
@@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int node;
 
-	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
+	if (blob == gd->fdt_blob)
+		log_debug("Same FDT: nothing to do\n");
+	else
+		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
 
 	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
 	if (node < 0)
-- 
2.34.1

