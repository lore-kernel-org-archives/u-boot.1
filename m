Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC13E68956
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 07:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F020489262;
	Thu, 31 Oct 2024 08:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kJgG/Kit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7958989285; Thu, 31 Oct 2024 08:01:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3079A89241
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 08:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730358106; x=1730962906; i=xypron.glpk@gmx.de;
 bh=9NL8QGnIzOMwWNGCJCxtX8LPpE+K0Kcae/8KAjA0fIU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kJgG/Kitz0ZVErJMUZucYEq+tz09pY/HE+RGizmywVaeiqYnrNWSn9NWAt+DAH+m
 BTZKCFABhll3k4/uyjj7/+vf65wgpK8hGe/2DJB8vmp/5v6GFMCFpzaZgGP9LC9d2
 5izkDnKCkoEsjKGMAe07GB/rHEMvY12e4ymz3Y3+vhtYJLR17DH+RU5n/i5M+aTiS
 Qg68vf/SCsreR0pn5+MQPHb0PwHMrqbf3uJW72Hlwr2m5etBCwS2ZC0MIZirXLaIL
 3IbkoIsuEN2TL4YOKNDlyxySbWI3KERNvIXIggN8eHiUdHQM0WldQQHlZBLygnr4H
 TBY7vgaaAoQQAoHlIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1tpP2d0b5R-00sgO3; Thu, 31
 Oct 2024 08:01:46 +0100
Message-ID: <4a9ac367-e504-4a6f-8614-0084047274ae@gmx.de>
Date: Thu, 31 Oct 2024 08:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-01-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bSgZppQu2wNn0e5qxAitJegX9/ipj3eLgOUcK+zNGLe4pCqZYQu
 Lx9LuK1CrFZHxvHX7meFvGi6BIzvbVxQ3ygAOjnYVOqDb3SJ3MNR6yGtzjHvYYTHEq3luZU
 NSp9t0QsIIuwJwlGp434qL4iDJGXbChq91qJ3vcJm2b/GyxbZqBVbF1W9X/q/BIHJ+MvQ4A
 Bqk1MZQ8X3UuVb06c/GNQ==
UI-OutboundReport: notjunk:1;M01:P0:K3bIpRLBAPY=;52O0jfhZho+U1jOhXWsRweF5d+d
 3ipJ1h78PixRp34SSOoEjoiTDZ1jK4y36WyzKChUe6Ugn8HaVOWugjPRGDLmsaE4aI6J2GDgt
 hARDyKibf3J/aqvQB6jjkHR11BG5vgI5gRbErGSoq6LFK6e39oJn32v1QapCgkq6o3vWpOo2U
 iC163ATWqCJMVHeviflUPzkHL8bbbOMUPsRcCHXKCXwssY7y3OQg+YvhZtSAfNBijUi9WEV6U
 VM1LjXzCBmesKy1yX46HmDsYx/9woP6aCOmb5dH3A+vbHalj0r9Sgovf8a3Xhm+5wd9JTPcAZ
 +/OVTKPMa+G8j97J4MDo9fqZ0SS5dfQugfuog4wKDW4bjloHYgChulZhZYGCzarSaL5APR3NQ
 FwJVYXEsEc5VumS9S4tRxnkPJ0KnpbaszB2Wy/oqTEgd+AEz2Kb4kUlb+CU02AsLsAJMt1ePw
 GCCKEyAC7X8D80DaNec2A/Td4DoKCX6jMz05k3LaRUpXdnbvkCox/2v8jUoFM/ozFTw9XTVEn
 q9geWDy+gNof0S+x6ANN+vqi5QEUShZvbbbeZZRoruEED1y25wlRKSDXVUWwWDPWqqeNiCWiW
 JKrBYl2fdEm96EyJ1H/g2HkO+JP7rondI7H3/TCFFXJZ9vYq9Ht/thHYirfyOWyDpYTGqtaQ/
 FgQdrA6w4CY2z1fgYHlHLue51LUnog9VoaXl1ArSm+a6MgHAo6FilgFJboJ25iOn2PTNkmiK0
 TTgbvYcWuZ6oFr5Z3c4U2zB3NiQvZBLQGU5O/a7C3i3+aYrM9VCkDNhrnlbPw+O3mHZHuetuQ
 USNSMY3RNA8rPrR21q/aSBjA==
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

The following changes since commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9e=
b:

   Merge tag 'u-boot-imx-master-20241029' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-29 18:46:08
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-01-rc2

for you to fetch changes up to 7596d77bc1b6be838e38af3fb4e73dbd0a0a078e:

   lib: efi_loader: Fix efi_dp_from_mem() calls (2024-10-31 06:05:39 +0100=
)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23113

=2D---------------------------------------------------------------
Pull request efi-2025-01-rc2

Documentation:

* include semihosting and K3 boards only once in table of contents
* include file-system API into HTML docs
* describe struct ext2_inode
* update Python requirements

UEFI:

* mark local functions static
* simplify efi_free_pages()
* pass correct end address value to  efi_dp_from_mem()
* fix typos in HII test and eficonfig command

=2D---------------------------------------------------------------
Heinrich Schuchardt (10):
       efi_selftest: fix typo 'got languages' in HII test
       efi_selftest: make HII test data static
       efi_loader: fix CONFIG_EFI_HTTP dependencies
       doc: semihosting can only be once in TOC
       doc: do not include K3 boards twice in TOC
       doc: update Python requirements
       fs: improve API documentation
       doc: include file-system API into HTML docs
       fs: ext4: document struct ext2_inode
       cmd/eficonfig: capitalize 'enter description'

Ilias Apalodimas (6):
       efi_loader: Simplify efi_free_pages()
       efi_loader: Mark efi_bootmgr_release_uridp as static
       efi_loader: Mark static function in dumpdtb
       efi_loader: Mark static functions in smbiosdump
       efi_loader: Remove unused diskid
       efi_loader: Make tcg2_uninit() static

Moritz Fischer (1):
       lib: efi_loader: Fix efi_dp_from_mem() calls

  cmd/eficonfig.c                                |  2 +-
  doc/api/fs.rst                                 |  7 +++
  doc/api/index.rst                              |  1 +
  doc/board/emulation/index.rst                  |  5 +-
  doc/board/ti/k3.rst                            | 11 +++--
  doc/sphinx/requirements.txt                    | 33 ++++++-------
  include/ext_common.h                           | 33 +++++++++++--
  include/fs.h                                   | 66
++++++++++++++++----------
  lib/efi_loader/Kconfig                         |  2 +
  lib/efi_loader/dtbdump.c                       | 12 ++---
  lib/efi_loader/efi_bootbin.c                   |  1 +
  lib/efi_loader/efi_bootmgr.c                   |  2 +-
  lib/efi_loader/efi_device_path.c               |  3 +-
  lib/efi_loader/efi_disk.c                      |  4 --
  lib/efi_loader/efi_memory.c                    | 14 +++---
  lib/efi_loader/efi_tcg2.c                      |  2 +-
  lib/efi_loader/smbiosdump.c                    |  6 +--
  lib/efi_selftest/efi_selftest_hii.c            |  2 +-
  lib/efi_selftest/efi_selftest_hii_data.c       | 28 ++---------
  test/py/tests/test_eficonfig/test_eficonfig.py |  6 +--
  20 files changed, 138 insertions(+), 102 deletions(-)
  create mode 100644 doc/api/fs.rst
