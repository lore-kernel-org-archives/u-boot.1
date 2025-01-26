Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C58C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 11:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E01680EF4;
	Sun, 26 Jan 2025 12:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Jfc9q7jp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC21C80F10; Sun, 26 Jan 2025 12:12:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CCF80275
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 12:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737889935; x=1738494735; i=xypron.glpk@gmx.de;
 bh=v90KUR7mhw3c9nvMiUTCnFOc0dKoFbKJSKbtNCbXX+w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Jfc9q7jpPBQhisSm9Aelw9np0u3mAA9FOiWRhqJ/rF9NocPYp3+6iNKrr8QIhOhC
 ZjZ70TAVXm0B+8VeVnXuEoN4vQcRyM1JSNh6cVdf3fOqlEw2kuRWdGURp4j8GFycX
 oPBBq8BcsK9yAyZ9MDEblEE1TEH5YTwSsx6DRortJJs6Six2rO0vuiio4qyFfRzmk
 ScCbPyMduN+CxBK3Lt3ly+TjihDvJJC9AfTDR48NIahRRmeOw69l0T2OZT+gd1Qy+
 n4fnKspHlfG1dLWkQqhybk9273b7ZHS1+Bo9/Je8utZi4yZvxrel+bF4oKlenlWYI
 E+VQcXr/XKFTS1gfHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1twztr1tyO-00OCAM; Sun, 26
 Jan 2025 12:12:15 +0100
Message-ID: <45b8506e-d2be-4a7d-9e59-056933b62755@gmx.de>
Date: Sun, 26 Jan 2025 12:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-04-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SmxVAL7YLecPv31qFjvQQtB2/sQoNjTRDXL5p13pYCSlGJ7I0Q2
 8dd0Y8d3HKMH7y9qt+2iMGhvrRovoGCKS3K8wpRLpVynMOuKVLty3eATY5zNQRq7io3ohpB
 XIo7weYhFt6eY3a9K5nBuu5pUhPq0TkG89WJVBs5hABcT0OOnRp2YY0hQaPB8JH1tZWQRS7
 YrpuDbT1oT0FGzwJE8UOw==
UI-OutboundReport: notjunk:1;M01:P0:Qs4kVgzxsRQ=;giQfRgtNgtysHNaQrX9r60qdKEB
 v93403K7CkSt8gJbi2WNDrLbI5Ua4ImlVLZl2PZlq5HF6R/ZI76QjPvydVQZaXpI/12eH2nh0
 4GD6u+3/l7Bmh7NfZ6SKST3aK/Cm/8ZG3laENcrycw9Hx3DGpGPwpm+zUgkTS70/Da+JVHNOY
 MkXP6mquqH7zxsQ3ko5amZiuIW4wJur2pxaQIydlaHduOIt+8upoHQAbXQ5T432AT2d4phOiB
 mJ2x9TMx19WGKKVCbcu6HrDkyymTdRXI/vQ7KR+NSaiKVDxa0UclsnrFxLw+RUmzNe2OnfsW/
 ic53LSw/qJDTqz55hfWiDWSTfNFX60hA1Hr/TWIzeBAFVlF2tIF+bX+MAz7XyPA7sh12VO1Tb
 OtmE9WK1FRDKU+6ynBnNyDMsRpWYee5eiL7C71wrTKhp8f9SWtariICJCq7sQ2n9zklt2PX1p
 41jfTgJ19W+mPQRe2e0WjtXfIma4fmgpEOBmTpmUMTsizHQbfDysE4Wz7RYx5EXQnl7vqj3fM
 lqRog7ZBjmw++9KeqsKqm0ESRoPAhibSOaCkt7oGKYMdmLkAegjQaLjaE/HPWD0vg14H1h8d5
 6TomX0asG2Ub0pis5ZEGzbT7ytMbQcY5Yd5F7rp7Fa/NDPi5sJGYBtv+LezV9wdwecbnpIeeL
 j3vlcsuzy/X89sc+T7TXHo6ZEk3aH7rLC6lLXeAymlT25PkiItNM/7yBjmKFrHqHnTl744atg
 rcYpqbeqTrYsvZ9CpI0D69wpiK6IfgkSQZKMYzwvSgdxM+S0EY/XmU23ynWztG/VfG04Kw6qR
 VAkPFQp/JiVRe5rUTfd6cMETLEqWEgiT6qEpYFQo7nZnTCT3/HnlVpM4wp/PDcbJKXQqFS1Dk
 GJWBC4rrF87taKQXD7hk9HJEXcpJj69gxhU+O8neB/ug8o2amPLmE/ptVreqrY4W0tG9XMsVx
 l6bqMZpdvgC+D92wpzqyZTyrhddozP7wZ2khmS76tZLIXmWDBbYNcqxeAJkaRP5zSk6EgU0ns
 KJdV9DZc4Zuae8+AkYNpCkOiMCLfQ6Armji9MdVs5dpzHKFfMeNzDmNibm4cRTTYUOWpwPCZ5
 EMYdQFBtZXiI0kcK9je5w30Bnvjj/oRst8BNkgM3SNUgTN6Dae3ZLlCWushINJJe2FAYQnWDT
 frEN2htYoSMRfkPkpa4JqfZnoi349oXqdYTL/U93lPg==
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

The following changes since commit 292278d6828e6c8c6ae11bc8658586d1acc411d=
4:

   Merge patch series "gitlab: Fixes to get StarFive VisionFive2 into
the sjg lab" (2025-01-25 16:28:27 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-04-rc1-2

for you to fetch changes up to 21de624eb89c647a21b06a5b0f5b186838be1d17:

   bootmeth_efi: Support PXE booting (2025-01-26 11:06:57 +0100)

=2D---------------------------------------------------------------
Pull request efi-2025-04-rc1-2

Documentation:

* describe creating a pflash file for qemu-system-riscv64

UEFI:

* correct logging StartImage()
* use LOGC_EFI consistently
* reduce UEFI size if HAS_BOARD_SIZE_LIMIT=3Dy
* Update efi_run_image() to accept image and device path
* Add a version of efi_binary_run() with more parameters
* Move the fallback code from efi_run_image()
* Pass in the required parameters from EFI bootmeth
* bootmeth_efi: Support PXE booting

Other:

* Enable log filtering by function name

=2D---------------------------------------------------------------
Heinrich Schuchardt (7):
       efi_loader: correct logging StartImage()
       log: make log_has_file() static
       log: enable filtering on functions
       test/log: test function filters
       efi_loader: use LOGC_EFI consistently
       efi_loader: reduce UEFI size if HAS_BOARD_SIZE_LIMIT=3Dy
       doc: describe creating a pflash file for qemu-system-riscv64

Simon Glass (5):
       efi_loader: Update efi_run_image() to accept image and device path
       efi_loader: Add a version of efi_binary_run() with more parameters
       efi_loader: Move the fallback code from efi_run_image()
       efi_loader: Pass in the required parameters from EFI bootmeth
       bootmeth_efi: Support PXE booting

  boot/bootmeth_efi.c                        |  64 +---------
  cmd/log.c                                  |  42 ++++---
  common/log.c                               |  33 +++--
  doc/board/emulation/qemu-riscv.rst         |  17 +++
  include/efi_loader.h                       |  22 ++++
  include/log.h                              |  19 +--
  lib/efi_driver/efi_block_device.c          |   2 +
  lib/efi_driver/efi_uclass.c                |   2 +
  lib/efi_loader/Kconfig                     |   4 +-
  lib/efi_loader/efi_acpi.c                  |   2 +
  lib/efi_loader/efi_bootbin.c               | 188
++++++++++++++++++++++-------
  lib/efi_loader/efi_boottime.c              |   9 +-
  lib/efi_loader/efi_conformance.c           |   2 +
  lib/efi_loader/efi_device_path_to_text.c   |   2 +
  lib/efi_loader/efi_device_path_utilities.c |   2 +
  lib/efi_loader/efi_dt_fixup.c              |   2 +
  lib/efi_loader/efi_esrt.c                  |   2 +
  lib/efi_loader/efi_fdt.c                   |   2 +
  lib/efi_loader/efi_file.c                  |   2 +
  lib/efi_loader/efi_firmware.c              |   2 +
  lib/efi_loader/efi_gop.c                   |   2 +
  lib/efi_loader/efi_helper.c                |   1 +
  lib/efi_loader/efi_hii.c                   |   2 +
  lib/efi_loader/efi_hii_config.c            |   2 +
  lib/efi_loader/efi_http.c                  |   2 +
  lib/efi_loader/efi_ipconfig.c              |   2 +
  lib/efi_loader/efi_load_initrd.c           |   1 +
  lib/efi_loader/efi_net.c                   |   2 +
  lib/efi_loader/efi_riscv.c                 |   1 +
  lib/efi_loader/efi_root_node.c             |   2 +
  lib/efi_loader/efi_runtime.c               |   2 +
  lib/efi_loader/efi_signature.c             |   2 +
  lib/efi_loader/efi_string.c                |   2 +
  lib/efi_loader/efi_tcg2.c                  |   1 +
  lib/efi_loader/efi_unicode_collation.c     |   2 +
  lib/efi_loader/efi_var_common.c            |   2 +
  lib/efi_loader/efi_var_mem.c               |   2 +
  lib/efi_loader/efi_variable_tee.c          |   2 +
  lib/efi_loader/efi_watchdog.c              |   2 +
  test/log/log_filter.c                      |   1 -
  test/log/log_test.c                        |  78 +++++++++---
  41 files changed, 365 insertions(+), 168 deletions(-)

