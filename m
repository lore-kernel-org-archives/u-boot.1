Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFBFCA0FFD
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 20:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227888383A;
	Sat, 30 Aug 2025 22:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VdzwgMTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C65D83881; Sat, 30 Aug 2025 22:33:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9C48380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 22:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756586033; x=1757190833; i=xypron.glpk@gmx.de;
 bh=rOYs179HVuziQw5wEKDF7CZOxMcMzVvNTGC9RSXKJ80=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VdzwgMTOoUjF0NCud4NFbFtMrgBD0Oc+5IP43Ud96v9lnXek0ILPGIIxZmpql/pW
 bXRFY4c0mZWBYRSL8SqdmTa8lu0LXEj8gu69Gi+09IWfmQoIawx1PFVxPjlNzn8XE
 WTACrV9Ji76HyilU7HfmeKVkQycEFpxtcQFWG3zzRnJQtEkGijKM/KXRpvUrBthcT
 Vb2OZrYTddsHJ6vQK8GmzUHkeF4vpM88a3dk3eupLSiiTIUgMhlMQ1AAtizr+Jdfw
 WqO7QbkKGdyALp9P1DxHVzDQj+0IjjDR1FPxPiPKWzDBmreHIpKBPhY3UyfYLOjWw
 A1Z76xfqLeR94cvUWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1ufWMQ2pZ1-0080lx; Sat, 30
 Aug 2025 22:33:53 +0200
Message-ID: <a70fe45c-e278-41b0-8911-cc6dffc8263c@gmx.de>
Date: Sat, 30 Aug 2025 22:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request efi-2025-10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WrqXowxlXd3RBY/kbLTAZRMuFHT78yDOkm4mdo25iKLwIp81a0k
 +XpkgNR0tom+vofjJ9CYb9WzmV3r364R6SlS+XKrLslKDW2DR9ZRxHUqGC0QvvsNBDa9ud/
 yHR2Q2r7FAOaqy9ql5M6Py7oClY1Gc7CjWbsXZWAzocCR6DUpdlhhQisJ7nAsALloTfj/OP
 0Rk4a5jGx2Lq2shm7WZKA==
UI-OutboundReport: notjunk:1;M01:P0:5K/Ku3zg8xk=;cSYjz1KB1sdPc6XzjZlH5k/Pm+9
 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
 XKOkETqoBhuxhwyGTbc
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

The following changes since commit e4c8b32d03d7ecffd586b7d33336603ad639d7c=
0:

   Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-08-29=20
14:58:45 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-10-rc4

for you to fetch changes up to d20b8792c5228a8d9f20943660d61ea5b2c60232:

   arm: Fix swtiching typo (2025-08-30 20:45:33 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27527

=2D---------------------------------------------------------------
Pull request efi-2025-10-rc4

Documentation:

* Rephrasing and text corrections for buildman

UEFI:

* Serial: Use correct EFI status type
* Let EFI_HTTP_BOOT select CMD_DHCP
* Let  EFI_VARIABLES_PRESEED depend on !COMPILE_TEST

=2D---------------------------------------------------------------
Adriano Carvalho (9):
       doc: Fix obvious typos and minor improvements
       doc: Quote all long form options using double backticks/grave accen=
ts
       doc: Use "supports" instead of "has"
       doc: Add riscv and unfold the list with the architecture/code name
       doc: Rephrase in a simpler way
       doc: Rephrase to be more clear
       doc: Rephrase to read a bit nicer
       doc: Rephrase to be more precise and less confusing (build)
       doc: Capitalize the word Buildman whenever it's used as a proper no=
un

Andrew Goodbody (1):
       efi: serial: Use correct EFI status type

Jan Kiszka (1):
       efi: Select also CMD_DHCP from EFI_HTTP_BOOT

Simon Glass (1):
       arm: Fix swtiching typo

Tom Rini (1):
       efi_loader: Make EFI_VARIABLES_PRESEED depend on !COMPILE_TEST

  arch/arm/lib/bootm.c               |   2 +-
  doc/build/clang.rst                |   8 +-
  doc/build/gen_compile_commands.rst |   2 +-
  doc/build/reproducible.rst         |   2 +-
  doc/build/tools.rst                |   9 +-
  drivers/serial/serial_efi.c        |   2 +-
  lib/efi_loader/Kconfig             |   2 +
  tools/buildman/buildman.rst        | 215=20
++++++++++++++++++++-----------------
  8 files changed, 128 insertions(+), 114 deletions(-)
