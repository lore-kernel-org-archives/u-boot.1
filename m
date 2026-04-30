Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEBCFF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9082B842C7;
	Thu, 30 Apr 2026 14:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="NKcH4LxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DC283FDB; Thu, 30 Apr 2026 14:26:43 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC12E803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2026043012263804dea308fb000207f0 for <u-boot@lists.denx.de>;
 Thu, 30 Apr 2026 14:26:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qtY1TnBD6vjNuTTr2QgV4ZexoNISEvInbXkse0u6WNs=;
 b=NKcH4LxG2FPAP/j5bozQer+kTQzorLvw0zYe3DIOqI0EYGDVrnHYvUoS1n4Z+Tcy4GEsyv
 qgtTPsfYMBZ5u7+S3Gajc/f7vnrJ3PeVYK5fS1IL5V1BiKA6dkrAAoEDAjf45qag39XpoBEo
 5DmsyXJBLG9vqtRMLfJa+T++0N2Dnb0ClJXRdvSfT6x38/CMyCiAkY+IBdSNRQGom5SKuwC9
 CzF32stw+rPhMsbQ9ixVReKLja95JQXhhqrbOgZIiKbcygAiDpKcM6g3ueS65KDYhrhlO4lO
 kVYwJ9oWx4GfpolrZO/rS2V0zOl1qI7vDLwNA38/mHD02Va/ioNQGw3w==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 0/4] Improve FIT signature handling
Date: Thu, 30 Apr 2026 14:25:59 +0200
Message-ID: <20260430122629.606153-1-ludwig.nussel@siemens.com>
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

Changes in v2:
  - introduce FIT_SIGNATURE_REQUIRED
  - document fit_all_configurations_verify()

Ludwig Nussel (4):
  qemu: overlay signature nodes
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  iminfo: also verify signatures

 board/emulation/qemu-arm/qemu-arm.c | 33 +++++++++++++++++++-
 boot/Kconfig                        | 10 ++++++
 boot/image-fit-sig.c                | 12 +++++---
 boot/image-fit.c                    | 48 +++++++++++++++++++++++++++++
 boot/image-pre-load.c               |  3 --
 cmd/bootm.c                         |  7 +++++
 include/image.h                     |  1 +
 tools/mkimage.h                     |  2 ++
 8 files changed, 107 insertions(+), 9 deletions(-)

-- 
2.43.0

base-commit: 70cb0b8232246c5157802cc26536258a1a446603
branch: us-qemu-signatures2
