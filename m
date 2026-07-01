Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0EBC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 15:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1793684BC9;
	Wed,  1 Jul 2026 17:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Yk53AYhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FC084BF9; Wed,  1 Jul 2026 17:05:09 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DC484B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-472055b0efaso506405f8f.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782918306; x=1783523106; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XSwfSJxnK9vyepECZ44MIUBpAplLbb9Bebm7U02+Mcs=;
 b=Yk53AYhhqOIp+HcxzBYbEL3GUYFwVxzzyD7+Rz4bXhdAsR6MixricfSJw76uFO4Rnn
 X3Qu3q/H4GA4OslfyOFe1ItczG60JRyRJ0UPqnedVyjfVuMwhMcVbKYWohMLQcGcL0pr
 oVYRkMsaI11pA5Mlu/83la7a+XYNKC6UGdcJbfl9bOyAlMIE7HMKKbuXVuElKEC2lDxR
 0xHkVqgJCXQnu8sR2xSzMB/8VOgM5T+ioaQBHM4HTIunmFKJow+vQWc2ocKif90g+giI
 W0H1I5ZXJnK2I7/St9nOBeJopxOLS0cqFWIS5RdzZHBNyCxeLJBrPLGZ/0a0AHT4KDDU
 uuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782918306; x=1783523106;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSwfSJxnK9vyepECZ44MIUBpAplLbb9Bebm7U02+Mcs=;
 b=EUztTMoTvDBPYQi4tNiCSRLBf2XRWDllarDuqnoO7QsrftKAZn+aiCmpIgdZzh03Wv
 jFmnzEbngREOzp7HS6Z2RymsvkHwIvjAE8q4kUFvvrxKIDxQOoixP3LVwTju13F202gM
 XHAHeRrqS4DVWMELNiDGPzvXHKFlqaZzKEe9T1D/1i91s4ybOGHby5DvjRA6vI+0Lzlr
 vyYFv4p8PwKeok3NbQv+hJ53i+Kv2Fg3iNJx48Dmz9WsVj66ZOEKDH0tv07UBfAYrf5Y
 1qLtqa8US6UddtYgBoGgRFSYepQBzbDe201LXw9Jo6+x/2yaReVaiOfv+JIfQmu+GDoX
 NEZg==
X-Gm-Message-State: AOJu0YzUVohLAJuU5FxdEQwQI1wPH23OtvITld2RhKF+nGCikAewKFgH
 2x26B4mBk++zCd5XyDGepHWWL96vwx95AV0tZe8ogFAzkkD8Jnlb/0wus1UtLAeW9Ip/mtaG/vs
 fLZ0KeYs=
X-Gm-Gg: AfdE7cl0acta8Mx3yacGeo0BQvlS+jXRohTKiLUzlXK4FR7WdB2lHoI9cC4uYj9BeVV
 KY++Qd0cXrhAzgbRFo30zlHLkNb18EKe/2wOgzga5pp+bKz52S0Y+rKGGDKyRT0znIwrhVbI4Vk
 gIdSWJBwtX4PxP//dFE+XsQwxCvjWarAa7m/lq4MOw4hxXYyUCY+rCeQ3tiHe7dE78ohUttMdqm
 +CbXVbZ1jfGRYOWKQ61P+ofgeV7oy3I6m1VzaLkLDdhde3tQ/DHD8aIr4wSrW1Uq+8gwgtu+5Yc
 2yPBFsqcjn6y+ti57aleI+fobqC4W1AaOFP+MnIy6UC7Jd50gd1nGm7H2JBgF+hbF+qBbZ65RyV
 YAz+rf36fENT38nXToHzUxYe+joLeD8f4Jx7DaPm9L4fSqFKEdAjB1IiT31V1ZC2u53axC608ny
 l63Or8tjn+sxa9CA2O8txFSwCzypGpJAJHaDApnCydAbFZRfexVqJsKNRkw3xwqRh6ObjKFyMs1
 Xv7nKm1zNKZDtfRFtxwsewLt/lKzewP0kmco1y/xuYYCOVKB63hvSfUAYLYfh2k0FpWMvE=
X-Received: by 2002:a5d:5d89:0:b0:46f:7d90:8114 with SMTP id
 ffacd0b85a97d-47757896cedmr3744372f8f.14.1782918306122; 
 Wed, 01 Jul 2026 08:05:06 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0fb15sm349531f8f.29.2026.07.01.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:05:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 Jul 2026 17:05:12 +0200
Subject: [PATCH] arm: dts: mediatek: add U-Boot dtsi overrides for Genio
 510 and Genio 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-fix-genio-510-genio-700-dts-override-v1-1-cb571f8c9296@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NSw6DMAwFr4K8riUnCBC9StUFJa/UXSRVDKgS4
 u6kn92bxZvZyJAVRudqo4xVTVMs4E4VjY8hTmANhcmLb6UTx3d984SoiRsn/9WJcJiN04qcNYB
 92/eDwDU1AhXVK6P8vpnL9ce23J4Y54+b9v0AboyKsYgAAAA=
X-Change-ID: 20260701-fix-genio-510-genio-700-dts-override-2699a0e153ed
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

U-Boot applies DTS overrides by searching for files in the following
priority order [1]:

  <orig_filename>-u-boot.dtsi
  <CONFIG_SYS_SOC>-u-boot.dtsi
  <CONFIG_SYS_CPU>-u-boot.dtsi
  <CONFIG_SYS_VENDOR>-u-boot.dtsi
  u-boot.dtsi

For Genio 510 and Genio 700, the common mt8188-u-boot.dtsi override is
never applied because none of the lookup paths resolve to it
(CONFIG_SYS_SOC="mediatek", CONFIG_SYS_CPU="armv8",
CONFIG_SYS_VENDOR="mediatek").

Add board-specific overrides for mt8370-genio-510-evk and
mt8390-genio-700-evk that include mt8188-u-boot.dtsi.

While at it, also add mt8188-u-boot.dtsi into
board/mediatek/MAINTAINERS.

[1]: https://docs.u-boot.org/en/stable/develop/devicetree/control.html#adding-tweaks-for-u-boot

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi | 7 +++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 7 +++++++
 board/mediatek/MAINTAINERS                    | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
new file mode 100644
index 00000000000..586d15bf72e
--- /dev/null
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
new file mode 100644
index 00000000000..586d15bf72e
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 37ca35b4dd4..d99c6d708b2 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -21,6 +21,9 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig

---
base-commit: 23a4f1e22076855df9c8dd93992edd9bd42d7ea2
change-id: 20260701-fix-genio-510-genio-700-dts-override-2699a0e153ed

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

