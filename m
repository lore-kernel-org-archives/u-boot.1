Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA3CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A5784686;
	Wed, 13 May 2026 16:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="TpPTwQvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0C28341A; Wed, 13 May 2026 16:10:40 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDF38467B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2026051314103538b32273ed000207f5 for <u-boot@lists.denx.de>;
 Wed, 13 May 2026 16:10:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sXz416zngb3pH0moKlMOHTjIkMj4fP3hdyNVWLOkL30=;
 b=TpPTwQvy0/mVNSxLSaG8OKYKRbUgvYkD/V00fcJRFJmb6chrStIv78BCl1OIa9/8j62nZB
 W7h0kG1QduOj5cYB/SzJONfqEvQ9tqLlUAAWRybGKLwzSXUAU/UhAsfW+WXqy1mDaCqC7Ly4
 WaYiQOCoFLEx1Ua1vNvUNEFzBNd2BLaS+UD0IKXsDzc30k1IQ3ymTVa4BTKQaNotIVhvkejW
 biUPWq4Y9ZvHN7rWP4efkr+PA1c1bu8As7nb2K7eXMRnbswPHWMucPs2XR4aXQlWsNM8wWjP
 rsJSA0VKsy9XkECHB3Nee7GQYvSUa/MG8mjc07Y/Rx2ManA6mu1TLytQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal
 <anshuld@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, Ferass El
 Hafidi <funderscore@postmarketos.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, James
 Hilliard <james.hilliard1@gmail.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao
 <raymondmaoca@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Shiji
 Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Wolfgang
 Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 0/6] Improve FIT signature handling
Date: Wed, 13 May 2026 16:08:10 +0200
Message-ID: <20260513141027.351280-1-ludwig.nussel@siemens.com>
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

The tests were created with the help of copilot and manual fixups. I
have to admit that the log output of those tests is not something I can
grok. I've left the tags copilot added in the commits even though
checkpatch complains. Not sure what the policy is.

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

Ludwig Nussel (6):
  qemu-arm: merge built-in DT
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
  iminfo: also verify signatures
  test: vboot: add iminfo checks for config signature verification

 board/emulation/qemu-arm/qemu-arm.c |  47 ++++++++++++-
 boot/Kconfig                        |  22 ++++++
 boot/image-fit-sig.c                |  22 +++---
 boot/image-fit.c                    |  53 ++++++++++++++
 boot/image-pre-load.c               |   3 -
 cmd/bootm.c                         |  10 +++
 configs/qemu_arm64_defconfig        |   1 +
 configs/sandbox_defconfig           |   1 +
 include/image.h                     |   8 +++
 test/py/tests/test_vboot.py         | 105 ++++++++++++++++++++++++----
 tools/mkimage.h                     |   6 ++
 11 files changed, 253 insertions(+), 25 deletions(-)

-- 
2.43.0

base-commit: 47dc2c9f758a82bdc98572d7afbf61e5870f0b5d
branch: us-qemu-signatures4
