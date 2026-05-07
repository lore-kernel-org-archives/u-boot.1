Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75421CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1350A84AA4;
	Thu,  7 May 2026 14:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="cycuWU5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E748984AC8; Thu,  7 May 2026 14:07:39 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3EE84A7D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 14:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20260507120737c33b477dcc00020771 for <u-boot@lists.denx.de>;
 Thu, 07 May 2026 14:07:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iLu+VUQQsVfH/akWgudpeXtrTrhi2p7DvUvCOr63Hvk=;
 b=cycuWU5py7qH1P9o+oXXUgUz7wh92wb/UgbNrHT11v7BNPyde9MEr/Z9aLhxgXir6uMFKS
 LT/oJTS24abZ8z0VsVjQ0sfLNkfipv4GEH9C6q6ilo0lPgJl0RBT1Fcr8cUPxq2SHraymwJV
 Njfk+ohzNwQVZ832dCqsl1DkyW+DGFXCtcJJq9PCscXyR3jBW/tD9/XDNYnB2XTHGFVBjl50
 Cuu7flXS8vQQ24wc5LJLyHR7/wyE9L4PO0nPo7uQM7gR3vqqAjgxFLBq1FEuKG6OfWP0CYrY
 MIH7jpnC/A0bySdDIOrabcJOPXu2vJupA8p3O7JLUgBNfDgOHALQ9Bsw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal
 <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>, George Chan
 <gchan9527@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, James Hilliard
 <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, "Kory
 Maincent (TI.com)" <kory.maincent@bootlin.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Mayuresh Chitale
 <mchitale@ventanamicro.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Raymond Mao <raymondmaoca@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Shiji Yang
 <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Wolfgang
 Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 0/4] Improve FIT signature handling
Date: Thu,  7 May 2026 14:06:21 +0200
Message-ID: <20260507120735.310325-1-ludwig.nussel@siemens.com>
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

Ludwig Nussel (4):
  qemu: overlay signature nodes
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  iminfo: also verify signatures

 board/emulation/qemu-arm/qemu-arm.c | 50 ++++++++++++++++++++++++--
 boot/Kconfig                        | 10 ++++++
 boot/image-fit-sig.c                | 22 +++++++-----
 boot/image-fit.c                    | 54 +++++++++++++++++++++++++++++
 boot/image-pre-load.c               |  3 --
 cmd/bootm.c                         |  7 ++++
 configs/qemu_arm64_defconfig        |  1 +
 include/image.h                     |  8 +++++
 tools/mkimage.h                     |  5 +++
 9 files changed, 146 insertions(+), 14 deletions(-)

-- 
2.43.0

base-commit: 2829c6969cd1bd5380a090edbdcd69068be035eb
branch: us-qemu-signatures3
