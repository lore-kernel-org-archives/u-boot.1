Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E681C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD7BC60818;
	Tue, 28 Jul 2026 06:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXVIc7-0rRoT; Tue, 28 Jul 2026 06:27:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A9EA60819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785220029;
	bh=CSuXoE15VDyutHEIlRfzvtfgbW40HQ6cbQUdknDABM0=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yegwvYMBCjRhT/fIwB93lnp+Gdb8L1/LhqN38drIJ8g+/uFkLbHbJW585uj5RGYjp
	 yTI1PpfxUbMwChyii/dJFqGONYncBdyPZpNpZKGMyGPzPbE5J+rV0LwTe0qpHlspqh
	 C7rHuP2rIw0dzOYLFXVXRh2I3Nnooyjcb07MNHGQXx3mMM7cBq44fEVLaATfuyUyi0
	 5Jh0EohNm0q0CcUbQQa6ATWfz5BvWq0ZHFGK6tZi7aGGeE1yWNQWjUGKx4j5IYwouK
	 pYs7ceX3Wc8pHJll4TqxTPvvpn9UmhuqmC6RBvxuu7WOM8+ea1IjPAE5hWtlqGa3dH
	 x14M96pUsj8ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A9EA60819;
	Tue, 28 Jul 2026 06:27:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E4842E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FAA540189
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1IEU8_rJeKO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:27:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 01B9C40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01B9C40042
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01B9C40042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:27:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E091284873; Tue, 28 Jul 2026 08:27:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C0482991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 08:27:00 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1wtq4e0T2Z-00ADGc; Tue, 28
 Jul 2026 08:26:51 +0200
Message-ID: <fb0a2123-60bf-4b13-ae03-332a780aaa11@gmx.de>
Date: Tue, 28 Jul 2026 08:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hem Parekh <hemparekh1596@gmail.com>, Aristo Chen
 <aristo.chen@canonical.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IDMMyfAjubNxRtQ4L/PgB1zKsDt1gULCB60K5i70yOof5iueMEX
 ItFcZ02+MgwyJzgTccIcA5CJjoU3YpwdeIa8QDYxW1k21vPfSX7jAQ9FSvIbZ0bexuoNowY
 TvRCQ8dDrV9sMjXKm42VYOIcwsBqt7h3OsfyVjtlbEyXa9aCrG6WDKDFfX2IYUtvqFhiRYh
 CteDMtGYJLeSOZi5jXkgg==
UI-OutboundReport: notjunk:1;M01:P0:chSq7vEvBIA=;Ekx9+JAVo66vzem9vDKVC/gkohS
 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
 PRT01bva7iidqOsCWmdwc6rQs0nlCk
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785220012; x=1785824812; i=xypron.glpk@gmx.de;
 bh=CSuXoE15VDyutHEIlRfzvtfgbW40HQ6cbQUdknDABM0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WVqWBJy61OiRCDuWi30ZLQo3PdEran80biFLA7oJ+Au7C84xsnD5OH7OBGcrDAgy
 8O/7dUlQspaKnJzhW0NtRCWuRBPwTGZWcuDBgVfz1ZRWxBtWCzNwmDSczlG1/gsQ9
 +2IhBGZfog62v/R3XLvHX2V9UouuBhEiy5cQfgYTInscVvrnbsFMKIeDVXIhVPkkl
 TFDb86+glOdXFZPX8H81+IfGQM3UHOcDMY4u113FMb9YM1w9ZieEToPEc0fTMDmXK
 qSyWrpTI3JX6fdAyLNmHgezQ+u6bBiK/fWFqg0ro73sJzEyk/WVCgGFokkG01Mjka
 FMfRDwePnEiMYSfJeA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=WVqWBJy6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WVqWBJy6"; 
 dkim-atps=neutral
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

Dear Tom,

The following changes since commit b635d43bca429500cb8ef20aa151cb5773b9a8a=
5:

   Merge patch series "fs/squashfs: fix symlink load failure on large=20
images" (2026-07-25 07:55:35 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc2

for you to fetch changes up to a2fda5145fdf771625b58723ebfb8f1f98f428a1:

   sandbox: fix enum host_platform_flags description (2026-07-27=20
20:24:38 +0200)

Gitlab CI showed not issues:
https://git.u-boot-project.org/u-boot/custodians/u-boot-efi/-/pipelines/75=
3

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc2

Documentation:

* sandbox: fix enum host_platform_flags description
* switch from setenv to env set and from printenv to env print
* document Renesas R-Car Gen5 RSIP Cortex-R52 start
* thead: lpi4a: detail how to enable fastboot

UEFI:

* unify and correct GUID selection for security database variables
* test: check default GUID selection of security database variables
* set correct frame buffer address
* check efi_deserialize_load_option() in get_dp_device()

=2D---------------------------------------------------------------
Aristo Chen (2):
       cmd: nvedit_efi: use efi_auth_var_get_guid() for the default GUID
       test: check default GUID selection of signature database variables

Heinrich Schuchardt (2):
       efi_loader: set correct frame buffer address
       sandbox: fix enum host_platform_flags description

Hem Parekh (1):
       efi_loader: check efi_deserialize_load_option() in get_dp_device()

Marek Vasut (3):
       doc: Switch from setenv to env set
       doc: Switch from printenv to env print
       doc: board: renesas: Document Renesas R-Car Gen5 RSIP Cortex-R52=20
start

Michael Opdenacker (1):
       doc: thead: lpi4a: detail how to enable fastboot

  README                                         |  14 +-
  cmd/nvedit_efi.c                               |  22 +--
  doc/README.console                             |   4 +-
  doc/README.fsl-ddr                             |  30 ++--
  doc/README.iomux                               |   6 +-
  doc/README.link-local                          |   6 +-
  doc/README.marvell                             |   8 +-
  doc/README.odroid                              |  22 +--
  doc/README.serial_multi                        |  26 +--
  doc/README.srio-pcie-boot-corenet              |   4 +-
  doc/README.update                              |   2 +-
  doc/README.usb                                 |   2 +-
  doc/README.video                               |   2 +-
  doc/SPL/README.am335x-network                  |   2 +-
  doc/android/ab.rst                             |   2 +-
  doc/android/avb2.rst                           |   2 +-
  doc/arch/sandbox/sandbox.rst                   |  24 +--
  doc/arch/x86/manual_boot.rst                   |  12 +-
  doc/board/andestech/ae350.rst                  |   8 +-
  doc/board/bsh/imx6ulz_bsh_smm_m2.rst           |   4 +-
  doc/board/emulation/qemu-x86.rst               |   2 +-
  doc/board/intel/slimbootloader.rst             |   4 +-
  doc/board/microchip/mpfs_common.rst            |  12 +-
  doc/board/nxp/mx6sabreauto.rst                 |   2 +-
  doc/board/nxp/mx6sabresd.rst                   |   4 +-
  doc/board/renesas/rcar-gen5-ironhide.rst       | 223=20
++++++++++++++++++++++++-
  doc/board/samsung/e850-96.rst                  |  22 +--
  doc/board/sifive/unleashed.rst                 |  10 +-
  doc/board/st/stm32mp1.rst                      |   2 +-
  doc/board/starfive/deepcomputing_fml13v01.rst  |   2 +-
  doc/board/starfive/milk-v_mars.rst             |   2 +-
  doc/board/starfive/visionfive2.rst             |   2 +-
  doc/board/thead/lpi4a.rst                      |   6 +-
  doc/board/ti/am65x_evm.rst                     |   6 +-
  doc/board/ti/dra7xx_evm.rst                    |   2 +-
  doc/board/ti/ks2_evm.rst                       |   6 +-
  doc/board/tq/tqma6ul.rst                       |   2 +-
  doc/board/xilinx/zynqmp-r5.rst                 |   4 +-
  doc/develop/bootstd/overview.rst               |   4 +-
  doc/develop/distro.rst                         |   8 +-
  doc/develop/uefi/u-boot_on_efi.rst             |   4 +-
  doc/develop/uefi/uefi.rst                      |  12 +-
  doc/usage/cmd/askenv.rst                       |   6 +-
  doc/usage/cmd/bootd.rst                        |   6 +-
  doc/usage/cmd/bootefi.rst                      |   8 +-
  doc/usage/cmd/booti.rst                        |   4 +-
  doc/usage/cmd/bootmenu.rst                     |   8 +-
  doc/usage/cmd/button.rst                       |   2 +-
  doc/usage/cmd/cedit.rst                        |   4 +-
  doc/usage/cmd/coninfo.rst                      |   2 +-
  doc/usage/cmd/echo.rst                         |   2 +-
  doc/usage/cmd/eficonfig.rst                    |   4 +-
  doc/usage/cmd/exit.rst                         |   4 +-
  doc/usage/cmd/extension.rst                    |   4 +-
  doc/usage/cmd/for.rst                          |   4 +-
  doc/usage/cmd/gpt.rst                          |  20 +--
  doc/usage/cmd/imxtract.rst                     |   4 +-
  doc/usage/cmd/mbr.rst                          |   2 +-
  doc/usage/cmd/memsize.rst                      |   2 +-
  doc/usage/cmd/printenv.rst                     |   2 +-
  doc/usage/cmd/saves.rst                        |   2 +-
  doc/usage/cmd/sntp.rst                         |   4 +-
  doc/usage/cmd/tftpput.rst                      |   2 +-
  doc/usage/cmd/wget.rst                         |   2 +-
  doc/usage/cmdline.rst                          |   6 +-
  doc/usage/dfu.rst                              |   4 +-
  doc/usage/environment.rst                      |  10 +-
  doc/usage/fdt_overlays.rst                     |   4 +-
  doc/usage/fit/beaglebone_vboot.rst             |   4 +-
  doc/usage/fit/howto.rst                        |   4 +-
  doc/usage/os/plan9.rst                         |   2 +-
  include/sandbox_host.h                         |   6 +-
  lib/efi_loader/efi_capsule.c                   |   7 +-
  lib/efi_loader/efi_gop.c                       |   7 +-
  test/py/tests/test_efi_secboot/conftest.py     |   8 +
  test/py/tests/test_efi_secboot/test_authvar.py |  47 ++++++
  76 files changed, 511 insertions(+), 239 deletions(-)
