Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C303CEE352
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E141A88CAE;
	Wed,  9 Oct 2024 23:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SpGcXe2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B569788CC9; Wed,  9 Oct 2024 23:40:44 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2072E88CA0
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9AD203F48A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728510041;
 bh=LeX/PI7OIdlTEOtusxuhz6s7jWJ9m+vy68HM/K01kqk=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=SpGcXe2bgpm1ybtsaxH0h64gLRjty0JUr0hLxgnIOaoQVOaMdMxGUCUh903TLO//8
 1L2rV34Co4WnQMH2nUhkKQs/m1DZ02cH+h2DEm8L/rqH7P7VhZxLeRURnpvIOcV4Qw
 Txx2DLvU4zU+S+iMGikSLXC0T4NBDSl/101U0ZDy6UNaQJs7/I/L1kYDWv2Ls/VcKV
 Hf1PI6y/rcNT0pQOm8jUiYcCVwnQqUvZuE9qChEn54fW/AX+UjEyKS4rYtm16l4s54
 gLT69BVZ2l05QksfEx+q2TEfS7fVdWvnctto8ufKp5fg3nu8TatQJiRW7YjnGEV31J
 92iGSWBk1nRCQ==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a996be26171so150813766b.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728510041; x=1729114841;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LeX/PI7OIdlTEOtusxuhz6s7jWJ9m+vy68HM/K01kqk=;
 b=l499RKsCiS5/Pz/4i9zdHhWyoZzRiRDZHoeWFQJCSayAvIK7XTzM7/B8KqdUsb69Rb
 VjlWZ8rGlK8cwlFzvponRejVM4IFS0gMShRqf8/aoPxTue8GbKarRXKWEwuAUGELHUHU
 eU32kMP3xhkTFI3vsWMrKqrdX73I1+X2pJmCqM93dXPx55wAbawZpMVThJVh73YLNptg
 /fPC6ULMw9GhiAVkrZk9ff6RfI9x7yV2XcZRORA9Md/jaap0vgodoWHDw9Jx7ZP8Sppk
 y7RzER1SwsGYRr8Bw3A2bkGkS6/9icRsFy3hqd3lk/OxMhfU5DudsdLW4gvlTLojX1Wv
 +Ozg==
X-Gm-Message-State: AOJu0YxfFD8MJBQrHxVnQMPCE/zdrPiOjL4Xzbbz9AENaaNBB//CNtOq
 wA2ILpOMAPFUgtCi8E0qCkdwsrigfefHxtxujZAiJmp3NZ3cCmpEEAvGZZMw1ASObH2qerEsNFJ
 +2suVmizW9+SBrt+wPySBlxeWV5die4YS/2BNC16q4esZDLb9WSb78ELE2bRXQU/+sUM=
X-Received: by 2002:a17:907:7ba9:b0:a99:6265:ed35 with SMTP id
 a640c23a62f3a-a99a10e876amr96601066b.10.1728510041063; 
 Wed, 09 Oct 2024 14:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiE8fKWKiePn4jnySl8lMk9aYaqPlVHbqUIoM/a8nsCi3iCcPxjh7NIe+x9YmeKVT+67AW/g==
X-Received: by 2002:a17:907:7ba9:b0:a99:6265:ed35 with SMTP id
 a640c23a62f3a-a99a10e876amr96599366b.10.1728510040641; 
 Wed, 09 Oct 2024 14:40:40 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:3cab:4823:b867:e230:71c3?
 ([2a02:3035:6e0:3cab:4823:b867:e230:71c3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99501181a6sm510932566b.139.2024.10.09.14.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 14:40:40 -0700 (PDT)
Message-ID: <fbb5acff-f3b3-4c3d-8d96-bc95bfe470a8@canonical.com>
Date: Wed, 9 Oct 2024 23:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2025-01-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The following changes since commit fbe16bc28014dc1ed957f5fee7e53d6eee781aa9:

   arch: arm: dts: k3-j7200-r5-evm: Enable AVS feature (2024-10-08 
10:23:36 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2025-01-rc1

for you to fetch changes up to be5e7c11ff7df70b7c2adfdfd114ae25573996c8:

   sandbox: enable clk command on the sandbox (2024-10-09 15:48:42 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22597

----------------------------------------------------------------
Pull request efi-2025-01-rc1

Documentation:

* Move the generic memory-documentation to doc/
* Fix typo boormethod

UEFI:

* Delete rng-seed if having EFI RNG protocol
* Don't call restart_uboot in EFI watchdog test
* Simplify building EFI binaries in Makefile
* Show FirmwareVendor and FirmwareRevision in helloworld
* Add debug output for efi bootmeth

Other:

* CONFIG_CMD_CLK should depend on CONFIG_CLK
* simplify clk command
* enable clk command on the sandbox

----------------------------------------------------------------
Heinrich Schuchardt (6):
       efi_leader: delete rng-seed if having EFI RNG protocol
       test: don't call restart_uboot in EFI watchdog test
       boot: typo boormethod
       cmd/Kconfig: CONFIG_CMD_CLK should depend on CONFIG_CLK
       cmd: clk: simplify clk command
       sandbox: enable clk command on the sandbox

Simon Glass (7):
       doc: Move the generic memory-documentation to doc/
       efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
       efi: arm: x86: riscv: Drop crt0/relocal extra- rules
       efi_loader: Shorten the app rules
       efi_loader: Shorten the app rules further
       efi_loader: Show FirmwareVendor and FirmwareRevision in helloworld
       bootstd: Add debugging for efi bootmeth

  README                             | 45 ----------------------------------
  arch/arm/lib/Makefile              |  8 -------
  arch/riscv/lib/Makefile            |  4 ----
  arch/x86/lib/Makefile              | 16 -------------
  boot/bootmeth_efi.c                | 11 +++++++--
  boot/bootstd-uclass.c              |  2 +-
  cmd/Kconfig                        | 23 ++++--------------
  cmd/clk.c                          | 14 -----------
  configs/octeontx2_95xx_defconfig   |  2 +-
  configs/octeontx2_96xx_defconfig   |  2 +-
  configs/octeontx_81xx_defconfig    |  2 +-
  configs/octeontx_83xx_defconfig    |  2 +-
  configs/sandbox64_defconfig        |  1 +
  configs/sandbox_defconfig          |  1 +
  configs/sandbox_flattree_defconfig |  1 +
  configs/sandbox_noinst_defconfig   |  1 +
  configs/sandbox_spl_defconfig      |  1 +
  configs/sandbox_vpl_defconfig      |  1 +
  doc/develop/index.rst              |  1 +
  doc/develop/memory.rst             | 49 
++++++++++++++++++++++++++++++++++++++
  doc/develop/uefi/uefi.rst          |  2 +-
  include/efi_loader.h               |  2 +-
  lib/efi_loader/Kconfig             | 12 ++++++++++
  lib/efi_loader/Makefile            | 46 
+++++++++++------------------------
  lib/efi_loader/efi_dt_fixup.c      | 15 ++++++++----
  lib/efi_loader/efi_helper.c        |  2 +-
  lib/efi_loader/helloworld.c        | 37 ++++++++++++++++++++++++++++
  test/py/tests/test_efi_fit.py      |  2 +-
  test/py/tests/test_efi_loader.py   |  2 +-
  test/py/tests/test_efi_selftest.py |  2 +-
  30 files changed, 153 insertions(+), 156 deletions(-)
  create mode 100644 doc/develop/memory.rst

