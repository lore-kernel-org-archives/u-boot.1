Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C422FFED2C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 04:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FBF83F75;
	Thu, 12 Mar 2026 05:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPf38SCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9BD83FED; Wed, 11 Mar 2026 20:39:36 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9FE83FDB
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 20:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso1864675e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773257974; x=1773862774; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lZkxqUuUbJ4Vbj2riO1raVFqanxfpUss3tcQOFPsGhg=;
 b=GPf38SClVQM9jO3UwNpwKmm8qDrbt9rDFE4o4MMAfipFQ9ohxh08X144XUa+h+Mi87
 g0QVtfUDWqGfkh6eWALSpEmESHDtcstZ9o55p+XH3U1q2VfF+QqktuMiY+mZ/15qPk6E
 F2rKO0hhOmmiWV6juzYwo34XzDMehAqqtKbvU05LKoZpjqVV0XhZ8S8/Y9qSo+F2JIDj
 GYZkSjqYBLIZkZ3wygd5+KTsckFSjoPmNG+H2xhmFFoF8i2puKRzod7BGYld/gSXHQtj
 dGiMdgp4HSdq6VT3BV94d/4QJEkR9ODT9eaJGApjYLiZuE9KtLGGfwHIo7fheWI9Yq/j
 94oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773257974; x=1773862774;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZkxqUuUbJ4Vbj2riO1raVFqanxfpUss3tcQOFPsGhg=;
 b=Vh2vKFEze6f5V3qIR7cLjPzOkuYEni1Lt38pk1MpJxMyu+21sUOS4BgCAzlZT+CKXr
 5GUmgIJWrh9m25tjQ+VSSXN15oVnWKwtTcKfciqoYmeeVgu9sMGaPJqYDk2Z+wW98z4e
 CzHYkDvLJrNAM2YSq84SzY5hgx34/MwRXrR3K9apsTSkVGj8V37O6m1v15rTkJSHWHSB
 aKXnStmwls7o/+hHJYRWRJw1eodtyJvYo1QONNUt6WbWDFLA5z9NPGcADxFD6m+n1+vX
 EI10r7bsj1mhtaXQDKMpfWiqdXlzcaBYE+k7+zWYy0nPTHlGrDBvnBdjPmQAWez4Vt76
 Y18Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyFH7Jgw0FmKcGVZnMFjULVoxr9HLjbp3fNdKtmiwaRpT1Ra869FI5YUoBtX4XEco/Ms+SjM0=@lists.denx.de
X-Gm-Message-State: AOJu0YxfbYfzSB4fEK1X88zxXH/bHDhja1u1SAyKOBCy05BpgVKVXoel
 uufJV5hPGQjSac3ifO5bQvnk1VI24EvE6VSxkLJL5rK8ajYysRWXel/KA6vRMgjxXMs=
X-Gm-Gg: ATEYQzyjWjMGpsjsX94CzGVmqajpokof3Ztc9XGTxuFJ4i1s9vtiprAETRV/OOddalY
 x1ePHNtENBVnQzC3qUuARnaCRwU7a+T2HCtITEjme7FtatnCFyBss1QSZquPPzhYMoRYhcVKx/N
 CK/WDwigFuEB9QCR6VXSPPB0vo3NrPvtausqQ9OGR17/1FrMetyfrNZJ/AqY7d/jpVVXEm8TG4M
 Z2BWlqdNB2g21TbRgor55iM0bdA1bar2KZb8YplmKwX0EnOBPFz3eZ9D5tfokYYeQZbX94FJscJ
 yvA39HV2RxS7mNzXdSvBmIns+C34s7Bt27vwAze5VatEJxcoBnMACb0Z//jB94QGZ4hgjqEwCaX
 99hzqrYxkzxto7TdlGbRW7Z/lCrEsHswj7f0kV4F5hOj5V4YOUKyoXJ9UVorDOYFNYiF+Gjcnq0
 ID46rwJJVrmUXnDIKvtHeEYyuTAnyk
X-Received: by 2002:a05:600c:4e56:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-4854b0fafb9mr59007345e9.22.1773257973713; 
 Wed, 11 Mar 2026 12:39:33 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0d4a37sm24019345e9.20.2026.03.11.12.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:39:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:39:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Anis Chali <chalianis1@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Yao Zi <me@ziyao.cc>,
 Yegor Yefremov <yegorslists@googlemail.com>, Ye Li <ye.li@nxp.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 0/4] u-boot: add SCMI GPIO/Pinctrl support
Message-ID: <cover.1773256350.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 12 Mar 2026 05:08:48 +0100
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

There is an existing SCMI pinctrl driver in drivers/pinctrl/nxp/ which
lets you configure the initial state of the pins via device tree.  This
patchset is a more generic version which provides GPIO as well.

I wrote two small cleanup patches to the NXP driver, one which renamed
an enum and another which made some white space changes.

The next patch adds an pinctrl driver which lets you configure the
initial state for the pins.  But the main thing is that we need one
driver to handle the SCMI pinctrl protocol so the pinctrl driver does
this.

The last patch adds GPIO support over SCMI.

I tested this code using the SCP SCMI server on OP-TEE over Qemu.  I
created a custom mock pinctrl device in SCP.

Changes since v1:
Address Peng Fang's review comments.
Use the standard gpio-ranges to describe the pins instead of
inventing a custom format.

Dan Carpenter (4):
  scmi: pinctrl: add pinctrl message IDs
  scmi: update comments for scmi_pinctrl_config_set_in()
  scmi: pinctrl: add pinctrl driver for SCMI
  gpio: scmi: Add gpio_scmi driver

 drivers/firmware/scmi/Makefile            |   1 +
 drivers/firmware/scmi/pinctrl.c           | 365 +++++++++++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c |   4 +-
 drivers/gpio/Kconfig                      |   6 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/gpio_scmi.c                  | 248 ++++++++++++++
 drivers/pinctrl/Kconfig                   |   9 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    |   2 +-
 drivers/pinctrl/pinctrl-scmi.c            | 365 +++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +-
 include/scmi_protocols.h                  | 379 +++++++++++++++++++++-
 12 files changed, 1371 insertions(+), 12 deletions(-)
 create mode 100644 drivers/firmware/scmi/pinctrl.c
 create mode 100644 drivers/gpio/gpio_scmi.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

-- 
2.51.0

