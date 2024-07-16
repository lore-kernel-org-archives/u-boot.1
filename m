Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A70C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D1A889C9;
	Tue, 16 Jul 2024 09:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N4xHE+a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA9588865; Tue, 16 Jul 2024 09:04:41 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833EF889AD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso67827291fa.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113478; x=1721718278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGEqpULOcVNkeVIabgiREXzdZtjLJqTLZEGcH2X3anA=;
 b=N4xHE+a/LzmhyumPI5MxNOBOpvyzL7BnP3mTzAP797keGz0SFxPu0N9L+O9AQaR913
 xHJJsxVNbjKyoHSsMEoNG3svPriIbhF02au9CfiwqEDq+2Wm/tfO7uGoso/iUpzBcPQN
 f9W6JHf7+SoVwp1SWUNUUaByzj7THiBY8n4O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113478; x=1721718278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGEqpULOcVNkeVIabgiREXzdZtjLJqTLZEGcH2X3anA=;
 b=i3BGMux2nnjR4vqk+O1TdSE6TUGXyytLr0HqKsCf/DPzFUUFH5s2u+NJ5XFXIegXOD
 DJRhvl186vB0/6oflJbocIfXsA4poaFthZqExTZOmcsmJEOgoQD0bMZB1EpcdIV5dsSG
 kOYk0NDOA6w/NotNY0hsvahfGyIN6BKjNlRDbY9iGBbDsm5AmO5+Gq6MWyLifntfDsTK
 6Kd+icioGJaXIimjIpPGKwihluLk4CuLoPuhdSINmUZ51fq8Pe5EujohpKABarcdAnca
 /MqjT5YnMqScrQWg3+ZRwkvmjuJXhu0U1P9Yl/jzVtC66lF5Pqdpufw751UNtvwE4sAE
 9RuA==
X-Gm-Message-State: AOJu0YyM7kgfFIqvlG1vA3soxGun1y+0oUSwK5bt/4Y20meTzAnbTArd
 9QkNgmtju3DRn2KBRpUNezrevpi8cNxMxkI+Corhlp61eOxHBoeZRwlAXpjF+W/0d3CfOSmWGBY
 =
X-Google-Smtp-Source: AGHT+IE5rMlzweJMrTzwHb1jtCyzTWUspffvTeIskPnO34+5iBJ6j1c1u6MiqunMz9JFmBxB603nNQ==
X-Received: by 2002:a2e:97c6:0:b0:2ee:4c66:6828 with SMTP id
 38308e7fff4ca-2eef419d89bmr7850711fa.24.1721113478574; 
 Tue, 16 Jul 2024 00:04:38 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 14/14] doc: Describe the bootstd settings
Date: Tue, 16 Jul 2024 08:04:19 +0100
Message-Id: <20240716070419.1897560-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

The bootstd node provides some configuration properties. Add these to
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 doc/develop/bootstd/overview.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 4a55b7da00a..d92a649beb0 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -406,6 +406,19 @@ You should probably also enable `CONFIG_BOOTSTD_DEFAULTS`, which provides
 several filesystem and network features (if `CONFIG_NET` is enabled) so that
 a good selection of boot options is available.
 
+Some devicetree properties are supported in the bootstd node when
+`CONFIG_BOOTSTD_FULL` is enabled:
+
+    filename-prefixes
+        List of prefixes to use when searching for files on block devices. This
+        defaults to {"/", "/boot/"} if not provided.
+
+    bootdev-order
+        Lists the bootdev ordering to use. Note that the deprecated
+        `boot_targets` environment variable overrides this, if present.
+
+    theme (subnode)
+        Sets the theme to use for menus. See :doc:`/develop/expo`.
 
 Available bootmeth drivers
 --------------------------
-- 
2.34.1

