Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07027CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 22:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427B084198;
	Wed, 13 May 2026 00:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wTM/yl3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7103845C8; Wed, 13 May 2026 00:32:27 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E1C83E36
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so6541673a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778625144; x=1779229944;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L7WUuaQ5Wlb7ZoqiQOpFGPE3Wo4OJIzN2O+W1QB26s0=;
 b=wTM/yl3QJWbqNbivbSzn1ZauJvbUIABigkKpDqscXhd9TXf6RpPtRkaH3wcgMOQleD
 si8Fr5IM8YCpV7KKwKv676a8zla4k50zTWbOieu4UERfvJb65giwDT1PTIHr0Pvc+XmO
 wf2hvlsf/A1fQQ6RCI/bDWS+OGwnX6iHa7jTEBjdx090cTErgyiUwItm9DIjgspypjXW
 aRxX7121+ps+qInkA7k+bckGCrWn3Zo7tqMZ5AqevoAHq+BjHGysGLf/m+OLBFVjQd4y
 Xmrdi+HNoFulxxt1+BtLH+CBJ7qc20HOWWHOmEtNVZ68n/po0XT7qE4VxeYb2skJQOlQ
 VY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778625144; x=1779229944;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L7WUuaQ5Wlb7ZoqiQOpFGPE3Wo4OJIzN2O+W1QB26s0=;
 b=fsA9o9TWI29eCCWfgj20NkDKbHA7op4/7LIDexgZR/8OvnxCy69m/PTd9acFjTUYTe
 IeEJykePYBSdF6tSuHgOtrBmkBeQapG+8bCeSWJhgFOp+gU/1cYWqfunuyzzvJjxDyho
 GAkhDXwOfiItCy8FEy38xjzNlsBbyw4rK5MqCekAqSgH8yIZO6Z28K5S9rTEjr617vGp
 3o6KlOxFKe8BpF1zM/ncmGzM5NV4BP6TQFND2rPO5Yp0mD89y6m4378/UVn3pFdCTDXC
 0lSGisu9+QbFCtsIv7WTvjAGK5gy5Tig2B30mBu8dpoVVf2DvdPca2gJJ4FjQMIaZfJv
 DzLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XsIRuxd4QBVnHK1j1qMVbG6+EVCRtT+3bCFmJrIxqv6MFajFxZxrTh9UeugK1nYEAJ3i4xMI=@lists.denx.de
X-Gm-Message-State: AOJu0YytnxE9NCh6LxEGdpC+I6xcIJZzMzxzmHlUnBfiAkYTHULx7uV+
 xnC+O00GsU9uN6grQkdRqrHy1ly1xBuwJ5XkDceVdtaVdoxg3iyl/eLxQVX8LpHpUdD0OyDBUMg
 IYeMu
X-Gm-Gg: Acq92OHu/aLYasu8wEnV17hFBsQ0Xk99XMO1gvLlGTDENmagdsIRrlq76ltJNCvubo1
 yKSZXBFni4roFm6jaI6PBOB5nH4U+nPHM0ij66wU/U1oeTeANpysvmzM/oP0JBNjlW6YNBpLtm1
 OlFevIM/Tda2Ijqjv7wa1fl4fxQ5kpXS3KjbEvvUX/8vC9jJ4Ttp08u43Y0YR8us+818vq79+KW
 yYE2yEkuZfx06OMlzLs+1UF885zJpRC8nHJXgJI/eEtE2/mfg2f2bo51hBsCrop8uMnrr1xTZmC
 Ckj4R706AqRuAYDEWZ3xRLhNGrXkomLRFP0LdIxptYhXSTTjrgeMeiQO3En0z7OUVusUyMu5j82
 bq57mAcmV+PrOP9/l505QLHb8rYFoHxvgTb/5EOPNDXp0HixRC3Ib0jVKZvFR1ecraQFh6z3qMI
 +ny9hzfU4rRuFGukNITUopPzRWDawy
X-Received: by 2002:a05:6820:4cc4:b0:694:9070:8227 with SMTP id
 006d021491bc7-69b7ab62e5bmr28404eaf.41.1778625144406; 
 Tue, 12 May 2026 15:32:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dc0193sm8334545eaf.11.2026.05.12.15.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 15:32:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 17:31:51 -0500
Subject: [PATCH v2 1/3] configs/mt8188: enable bootstd, FIT and DT overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mtk-genio-defconfig-v2-1-bf4c30ef7f14@baylibre.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cxxYNlxHkWfBx5ijoytTakJI942thx7x6guQK8O8XRs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6pgzH216Ht/bqdRjK+5qO/js8eduHjx3nObJ
 vvbe0Oz8smJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOqYBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7F4H/iBTiwW2V2Q9f04VLMH6/z3S9IZlPF+WWVxAmqC
 057cNX3+hhvPCkBR+ZU1IWO1v9A5V6lfTH0P+mUb5PeZfWi+kUDHupT6rXftP40B0FOMu6aDLQa
 jZvp2Bm3KjyBUtwkRrCt4oAC8LZXB+faOOjlxPMr/DT8Tn/pz/gb4yPQOHcz/REq9qSe6UEf2Bj
 ijN+OsAV9FaIEEpcUX+K8WnOm2hOJ6JYSohpXX3AKRSL9VL00IsmlUCLCkaHoFsJbGZVGhQI/tc
 0fn0xzhz34m7XhiCaLRlFDuA38FNEThr5WLbpb8hTKy4uaBKfdbHQINPtiJnUGWgxsDcNiK99ey
 mQMw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable options needed by the default board support package for Genio
510/700 EVK boards that use this config.

CONFIG_CMD_PART is selected by the new options, so is removed here since
it is now redundant.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8188.config | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 9dfba6bf99f..0f748415602 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -4,13 +4,15 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y

-- 
2.43.0

