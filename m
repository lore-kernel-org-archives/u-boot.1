Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2635DC4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 16:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3AD28484A;
	Sat, 18 Jul 2026 18:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cl+uxsfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E98849AA; Sat, 18 Jul 2026 18:16:39 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BBB84659
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so7917625e9.0
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784391396; x=1784996196; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RSkX9KCL8fnPNQzC+0knGwYIYBCDSeKLNAaP2Houirs=;
 b=cl+uxsfipbgrgwXT45e4ZRO9uMJoayVxFR/142XAefxUB4qE73Z6WSoohxs41op1Sa
 ArLzgzVyIo9F+Vd1z6VmjYwXSZP1gN2PYW82Yh0WwX/zI/2HauEWO1B2iCNr0cs2QqGi
 G3EK8NUjkTUm+irv8S88pX12HDw7FIFsHpcJv2tQ3bijLUckwczyvjSV1YCOa1dtQuRW
 nrd9NHCMj2lvIadMKIhLwZ6+ENd8kbKfsXDDUdYbaHzhwt2AMGf78ADqnSvaBmsUkdxx
 gksB9U5ImGhB9WUQ9B3bTREgl6jtmI1MA6hVFzwX7UkVr5L8OU1GmJf9/OodYSmI6j/X
 Gs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784391396; x=1784996196;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RSkX9KCL8fnPNQzC+0knGwYIYBCDSeKLNAaP2Houirs=;
 b=qWfRRraefw6/ASFLARApG0NgIEbGoyjhv81ULpk4bljGxkXHBwE13qUn+Ok6bhf434
 CVVMH5Ysiszg1IiSqh7LVOqBOEW1CYwvFuGc99i/F3dHZIBEgIdU/S0ziPftikkT53H3
 2A1TyfTuCLPKuZC0gOfztjiIZ04dBj2V7jdZndOlX4WfpG5r/mHuHw0hSiPY1pqTYK5J
 w5hArlqHiDbjn1Mkguea5zphpgUVMjGzc43XwvPvBsxbTI9va0fmcX2aCoDhB7WBVkvu
 7MVOEuqQhFIPDqQJlqD/fSoqpKZWXTzl3BqSzXIgmtilsfdBGAYhe3t5y0Wd6izOaJdR
 E96w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rourp7wUHxvErKgjVR2C53dpe3iIvKehEUzmF7YLwWMCI6tyryi/k7xuXabFvXvSJBYZEjbRNY=@lists.denx.de
X-Gm-Message-State: AOJu0YweyefRnQcGqBioMoYsPxxlXG5J+9n5urGW3T9h6oaf8N7m7rdb
 jnJVnQSUyOIZeuf3UHvZtw/AcWGL3/eZ/qCJnZ6OxlywrE4dr/0lmnyvIm+KFt3MyG0=
X-Gm-Gg: AfdE7cmeCaqVGKqUBG+FQQZfoJXOh1h64uyyZP+rRUlDlJf+taiP4+EbBCvFDagHTD3
 bPOFZfD1z1r9SldLOz5LbpV7Xkz1reBgt+golAq032WxOVnAWoyafhqLL3NBDIlnyYJeXBRKmWl
 Sn8mxSTFouWxIsvajb0O/rZqcfxUi74f0Oy2CJfqpEJ7zF3cXrdtvSW7MKw0Fy1qaB4czblsyAQ
 bwWi2mr/LFwijXAfMvl8C+ouxeVEW99CUQjUtGwEAInK7lNKi6KOT5xIQ5pHlcIpQ9iNsdy0+BI
 Me1lCs4OlNVyrm82xiYnbroreF//elGl/yzsfvo2AltkrSHNWyFn6k6MxcdnNSPR4aM6mKoA+kh
 6gLIqTnnYYVOvpogYzn5FmHNr8euhMlLHsQoBKcPHXmsbLudIM6Z9rHLfiCBbuZMhIWK+wDoxwc
 22rnb7l4WTtyCMvhByfQHgsBIGRoxJUGX1yINCy6GLwDB21rNfZTytfzSFZ7JadXoiibI7Q78jI
 LrWJC7JvISrVkNh/KaE
X-Received: by 2002:a05:600c:45d3:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-495503fd2a0mr34515075e9.9.1784391395922; 
 Sat, 18 Jul 2026 09:16:35 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499d1d4asm88915955e9.2.2026.07.18.09.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:16:35 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/4] arm: mediatek: add Genio 700 SPL boot support
Date: Sat, 18 Jul 2026 18:16:06 +0200
Message-Id: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTuQRGnUq0gX6WSiI7aGTCpC6
 d2Nunzw+SsoF2GFc7dC4ZeoPOcGu+uAbmG+MkpsBmdcb7z1SBRawrhkrYXDhFM97k8GNT/Qp/5
 AwbqYxgjtkAsnef/ul+FvXcY7U/0uYds+Th2fkX8AAAA=
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

The Genio 700 boot chain uses an external DDR loader to initialize DRAM
before entering U-Boot SPL. Add the SPL devicetree and configuration
needed to initialize the debug UART, watchdog, pinctrl, and eMMC, then
load a conventional FIT from the bootloaders GPT partition.

Add a binman description that generates the two images consumed by the
MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the external DDR loader and SPL

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

The DDR loader, BL31, and OP-TEE remain external build inputs. Document the
complete build and flashing procedure.

Tested on a Genio 700 EVK using a full genio-flash cycle and a cold
boot. SPL loaded the FIT from eMMC and passed OP-TEE as BL32 and U-Boot
proper as BL33 to BL31. Linux 6.6.37 reached the RITY login prompt.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (4):
      arm: dts: mediatek: prepare Genio 700 devices for SPL
      configs: mt8390: enable eMMC FIT boot from SPL
      arm: mediatek: mt8390: build boot images with binman
      doc: board: mediatek: document Genio 700 SPL boot

 MAINTAINERS                                   |   1 +
 arch/arm/dts/mt8188-u-boot.dtsi               |  40 ++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 178 ++++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |   1 +
 board/mediatek/MAINTAINERS                    |   3 +
 configs/mt8390_genio_700_evk_defconfig        |  28 ++++
 doc/board/mediatek/index.rst                  |   1 +
 doc/board/mediatek/mt8390-genio-700-evk.rst   | 168 ++++++++++++++++++++++++
 8 files changed, 420 insertions(+)
---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

