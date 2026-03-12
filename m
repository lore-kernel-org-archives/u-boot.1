Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FE106ACC9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F1B842DB;
	Thu, 12 Mar 2026 17:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GA9QSwkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40586842E0; Thu, 12 Mar 2026 17:19:27 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D83F842CC
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 17:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so1055188f8f.3
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773332364; x=1773937164;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGXGbsKPYISg3Yo0JXsmxV5IgU1Y06bDIm0gXi8F2b0=;
 b=GA9QSwkQsf/2vxaqNP0LqXVK+OWd5FZWlD1DNnSRHQhedTg5eNRiMJg8SQsnWPW3t+
 ITb+PEnjJGfcJ2V6qw6DSUogtsYZLs+MUGwOKDn+woFgFQMGXviG59Qb7PmANRqxBKjN
 isvrkd4bWdZ1u7nT7xmvGK3Mq5EyO8mbyHZuQInXWGq0wgKtWEOyhhtPJpvct2QN1+pu
 GO2ZaYa75QNxrBn5OsLWNvv+IvUprSi2fASaJbN3yhAyGYJkxNgooLUR7YAUBruVowYG
 UEw8gLoemrojzPXqC1Ao1hZTCy9muFcOOPwRWl77txztUiUbW1tKZobQlcKpxtlfg4Pe
 Lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773332364; x=1773937164;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGXGbsKPYISg3Yo0JXsmxV5IgU1Y06bDIm0gXi8F2b0=;
 b=qQtt6HieJPT1401O9Yc8Odah+jJZRlVobZw22apakpz3a6TrK6ruNoZnU5HYUhqBVz
 djnWxiMhmnYY6h6bZUZPdBh/Q5wkNh2p1f/oCmd10rXOTkMhprTRpyXa/iE7f4n6C/ok
 Avvmxt+9i6Q/6l911sBmHIGnGev7CIzKyNOhELKT+EZ6uOpv13hsogGqJey9GpuW/uB/
 HGMXeeqBc17+BbFDd0UGOCyV71GWiwD4jK3kGM96i0O6BDDFW/H+AsIhnuBJRghJ/35V
 VF4X71J6aBwW/apRXeydM/r0D/cDPiIsG5WmXHyWjCSkPyAw1btPEtE7RNorwFBJdHKW
 +M9Q==
X-Gm-Message-State: AOJu0YwbH60efFuxn3LXuBHJNo4C14WOuYecty1FDj07lSfroCHOQ0Tb
 V700Uu4Mx8H3JUBowclon/1L5V+oOP8dc92D4T9elSdaCcyDBIhMVGy2uRf1YEgSyMg=
X-Gm-Gg: ATEYQzzO6BYo9tnJoaYhpJ4QtBbLIKb10e+uXqxkrXSWLF/r+DFYrFKiyFBUDGdkPi+
 0Hgba3ckUlNr9KyDeKbWe+SG0bSyaqVdXqqDFc+OGOwFpf1PIa6cTNY43bVFF6t/qQNwsAVC8zF
 OTfrEsw9cPRHByaOl4+BdF2IO3jWcVVbTw2Esq0bAZQTAy439uQJNe9Tz79qt+QdUgOqk+CWxG8
 K43FH6IkUOpNyeCLkW66XEEWTF2tMQPOP54MmO61xEp6qj7xsmwf3bN3H5QVHyqIyMJj97l30QF
 1wGljtTnckt1bqGJLW4R7yH9K0mFvuYmcDpe7nyKu1JfOcZEm6J36yOh2Wmu7Fr+xpdIQHPB/eO
 JZGbHFl1az0xGHCvTwk+dVnegAN4iU13a2217KBoXraDuBOLTAkw0e1fHse8n189a9P2HqwoqUs
 hLSyM278rdLEjmcSaZwzfYZcpfdD4NGYfeMmAXgShhK2t+78KRLkHADOCCrTj3XxVjCgkdIS13O
 /mEHhbpYXqs6nS1s/2CSlEx5z2+AslydAXZ6joOKcOJbXm9xCOHr9oeDXEpdgs1vvPgDMDxmdeG
 h9qx+NE=
X-Received: by 2002:a05:600c:37c6:b0:485:3fc6:c0f3 with SMTP id
 5b1f17b1804b1-4854ad723c2mr118976225e9.0.1773332364555; 
 Thu, 12 Mar 2026 09:19:24 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b4dasm9569953f8f.18.2026.03.12.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:19:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 12 Mar 2026 17:19:26 +0100
Subject: [PATCH] pinctrl: mediatek: Add missing bind callback for several SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-pinctrl-mtk-bind-gpio-v1-1-21b8968902ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqAIBBA0V+JWTeg9iD7lWjRY7KhMlGJIPr3p
 OVZ3PtAIM8UoM0e8HRx4NMmyDyDaR2sIeQ5GZRQtSikQsd2in7HI244sp3ROD5RN1pLIt3IsoL
 UOk8L3/+369/3A7oa5cBnAAAA
X-Change-ID: 20260312-pinctrl-mtk-bind-gpio-98991ee98145
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Jill.Wu" <shu-yun.wu@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
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

Commit f4df9f53b7a9 ("pinctrl: mediatek: Bind gpio while binding pinctrl")
refactored pinctrl-mtk-common.c and the SoC-specific drivers to register
the gpiochip during the bind phase instead of probe. As part of this
change, each SoC driver must implement a bind callback.

The drivers recently added for mt8188, mt8189, mt8195 and mt8365 do not
define this callback, which prevents the gpiochip from being registered
properly.

Add the missing bind callback to these drivers.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8188.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt8189.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt8195.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
index 386d4d4a922..256053f269f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8188.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -1339,6 +1339,7 @@ U_BOOT_DRIVER(mt8188_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8188_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8188_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8189.c b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
index b798f3c019b..a64440d8bb3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8189.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
@@ -1271,6 +1271,7 @@ U_BOOT_DRIVER(mt8189_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8189_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8189_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
index 031ad5f6a8a..db619766a99 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
@@ -1074,6 +1074,7 @@ U_BOOT_DRIVER(mt8195_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8195_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8195_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index a6985e48858..0ce99b92a9f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -596,6 +596,7 @@ U_BOOT_DRIVER(mt8365_pinctrl) = {
 	.id        = UCLASS_PINCTRL,
 	.of_match  = mt8365_pctrl_match,
 	.ops       = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe     = mtk_pinctrl_mt8365_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };

---
base-commit: 4ea741b6128e3db998b5a111ffeeb45f158b7116
change-id: 20260312-pinctrl-mtk-bind-gpio-98991ee98145

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

