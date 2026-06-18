Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B78CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59C7849E5;
	Thu, 18 Jun 2026 15:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="q046aD/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841B0849CA; Thu, 18 Jun 2026 15:09:49 +0200 (CEST)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20619849AA
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20260618130946a7cc759fd500020755 for <u-boot@lists.denx.de>;
 Thu, 18 Jun 2026 15:09:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bW43M2vBW8Hr7bf0Drc0fPLrTy/rarX0rNDpe6E8JsI=;
 b=q046aD/e0bSGClmVlbHNbE9vYwZsyKCsWBtWXXchAfr+UzWzNx8luGYs9nPTAwbpeH4vm9
 s5+pPN8gRYTosqZ8bfF3d1ic/jxaBWbdd4dBdsge+GD0bGnQ1lx8aXqDWs1S+D95A0Nz9oRw
 NVZ5ftzE699Yye6Xlb8AWOudh8vp5Hu/E1zb0onXLNi0ZQfyq20k8JSODOZvV/EdgWq5fSR6
 whivpk8D4wDABUpMO3L5DkF9uaLabueiWueY9gHfH4oPcJ/OH6Py+JgNsqn18fZ7nItHC+Ih
 12n2K1vPSkJZa2OXddP08peLBDZ2GEm8Ma8vQs7S0uabGpwAmnX0VGkA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal
 <anshuld@ti.com>, Enric Balletbo i Serra <eballetbo@kernel.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Stephan <jstephan@baylibre.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Shiji Yang <yangshiji66@outlook.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v7 0/8] Improve FIT signature handling
Date: Thu, 18 Jun 2026 14:47:35 +0200
Message-ID: <20260618130943.549083-1-ludwig.nussel@siemens.com>
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

Changes in v7:
- add guard for OF_LIBFDT_OVERLAY

Changes in v6:
- fix comment style and typos
- fix error message
- return error from board_fdt_blob_setup() if dt couldn't be resized or
  merged. Unfortunately fdtdec_ret_to_errno() is static elsewere so
  -EINVAL has to suffice
- mention CONFIG_OF_OMIT_DTB in commit message
- move 'ret' declaration to top of block
- Add missing return value documentation to run_fit_commands()
- use f-strings for the refactored code
- drop not needed length check for command list
- remove superfluous blank line

Changes in v5:
- refactor ubman.config.buildconfig access
- reword commit message to mention disabling of pre-load global
  signature test
- rely on inline dummy for fit_all_configurations_verify
- use CONFIG_IS_ENABLED(FIT_SIGNATURE) to guard fit_all_configurations_verify
- print warning if /configurations node is missing
- print "OK\n" in fit_all_image_verify()
- new patch
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

Ludwig Nussel (8):
  test: include mapmem.h explicitly
  qemu-arm64: merge built-in DT
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
  iminfo: also verify signatures
  test: vboot: refactor run_bootm
  test: vboot: add iminfo checks

 board/emulation/qemu-arm/qemu-arm.c |  51 ++++++++-
 boot/Kconfig                        |  22 ++++
 boot/image-fit-sig.c                |  22 ++--
 boot/image-fit.c                    |  55 ++++++++-
 boot/image-pre-load.c               |   3 -
 cmd/bootm.c                         |  10 ++
 configs/qemu_arm64_defconfig        |   1 +
 configs/sandbox_noinst_defconfig    |   2 +
 doc/usage/fit/signature.rst         |  13 ++-
 include/image.h                     |   8 ++
 test/boot/measurement.c             |   1 +
 test/py/tests/test_vboot.py         | 171 ++++++++++++++++++++++------
 tools/mkimage.h                     |   6 +
 13 files changed, 311 insertions(+), 54 deletions(-)

-- 
2.43.0

base-commit: a7830e87555abfb81cc69275cecb2bc0fbde5b28
branch: us-qemu-signatures7
