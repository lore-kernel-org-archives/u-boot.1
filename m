Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D656CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EFC869D1;
	Sun, 15 Oct 2023 08:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiOYzEwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FCB865B9; Sun, 15 Oct 2023 08:15:46 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DCD8691E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57bb0f5d00aso2304701eaf.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697350529; x=1697955329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XuoEPgsb8kwNYKbt/ixcsXdHyCAsmjSj2X25nS2LHI=;
 b=LiOYzEwLSnXVej2SHBPQiMUksWNQBXGp45YpdtRumv9mF8TFUDeuzGDvC8+ZzmVoTM
 VpePUogbjHplwaVc4+MQM0y50jKaN/L4C0ZyTs/IQNVmBG67KiRNIQUvKBYkhhRMlMoe
 Qbdf21hpIvTvUnqdDqqXDKCbBO0K+M4fetn3DZl9KSrOI1DSFRRUBR0N3WS/ZOblJOCc
 G2IaSZHsgZJ0qjRRD1jqgzxEmVdJPN5LL00qrt34Fc6JtL1lkh8yil6RmUPtGPR8JK1b
 ljflS0JmzwwWKhAVa+E/+O2r9Z3cO+/AcANl+puzQ7O5J2hccgWNZBGZGPRQcD79SBJt
 ZAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697350529; x=1697955329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XuoEPgsb8kwNYKbt/ixcsXdHyCAsmjSj2X25nS2LHI=;
 b=BDEBwVFPSbmrVXJafgHGUnY8XAzJ96yVrUB20BZkSU5xgB/7IBoTfm0H/JIdBGLVw1
 nNLGeUxPXC9WO9bZNwqLDOGgGjXzRyY1jkm3wWtZs4sWYQCj/BIgEom96GLDLK4oRvrl
 Iq6FXbMzRkE0+Uh+ole08e15oyx769qMsFehIDA3ynZRjdCYBTMczT72Rh5GoU2wrVZF
 8GA4soPvuPG/FuGNENIShZm+Ea2RJTSPim11FcF3fOZZbZrZSXn/J2XmW/p2wBrPSfTl
 7h+CXoa9LSbhe96dB7gQ5kGrVzk/3x6YL268uhBzmwqnVI+e/Gzx6JFK4rTseG3sIWjL
 ex3g==
X-Gm-Message-State: AOJu0YyjMMftAOrHXBD2kK3LFk/FqLtHb+Nw1bnlqkc3uzD2nIkNUYeV
 2obKucxJiAhbfWhxe1x80TB0nmLDO8rbVg==
X-Google-Smtp-Source: AGHT+IExghQzI/ygSnvJLLsNpKF/X3rfn2CbgCaZuuNZndt3gmjOv83elp190HOeCrbFMd+EaGeC3Q==
X-Received: by 2002:a05:622a:295:b0:417:eb46:f81 with SMTP id
 z21-20020a05622a029500b00417eb460f81mr38337117qtw.58.1697316500719; 
 Sat, 14 Oct 2023 13:48:20 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 jy8-20020a05622a818800b00417fa0cd77esm1737198qtb.80.2023.10.14.13.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:20 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 11/29] lib: acpi: Fix linking SPL when ACPIGEN is enabled
Date: Sat, 14 Oct 2023 16:47:47 -0400
Message-Id: <20231014204805.439009-12-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

lib/acpi/acpigen.o is only compiled into SPL when SPL_ACPIGEN is enabled.
Update several files which reference these functions accordingly.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/root.c  | 2 +-
 drivers/i2c/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 126b3140666..d4ae652bcfb 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -426,7 +426,7 @@ void dm_get_mem(struct dm_stats *stats)
 		stats->tag_size;
 }
 
-#ifdef CONFIG_ACPIGEN
+#if CONFIG_IS_ENABLED(ACPIGEN)
 static int root_acpi_get_name(const struct udevice *dev, char *out_name)
 {
 	return acpi_copy_name(out_name, "\\_SB");
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index d5b85f398db..a96a8c7e955 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 obj-$(CONFIG_$(SPL_)DM_I2C) += i2c-uclass.o
-ifdef CONFIG_ACPIGEN
+ifdef CONFIG_$(SPL_)ACPIGEN
 obj-$(CONFIG_$(SPL_)DM_I2C) += acpi_i2c.o
 endif
 obj-$(CONFIG_$(SPL_)DM_I2C_GPIO) += i2c-gpio.o
-- 
2.37.1

