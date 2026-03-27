Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1925A10ED659
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 11:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3809C83DA7;
	Fri, 27 Mar 2026 12:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uIVamtug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2356D83E7A; Fri, 27 Mar 2026 12:19:26 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA4883C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774610360; x=1775215160; i=xypron.glpk@gmx.de;
 bh=Drz2rkimG8GX04Q+rjcCC688nnd8G+uf7p6wtHFas0Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uIVamtug/NhHKLgf1F8kn1THe8CjilyciS7NWRNgkm5pD7V4ooqufrOve9DQOB1N
 lQNAcneQWF6De9f2+TZ4pYZF4jcDleEUwmakpwgKj6Lq10S/lRZcaerlLRb/8jzlH
 yh69q2MU+Z4TLEgEJxaXnkkkM/aLTDH2P1NLoW0dDNG7uypedtMrIK1KZlfJKySMs
 rsQ1DdPQMsLi9fphMNixBQYqmnOGNGLCLw2Bj1HHShdG1h7x2+bB7efoffOKgCja+
 S35GTbAql7jgoj40+GIAA2ZsNZYHh6/Cfl71CMhla+mfTtwKlq5UiOBgbcei5HJdD
 U26FmkUWf1RhqloE7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1vpF3g31UV-00O8Fh; Fri, 27
 Mar 2026 12:19:19 +0100
Message-ID: <5eee3f35-a8f6-4e7c-9ea3-c7be045ff6e2@gmx.de>
Date: Fri, 27 Mar 2026 12:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>, Aristo Chen <aristo.chen@canonical.com>,
 David Lechner <dlechner@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2026-04-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sB/F8HvpKw/9HkLNdubYv9rG3fR3vDvOGy4Lph3v7QWwuQel28m
 MJRp32IhQ4h71XWxNFRgQkD6qQnVawa4ReJHoT2YwFDZz7ilC2VLLD9C30g1996yhXQdNqN
 vq5Db+7MC5RLCP/NHsvUYyBuaQyG3TKOLfBIps9c02mmraIUd+r6pnppzUEQ1uXm6UwNyZY
 BwPTdm+TsthsuiLAZmuVA==
UI-OutboundReport: notjunk:1;M01:P0:ZyYG2FZbpiY=;vJgU3R8a8HhZKHUDUUYVdax9rzH
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

The following changes since commit c24a72c35abe9cbbeb72e2effc6b6c73cd828a3=
2:

   Merge tag 'rpi-2026.04-rc5' of=20
https://source.denx.de/u-boot/custodians/u-boot-raspberrypi (2026-03-26=20
09:02:05 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-2026-04-rc6

for you to fetch changes up to c009771427767679b5d0f2a91110eb10bfa1d604:

   doc: overlay-fdt-boot: .dtbos do not need load addresses (2026-03-27=20
10:57:08 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29687

=2D---------------------------------------------------------------
Pull request doc-2026-04-rc6

Documentation:

* TI boards
   - fix OP-TEE args
   - fix incorrect labels for boot switches
* Fix typo in pstore documentation.
* Fix document references pointing to replaced uImage.FIT.
* buildman: Add missing :: for examples.
* overlay-fdt-boot: .dtbos do not need load addresses.
* When building the documentation use sys.path.append for pytests.

=2D---------------------------------------------------------------
Anshul Dalal (2):
       doc: board: fix OPTEE args for TI SoCs
       doc: board: ti: fix incorrect labels for boot switches

Aristo Chen (1):
       doc: pstore: fix typo

Daniel Golle (1):
       treewide: fix uImage.FIT document paths

David Lechner (1):
       doc/buildman: fix missing :: on examples

Rasmus Villemoes (1):
       doc: overlay-fdt-boot: .dtbos do not need load addresses

Tom Rini (1):
       doc: Use sys.path.append for pytests being found

  Makefile                                           |  3 +--
  README                                             |  2 +-
  board/technexion/pico-imx7d/README.pico-imx7d_BL33 |  2 +-
  boot/Kconfig                                       |  2 +-
  doc/README.dfutftp                                 |  2 +-
  doc/README.odroid                                  |  2 +-
  doc/README.uniphier                                |  2 +-
  doc/README.update                                  |  6 +++---
  doc/board/beagle/am62x_beagleplay.rst              |  3 ++-
  doc/board/phytec/phycore-am62x.rst                 |  3 ++-
  doc/board/qualcomm/board.rst                       |  2 +-
  doc/board/ti/am6254atl_sk.rst                      |  2 +-
  doc/board/ti/am62ax_sk.rst                         |  2 +-
  doc/board/ti/am62dx_evm.rst                        |  2 +-
  doc/board/ti/am62px_sk.rst                         |  8 +++++---
  doc/board/ti/am62x_sk.rst                          |  6 +++---
  doc/board/toradex/verdin-am62.rst                  |  3 ++-
  doc/conf.py                                        |  2 ++
  doc/develop/package/index.rst                      |  2 +-
  doc/usage/cmd/pstore.rst                           |  4 ++--
  doc/usage/fit/howto.rst                            |  4 ++--
  doc/usage/fit/overlay-fdt-boot.rst                 |  8 +-------
  lib/ecdsa/Kconfig                                  |  2 +-
  lib/rsa/Kconfig                                    |  4 ++--
  tools/buildman/buildman.rst                        | 16 +++++++++-------
  tools/image-host.c                                 |  2 +-
  26 files changed, 49 insertions(+), 47 deletions(-)

