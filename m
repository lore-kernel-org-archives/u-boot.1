Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAADC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 15:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EF5803CB;
	Sat, 18 Jan 2025 16:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mtI+fI30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAEC480312; Sat, 18 Jan 2025 16:43:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9952680312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 16:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737214992; x=1737819792; i=xypron.glpk@gmx.de;
 bh=tuAiP4VfrZF6EkCiqsns2tdedKTQbshCkaVDFtTwKrM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mtI+fI30arxBzcPZOUT0EV25eSuLgbTsFFT4Hc2RtTL/vidcD8RuH16ejHw/9OH4
 jJ+HcGDDHXPDYSWyHAyojJ0KzcHIje8rSP0m4sLAJ7VTf/sUmwKNFiT+49kcRYlZF
 LdslL7paoN/73AmHKmJRthdPMChDc7iMpsgXiEekio2d9eelrFykqm5ln4B8OPulD
 UYYgjnb9afYsalw83XqAMNuc+LJ+9Lva1Ph719f07U2Ma/9zPERQcCEzom2KLtSKe
 bZOXE2jx0khscs53Fi0497bNMyPc+th1s2XLFASQstQIQfgaJmaz0BaTfPlHwdJz6
 oz8a4sqXgYpz0+OTSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1tNztQ28K0-00xPSe; Sat, 18
 Jan 2025 16:43:12 +0100
Message-ID: <95436c0e-14a6-4771-859e-30c62e2c4df2@gmx.de>
Date: Sat, 18 Jan 2025 16:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Andy Yan <andyshrk@163.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zExyUL2Tg+x4puhIoZC0cNCNmSN0sdUZjHvW34ff8rAHr31KrLh
 2uAMhKqrIpBQ7JZKjOMuVjR/J51rM3EEFejlcaaizKb6+G6e1hEFk0PcOZ4wPa9QQ+d3WHQ
 D99+QT7aZuYEyu9J2g9fWbXJqYL5hlnB/M3ZEi1aupiykO4kzy4RnF3VFtRqzJekuuJhKoT
 EBiro/FiY0MTp98xYjJJQ==
UI-OutboundReport: notjunk:1;M01:P0:iS7br+6Hvu8=;czR+NcwpK9XJ7a2pmVnjS120i9v
 Ty2yYCqaFybiZ8rC9V1Ny7+t39Dvm2v3dVbVMPyptoTsIVEXxFE4CLNrDEXylJ4wxI0Nkihd0
 YS+Oo5p51UAH3JLr1RpF4ReRqAi+c7v8IwQlomv0y7h3DFLrzRRNm+fXL0gRxUcFLloXYC1Sc
 0FpPOS+jGMhIMthtNvKQPLu9LPUiVIzP8uawTKeaUqNuUfoldNW7QTFcu1pQ5mmbviLlqC3gv
 /ANS+HQ/iF9KGsZB0A+EJZ6aYx4wEUGcA3PE6dLxI5fqIet5RnT87oqckSVo8C5XC+W+AQ1Uo
 LfIBFHa0Mp2eP4JU8tN+ycrzk/SvRuR+YZlv8QRTVwZkEJyJL50jsJ1TdYUDZdnVN74SSQCzL
 mq6V764JEzJm/Gc4RwZI+7sokWJTYtcWUkZZ4U6QgzY81P0vJRyJykRuihJf1IGDgJ7KE7gCO
 grcQSOuWEkjPCy4N8Sx/wVdK964Jp4siLJCApVKfDX91QYmlrJoKEw8eySIdu2XKEIaIvbHzF
 VEgas0u0p0WLIYKc1+j5wDipohnQzcRLFxPKz5/qh3x2GiaAov0QllwKyPHYTRKFK8JECqVJ/
 Pc2biVhdvV3UxVH+bm4lxgNHsMp8Zr7RPBIcUK5VsJlwgwHE1pcv31Fzxsa2HJ9yUPNkWxcB8
 Pdwfhvqeq7y3/dwzNrERRYkxGidwbEMn6blkZ29p1R6uxZOGPTp6KcmZr8krG24ZW0j3FKIQF
 RH7N/zn1Gztwx2IKlFNd9pM5rPjWwKodEd4kXWTrH0Nrm36FeH55tLFmlaFaLwx+iyCIJVLyA
 ZEuWnV96FE3nr+thPQVkMQhdezO5Bcfc9fJ502bElX+/5Dc9keOR7r5/iLCqDonDKoFufSAzW
 8Vt2f2kvUhjoONR4pWHeGVeWBMKh4zFXvl/uPL9DDpd2smU8HAww2h7bSumwaTDBI/Bz8wLqG
 m857tOCv17eIQI/YR/x/BkkERAwIDABC8So2TsOp1497aOXP2gUcpkStqsct8M352djV2MxN1
 iTYimCKW3+CATXYFkXY2Sv0YHu3jh5kFXhfn1/v8yY3CEjbpZDwOEMxK4LeN/MmKNndImJwAE
 UPTKwXj5Pjda/vskufCRNFC9Rs5znWy5dPehV1CsINMZtGcl5s9Q8/YlYXfhdJPfHkN9FFStG
 ngpwmOwzV3ZI0qF7AgqT9xsBXYntdUXt1uLfjxNYgKw==
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

The following changes since commit c11dc783fb4418393dd08d39ee01debfc2dea4d=
4:

   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
(2025-01-17 08:27:40 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-04-rc1

for you to fetch changes up to f58b0d00126a906f9e1e9fc1c55512b47c8e51be:

   efi_loader: Make efi_run_image() static (2025-01-17 21:05:49 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24239

=2D---------------------------------------------------------------
Pull request efi-2025-04-rc1

Documentation:

* Correct the defconfig name in the coolpi documentation

UEFI:

* Carve out the biggest part of the RISC-V and ARM linker scripts for EFI
   binary into a common include.
* Correct the values of SizeOfCode and SizeOfInitializedData in generated
   EFI binaries for RISC-V and ARM.
* Avoid gaps between sections in EFI binaries causing a failure in secure
   boot.
* Makefile: let clean remove capsule_in.capsule*.efi-capsule
* Refactor some of the code used for launching EFI binaries.

=2D---------------------------------------------------------------
Andy Yan (1):
       doc: coolpi: Fix the defconfig name

Heinrich Schuchardt (5):
       scripts/Makefile.lib: add -L option to LD command for EFI binaries
       efi_loader: use INCLUDE in EFI linker scripts
       efi_loader: correct SizeOfCode, SizeOfInitializedData
       efi_loader: use include in ARM EFI linker script
       Makefile: let clean remove capsule_in.capsule*.efi-capsule

Ilias Apalodimas (1):
       efi_loader: Fix section alignment on EFI binaries

Simon Glass (2):
       efi_loader: Refactor device and image paths into a function
       efi_loader: Make efi_run_image() static

  Makefile                                |  2 +-
  arch/arm/lib/crt0_aarch64_efi.S         |  2 +-
  arch/arm/lib/crt0_arm_efi.S             | 13 ++---
  arch/arm/lib/elf_aarch64_efi.lds        | 68 +-------------------------
  arch/arm/lib/elf_arm_efi.lds            | 71 +--------------------------
  arch/riscv/lib/crt0_riscv_efi.S         |  4 +-
  arch/riscv/lib/elf_riscv32_efi.lds      | 68 +-------------------------
  arch/riscv/lib/elf_riscv64_efi.lds      | 68 +-------------------------
  doc/board/coolpi/genbook_cm5_rk3588.rst |  2 +-
  lib/efi_loader/efi_bootbin.c            | 87
++++++++++++++++++++++-----------
  lib/efi_loader/elf_efi.ldsi             | 74 +++++++++++++++++++++++++++=
+
  scripts/Makefile.lib                    |  4 +-
  12 files changed, 150 insertions(+), 313 deletions(-)
  create mode 100644 lib/efi_loader/elf_efi.ldsi
