Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB782EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C756E83F7D;
	Tue,  3 Mar 2026 20:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mxJ2y3ZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5A283F7D; Tue,  3 Mar 2026 20:55:52 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C499839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-463901a0accso1947341b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567749; x=1773172549;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AajiP01FE8So1A2OXZgcMGP/h/4IhJ+SuHhA1yCxxa4=;
 b=mxJ2y3ZAoSg21SMLZwQqFUS4TAtJh4XTsrFXyGpWmi3RR03Xg++ukAt1RFdQpaE2b1
 DJxQgmtXzai1Pke/1JARcNI+zPmXvf97Y2ykBKmLB+SBW4O3uru9n19sc0DYQloxu2Li
 oZoVlO8gVZJ/B3ixOY8ipUcEUTt1DIKZyL4OaRP852OzVKQmXzR2dRTDqD9Zr8RY1K58
 W5bLxGsFB54wGJZbGyivfEeuABrQ2zQEi+Tj5DZD7EO2HkpyhR3N7uqIGnwP2M6H14lj
 Ozeh4TFnSMHXujoskeQnktPrAZ6XSe+1Cmr1UhF7fTGaSkUwxytQ1R6Qyh3D4T3qQNzF
 2mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567749; x=1773172549;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AajiP01FE8So1A2OXZgcMGP/h/4IhJ+SuHhA1yCxxa4=;
 b=Ng0CdOmZDwsXBWXRVZ7TbERLeW429J8tUlwfHorIq0Ob9Qsq+F5/GbMlZTKjr71UQe
 0HV5M8D4jkUzHST3cn+fld3IRlnW/Asi6lbpYthY4PTvtyNgn1lMrUL8WNXWA6iBa6yD
 0jj2P8+i438ER3V/Zx8c5pYnZNVT0/KzqhIYnNJba/4IdL5TibpkpvM8BH8FzdXu3Qsz
 pZ1lCWO9sIsUSWjaFItn51o6AFA/0yg40RlMG5OY2c2xtO+UAmLyqlFJU1oxF+ff260N
 Z0VrXcTGGTpGNc9n3mI8RuF+Y7s6glBW2f1aosFzJvU053ebVEbsBABbcXLFzar5Ns5m
 Nmbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiYYeOSbUbWRCmA4II+sWeR6cMo30ntNPeLcXuf+lxKTgkP3EV26+G1wgVBbbkynf0dZx3ado=@lists.denx.de
X-Gm-Message-State: AOJu0YxZrvuy+QzUJ9RWfBEjkC0KOgsJfULw3Mho+OsjxGO6GanQ8oeY
 6RSzagrp1KeKuFGUH/a5TqCHC68FCM+vFQ3tm9RPfOokiQq6hZsAtmFi8cDtBdbNLwY=
X-Gm-Gg: ATEYQzzY73E1hJIsF321h0pig37ElwVSBVJE6+1xefAM9zd6JjCMUtw3SmLcMj0kgk7
 M6hhVJwqwgm/RUIQbvWL7iS+waEAbYNbd2g7uoeLEtawb7cilUOLy79AU3cvzDic+f1m1al7B6t
 kO40yqdzbEBqCcK1RngdB+H2ibM4kEbAFHMc61Om8k2I7xNecDMppxz1grlZeGWWPoznA9nV5ey
 29JXABA0+C8T5oOI6wzqUp4CPazEbycwIGxE9l8m9t/RRTncU/+C159iqYbHmJB+FD8A/Pw92LK
 1OX4Xcd6ITaiB4uiRwoW+aT2VbQy/xFVkHVATO2bcEW/VoI6MZj+P3yW0t7CCYM4csL+Cj98pwr
 rygy3EqgKRl+ioLG+Jc1k7BqEXG++6K8T/hQvmKzPfQgdMD4EABigtwhH6RoC3jZa4MMTOeAZr5
 UmEqTyxnJOTbv4DVS4IFxIf1KOP8I8
X-Received: by 2002:a05:6808:1523:b0:45e:fbe0:1bf3 with SMTP id
 5614622812f47-464bec1af08mr7118081b6e.52.1772567748609; 
 Tue, 03 Mar 2026 11:55:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/7] clk: mediatek: new mt8189 driver
Date: Tue, 03 Mar 2026 13:54:48 -0600
Message-Id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OzW4CIRQF4FeZsC4WLkzLuPI9TBf8XPVGZ2iBT
 jRm3l0cm9SYWbA45PAdrixjIsxs3VxZwpEyxaEG/dYwf7DDHjmFmhkI+BAgNO/LsR4jTcf9Kfp
 j5lZ2AQVoq01g9d13wh2dZ3P79cgJf34rXR6XzNmM3Me+p7JuYqI9De8Dngu71w+US0yX+Uejn
 Pt/4+3C+Ci54M5Zr0WnwIPdOHs5kUu4qgMzOMITIj+XEKiID8pIH0QLrVxA1D+iBCwh6o5og74
 2tN6FF2Saphs8+M3KbgEAAA==
X-Change-ID: 20260204-mtk-mt8189-clocks-a19de024a48d
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0doEbnBIElle50M2P8PE77zmFPed2dYLviISoCEdVqg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzyOCpW4vwVVsYL4doVxM2e+z27SoWrcxDqaE
 chQcR94MRWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8jhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVw0H/iHXeg5z9tzjnQi96PxN0n7QcmRtufMIp1zuTR3
 m0UVvADHS7D4yNGCwXEz9O1OGydsxsZshIDzTRlcovKBqbufdqub2Uk2rii+ObFKTDXW6vVcFQR
 g49H8FastUU42hCHvr3n37a5SpWtR3A/HKWwqPAQfdrvH6fz1WYhOmEv6WXATFfZkAqs8aKL30w
 vp0uAH5HeOfNmazcVIbi65kGYVlNLuEf+UYsC651QI05S5YcCr4cuOV7vA24/kG4tbxyzfN2TVu
 kI5sU3FSqibnwmDY2Z7jzw/7CC5qyBSw3Ugb1h3i4wb3BaB1zmJTOSJxmAk2rAJv6jNjveRvVYg
 iJXw=
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

This series adds a new clock driver for MediaTek MT8189 and similar
SoCs. This one has some unique characteristics compared to other
MediaTek clock drivers, so there are a number of preparatory changes
first in the series. And, as mentioned in a note on the dt-bindings
patch, this is simultaneously being upstreamed to the Linux kernel so
it will be a while before we can use the upstream devicetree sources.
In the meantime, we add a copy of the dt-bindings header file for the
clock IDs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
- Fixed some missed refactoring for gate clock parents that caused a bug
  in later changes building on this.
- Link to v3: https://lore.kernel.org/r/20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com

Changes in v3:
- Add more macros in last patch to avoid repeating CLK_PARENT_* so much.
- Dropped dependency since it has been merged in the next branch.
- Link to v2: https://lore.kernel.org/r/20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com

Changes in v2:
- Fixed CONFIG_TARGET_MT8189 in the last patch.
- Link to v1: https://lore.kernel.org/r/20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com

---
Chris Chen (1):
      clk: mediatek: add clock driver for MT8189

David Lechner (5):
      clk: mediatek: use correct struct type for infrasys clocks
      clk: mediatek: refactor parent rate lookup functions
      clk: mediatek: add mtk_clk_id_is_* helper functions
      clk: mediatek: add CLK_PARENT_EXT
      clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro

Irving-CH Lin (1):
      dt-bindings: clock: Add MediaTek MT8189 clock

 drivers/clk/mediatek/Makefile                   |    1 +
 drivers/clk/mediatek/clk-mt8189.c               | 1748 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                  |  273 ++--
 drivers/clk/mediatek/clk-mtk.h                  |   26 +-
 include/dt-bindings/clock/mediatek,mt8189-clk.h |  580 ++++++++
 5 files changed, 2488 insertions(+), 140 deletions(-)
---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260204-mtk-mt8189-clocks-a19de024a48d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

