Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C777D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8032845BE;
	Fri, 28 Nov 2025 15:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bcb+4dpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C67844E3; Fri, 28 Nov 2025 11:17:23 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E69583B9B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso926386f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764325041; x=1764929841;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IbKKb/jZ8vjLXiQlTQK9uKl3haK87cL97um6gT1c7+Y=;
 b=Bcb+4dpYUqsEBC+NQ2JSLk2y06EZobQlfcAurqDQdE0/l7Yf5ogSm1pZg8soyFOZOb
 HxEzvwtcg9Clx9MMviNa6KboSKgvx791FPA3pxDS9ch9SurbuL3bduICXw/HvIUzPwv+
 1T+dj5hynBOzqav2Fyw18UupyPMMzdAOqyMvPdyXmMT5aYEo+bziVZ1/Sovl8kgjOY5e
 RC00v8/XlEafr5YCTLTSlulBQhRPT6oceTSw81QO6ZGmsKRud+Mh+d4HPpfuc6MAPGfZ
 WFWEm1Ij5H+qtLXgkrdIUmrzRNs1VOltE2DA5lPUmDGQegluxUrfCu27IUQgV7nFMALY
 EVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764325041; x=1764929841;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbKKb/jZ8vjLXiQlTQK9uKl3haK87cL97um6gT1c7+Y=;
 b=k61fJ6Ax/Fs8uHDB0msmSXDsZhuiACl5cEj9sJF/xCoPKHm4kH6erMRnQ5TstQXCzY
 GQWQtx8bTtqh2IQK6EFJuTV6RIPVl+8EzzxJWjdmcY2UcHSWIet407tInEaP6amHiAMD
 kqL+dPODLdd3WR8rFXJ2aMpNPhJLjLdIZxWQAvhZOWja0eu3LXzkJ+0PrKoitSlfWz1g
 +S5rS/+o3P0Vkz/eU2J/QAitllfYJp/cHWOivZFo+/jkK9H+V923LGXfkX6oOLKg5Z/u
 hCz4vKlmZtR3pyhUJT/c69mbh2JZfZ/HkPkNM7ZUvi0dTX63w3D+2TS9ikCugP+U9sOf
 E0Fg==
X-Gm-Message-State: AOJu0YyfIP77rAn9CYwwZ3RU4M6Ag9jgFMyJIcyj9UT1IkK9278hspGs
 o/qiLdrfZAT3or8tDuSeNLqbpvmAVX6+Zvl1qCcjVE4IGJqoyjuC/h69seUSi8t+mhU=
X-Gm-Gg: ASbGnculX/MaiIlIKG5v/w0aFgNc2BUXSrsjZPZ8XujRao+aBydQOSQUajm2yquGGin
 2wHOMLmQ+MngMX8qncPmmTX69Dscy2jXu8kUsjdPPzexm4VocwH7bqn/SzezO1BxG8jX+IQuSib
 RKDnHjMUd5X+XsvZzy/aj0RUe6ZsmqcGddxjzReSyZXUWIq5VuhADVf0hEyvBoSYF8VPyXO7X6k
 ycc7FHYfWrplmRFw0lNszS7GH32damtBB0eZ1mChlr7h1B9a4z0ZH0ftKmnutwC/G3meE6nv43M
 BzjtJyQSi/7HKrKXCtnh7ffW+MpEsNKQrEIbTIiCrtOWAwq3JgrSxHQ/sjJJLF6TijIwl/TfDOm
 +keX4Es/6As+MvvwHG2WGhjYrTpOrdWZfIHVEO41H6nCXmj+8ph+SxXEPuQ4dnF4oxddVJrYc2q
 /PaRR6RZ4=
X-Google-Smtp-Source: AGHT+IE0HS4Ruahke+6EYU5sJM2LP1dO4LWd9l4H0C0/vx0/BqhlhDMy8qnmja5SCUgpfavU+hTSqA==
X-Received: by 2002:a05:6000:438a:b0:42b:3746:3b67 with SMTP id
 ffacd0b85a97d-42cba7c4d0dmr35477359f8f.25.1764325040879; 
 Fri, 28 Nov 2025 02:17:20 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1c5c3c8csm10837543f8f.2.2025.11.28.02.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:17:20 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH 0/2] clk: ti: Cleanup common functions and omap-cm
Date: Fri, 28 Nov 2025 11:16:58 +0100
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJt2KWkC/x2NwQqDMBAFf0X23AWzQWn7K6WHbfJql1YNiUhB/
 HeDx4FhZqOCbCh0bzbKWK3YPFVwl4bCR6cBbLEySSudc9LxMicLrKP3HH5fzhhGTRyReK1Oz61
 j6a+i/vYColINpYy3/c/J47nvB8A0xN10AAAA
X-Change-ID: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, 
 "Andrew F. Davis" <afd@ti.com>, 
 =?utf-8?q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@nabladev.com>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Adam Ford <aford173@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Thomas Weber <weber@corscience.de>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 "Derald D. Woods" <woods.technical@gmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Tomas Peterka <atheiste@seznam.cz>, Anurag Dutta <a-dutta@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I4ryOnbifN6M1+ydU1oq7metVfOSCU22zbbJlf9BLb0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNsnn/Xn7/Xjm1Y0LpFbW46XaLJ5lNfqt9zLjjT/4NW
 SfH2Uf+d5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEtu5l+Ge65qXkN6/u5VGN
 +1fYpD5lXPe4gU2Wy3j5LEW7zelxfmKMDA+XfJjPmpK6obdS48YPL11BL24nwd2rzuSsu/us82b
 aTx4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

Hi,

this series cleans up the direct dependency of ARCH_OMAP2PLUS to compile
ti/clk.c which holds common functions for other clock drivers. It
creates its own config symbols for these common functions and for the
omap-cm driver as well.

The omap-cm driver config symbol is added to all defconfigs that
need it.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (2):
      clk: ti: Split common omap2plus functions into new symbol
      clk: ti: omap4-cm: Add Kconfig symbol

 configs/am335x_baltos_defconfig           |  1 +
 configs/am335x_evm_defconfig              |  1 +
 configs/am335x_evm_spiboot_defconfig      |  1 +
 configs/am335x_guardian_defconfig         |  1 +
 configs/am335x_hs_evm_defconfig           |  1 +
 configs/am335x_hs_evm_uart_defconfig      |  1 +
 configs/am335x_igep003x_defconfig         |  1 +
 configs/am335x_pdu001_defconfig           |  1 +
 configs/am335x_shc_defconfig              |  1 +
 configs/am335x_shc_ict_defconfig          |  1 +
 configs/am335x_shc_netboot_defconfig      |  1 +
 configs/am335x_shc_sdboot_defconfig       |  1 +
 configs/am335x_sl50_defconfig             |  1 +
 configs/am3517_evm_defconfig              |  1 +
 configs/am43xx_evm_defconfig              |  1 +
 configs/am43xx_evm_qspiboot_defconfig     |  1 +
 configs/am43xx_evm_rtconly_defconfig      |  1 +
 configs/am43xx_evm_usbhost_boot_defconfig |  1 +
 configs/am43xx_hs_evm_defconfig           |  1 +
 configs/am43xx_hs_evm_qspi_defconfig      |  1 +
 configs/am57xx_evm_defconfig              |  1 +
 configs/am57xx_hs_evm_defconfig           |  1 +
 configs/am57xx_hs_evm_usb_defconfig       |  1 +
 configs/brppt1_mmc_defconfig              |  1 +
 configs/brsmarc1_defconfig                |  1 +
 configs/brxre1_defconfig                  |  1 +
 configs/chiliboard_defconfig              |  1 +
 configs/cm_t43_defconfig                  |  1 +
 configs/devkit8000_defconfig              |  1 +
 configs/dra7xx_evm_defconfig              |  1 +
 configs/dra7xx_hs_evm_defconfig           |  1 +
 configs/dra7xx_hs_evm_usb_defconfig       |  1 +
 configs/draco-etamin_defconfig            |  1 +
 configs/draco-rastaban_defconfig          |  1 +
 configs/draco-thuban_defconfig            |  1 +
 configs/igep00x0_defconfig                |  1 +
 configs/omap35_logic_defconfig            |  1 +
 configs/omap35_logic_somlv_defconfig      |  1 +
 configs/omap3_evm_defconfig               |  1 +
 configs/omap3_logic_defconfig             |  1 +
 configs/omap3_logic_somlv_defconfig       |  1 +
 configs/pcm051_rev3_defconfig             |  1 +
 configs/phycore-am335x-r2-regor_defconfig |  1 +
 configs/phycore-am335x-r2-wega_defconfig  |  1 +
 configs/pxm2_defconfig                    |  1 +
 configs/rut_defconfig                     |  1 +
 configs/sniper_defconfig                  |  1 +
 drivers/clk/ti/Kconfig                    | 17 +++++++++++++++++
 drivers/clk/ti/Makefile                   |  4 ++--
 49 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

