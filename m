Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F575E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501518060C;
	Wed, 15 Jan 2025 03:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oe1D3Zyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D2780027; Wed, 15 Jan 2025 03:07:35 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C54980027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 03:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so547741185a.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736906852; x=1737511652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3OT9JFfy1uwauEFT4hDe5DLXljGa6RYZeo1yeFRcWs=;
 b=Oe1D3ZyiKa7iCC8bx/YLLFndtK64x0mV47blGLk/LGedSBCT0KLjUmBbGDShCxRzMh
 JL8DAwdZnMaJxzjZUfGgI0IWvEaYjx/oJw5sWgSjv8rEmClYfU5w4vS0CibiQoZa4qeg
 0qIXKmvo9VI9mYRiBd6HnT9o+EcUDayHWzdvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736906852; x=1737511652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3OT9JFfy1uwauEFT4hDe5DLXljGa6RYZeo1yeFRcWs=;
 b=PzZytGqHb0rHE5i6ZavjRzN6j74RG1EkL1uMNTL+IlUvouj0wkvLwq0LgmaB/Z2Q83
 UPirllQsfa7FCaoxVfYwO8BlESDJQrBanZp2jxAaykfWyu8+bTcFUsEfgo4AWQByS7EX
 C570jGhLIulb4omaI4O4oNx+NQhLsrHUAhdzruZyiE5rsXqXY/+M8QTVtgCvbsnzIcjD
 s6wDmd9B2OfK5VxPEkSaivY3rRirUa56GVhKJ25X62JZdG0YX+g+qGIXOdnCZXyi0rFo
 HM50zUcXxtNME79VE1V3u0zDfQmTeNTHu/Kr0MPRqScpcoKEzeGOLF0IY5cemxILk3TO
 IsXA==
X-Gm-Message-State: AOJu0Ywvx4zM/z8+WK60QfPiyBGnSYld2tSgUrPRHhAW3CgZxyQf2KTh
 8OExIYrU87HFg6ZYNbLSK05v1Of6PdErYTZy7xaOO/VxCVL445ZvU/1QymrXTV7EVARbcbJafYs
 v
X-Gm-Gg: ASbGncvGMhv8suWSmoO7CICUESdJIbded0e8Mt+Ssw8rcKCNSC5cnu5zxV81O+PdWKE
 LqPnYuRUZVUPV/pSq8MlyOs/uR9cWC8BtSYMRpR0Xq48bNfp0aY+z4yJ/eXK0xQ+N/8GFPzSqcC
 whahps91O+Ai9eyJ1Baz8E76adDMRKbLQsBhAS48M3qWnc/xinh8V1Ha2mIIic2W1qu7+ZHgJTf
 72fYmMQBPNAUu6Rddov7pk1OxG+wUndrmS5uoHsllOkiOxOa6EBS5HfHOuKhxuRzj4pIA+K12GC
X-Google-Smtp-Source: AGHT+IFCpArSDVrUpSISWdxzjzp9ujHg6bdpHd5ixd0AWbyxhgcNF6AJDUU/vd7FXNRFItKi9gxH2A==
X-Received: by 2002:a05:620a:5dd9:b0:7be:2a68:6d79 with SMTP id
 af79cd13be357-7be2a686e05mr1934652385a.7.1736906851977; 
 Tue, 14 Jan 2025 18:07:31 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3238003sm675238485a.2.2025.01.14.18.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 18:07:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH] configs/am62x_r5_usbdfu.config: More completely disable MMC
Date: Tue, 14 Jan 2025 20:07:29 -0600
Message-ID: <20250115020729.230536-1-trini@konsulko.com>
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

As this fragment turns off MMC in both SPL and full U-Boot, we can turn
the whole symbol off rather than just the MMC driver.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Sjoerd Simons <sjoerd@collabora.com>
---
 configs/am62x_r5_usbdfu.config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
index 772bb2ab935d..414e7ddfe244 100644
--- a/configs/am62x_r5_usbdfu.config
+++ b/configs/am62x_r5_usbdfu.config
@@ -23,6 +23,5 @@ CONFIG_SPL_DFU=y
 # CONFIG_SPL_SPI is not set
 # CONFIG_SPL_SYS_MALLOC is not set
 # CONFIG_CMD_GPT is not set
-# CONFIG_CMD_MMC is not set
 # CONFIG_CMD_FAT is not set
-# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC is not set
-- 
2.43.0

