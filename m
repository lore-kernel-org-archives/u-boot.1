Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32E210775E6
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7873683DA6;
	Wed, 18 Mar 2026 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qBygJW6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C0783D71; Wed, 18 Mar 2026 17:45:27 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DB88341A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so563555e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852324; x=1774457124;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nss73WuEoIxGCWRV2oNuKZxLgUL3eLXIt9TPaQz/Q2w=;
 b=qBygJW6RUo6wY5X+55l64h2reETziaX7O2WgHGCjMVIS+GjUaSMHRPv+LGE9oJ748C
 Uztg+B0m42wLhvRPqauxynlb0Fzk6VezL9nitFVb5SGMeGeZV59+6fvszCjh/BwyVrbk
 EISPW5G2MLA/KJJkIarMFElPge5RUY9FdH7XzyuxwQUBLuIuot1cKqBE8Lg/gIY7ucy3
 t24XGLzIjuoQCcB++UYuQqepB6dxzMDMCuKCqMnVY7Idjeu6ul+vfPy3U23P+z7hjfoG
 jXGYCGE6jS3DilRHk1aIpqke3QvyLntrJORz9LZLNVLsmxPipw4olvxOVemxyEvC/Yu7
 sZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852324; x=1774457124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nss73WuEoIxGCWRV2oNuKZxLgUL3eLXIt9TPaQz/Q2w=;
 b=nzzZuhV350u3AXNxu2hPIogA5Gv1TsT/tdgoZbdwM+52lBrzZ63wfBq571v+upKbWv
 YlLTebEyqFpZITcvCxCUnhfdpJv2wo6q57VHfkpd6GM8kOrRw1kSkwB/C7Kkh4qcQH8t
 zyVZoEmszZIHzgPv5KDaXvMfoc5EPJhy79gzYEc/MASfFdHQQE/y1ptqGhNj0JX3ysFg
 T8ZAz828v4jPhdTg54Mt1bM5WlQ/X7DECBOKnl02utl0uIJmKSn0b9DMappHsq1+nuvG
 unbvmupsRYjVGNYEjLC2k9ICtv+cO6FbfTYg7UvVN4hMki6YIbjmLBhJjfIBeJR75cCR
 0SKw==
X-Gm-Message-State: AOJu0YwdlEh32l0SOeI+1HUDRL0jFW3nKOkaF++2OM5SYyPsRB74QRzM
 5HWHdHrp7h1oPYaUSIi2gUBQEbUnOu0W42tFy7xv+gBwp3bZu7io1oBqx1qQeZftcGvlL8ckMXA
 Lc9B+xAY=
X-Gm-Gg: ATEYQzwDGuDZEFcyLDV332f44hFAHwyD8YpoPAxFDFr2eo4K8qvzzkmA5dMDb3MUIgM
 PaKr5e/WLLLfna+JbwUOeubYiZnFfHSa6NQ0nnT/0uCfgRP88wNXNI71mW/bUBOHZ6N+gtglMjk
 NPnFj4nziQqxLTiCmYxEDlFyjMBNOMVBBpnxTtAUPHGMPO7bFyG9/oItiLMpePtKZPtxTK8Rjvn
 shWc2I9yJMrS3xN/KBkW0pqVHPLeq2xiqZ4mLG0LjwgQDcElL4Krt7LTQi9BGKGwNNY9kjzSfVN
 oRNdkyNZ5yQ2x+qGUfttAOItVOYNBKvIpUpwNA+tn0FVrw3jJkgiEHIqgHM7B6lBdGgK/85t9mj
 ROj4h1YwQhsW8VHGPYU/K9nVwnSMQI7A/jlroPa3Qu1VUsx9YyXzV6QdbUBviJJhdIB9jh2xzCl
 7cPPhMbPZo6A7brxGVG6ZSlbzthRbwvR+4W3wtqQuEl4h0P1E0YVydreMrsMBfttk7i+M3D1Snw
 K4YKBjvMV/Tc28O5A2mANprkes3pAWYZiFpGdKHDha6pN9FWnYU27TEeb1DbySWXBne5ek2y6l0
 goyP+20=
X-Received: by 2002:a05:600c:630a:b0:483:c35d:3659 with SMTP id
 5b1f17b1804b1-486f4448621mr66609185e9.18.1773852324109; 
 Wed, 18 Mar 2026 09:45:24 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:26 +0100
Subject: [PATCH v2 4/6] configs: mt8390_evk: rename to
 mt8390_genio_700_evk_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-4-1f77580d72f3@baylibre.com>
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

Rename mt8390_evk to match the name of the device tree which is
mt8390-genio-700-evk.dts

Also update CONFIG_IDENT_STRING to be consistent.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS                                       | 4 ++--
 configs/{mt8390_evk_defconfig => mt8390_genio_700_evk_defconfig} | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 01698cb57cb..a1f34a91ebd 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -8,11 +8,11 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8370_genio_510_evk_defconfig
 
-MT8390 EVK
+MT8390
 M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
-F:	configs/mt8390_evk_defconfig
+F:	configs/mt8390_genio_700_evk_defconfig
 
 MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/configs/mt8390_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
similarity index 93%
rename from configs/mt8390_evk_defconfig
rename to configs/mt8390_genio_700_evk_defconfig
index 99272f17989..0ca4279c1ae 100644
--- a/configs/mt8390_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
-CONFIG_IDENT_STRING="mt8390-evk"
+CONFIG_IDENT_STRING="mt8390-genio-700-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

-- 
2.52.0

