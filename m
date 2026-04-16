Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DD9F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8388584497;
	Fri, 17 Apr 2026 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bz2fbcTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7819684201; Thu, 16 Apr 2026 17:20:28 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60506840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so728472685a.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352825; x=1776957625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=Bz2fbcThHgUQkOl3ImO1zk5qGpNn1hu+NVaxJZL3wXLR7PZtZpzCdWW3MBzqCMVAJO
 WsTE/p10+5rlKvRtqlDOknxgzHD0RtOlwojCHR1i8rcyyW42PuJsGnpRZf/zVWbjagOx
 6ezMIa6FcZ/iQ7RlxRfQkDFnR33C9QNfGYO2UyJD8F65BhHZpwlDLHX9XhaYTWjfxF6w
 Ljqj2hiR9PW3KbMZ8+4nYjgG0xzFyeIRgjpdpqtfa6YcSPVjWPf5rR6+hjaq9GEGrm6k
 YK67Orsv/Ac1qHCgFw8Lza16gxWzGtXwKGso5F74BYhgWZPzy42CH37gEJWfnORQyydx
 RX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352825; x=1776957625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=ow64EG2gJDEm5IwZB5j5kYUnajHA212hRYg2s68O11QeuOxeJ2LDp7LvzDdnGJddoh
 SxktTOIDNSvgtNPQbedpVn7H9UPlLOsdradfGZnLUvUSbDDEiAyBi6XOBAUvpDwiY+9E
 WT4EuZK6jRgv3ft9hhcEwCnjlx/xIoyMZlmysuc+hfbyFCZFzE4d+7oGio7beKWb41Rx
 rn58NhO8dBEulwTFxzE8d6S6JKBgTIufnV9nnDrmwcGj1nBPBJoB47r79PNhBcmSFeMs
 laJ67yn+I6qwGVldBr050TzKWYD28k+T4Q2ICRDG8jPjxdVn7KTNFeX+qveX62wIQPcT
 HCBg==
X-Gm-Message-State: AOJu0YwZXbPmBMGwrnNnqAdMqIDnmcIaTWsbq9foy+/a5LcKDT7mY13t
 2Ghl8IsKDVq8xSyxKaKqmQ80AvZk4zNj4i1teVoVWgpEZx6xegjT/7+uW3YcraZz
X-Gm-Gg: AeBDiev8Iuw7CbZOxlSHLt274JyW4kIRvDKxx7FaFRr/anHI1kzkj4//Gyj+C1vYfMe
 ueHwRdoJhsi/kc7kHph/9W0wCrfI73ktgcz5qhhBVef0zeGSclfrxBUR7XHNDz3alDqR22TL0tk
 P6TjTYXb+mn0i54cyj+oMoDloaTU+eWk1qeuX/TeHSBIpdJoHBeuQKYllxEXnvh+j96Mihv+3Mk
 CA4NDF4kOx8OsCvS6HdD8/zAGYvS6BfanXmdIUceKeus27m3iW7eERu7r5U/l9gkxk8FLXzBJ1E
 75UhTYTS1JGXTu084MqyzQjdMTh6+3z1ma3Jtb1VCRFMfneum+8gfsfQaZUuHP3kGeKLzVb8Gvm
 Vd4CTYnKRnCU/kUziPNgH2Duu39s6tNSVDxdfCDt3OkWroHOoVem3ngWJtJ2lt5LEGjhJwsv1YD
 Lf2x1H5XCCuHQ1vwpg4byUu0MbEHF04G7xlA==
X-Received: by 2002:a0c:f40e:0:b0:8a3:d463:da96 with SMTP id
 6a1803df08f44-8ac862b66demr419728586d6.43.1776352824990; 
 Thu, 16 Apr 2026 08:20:24 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:24 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 11/14] configs: sc5xx: Set default bootcmd to SPI boot
Date: Thu, 16 Apr 2026 11:19:46 -0400
Message-Id: <d94f35e58449d36e93362ac5733cb5d6b6c70fbf.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Align configs to use the same default bootcommand.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc589-ezkit_defconfig          | 2 +-
 configs/sc589-mini_defconfig           | 2 +-
 configs/sc594-som-ezkit-spl_defconfig  | 2 +-
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index a249fe8df7b..d8982f62d82 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -22,7 +22,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 25285695367..78b39b6dd73 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 89ef08c1a72..23951d0b5f1 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -15,7 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 9e907d31136..b4e71b5d2eb 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
-- 
2.34.1

