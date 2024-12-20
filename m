Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B26E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4C180328;
	Fri, 20 Dec 2024 01:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BgblUD3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCC8803CF; Fri, 20 Dec 2024 01:35:11 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD62180384
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a7d690479eso10181635ab.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654907; x=1735259707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwHG8t4ktbzjPp+D1/FfhuiLUyVYcujRFJq9lLfQDPw=;
 b=BgblUD3PWScTwQLAJzE/Oot/XBeb8q8NOInFlcpULQU0R2rYP9YhgLTn8QoFs+x2Gc
 u0QI1tsKksMGkyiz3NDhp9Vho8Mp0K01ki1G3PfDxpyJMCNhwFg8RzJVVIpBYVnfpCa6
 oBNXWPNPr6b3grUTGvxF7CzZGBHMImtGAQ3HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654907; x=1735259707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwHG8t4ktbzjPp+D1/FfhuiLUyVYcujRFJq9lLfQDPw=;
 b=MJpJPs+7ma/A87QiOOhJ+Ve+Iq2PEs6T+lw3uEUCZFLg4vJTqt4CYtRNcjK3wOVLTE
 4C9jpDrOyDevAqqiAT+SHIQ0HX36b58DtkTseyBt6gd5s+FXBKOhSlSUo7S1b7YC/WKa
 oPDfrMR25lZySgzdrWcVNhmCqZk4LrUkgpu5SjJs7N6oIjTJAdXCKt85eWjnkUdYtzci
 1oUJ37WnPVPsoXZH6KotX/bqClDboVUB8Xg6lUFyMcZq84aJs1GB1mHD5/pg4vgNI5E/
 GNdKX2q2bIoEJAoZZ/jkgRbl1KouV8O3/gnLAH26wKIOLEOFy5HN1PjNyIdEqLq3OINv
 afLg==
X-Gm-Message-State: AOJu0YxD6ClCxPfcGgPhYmZiLgFhJgkQlj7jHZvSDMe6TKa2cfxVd5Lw
 4OiQb9clU/nIXid/kxCgMGPQrE7erHyP+oGg7uIpV305VVsibJQKfxuFNAQp/3cWjWfqYsyJPhc
 =
X-Gm-Gg: ASbGncsdBwWEJN47JaEsMZ/dr4dX6PhBebL6WArWvZe+NtbDTdsKm0RLWbohfd28HY+
 6dXlBaEKHlZpDWOrAAu51OPQlpl0jWwy54luTjKD6jpwYxYD/IaTw2k7z3wvtexi5j9mYoYDWNL
 NpxD9fTzXh8FkC2Ky/4wqDvZW2/t4EJUDuPnrc4iX2wdEJHMFQ3f3Xofx8UA849l8P/wRfgeqgC
 cqrkPhu9nsneX1WByzLHeGGUsdMtg2xKeqnf8J3neBJLsWteErYBqGZN45FZ/ICTSpC7A1NjA02
 c2/5Iss/KYaptaRbaQ==
X-Google-Smtp-Source: AGHT+IEuKEt5fhAhpe2R6+Vo5WxeY2tuQxDf44zg9kZanTl2+QTYXGJODBdQk5piCOw4lhXJtRqYgQ==
X-Received: by 2002:a92:c24c:0:b0:3a7:c5cb:8bf3 with SMTP id
 e9e14a558f8ab-3c2d277f5aamr10548715ab.9.1734654907098; 
 Thu, 19 Dec 2024 16:35:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:35:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Date: Thu, 19 Dec 2024 17:34:47 -0700
Message-Id: <20241220003447.2913443-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
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
---

Changes in v4:
- Expand the comment on set_fdt_addr()
- Update the commit message to talk in terms of my testing

Changes in v2:
- Drop patch to allow expanding the devicetree during relocation

 board/raspberrypi/rpi/rpi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index c46fe4b2350..f74006e0968 100644
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
@@ -326,18 +328,13 @@ static void set_fdtfile(void)
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
@@ -571,7 +568,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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

