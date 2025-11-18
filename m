Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF648CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970AB83D07;
	Tue, 18 Nov 2025 14:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XbT7NsKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5116B83CE8; Tue, 18 Nov 2025 11:42:15 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A04383C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so8579763a12.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462532; x=1764067332;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B12UR3dsnaguruwttbeog3XD57O9eEvKoEDP3MEeu0I=;
 b=XbT7NsKtnrxXm/HiDQMp7NX9cjXRLACKje8EnCIvAqrnn22H/xwEwuNQrpFwK1H4pB
 SUlBOKNqWq/KeKAlmAdyOMFhC104Kp8e/1O6NREk3qfqSimWKIegGEtLWNBXf6Tdm9w+
 pDuhUnjJwb+Hzwrn6/eW7Gnay1U6CdCvlPUtgi8fDaXREI6lBd77upKmr0XFIVaPsQoJ
 f6Rf4AIIB3oua767qHxvP1IfIAo2jBW67b930Esa+bHTGwFo/ySeUcdg6CknikSha4ap
 ateXxBVhis0AVFkQllvHeb59bSMgYuOCjigluT69vDYmeDQV3lpfbu79Qk2WP98X39Cx
 rkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462532; x=1764067332;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B12UR3dsnaguruwttbeog3XD57O9eEvKoEDP3MEeu0I=;
 b=Y86rls5ECTZ1kDFvkn3/wQkadjjIHfdtxjZGy3mtB6TPWHwVX1UfJ/DlmaaMs2/rsV
 kss84RYdCtmmGYqjkQOWVicu1zFij7xStm3Ty5i16cAG8wapVUlTGosKPtYZoLIFI73l
 MHh5jBnmjvchYXVs5wAlNvWD3ecxQmmJtGcShvW6KxsKn1fCa50H3xznQtnleORFKZ6i
 I1GX4BiBfiOz5ZfS+NliYZpGlopZBbbT752waMsaaeYiIxrvHQF6ShvKSF+TnCeZYaOX
 aVUJzckCZXJBTVxXeXnyzFZQvrJ66BGO4xiLtgkuUsYSG3vzree3QqKgnjP81YXZ82Rq
 pmvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqdrY7ASSUtfFJImpjmPQzgfoyP2N5Nme0GldkidJSSITq8abVXlx1/J2NTteL6fHSjAhiiA=@lists.denx.de
X-Gm-Message-State: AOJu0YzE3NRGhzid203C6XjcO5BLAZJn8jMeCYpLqyetgzxhDDvCE0zq
 zRxdATMoQ9MZYSfEy4+Ek/zVMBYv9aRamVx2I3NlLijtkdETgA0UoL513YrJaj2GKmQ=
X-Gm-Gg: ASbGncuNyNh5mNUpN4xIsBLezyPmT5CjKJdHLBd+bhVEdJK0gDt0Wzjxd+kBMiZ/bAx
 6BECaVM9Tifm8mGkfwagp3SFBLUvxd4dFnnvyMA52uq0u7UZSJh0uL+Tf6GmhJNynlFLoWFHzsD
 56Q8ht7zPHLuqy7V72eHv5vWn7QtRbx/zuSCG5HMcbGoe6d6fNCDIxL2gEYYfbZoRonxl4WvV9B
 kcROilyzRpHgV+dMnnE7WLY/Y1la4EWO1RYTz8Lv+J7vjh6rmyIesJlR5CYfxk3wKUy+k+N16H5
 7Cn7IE7uNSbS9AEn/IFqmcsZ7TTQDTMDCIlJuzbEY3Xzbp2qzDajFIuA567t6QyZwYKfcCt9r4b
 MXdXGjuAyvam4Hmumzc6ZngmRym6KvvImrDUcZ7TxjlnSW4dkJJ5pwCKgLNPlhnUmmHL2EGFXb+
 Mk5PoYE5U=
X-Google-Smtp-Source: AGHT+IHP30JqIb+XIU6L1oIvOQKB095AIQZ0l1SKZcvCaZBnVFuEnOJIsPZmJw8BpevmxWh6KFE+zw==
X-Received: by 2002:a05:6402:5188:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-64350e899a3mr12879081a12.21.1763462532524; 
 Tue, 18 Nov 2025 02:42:12 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6433a3f8767sm12633292a12.9.2025.11.18.02.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:11 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH 00/15] arm: am335x: Switch to upstream devicetree
Date: Tue, 18 Nov 2025 11:40:20 +0100
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVNHGkC/x2NwQqDMBAFf0X23IWswVb6K6WHEF/aPSSRRIIg/
 rvB4zAwc1BFUVR6DwcVNK2aUwd5DOT/Lv3AunSm0YyTiMy85VU9u2gto0XOYSsAt+6fbIThXkZ
 gbJh9oB5ZC4Lu9+DzPc8LmMJ4iHAAAAA=
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3969; i=msp@baylibre.com;
 h=from:subject:message-id; bh=HbgGrx4HdC4vRnkp+UsASe4AiS9Oaeu0irH6KeqvEuc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX313tQllr1vM70d6RJrmLXrL2LlVT3xL8tzHPX9Cr
 jt+cDTqKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIncbGP4ZxLn8MpO9PtG03nn
 JTadSlOIbPmduCMpSY5bp/rpG4PoLIZ/Ou+3HNcIm374scutNMl5/2fyHHh9xXWqi+Zj7SqXii+
 T+QE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

The series is split into two logical groups:

- Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
  with the current u-boot devicetree.
- Patches 5-15: Make upstream devicetree working with uboot. This
  touches different areas, power-domain, USB and simple_panel/ti-lcdc:
  - Upstream DT uses simple-pm-bus a lot instead of the simple-bus that
    is currently in use in u-boot devicetree. To support simple-pm-bus,
    power domain support has to be added which required me to add a stub
    driver for PRM to implement a of_xlate function that does not accept
    any arguments. Also I had to make the clocks in the uboot
    simple-pm-bus driver optional.
  - USB in the u-boot devicetree is using a wrapper driver binding to
    ti,am33xx-usb that creates new devices bound to a host or peripheral
    driver depending on the dr_mode property. But that does not exist in
    upstream devicetree.

    Current uboot devicetree:
      usb: usb@47400000 {
          compatible = "ti,am33xx-usb";
          usb0: usb@47401000 {
              compatible = "ti,musb-am33xx";
              dr_mode = "otg";
              ...
          };
      };

    upstream devicetree:
      target-module@47400000 {
          compatible = "ti,sysc-omap4", "ti,sysc";
          usb0: usb@0 {
              compatible = "ti,musb-am33xx";
              dr_mode = "otg";
          };
      };

    To solve this I chose to use the compatible for both drivers, host
    and peripheral and return -ENODEV if the dr_mode property does not
    match the driver type. This required a slight adjustment in the core
    probing mechanism.
  - And last I ported the hardcoded panel settings from Linux
    simple-panel driver to the u-boot simple_panel driver. I also added
    support for the simple_panel to ti-lcdc.

The series has been tested on am335x-evm. This series should make it
much easier to port other am335x boards to use upstream devicetrees as
well.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (15):
      board: ti: am335x: Fix DM_TPS65910 condition
      arm: dts: am335x-evm: Add backlight to the panel
      arm: omap2plus: Select REGMAP
      configs: am335x_evm_defconfig: Enable panel
      simple-pm-bus: Make clocks optional
      power: domain: Add ti-omap-prm stub
      arm: dts: am335x-evm-u-boot: Add chosen tick-timer
      dm: core: Support multiple drivers with same compatibles
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree binding
      video: simple_panel: Add tfc_s9700rtwv43tr_01b
      video: ti: am335x: Support OF graph
      configs: am335x_evm_defconfig: Switch to upstream devicetree

 arch/arm/Kconfig                    |  1 +
 arch/arm/dts/am335x-evm-u-boot.dtsi |  6 ++++
 arch/arm/dts/am335x-evm.dts         |  3 +-
 arch/arm/mach-omap2/am33xx/board.c  | 16 ++++++----
 board/ti/am335x/board.c             |  2 +-
 configs/am335x_evm_defconfig        | 18 +++++++++--
 drivers/core/lists.c                | 62 +++++++++++++++++++------------------
 drivers/core/simple-pm-bus.c        |  2 +-
 drivers/power/domain/Kconfig        |  8 +++++
 drivers/power/domain/Makefile       |  1 +
 drivers/power/domain/ti-omap-prm.c  | 36 +++++++++++++++++++++
 drivers/usb/musb-new/ti-musb.c      | 36 ++++++++++++++++++++-
 drivers/video/simple_panel.c        | 48 ++++++++++++++++++++++++----
 drivers/video/ti/tilcdc.c           | 46 ++++++++++++++++++++++-----
 14 files changed, 229 insertions(+), 56 deletions(-)
---
base-commit: 365a7079fb918643da0f0709660a7d8ea76dd6f3
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

