Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342F9CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54AB832AD;
	Thu, 25 Sep 2025 22:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/LEXiVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B3B8003E; Thu, 25 Sep 2025 22:42:34 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBFB8003E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7a8e7ece907so167701a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758832949; x=1759437749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjjvQZ5XOvho/Yq56z/U9VfwzTLb1buNmmYTtilI6PI=;
 b=D/LEXiVA7csCXJgavUpOTvIw6hkdzBl/pMj7gUcbgchQIFm2xdkWFQxwQx15byLaM9
 xCNmtFMB4vBCIVFfNSxBlVbwlz/EONViql1cPxjYA4eERv97cBt0BmLO9z3lDb5sUCNz
 d3B+C64nS03irE6yrtBwsln383Ygr2gyjLM4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758832949; x=1759437749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjjvQZ5XOvho/Yq56z/U9VfwzTLb1buNmmYTtilI6PI=;
 b=PtLMOsC4moilHJHFYabyk87B+QhvSNxubUmBB5rC7TANWGJDJk0EdIM/rNDTqvwfYu
 lALoi8WDzFBa4sa/uQoucDpRdBY7maTsdYVSi+/w3hmepLwUjYTKzlzx0oq9eVVadUeX
 IEcToTUENWHV/dkqPQnAoGn4YDms2697RYTI+NZMEKGmNs4PEJsx3NdTjpZ1t5Fftwi/
 DRU2JHHfKSCW/3C+nJpkHmdYzL5KM8lOb+ycX51AU/woQEtx4FmNrviDukk+kkAqa3Rh
 tMqZvDN87WJSdUmKvKDxLDtQxUQvt84eIaeCrBBo5r+oDHUYN5SWnVAudjztNqJmFaUS
 H3+A==
X-Gm-Message-State: AOJu0Yzd6cUzXEv1eUtZa7TcYlA84+xckYNAeSqcmp7WAEG4o9Md656U
 mMRauBQijRg7W8dUmYT7Puw924DFwfUS8Gex47N+6yEzKA9ixRXFW5rd3gUQZvU7BdcwNuqHFuG
 XPWCGZ5o=
X-Gm-Gg: ASbGncsL0OTz7i4OMathyNiWBa0u8g6g75XpfBd1j9PmxmBFjqg+reuKyTKD4FA4EwR
 tJw24lt7oz7zM6/FXsyX+HC67csAIYatGgQBKSuqULP7Czw1FpzlFGqOJqBfoTW+lGaxtB0e0S+
 0eO1tccmWTIvaf3tMN2Rku17zHUQOTVCf3pxbXwPp/Z+MlJVy7Uyhz0tVyRHXoKLjgBs3JMHYOj
 rsw7M2bKndMzrfi/vupc8QFaFwvH9VTahTSrSUuqUiA7WJgMbpj8wLjFpopyGjaHSooENUYVr6w
 u0f5H0JXLKeU2rtRCpBgfHCXYc+8Wl6C3hilmSvYlCyE5aZPUb0au24eS7K4iQFWcstBuhtkWpX
 tMkLccwje9HSTLbCZha/DgKCMr94PzHxvra8DQ+heCl3OH0RaUTVc0OHXvK8=
X-Google-Smtp-Source: AGHT+IEgtoAqxt1HAlPvJ2dXt0UzR+IK6FpmPRoitKdzEg1V2yJ8PuBQBXJBopnMhmk/JuWJ/GLLIA==
X-Received: by 2002:a05:6830:dc2:b0:79d:ebe:f238 with SMTP id
 46e09a7af769-7a03eaf5f3fmr2411176a34.12.1758832949345; 
 Thu, 25 Sep 2025 13:42:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8dasm599072a34.4.2025.09.25.13.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:42:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 3/4] usb: host: xhci: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:42:24 -0600
Message-ID: <20250925204225.3560724-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204225.3560724-1-trini@konsulko.com>
References: <20250925204225.3560724-1-trini@konsulko.com>
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

