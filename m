Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C3FCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C04836AC;
	Fri, 26 Sep 2025 17:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZqPpIsSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DA58319C; Fri, 26 Sep 2025 17:30:43 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7A1835B3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-4258ac8f64dso19605935ab.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900640; x=1759505440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxK/RLlHhwdDkrVtTW6DqOcJ4Vu9ANSUedDtYrjukrA=;
 b=ZqPpIsSgTlZhi/k3bvD23lYGfcGyZXlTSGTRKDJ3+oJvWVnO2RPI+310iTTSj5JsJC
 6C13uUrtnO0BJ5MPWrz9VJuWKBR32WnQ3ypkAxXyrGjFWAajFLYYMSlGJjcOH0NWVkWF
 j/zo6TSCJz795yPwD2P+w0GavJCQVPu8uWR9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900640; x=1759505440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxK/RLlHhwdDkrVtTW6DqOcJ4Vu9ANSUedDtYrjukrA=;
 b=RwhbXzDrvGaSal1YB+0QlcDpUPoxqJ+kNqAZnwqzBuWJWZIJN/JuOrsnry4GG8Twid
 5Gf2nIGm+RP4IY6wePALZoJqCkHDL0irGXEQ6MTfEUhmwQJDkcorwLzClcDhE/216sVo
 fW9tX7aNgK7/841Q4bZZK+GBdo+NS+B68Hh6rvntmjqJGFJqxj5iXXlnhQJNhjkCY7OK
 EQs0Qx7LvDjiwQOZrvnCph0uyA40BGYfOv+n57oelS4dN2vEfdjK7asnoGhMQ5JmW78/
 Urv3nJ+uwdxSC0yIFEehIbMHeyu8pfBh36LIbEm5VZcXZ0/QxrYN7p5qDDICqOKhj7qW
 +vWg==
X-Gm-Message-State: AOJu0YytpvlQN1dKJPGCqGLLHVvOKO55ZwY8vEv+/1354uwlAMa/9SGN
 GscrCCX3YrsFR5hGm06+qJhkZGXjXsA6fllcpHEn5W7hM8JKBatFD2MA/V09n8ixtbLRs9xtMiI
 4WY+i8uQ=
X-Gm-Gg: ASbGncsw8Tmzfi5DUf3ge+uMlXeLm4G9G3UIPvrZz2W/JEG+kh/5n8QTNaq0vphcdfb
 V4PyGTdITsZswqNL9ocLmeuVmnJoTbneB+Ra85DFDERVCAwH2jS+ep8S+kPKT3X1oI/SECHEgqR
 mHKhaZife75TBajjGNiO/xBHXz/dRMYC7rWhBozMkogEydckbln5PLkRinIx4dfmFzYcKyg37YN
 yDaK/xWybNNK89FRm8PnhMf12wpYbfOjERye7yEv4Lt9xs+Z1xZH3cvtJ72VfHVMf6rjWaGtrHX
 Scq0hk5Htv9bA9im1pYuUCwpNADcEiP8S0lzPJ6SIQEzpsT6khEet8gSvT+llozYR2n0IordSOO
 bRvQ/QdTalOycwV05lC7Y4ZhFecyljuxcJzGrV25Gz/JCU+hAe9QvVGjZ/lu9QplgibB6+A==
X-Google-Smtp-Source: AGHT+IGzdKM7X/jn309swy6jW8cX6EYfs8x4+8C30WVJk8kDEuR/ZpLL/DimSAF5NtZTdD+TNvX0WA==
X-Received: by 2002:a05:6e02:170b:b0:424:7bb:775c with SMTP id
 e9e14a558f8ab-4259565438bmr109135075ab.31.1758900639910; 
 Fri, 26 Sep 2025 08:30:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23263865ab.34.2025.09.26.08.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:30:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 4/5] usb: host: xhci: Make U_BOOT_DRIVER entries unique
Date: Fri, 26 Sep 2025 09:30:33 -0600
Message-ID: <20250926153034.3680674-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926153034.3680674-1-trini@konsulko.com>
References: <20250926153034.3680674-1-trini@konsulko.com>
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. Most of the XHCI drivers follow pattern of xhci_xxx in their
name, but a few used "usb_xhci". Change these to follow the pattern of
the rest of the XHCI glue drivers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/xhci-brcm.c    | 2 +-
 drivers/usb/host/xhci-exynos5.c | 2 +-
 drivers/usb/host/xhci-generic.c | 2 +-
 drivers/usb/host/xhci-mtk.c     | 2 +-
 drivers/usb/host/xhci-mvebu.c   | 2 +-
 drivers/usb/host/xhci-rcar.c    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
index 2ffad148dea6..595839fac3c9 100644
--- a/drivers/usb/host/xhci-brcm.c
+++ b/drivers/usb/host/xhci-brcm.c
@@ -85,7 +85,7 @@ static const struct udevice_id xhci_brcm_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_brcm) = {
 	.name				= "xhci_brcm",
 	.id				= UCLASS_USB,
 	.probe				= xhci_brcm_probe,
diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
index 6a2d422c4b8e..9a7c0f29dc8f 100644
--- a/drivers/usb/host/xhci-exynos5.c
+++ b/drivers/usb/host/xhci-exynos5.c
@@ -247,7 +247,7 @@ static const struct udevice_id xhci_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_exynos) = {
 	.name	= "xhci_exynos",
 	.id	= UCLASS_USB,
 	.of_match = xhci_usb_ids,
diff --git a/drivers/usb/host/xhci-generic.c b/drivers/usb/host/xhci-generic.c
index 355d4883176d..8bb4e2774230 100644
--- a/drivers/usb/host/xhci-generic.c
+++ b/drivers/usb/host/xhci-generic.c
@@ -61,7 +61,7 @@ static const struct udevice_id xhci_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_generic) = {
 	.name	= "xhci_generic",
 	.id	= UCLASS_USB,
 	.of_match = xhci_usb_ids,
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7e288f0575b6..ffe80c0bbdc6 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -357,7 +357,7 @@ static const struct udevice_id xhci_mtk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_mtk) = {
 	.name = "xhci-mtk",
 	.id = UCLASS_USB,
 	.of_match = xhci_mtk_ids,
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 1338b1021c64..12dc61aee9db 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -87,7 +87,7 @@ static const struct udevice_id xhci_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_mvebu) = {
 	.name	= "xhci_mvebu",
 	.id	= UCLASS_USB,
 	.of_match = xhci_usb_ids,
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index b72807053c42..95dfa2c3f874 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -149,7 +149,7 @@ static const struct udevice_id xhci_rcar_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_xhci) = {
+U_BOOT_DRIVER(xhci_rcar) = {
 	.name		= "xhci_rcar",
 	.id		= UCLASS_USB,
 	.probe		= xhci_rcar_probe,
-- 
2.43.0

