Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3841910775E6
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED1783A1B;
	Wed, 18 Mar 2026 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xbcs5vJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB38783BC7; Wed, 18 Mar 2026 17:45:25 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E247583015
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so573515e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852323; x=1774457123;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LPmYUe74yJNM3j3SfFBi3JrYJDd3cJE7GJxFiLu5FtM=;
 b=Xbcs5vJibrf3qhRkdgPe0K3MkSOVsUYg0rQ72Amep1phR6+4lYGj2uO7r43uKmy87c
 d4UTdgPNHL83OPhdrJUAovlgLiEwjnV8WciifWiZ/6HTJN4ikUtI0TvDGqNgpGoo80lK
 wZyK9HFADf2bl3pfFqcOek3om/+6T2OsFroRyt3k3FV9khigjdi8lEUIT5zexvQWEzkM
 9PorWZ+bqJ5l0/ISmQgP39upP+DT5cPJRg7k8SnfzJNEJ3RB2sHosUeu40oQOFlllLUx
 EsFy+ly4meRdFT+eQZO19EcoSbH1Kjtn0Inz2LkYCO1k308sO09ACEa9Y4pKXUeH4MYn
 5uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852323; x=1774457123;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LPmYUe74yJNM3j3SfFBi3JrYJDd3cJE7GJxFiLu5FtM=;
 b=rZkh2ck3P7zsKEjv2S/dkNxYbXvgTzl/7cZwUaVHRaQlYWCss0pn2P0Negv78OGIvN
 DgrLxDQWQ1BlGoswb/yfhjAfv+v/Q1F65HKz1c9DJR9C87a/PaRZxHKuxM3LA+Q5oTPb
 qr+PYxqRO3x2yZ/Vo0mNlPefy8/IY4JZ1W7U7eyC4Pa9iqEM6uN7xoptjFB/dTVgvf7o
 cS+oMxjTt7SaYR/5y78m0/rCXBpc5Fg4AGNdoS5Hqi7EjY6pHGU04CHSPLYtOOlRGZEz
 dDb6fcMBfhxIcLcQRVhoqVVp2vTSxKTBOgyf/w7I1/zjsbojUscLwpyzIFJmcpz9yY00
 lstw==
X-Gm-Message-State: AOJu0YwphYTKBI81W68Ccytk1WpV3keOzMUEvixjpmbfZDubMMkxTCB3
 ptqL5oPZFEkjJ37UT5yBIz/JsF0D7suHqZYe2qGQ2e5YBQmAGMTTdO1HY7USf4NGoM8=
X-Gm-Gg: ATEYQzy91upu1wYGQXcxtZxiz+d6XSzPAhWIoL7Dxic5sUI4Wz0ez7p18tRiMxh71Is
 Rhz1ODFUUAK47IubnlDqxqLyBQi2SskZFuuK1IPnifO/Aad2hUa3lJKGpzzzje9Gb4kt7l2yMoO
 lGTufTuuT5t/L9cTSC1yWY2V5cbR9cPA9IqJqnIQqOe3sRvAqFKO49eER6JUnw9bk+gYQFcj5zK
 qfo6/3Kw+OjQrDy/TRng4cu+QIjk4nJXteMHRzib5l1qeIFJIUZfFaFkQAuA966Kwb37GefuPIj
 U/jI0Y9HCODYQeXcux5lRMViG9v/kWaInarGV5R0aMvoXA/Lv1+tG5BAD62ln3nHTS6F4EPbd4T
 r7hHmfBr1R39o0u/P0Gk75qbMX/AwQ/VaH7LpRIA5FxBwuOL9C6iDowlCrAS8Rl/E0T77/vjB3x
 5c+8tIWg7NeUle3zvYVsESVIQbg81pam6YPN4V+Rjx1Q3X0VFwMh9iQhOIKxROLZ+m88zIua9ls
 yWW1PrVTsbarRgrgMpDwgTa9JRAQGrgIUn+IRB5nFUxqR1lZT1cOV9E5wohspGszuyLgUpOK0LV
 7u78WEk=
X-Received: by 2002:a5d:5f86:0:b0:439:fd78:188d with SMTP id
 ffacd0b85a97d-43b527aaa6bmr7330947f8f.17.1773852323251; 
 Wed, 18 Mar 2026 09:45:23 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:25 +0100
Subject: [PATCH v2 3/6] configs: mt8370_evk: rename to
 mt8370_genio_510_evk_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-3-1f77580d72f3@baylibre.com>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Rename mt8370_evk to match the name of the device tree which is
mt8370-genio-510-evk.dts

Also update CONFIG_IDENT_STRING to be consistent.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS                                       | 4 ++--
 configs/{mt8370_evk_defconfig => mt8370_genio_510_evk_defconfig} | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5ae23b1628c..01698cb57cb 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -3,10 +3,10 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
-MT8370 EVK
+MT8370
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
-F:	configs/mt8370_evk_defconfig
+F:	configs/mt8370_genio_510_evk_defconfig
 
 MT8390 EVK
 M:	Julien Masson <jmasson@baylibre.com>
diff --git a/configs/mt8370_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
similarity index 93%
rename from configs/mt8370_evk_defconfig
rename to configs/mt8370_genio_510_evk_defconfig
index 48d3f64a42e..53ef067af22 100644
--- a/configs/mt8370_evk_defconfig
+++ b/configs/mt8370_genio_510_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
 CONFIG_TARGET_MT8188=y
 CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
 CONFIG_SYS_LOAD_ADDR=0x4c000000
-CONFIG_IDENT_STRING="mt8370-evk"
+CONFIG_IDENT_STRING="mt8370-genio-510-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

-- 
2.52.0

