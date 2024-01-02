Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B72C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9595887906;
	Tue,  2 Jan 2024 16:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EP7l99Cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AC1878FF; Tue,  2 Jan 2024 16:47:05 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F59876C0
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59446cd46e9so4501308eaf.3
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210421; x=1704815221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OEP8aPGLomnQRqIX9ME4ZGP8Lf1M4kcuk6jNJuI9PQ8=;
 b=EP7l99Cp7j4caMkT7+YwWnVm8V/IBpGWMd6e9ql8TM1jMid3/Kgo8EPw7QdtwbHCvo
 GiZkiBqnWqaz0NO3ie9CORLPkXWQydzHpQE9DE4NmqwnXPzmowXoX0/T7743RldBoFIH
 Vh/D2nRgV/a7gndYIBs45QMl7irY/bfCf/4QAwFR1JbScLaMqZXyxcfG6xCeSImiHehk
 1z8nHWdTMychDumXrf0FSCpUEVwuZefvTfkEb5YwqgxMwcKRXE8ioSbK56ul4RRfHnyU
 nIRlKzl3I6h/XTQ79iJbWFOxIBsoz5fTTlMsK88cmoVLG2qdKFyWy1JH97r/f61MXqBQ
 fFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210421; x=1704815221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEP8aPGLomnQRqIX9ME4ZGP8Lf1M4kcuk6jNJuI9PQ8=;
 b=Djzl3lgSuWNKesSjhr3xbUNo1tMUZLMEyHftIb3ixWQjFiPROCefI7dW2NxzNCRVCS
 xAQAhsQJ0PJGsnmDo03fPThfoCIzpczPeeQTVnrYV1yRQnsT7YYqHSygi8X6n/FmNma+
 qfWyqymnRKx02QnyLdoWgQavW16BcSh5t1gmj80CjKT70UIBOyIIIazvZ3ZLnnpBYo0U
 H8Mp/aGJ/sLdDkIERSykZiinKs/JBuKVAetIn7kuy1kHSAlsNn2iFcydK099+9v9xbuD
 H5dKkNtm8NNMUTENCN/vbl4ca1MeDFnd9jgyUZirIWQ52scYoAE0yYB/4knsGPxYyMZw
 oUDQ==
X-Gm-Message-State: AOJu0YyRo3OUf2JroKnDleGl0oMTq3/b5Nx1yWIo6ugR/UoiXXx+U7iO
 s7mCawCAnmHt3X73OkT7zf1ZZMMGUg9YOQ==
X-Google-Smtp-Source: AGHT+IGJqPwS7TX1uN48RkHdKtqQr/6IB6ArRUUfUn2AgIkVqumTV0XwY5B38x82x0wfKwsIFEdkXg==
X-Received: by 2002:a05:6820:1687:b0:590:8217:b060 with SMTP id
 bc7-20020a056820168700b005908217b060mr9154088oob.12.1704210421263; 
 Tue, 02 Jan 2024 07:47:01 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:00 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 0/7] Add Additional Boards and Features to RGxx3
Date: Tue,  2 Jan 2024 09:46:47 -0600
Message-Id: <20240102154654.191055-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chris Morgan <macromorgan@hotmail.com>

The RGxx3 is a pseudo-device for U-Boot that works for every Anbernic
RGxx3 series device on the market. Add support for another series of
very similar devices from Powkiddy.

Changes since V3:
 - Fixed a bug with else/else if logic for board detection (changed
   a second incorrect "if" to the proper "else if").

Changes since V2:
 - Modify the mach-rockchip level rockchip_dnl_key_pressed() so that
   we can also call it in SPL mode and eliminate the board specific
   function. This requires adding ADC support to SPL. Additionally,
   I had to change the regulator for the saradc to a fixed regulator
   and add GPIO and regulator support to SPL.
 - Move the board specific board_rng_seed to the mach-rockchip level
   board file so that other rockchip boards with a hardware RNG can
   benefit. This should only be called if both the Rockchip
   hardware RNG as well as the rng seed functions are enabled.
 - Add two new boards (the RG-ARC-D and RG-ARC-S). I removed the
   previous code review due to the extensive changes made.

Changes since V1:
 - Update verbiage around function button to say "recovery" mode
   instead of calling it "maskrom" mode, which has a specific
   meaning. Also note that recovery function was done in a board
   specific manner to ensure it can run early.
 - Update board level documentation for the RGxx3.

Chris Morgan (7):
  board: rockchip: Refactor panel auto-detect code
  spl: Add Kconfig options for ADC
  rockchip: boot_mode: Allow rockchip_dnl_key_pressed() in SPL
  board: rockchip: Add Recovery Button for Anbernic RGxx3
  rockchip: board: Add board_rng_seed() for all Rockchip devices
  board: rockchip: Add support for new boards to RGxx3
  doc: board: anbernic: Update rgxx3 to add new boards

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  11 +
 arch/arm/mach-rockchip/Makefile               |   4 +-
 arch/arm/mach-rockchip/board.c                |  32 +++
 arch/arm/mach-rockchip/boot_mode.c            |  11 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 194 +++++++++++-------
 common/spl/Kconfig                            |   7 +
 configs/anbernic-rgxx3-rk3566_defconfig       |  16 +-
 doc/board/anbernic/rgxx3.rst                  |  20 +-
 drivers/Makefile                              |   1 +
 drivers/adc/Makefile                          |   2 +-
 include/configs/anbernic-rgxx3-rk3566.h       |   2 +
 11 files changed, 210 insertions(+), 90 deletions(-)

-- 
2.34.1

