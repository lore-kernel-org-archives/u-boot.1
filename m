Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F7CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6528483FF5;
	Thu, 11 Jun 2026 22:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WQzNXd1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F32DA8407D; Thu, 11 Jun 2026 22:32:02 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9005B803F0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4863cd278d7so229756b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209919; x=1781814719; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KxAkNrfXgt6BOjMLkCRdieTtJngcMHFmqMLnaD95HqE=;
 b=WQzNXd1vlOMpu12OLZfaFZd0Yfy/WpT6ax/suowyoCAopofXE1pUJ5ZF1r1R+bWqEK
 B6v4ZBHKL7qtZzCv2su5d6N04yuhmJHxtFRxVo4I4GNYPC2uj8cBUYh9IESztuVTCWmP
 3SS+oVIEfqv4SGOaIYOq71fKlfmyX5YTc/TUXTqj4cI8++ZXjCxyhI76xv9BZNJjYKtV
 dHl4+L/v0cudyOI1zAX9/VV5Bfh/+91gAdkmtXPOZ3c4LY0np+TG2etQvgrNHNOZHljk
 t9RKXcVAImHUMKIosrLOyfZHa35L6Ui9kF//1A/lHTYJs2Keu9P4l0w0kRyTHgMFrNMU
 BOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209919; x=1781814719;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxAkNrfXgt6BOjMLkCRdieTtJngcMHFmqMLnaD95HqE=;
 b=TEzFxHV8gHPiWUlJEZitsxjQcLb8BXn2GrDqsc3yEZhr81esJcLTji+XkkN5hmhhHq
 0RW179e6jY4ivqDYDI2XIis4TFauY8AQYzAcYYBqu1iwMNQ0SlcE3yewnUBflQV4K/hN
 wE4BEXgJhUPOOSaafO9VN3cwwhnL/e4X1WiW+YTXHFLSDRHjAyZh5iLgUXGl4cOlLAZt
 4dX4OFpeopLZ3If3dbI6NSnfl/GAF7DMCbzlyVAQK6T0Fw8u7rEQnqTkkF43PpNl7CaX
 05kubytekIMnohCMHOrak4p+3S3/srUs6ubyy8ytJQMxMlVTrnK2lz/TFna+Iw72RnnT
 lUzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t76imhyxznEF7u2/d+KTwZNyvYFU/8Rof/UHYrDCG9ktEbwyrNmTRwH3r3/i0CzNvZuaZALQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxgEsaUjM4Z2DXj7rsu8GmsSqpvudCY52QhwPtxv6VCOxPSTcxO
 O4wrFIPGG/BEmtQKw1XcWA+dNaRNErCGgieDv5ByTnQ+cB9HrBMd0SiZcsFmVyBgqfc=
X-Gm-Gg: Acq92OHviay9QonnJE6e+Fzavpa9ZeWl7TuSLRBQ8hnbosmhqNdZltLXhQUtoBRLVCE
 c3WJ4HFpwFMdgQAspSukGGQJKmGkVz5lu2W/dd8k82KBKqCOPOp+Og3SvTsQrZ9Y5hYl4feo24h
 9Kdeo4/rdDsnEuT4tC7fdKZE3b+clEnXIYSVkFRhMO/O7b14ulA+4GBrUQjI09nX6mwXYtiqqF6
 MKClD97kPiRBUdVVWEX8UcWuGcdp9mrtYE/r2bn+/VW+/zJMpGK119i1EO8Z2b8f3wa//oVngaI
 EtHe2cox0vlx4KXxprjlRZPqM+9QkfHcXWKeUCNp4LlwtIBpIMsUdUJnW6bs9wFaQk4eDzxupNF
 FqGiRRLMBs3k2m/jXi40UaYITWDmzrJeWOjMNEsZMHzEXGKkWTdMxLqndamwFX0vPgxPBbp7EO2
 SxiPWvfeOdIMQ3tn6bu2UhHIfC0JE=
X-Received: by 2002:a05:6808:15a7:b0:467:2f84:b0c6 with SMTP id
 5614622812f47-4872f31269amr6668b6e.8.1781209919132; 
 Thu, 11 Jun 2026 13:31:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:31:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] arm: mediatek: fix gd->bd->bi_dram[0].size
Date: Thu, 11 Jun 2026 15:30:59 -0500
Message-Id: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ND3dySbN20zArdosRc3eLMqlRdAxNTY3PjNCNjk2QzJaC2gqJUoDz
 YyOhYCL+4NCkrNbkEZI5SbS0AjtKUI3QAAAA=
X-Change-ID: 20260611-mtk-fix-ram-size-045373f234c6
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=68pXcVqV/qOvT9zNi7ZGXAxoMssISfGOSZImyLN8L1k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxsHi/z/oybZDTZqbcU38QJiwK6IT+jwgepdJ
 xm0++jkgVOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbBxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKDUH/RMreJyoIX4EsUqWrRDxstvstFubC5DfYF1r8mp
 Iz7o7Jj7MZee1nCGyRwI4SeGQ8QGHuZ9wcjJNjKJzXDEYvzX03zPo8nStKNuzrdwj1bzUci6VJc
 e9mBIrOR5XQU9yBUgwYU3jIDU3VMsUxvIcn42kuONIQOJsZ8e/zQ+YPtx4F6l3aJDSgHhUSX3jw
 9dkq7uGwbyTQIkHf/FPIk251uLR/I5J6PMygxOS1Yg8TmpW2R4Jq1rlPfEGPlaQPT5MHWLComd3
 0SoEhqQ048Kx/zmJvcJ2DXgG38X56kDbOe5jysNMvAz7XJvCdDgdsQZ5GvNICYvsYeRmVd6kjZR
 09K4=
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

The first patch is setting this new option for Mediatek ARM SoCs and
then the rest of the patches are fixing the board implementations.

I have tested the mt8189 patch but don't have hardware to test most of
the others. Most are quite similar though, so I am reasonably confident
they should be correct. And ideally Randy can test the mt7988 patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (7):
      lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit Mediatek SoCs
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
 include/configs/mt7987.h             | 14 --------------
 include/configs/mt7988.h             | 14 --------------
 lib/Kconfig                          |  2 +-
 12 files changed, 32 insertions(+), 50 deletions(-)
---
base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
change-id: 20260611-mtk-fix-ram-size-045373f234c6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

