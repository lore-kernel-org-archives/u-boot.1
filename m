Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A191ECAC5B8
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 11:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2053C83677;
	Sat, 27 Sep 2025 13:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OxRUEsLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE27836A3; Sat, 27 Sep 2025 13:55:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B9383653
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 13:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1758974114; x=1759578914; i=xypron.glpk@gmx.de;
 bh=w4+za8y8xuPIC8HI6C/ke48FkvrI1z9306Y8q1xVUYc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OxRUEsLdE63CHz0Lr526Gd2lV2u5mmqoRk0njrmKi6urIHCM2MNNprK99LUvEqB7
 Il9OCc0FW4QwFNU+DeL2lAyrH9TEHVSC6eixioiueKgZwIaFa7JBJIE+/S2CQd2WZ
 iwk3pzdimmJfzWCWXcIYFAU/kwwDkewljjvLoDhLNbWEKT8Q2+Zt2pzPhoX42Qwgx
 mVyKHWwgyGuLuCGfm8xVC4glh1rAtEdMZlI3HeqtTRUpqCFqiEUW7x5LXwenX/U9q
 gfplz3eOYdi+F57LM1ab1PkumKyxGnOnRxDrjcLBH4/yEPd2pteRthNs7J448b8vs
 UemfZvmDASTbCCIhoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1unr4p2rVl-00LxtT; Sat, 27
 Sep 2025 13:55:14 +0200
Message-ID: <65571c10-0146-4422-b7c7-888db609a848@gmx.de>
Date: Sat, 27 Sep 2025 13:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>, E Shattow <e@freeshell.de>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>,
 Sidharth Seela <sidharthseela@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request efi-2025-10-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VPaGgo9WOwd0kJjOpJ0vO0Lfrvl5hk3PtAm8KzPu8LX4EXnk+lE
 +wciskOlDThU3hlOnGE3bXSX8KtUPLIZyrOHjIKDygohaNifujonLx0GRuTK2TEwDKjb5ZV
 HWPoZEppQTPdqlcVf06EgL5nxPGaLO5yPYSaIMacgbLxo74kpfR3MA+HbRryNl8HF5j7Zw1
 nfgPAo7xHTinrpMPXIpQQ==
UI-OutboundReport: notjunk:1;M01:P0:+/BeBbluZzU=;X8VyBDJZK3yTgi1yMHbIlURmmlT
 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
 WzZZnp094XJ0nQ==
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

Dear Tom,

The following changes since commit 9b45d574af1b64fcd997f08fe702a2d0ecfccbe=
4:

   spl: nand: initialize writesize for am335x (2025-09-25 18:54:07 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-10-rc6

for you to fetch changes up to a0fe8cedcbe8c76403a77e57eac228b8f778a3ae:

   efi_loader: Cleanup UEFI Variables menu selection (2025-09-27=20
09:22:00 +0200)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27745

=2D---------------------------------------------------------------
Pull request efi-2025-10-rc6

* Correct encodings for spl memory layout diagrams
* Suggest usage of KDOC_WERROR when building documentation
* Replace references to README.fdt-control
* Clarify precedence of environment locations
* Add documentation for the TI am335x_evm board
* Remove README.commands.itest
* Add a note about asking for feedback in the development process

UEFI:

* Cleanup UEFI Variables Kconfig menu

=2D---------------------------------------------------------------
Anshul Dalal (1):
       doc: memory: fix encodings for spl layout diagrams

E Shattow (2):
       doc: build: documentation: add description of KDOC_WERROR
       doc: Update mentions of README.fdt-control

Michal Simek (1):
       efi_loader: Cleanup UEFI Variables menu selection

Neha Malcom Francis (1):
       doc: memory: Restore missing diagram

Ricardo Simoes (1):
       doc: environment: clarify env precedence

Sidharth Seela (1):
       doc: board: ti: am335x_evm: Add documentation

Tom Rini (2):
       doc: Remove README.commands.itest
       doc: develop: process: Add note about asking for feedback

  .gitattributes                        |   1 -
  doc/README.commands.itest             |  16 --
  doc/arch/nios2.rst                    |   2 +-
  doc/board/ti/am335x_evm.rst           |  10 +
  doc/build/documentation.rst           |   3 +
  doc/develop/devicetree/control.rst    |   2 +-
  doc/develop/driver-model/ethernet.rst |   2 +-
  doc/develop/pics/spl_after_reloc.svg  | 297 +++++++++++++++++++++++++-
  doc/develop/pics/spl_before_reloc.svg | 386=20
++++++++++++++++++++++++++++++++++
  doc/develop/process.rst               |   4 +-
  doc/develop/spl.rst                   |   2 +-
  doc/usage/environment.rst             |   6 +-
  doc/usage/fit/overlay-fdt-boot.rst    |   2 +-
  dts/Makefile                          |   2 +-
  lib/efi_loader/Kconfig                |  50 ++---
  15 files changed, 729 insertions(+), 56 deletions(-)
  delete mode 100644 doc/README.commands.itest
