Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90030C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EFDC80D4B;
	Wed, 26 Aug 2026 13:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id onEG3Lbe-iav; Wed, 26 Aug 2026 13:09:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749794;
	bh=2ysH6nl4i2FGdvS36wDSxWPkrTZC0/cPyPs6TKdO98A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f2fG8EjRT5Y6yzXiDWiqg294ayO+exComEjvJO+47rFfco0yQeNPGiqOfYleV+FmS
	 GlqXQVTk3GfFhuUl3BlAXpVLpUc6bBwzBBFSs6wL1L7d4nJC1eOzb26Y42cWubPf9V
	 ZZ6oaWnklEk+7s57rWA2/JQowIf++2AG53EutsL7b0AvQaej4hK758FHQOK1j8YuGY
	 w0JnD95nxk08bgVnsK+RFFujguUR5ruCwymrVFtqjXG1Gj/AkYnRR0IDFxjbJ55a5j
	 mtw95RQujDIfz1WH1klKXZeW0SPxF+/wPH5LdArYOzT81s5yR1067c6nEJ3UF6xVM9
	 A7g8RweB7S34g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E032880CA3;
	Wed, 26 Aug 2026 13:09:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D7E3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B15F40695
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kgG1L63qVJ4J for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=V7bvny5r
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1921C40697
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:47 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so8448265e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749786; x=1788354586;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ysH6nl4i2FGdvS36wDSxWPkrTZC0/cPyPs6TKdO98A=;
 b=V7bvny5rEH8oYqTXHDH+XZCvKFZqVgg+jJgNO+979JDoYNMdNZp+TAWdrS7/eKHba6
 1xioaGvb53W11YPnjUDbo0CG0ttgmhegff20s0CLg+aVFQTK2Ibnpoovr1asqCmE8kl+
 Vi/QSM8uiSX15YJnaaXPkTHW7z86j7RYQtW4Gv/PZMVAgA7t3uo5GPf3ern3BFHi/aMA
 pfYpxXEIIST8/H86IEimt0pC+GduS8A8o3avdS3SbbxnWalRIoqB1lEDkdeXlcaHner9
 jVVa0CLjjfCuQCT2gSoUJaG6uicTp967V/2eX5XnG0qqbglXndlczpwoQtsStpE6q+y1
 nm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749786; x=1788354586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ysH6nl4i2FGdvS36wDSxWPkrTZC0/cPyPs6TKdO98A=;
 b=P2rdf+hGdJmCWGZFUCiBJ4KnFeEAn/wUTtCCRFJ4Q400zYoaq1V11ZQT2k0twYUs9B
 yDVAAB5FzLDFz6hZi1V4CCwbXlAhQNRmporCy5ZiNgn3k+Ezp6iW83S/nK7mM4Q2ce8R
 oMOpJ9xmcCfe73IrBoMGk7zvhOSif8AQWR1js+8gqAH6OgWDt9AVZR1xgkBrK2Ora2ox
 nByUuIRY823lnsLh9ro9ghkxVeqK2OXFGMVJAP8jcFn2dHMnudRro1uaFgrVLxlYdF2v
 D9wxr/P6fBwXYzItlTvVRHQEyAyg97vvN5qgvl0xqNreTbCxVYrlXN3xs6sg5jOsqMMV
 VCsA==
X-Gm-Message-State: AFuF++mdJO2e63FHSIumZodhOW6SdvVCbjKhnK+dvOEm+wXR7Bn1+08c
 R4Zj/o4sTvYYKzM06bIYzMA+qksbvjcGvKdj7yd26DE+dPyi/9bPgL2evnhpzbMvTCo=
X-Gm-Gg: AR+sD117rLkPGv/OPwr5ofrcOOQjKTHGiUbUhpdBmaD3bqKUv/S7zQtqQVNPJN9HyD5
 pQS/MJQA8t6W4dXv52uIIxgR4qxs2krI/DOdC34Efnsqw5CGXtriJtf5JGuK3s3lmmc+Bn/xT2Y
 m8OvalkO2MAIErf4H6ZRK/sic+VfUcNctBW/9NAz9Gcz/w8dwyLHFeswOhmJaH3QOnIhtoSfBuS
 GYP1fkjHnN9eOtMrbL+gCDANyIGHNeMRyR4mYNeSgqKdpv4a0hViyQJfV9M/ufQjuWzk9QZ/HPT
 v+uaMQG+vq7I816fHCSU01QGjx91DN7vQVnyQMyOTRXW5hTVyoqs2ScqvsnZRmnnlm/RHa2PeWj
 4Y9om+LoUdLDhgY0FxqE7tARbX5ZG2fezw1uZNrHGE/QmDTjyN+VOlVLlm1H/XW8Bc9vDpUk4cw
 hy63gG+TPN4BD/zgH6d0ND64ZcrBc99pOJFw4hG66hCHiDLI+jPw7HwFa+++iM3AkN1gwYvV4Qq
 mbfEQSECZe/nYxREHur2OkJ0aHYU31ATmRpAX4zFIEdZ+14r1mqD6cYUvVLECVYSqMsR4HEn+7A
 bu5FI3ZxRv0u+mD4uF9+i2CcRWRKshhugii6yKdrjBmw3g==
X-Received: by 2002:a05:600c:470a:b0:495:4689:1e98 with SMTP id
 5b1f17b1804b1-499dc72266fmr59184415e9.10.1787749785646; 
 Wed, 26 Aug 2026 06:09:45 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:39 +0200
Subject: [PATCH v2 12/14] arm: dts: mt8390: add framebuffer and splash
 reserved-memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-12-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

These regions are specific to U-Boot and only needed by boards driving
the HDMI splash output, so define them in mt8390-genio-common-u-boot.dtsi
(included by the Genio 510 and 700 EVKs) rather than in the SoC-wide
mt8188-u-boot.dtsi. They are placed at 0x70000000 to stay clear of the
reserved-memory pools declared by the boards using this SoC (the Genio
EVKs reserve the range 0x60000000-0x61100000 for the ADSP and AFE DMA
pools) and of the kernel load window (the Genio kernel FIT images load
and decompress the kernel at 0x64000000).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..dda05bcf7f4 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -5,3 +5,4 @@
  */
 
 #include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 9b7c54854b2..487fc944d35 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -7,6 +7,7 @@
 
 #include <config.h>
 #include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
 
 / {
 	binman: binman {
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..95b2f66973c
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+/ {
+	reserved-memory {
+		/*
+		 * Keep these regions clear of the board reserved-memory
+		 * pools (the boards using this SoC reserve regions up to
+		 * 0x61100000 for the adsp/afe DMA pools) and of the kernel
+		 * load window: the kernel FIT images load and decompress
+		 * the kernel at 0x64000000.
+		 */
+		splashscreen: memory@70000000 {
+			reg = <0 0x70000000 0 0x02000000>;
+			no-map;
+		};
+
+		framebuffer: memory@72000000 {
+			reg = <0 0x72000000 0 0x02000000>;
+			no-map;
+		};
+	};
+};

-- 
2.54.0

