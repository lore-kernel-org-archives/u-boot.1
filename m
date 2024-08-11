Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB981C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88A488960;
	Sun, 11 Aug 2024 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kFPqfFSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17428861A; Sun, 11 Aug 2024 16:51:20 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141E287E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39b3cae5675so10096975ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387877; x=1723992677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIl3NxLT7YG27z9YjQMdHmJ9Ky0fFfDAYgAQsScCXRI=;
 b=kFPqfFSMbxtKdWiQ7gQI1SpEkQvEm8Pj8QftPBTHIgA9Srzyr1TK2X9wafukaoWCAD
 1CvTwJ2/MkSLvYUwgHE+N4LALwVDQ1dOZFKCkKlgDj+1qTC9JyklyKTb1efP9msSfSfP
 q94bF1SgnAkM/skEATvLaMzHX3QjK2zZaxtZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387877; x=1723992677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIl3NxLT7YG27z9YjQMdHmJ9Ky0fFfDAYgAQsScCXRI=;
 b=LOVi9f8SVhSGGGOFECl6dMFv84QkNMs0bOGhC42J6R2Ff+UVK44Kephu2eRXOw97PI
 3TszQoD5aeJCW4trhcPfPgX5hh9wRwK0HiqBqIhqMFoQMB8sNPqqn4bx+aZ7xoKJ/j/M
 IV5e/RBF1SKyBzmZS0H/vqncV3UOUfwLtB5i4ezYl8A10CY3oNm0olUHhBIAbRUOTurD
 yyD7aFfGFHOven15GIJdtFPADlBWM/cbsyvWjrFC5Dq8tjDtoCbTrNbgoOWpcJhVC19D
 70AVdJxo+SLQnWPBxsyyq1n5wbREnM8PraBW7w/vw/tHS3dM/SYLS0D3fw3iOxd7mQoU
 3xwQ==
X-Gm-Message-State: AOJu0Yy2lzfdoEKa7blp5dRLEuiyv00Nd5WJObIM5UkSYSwfuNhOTdVE
 qzg0Vb9+FjLgk1PVkh4OTkHBxVRCdmz7WkmgOuKICfPkZCJbiZLWYKOLMkXYCxb3DDxr33YSPaw
 =
X-Google-Smtp-Source: AGHT+IHjF5qsaViggKybnF8vTLf+4NCxSqgd8mFH9YSOgj2xNl/eh+TEnTemdeI2FXPQE8FPc786tA==
X-Received: by 2002:a05:6e02:15c6:b0:376:3ece:dc5 with SMTP id
 e9e14a558f8ab-39b5f9e56c2mr118583555ab.4.1723387876681; 
 Sun, 11 Aug 2024 07:51:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH v2 04/18] mips: malta: Drop CMD_DATE
Date: Sun, 11 Aug 2024 08:50:33 -0600
Message-Id: <20240811145047.4189460-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

These boards use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/malta64_defconfig   | 1 -
 configs/malta64el_defconfig | 1 -
 configs/malta_defconfig     | 1 -
 configs/maltael_defconfig   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index ff371daaa0d..8ac29b9289f 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -27,7 +27,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/malta64el_defconfig b/configs/malta64el_defconfig
index 5b130bcde9b..0a71013d5fc 100644
--- a/configs/malta64el_defconfig
+++ b/configs/malta64el_defconfig
@@ -29,7 +29,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/malta_defconfig b/configs/malta_defconfig
index ce917a69de5..355292ef950 100644
--- a/configs/malta_defconfig
+++ b/configs/malta_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/maltael_defconfig b/configs/maltael_defconfig
index de29a7a3a5b..ffd27713963 100644
--- a/configs/maltael_defconfig
+++ b/configs/maltael_defconfig
@@ -28,7 +28,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
-- 
2.34.1

