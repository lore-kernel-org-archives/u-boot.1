Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D6CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C696848A6;
	Mon, 15 Jun 2026 21:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="l9QtdhZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9A384704; Mon, 15 Jun 2026 21:24:36 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E1984105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43ccdc20e67so1608591fac.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551473; x=1782156273; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ+E9HXiXCFgwRp4aNK8uBo3qiGTMTTyRQc7zv69cxc=;
 b=l9QtdhZMGsfsRyZqSStD4v7NzTh+X4WV3YV22zs3pWNdDl0vJiDRbpNFhXKBjWoQDc
 DoE6J3IR15R85XtzDDPfxn5BvDtG4BpjxMC0fJNeC0oSqaqaSOvQWucv4ftQeaF5/FZC
 Q3d3YNXThb8PjH5qzVa4XCfelpSZLufieT4jcuUCPpMwE+/qxhMBgwzk1/zZVNEgiGKr
 S0WgXYy3uvLFoAIFGsO6uV7ZQGKICG3EX6/4e/skGhZAMNub6izdWbvbeADqh0IWh3Ov
 e4GP43LTHkuJ5gywPZmeacEHBo2cTzPoJkYawIwJdFpcCnWPorIxY1XxZYKCoe9l+d0J
 U0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551473; x=1782156273;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZ+E9HXiXCFgwRp4aNK8uBo3qiGTMTTyRQc7zv69cxc=;
 b=AUsImlTNUwjSYNRR8olATBsHa9CgBVj2Xcvq3XLCg9IaC9+4USuf0VKSQMLt3qbWjs
 3flNoRUHZ/S9mLJTkjityKGkkhabEr0CvN3GQB3H+1V8EvjT0y7XgNr7L5RpPjTsdBEk
 Tdnu8XH4g/5BLKNhazJpZhXZKtbEXCuzrboErYfBIICtwLQNWsj/fpZVMQPjOBvqC7rt
 PcSar3qASJQUlDtESG3TUgVejNh5s4+j5BtfGj2LA4GIllHrDp136PQiYHG8K3nws+xD
 CxLEghdvSj7aJ5fFAkLjBMtHsJsHAucZ2Is7VG8exAICH6CcTfXx4kGbO/4rNkg7TXJ7
 GyUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9i2OSoipnhvfPA/c/0a9hdmBaSZt/ddIi5O+2x920xb8To3SP0/7z1pPJiyPgpcU6/kM3MZGE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2Th18VCrzKNlAgTDdUeK3rCga+a5cRHgOnn+RvX+d8vvH0H93
 1skS763I00Vc104phX0oEC4yC98b2wkK3LJEikOXlYfqSMKcYIHjcJVnYxQsbiSr6E4=
X-Gm-Gg: Acq92OHBueRlZYXbII6o8DCgnisju/195AAajCT1MKPVud3FimiUfnwEeqTUeZu8NBn
 EEDbubIIXSI1O8KtzLrOLXhrI7O7LaPzwkzSo25Mq2j3GoigYJrMtMnlO84LB87o0blBZnt8lin
 u7olOc/x3AC+OIZWdPYW4r+iiTDFQfNUHgzRF9ZsUAC2YSOPzbsCnjvkIE4yZMPSsFfFutzUiKZ
 hBZwpml/1EfJZ/ZBKX8BGD9ewPXuUViKpnB9QAeCW8zyUgoCNCiAIoBabD78R+4AOAEaYyxkorw
 vSWj7vZKvnrUDQ/DptyKozo5tb8Rxc6WA/NPBcp208oSCEcE+OWPN9NPH2OgYlZRjzAHnR/VGiH
 nWM+yQ+Cc7gTs2Z6yFDkdizMTookpKd/Ztdq9R6tK/nZ5ZblqGOtL4LsLXDUE/JTO0z3tPwshw/
 WwLsD1MjsDFlZcN4LTFa5tPvAoAyKN1S3pUKW1MEY=
X-Received: by 2002:a05:6871:14e:b0:440:e35c:f8d8 with SMTP id
 586e51a60fabf-4428c49e136mr8141909fac.17.1781551472689; 
 Mon, 15 Jun 2026 12:24:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] arm: mediatek: fix gd->bd->bi_dram[0].size
Date: Mon, 15 Jun 2026 14:23:30 -0500
Message-Id: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2TX9wZp48j0Mh7YssipgWiQi6
 btb8O7xy8x8s0CkwBThVCwQaOLIQ59B7Qrwre2vhFxnBiWUEUZK7MY7NvzGYDuM/CEU5UEfdaN
 06Q3k2TNQzjflpfpxfLkb+XH1rI2W4ziEefuc5Nr7o58kCiwV1VoLY4S3Z2fnB7tAez90UKWUv
 oExxw7FAAAA
X-Change-ID: 20260611-mtk-fix-ram-size-045373f234c6
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3459; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=G1u9NtPP/Fn9XRYSzqSIg2fl4HJlTb1T70zWbZyY9vQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFE0vR5VJsPpfZdt90riqNj/kd+gwaWfAQzL0
 uc6jn2xtLKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRNBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAa0H/346PYVfsWxXXmsydF8a1E37I4wKAJhCy0i4Bgw
 VFfCAT0Cscq4VEOeUsXj3eHoLpZvz4YNWhTjE+E66hpXUM9U8LxB4JenSAb//EN9M07ymIWfg6R
 S71bDDTc12+n0/ErbUaOsU1iZMA6HVjTa/A9lZCDGrTKbrWZt4u6aQFvnYF0Cge+D9zTXV7iXfX
 km52NDoAoP0+49HMN6cjFOVvFygPEw6MloKj6+/K7oQx35HSNxC2a4izv7mG1KqruEgAhSPmtRk
 /6bGCDSHS8Hi0IzoVLZnjIXdsQOAkF88FKWHVNa0Dt0tZQ2DHUjV5tjgQdrIW70szTDAJedg3PS
 x6Uk=
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

During some recent cleanups we made some changes that had an unintended
consequence of changing the value of gd->bd->bi_dram[0].size on some
boards.

64-bit Mediatek ARM SoCs have some peripherals that require DMA memory
to be allocated below the 4GB boundary. We were using
get_effective_memsize() to work around this. However, this also sets
gd->bd->bi_dram[0].size to the value of get_effective_memsize(). This
variable can be used for other things, so needs to be set to the actual
size of the DRAM.

Now that we have the LMB_LIMIT_DMA_BELOW_RAM_TOP config option, we can
set that for these SoCs and use board_get_usable_ram_top() to have the
desired effect without changing gd->bd->bi_dram[0].size.

The first two patches are setting this new option when a driver that
requires it is enabled. Then the rest of the patches are fixing the
board implementations.

I have tested the mt8189 patch but don't have hardware to test most of
the others. Most are quite similar though, so I am reasonably confident
they should be correct. And ideally Randy can test the mt7988 patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Make Kconfig depend on individual drivers rather than entire MediaTek
  ARCH. Only certain IP blocks have the 32-bit DMA address limitation.
- Link to v1: https://patch.msgid.link/20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com

To: Peng Fan <peng.fan@nxp.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
To: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>
To: Weijie Gao <weijie.gao@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>
To: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: Jerome Forissier <jerome.forissier@arm.com>
To: Sam Shih <sam.shih@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de

---
David Lechner (8):
      mmc: mtk-sd: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      net: mtk_eth: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      arm: mediatek: mt7987: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt7988: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8188: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8189: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8195: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size

 arch/arm/mach-mediatek/Kconfig       |  2 --
 arch/arm/mach-mediatek/mt7988/init.c | 10 ++++++++++
 arch/arm/mach-mediatek/mt8188/init.c |  4 ++--
 arch/arm/mach-mediatek/mt8189/init.c |  4 ++--
 arch/arm/mach-mediatek/mt8195/init.c |  4 ++--
 arch/arm/mach-mediatek/mt8512/init.c |  4 ++--
 arch/arm/mach-mediatek/tzcfg.c       | 22 +++++++++++++---------
 board/mediatek/mt7987/MAINTAINERS    |  1 -
 board/mediatek/mt7988/MAINTAINERS    |  1 -
 drivers/mmc/Kconfig                  |  1 +
 drivers/net/mtk_eth/Kconfig          |  1 +
 include/configs/mt7987.h             | 14 --------------
 include/configs/mt7988.h             | 14 --------------
 13 files changed, 33 insertions(+), 49 deletions(-)
---
base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
change-id: 20260611-mtk-fix-ram-size-045373f234c6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

