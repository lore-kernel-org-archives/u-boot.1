Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEDCCD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D8BD88152;
	Mon,  8 Apr 2024 22:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CROM3VxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4F388153; Mon,  8 Apr 2024 22:28:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0805587FBF
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712608127; x=1713212927; i=xypron.glpk@gmx.de;
 bh=6RmMYJMp05k2VK1FUZoDEVIhoZPnapiZGc3io3T5P+Q=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=CROM3VxQMd9hei9ri5CxA6ES+HEfGkkVUS+9JHtNYOFX7jUnwR2RAC/tkWJCbEIy
 pqdbS5RLYfy9mXKZSdjanEigVi96B8cuL0qyI1eWFBrzpHgE+GrzDNa4cWoOY2Os5
 I+dbZkWs30Nib3BNLGWoPE7Mp+Hgaw6Kyt95fA3WU+K7pwm0WsY8Bzv7VwOfrmQsZ
 BbCl/4ffKGrEJfvv2GkauD6mPWx7ISJDAuheF40P/YIHKuGYwws+Q7WydvcyNAND2
 CAWuReE69B72KBOKn1JjXhqfD+956VrCxPpYxEJVBrlI6Lxc0fEUe/N89QHCI16Md
 QfcMPIwERexFsvqeBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1sAuUb0gq6-00JGPV; Mon, 08
 Apr 2024 22:28:47 +0200
Message-ID: <d34e7f84-a22d-40ed-b756-c10ef935c49e@gmx.de>
Date: Mon, 8 Apr 2024 22:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RC/PM4HASZAoqyvqZvhrmVAQ//XeqTStTg12bSdxHo2hOD8upZT
 VfmEsEvvsA3VfXvy8wAzgsSzGgFXcNW5i/bRALJdaP/cqJt7/FBv6AW64Qy+P0iGw8QX71m
 IkAC4ZyCdnGBj7zlCWhNkODmEgBTEme5IJfl0frB5KjuH56RQ4b1Z8f0Q7HlDQmdK56cIcS
 LNSPKvFVN41VDhqY2IXqQ==
UI-OutboundReport: notjunk:1;M01:P0:Ycc8b90IHg4=;SdYjGyJMMXN625jsTkJl28Vlm/p
 G1aap/aKjPx3/rq6wn+sm0sUp6wkU/3e2MPyJrFQZEULFtagTquo3PmlWEKTpzy27D04sUROX
 vvWNXdIEEaDbGuU0xnkFbDE8p7sTA74hjLgFKAVY09d1lJwviE8mtXt1yj4dGQA8TGq4JQoJR
 FYvT2DlgISFXx7R/Rtrpcr2YQB8jWUVPFMa/3ZhKyHm9fMgpHfYFRdoU0kRAl9ppowqTAzFjw
 SNdaquivzXG6RaFW2FIvwmyoWy+nEuiskf3oI3lBkshyJaKG/ncv3LvJATbsFyjH6tCzuGQNJ
 EDkjuPQoBQbKi4e1Jk2wXkTLGdIW7kAMsqXGIzEHCe2SYBbxUkv2rCYisRn5m4OnaP7xYfGng
 QBY5xUvoqA7Q2R7UnRUqfYB9TKjREg3K1+R8FU/QYAowlfzJ4uA+BqBJjWtpOlf+XAWpTaPhR
 ajJtq3f8OcKPKebiVXowymXrAz7d5IgWQGOAUnOWz4xWdhVvTN+4uFSfmo8TchckaK4pStHNJ
 PDY0/cnYfmzCQURanWLAOo4q7UhbBZqxzwvlPXBKTNMgtX53FOORr4sDZeoOUfhuhWnJ+KzWu
 H2wLWULWgPeCLdC9yA+qt+zVYfjtV5Aioe627hDcTPtn5IlZia8Fs45+BGIeqTb9cKGFSJ1uH
 JjrsYT+yEdknMlAZ+DKzG4ryxP4PQSjweeT9uayWcSkK7vEKkVhORvqI9jxfLGotnJJLDVfrb
 JY04fsz9/bhqjOBNp8+A1QO445SQi9S2cHCWoXULMk+O2DAaX7WDihURkrai+7qABMC3pYj3X
 lMW5EKnRfS0ie2xbdmImsKzA3ZAnb41lk/zhdgcZhzPcw=
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

The following changes since commit 9cba29b19f43f9450117e8bc89e7dda691ed5ab=
5:

   Merge tag 'u-boot-imx-master-20240405' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-04-05 17:23:58
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc1

for you to fetch changes up to 3f8d13044b32ddd906bb9f2fc705b988ec93df35:

   efi_loader: access __efi_runtime_rel_start/stop without & (2024-04-08
13:05:50 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20252

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc1

Documentation:

* improve description of FAT partition name generation
* add missing :: in doc/usage/cmd/itest.rst

UEFI:

* fix address mode for __efi_runtime_start/stop,
   __efi_runtime_rel_start/stop
* fix size of variable attribute constants
* enable booting via EFI boot manager by default
* correct the sequence of the EFI boot methods
* correct finding the default EFI binary
* don't delete variable from memory if update failed
* fix append write behavior to non-existent variable
* Use binman for testing capsule updates on the sandbox
* Consider capsule test files in .gitignore and make clean

=2D---------------------------------------------------------------
Heinrich Schuchardt (9):
       doc: missing :: in doc/usage/cmd/itest.rst
       doc: improve description of FAT partition name generation
       efi_loader: all variable attributes are 32bit
       efi_loader: EFI_VARIABLE_READ_ONLY should be 32bit
       efi_loader: handle EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS
       boot: correct the default sequence of boot methods
       boot: enable booting via EFI boot manager by default
       efi_loader: move HOST_ARCH to version_autogenerated.h
       boot: correct finding the default EFI binary

Ilias Apalodimas (3):
       efi_loader: Don't delete variable from memory if adding a new one
failed
       efi_loader: access __efi_runtime_start/stop without &
       efi_loader: access __efi_runtime_rel_start/stop without &

Masahisa Kojima (1):
       efi_loader: fix append write behavior to non-existent variable

Sughosh Ganu (4):
       sandbox: capsule: remove capsule related configs
       sandbox: capsule: binman: generate some capsules as part of build
       capsule: add the generated capsules to gitignore
       capsule: Makefile: add the generated files to CLEAN_FILES list

  .gitignore                                         |   3 +
  Makefile                                           |   4 +-
  arch/sandbox/config.mk                             |   2 -
  arch/sandbox/dts/sandbox.dts                       |   4 +
  arch/sandbox/dts/sandbox_capsule.dtsi              | 169
+++++++++++++++++++++
  arch/sandbox/dts/test.dts                          |   4 +
  boot/Kconfig                                       |  10 ++
  boot/Makefile                                      |   2 +-
  boot/bootmeth_efi.c                                |  46 +-----
  boot/bootmeth_efi_mgr.c                            |   2 +-
  boot/bootmeth_pxe.c                                |   2 +-
  configs/sandbox64_defconfig                        |   5 -
  configs/sandbox_noinst_defconfig                   |   2 -
  configs/sandbox_spl_defconfig                      |   2 -
  configs/sandbox_vpl_defconfig                      |   2 -
  doc/usage/cmd/itest.rst                            |   2 +
  doc/usage/partitions.rst                           |  17 ++-
  include/efi.h                                      |  18 ++-
  include/efi_variable.h                             |   2 +-
  include/host_arch.h                                |   2 +
  lib/efi_loader/Kconfig                             |   1 -
  lib/efi_loader/Makefile                            |   3 +-
  lib/efi_loader/efi_memory.c                        |   4 +-
  lib/efi_loader/efi_runtime.c                       |   6 +-
  lib/efi_loader/efi_var_common.c                    |   2 +-
  lib/efi_loader/efi_variable.c                      |  45 ++++--
  lib/efi_selftest/efi_selftest_variables.c          |  48 +++++-
  test/boot/bootflow.c                               |   6 +-
  .../tests/test_efi_capsule/capsule_gen_binman.dts  | 167
+-------------------
  test/py/tests/test_efi_capsule/conftest.py         |   1 +
  30 files changed, 326 insertions(+), 257 deletions(-)
  create mode 100644 arch/sandbox/dts/sandbox_capsule.dtsi
