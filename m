Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB7C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6477D80FF0;
	Sun, 26 Jan 2025 19:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wqr8gYjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0169380FC2; Sun, 26 Jan 2025 19:44:29 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A861480FD1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so100428439f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917063; x=1738521863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YD7/i2Ilf2SU6H/j/wdd1WkfJCi2iOm/ewdFOgV9YeE=;
 b=Wqr8gYjx2PQ+1wiTrBsgk8myks+9ZDBdSHwntvTA4tEuRxwEhVzJ0y+cIQ53V7DQgY
 Rpow0Xo32V0Q9U/0N9uOE3wS4BMNA2hvrPPLefWHzDD7Y2nPiH/4YMjhN2IZYBd9153f
 DJHMVz18uGNhNXBBTJaNLVM/vJhW3dr4aNHTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917063; x=1738521863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YD7/i2Ilf2SU6H/j/wdd1WkfJCi2iOm/ewdFOgV9YeE=;
 b=ewCda5UyXV6EhA71++7HVK1DEf8JolUZUjLAtxVHRkelrjLASJ+Pv1IP4mezwrXM/W
 zr8fzPYZATyxsfUEhiQ/Z7NELnoK8vAvoK29RU9vwxH5+fPLZHRHSF/QiuCEAKzgI+bU
 ISula1LMoS8DpTlORod8VzR9CH94wxD+qesJruNt37DJuZea/jPm8t1MXXjJ9H5gNC2c
 rnyV+OfOUSsYa215vxMSV1C3YFj5RpPDZwMZPJ2GfcCJyc2BoA9h4wdfq/b7Tm1IqvWt
 b/YSKJr1KnLwi4a/8QLCH6/GzbYZ2nabrxklflDIVRGBVGWVsBCOsCHFH5u/zCHjPuiP
 JFwQ==
X-Gm-Message-State: AOJu0Yz5Nfh3POlYYpilYYhj6m+w4cJfeKzxvtvFMIyOLZ4JXDHOM5pe
 lSkqZVx48aX8cgWTw3mngJqZVhQ7P6aQZc2EccB9nX9Y4UYYcrK9KBMAH1QKp7xz28KyltSDdXU
 =
X-Gm-Gg: ASbGnctvysmWv8wIRjMyw+Hn7ae5kKLv3b2EFPZgP06hdYYEU+04JtPzwjoNqGGLr9M
 t2fQB7TKRbpbsLnzC94GQWcyl1kj+3mi+QT27XJoqShyorMq/M33ietItqq0IUTnmGnX8d41s/Y
 +ukT2wApfcHU++vxb3gStCIoERO1lpTVOI2YBz59yeKQNQNj2XF+q/vh5Zl02pDYfsKpY1XZl+F
 1eO/NruHscFadmmO1jQzOsEI7ZtnGkA+TyKSU/a6+EQCEBaxZ20FNPsdQjN10zQwds/5K/+AFOq
 slN9GKrfW9n8+7Rj7D+707xFvCp7r6p/KqKv299TF6lwgY+aQY3O
X-Google-Smtp-Source: AGHT+IH23bxIyRuAejQq14yt6FV4IU1TWrNmnUvrWCW9JdjiMT0Imsvx/Ijzi4a0jIkeqQqsg9890Q==
X-Received: by 2002:a05:6602:6c19:b0:844:c750:3d9d with SMTP id
 ca18e2360f4ac-851b618c3bamr3854451639f.4.1737917063455; 
 Sun, 26 Jan 2025 10:44:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/19] vbe: Provide VPL binman-symbols for the next phase
Date: Sun, 26 Jan 2025 11:43:26 -0700
Message-ID: <20250126184333.4058848-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Add support for moving from TPL->VPL->SPL so that the VPL build can fit
properly into the boot flow.

Use #ifdefs to avoid creating unwanted symbols which Binman would then
try (and perhaps fail) to provide.

Add debugging to indicate the next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7cfbab06419..6b75910e243 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -50,8 +50,10 @@ u32 *boot_params_ptr = NULL;
 
 #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
 /* See spl.h for information about this */
+#if defined(CONFIG_SPL_BUILD)
 binman_sym_declare(ulong, u_boot_any, image_pos);
 binman_sym_declare(ulong, u_boot_any, size);
+#endif
 
 #ifdef CONFIG_TPL
 binman_sym_declare(ulong, u_boot_spl_any, image_pos);
@@ -179,9 +181,15 @@ ulong spl_get_image_pos(void)
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, image_pos);
 #endif
-	return xpl_next_phase() == PHASE_SPL ?
-		binman_sym(ulong, u_boot_spl_any, image_pos) :
-		binman_sym(ulong, u_boot_any, image_pos);
+#if defined(CONFIG_TPL) && !defined(CONFIG_VPL)
+	if (xpl_next_phase() == PHASE_SPL)
+		return binman_sym(ulong, u_boot_spl_any, image_pos);
+#endif
+#if defined(CONFIG_SPL_BUILD)
+	return binman_sym(ulong, u_boot_any, image_pos);
+#endif
+
+	return BINMAN_SYM_MISSING;
 }
 
 ulong spl_get_image_size(void)
@@ -263,14 +271,20 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 	 */
 	if (u_boot_pos && u_boot_pos != BINMAN_SYM_MISSING) {
 		/* Binman does not support separated entry addresses */
-		spl_image->entry_point = u_boot_pos;
-		spl_image->load_addr = u_boot_pos;
+		spl_image->entry_point = spl_get_image_text_base();
+		spl_image->load_addr = spl_get_image_text_base();
+		spl_image->size = spl_get_image_size();
+		log_debug("Next load addr %lx\n", spl_image->load_addr);
 	} else {
 		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
 		spl_image->load_addr = CONFIG_TEXT_BASE;
+		log_debug("Default load addr %x (u_boot_pos=%lx)\n",
+			  CONFIG_TEXT_BASE, u_boot_pos);
 	}
 	spl_image->os = IH_OS_U_BOOT;
-	spl_image->name = "U-Boot";
+	spl_image->name = xpl_name(xpl_next_phase());
+	log_debug("Next phase: %s at %lx size %lx\n", spl_image->name,
+		  spl_image->load_addr, (ulong)spl_image->size);
 }
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
-- 
2.43.0

