Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7246AC36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C4D81F28;
	Wed,  2 Apr 2025 16:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HR2I+BXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0442581CF0; Wed,  2 Apr 2025 15:22:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9589680584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bjorn@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6B48D5C6755
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 13:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C79FC4AF09
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743600169;
 bh=NRoeAy+hdPSEazsyZW60mLwTE2KwWmwUshSCO8F8NiI=;
 h=From:Date:Subject:To:Cc:From;
 b=HR2I+BXDw7XkNlsVxP5dJ7NkrV6GSKza1ViK2OHcBVwh5RhXTVX+597TX+aLCjp7X
 YUS2hqnjoa9Ho3tNSeOYbayjI0mz8iTtdLzLBdQDVmtOttxgt/2VVCjkIedLSLW634
 9aWttzCLc3IvsBODTrt5/caLCIRbBr/SkBP68dZ4ghMhf+SmJf3tPlz16eeUmb8zF9
 J0siBdHRvVbol6iDMz/KhVxtPPxl0KgLORPl8r8wegrVSSSKwZbQ0xbDkSSk5W9iet
 +XnjKoF8tM2sBzIkupg7Q0aqtpOsUhpm5ZcASGAloNjl5UTYXiUAsuYvtKPAqBeXQ6
 xSJ2YItFfTUyA==
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4768f90bf36so67656601cf.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 06:22:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1VpDPTH03QtXkwfO1KoG9C991Wy6oknY4v+qz5ysYFMEBnjt8
 q861SbCqIHJmn3fCw6NqOL9BR1ZXkpcb18yR+EI43SQYzI4swxKfwu2fgo1ozRYj6M62v426jxL
 CVLV7w8kKokaOGUm1fcd4C+lqGZA=
X-Google-Smtp-Source: AGHT+IGJKNbNy3Qw1tMfMITJ0mp2khXV7nHmN9ug6hNM5uZQmeBaErrRcPtpRHfF0sVgOGHmxSW0nLLHtBG/BjCW3Bs=
X-Received: by 2002:a05:622a:1cc4:b0:478:f76c:191d with SMTP id
 d75a77b69052e-478f76c1b05mr109483451cf.52.1743600168252; Wed, 02 Apr 2025
 06:22:48 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 2 Apr 2025 15:22:37 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqb-OjvQpfian5DPZmKQB_DG-l2rmvzJ8P0AbNUGhpW2Uw-gPNK3bzT5Ks
Message-ID: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
Subject: RISC-V UEFI/ACPI on QEMU regression?
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Apr 2025 16:06:08 +0200
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

Hi,

I think I got a regression from commit 53d5a221632e ("emulation: Use
bloblist to hold tables"), and v2024.10 for
qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEFI.

TL;DR: It seems like the RSDP is placed in the wrong EFI memory map
type (it should be "ACPI Reclaim").

I might also be misunderstanding what config fragments should be
used -- I'm out in the weeds here! ;-)

When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. All
good, and e.g. a kexec would properly work. However, when using u-boot
with commit 53d5a221632e ("emulation: Use bloblist to hold tables") I
get the following when booting, and then kexec:

First kernel:
[    0.000000] ACPI: Early table checksum verification disabled
                                                  [    0.000000] ACPI:
RSDP 0x000000047EED3000 000024 (v02 BOCHS )
Kexec kernel:
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI:      0x000000047EED3000 000000 (v00
  00000000      00000000)
[    0.000000] Oops - load access fault [#1]

RSDP reside in:
[    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   |   |
 |  |  |  |  |  |  |  |  |   |WB|  |  |  ]

(Boot Code vs ACPI Reclaimed)

Now to get qemu-riscv64_smode_defconfig + acpi.config to build
post-2024.10, I needed to add the following fragments:

  CONFIG_BLOBLIST=3Dy
  CONFIG_BLOBLIST_ALLOC=3Dy
  CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000

which is really just a "make the build not complain", guessing game
from my side.

My guess would be that it's related to the change in
evt_write_acpi_tables(), where:

-    ptr =3D memalign(SZ_4K, SZ_64K);
+    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);

is done.

Is my config fragment broken, or is this a proper regression?


Thanks!
Bj=C3=B6rn
