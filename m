Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA4CD4A61A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D915C83015;
	Fri, 16 Jan 2026 10:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kXmLmtCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECC68389A; Fri, 16 Jan 2026 10:32:32 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBED82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so17957355e9.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768555950; x=1769160750;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pfxvYMi4B+pjlNq+gh10qf1jnKI+7rrwI7pPPGF4fWw=;
 b=kXmLmtClFOo9ftFF9wQNnKZLBQLk+MpGvckV70ChC4DOczFdHoj/lNgkA8Ic2fapS3
 Tp5oAlKechgIq9zkxW3iw5egq0XB31b6R+Qlj4TmzAgR1mnWwECyUzzzUec3/lOA44Ko
 I/+TaGqDfW7fKyihhK/eZlfgfNpD2EKv1Oy6w2KSe8Iidwd7Mt/Q+6laLzSeE9ZIRZBC
 f/rFnhpaDSAx8nUL58nRFBl4TcfDB/uzBg+9t8MdYmA5RIOTCWTysNWGfkdZC727Asp0
 1R2gaP7aFLA4CmPlIynkbdqQBDhQkhCGe7HeUeZqMPWYx2ErT/oJ/DNpS1tBB+Lv8xV0
 pPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768555950; x=1769160750;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfxvYMi4B+pjlNq+gh10qf1jnKI+7rrwI7pPPGF4fWw=;
 b=B2I7wogJIuhrEtt1oFn+J1GXyU6+6/efUBkxIb0Nx2W3tlFStRcLuz7uF32xjr00Ll
 Rz70Ey/j/b4KyOu9wjodHpYzew0HWDUxoCYTfHK3F4vqwJbYR0IjJfbeF4+hk2Xr34uk
 nLuWOhzPseTIWkG0cGDwOr/3wrpDRuofBKVCj0tG2NQQfZYfmlDf1h0dkTLzyTWILPQj
 rScO2OXhI7cjs/pDMlP6V4P92FEqK5tNtrDfik622A7oVTK2BGFV40KKLMlvoSxENVgk
 ohtqPpYj847ITaFiv3Jq/QgWTr6OLWpjngeXmY4ZwXoIjn4jJN5ubQNWaKzEkSIBkDRR
 Uhew==
X-Gm-Message-State: AOJu0Yz4gjPbYFPtQRfavdq9ijG3fy6Drxzw+Txgz1taaB/ow0CN92CQ
 tY2uf3/wt+4VhPhMMjI1Y1OtE3zyZpg+9mBi1ecNMP4IzWCYOqdNjbOoreXn4/taBNE=
X-Gm-Gg: AY/fxX43/p4m6EYUvjnKjOLQFfWtASvn6coDdBeL7mSqYRaBlJ2pLLJjmdVxIQNSXCv
 ShNHMJdZkpwGmgX6Vn4Qp2wrOoCcobybDN5UNNxVaUacJeRRH5DUQKBOBWmtwemNS4TRxgJ11l6
 PwiXOcHodFwA2STthRfuGXXuWHwubVbA2iIPmc3gcv9aBnBrks5vLeQUz47LlL+YCVV5Q33CE8S
 hSbYKD8rE+383WINlDJ4gUrbVnp3V3wuxD8YrPPl//3FMR5I/+5nOnpq4HSyAwwRSB24kmkojnX
 Z/7iZTrBPfFexXMDWkjE+bn+ow05Z4nDW8JjiLo75y7kDWI05O9ZfAOQmWh/d2c6G4H5wopu07F
 oK1RH9wFIF1yVAkrSMucsYDUmwQRVv/Xa9YeNny0z4vESYNztYLnGxa5dJ1UcYT2s+katlyjN8u
 WnD9JzMWWSadoYmzlhcWee
X-Received: by 2002:a05:600c:3483:b0:47e:e2ec:9960 with SMTP id
 5b1f17b1804b1-4801e350307mr26837965e9.35.1768555949641; 
 Fri, 16 Jan 2026 01:32:29 -0800 (PST)
Received: from [192.168.1.35] ([2a01:cb1c:39a:2200:bfac:427f:8a06:fcce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435696fbea8sm4179086f8f.0.2026.01.16.01.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 01:32:29 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] Add pinctrl driver for mt8188
Date: Fri, 16 Jan 2026 10:32:26 +0100
Message-Id: <20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NSw6CMBQAr0K6tkk/QFuuYli0rw9tIh/bQkwId
 xdFo8uZxcxKEsaAiTTFSiIuIYVx2IGfCgJXO1yQBr8zEUxUXDBJrfe0z5prTacwQI43muZpGmO
 mVam8kcoYVXZkD0wRu/B4x8/twRHv8/7Ih/wtmuIz4P+Db9hJLj0o0bESm4W/2s4mpDD2fchNA
 RXWXlin0Nlag+tczRh44JIDA6kqQC8QDGm37QlGlvYU8gAAAA==
X-Change-ID: 20251203-add-mt8188-pinctrl-support-547d9379974f
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, "Jill.Wu" <shu-yun.wu@mediatek.com>, 
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

The driver is based on the kernel driver for mt8188.

While at it, also add pinmux_property_set ops for mediatek pinctrl framework.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Chris-QJ Chen (1):
      pinctrl: mediatek: Add pinctrl driver for MT8188 SoC

Vitor Sato Eschholz (1):
      pinctrl: mediatek: add pinmux_property_set ops support

 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 1344 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   12 +
 4 files changed, 1361 insertions(+)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251203-add-mt8188-pinctrl-support-547d9379974f
prerequisite-change-id: 20251201-add-mt8188-support-b313dc72f04e:v1
prerequisite-patch-id: 634923bde5228f44b507cce64f9583f1f564b865
prerequisite-patch-id: 223495938bb176ffa7bdd6f68377dfa7839ef00b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

