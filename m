Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB5CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 11:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD65846E2;
	Thu, 28 May 2026 13:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="d5/qFFPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF3A846CE; Thu, 28 May 2026 13:49:11 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B3680398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260528114907e5b64cd8d50002078d for <u-boot@lists.denx.de>;
 Thu, 28 May 2026 13:49:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9nrwwS+ej9EULojR01xD8m/CqsCrFHccqP8YAHNCARA=;
 b=d5/qFFPXR8UgNvp4a2dPnog8MvptQfbfU8wdWdUpOt0ITZtitaoFNdYbrRnXIUSNUN5glN
 x9YfuHr1KZv42OGBY8XlsjtnTC/TBrTSmeQTWkKV7xaAslKmsmMcnmVMajdlrjPOsTToo4xF
 m4fdhUCv4T3KJ/srtd7PVIFaQrKyK/GmFjzFyAqpnQrKd9Ws3fnl0RNitF95IRmRZWomPAxB
 wqL3HPmrisEgJNymKlUD8LtL63ck+Mco+gfO7hB+hDmpkvz3oZLZopBTedNY2IAVQsXpD0QW
 IG9GN0VS8qj6MDErPWQcufXiz0NKbhlS6sUJnwOdXepQVemHdbz3kXyg==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal
 <anshuld@ti.com>, Ferass El Hafidi <funderscore@postmarketos.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Raymond Mao <raymondmaoca@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Shiji Yang
 <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Wolfgang
 Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 0/7] Improve FIT signature handling
Date: Thu, 28 May 2026 13:47:56 +0200
Message-ID: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

This patch series tries to improve dealing with FIT
(configuration-)signatures a bit:
  - make signatures work with QEMU. QEMU brings it's own device tree at
    a memory address. U-Boot expects public keys in it's own DT though.
    So merge both.
  - (optionally) enforce signatures so we can't accidentally boot
    unsigned fit images. Quite an easy oversight, esp when qemu
    previously didn't even use the built in DT.
  - make iminfo verify configuration signatures, not just image hashes

Changes in v5:
- refactor ubman.config.buildconfig access
- reword commit message to mention disabling of pre-load global
  signature test
- rely on inline dummy for fit_all_configurations_verify
- use CONFIG_IS_ENABLED(FIT_SIGNATURE) to guard fit_all_configurations_verify
- print warning if /configurations node is missing
- print "OK\n" in fit_all_image_verify()
- use helper function shared with bootm
- introduce assert_fit()

Changes in v4:
- mention arm in subject
- correctly change defconfig
- fix and reword comment
- reword Kconfig help text
- rename option to FIT_REQUIRE_CONFIG_SIGS
- introduce SPL_FIT_REQUIRE_CONFIG_SIGS
- test CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
- set CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig
- fix documentation to use kdoc style
- test iminfo in test_vboot

Changes in v3:
- enable CONFIG_OF_OMIT_DTB=n in defconfig
- add error returns
- document decission about dt merging direction
- make log_err use stdout too
- clarify error message when no keys were found
- change printfs to log_err
- reword Kconfig
- keep FIT_SIGNATURE_REQUIRED off by default
- use log_err instead of printf in fit_config_verify_required_keys()
- don't make iminfo fail unless FIT_SIGNATURE_REQUIRED is set
- update fit_all_configurations_verify documentation
- stub fit_all_configurations_verify unless FIT_SIGNATURES

Changes in v2:
- introduce FIT_SIGNATURE_REQUIRED
- document fit_all_configurations_verify()

Ludwig Nussel (7):
  qemu-arm: merge built-in DT
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
  iminfo: also verify signatures
  test: vboot: refactor run_bootm
  test: vboot: add iminfo checks

 board/emulation/qemu-arm/qemu-arm.c |  47 +++++++-
 boot/Kconfig                        |  22 ++++
 boot/image-fit-sig.c                |  22 ++--
 boot/image-fit.c                    |  55 ++++++++-
 boot/image-pre-load.c               |   3 -
 cmd/bootm.c                         |   8 ++
 configs/qemu_arm64_defconfig        |   1 +
 configs/sandbox_noinst_defconfig    |   2 +
 include/image.h                     |   8 ++
 test/py/tests/test_vboot.py         | 171 ++++++++++++++++++++++------
 tools/mkimage.h                     |   6 +
 11 files changed, 294 insertions(+), 51 deletions(-)

-- 
2.43.0

base-commit: 7a2caf07d7db4803d2c5738a85b20043066d958b
branch: us-qemu-signatures5
