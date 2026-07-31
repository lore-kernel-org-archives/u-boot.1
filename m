Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF96EC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55E506069E;
	Fri, 31 Jul 2026 17:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iS6iNC4THj-8; Fri, 31 Jul 2026 17:18:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39E1C6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518330;
	bh=lHscpy83G/kaOR1q+D8AxQ0rqwDi56W09Wyksl8Yl0E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f/0Jz/ImVHlc7zzxIop2K5appGuvqXpcP2x1vzaXiUzjNe5hZx16PLie1h+Pwn2Hy
	 Uyf2wdHZrRmMoJaHKC3IqLD0Srx5LBLMUhkdqYiAUE54mwGkx9Uz1xWYDzysD+5eCU
	 rBO1oXb1APtQDd7svTMaprpvAQvAzk+2DsAVn7ygTJGxkJgB20Rqi3x8hIhAZzNJoJ
	 xoG63WtpEGmE4LECOshq0bTqCX+PeXm+zqtSN0KttL4buj7ErvWGdQOQO++bK5gGrC
	 VVi76cCLm+rxjK6oe6HnoghnlbMlmLJmFtRLLaUKz2UMV7nI2PW58gfOrPpLQP1VfT
	 GS2uDgfy1hxQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39E1C6065E;
	Fri, 31 Jul 2026 17:18:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D0E926E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A99360680
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NH842xwQCbRb for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B4CE36067D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4CE36067D
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4CE36067D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:06 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so776274f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517864; x=1786122664;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lHscpy83G/kaOR1q+D8AxQ0rqwDi56W09Wyksl8Yl0E=;
 b=df45UC2734CohLddZ5egXYcqX3STyFLV5xjdn5b/YtxOhv24vT3p88IJ31+Pudf6nS
 kCmOew4iigYuI6qjpGYN6FIbPsXZI8+r6XZ3+Mj8lyWNHPZx9tkiZmXWoFZzk9Z5nqp4
 OOGDhrcHSv3WXRGZreURKGT4K1dTlZReaIuq0nU6FmmJHhwdyDriDUtHaVacoBkgsqTv
 sZdi1OGRpiomaHs9Uz4TNZfRQhIHhg4Z/wJP9KOuMW7HHXEYfoVqDtZXhJevNfcI1gS4
 jR7NtS3SpNpy3HNhm880TIr0c5you4xZbh2YXZsJUvGP9t/Yklce0/H7jXmpvOXRhhPd
 Li8g==
X-Gm-Message-State: AOJu0Yyuqsmv18RQ1o4ODPh2/EMsNNQzRxcGHCFv4YeTgxwq8/Ey/RbH
 PWt2p+6+rlhPrFIvpT5t+aTulzWpJS/AWnANz/CJWI7zON+/GDyGfL90j2OYgw+Ib1c=
X-Gm-Gg: AR+sD11O78iCCW4kH7L+xJMKN/4oVdtvYVshzRwgHH9peCWeXKnL6fzOHgJOzjVRGbl
 9SwcBwiYmX8hErFpl7o+YrJKiwfCd4wIiLk+golhsy0Rm10N+lj9rp3xNpPt69lPe8ila2Rf8YC
 oKyw/e1PVsYltdKRS2WYTEQAmHtmfD5mPMy0lahBd2eRZ2UKVn1mqP8v7KG1YW6Q99P/+vU6HAx
 LYHHsOqtFXWDOnJt4ie74hGZOmJ/JsBU/IJnc1TP+ELBdT4kDpBMciSKuTVVTJludYCpzPjRJe4
 D9tojNozBvI3YVg96WsU4f2wUt4n690gQ0A1WD8JE5xhdGWjDEFbe3omvgN7JpxRAhuDJ2rDIkD
 cyrlrxRrEVwGlGYcY7HyuyJLvl6OvhR6tSceeauaJ4NzDW/6zFI1bhR3UiKdXDxBc55vxBPg8/w
 IX5DwUeb4czqoGfLd1ooqddcreCwKMtzuVyFOE7yT7FnbIoaB2dYxO01VJCM6gISnk3R1yXt6QB
 /95TdOZ4X/jQHQPJhm5t069iXXAsPJu+hfGA6+74Q==
X-Received: by 2002:a05:6000:184b:b0:47f:9171:bca2 with SMTP id
 ffacd0b85a97d-47fd72e9a25mr970626f8f.27.1785517864380; 
 Fri, 31 Jul 2026 10:11:04 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 00/10] spl: Add support for Falcon mode with ARM Trusted
 Firmware
Date: Fri, 31 Jul 2026 21:10:44 +0400
Message-Id: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBQFf4XctTVttfWx8j8MCyincg0ppK1EQ
 /h3AbcuJ5kzZ6KEyEh0LSaKGDlxHxbQu4JcW4UHBDcLk5baSisvospe+KpzfRA4Ad4cG2VhaBk
 MEZ7fW+xe/ji96idcXgur0XLKffxsb6Navb/hUQkpdK2lMzgfrDI33/EwIO4DMpXzPH8BO/QAd
 LgAAAA=
X-Change-ID: 20260609-atf-falcon-e7eef54d16e5
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7703; i=alchark@flipper.net;
 h=from:subject:message-id; bh=og5KejLaUYhKda1LFR7X2xzh+89+9ZYxQmAWKw9H1eQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXJeM36LIIvStd+3F7n8lfMtsL6o1G25gDX62woBnF
 sOrRql/HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1wzRGhh7diCmnst/MyNQK+98fIOTOY/HN/vr27hKDmDOLpZK/nGH47/24i0F
 gl0PCrOpPi5kcGe51/rnKw2+1dGmh2AaBy79XswIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517864; x=1786122664;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lHscpy83G/kaOR1q+D8AxQ0rqwDi56W09Wyksl8Yl0E=;
 b=RsvRplAFrKuuedMY8EqkJBQV9cm2bFmH065j6nrdV0rkYFTHcbtk3QFJWizZSb1Hd9
 vamf2mRObyUKUYKq8TL25fbXH0nk2fOZiKz2Qf/z0BsMFYXV/mvIscKiAzstSj5SJW2R
 0xAer7r5FnflkLkPhOPWQnwbpCHcjdeMcW2hKMyzDAF9MHWgADEirXnBjF5h/k8RgCWm
 UnJn4EWCpDVE7dUZOfrSMfLSRrbfzbavCnAjt6o7ldvSJ/2kkGIU7g01fBxDXG4/KtlZ
 0BadflF3PGYstORA9RiC2NpHz6RmKfcWxWZwF6IXLbpKyaFAAOS/MGsezsNf27II6uko
 0a2w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=RsvRplAF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Some of the modern SoCs such as Rockchip RK3576 require TF-A to be running
to provide firmware services to the OS, and current TF-A loading code in
SPL only supports loading TF-A with U-boot as BL33.

Extend SPL to support loading TF-A with Linux as BL33, and add necessary
hooks to enable this functionality with RK3576 booting from UFS flash.

This has been tested with an uncompressed ARM64 Image as the payload, as
well as with a GZip-compressed one (using existing SPL_GZIP functionality)
with a Zstd compressed initramfs and build-time pre-patched DTB to include
the kernel command line and initramfs location directly into the /chosen
node, on the Rockchip RK3576 based Flipper One board.
Booting this way lets me get from power-on to initramfs in 3.5 seconds -
without any extra optimizations - which is pretty impressive.

Build command is along these lines (native ARM64 build):
$ make -j$(nproc) \
        BL31=~/trusted-firmware-a/build/rk3576/release/bl31/bl31.elf \
        ROCKCHIP_TPL=~/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.13.bin \
        LINUX_KERNEL=~/fit-artifacts/Image \
        LINUX_INITRD=~/fit-artifacts/ramdisk.cpio.zst

Loading a Falcon-equipped usb472 payload via Maskrom directly to RAM is
also possible:

rockusb download-sram u-boot-rockchip-usb471.bin
rockusb download-ddr u-boot-rockchip-usb472-falcon.bin

The caveat though is that the boot ROM checks the download-ddr payload
via an extremely slow (124 kB/s) unoptimized CRC16 routine, so loading
a meaningfully sized kernel and initramfs takes a long time by default.
This can be sidestepped by forcing the CRC bytes in the maskrom 0x472
payload to zeros, which skips the slow CRC16 check altogether. Another
speedup I have identified is to enable the processor's I-cache before
sending the 0x472 payload, which speeds up the CRC16 check by a factor
of 16x, making it borderline tolerable (~20s for my setup).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- s/ATF/TF-A/ throughout (thanks Marek)
- Refactored the common spl-atf code to avoid the global variable (thanks Marek)
- Dropped the misleading reference to U-Boot requiring the CPU MPID in x0
  register, which is not true for upstream U-Boot codebase (nor TF-A) and
  must be a vestige of older Rockchip-specific code from before 2017 when
  the comment was introduced (thanks Marek)
- Added a panic when secure Falcon mode is enabled but the Linux image
  cannot be loaded, to avoid falling back to potentially untrusted code in
  this case. This behavior is also prescribed by the existing Falcon mode
  documentation (thanks Marek)
- Factored out common atf-SEQ sections in the binman template to make them
  reused by both the U-Boot and Falcon mode images (thanks Jonas)
- Added support for multiple DTBs in the Falcon mode image, with the ability
  to select them via existing SPL board hooks such as
  board_fit_config_name_match() (thanks Jonas)
- Added test coverage for newly introduced binman functionality (thanks Jonas)
- Added documentation for the new TF-A Falcon mode support in SPL (thanks Jonas)
- Added support for embedding externally provided Linux initrd
- Added support for pre-patching FDTs in the FIT image with a /chosen node
  to facilitate the creation of a ready-to-boot Falcon mode image without
  extra preprocessing
- Added a caching helper for boot-time Falcon/U-Boot selection to avoid
  mismatched selections during the boot process when the board provided
  implementation of spl_start_uboot() is not idempotent
- Made the default spl_start_uboot() override for Rockchip non-weak to
  avoid relying on the link order, and added a separate board-overrideable
  hook board_spl_start_uboot() there
- Split out binman changes vs. Rockchip-specific image template
- Added a separate Kconfig option to enable Falcon-mode image generation
  for Rockchip SoCs, so that a Falcon-enabled SPL can be built without
  necessarily generating a Falcon-mode image with binman
- Enabled kernel compression support in binman-generated Falcon-mode images
  (using existing SPL_GZIP and SPL_LZMA support)
- Added a config fragment rockchip-falcon.config to easily enable the
  required Kconfig options for Falcon mode support in SPL and binman
- Link to v1: https://patch.msgid.link/20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: João Marcos Costa <joaomarcos.costa@bootlin.com>

---
Alexey Charkov (10):
      spl: Decide about Falcon mode boot only once
      spl: atf: support Linux as BL33 with TFA
      spl: ufs: add Falcon mode load path
      binman: Add support for externally provided Linux kernel blob
      binman: Add support for externally provided Linux initrd blob
      binman: Add support for pre-patching FDTs in a FIT with a /chosen node
      binman: tests: Add test coverage for a FIT with embedded Linux+initrd and /chosen
      rockchip: spl: default to Falcon mode boot in SPL if enabled
      rockchip: binman: Add support for Falcon mode FIT images with TF-A+Linux
      doc: falcon: Describe booting the OS through TF-A

 Makefile                                       |   2 +
 arch/arm/dts/rockchip-u-boot.dtsi              | 204 +++++++++++++++++++++----
 arch/arm/mach-rockchip/Kconfig                 |  49 ++++++
 arch/arm/mach-rockchip/spl.c                   |  29 ++++
 board/rockchip/rockchip-falcon.config          |   3 +
 common/spl/Kconfig                             |  45 +++++-
 common/spl/spl.c                               |  18 +++
 common/spl/spl_atf.c                           |  49 ++++--
 common/spl/spl_ufs.c                           |  58 ++++++-
 doc/board/rockchip/rockchip.rst                |   9 ++
 doc/develop/falcon.rst                         | 131 +++++++++++++++-
 include/spl.h                                  |  11 ++
 tools/binman/entry.py                          |   8 +
 tools/binman/etype/fit.py                      | 103 +++++++++++++
 tools/binman/etype/linux_initrd.py             |  23 +++
 tools/binman/etype/linux_kernel.py             |  22 +++
 tools/binman/ftest.py                          | 107 +++++++++++++
 tools/binman/missing-blob-help                 |  10 ++
 tools/binman/test/fit/fit_chosen.dts           |  62 ++++++++
 tools/binman/test/fit/fit_chosen_no_initrd.dts |  60 ++++++++
 tools/binman/test/fit/fit_chosen_no_load.dts   |  57 +++++++
 21 files changed, 1007 insertions(+), 53 deletions(-)
---
base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
change-id: 20260609-atf-falcon-e7eef54d16e5

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

