Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D7C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 08:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AF78809D;
	Sat,  3 Feb 2024 09:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="czoOW7yD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A72EE88117; Sat,  3 Feb 2024 09:57:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F8E88053
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 09:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706950649; x=1707555449; i=xypron.glpk@gmx.de;
 bh=kDJQNH9pceNjn6rvVh64ahEXsynCzMIRsrLd0yyycak=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=czoOW7yDsgmxkj3yy/iI/sxyQTmR2Pi6nlc6SneDb65XIjg+ezV/IHY+PtoIjo80
 4g7nnlZ0f+M5V7UDjX9dKzmRNrlgW2WOq4fphJdyNSx63z0SPARU+6FUqObrJru+Q
 hKzAYIfT6jABoyPo+kfx4HT6AAcov1o2TJZRm3hwhWGNOmbBYyMgMIyH5BAtZCoyh
 lvL+oCnyqNnWDiyljWyEQarHjQeqYmUZQpp7xxtoAvc/k78TnREkhRjeyoDpsvRV7
 Tf/CwiSEUdil7yAZGaQm45CCXTBiKBt3tnxxB8j0TkosxazUKNVYCBZP0NflAQ3lB
 W4Cqsutyp7i7yVNqlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1rFtkF3JXD-00HKk8; Sat, 03
 Feb 2024 09:57:28 +0100
Message-ID: <0ff1a399-e295-480f-9949-4e021f0794f4@gmx.de>
Date: Sat, 3 Feb 2024 09:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Matthias Brugger <mbrugger@suse.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request smbios-2024-04-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dyjLZU7wrTeVlge3ElAfdKfGPqEfNSU4NfoB5ZNWfKNwFe3vrRa
 UzTe1ck1i72X3nf5Oebow2yyAw3/nfUqmCG6yDVby0hllTpTgBmrHh89gNTIpTpXL32tFj8
 7Wd/9x9r9qEs2auaKaQ96G5166mlrTuTCQ+y7mHwmE8Xy3HOkka2xZIJQs0vIAURHQpyRJ3
 fjTUVGA1hNBGoV9r+cV3Q==
UI-OutboundReport: notjunk:1;M01:P0:+kWuT9RSOCU=;DjFdmQES/BTsqZ2F+tcqAnr8VQp
 cr56qYoyMwfLabbfIRc2FCjaBCWRGBweEVh/VZgs7YWOmfJt38a2G37KB1zPrHVkA0lyJ5nDy
 hXyFC7HHN4ku7NEmLQLslBoH4qsfIzu91BIxjM7cT92s5q6tRZl+SGEi6YY1Tuo7pZFdELe7L
 Z1EZXYSA1NPD4M3dSQPaEmMXnHMZOJ9YN6iu4HofDI5NLjl86yV44TYGtyq9W5slRvYtyoY9z
 TlOjDMM91TuMJfQvxdJQZSS0pQgOnZk2559MwiALIgVpqiBXt8AK2A2Y89msY8dj/nRhjARaT
 uc6s7JtdKCp6HTjXC71YpmmI0XcnWLEyf50GTJH+vDfsrQOJVA/S7Rr98l/+8Tn3jrptun5IT
 w34NrB3jyBEmx5wNzEE4nZHyc3UvdXOA5yR5wwM7mu0cH9OqvcWpYWrrW06gOqYyP34S7n9JR
 /bALCJEGJ/oEkpUsI5Huw+clD/5nhngmtL/sTJ/J/crD0E9Mfi/dPTliaV2U5VoDUGAZljVg+
 UvdOdwIjpvjA8PxpMSDis+ipIcFs1ugDeO2fh9ZEI0ub7FKzh7EtFOqFtYt2lV4gmO0nrSEsC
 vZV3FB6PG7HbQSDOltBLgit/IrBB72ZnVu+LW6u4hxCaH2wQeu/S4Zeahfmp9Ddrs9Es/3cG9
 wQEeYzs1viR6wiH/boEUkRbmYiXgp3VxlzGihex7LumZkAWHtjEDeOEAeXgP5oxHHlBTutAH/
 F46YMGcVXXo4bdOgrT01+ukWZcYIcLF0s7Z2JaFiR4bS7QpwjDnBt80gL+4wIUJJmGHjsKjqT
 YBOjGh3MDNUvqG2RsG9ILqlFfDYjrukBHe7VOX1eA8ZBI=
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

The following changes since commit 050a9b981d6a835133521b599be3ae189ce70f4=
1:

   Merge tag 'u-boot-amlogic-fixes-20240201' of
https://source.denx.de/u-boot/custodians/u-boot-amlogic (2024-02-01
09:59:53 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/smbios-2024-04-rc2

for you to fetch changes up to 406c410ef747d66e16f2f5494cbf88ba1307224f:

   smbios: correctly name Structure Table Maximum Size field (2024-02-02
19:57:45 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19538

=2D---------------------------------------------------------------
Pull request smbios-2024-04-rc2

* In smbios command
   - write 'Not Specified' for missing strings
   - show correct table size for SMBIOS2.1 entry point
   - adjust formatting of handle numbers
   - add missing colon after UUID
* In generated SMBIOS table
   - avoid introducing 'Unknown' string for missing properties
   - provide RISC-V vendor ID in the type 4 structure
   - provide the correct chassis handle in structure type 2
* Rename Structure Table Maximum Size field in SMBIOS 3 entry point

=2D---------------------------------------------------------------
Heinrich Schuchardt (11):
       lib: smbios_entr() use logical or for booleans
       smbios: get_str_from_dt() - add sysinfo_id description
       cmd: smbios: always use '0x%04x' for printing handles
       cmd: smbios: add missing colon after UUID
       cmd: smbios: replace missing string by 'Not Specified'
       smbios: if a string value is unknown, use string number 0
       smbios: provide type 4 RISC-V SMBIOS Processor ID
       smbios: correctly fill chassis handle
       cmd: smbios: show correct table size for SMBIOS2.1 entry point
       smbios: do not determine maximum structure size
       smbios: correctly name Structure Table Maximum Size field

Matthias Brugger (1):
       smbios: Fix table when no string is present

  cmd/smbios.c                | 20 ++++++++++--------
  drivers/cpu/riscv_cpu.c     | 12 +++++++++++
  drivers/misc/qfw_smbios.c   |  2 +-
  include/smbios.h            |  2 +-
  lib/efi_loader/efi_tcg2.c   |  4 ++--
  lib/efi_loader/smbiosdump.c |  6 +++---
  lib/smbios-parser.c         |  4 ++--
  lib/smbios.c                | 49
+++++++++++++++++++++++++--------------------
  8 files changed, 60 insertions(+), 39 deletions(-)
