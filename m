Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB31106FD81
	for <u-boot@archiver.kernel.org>; Sat, 14 Mar 2026 09:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258B4842DF;
	Sat, 14 Mar 2026 10:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lNQNA/N1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801AC84332; Sat, 14 Mar 2026 10:28:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACCC842CD
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 10:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773480476; x=1774085276; i=xypron.glpk@gmx.de;
 bh=ADR4XFwhSy3+07zswJXKYLwo2S0+7yTCQMDWoXIRkh8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lNQNA/N1kUHjwCpRl6hdCfdei4K2X0BAwIPZgUVIdbKgVTIWNbsHNIk9dctvSWm2
 ObmpOCU0uP7vUwrPh44Jedw0XUsJfzkWoQi8qNHMqz0WXfhOHppJShrkPWRGoalPJ
 HoPR50Gc5xv0cs/gufmSxcn/UdSNbPDVaavwTIx5rkGNKs3/bkCjZM7ERtKt5ZfWE
 /G7At6v0HVYh1U4ZLmGA72JhBRsqFU0CCpWvTOsjuMERYjAT45AC1h0GLFZw8fn+A
 dq7HsDHSMATmhyndfPMcXspZbzAcSvbuJteRTM3l50XGMJWqqn9dCUKpCajMo/6vl
 Vs3YP6c9F7Een1iYTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1va1NI1rGu-015iOc; Sat, 14
 Mar 2026 10:27:56 +0100
Message-ID: <6a7870e8-bd72-4a6c-a513-0ed819db67b4@gmx.de>
Date: Sat, 14 Mar 2026 10:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-2026-03-14
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D0rLN3ZmQv1Zx1bMP4CA3SCC0f9/PVkoRWYKAiQy/WnwcP5BeOT
 xJUE2lmOAnehyRMmwcsSgVK2K2HswnFrsuvupwel3Vprfb6Pb8Op6ejSflzOWlyokfnbEvV
 bJPQvoT0g6O5OiMeTldOM9kmqLzHUNAwaTpT7dbcg8Nwo4/UygR1FED6Sw60C+il0niWSqo
 ZZzY1c/u8fqdC0CaJ2FZA==
UI-OutboundReport: notjunk:1;M01:P0:3MR8nULm/Vs=;pT4+Tg9Sk+K5YQ9oPdifTaT9tBS
 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
 c/BOXwzG9QsRDwrae4mL
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

The following changes since commit fab3b667b4128fae2d94752bb03088f84dafcf8=
9:

   rockchip: rk3568: Include all addressable DRAM in memory map=20
(2026-03-13 16:17:15 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-03-14

for you to fetch changes up to 8f83a4596677fe6a3f3b587b76d460644205a922:

   cmd/exception: missing include string.h (2026-03-14 08:36:53 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29512

=2D---------------------------------------------------------------
Pull request efi-2026-03-14

UEFI:

* Require at least 128 KiB of stack space to use EFI sub-system.
* Avoid buffer overrun in efi_var_restore().
* Avoid superfluous variable store writes on unchanged data
* Implement SPI Flash store for EFI variables.
* Add an efidebug ecpt sub-command to display the ECPT table
   and a unit test for the command.

Others:

* Add missing include string.h to make exception command build again.
* lib: uuid: add EBBR 2.1 conformance profile GUID

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       efi_loader: require at least 128 KiB of stack space
       efi_loader: avoid buffer overrun in efi_var_restore()
       cmd/exception: missing include string.h

Michal Simek (1):
       efi_loader: avoid superfluous variable store writes on unchanged da=
ta

Shantur Rathore (1):
       efi_vars: Implement SPI Flash store

Vincent Stehl=C3=A9 (4):
       lib: uuid: add EBBR 2.1 conformance profile GUID
       efi_loader: export efi_ecpt_guid
       cmd: efidebug: add ecpt command
       test/py: add ECPT tests

  Kconfig                          |   8 +--
  cmd/efidebug.c                   |  49 +++++++++++++++++
  include/efi_loader.h             |   7 +++
  include/efi_variable.h           |   8 ++-
  include/exception.h              |   1 +
  lib/efi_loader/Kconfig           |  35 ++++++++++++
  lib/efi_loader/Makefile          |   1 +
  lib/efi_loader/efi_conformance.c |   2 +-
  lib/efi_loader/efi_runtime.c     |  24 +++++++++
  lib/efi_loader/efi_var_common.c  |   4 +-
  lib/efi_loader/efi_var_mem.c     |  29 +++++++++-
  lib/efi_loader/efi_var_sf.c      | 111=20
+++++++++++++++++++++++++++++++++++++++
  lib/efi_loader/efi_variable.c    |  27 ++++++----
  lib/uuid.c                       |   6 +++
  test/py/tests/test_efi_ecpt.py   |  42 +++++++++++++++
  15 files changed, 338 insertions(+), 16 deletions(-)
  create mode 100644 lib/efi_loader/efi_var_sf.c
  create mode 100644 test/py/tests/test_efi_ecpt.py
