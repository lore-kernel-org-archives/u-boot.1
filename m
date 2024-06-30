Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AE4C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 13:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1388785E;
	Sun, 30 Jun 2024 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="T8hTsfQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D9E87B77; Sun, 30 Jun 2024 15:21:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA8587666
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719753687; x=1720358487; i=xypron.glpk@gmx.de;
 bh=zM9i3GUgT9mJl4dgwv+wdKpldtIuxtaAVLTIWvTH6mc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=T8hTsfQi4E/ZK8W924jQBPRUKOt7R/u8WUIlfDEIl0es5o2xSWw/QKdZ9Y24hesv
 q8/XKfiKpHVyEKJLFZCi5dTF8tfQSOztFHBLkNZhppMXqccAJzVloRr7qGzU8BNmA
 nM+z8vDD6psbOUdyDTweoQW0DN40hEXVZRzrfz3ESpZELx41L2XuCSAXU/GhmmfdL
 kOhu9JQ2HsCFtMEFu7ijMf/yM0/ogOzp1uKZobwoi08gQ9TM+6BdjOZG9INTaxYy1
 vcIft/mEPCwry56w+26kywcYTjTXY8gh32luLfZLUu2duaX7Fz1VAHoun9pi6Gb7U
 ToovYUMnQYRTNc3Bsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1sWT5D3EjR-00Bn1U; Sun, 30
 Jun 2024 15:21:26 +0200
Message-ID: <55093256-50af-4d2e-9a30-433bee153f13@gmx.de>
Date: Sun, 30 Jun 2024 15:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 Bastian Germann <bage@debian.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-2024-10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cXxePz4vkNHM8Be8H+pSOY5r6dp0Vjl+EimsnvY80uSJge9ay92
 6RmL5NRh4TW4+eZ3R8p38fK6SaytqOeRKWFmtxxwcKya/k+m+6NUAmDjU9Tr5KeAsVd5g73
 2reIyXf9F8Tdjl5KhU++S9T3fZOyFDjmgQgHaMriC+0TGu9aTNUWApVAVQeOyA/Fq8DZTY2
 9P9Ud/4QSrhqlMk92IKPg==
UI-OutboundReport: notjunk:1;M01:P0:ZR+jk6IxfZs=;joIU9+pjvBSUkUno6LFmTzs2wXd
 yqDEz9I9VYSIdCncTp5Sr+xYvruSm2F58XhQImAXHqKtRiW6JfPoqZHl7Rz1hld7gXCfuBtU0
 LPY57um2wYadCq4/zGJOWRQF/x2WQlcwo81I1IU59z6FqbL9KglfCRuFWG6gXgnDeu4gdR37q
 ez5Tf/QLfBEPwpsm2AWBlhZrB+9bGZA0/TU4lX35VnIpCraiaY7mzgzjyee3sm/SRy/OIfxsq
 XVE0JTU52PeJmHArxa8hIl2nnEVKBNtwyxOiOq0Hw6l8cL6YsUADRsv5coodA6hMK4/DXmiFg
 o6jRYna+v+O4AOwbx0n3ZBeqJNUhnoIuzeG5VO7GJzNb1NCeduCxXFX8X2uZkLfsct2y8vKr0
 3VbFzpjRkHIdD4cTClnFHlj0Xxxi9JGRElB7Wpc0UrN2XBNEymYdkFHhG5XhNMEH/qU/f+54w
 qpr7VyPdhbsAlh00a7m8gEePx+DMYVzdlVKPIpwRVangTsE2JUXMM/JfL8DJcjk2fbz+gzncJ
 SekV7DLeC1TKcVOax5CUy+4cbUEREbcGe2ftTce9xdhHwW5p0yRtop10vM7re1e9EXeO+hajG
 Qcz8h2ZjQ0vCQ0VvNA6xJux12m13afiNB51V71X5ZndCEdlz0244Kz7yfGnvcWrdWBqVyjiZM
 fYrZ64IuQdhfSnkHhCaefHsjY2DauEIrNV/WqdcHJKMo0w3MCqCqgtc02qJouEpdEuBCDFE9f
 Pnz+m8jM9HpxJr5EveyvcJyeyUsqsiv+iO8w64Iu7L8Ea/Xhp+Ze8VDT7u3lrBYViYni7vlxt
 +zh/RiAQTR7wyZTrJcOXZF7C5UG3WHFYaq7FxV+Po9X8A=
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

The following changes since commit 899b088674b6905710ce546f0a8848662904852=
a:

   Merge patch series "pxe: Add debugging for booting" (2024-06-26
13:17:52 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc1

for you to fetch changes up to 636480e4e7088d05d7ff77af72ca00443c62b3e9:

   doc: develop: Add a general section on gdb usage (2024-06-30 13:58:31
+0200)
Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21383

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc1

Documentation:
       Update requirements.txt to use current Python module versions
       Add a page describing debugging U-Boot with GDB
       FIT: describe data-size as a conditionally mandatory property
       Correct link to FIT specification in SPL code.
       Correct kaslrseed command long text description

UEFI:
       Add unit test checking that don't have kaslr-seed when measuring bo=
ot
       Deduplicate code for measured boot.

Other:
       Print size information in fwu command

=2D---------------------------------------------------------------
Alexander Dahl (1):
       doc: develop: Add a general section on gdb usage

Bastian Germann (1):
       doc: fit: Make data-size a conditionally mandatory property

Heinrich Schuchardt (4):
       doc: update requirements.txt
       spl: correct link to FIT specification
       efi_selftest: can't have measured device-tree with kaslr-seed
       cmd: correct kaslrseed description

Ilias Apalodimas (6):
       efi_loader: remove unused TCG algo definitions
       tpm: Move TCG headers into a separate file
       tpm: Move TCG functions into a separate file
       efi_loader: remove unneeded header files
       tpm: Untangle tpm2_get_pcr_info()
       tpm: allow the user to select the compiled algorithms

Michal Simek (1):
       cmd: fwu: Also print information about size

  boot/Kconfig                         |   4 +
  boot/bootm.c                         |   1 +
  cmd/fwu_mdata.c                      |   1 +
  cmd/kaslrseed.c                      |   2 +-
  common/spl/spl_fit.c                 |   2 +-
  doc/develop/gdb.rst                  | 171 ++++++++
  doc/develop/index.rst                |   1 +
  doc/sphinx/requirements.txt          |  16 +-
  doc/usage/fit/source_file_format.rst |   6 +-
  include/efi_tcg2.h                   |   9 +-
  include/tpm-v2.h                     | 388 +++---------------
  include/tpm_tcg2.h                   | 348 ++++++++++++++++
  lib/Kconfig                          |   6 +-
  lib/Makefile                         |   2 +
  lib/efi_loader/efi_tcg2.c            |   3 +-
  lib/efi_selftest/efi_selftest_fdt.c  |   7 +
  lib/tpm-v2.c                         | 767
+++--------------------------------
  lib/tpm_tcg2.c                       | 731
+++++++++++++++++++++++++++++++++
  18 files changed, 1386 insertions(+), 1079 deletions(-)
  create mode 100644 doc/develop/gdb.rst
  create mode 100644 include/tpm_tcg2.h
  create mode 100644 lib/tpm_tcg2.c
