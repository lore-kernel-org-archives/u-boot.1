Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA181CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 16:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C76801DD;
	Mon, 18 Aug 2025 18:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M4L/TlSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C674803DF; Mon, 18 Aug 2025 18:54:11 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 324AB801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 18:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3110269717aso218276fac.1
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755536048; x=1756140848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAXjweTFRHVhkXS76yK5dPyS6utu1rSPu5SJN4BdDPk=;
 b=M4L/TlSixr8b5xb3FZv8RGIi+TBvZ8BiZ9RQ4iV15mB6fhxj7be2mOKBIZO5J0kOMR
 bgR2DIS6iik9AfbEtUebCoxxYa6u0yqLNnhS6Zce1VfufpXq16swxpTcAb0nt6PvpqCK
 qn9Pa/NLG3GlzG2TJKP6Dr+t10RgVp/WAo9hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755536048; x=1756140848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAXjweTFRHVhkXS76yK5dPyS6utu1rSPu5SJN4BdDPk=;
 b=RmTeeiuSEBSiUiIsaWo/jke1LUo4NshNdNaCchBYf3KaLbYSWyzeaweCDELQtvvypI
 NAXluttolKaLY5DH7eAHWLs3x1nurEjRwpWuOsf7bjtwGtMnHb/eaRRwr2iSYPcKtrj9
 Fu9PjwKKx7NI8a7Yb6CYKUmltOoegK1onf4pxYQkUKuYxsWq46XQpK8J5Q+13U4fJd+w
 7Fdk7DtXir0amFSHPMtB/603kzMCEt2j6usnth4DXykQg6jYjzpderREetsj/7jTpDPY
 u2sQAqBv0+EiLGcFK/CdUuJYj6D6rWVO9dJplfMcsr2Am/1+mP4qNHWsMFu0vQZv8WGw
 q4zA==
X-Gm-Message-State: AOJu0YxD3vnVgSCKpUGdZVfw95B2j64mSimxd9L6Tqmum1XkWxO+2+D+
 Qm4+vM0aSRDAEiSEjpLyyIR5GUkO3w5cdYyNtMgF18SGP/CgYcmXWcim/tGpO+3ZxyUjQlidjpB
 ylmQG31U=
X-Gm-Gg: ASbGnctBphcC7RjrZlncJfjcVv2mSrrPoo6g2Nz05QyX+tvWhos8voXmcGYj5flooX4
 1hNIM5W8A2DhKohFY4UZGdae7c10+CCX8lC6bkVqQgh39U0qiHzPHNJMV9bt50zuZliCiAKwWfX
 BT3I5OmegKnmhlK1S0hZU9spB6whoO9jfZmmyW1q0Bu2C9E0yFpLF81lw2/0eMOBdEcWqGTG5I2
 1kPJC4D5kdMyVBdmErRkrA4l3MySKdEVlRTlNWEXX7iPzPOUA+4EV3Yy3PbmCgXjDe5IrmjoqjS
 XHX8nW7yStb11fpHZx4rwQ3TxsFftqrmLFIUkmUkKeM5R1qjBYYkWYdJCDAGgy3LjGBrK6BfG5y
 8RA8cjq1HsrLnwHXmZ1JbM+xd7+UE0fS4jNx/TVndrFpbmwKHM58ZywyoNpA=
X-Google-Smtp-Source: AGHT+IFJ4qz4mNd68LmxcBy5V+Z2VZY7CN7xIViPob81YhZFpn9egp/i3H6I63Gg9F1HIBWJ2d4aDA==
X-Received: by 2002:a05:6871:e80b:b0:30c:4f83:79f8 with SMTP id
 586e51a60fabf-31108139f18mr215550fac.4.1755536047859; 
 Mon, 18 Aug 2025 09:54:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-743919da7e9sm1908573a34.7.2025.08.18.09.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:54:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alison Chaiken <alison@she-devel.com>
Subject: [PATCH] test: Update logic for video test
Date: Mon, 18 Aug 2025 10:54:06 -0600
Message-ID: <20250818165406.3194425-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The video test here is specific to the sandbox SDL video driver, so only
build it when that is enabled rather than VIDEO is enabled.

Reported-by: Alison Chaiken <alison@she-devel.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/dm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 474e77a2151f..2db0e3b8dfd0 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_TEE) += tee.o
 obj-$(CONFIG_TIMER) += timer.o
 obj-$(CONFIG_TPM_V2) += tpm.o
 obj-$(CONFIG_DM_USB) += usb.o
-obj-$(CONFIG_VIDEO) += video.o
+obj-$(CONFIG_VIDEO_SANDBOX_SDL) += video.o
 ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
 obj-y += virtio.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_device.o
-- 
2.43.0

