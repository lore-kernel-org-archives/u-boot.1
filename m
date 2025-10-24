Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC08CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F9983710;
	Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D59CE836B2; Fri, 24 Oct 2025 17:12:28 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03BF83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id A31306EFA;
 Fri, 24 Oct 2025 17:12:25 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122290-28972 ;
 Fri, 24 Oct 2025 17:12:22 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122519-18293 ;
 Fri, 24 Oct 2025 17:12:25 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Alex Shumsky" <alexthreed@gmail.com>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Bin Meng" <bmeng.cn@gmail.com>, "Bryan Brattlof" <bb@ti.com>,
 "E Shattow" <e@freeshell.de>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Jerome Forissier" <jerome.forissier@linaro.org>,
 "Julien Masson" <jmasson@baylibre.com>,
 "Lothar Rubusch" <l.rubusch@gmail.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Mark Jonas" <mark.jonas@de.bosch.com>,
 "Martin Schwan" <m.schwan@phytec.de>,
 "Masahiro Yamada" <yamada.masahiro@socionext.com>,
 "Mattia Narducci" <mattianarducci1@gmail.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Mayuresh Chitale" <mchitale@ventanamicro.com>,
 "Michal Simek" <michal.simek@amd.com>,
 "Patrick Rudolph" <patrick.rudolph@9elements.com>,
 "Paul HENRYS" <paul.henrys_ext@softathome.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ricardo Simoes" <ricardo.simoes@pt.bosch.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Yannic Moog" <y.moog@phytec.de>,
 "Yegor Yefremov" <yegorslists@googlemail.com>,
 "mason1920" <mason1920@use.startmail.com>
Subject: [PATCH 0/9] Fix various typos, wording or whitespace errors
Date: Fri, 24 Oct 2025 17:11:56 +0200
Message-ID: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:25 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:25 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:22 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:24 PM,
 Serialize complete at 10/24/2025 05:12:24 PM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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


While reading through the U-Boot source code and documentation, i stumbled
over some typos and similar errors like wrong formating. These are the comm=
its
where I collected the fixes.



Wolfgang Wallner (9):
  doc: develop: Fix typos in binman/binman.rst
  doc: develop: Change formatting to make binman doc more readable
  doc: Fix typos
  boot: kconfig: Fix typos
  image: Fix typos in image.h
  bootm: Fix typo in bootm.h
  boot: Fix typo
  doc: Fix whitespace in devicetree example in overlay-fdt-boot.rst
  doc: develop: virtio: Fix qemu example (true/false -> on/off)

 boot/Kconfig                           |   4 +-
 boot/image-fit.c                       |   2 +-
 doc/develop/devicetree/control.rst     |   2 +-
 doc/develop/driver-model/fdt-fixup.rst |   2 +-
 doc/develop/driver-model/virtio.rst    |   4 +-
 doc/develop/testing.rst                |   4 +-
 doc/develop/trace.rst                  |   2 +-
 doc/mkimage.1                          |   4 +-
 doc/usage/environment.rst              |   2 +-
 doc/usage/fit/beaglebone=5Fvboot.rst     |   2 +-
 doc/usage/fit/overlay-fdt-boot.rst     | 156 ++++++++++++-------------
 include/bootm.h                        |   2 +-
 include/image.h                        |   8 +-
 tools/binman/binman.rst                |  73 ++++++------
 14 files changed, 136 insertions(+), 131 deletions(-)

--=20
2.51.1

base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
branch: us/fix=5Ftypos
