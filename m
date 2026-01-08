Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43703D1D462
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AB684214;
	Thu,  8 Jan 2026 15:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MX6OZfZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DB68425A; Thu,  8 Jan 2026 15:47:19 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E708284214
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so2405306f8f.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883635; x=1768488435;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6eCScPkO1PKz4+jJ/xF/8hnnB6qZeQWL8rLHyykG+RA=;
 b=MX6OZfZRH+lKY8iaXAceD6xB3/kTEx3ZeNoBaVgYtiEw+rVhCpXq1KhX4Ol2bTK/So
 OBV9sNSfXwXs+Y1hK7TJp4qMVU2MfTQEUOfF+KOT0gAtu2g55xto4DpR8pcPt3siEz44
 FCJjbkYUBn8gN1SsM0vIbmAbF4O/3fjTHscVFCEFz3yvt7JzF1WVy70KLASM5L0eUa76
 T3RWfvwj2je9/84ptueKS5rZ5y7/O6w9p3GomettEbao3Aj4BRBYB2xfH7K5Hpj1tA4/
 FatTFFv3V0C6mNMsuAc1JRHf6JYbLGx4lO5yTByrOcqKSNogCAKlQdP8yrdkFhsLv9Lu
 ndnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883635; x=1768488435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6eCScPkO1PKz4+jJ/xF/8hnnB6qZeQWL8rLHyykG+RA=;
 b=E5n2VNYABIi/tCm3ebexBtxWrj8Nrsl6UdqOn1z0mMMCzCD4y0cmtOxouyjd4Rf7Qv
 gEXBhbBMloluBVoHiV5emAQ1AYj5zQkDnDuTA7RaKNPlTIZxBOa5r57gM/Uba8sQl9wU
 dTD5/YGSCmHYMEOLLo4pXbAYfJnVwaQF9SMOdUTWIj7AIbLT717xeWEnmfHDkNenbFDn
 VE6p0CN/juy3mNM7/E8TwO/X4eOIx99kSpvkM69X8t2Ct+S4ehoCMAjw1mANJsve3YDh
 ImfEliuANbwPlqalOUKFet3gu1ZDZ1NyhZUL+L+CJvV/mKVgAdagkD+Q2JTkvMhVDux8
 DSqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDG5+CWD2qPQq345er5Xm1VftS7F0ntLMP9OViwFM3egv2ltVNNkVeuF7TT8jG5iCy+wLTJbw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1lNTpwBLKkt5S2RlP3Zy+y2ql9ZNoU03EKu0Yw/Pt5CESt2dF
 95q/XM3GnEBhmQj7S/BtMbqz7Hj6C9GT5iGwJzZMZZOcXDdefqQKEHVl7Yo+culSgKw=
X-Gm-Gg: AY/fxX7EZqHbz1FAdAkb6uWAOy3XJI3ottuDoY958aPM8zg+C9pvw7H930Q3/wdqC1l
 nBDJ9HpKCeeLBhZt1PXxYRKLutsbCL0SkOjurLUv8pTKV/0YgDzMKyphkawWmS8qVKJFUd1Lxx+
 3irHmDlE0lmzwAduNuJzB/zUuL+Nco+ma2J1XxqxBNWdaXaQbeCxDpyvMZnu9zp6HTeKfa4iexo
 QG/nMX8nV3QeGMOw8lgpYZ51/OO9uYoa4xu7pDuoOdp8qE+LLAfsurFyIGzFCNC4GAlqSDcjR8T
 /VSfm54AxF5gHvwgHe+cXjyIEGuPXHNxL6qX+5F4lDgp85nNd5FznNW0z91wVQdIeqKaSroWQxN
 MCe+UdEphuu6iKIz59J6dCQEM7DnhDb92Tjux9+BCEPmX+ViqP+jiVRTVjWpJcojmHsAr3zgvLe
 SUSMCnrjgKLBVB31FthQwqLl3Nml87q5i3xLFI7vdkXqvq24b1bZnlcmoxrSSnm8zjvHmHUUoag
 M4cyzZ2
X-Google-Smtp-Source: AGHT+IE0HLAJiKLNp8wRwEuU6KFVSCqjmtarHHx2k93d/XziDTe+6TgI8RjmNfU2ngci9CWCtTIDxA==
X-Received: by 2002:a05:6000:2207:b0:429:ca7f:8d70 with SMTP id
 ffacd0b85a97d-432c3760d62mr8986253f8f.15.1767883635270; 
 Thu, 08 Jan 2026 06:47:15 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5eesm16872463f8f.34.2026.01.08.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:47:14 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 08 Jan 2026 15:47:16 +0100
Subject: [PATCH v2 2/2] pinctrl: mediatek: fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-2-3d0499d3b6db@baylibre.com>
References: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
In-Reply-To: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
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
index d10d08d9fe80441a5a2f8acc13e312825fa43a5d..800c14508616524c6ce3cae15c8a23222952d199 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -18,18 +18,22 @@ config PINCTRL_MT7629
 config PINCTRL_MT7981
 	bool "MT7981 SoC pinctrl driver"
 	depends on PINCTRL_GENERIC
+	select PINCONF
 
 config PINCTRL_MT7986
 	bool "MT7986 SoC pinctrl driver"
 	depends on PINCTRL_GENERIC
+	select PINCONF
 
 config PINCTRL_MT7987
 	bool "MT7987 SoC pinctrl driver"
 	depends on PINCTRL_GENERIC
+	select PINCONF
 
 config PINCTRL_MT7988
 	bool "MT7988 SoC pinctrl driver"
 	depends on PINCTRL_GENERIC
+	select PINCONF
 
 config PINCTRL_MT8512
 	bool "MT8512 SoC pinctrl driver"

-- 
2.50.1

