Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDEBC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8625788C61;
	Thu, 29 Aug 2024 16:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="goggEmrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FF488C4C; Thu, 29 Aug 2024 16:58:21 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A29CD88C39
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso3037325ab.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943497; x=1725548297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDwgz+tv41oZ9rFU6Vfvvgb6pdQt8SEam8Fm1feulPQ=;
 b=goggEmrcE6MKJckubrU88TCvnvYJPWCnL+Hk1dvvVbWDr1A1jymoCC7OrR4badlpV5
 zz8CY/oxWwK1Fb0uUoyyQHq+BTXopw0jXoWcKQn6PqfQ3fv0R0kzloi1PKZlOGvJGc0R
 lPUURCyfGQrSPWuqtLLZJ/FUtEl0k3KB+4zbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943497; x=1725548297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDwgz+tv41oZ9rFU6Vfvvgb6pdQt8SEam8Fm1feulPQ=;
 b=SD2Hef+wvnBofJ/0gABIxxyZoc0DXRHtog00KoCjh5I5ZKpi1sXMVx785XOLxswoy4
 YM7z7rOZinmtmv026dd7lrA0gc5fbu2mXksvcM59uc5jJ5d2LYcEpZSokgh8amqM6/2p
 lWH5vw39l693bXYaMIR81QvGWDeF+VdOsYB/zB/AdfnBgpc2OPvNxlb+GQdrP0AL5e+f
 +jQrLnTjRVkQzwdsos5VYTTbE5VlMACOE8fhN+bpFoTYzBHu8O7kNe9jUWaoEmFu5Abd
 a/inNnEOolHUHGWXWwHcTMy4Kt5ynkT0sWUMEv/E8gP/+ZoCF6Uxd89wrDSIvTTybMV+
 +9Sg==
X-Gm-Message-State: AOJu0Ywhca9cAbWwg1Wx8FhiXAZkfuW3wqBY9OX16aF447oGaPw+nGRK
 5/EqCqTXVViLSAK0R4j3chT2YBu66YbF9gVEaN2GlMsr94NvgXn+9GfyaBC9dzI0PmHAxCOAD+k
 =
X-Google-Smtp-Source: AGHT+IG4nzoEmdivdrqc+KUV0oLiUT98XCk1Bs2O2FZAEZN7/WmlhIlxZOtLQW6Fgt/IHfQCiCefHQ==
X-Received: by 2002:a05:6e02:1d04:b0:39d:286c:5b72 with SMTP id
 e9e14a558f8ab-39f378acb8emr33096525ab.28.1724943497263; 
 Thu, 29 Aug 2024 07:58:17 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/19] serial: ns16550: Allow clocks to be missing
Date: Thu, 29 Aug 2024 08:57:45 -0600
Message-Id: <20240829145802.1827952-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

Allow serial init when clock support is not enabled in a particular phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/serial/ns16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6fcb5b523ac..5cda273623d 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -570,7 +570,7 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
 		err = clk_get_rate(&clk);
 		if (!IS_ERR_VALUE(err))
 			plat->clock = err;
-	} else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS) {
+	} else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS && err != -EALREADY) {
 		debug("ns16550 failed to get clock\n");
 		return err;
 	}
-- 
2.34.1

