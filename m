Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9958ECCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2452982C84;
	Mon, 20 Oct 2025 11:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nI7sfDFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F19A83043; Mon, 20 Oct 2025 11:13:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95B7807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760951591; x=1761556391; i=xypron.glpk@gmx.de;
 bh=NZbhk+yictOW3UyF/MQddaA/qG4dplLh7L5lIcESL04=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nI7sfDFzlkLvXXXUxmn4WqIUdRzeP+xIeCBL0XBGLDxxj4FQd5DPRK7r7jYPFjQ6
 GcezsIeEbiF3BQK2d4IccUOXjWD95RSErVUQ4epF4ayPm7giu4+asI1C97Ghp/Ift
 wn2izg7ZjoxO4waAt1anMGNB2k76x5mHZxGDuGo6sR7QN2PlE4WxWL/HB+PICWRNg
 6ifsTblRAUj2GSsiX8tFm7L1XxWrKzHyhtSdcQfMsGCubSZOadHAKU5NqqIx0tOKL
 9uY6Er3QEuq4hvoULjZdN22Avz7OfmzdZtLXYxeOL/sxPM0hb+LhqvzJXlk3ib6HS
 05T1hq60q+MXw0dVKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1uldNp49MN-00YEfC; Mon, 20
 Oct 2025 11:13:11 +0200
Message-ID: <9b25f391-944c-4ca0-b990-ed5caf0a3e8d@gmx.de>
Date: Mon, 20 Oct 2025 11:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Mattia Narducci <mattianarducci1@gmail.com>, Lukas Zirpel <lukas@zirpel.de>,
 Brian Sune <briansune@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1w06FCQNK7cur5t37jLc1A3GdOZSpGTLnQWc3n8nP9g4T/6zXGM
 EmiOErexuOIv4roZNUjvkt2XK+QW3nq17tJriJGDCHmKVShV6JfmC4DxAOgqzfWEs96LVfi
 nVZRbua6kjnY1jMJdgc7pfWOsZMtz/32sEk5w1BWCHOdu9yyKf/W1xpO33wn7Ybhqk6tKDp
 rXTnnueWVZ9I/f2V65KcQ==
UI-OutboundReport: notjunk:1;M01:P0:ifg/mZHHW2M=;uASmSzAb8eK8x5ja+wtaTyGeJmw
 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
 PM6saONMf3bs0WFRCbWHtw2ATpOkIkefJ18=
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

The following changes since commit bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc=
2:

   test/py: Update to a newer pytest release (2025-10-16 18:03:27 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc1

for you to fetch changes up to dbac24b7137b7d1576aead857850121af92f0a51:

   doc: ti: j722s_evm: drop outdated boot note (2025-10-18 12:01:16 +0200)

Gitlab CI showed not issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27944

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc1

Documentation:

  * samsung: Extend E850-96 documentation to be comprehensive
  * environment: fix links to Linux kernel documentation
  * sandbox: fix typos
  * document dmareset command
  * ti: j722s_evm: drop outdated boot note

UEFI:

  * Prevent leak of memory from tmp_files
  * Correctly check if the HTTP protocol is found
  * Use ESRT_FW_TYPE_SYSTEMFIRMWARE instead of ESRT_FW_TYPE_UNKNOWN
  * dbginfodump: use guid definition

Others:

  * lib/uuid: add support for efi debug image info table guid

=2D---------------------------------------------------------------
Andrew Goodbody (1):
       efi_loader: Prevent leak of memory from tmp_files

Brian Sune (1):
       cmd/dma: documentation

Heinrich Schuchardt (1):
       efi_loader: correctly check if the HTTP protocol is found

Ilias Apalodimas (1):
       efi_loader: Use ESRT_FW_TYPE_SYSTEMFIRMWARE instead of=20
ESRT_FW_TYPE_UNKNOWN

Lukas Zirpel (1):
       doc: sandbox: fix typos

Mattia Narducci (1):
       doc: environment: fix links to Linux kernel documentation

Peter Robinson (1):
       doc: ti: j722s_evm: drop outdated boot note

Sam Protsenko (1):
       doc: samsung: Extend E850-96 documentation to be comprehensive

Vincent Stehl=C3=A9 (2):
       efi_loader: dbginfodump: use guid definition
       lib: uuid: add efi debug image info table guid

  doc/arch/sandbox/sandbox.rst  |    4 +-
  doc/board/samsung/e850-96.rst | 1023=20
++++++++++++++++++++++++++++++++++++++---
  doc/board/ti/j722s_evm.rst    |    5 -
  doc/usage/cmd/dmareset.rst    |   55 +++
  doc/usage/environment.rst     |    4 +-
  doc/usage/index.rst           |    1 +
  lib/efi_loader/dbginfodump.c  |    4 +-
  lib/efi_loader/efi_capsule.c  |    4 +-
  lib/efi_loader/efi_esrt.c     |    2 +-
  lib/efi_loader/efi_http.c     |   16 +-
  lib/uuid.c                    |    4 +
  11 files changed, 1042 insertions(+), 80 deletions(-)
  create mode 100644 doc/usage/cmd/dmareset.rst
