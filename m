Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA9EE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A959E89752;
	Mon,  9 Dec 2024 19:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTVU/z2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2032289766; Mon,  9 Dec 2024 19:20:24 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9259896E2
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a7dd54af4bso20864675ab.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768420; x=1734373220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpTc/uIAtqJ75cOtFCQiu5KCUPdamZcLqlaoDaJemt0=;
 b=cTVU/z2HnYbQAdmi/Sn3I8DyFLPtIhfX8ICuTuOGV4x35uyt0lrUQqGJNzVDh/kVp3
 jv3DWg4Kaw99nK31LU4KBpLqQKlCjL82VG5ZOeGRm27nqS3rw22naYp9n28Im/rb6jHX
 oV9SUtQ3KsKafkU/wQ8+qBwbe/6LqHJ7r59/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768420; x=1734373220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpTc/uIAtqJ75cOtFCQiu5KCUPdamZcLqlaoDaJemt0=;
 b=I3s5OG6jSQxBLsQkGSwH9cL4b9+NTt7zU4HK+Bn0fb9ax0pPKDUINuxjNlMiyQkjOh
 0BlNuHuBL6YoUFm4BVAwz51Q3WctG/ywhF3gIqwfxD2LDIGgWLJqfrBAdfKAI13zrtAh
 p1Kg2yDdzQDstF0x3HM57CRG3SGOQNvqllxF5boYzKerQ36QT0fIQu66oso5Mn7vzi+g
 Ut5530c7OFObVun4Ks2fD2qQ7FqeDdB8RrsaiosSOZsrkD8Wwf7LRHLzPjrPl/O7N6b9
 a0uTcKkChZT9bj4vFjnNLk6X9Rb54UlZsVYBasZYcgaWJoMstsLhxU0g1FQBMNmhzXnc
 xZ/Q==
X-Gm-Message-State: AOJu0YwlxmJJ3AeVCASqJ0vxLKaZa+KA8lxL2eJ5WxPQLBRcy4SUMmHK
 ui8GqsK14o7A4LMIbZxqgqqjLWmmRtNcpyV7q6tF40n7hR06LkpALXeTb/snKkPkLi8cnT4EKFo
 =
X-Gm-Gg: ASbGncsukk2ObVFMBCa/q5LfDY3B74Afmuk2LyaU9i1rtF84U1/LOpXa5YERH8rnhcv
 nG88ijFJeO0y9a9oU9G2AFNpC6jovhzyV4ekerLjNk6HkEycyR1YErY3c4OiqpNOR41RW3XkZAl
 0vCLK/YKcPA9PmIXP3Y/0y4KY9G4g2hoQ9lhOc4YVjRapG1nis3OJe1wzuPG/8HoHUrY9lQQz/A
 eCXdFcUuz0mvzv3U95WajjUMjyNkhFgzsanSK8HdVAXSj7GTFQNHBzjhc+k13lJc0RKRPOwDpUS
 TcD7J5Gmj/M=
X-Google-Smtp-Source: AGHT+IH3JtJ2an45MeYbbRUfSNttDBqL+VUwd16BFtHud5ZSV2WcZrgLZoiCUlGVOxUX5QWJ0Qb+FQ==
X-Received: by 2002:a92:c563:0:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a811c799a7mr144423125ab.4.1733768420069; 
 Mon, 09 Dec 2024 10:20:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Date: Mon,  9 Dec 2024 11:20:01 -0700
Message-Id: <20241209182002.671953-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
References: <20241209182002.671953-1-sjg@chromium.org>
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

In version 2, it incorporates some changes to fdt_addr, etc. suggested
by Tom, as well as adding myself as a maintainer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop patch to allow expanding the devicetree during relocation

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

