Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299CCC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 10:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4454D87D64;
	Sat, 13 Apr 2024 12:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sj58ZbAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D78487D8F; Sat, 13 Apr 2024 12:28:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6718187D0A
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 12:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713004114; x=1713608914; i=xypron.glpk@gmx.de;
 bh=D8tSDdrMfGU+17pIsKmQ3wBlvP4VI86k21hWGrfrRH4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sj58ZbAT4EZBEIU5Fd7sHyNRymGekCnfkl96tP5enXLAUDuQfcJoQwf2TUlebvr7
 iTX+ZsNjxJn/LHeY+XAILuiqkaGZN9LwKfJqFmj3UD9x0ltVKUrWPbYM8f4PDtOha
 AAitKxHsz8np7LUzt/Zpk7jx5kDZ7+GuzS36AL1kJbqXc+xHbq1x2dPsNbJztnSAc
 R+mgX2XUsqRm5XuunQkxhdFy1BTSsTQLM1fRl178/Z7tnIEQzfqz2sh9u55hVNBea
 hMI97wrTPVCTED7HojL9fej7IyDOWgd9EFcWgCG6pbohs5H/1TMsm44hc03vaitzw
 PDISK/OSdW7Hh7VHkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1sdl901s7U-00iFJQ; Sat, 13
 Apr 2024 12:28:34 +0200
Message-ID: <c17cb6a7-2c98-4408-9b29-27f766edafac@gmx.de>
Date: Sat, 13 Apr 2024 12:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Weizhao Ouyang <o451686892@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r041G7HMW7bo8Sn0nmwZp97D9Ts11RY+JAvxOH5EYbhJoM45o7W
 Ib8xgqxbVXa63mfyZCQVNMKMmYsH2KOYaTpKw5H6mdTPmSrL9zZHl1dcMLGME5HfmiogZcg
 YrlRMmYrxHXH+pUBm2tUo5kUqDJ6BgpliHWfYpM+dcuo2rauPYDJ5M3Vd7FLLG3PqaibEc/
 2ipvoyOx3jDl6toKPA/1Q==
UI-OutboundReport: notjunk:1;M01:P0:SKCxgVaV45A=;s+SMUkmVPglx+RXHbcGr6TpgxOV
 pUgLXU98Xif4NiNOo+woJEIP2cxAg9PZXS8+5vjoubP8ute25K3njRKRcV7vvhExvz4Exv78S
 rWY2kFG1h4+6xN0zwTRZ945QFkz5PwoO1au4xCYoOOkbGGwm1pHyeaQgSWJZJK+okIUjjUN3c
 mBwnFuQ6RUKaFjitHklctwhHt1PtW+4ILr7F513tW73HTJGYNVNRLqT1/SdT7ED69bx3q9I8h
 u9iHKsXfHNr/r5OIpdLargF9NYAGLDSamVwmdopT/20W35J0/Qw+7sRaX20WmKKpg32CekeVb
 al/oc0vaTu3BEaWhi0Cqhf/8o9SU546x60wgDPtIYBvYzbmzN2LorSMEG5IHTlqRMK2apnnQq
 fDTv+vLw2c+hWkvVLXYboEdrpMlbXRoe5SeaBGc2Ek6bpgwL5fmKke7cjPBCSGdZW9XgSYMUB
 11ivw06kNvwXN6C4LLAds2y7w7jykFYuTxnjbQF6k3B0P6SqEkkUzCZarLauT5H+uEoGITK9t
 Ut3+BP6qdtMRH6KsW3VSwwDg2iHPqqC7VDlrGGQHwXjksG3anrrnOk9qDMKY1dyvyieswbHUh
 avam3xASi50Z5Cugo3s3OgLl+U+WHj9/8awsNj5tu0s0dXPvd6QF5yZ4jLCSpyBn8KExyflwP
 vFjVo58DPANsTjeNYbmder/s3rKsLZ9/3Svz1rVNeuOUkd8+orQXZ0eob8IzcNd0JxaOe9nSK
 Y7SKQjFVgoZHHE297ySKhOaCxi2mhu5wVDK0lS1yf877jZsGa5aI7jiPi/CcDM1dYqfz8B1yK
 XOTcvAcsTyBR0gLWlSybid7jK+76/u0kvhQO+I7IQ3AL8=
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

The following changes since commit 13c1100335e40acb1066e074eb061387fd103c3=
6:

   net: designware: Pass all multicast frames in designware driver
(2024-04-12 13:59:12 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc1-2

for you to fetch changes up to f1f4b0e6f37d801f01d043a1ed44b88e7fdd1d92:

   doc/sphinx: Bump idna to 3.7 (2024-04-13 11:16:14 +0200)

Gitlab CI showed not issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20322

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc1-2

Documentation:

* bump build dependency idna to 3.7
* update docker image reference to latest
* fix section levels in gen_compile_commands
* fix references to trace doc

UEFI:

* eliminate duplicate runtime section definitions
* let 'EFI using ACPI tables at' be a debug message
* sanitize efi_tcg2_final_events_table definition
* move efi_var_collect to common functions
* improve error messages in variables unit test by using
   EFI_UNSUPPORTED for private authenticated variables

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       efi_loader: eliminate duplicate runtime section definitions
       efi_loader: 'EFI using ACPI tables at' should be debug message
       efi_loader: sanitize efi_tcg2_final_events_table definition

Ilias Apalodimas (1):
       efi_loader: move efi_var_collect to common functions

Mattijs Korpershoek (2):
       doc: build: update docker image to latest
       doc: build: fix gen_compile_commands section level

Tom Rini (1):
       doc/sphinx: Bump idna to 3.7

Vincent Stehl=C3=A9 (1):
       Fix references to trace doc

Weizhao Ouyang (1):
       efi_loader: using EFI_UNSUPPORTED for private authenticated variabl=
es

  cmd/Kconfig                        |  4 +--
  doc/build/docker.rst               |  2 +-
  doc/build/gen_compile_commands.rst |  4 +--
  doc/develop/tests_sandbox.rst      |  4 +--
  doc/sphinx/requirements.txt        |  2 +-
  include/efi_loader.h               |  3 --
  include/efi_tcg2.h                 |  8 ++---
  lib/Kconfig                        |  2 +-
  lib/efi_loader/Makefile            |  2 +-
  lib/efi_loader/efi_acpi.c          |  2 +-
  lib/efi_loader/efi_memory.c        |  1 +
  lib/efi_loader/efi_var_common.c    | 74
++++++++++++++++++++++++++++++++++++++
  lib/efi_loader/efi_var_file.c      | 64 --------------------------------=
-
  lib/efi_loader/efi_variable.c      |  1 +
  14 files changed, 90 insertions(+), 83 deletions(-)
