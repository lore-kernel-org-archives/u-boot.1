Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1357AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086C884B24;
	Tue,  7 Jul 2026 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EyfCD4GU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9329084B24; Tue,  7 Jul 2026 17:33:13 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3576A84AF7
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-49c86d1d21cso897828b6e.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438390; x=1784043190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJCKCmPFbjMhlo4o1vwX/nsQ3RqvhOeG27helk/5S5o=;
 b=EyfCD4GU8pRzIm2LcIa/Z+I6MusDL1bCCRfGwiIsXu+APlwFCsWNtK0B9hugkjxGqq
 h9WVpi0slwQKQ+NGxKBxUT/qM+4t7jl1wvuGTu5xvYzNezJZhZaaHEq8NHecA+hO4cjo
 eX2AmhSiy3sp83FtvQXyt4BCx3h9GqdUxjTYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438390; x=1784043190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJCKCmPFbjMhlo4o1vwX/nsQ3RqvhOeG27helk/5S5o=;
 b=imiocRe2ec+JWSfeGUTH7g+2x+m/PoYomrUFCQU5CPA473/TEdyL1SQBXfAPt68kQQ
 f2vmQLHUCWgtQkuAy0lnAbDw1+WO8CyxQrPfxFInvRMm8eWjGVJdz/BsBtDE9T5VXyLM
 JFMOZb4SMOhjInHSF0qvL43lFFpzzSUv1bypoxcqihjtlu3jO9DB6L5oOglvtS0w0hMZ
 AgebSeRX+tE8s0TDArd01ymMu3KCYyR27KCXVNmaQeMmsvzfMjoW8v/7I/D0FQCc/yln
 MYH/wrAUkqo8NZVfIfI77Rsbb1EkkdU84/3l37/FOw0x6DP+yCkAHcdTf2U7CNnjygN4
 ZPKw==
X-Gm-Message-State: AOJu0YxGBpwigNKi+aCGEiortRygpjxeYNVG5HqLDXaHT93Ob2bew9+R
 dTDoK8jcdyRhV4/qqEqohZotayc5jrVolHNmvbq3FkhNoHxjgfGsu0fMd7SFKLrOgc+uDfw1u1/
 duXGoBg==
X-Gm-Gg: AfdE7cl+ygFf1nNe1jgLFp1cQ+j8iIWyey8IA9RRZKoURuAZswCatx0hx3LKsUjpE1U
 U/EOVpf0cWc4pkcoJK2kruIkBfuVdVMgreLm5k+n7RpNgXqkbCK7XIFyKfN6uKYhe/Fq13/H9EY
 i33u8h9fpZugcR2VShqZvTL2269ktbo+SlZhwbQ+LzmqC1uK6chOfrKKF/jJ6Kv6C4ZVuPwzvj0
 g5tG4asgqtIG79voHj2bgr9gv239hLUcXnzxm96rqpVAvt4klL/VkLVBMbNEpEgEORq19k+2r/U
 cf7bZFmWfmlcIaz9xRdNvML2pBm4pEGsZhWDWC6J0BHOyGaQ6Qm0yrREox5+uskubVHu+yoklD4
 uoNX+HTUmeTgGuf44IHPqhS4rnwc4jJ7tUmTuQkRPh0Q4pV7io9n6vBoyzNJQppgs8emA58xWlM
 /WJyUrq/FfB8VGJfCxBw==
X-Received: by 2002:a05:6808:250c:b0:495:97ef:b41e with SMTP id
 5614622812f47-49fde4f6cbbmr3812532b6e.34.1783438389972; 
 Tue, 07 Jul 2026 08:33:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 15/15] rockchip: Support legacy images when booting from RAM
Date: Tue,  7 Jul 2026 09:31:13 -0600
Message-ID: <20260707153135.2048115-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

The ramboot loader used for maskrom-mode USB boot only handles FIT
payloads, but the maskrom usb472 image contains a legacy image on
32-bit boards without OP-TEE, since the FIT template requires either
TF-A or OP-TEE. Such boards print 'Trying to boot from RAM' and then
hang.

Use the binman payload symbols to locate a legacy image placed
directly after SPL and load it with spl_load(). This allows boards
like the Luckfox Pico Mini and the Omega4 to run U-Boot entirely from
RAM in maskrom mode

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/spl.c | 53 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079..1322fc000b0 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -14,6 +14,7 @@
 #include <mapmem.h>
 #include <ram.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/timer.h>
 #include <asm/global_data.h>
@@ -153,15 +154,14 @@ void spl_board_prepare_for_boot(void)
 	cleanup_before_linux();
 }
 
-#if CONFIG_IS_ENABLED(RAM_DEVICE) && IS_ENABLED(CONFIG_SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(RAM_DEVICE)
 binman_sym_declare_optional(ulong, payload, image_pos);
 binman_sym_declare_optional(ulong, payload, size);
 
 static ulong ramboot_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
-	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				    CONFIG_SPL_LOAD_FIT_ADDRESS);
+	ulong addr = (ulong)load->priv;
 
 	memcpy(buf, map_sysmem(addr + sector, 0), count);
 	return count;
@@ -170,29 +170,44 @@ static ulong ramboot_load_read(struct spl_load_info *load, ulong sector,
 static int ramboot_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	struct legacy_img_hdr *header;
-	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				    CONFIG_SPL_LOAD_FIT_ADDRESS);
 	ulong image_pos = binman_sym(ulong, payload, image_pos);
 	ulong size = binman_sym(ulong, payload, size);
+	struct legacy_img_hdr *header;
+	struct spl_load_info load;
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
+		ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
+					    CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+		if (addr == CFG_SYS_SDRAM_BASE || addr == CONFIG_SPL_TEXT_BASE)
+			return -ENODEV;
+
+		if (image_pos != BINMAN_SYM_MISSING &&
+		    size != BINMAN_SYM_MISSING) {
+			header = map_sysmem(image_pos, 0);
+			if (image_get_magic(header) == FDT_MAGIC) {
+				memmove(map_sysmem(addr, 0), header, size);
+				memset(header, 0, sizeof(*header));
+			}
+		}
 
-	if (addr == CFG_SYS_SDRAM_BASE || addr == CONFIG_SPL_TEXT_BASE)
-		return -ENODEV;
-
-	if (image_pos != BINMAN_SYM_MISSING && size != BINMAN_SYM_MISSING) {
-		header = map_sysmem(image_pos, 0);
+		header = map_sysmem(addr, 0);
 		if (image_get_magic(header) == FDT_MAGIC) {
-			memmove(map_sysmem(addr, 0), header, size);
-			memset(header, 0, sizeof(*header));
+			spl_load_init(&load, ramboot_load_read,
+				      map_sysmem(addr, 0), 1);
+			return spl_load_simple_fit(spl_image, &load, 0,
+						   header);
 		}
 	}
 
-	header = map_sysmem(addr, 0);
-	if (image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		spl_load_init(&load, ramboot_load_read, NULL, 1);
-		return spl_load_simple_fit(spl_image, &load, 0, header);
+	/* Fall back to a legacy image placed directly after SPL */
+	if (image_pos != BINMAN_SYM_MISSING && size != BINMAN_SYM_MISSING) {
+		header = map_sysmem(image_pos, 0);
+		if (image_get_magic(header) == IH_MAGIC) {
+			spl_load_init(&load, ramboot_load_read,
+				      map_sysmem(image_pos, 0), 1);
+			return spl_load(spl_image, bootdev, &load, size, 0);
+		}
 	}
 
 	return -ENODEV;
-- 
2.43.0

