Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB90F8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251F083E36;
	Tue, 21 Apr 2026 16:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gX+HzPYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3D483E76; Tue, 21 Apr 2026 16:24:39 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB36E839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-470145d7df5so2625757b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781476; x=1777386276;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqNzI2HKd2N+egTwm2x9JBfwXgyzJpoDwmu/sRRqVpA=;
 b=gX+HzPYYsO6x4+YMXuBDAzkmb01JuIYTwpMKnY0+ev8i21pMYazEDBjXPQc38UmqFl
 SF9lc8D9H+FHuOzB061sonGLOHYJXs4KQVDtqiAML/p8i6FkrUaaJgg/LWFGAakPWXgI
 zTdvF2mMm95A4cSg1cssikqEpgw7vdERsOhrpEWVBKh6y6a8OqrwUkHKKE6mqQ1X+BG7
 5NIOwC1ktq4dXxvOXZ/3L3heklViRr1l88o1FUhCGaks5qqy9gG24rzuU6c49uQuli1R
 Tpl7n1mqOotJ2Tx8r3k1g4eAfYXw8ew4HGvy7Px9J2ZySBEgTH4tD46Nn5tBtuyjfbVk
 OFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781476; x=1777386276;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqNzI2HKd2N+egTwm2x9JBfwXgyzJpoDwmu/sRRqVpA=;
 b=nwcEObnTRkY23tcbhbZrZEECihE5uqU7fjAZ/UN1wJEmQR5sbSPHUp6CJ3TwM2iHlc
 SVK/m1OxaQLCIPNvzUXrotN4x9fdw1gBPKIVqnc2nhqygDn1pLxkkB1xaSQ6Ggh9q0cX
 J77198pCtTrUjMvvsIFusGuOCVYAXS8B9RGtW7RlprS9wamtNTiPmYVIWAW0rd/MTuWn
 pibET0KCUf24uNz6kruLJwbn/eH6qugfa7L9/UIgRnPHwOryUTw+ApFgxT6mVa4mMR/N
 maOYgbW7QHwK0iTC5hyfTBBLIOYcx7KeRsbj1is/Q5ID4KAfKuNNZFhgNe6XsjtBJbCJ
 Di3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DWcCM9MiIjfLXzO8fQsRa8/ahmMFqjQUNpsH5RQ/Z5eYI+etUrSGY+DouzAJ2/B0e4xDTSKU=@lists.denx.de
X-Gm-Message-State: AOJu0YzWes8+whLXpFuzUOlXC+s83IpMpIerXx9f9Ff/HNZ21poyVbRx
 wPTF1gihRuGd0h4qqZYIY8aMiNFh2v8vKpkwDWDR6yMP3t3Mm1MDbkaAHI7bMJw3WFM=
X-Gm-Gg: AeBDieu/Mzul2uKQpRv7LOIX3NMqkQ4MnfveixegvNJnQS1Bo6TjHyoRnkVOe8UtEUo
 dxExryx1QtF5QCJxy4DYjZlBRxg8R3eiusKyBCQJxOYmhtNPpzvJ3qVieTF5wK0+Pzw4dcw/126
 RHmBgu3GX+aS09ATfk8rKaCkEwZmqSBE0qdS0bMOwfnlBhxo9h+PKkU2p3WnXjBLvPoiyGnRCKI
 SvJmsx0u4DIwKM1KhcNu/eo9whi26GlJXcLrsa0TboWLHyY9VzSpSdQsggeAiBxQu28G4jaNVlo
 Iu84EdLlER6ql0UWldi1W7OlCx+itcf+h/+0WKJx008Z22+J781oWZ+n9TDnna7J5SV+WTWd/gi
 cU22FfvcuKFZehYnSibVwD0hUnjRU56+7q6HGoGQnXhvJkJ1nBehXCgGapa4QUUFjWyrbVUgYjV
 lHIEfdtAmauKqpjSWlvr4bSkigOWVW12lpyNqPtSE=
X-Received: by 2002:a05:6808:2f0c:b0:46c:cdf4:1bed with SMTP id
 5614622812f47-4799c8fe25dmr8993063b6e.3.1776781476377; 
 Tue, 21 Apr 2026 07:24:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fead505sm9217965b6e.2.2026.04.21.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:24:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] mmc: mtk-sd: fix HS200 mode writes on mt8189
Date: Tue, 21 Apr 2026 09:24:03 -0500
Message-Id: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TXdltjEk/9hONCyyKoF0yKRE
 P7dgnePLzNvZoHEUTjBuVgg8iRJhj4DHQrwXd3fGKXJDFrpkyrJYggew/jA1GArH07Ihoh0a41
 hBVl7Rd6DbF2rH6e3u7Mft52t0UkahzjvnxNtvT/zE6FCpxqlTenY2vri6vkpLvLRDwGqdV2/V
 Y0Cq8UAAAA=
X-Change-ID: 20260417-mmc-mtk-sd-fixes-e31112f733e0
To: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Weijie_Gao_=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Dv5FNY3I4I/d8Z6Kwn3lZeMNNRlKiJg42aCzXQ0Oqkk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54iI9RPmiy7urWNWGs6rDbGfzKscmknqiEaGZ
 jsl9l9367+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeIiBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcUsH/2zrsVo1BVbETmAI4oL0hBfoLNOxiojCBcevkQg
 stXGxkU6YdGBWzF7MLAh7MVNowkUaOmDXVmixmKiWdne5MfDxWwMeXOTMlbx7L34Ltdd77cPI8p
 ls0CdAYX4V3VkJzIIAQ7FnjlsyNYVV8DvjpEl+5YCwiKfMUmauJpDaS0D9MOWOAhDtgjU6Wq3tp
 aWaMbnQcF3flCeGCY0HJNCXUZ4pU4gB8Ch1XFA1zzd1YT/6eC+uBOIrv3SrI8JffWuqXC42jK0U
 Kvu/7wJdNyJyps43cCmK/Hg7L6SvJIDayXb+bTq/COHPfzOUPyqe3TY5QVjyib1XSrCfYRBQ3ea
 tK7s=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

This series contains a few fixes to fix HS200 mode writes failing on
Genio 720 EVK, which uses the mediatek,mt8189-mmc compatible controller.

For example, trying to save the environment to MMC would fail like this:

    => saveenv
    Saving Environment to MMC... Writing to MMC(0)... MSDC: start data failure with -5, INT(0xa000), rawcmd=0x2003099, arg=0x0
    mmc write failed
    failed
    Failed (1)

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      mmc: mtk-sd: enable DMA on mediatek,mt8189-mmc
      mmc: mtk-sd: enable async_fifo_crcsts on mt8189

ht.lin (1):
      mmc: mtk-sd: fix msdc cmd ready check

 drivers/mmc/mtk-sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 71176c454f59b3f9ad166ee3b807bbef712e8d37
change-id: 20260417-mmc-mtk-sd-fixes-e31112f733e0

Best regards,
--  
David Lechner <dlechner@baylibre.com>

