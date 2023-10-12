Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8ECDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4D186E5D;
	Thu, 12 Oct 2023 04:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZB7qg6QL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1091386D4C; Thu, 12 Oct 2023 03:59:36 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C5E86E65
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77433e7a876so30447985a.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075801; x=1697680601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFoQ+BA+4d//0M15e4zaWWu1QuS5/fBt1i9HqAlG5p8=;
 b=ZB7qg6QLkHSwF7pkJHzbcoWvfMGyzmf8Jdd7bnhsLzTIxKjof8i4DqjLDW+4XLpJvd
 Eczb/1bbvP2GLyoicfUlZb9BvYp9Udyz1hMmi1VtVVaatygfG+k6kt+aq2sk6CckXdj9
 NXf/AL4jIbZIFU1oWJesesxyUTqLQWJBnsPdbIrL6kmhrlyq+MYc4UReeQnq1dXyz+Qq
 M4zQyOlJtZxZfOGsXWYu3wXPZ+AmmD41d55MV85P4BUhJyUvZHfDnSwaQ4M8rNSjumpN
 X+gt8h1sw1BRBFyfruRbE4B9CmL7FliwRnZbeEef8ryjqAh9FxDHnV6DUScVFtLf6fCE
 3IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075801; x=1697680601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFoQ+BA+4d//0M15e4zaWWu1QuS5/fBt1i9HqAlG5p8=;
 b=PSNMU/U+SK3I+W6hLT/FnGkK8+JxzO/is8TV7ZcRwRRaPkEZDrE/xHSK3ce4guQV6K
 v2DnV1xl0TYBuUTZ/bAa0Nb8J7MXlJW4LEy8QapCZtsuKJJVvk3L3pKP4E+o7/ncARum
 vZacwvouxhgAGLiwO3VtlsBuci1K//yKtOLfDSJZFkWM0pjevCwudC4RF7Wyf6InGwr8
 P1BwV3YOFBOe5abJbknPxfhUv5mVkEIB+5xYsXHM1egPYA1AURXYv4hXY+DCI3XsQiJO
 3C2nYF/kbe2I2y8mLXOzyrLnGQbyXFpt87b+S+LO1bFQqIX2vmqzh7vj8iYub3hSg+Z7
 GurA==
X-Gm-Message-State: AOJu0YzUbhcFIiAyfeqbyTRIrPu8cXTVV2AFm1MrL5Qt14MKzzD7BkyU
 P+BEFYSCkjxxpOL695rvi0iak3DILKJN+A==
X-Google-Smtp-Source: AGHT+IHAoBQi0Ida0P4RFhG+kn+pkeMAmf7APpJPfpGs7jeTkD4oEGKq2DhulLLeGP+l+mIjPs1G3Q==
X-Received: by 2002:a05:620a:40c9:b0:772:63e5:5ab8 with SMTP id
 g9-20020a05620a40c900b0077263e55ab8mr27221574qko.3.1697075801664; 
 Wed, 11 Oct 2023 18:56:41 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y20-20020ac85254000000b004182037f655sm5758501qtn.14.2023.10.11.18.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:41 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 11/26] fs: ext4: Fix building ext4 in SPL if write is enabled
Date: Wed, 11 Oct 2023 21:56:11 -0400
Message-Id: <20231012015626.3487451-12-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

If EXT4_WRITE is enabled, write capabilities will be compiled into SPL, but
not CRC16. Add an option to enable CRC16 to avoid linker errors.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/Kconfig | 1 +
 lib/Kconfig        | 6 ++++++
 lib/Makefile       | 1 +
 3 files changed, 8 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ad574a600e3..6bc4066fad7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -657,6 +657,7 @@ config SPL_ETH
 
 config SPL_FS_EXT4
 	bool "Support EXT filesystems"
+	select SPL_CRC16 if EXT4_WRITE
 	help
 	  Enable support for EXT2/3/4 filesystems with SPL. This permits
 	  U-Boot (or Linux in Falcon mode) to be loaded from an EXT
diff --git a/lib/Kconfig b/lib/Kconfig
index 79cf9ef0fa3..f6ca559897e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -687,6 +687,12 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config SPL_CRC16
+	bool "Support CRC16 in SPL"
+	depends on SPL
+	help
+	  Enables CRC16 support in SPL. This is not normally required.
+
 config CRC32
 	def_bool y
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 1c31ad9531e..2a76acf100d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_TPM_V2) += tpm-v2.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)CRC8) += crc8.o
+obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
 
 obj-y += crypto/
 
-- 
2.37.1

