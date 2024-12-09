Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B2BE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDF38979B;
	Mon,  9 Dec 2024 20:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nnKIdX+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80278979F; Mon,  9 Dec 2024 20:55:45 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974BA8979B
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so12832635ab.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774142; x=1734378942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viaiZEbftmREq3jeJ6GHgIvUIG7RQqLZdtzOTQoPd+M=;
 b=nnKIdX+Qz7fH3FJnNK2dERdDlft9tMbZoc4GPnyOEn5JEknwYA+z66HomlP5o7Jogf
 37TCyfr/UvXGf9svkkyyvFeXBMYj3NQZqx0Wo5g7VmpPdN/1NKkW5c48qfgKnZevFsY4
 kpXMUUtgBvMLPzch7yU2dx9F/cOiA36FcBpDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774142; x=1734378942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viaiZEbftmREq3jeJ6GHgIvUIG7RQqLZdtzOTQoPd+M=;
 b=CMirPpPRZyyOp6h+z+wsNgsr1WjX+nV0+LqqMP1FucR9EuVQ0vRrnTJ6maUvCYtbEJ
 hX+ZtO0a39DGbBYO2KseZlDdR+klg1roepNSuG36DSPjKhdQxKofk5AS+vNmO9aCBx3Q
 FhSxlgDi2nrq8QYzSb+hgDIOjBsHRUcIVWI+dHo3NYF5YGBP7yzgHDvY0Mf31wSZKJfe
 ND+yoCmFaiwhtV+FCRjHEAmYIrU0lYZdWVxJkoJA3BgH9b7/L1bszgG0GqE/SbwKYCzz
 KqSI5tXY4k9Fyp04bdm7kZdBUamY3QGwWA8RfTXhq61Xd5UK/B21F4HB1Y0F590qZlCJ
 K31w==
X-Gm-Message-State: AOJu0YysPsZoi7BwdfvB1NKnkqSMgHradjeocULtTE6NpfF5I2O29U/Z
 kTZ0t1Cv7kkbujUtJR73PMSv9fv01rlxcWH5IkF0JKPQY07q0qTkGlo+DVj35FY/Ln5D8FXjM1w
 =
X-Gm-Gg: ASbGncson2yds8cDMklf3jac8aNu7JJF/jR0kTqJE5WeJ0bj7dQ6SFokjYgEsV3A6Ip
 X2za/KPiGUpD8vMQXgx0hLaiEvbb6OmLXr6iW4u0vX5H35SP9g4D0qXQ12to/zWlLhQH9IR3ldB
 Fz68gUZvNe5T3f+LreLUEB70eKFPKNy8JQ3nSnvXCMyySs5JUPL3FNRYBPPzF/xNyJhJ4LzOKT1
 fq3rgiA7S6d1A9Kpy4LciS2+FesISEdMvsKbKqyDRgaEJkgC98qKND2lK8FrUZhLL99WYs87cD9
 AKuJ4NfuuXzD+4Q=
X-Google-Smtp-Source: AGHT+IHoZzqgwf49dXIXzquyhWkLBNXVTogZ7OvVJHWJ4UAUVJv9wpUQue/+nq3jGo6mJ764nS/wKw==
X-Received: by 2002:a92:c265:0:b0:3a7:7ee3:109b with SMTP id
 e9e14a558f8ab-3a811e03747mr148841515ab.16.1733774141837; 
 Mon, 09 Dec 2024 11:55:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Francois Berder <fberder@outlook.fr>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Date: Mon,  9 Dec 2024 12:55:27 -0700
Message-Id: <20241209195528.730260-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209195528.730260-1-sjg@chromium.org>
References: <20241209195528.730260-1-sjg@chromium.org>
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

(no changes since v2)

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

