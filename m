Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E0BC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F28688A2F;
	Tue,  6 Aug 2024 14:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mZJUjmGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B2288A27; Tue,  6 Aug 2024 14:59:25 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474A588A2A
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso192561439f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949160; x=1723553960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=mZJUjmGm7wLAZN1IQvnz0PiD48les8z9/r36N2LQPCVUxbmjISgNPhs/zEKOQr0ipi
 k/iV465DYZaHFKmlKTP9/DGD12N1stXWmXAkbKEW8vn2szYcwTz/o48geZuf6qi079id
 l2LmrGWJwESCvtWaEFNAT8ZzMISxSfNsxYPYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949160; x=1723553960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=G7wlV67mJgBr+U302wVvE3TQxD0OZzWelsX4VyZyvkNPzAFgA6tjyrqBnx52Be7/x3
 0L+iTzr/RpoYzV8zZ6U1roIOlYyL0zwMJnd8IRMx3PGTU6/60xUBf2vBkiCpAmet+Doy
 ZWy8p/RHUir/jS43/BJ7ZGRdLx2eBTaPxMdQH2zTZjBSx3hH+HAwuq1JAG4rdmtvAsY7
 r3qFPDPjkeA6E3T2LAehyaA5KZfAdUGWRz0Cs6af5q1aHjI0cMhJSCKkdSCZJNgEg1sW
 52ohqlKDVerG5OgoubSPe7JB+VVH8jkhNkQ1hpcjkobGd8MjU0dXzY769hNyH8Gn8DXp
 omcQ==
X-Gm-Message-State: AOJu0YwimTYzzz6geBb0+4+ZR2DU6caG7ZeOsdufnnZ4t7VF4ufCi0Ly
 1FDjtEyhxnUEc0QsoVjiQpkwrrZr87ynHiYaKm7ZaCrlBYmk2ytuvR3bYmh1/dg2TpdU5UzGLkE
 =
X-Google-Smtp-Source: AGHT+IEr2N0+fuLGyB73giWvpmLF/UqVBXyuC2qfEBCav53JsWWGUA05rb+OWVgCV4diDKbJgdt4Lg==
X-Received: by 2002:a05:6e02:c73:b0:39b:20e0:948 with SMTP id
 e9e14a558f8ab-39b20e009e3mr117363145ab.10.1722949160401; 
 Tue, 06 Aug 2024 05:59:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2 02/39] nvmxip: Avoid probing on boot
Date: Tue,  6 Aug 2024 06:58:13 -0600
Message-Id: <20240806125850.2316956-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Devices should be probed when they are used, not before. Drop this
boot-time probing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 58e8c3fb74b..d18bd0e3d6b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
 	return 0;
 }
 
-static int nvmxip_post_bind(struct udevice *udev)
-{
-	dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
-	return 0;
-}
-
 UCLASS_DRIVER(nvmxip) = {
 	.name	   = "nvmxip",
 	.id	   = UCLASS_NVMXIP,
-	.post_bind = nvmxip_post_bind,
 };
-- 
2.34.1

