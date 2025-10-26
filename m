Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A80CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 13:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0358832AD;
	Sun, 26 Oct 2025 14:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KwlcdoBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528D383623; Sun, 26 Oct 2025 14:48:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002F482E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 14:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761486476; x=1762091276; i=xypron.glpk@gmx.de;
 bh=0/ZzcW8tfsJ4G4i2/iyhDUX8QgPCpQkX4Hj7GyEtMlY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KwlcdoBOy/aEhgc0ECFDj2x4gdd4qonizLmcKBTbcLlH6h6HahoTlPvnDQpk0waa
 OnG5ZmKwcM/VFlbKLAyM89yYQ4vCuHnqYexzimyCVrTTDWafb4RAEGFjjZXpAyot4
 9ViLt0/cVeP2o3xk3GMJYcrW9gfOJwrm3mpAjDj4mjuGChvHoFO8x71vQneEUhhFs
 7zcSK1Puqvk01xQsbdZjutqAx7cPrczZhTlGpsqpRPWc0kmmE6U0AW7UzY1W56aXC
 KtveMwruZbQM02YtFWcuDIM2qiEmzDjUjjuHmmU1Ghrr7LQfv75iDrfbUXqudYGp4
 V5YJdiQlR2ZIOIvDUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.164.78] ([212.140.138.218]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1v5tIH3YJG-008blv; Sun, 26
 Oct 2025 14:47:55 +0100
Message-ID: <9793c710-20c9-4536-941f-9ed50793f8fe@gmx.de>
Date: Sun, 26 Oct 2025 13:47:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:do/qTqTDVcB/dBSbVlNmS9EHneRPDxvfOdx3dkDe7e8IzheFwId
 VDPPCDYh5lx1mieTNDoUlOU6pJ0qfOZ8Y73L4Xx9iZ24Xyia6ybxCLSdfs6/J/sJicQJmhy
 7N0k7bZQSksiOvUaj2x4zJy6SPS97XjJwKDD6A0gcDuh5K8sQPH4Pkl0NnBrDWnvlzNE010
 tPDaPqLb3OdQ+bhJhl5sg==
UI-OutboundReport: notjunk:1;M01:P0:iiLSNWG/mgA=;zE6dZRPv/nJmPy+PU9C19R+QshS
 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
 1LgGDuFZEXocig==
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

The following changes since commit fd976ff3a233ae7c6a9f5bec790b02bbbf57bb2=
4:

   Merge patch series "firmware: scmi: Support SCMI LMM/CPU protocol for=
=20
i.MX95" (2025-10-24 13:47:50 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc1-2

for you to fetch changes up to d4fc62452be05c4aebe951b3855b4523aed077cb:

   doc/usage: Add a reference to General rules for commands (2025-10-26=20
10:24:50 +0000)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28024

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc1-2

Documentation:

* develop: virtio: Fix qemu example (true/false -> on/off)
* separate read and write command documentation
* usage: Add general rule for `$?`
* askenv: Reword and remove return value
* seama: Reword return value section
* usage: Use glob for all commands
* Fix typos and formatting

UEFI:

* console: support editable input fields

=2D---------------------------------------------------------------
Casey Connolly (1):
       efi_loader: efi_console: support editable input fields

Heinrich Schuchardt (1):
       doc: separate read and write command documentation

Tom Rini (5):
       doc: usage: Add general rule for `$?`
       doc: askenv: Reword and remove return value
       doc: seama: Reword return value section
       doc: usage: Use glob for all commands
       doc/usage: Add a reference to General rules for commands

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
  cmd/eficonfig.c                        |   2 +
  doc/develop/devicetree/control.rst     |   2 +-
  doc/develop/driver-model/fdt-fixup.rst |   2 +-
  doc/develop/driver-model/virtio.rst    |   4 +-
  doc/develop/testing.rst                |   4 +-
  doc/develop/trace.rst                  |   2 +-
  doc/mkimage.1                          |   4 +-
  doc/usage/cmd/armffa.rst               |   5 --
  doc/usage/cmd/askenv.rst               |  27 +-----
  doc/usage/cmd/bdinfo.rst               |   5 --
  doc/usage/cmd/bind.rst                 |   5 --
  doc/usage/cmd/blkcache.rst             |   6 --
  doc/usage/cmd/cat.rst                  |   5 --
  doc/usage/cmd/cli.rst                  |   5 --
  doc/usage/cmd/cls.rst                  |   5 --
  doc/usage/cmd/cp.rst                   |   6 --
  doc/usage/cmd/cpu.rst                  |   6 --
  doc/usage/cmd/cpuid.rst                |   5 --
  doc/usage/cmd/dmareset.rst             |   6 --
  doc/usage/cmd/ebtupdate.rst            |   6 --
  doc/usage/cmd/fatinfo.rst              |   6 --
  doc/usage/cmd/fdt.rst                  |   5 --
  doc/usage/cmd/font.rst                 |   6 --
  doc/usage/cmd/fuse.rst                 |   6 --
  doc/usage/cmd/gpio.rst                 |   6 --
  doc/usage/cmd/host.rst                 |   6 --
  doc/usage/cmd/i3c.rst                  |   6 --
  doc/usage/cmd/imxtract.rst             |   6 --
  doc/usage/cmd/loadb.rst                |   5 --
  doc/usage/cmd/loadm.rst                |   7 --
  doc/usage/cmd/loads.rst                |   5 --
  doc/usage/cmd/loadx.rst                |   5 --
  doc/usage/cmd/loady.rst                |   5 --
  doc/usage/cmd/msr.rst                  |   5 --
  doc/usage/cmd/mtest.rst                |   5 --
  doc/usage/cmd/optee.rst                |   5 --
  doc/usage/cmd/part.rst                 |   6 --
  doc/usage/cmd/pause.rst                |   6 --
  doc/usage/cmd/pinmux.rst               |   6 --
  doc/usage/cmd/pwm.rst                  |   6 --
  doc/usage/cmd/read.rst                 |  39 +++++----
  doc/usage/cmd/saves.rst                |   5 --
  doc/usage/cmd/scmi.rst                 |   7 --
  doc/usage/cmd/seama.rst                |   7 +-
  doc/usage/cmd/setexpr.rst              |   7 --
  doc/usage/cmd/size.rst                 |   6 --
  doc/usage/cmd/smbios.rst               |   5 --
  doc/usage/cmd/sound.rst                |   5 --
  doc/usage/cmd/source.rst               |   6 --
  doc/usage/cmd/temperature.rst          |   6 --
  doc/usage/cmd/tftpput.rst              |   5 --
  doc/usage/cmd/unbind.rst               |   5 --
  doc/usage/cmd/wdt.rst                  |   5 --
  doc/usage/cmd/wget.rst                 |   5 --
  doc/usage/cmd/write.rst                |  41 ++++++++-
  doc/usage/cmdline.rst                  |   6 ++
  doc/usage/environment.rst              |   2 +-
  doc/usage/fit/beaglebone_vboot.rst     |   2 +-
  doc/usage/fit/overlay-fdt-boot.rst     | 156=20
++++++++++++++++-----------------
  doc/usage/index.rst                    | 120 ++-----------------------
  include/bootm.h                        |   2 +-
  include/image.h                        |   8 +-
  lib/efi_loader/efi_console.c           |  55 ++++++++++--
  tools/binman/binman.rst                |  73 ++++++++-------
  66 files changed, 261 insertions(+), 548 deletions(-)
