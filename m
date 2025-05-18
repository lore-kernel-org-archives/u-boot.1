Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FDC3ABD8
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 08:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2768C80584;
	Sun, 18 May 2025 10:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SWrS0cBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B13A8059D; Sun, 18 May 2025 10:51:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1A68004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 10:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1747558261; x=1748163061; i=xypron.glpk@gmx.de;
 bh=75vDZfQfMKRdjFsfmq0uV3sLGwiIVqNh21JqkAnB03U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SWrS0cBy7K7+Uiu7jMPCf193JI9kAnSmnp+X3oSFrt/zHounCp8QlOZuFrDLqGk9
 K/oSpvxhY/7dnTx+bRr0fzerC4u/kGpQbKdP0Kq3bAjprd1M93ElfDVmR15aJDSSt
 xnZf21RUZHiEzhSA9466cJ8U6o9B2BHh37l0Ph9RJWQr7ktoqYqBMepk5AhRe4c3i
 FIcMNo5t7Cphnvq0RoKp3NQvJTwxZn/clBOxNN8e0cWWuqCZl680Zb2XJKsfa4Vbb
 Gub0kT3agfUN+SbRcNVFbbvpy7Xijjx/Q/qgBP/XYl6xPSh4DWt13R5jnkhGtUwFO
 c2UntnFkEBd8LTPijg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.104.35]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1u9z5B1iVE-00Fxod; Sun, 18
 May 2025 10:51:01 +0200
Message-ID: <98d37342-2e0d-4de1-861a-6b8d95d867ea@gmx.de>
Date: Sun, 18 May 2025 10:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-07-rc3-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TJCfPqBRMA+P4MegEk0ANLHgD2CbAYmu/vs3XXxq3ekgQy6Ki8j
 +F6Y+4omQi6vdVtkMsLNBeO+PoHKlRj/ZLh44sDyvrNU0H+qBcs3yy+6v0A7uHl+dXcsD5t
 x3xE0M1iTg5hilYZadID+uLHhFbMaOKgKRJefPh48dllL6JwhOiOYtvJVvOVLoXTBnrUqrx
 A8QxH+KP1rFhZqqrThgig==
UI-OutboundReport: notjunk:1;M01:P0:efutTIL2Ilk=;8ZhBydCbWk3eeL+vlTOLBbjunoq
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

The following changes since commit 126a88d49bcae04bbfc0d6723097cd6341355ad=
e:

   Merge tag 'u-boot-watchdog-20250516' of=20
https://source.denx.de/u-boot/custodians/u-boot-watchdog (2025-05-16=20
11:05:27 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-07-rc3-2

for you to fetch changes up to 22abd882c3de2eb365d4c503246c9c7499d4c7f1:

   test: allow testing with NET_LWIP=3Dy (2025-05-18 09:16:55 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/26215

=2D---------------------------------------------------------------
Pull request efi-2025-07-rc3-2

Documentation:

* Add test/py/requirements.txt to documentation
* Use globing for selecting pytest files

UEFI:

* Provide a function to disable ANSI output during tests

Other:

* test: allow multiple config options in buildconfigspec
* test: allow testing with NET_LWIP=3Dy

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       test: allow multiple config options in buildconfigspec
       test: allow testing with NET_LWIP=3Dy

Simon Glass (1):
       efi_loader: Disable ANSI output for tests

Tom Rini (2):
       CI, docs: Install test/py/requirements.txt as well
       doc: pytest: Use globing for test files

  .azure-pipelines.yml             |  2 +-
  .gitlab-ci.yml                   |  2 +-
  .readthedocs.yml                 |  1 +
  doc/develop/pytest/index.rst     | 10 ++--------
  doc/develop/pytest/usage.rst     | 24 ++++++++++++++++++++++++
  include/efi_loader.h             | 21 ++++++++++++++++++++-
  lib/efi_loader/efi_console.c     | 26 +++++++++++++++++---------
  test/py/conftest.py              | 10 +++++++---
  test/py/tests/test_efi_loader.py |  2 +-
  test/py/tests/test_fpga.py       |  4 ++--
  test/py/tests/test_net.py        |  2 +-
  11 files changed, 77 insertions(+), 27 deletions(-)
