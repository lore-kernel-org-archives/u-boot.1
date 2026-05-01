Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B0FCD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 11:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744A3803C6;
	Fri,  1 May 2026 13:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V+vNIynL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4347880F0E; Fri,  1 May 2026 13:46:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AD180086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 13:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777635963; x=1778240763; i=xypron.glpk@gmx.de;
 bh=w6tuZQdFqK5rLJxy1mWFOmLsKIQmvSYXOlXDmLCS/fY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=V+vNIynL7gUKBiafuKbxVG79w5tWWp4dDu62FanA3KW1dQM5Q2iug5ydkgNuJQmq
 eb4TzQpXkU05MuOoCvDpjH0ilZIhEzhgO1k9+825lWVCiD6ZBmpGRenl+ZZMBVy7H
 nYdJo2lhLPi5D8SWn5mX+7QxHRPR8fM94qYI5oO+NBZg/mc6I8IBzOt2bmsjJMJnn
 E102zy8kpPwRLfWVjVgI82e9SRlzMzaTnts75dVAOwRl2hTI29KNud0bFy6+YCjow
 z5YjhzPNGz+6VtcI+tm5no1+O1eCS+FABEWWd2K2ZoBGH3YMSE1J1jUCzJWN9lviQ
 W/k3ZVsx6rJuTl+QNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1vNUpW3EZs-015q4O; Fri, 01
 May 2026 13:46:02 +0200
Message-ID: <0ef3c3d7-4255-470e-97e5-951e7351d7b9@gmx.de>
Date: Fri, 1 May 2026 13:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johannes Krottmayer <krotti83@proton.me>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiva Tripathi <s-tripathi1@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-07-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QSQqA2mw0+7KuMKyqT4V6+9CoR93Vy8moQjOKvd9tfhrBfEZsDo
 fi5F47o/B5uta7ifWf3DkeK+z417YzcciuMO38liadPzHepccPNggfubbMRB46oU2xt6zGP
 YVCdIMZprb5cEWXbxn/25D75AdxvXoIXZyG7nOvtxAtn99dmzqr6nJp1KGsG0Lu/rShWUlJ
 EJIEAWlFsQ1ePZTRSDZMg==
UI-OutboundReport: notjunk:1;M01:P0:a9VZsW0U3Wk=;6iCPv5B0pJ+AieHLp4t5AqDAUog
 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
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

The following changes since commit b52670d37bc855f6c8da63eb51bf84bce4dad90=
b:

   gpio: 74x164: use dev_read_* APIs for live-tree compatibility=20
(2026-04-30 13:57:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc2

for you to fetch changes up to a48ddf81c29a6def34f5b3417bf190c8ff117c91:

   .clang-format: add U-Boot specific for each macros (2026-05-01=20
12:22:38 +0200)

Gitlab CI did not report any issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29967

=2D---------------------------------------------------------------
Pull request efi-2026-07-rc2

Documentation:

* .clang-format description
* qemu-arm: describe secure state steps
* mention that CONFIG_BOOTSTD_DEFAULTS provides network features when NET=
=3Dy
* ti: k3: describe fTPM support

UEFI:

* cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
* correct return value of efi_bootmgr_run()
* correct efi_binary_run_dp() return value
* centralize messaging for efi_init_obj_list
* correct Kconfig dependencies for EFI_HTTP_BOOT

Others:

* .clang-format: add U-Boot specific for each macros

=2D---------------------------------------------------------------
Heinrich Schuchardt (6):
       cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
       efi_loader: correct return value of efi_bootmgr_run()
       efi_loader: correct efi_binary_run_dp() return value
       efi_loader: centralize messaging for efi_init_obj_list
       doc: .clang-format description
       .clang-format: add U-Boot specific for each macros

Johannes Krottmayer (1):
       doc: emulation: qemu-arm: add secure state steps

Quentin Schulz (1):
       doc: bootstd: specify CONFIG_BOOTSTD_DEFAULTS provides network=20
features when NET=3Dy

Shiva Tripathi (1):
       doc: board: ti: k3: Add fTPM support documentation

Tom Rini (1):
       EFI Loader: Correct dependencies for EFI_HTTP_BOOT

  .clang-format                    | 51 +++++++++++++++++++++++
  boot/bootmeth_efi_mgr.c          |  4 +-
  cmd/bootefi.c                    | 13 +++---
  cmd/bootmenu.c                   |  6 +--
  cmd/eficonfig.c                  |  6 +--
  cmd/efidebug.c                   |  5 +--
  cmd/nvedit_efi.c                 | 10 +----
  doc/board/emulation/qemu-arm.rst | 88=20
++++++++++++++++++++++++++++++++++++++--
  doc/board/ti/k3.rst              | 83=20
+++++++++++++++++++++++++++++++++++++
  doc/develop/bootstd/overview.rst |  2 +-
  doc/develop/codingstyle.rst      |  6 ++-
  lib/efi_loader/Kconfig           |  1 +
  lib/efi_loader/efi_bootbin.c     |  7 +---
  lib/efi_loader/efi_bootmgr.c     |  7 +---
  lib/efi_loader/efi_setup.c       |  2 +
  15 files changed, 242 insertions(+), 49 deletions(-)
