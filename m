Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9228DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C902B880F9;
	Sat, 20 Apr 2024 12:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rQmKVb3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E0888113; Sat, 20 Apr 2024 12:09:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C19E88054
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 12:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713607779; x=1714212579; i=xypron.glpk@gmx.de;
 bh=lQlZU3RHv+XQSGgDVc8LS4OE1u4fAU96YvZjlLsfIzQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rQmKVb3rJAwsBp0ERADdB9aPE3l0yIoe/ytBGvttvpOGvcghDMpgEj1H+eceHeK+
 dXBQP+pOKQL+yceuapVFA0Ie4ketHdbkTW7m8AmUK4wVJaaBAOcVzrqtOnGuaYq0h
 BQNhc79kbm42V3CxgolChCA46ybha6XG6VwniMfupVVB4Nuva7z3Tm+/b9wJwnp6o
 rHcLgUoDM56X4J+VAp9o2buDNR4TRtZvAfQMbAHOkre0Jk9whxjSrQtiSzuPxS0IH
 hCALITXoeXy1H6iMrRm7KS3L63k9WW6EhJTBfuwsIyATL62qYYyxpmqSw65E1+Dwx
 q0DcpCY9GDUlh22xKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1rups71Uma-00EQkc; Sat, 20
 Apr 2024 12:09:39 +0200
Message-ID: <f40c6e8f-3cb6-4c67-b386-764fadd6aee5@gmx.de>
Date: Sat, 20 Apr 2024 12:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc1-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+keNr+wIsaSenUZHMDl+x0XzjT6bTaZWygx7e63HsGQq7X6qmH
 WA5IVaQcYJ2UzX9VkUbwNk0uh3P8et1NU5FHz6qVwLqZ0FOj+YYl2aipuhsCGDgVgSGG2vH
 tJSTGEORlp0PT13L/XP8r24y6M2tU+P+sySiS/M+zWzVaj4ThHsb8vRNXzt9wm0zGpvd6Be
 sPFb19VYHp8MeYSiLEpXg==
UI-OutboundReport: notjunk:1;M01:P0:zX2kmOdzwlk=;37rq4m+JjiaoR1FD7mwXYhyxnsi
 dU5Bc5QB/SMO3yg8xlOg22cVpAiGkmuqVTR8YUTLbNIbsVkGS06ao0lJlzkz4B64vQ3vB4AqW
 mqdcTj0+HJEuPOLVg9G9ZEcA1JzDWcMd/iwpSsqMsuw2Q16vulJbMsPXt4iDnxhFNLZZZP2Xl
 EvVUX2utEdnFxo66/PssRG2isZmHpQKFxDFJRUM4u0Cp/uQRN7xhSfiJL9Lup62y5s3Ev23SH
 UQPRU1rCHdnxrSta++uu69uZC80hphrQRDbltzSDM45BHGTK89psRBUyQHEZB7ozCR4rxfwSV
 WheMGMjA2dKDWaCgtTmzopSUvb5YQLsqlt5FokUcEEeIZW/c+FUxsD42Ao9SCidZiBppzckuA
 Tn16kishvIQCpnVZLvuQmY2Yby11oxmk7J7MrPnjj2VK1X8iwr5286osAEwet/5LsFqzPnnO0
 iXU6EAD12h3W6MR1HfaHTVcYleYNBqioKbmNzLbtUqS/EmC8/FPtnVEhFUAvO1cTMxE2kTFoE
 +082XThi4QAJJxkKuaG+LeVB93VN3VXXRpgdUJgyxB5wgXlj177N7ljqQjaSszFenYrmhg/C5
 hX0smvkFOv2LToNUzgU3Jn6dFnho+q9Z/p7LpE4sFGbgImfqqGhpymBeigoothTPTxGrBGQyz
 7w5IbzwlgACdkurvk6EOsf9hU9Wb3EDP/zXf3GzvXGrs3uI4blByHD2mEj/LQ4FHLATJVhk0C
 3MKdR9eBB1u9kYCeuBV12CQZZ73PvPHRnMZjkwjiivkSlVwyoNpCGDLbsaxhVQ/Ax/IvWdBOG
 GsPzx51q3lUMYXKBwXCFlxIoOrePOu3WslZkINxwcxnmU=
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

The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f9=
2:

   Merge tag 'u-boot-stm32-20240419' of
https://source.denx.de/u-boot/custodians/u-boot-stm (2024-04-19 14:25:04
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc1-3

for you to fetch changes up to 52c62acc349a0ec1ba26ae497913ad34ee3de733:

   x86: all firmware tables must be paragraph aligned (2024-04-20
10:15:03 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20447

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc1-3

Documentation:

* sort env sub-commands alphabetically
* update list of aliases for the env command

UEFI:

* allow enabling SetVariable at runtime
   for future OS supported writing to ubootefi.var
* use event callback for initrd deregistration

Others:

* correct alignment of x86 firmware tables

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       doc: sort env sub-commands alphabetically
       doc: update list of aliases for the env command
       cmd: eficonfig: check initrd path allocation
       efi_loader: typo mstching
       x86: all firmware tables must be paragraph aligned

Ilias Apalodimas (4):
       efi_loader: conditionally enable SetvariableRT
       efi_loader: Add OS notifications for SetVariable at runtime
       efi_loader: add an EFI variable with the file contents
       efi_selftest: add tests for setvariableRT

Masahisa Kojima (1):
       efi_loader: use event callback for initrd deregistration

  arch/x86/lib/tables.c                             |   2 +
  cmd/eficonfig.c                                   |   2 +-
  doc/usage/cmd/env.rst                             |  35 ++--
  include/efi_loader.h                              |   4 +
  include/efi_variable.h                            |  16 +-
  lib/charset.c                                     |   2 +-
  lib/efi_loader/Kconfig                            |  16 ++
  lib/efi_loader/efi_helper.c                       |   5 -
  lib/efi_loader/efi_load_initrd.c                  |  82 +++++---
  lib/efi_loader/efi_runtime.c                      |  42 ++++
  lib/efi_loader/efi_var_common.c                   |   8 +-
  lib/efi_loader/efi_var_mem.c                      | 151 +++++++++------
  lib/efi_loader/efi_variable.c                     | 122 ++++++++++--
  lib/efi_loader/efi_variable_tee.c                 |   5 -
  lib/efi_selftest/efi_selftest_variables_runtime.c | 222
+++++++++++++++++++++-
  15 files changed, 583 insertions(+), 131 deletions(-)
