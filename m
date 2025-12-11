Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80A7D41C12
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 09:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4558283655;
	Thu, 11 Dec 2025 10:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zAeFa+Sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296E68389A; Thu, 11 Dec 2025 10:16:48 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF42835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so6546095e9.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765444605; x=1766049405;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/C4ATUhovvN63l26G5sL9iXoVAzcMgqhuTs8fcKbZ/0=;
 b=zAeFa+SxTRmFyB2SxIyVdtubEMrFumNzbkM7Nn447ygCA4AWNygpqFLT4vp/SijOmA
 VdnxW8A37m0LciaK9V48ULRv3YoZVuKvvvGjpcKgbcsubFvWknHX135CW8yj7z/RpnL7
 MADiGCHtshTMulYmLzTqNrehwNdZBcl/r0qEZjghidOODIPUnhEeCEr3vJpADabi6Tn7
 5EGUaB/PZLg2Tj4gUxEO8DxqwitxZruA6YhcG9jxL0qG6G+IHpH7CQLeKmg496t36rIq
 7pBgEyWlOk69HeMo9HVjQsNQOR4HpC05kvNR4BGCRHVtpayv8FfjWPJK+0RoM4+osOFh
 J6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765444605; x=1766049405;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C4ATUhovvN63l26G5sL9iXoVAzcMgqhuTs8fcKbZ/0=;
 b=h115vej/oYaAoiTamh8lu5nZMvI+XmXKj4v8G0+a+m3+9LM0fLJhTPRrBTDLYwlxaa
 03JRQIfzmSVqJd+B6Nml3u/jy+vPCLCPL5xX39Kf7HKf+DJGruWcVnuvzndIjKV1jj02
 pM8gLQKCZPD8ioABWHyW3MA2pNBTL9tu3H69Vvk8sV0gb6A22U9BlzRN6CZ5l0Caiw0+
 7jtplyQFfsT1jnBPpCm+Shn9nw4UHdGyzX5kXRLe+xhdGkaFlZlbWe3vANaED3ri+3Ug
 zRu9KfjRXOXzqq+hdB5tJKqRcBqgvbMZCNi5pmYhb5LB5AMdaXJ1D2g1GATs8kAg0CMM
 FGsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqn9tQBcY4PvKTOa0ZHy999PiqF2g9j+mCcn9WhTVrh+iVUuKIwHMKlgHuxlWgSrMOvMQXuyI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0mFmli+A6QA0QUtE60cBC+PC4cBLJUUjCMo9/ObI3sYyC+MW4
 4obeZ8e1/nZGmX4SnBjZhUVE6agtO6XFn7Q8AvXaRQm08SHe8Og9zGa9VvPlUer6EVE=
X-Gm-Gg: AY/fxX6xhBCSAK7NXS/AMFTeKhrrtlKQ9RupkXKgt4r63j++x2E7J9zyI/DQg0QNVyy
 vjx+3s51tZl96R5fOMPhIel1uQY7s7eaN8q5dAuVv0vV2N/zpbRBo4Xs7Q3o6pGBuAI8wzZhdiU
 9d/lFuAIyop9NHRXj+LbfyKDzFmieIn12LFz0f4MfWFTzhnbhq9wf21H43JSzv+bkRcLXuue1Ew
 2NPfupRfD55+QCLBS95jQL55OMW69vw8wp/jz+h4gPHw5jHXAWqehS7GfAlcTDfvleftqKLJR/4
 hnJvMAQSfdJBL0xg0UIhvBna6p9jJAvi+On36Z36NVxlZlnGuxKmMaVDGy+1sOdf6TSln1+ZBQP
 W8Oa95rWeaEWxJfez1pVCZpgdKWSCXINl6b4U9+hV2n6wJRj9J6yShuDB/l5nIZb27ISKKXRX6x
 t6HKcY6mDC976A/QMdedy10fZ6PC3SJBfTR521q/9DWw==
X-Google-Smtp-Source: AGHT+IEA37yXXE5L3DIkGl5lzdOqaS4q+MjDn+1Qk21YFIyBVis2iPbkyiJA/5VjY4l9mfR3dNOuNw==
X-Received: by 2002:a05:600c:3b27:b0:477:7bca:8b3c with SMTP id
 5b1f17b1804b1-47a837ac2dbmr51257925e9.19.1765444605304; 
 Thu, 11 Dec 2025 01:16:45 -0800 (PST)
Received: from [192.168.1.35] ([2a01:cb1c:a3c:b200:c143:28dc:79fe:fb5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f03b73sm8997795e9.4.2025.12.11.01.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 01:16:45 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 11 Dec 2025 10:16:42 +0100
Subject: [PATCH] pinctrl: mediatek: fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251211-pinctrl-mediatek-fix-compilation-issue-v1-1-c7a52a48e5d1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPmLOmkC/x2NQQqDMBBFryKz7sAkahdeRboIcaxDNYZMWgTx7
 g5dPvjvvxOUi7DC0JxQ+CcqezJwjwbiEtKbUSZj8OR75x1hlhRrWXHjSULlD85yYNy3LGuoJqO
 ofhl919FMT+K2DWBnubAN/6HxdV03cd8no3gAAAA=
X-Change-ID: 20251210-pinctrl-mediatek-fix-compilation-issue-2440f060e33a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

When compiling the pinctrl driver for mt7981/mt7986/mt7987/mt7988
we have the following errors:

  error: ‘const struct mtk_io_type_desc’ has no member named ‘bias_set’
  error: ‘const struct mtk_io_type_desc’ has no member named ‘drive_set’
  error: ‘const struct mtk_io_type_desc’ has no member named ‘input_enable’

Fix this by selecting PINCONF in the appropriate config.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 8b9180bd2aaeb56325ba42d08afa42d9317f23a1..026ddbddb2cf1f489e4e22a6ef2b407fb96daf11 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -18,18 +18,22 @@ config PINCTRL_MT7629
 
 config PINCTRL_MT7981
 	bool "MT7981 SoC pinctrl driver"
+	select PINCONF
 	select PINCTRL_MTK
 
 config PINCTRL_MT7986
 	bool "MT7986 SoC pinctrl driver"
+	select PINCONF
 	select PINCTRL_MTK
 
 config PINCTRL_MT7987
 	bool "MT7987 SoC pinctrl driver"
+	select PINCONF
 	select PINCTRL_MTK
 
 config PINCTRL_MT7988
 	bool "MT7988 SoC pinctrl driver"
+	select PINCONF
 	select PINCTRL_MTK
 
 config PINCTRL_MT8512

---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251210-pinctrl-mediatek-fix-compilation-issue-2440f060e33a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

