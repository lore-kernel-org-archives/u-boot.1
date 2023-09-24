Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536ACE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD06E86BA1;
	Sun, 24 Sep 2023 21:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R59qhBvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BF386AE9; Sun, 24 Sep 2023 21:26:10 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E64086ACC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fca042ec0so17221439f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583558; x=1696188358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr3ziMq7WmMc3zTn2VEs3Z5MaYDMSFAjHVpZ9Fr4qlY=;
 b=R59qhBvQb7a8KbI5KTabiEIgGt7Qw+LC6evSAWcfypLGioseLC2m7YUwtHe0sqCbQy
 Ji+ij5thcmlxPztHu+epb+vNNE+GKfIn+Kf1KKMzjkUQ2Dem5zLcrXl39lQ0ptD0IIer
 8rcw63+N7RA0v8VV1JJUN8bzzFa8qOSfbcivg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583558; x=1696188358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zr3ziMq7WmMc3zTn2VEs3Z5MaYDMSFAjHVpZ9Fr4qlY=;
 b=C1l0G6L3Iv/D3o533KOaxix+J7P+8odX0gNGc08eROqpvg5g/Z/+lOUJ/B0P48Pa0e
 rzMGEP6zItxMi1muyWZWElpuhkdnj13s2nDF+FUsBkyof932lXTKfC/QoSJwUewZiWBA
 z4pkMIv59WMORX+AgdBZUaZprUuAb1T0b9Zuu0ZjkoFqgROdZ99cXoUGRRNQb++AQkMU
 QKTkQQ/LxF+FRkkzmhofyFqOEizc4XHz2cj50Vfz3hV9faNFZvcs/9QyPfzfQ5Mc3S55
 HvWtTUrIwmfxiWG5WnYatsGZdQXKHriblPxD0SmQ64a4b1Vp004l01cJgp1gQyD11MSU
 kXmw==
X-Gm-Message-State: AOJu0Yx/rxiCqFKetroE6luhBor4O6e/bsyxPx+pN/YfeKajsRj0woVs
 jAjXAIA7BTYX8PPG+F9EUDc7+0MTPoruey9PHHQ=
X-Google-Smtp-Source: AGHT+IHcoVSOiQhoIbmPKYubEFXszZs3oOE4swwRF6ZA6tFnVD6lQSLYaoTZ0XKqBwZ/sGET2b9hTw==
X-Received: by 2002:a5e:8c04:0:b0:795:12b0:c2a1 with SMTP id
 n4-20020a5e8c04000000b0079512b0c2a1mr6469380ioj.10.1695583557996; 
 Sun, 24 Sep 2023 12:25:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: [PATCH v3 10/38] tpl: Enable CONFIG_TPL_SYS_MALLOC_F where needed
Date: Sun, 24 Sep 2023 13:24:55 -0600
Message-ID: <20230924192536.1812799-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Enable CONFIG_TPL_SYS_MALLOC_F for boards which have a non-zero value
for CONFIG_TPL_SYS_MALLOC_F_LEN

Note that the default is yes in most cases, so no changes are needed to
board defconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to nable CONFIG_TPL_SYS_MALLOC_F where needed

 arch/arm/mach-rockchip/rv1126/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 7382c5599661..a6e2b5903c67 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -42,6 +42,9 @@ config TPL_LDSCRIPT
 config TPL_STACK
         default 0xff718000
 
+config TPL_SYS_MALLOC_F
+	default y
+
 config TPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
-- 
2.42.0.515.g380fc7ccd1-goog

