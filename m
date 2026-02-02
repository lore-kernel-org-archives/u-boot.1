Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4C7E7315A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E976F83E3A;
	Mon,  2 Feb 2026 13:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HRrBjmz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A53783E36; Mon,  2 Feb 2026 13:08:15 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EE683D8A
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so35035775e9.3
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770034093; x=1770638893;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sy7VMlACoDb2tL00LzUMFti04syaEKoBW9aYM5G5rHs=;
 b=HRrBjmz1XPbzUs1eXfM7V59RSsug6q1bERIZgINnoI/pHRoi0P6OmDreux02PP0HNG
 b5e6qW1C19j6W/IdkoHyWdnOcrORfAyUNz/bYzS1QW4UVWTJqmwN50EPL5EWfXBNUb1H
 um5GBf+wYeqVByI2/UgPpMo0WLcwVmzdwYWEe0jFG9A8a/sl16aqFye6N8UJfafhGLjG
 vfr7Th95bYJsnhNUPNCZd9z0xl4WQGSpUYCCPECxMq7P8ky/evCDhgdN49rYx/eZrI0r
 CUzVAlw6mTRODUYd5NNSOSGRz5d+MLqHrk6LFCJBHDW+hFS8VpkRCZxtOmkRJJ/isDds
 hLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770034093; x=1770638893;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sy7VMlACoDb2tL00LzUMFti04syaEKoBW9aYM5G5rHs=;
 b=knvHsny/ALQOcfDZNYmioVQCiBoaLzTduBmTq4vklT6FQS7v8ffEkZplxVFHe2tlge
 r/cD/2JYo5q9nu4D1438xpPCg/CZ9mpDogFzVZ6sltStYEMTW4vdrBJsLPd36NbuIQNs
 lZOuNKiDFJRMA6wT1XuK7FGHdQqL5fDruKsfhV0AwZWsFU1Yhi2pH0e9iiNrbU/JcEau
 9ARP6tCgx9qzqqf+8P0KYZTdtQ78XNmRUHSmmvzSiDYuL0lo2NpthOXxOXoeEE+s3HIM
 WGtVYUQhCHgxpGwuBSB+LJmiRVq8BTe34/RNaxRtPeCGVG70/KjL5ziB3gXM65eq0hfW
 FGOQ==
X-Gm-Message-State: AOJu0YyqsJaFXmV37GOEq+CSQo4PtTggvkyCmJL9lFnIboCEmCxjSqvG
 1aFTqkUuJDHN9vz7wEK04yO3Ae489MAT2wwMYVmSH5E0qhVOR1vGGFTLVL9GooB1K8w=
X-Gm-Gg: AZuq6aK9xY/M7jhN/1epTmSt8kMLDEk3A2gVDPmyJZcfURlmJ1UJ5b/GJ3PAiQd0uL9
 HxCWno64egpNWdMe6bsSnOgcXkY7Iby7aCszQ8fIuLsvyNaMTbp1cDw039I1a/yO4OuBdIXEJ7b
 UgKt4csussock3Q975iu6ttbTrjWwDIz90XwUW1DlPeazh+qZTgIGitBNrbuKhwk4z/Uo4MOPPf
 eU1D9yIz2emwndYXldyOaJih0dry2J//AqTtenyIXbBr4DEb0Q9VrOswtWyTOTzyctHr20d4aOC
 2NmwlFeajGsEVvclVEKnWuMvlbJ6/cqp+BXCjiO/hngwXN129dyYxfJabTQtuKaX/x+JnuVQQCc
 WY/OljO23qNLvMbcbHn+1lbHlSQxPkFfbCJExpof8yI2V/0XEzhHM0RXldhNLPNKQrxpht7AKx1
 nJfuMGn7LIEpg5xzyq4hFrWhtzKn9L+p9guzKzCW0eldmDJBE1TLv5L9dhqhc/XmIMSRNk2Vmoa
 0tOjLZT0gwk43akbD/i
X-Received: by 2002:a05:600c:3b96:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-482db49978emr141284745e9.26.1770034092877; 
 Mon, 02 Feb 2026 04:08:12 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e267b699sm89784635e9.16.2026.02.02.04.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:08:12 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] Add MT8195 support
Date: Mon, 02 Feb 2026 13:08:10 +0100
Message-Id: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNL3cSUFN3cEgtDS1Pd5Jz85Gzd4tKCgvyiEl1zI3MTAwNTU+M0C3M
 loPaCotS0zAqw0dGxtbUAPdc2KmoAAAA=
X-Change-ID: 20260129-add-mt8195-clock-support-727400553f87
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
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

Hello,

This series adds basic support for Mediatek soc MT8195:
- clock driver
- watchdog
- add a new macro helper to define gate clock. Other driver can be
  cleaned later to use the new macro

Other driver will be added later.

It will also serve as basis for board support such as MT8395_EVK based
on MT8195.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Chris-QJ Chen (1):
      clk: mediatek: add MT8195 clock driver

Julien Stephan (2):
      arm: mediatek: add support for MediaTek MT8195 SoC
      clk: mediatek: implement GATE_FLAGS macro

 arch/arm/mach-mediatek/Kconfig         |   11 +-
 arch/arm/mach-mediatek/Makefile        |    1 +
 arch/arm/mach-mediatek/mt8195/Makefile |    3 +
 arch/arm/mach-mediatek/mt8195/init.c   |   91 ++
 drivers/clk/mediatek/Makefile          |    1 +
 drivers/clk/mediatek/clk-mt8195.c      | 1662 ++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h         |    8 +
 drivers/watchdog/mtk_wdt.c             |    1 +
 8 files changed, 1777 insertions(+), 1 deletion(-)
---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260129-add-mt8195-clock-support-727400553f87

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

