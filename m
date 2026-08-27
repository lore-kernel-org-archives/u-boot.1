Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89E7C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C8B080D6A;
	Thu, 27 Aug 2026 07:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4LKWw_27slM; Thu, 27 Aug 2026 07:35:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816130;
	bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdzVPBswE+FiA2agpSNVz9NPvg9tZPpqYF8/9sN0lmOUvCtBtOsl59Zv0uje5nGus
	 mRM8od7jmAdq2CgY6TbAPuRTzOHYy2NlkzaZ55ejHgbOC1Fd8k1iE0YkSycATUvuYt
	 dLEMX8LwlRtFqppgvHuoHwKIuIfQ0EXJVqwVRV64DGyH6o3qUk9bAzsFljTMx9FhAu
	 JQ8z4PJMlH6DU0oH9FWFHDZC/+mRyTQLSV+5S4oR3SoJx8dMhue6WJhIXs7uId7f+C
	 FD1WgMqC3bYZbuQ9nROl/r+CH/05FpmrggM3cR5uB7SmW/GUVaZnIIF179w/GFGcU6
	 1HpZ1k456gHDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF32080D4B;
	Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8E583A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9025406B3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UimD8zs0RxF1 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NtQugzO9
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93B1D406B2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:24 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so1757676f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816122; x=1788420922;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=NtQugzO9uUpdSPXeZDUQO84fOfReCouu55ZZdwUgEBGKhdf2td/AFVbTVaMJZtZ6C4
 othV8uxRjRrPFjCwO32Gf8hN2+OEvtgV/l0ZTE3W9kTP/hCm8YV4lRjhUC4B10R2zlq9
 ZG50CgJmI7tN6se5W4QVKRrtQ54Fyd8FE73KUC4qjPx5T/kteL4534mlq6mL+JaMfmKU
 rwize9hUrK37MwcHHv1UnETeozHSir3w6XNyuYtH9NMhFqC4fDDBbDsRQB9RSwu9CScu
 RN/gkVzlzRJxRTRiLEWSGWpHwk7vSrMQQelKeCsmmWEwhZlftlaRxlivw74LsI/eM/D0
 QhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816122; x=1788420922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=jL+7/7wUval1+an9sufgsXBEdlZQouXQeGhYTFkcaao+HgGW8ySd9m2Loe02q4mLf5
 rvvBQDnta3WJwTED9+TaNr3x1ojJqVP0/gpBLIxOyJCWOjCH3M6Qfy7NMmsr7f+p9drI
 4sW3FkD+e/fD+h6L2GzGThpPuMwQze5Jh3RXYKM+hwcgAxc7DVXLPK8as3UQZyjQYxLl
 l8Aa+xv/vHJCoRfaUqrKROOL4ycEJIbXEfZn0Rw2KiDH4PW4+QAvbxKV8w5OZv8Kd2cG
 bW5Pj1eafv6ARUjDrdVvIxSJTNlxsqM0OosSLo2biSSZBAbCeHBkn/ahjb2/n0dpS3wA
 vfTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+8mjYhfE6gxE+MuLOhsEnFa/wzt+lemF7mMi7rSb703H4KNSIwqwVDXCd4E7G2rWhQFx4LgA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mA5Fp70CPMu3ojyGN0wZhB0ZXMNK3cvyjS2l0PvB2Nbm2s13fZ
 0jJsMPWG8rAL4pa8rVBKrNMWIZJDFIZ0UxIftlhQd3073VTis45PKA0BGFPKDZ4cCc0=
X-Gm-Gg: AR+sD11FQWqIYrH4822Dy2CHk91q0YjNblvLNGPgLzEvJNZqCK56mbLCJ71DhLNTPWg
 9kP51yafn/iUXsv2iEXU668bj2ckHPxdl0Uyz4ng7JPu3IjTwkHwKUP33JQ5tjdjj/4n+3mFynj
 2XLdIBJ6+taWKTuCr9RwNDM9f40MTdDNDFhy8Xc3+eMPChai+8ys5sxSNv1rGF4DsGzzadYLVYh
 RyMtG4+IeiiWGuDON7raOjb5AalL7Eemubkfx6K5AEVANF1EydZ6M1gHajJidNZMN3HtWJcH0kG
 AFREfyfDLJ+JegWsIuDopam9W6ZIqwOtVi1RFcnyMlK+/+Jq0gdr+Webg5eUEA2ssroP/r196yw
 p4rhr3fnreFk1VijNL1HJc83tZaR+YMFMpYTHBWB/2weSKeGW4QMZnpXZUOHy0g+Llet33nhc8f
 /OhX69nzMPdqv9tpq9lCB2xwn2w0pmSAHMPnLw1MWYkia3ywbLo6HTthkCKvc6N7218CxZnjB47
 mlqGXuAU7cNfwrFptbXogAq3HvwWNZ7jtF9WKBQHXp6HFYI0xszV3gBNPpU/f+CJw+hcrG52Bi4
 Ihpnu1THJw==
X-Received: by 2002:a05:6000:4918:b0:482:f423:cf9d with SMTP id
 ffacd0b85a97d-482f423d051mr1772550f8f.20.1787816122192; 
 Thu, 27 Aug 2026 00:35:22 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:21 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:34:58 +0200
Subject: [PATCH v5 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-1-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
external DDR loader has initialized DRAM. SPL then needs the debug UART
and eMMC controller, together with their clock, syscon, pinctrl and
watchdog providers, to load the firmware FIT.

Both boards share this MT8188-family dependency chain, so keep the
pre-RAM annotations in a common include used by their board-specific
U-Boot devicetrees.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 94 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  1 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..87ebc64e6f6
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	bootph-pre-ram;
+};
+
+&topckgen {
+	bootph-pre-ram;
+};
+
+&infracfg_ao {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&apmixedsys {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+/ {
+	memory@40000000 {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..d0d25b096e5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -22,6 +22,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config

-- 
2.55.0

