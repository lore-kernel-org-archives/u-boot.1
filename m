Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A350810775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB91B83642;
	Wed, 18 Mar 2026 17:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QgM25iPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84162838FA; Wed, 18 Mar 2026 17:45:23 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B11E83015
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso6991647f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852320; x=1774457120;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CXAgvEb36u4IktaY7hHmK0sh5k4CwvRYY4L2rxeHfps=;
 b=QgM25iPdPwJdmHwiD6LcmNTOcpg2sngGsMiZquYOFuVE6Iu64dwCRGeaD5KeYzLQma
 NuAKQXYS9BDGo0I2DL9SUlqabipjH7XyTKRrGcZIm0t5BM0xIa1nwBDD8DLvkckvHJH3
 3agmZrtLfzFXx6ktXymHbg+njXfc9gDDy4C93Oj7ZQhgcF62WveuL53ffv/o/Tq7um1E
 ZDfEWrDm4tQO6vF42VDduNiTkn3FlTbJZYmBzojyESwnX9707swLeHWMrb9AY2M2jKJQ
 pmyexY2Ca6U2yq+TlYodnn1pLgsmA2f0b844/l/mIm6PC5TQRhAH3jrsHrgb6yaLTeNH
 V2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852320; x=1774457120;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXAgvEb36u4IktaY7hHmK0sh5k4CwvRYY4L2rxeHfps=;
 b=kSsFz5qi0zVp73VeMNLUt3TOG0F79YpqprS7BUVuEAW48gNbJRQrUgPCDyAKDkRfZD
 t7T44xpEUsDwrOt6KzFkfCGv3RivYZ92QBzql44fAfzwccDYpGx8QCQVV/RlezWEwouY
 mZ/0qQMApPQydls6hwITgK/S+IcRIEvoa9b2QEFKtXhlp1ia+wiYGA8kOlvuxQL0y0OZ
 411ijG/+WPgGlJlWZzRtLN1FLXV11Q00UEpg29Xxlu9zM3mKpbo60QyEQeCKcKVGsh7y
 7T6/8jYI40/jp5Eb5cyGYtQGjI+1D5M6zjGMkzA6Dt6vB/mJVwpgpcC2dayIu35TRVmX
 yCKQ==
X-Gm-Message-State: AOJu0YxBL8RcFddaRkmOnLJI2oKWkhQdYLtOgpaoC0Fz90TvHbltq897
 tklp3JfmIPCI7rhT64z57wMvpqd7DT9llm1XP2ylSAsXbrosOS/j6IwBWVBxXE51nhM=
X-Gm-Gg: ATEYQzxRoIvCY06Hi19aHQ48voIkot2rlTBTPX1PqjERffl1bg/5VeZOQBZvO2FThpx
 j22/VYr9AnsvlGeHaBywYiht2B+JzRKqfAO2yb8B1TCzY9/iNLd1cZYNuSLPJ7pdjto3gcJ9ox5
 kQxl2KPvaD0UIqh+KINZrVNMXzMbs9RKOf1x50osH1JzxwXjusmzDwyNTfrOdRs9sdn4rWguD+2
 OeKqmEnYB1U1J99MIzuE7IL9MhY8trQ0hAeg+aubimqgqgXGb/63VCGLJeYtAhGWTASIfPvaGuM
 266xxuJlzFY1U5hIIvLIcn18jE5lJy9F3dz+mKo2visNshACRh7CbjtcIHJSNVzZns0olafN6QB
 C054JR+Lhs4WXvTsN34Y5PKNP0CtTo4h5crz8kK7ST5gh9mU3nyWQ5ScER7Wi3+/IKp4EOcyakG
 GMc/tYOjXVWCO+2Os6Vz81f3PErxIhFwohXPuDCIWCmyRcdFoWpdq6Vkn3+Upa6Pk+o1MctXe0H
 A31ie5WU6PeXThH9lPTzWtk6tkSXwNEkQdUXG/9Qp25paRU0Qh00K5O2CVGYRsC+Cf7bIVjin4r
 itPaok0ndKDjEYEXPg==
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b527cc553mr7205715f8f.45.1773852320504; 
 Wed, 18 Mar 2026 09:45:20 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/6] configs: mediatek: rename genio boards defconfigs
 to match the device tree name
Date: Wed, 18 Mar 2026 17:45:22 +0100
Message-Id: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ7CIBCFr9LMWgwgUevKe5gugA50EgtmMMSm6
 d3FXsC81ffyflYoyIQFbt0KjJUK5dRAHzrwk00RBY2NQUt9lid1FYzJzigiJspixOBzChSLcN7
 Ii/S9xB6htV+MgT778mNoPFF5Z172o6p+7v/NqkSTMS2kjdFB3p1dnuQYjz7PMGzb9gX7ZKa1w
 QAAAA==
X-Change-ID: 20260318-rename-genio-defconfigs-bc4070c90e9e
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

Rename the defconfig file for various genio board to match the name of
the device tree. While at it, do some cleanup:
- introduce mt8188.config to factor genio-510/genio-700
- remove useless SYS_BOARD_CONFIG for genio-700
- set myself as maintainer

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Split the initial commit into several commits as requested by Mattijs
- Link to v1: https://lore.kernel.org/r/20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com

---
Julien Stephan (6):
      configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
      configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
      configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
      configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
      configs: mt8370/mt8390: introduce mt8188.config to avoid duplication
      configs: mt8370/mt8390/mt8395 add myself as maintainer

 board/mediatek/MAINTAINERS                         | 18 +++++++-------
 configs/{mt8390_evk_defconfig => mt8188.config}    |  3 ---
 configs/mt8370_evk_defconfig                       | 28 ----------------------
 configs/mt8370_genio_510_evk_defconfig             |  5 ++++
 configs/mt8390_genio_700_evk_defconfig             |  4 ++++
 ...k_defconfig => mt8395_genio_1200_evk_defconfig} |  2 +-
 6 files changed, 18 insertions(+), 42 deletions(-)
---
base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

