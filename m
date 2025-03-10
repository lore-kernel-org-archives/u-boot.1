Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E426C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E7280107;
	Mon, 10 Mar 2025 13:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZVmiGW13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 517E58122F; Mon, 10 Mar 2025 13:52:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89E28003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741611158; x=1742215958; i=xypron.glpk@gmx.de;
 bh=XriNGHkPMQSynx4TJRpuWpsU3b49YQs0BbAxzp8QPVk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZVmiGW13FshwTsgO1ypIfPehJTNterIMx2mZIAarpsZvOF+X9QxAngUR5pWzC3zd
 HM9O+fL1pqLhpTO4wfB6vFHwHnGN81BISyPg+PlTKvIQ+E0kgNo5ADXPMxKhzierM
 cSnQEFmVWT9DzkDo1VxlaY3l5i171D+xUUO0P3JEkhOyCfY5CvogJERuXLnKm2xky
 zgw15w4+1aDjtuDA2ZRuugUPu9ftS/RmWoH0XqYRdVesJoqg4qgS5fqzzFIImunDJ
 pFDswSOh+Wqv19DmPUmbhrztng8XQa1k3lErXiqiMb8AsvkaCyRI8nkHh1iTasfA7
 fp54lHm7tJoQEo3zbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1t04Sl3pXG-00xcYf; Mon, 10
 Mar 2025 13:52:37 +0100
Message-ID: <3f38b374-df82-420a-a253-372cdb2db279@gmx.de>
Date: Mon, 10 Mar 2025 13:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>,
 Yao Zi <ziyao@disroot.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-20250310
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRgzGL4c9/50yrj/TwlZAYf1rf7Lo1s20eHZl0w3z2ynLF+dKDf
 +c7RielPAAJZzcXzdJVoo6w0NcR+Eh8KxwPA4yEvZlwy9sp8NdVIxHF2QVVTMv7N3f5hkBI
 E/TymYjY951RBVGijG/9BzCYAPqbyTMOpofhPuuQQR9tBar5mCACJ8YSQ568DwfBEx+pab+
 5WceFy7RQEToazj8HcjAg==
UI-OutboundReport: notjunk:1;M01:P0:gThYtb4sf/Y=;F4PwpWtBe56zpGGuJZw6Nc31L5m
 769Cv8z3I2pOkw9SvsiyMDEPcn8I7/Qidw1HnPAlmXkqkVxOeKt42AOfsDvvCkC3dEy8U6sbV
 pgosgEaG7apYy/lHJfEJRj8S3rUGnXTJGuANPXpoi4mOXL95ukQbswM7FoKF3XbBLqxWhKNI6
 xM8nae1wa+Dp4MRPfFQC3lkLdeBfLQGv4369RIOiXy7asEYRtaQoqmqKsOiEFFIrOwS08qZjs
 gLphRJ400hMbk464+ZyPGTRHCgZhF4YlXVBZlaxh4E+Gfjy5Fa/rUm45Ew6fizAz0yuc/u9T6
 6xYnc1BbDezht9bGH/qggO70LR5xRB11PVW8RIC11YjDoBSPHku4k+aK3/WGyob6n5AdsG664
 o5DxZa7UJhhqlsncA7MOqkdOmC44XT5r/ZfF3OtIbcgEZX1tJSgNoRRm4hf6W67gY8u965oYD
 GYJ6SvZn2lbB/AWcCJToKBeH2TjagQFZPzQo1i2dGxeuEyUgvZ1MbOeaeEbiGyvrq+2GSY1fy
 zI1Azvs4gKUufK34XumXc0A+Xdzzxo8f6XA0oCMA6mUJQIeuvt/iA/5PKLCh5Icx5Zuo8sNnS
 /K7tktCm+cc5eNMkUF4Qs/go/yppa7bFnQzRjc+k5s54L16yC1Z0m4FhF7aESeQgSGNnbGkq1
 RHy6FL1I1++8UOUnDTVXfdkBU1ERJvuA87SpRC7ny0davWNefL8aAGvQYeQ3+GBpy2yK/eVvx
 0CWZn4PxICdbW+lwMfjJGhBRGrBJtC1HTAIW/KPAM/ID0CwkWegThSKE+f3krpIxuB7K8PF8F
 Ge6qGdJmauybQORTDEDF1FZ7wr4G+wwtiXToOYBzLFMxp+mBEl5FhJSrut7Lo07U6HaGIgd/v
 ZojABLcBglLXW/3t3/lZ1IWyIBPJVndXECbKfEj37oJZ7QsJBvTHeqyzzqeaPMy8w3DRb9pF+
 9yNO7vLmcBvBpgayKs/mzTtY2l/5HsNPDPFkNKW/u7ElkvKuuaaZHUdjVb29qb1XFGvp5m02K
 OYxhxzhgH6Ce+PiNdJKN5JbP3Tfh1qxyB29mu6V+GVHrc3oJB5fdQeB04sZfxyIOU/b/gvsqk
 rXewP1+oVYhVxI+sQb0GbiKGp8mXz/2tbofLDXLdiyGDFVkyqEenrRfTKl7QaF4agGXTtO8AA
 gGT/rZTneil1Ryj/+tlxy/EkURxZr9cvj0TE/fe22fIXW6eN3AAhdX4YNVtMu62LFpkAaIUdt
 3G8zg9OEM7g/bC/5NllsGPngmGHKb8cUB2WxfxnZP8uQBFjmcgsrZ6A0kpkTuf3AIvv+p2h46
 goB6gs2CXxP5Px0kpAgqz6avoqj20UN9O02iVMhHdS4fKYz81SUiDgxxkcvcpnK1O/I7jLcGG
 Sct/bPl5Db4UPJsNHdn21yOTtfuF6sfHx2Ls0unEuf/UBjjBDouIcT7omO7qLVd1gpv0lafBA
 RatZg8g==
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

The following changes since commit 743c15b9fdd2f639012a2c26734dc146dc56821=
8:

   Merge patch series "This series adds support for file renaming to
EFI_FILE_PROTOCOL.SetInfo()." (2025-03-07 12:06:21 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20250310

for you to fetch changes up to cb21476496d6f48712b24045aa7cd3299ad65d99:

   lib: correct description of CONFIG_SYS_FDT_PAD (2025-03-10 07:41:26
+0100)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25043

=2D---------------------------------------------------------------
Pull request efi-next-20250310

UEFI:

* Clean up usage of structure jmp_buf_data
* Refactor EFI network protocol implementation for future support
   of multiple network interfaces.
   - efi_net: let efi_net_set_dp properly update the device path
   - expose symbols to be used by the EFI network stack
   - efi_setup: Add efi_start_obj_list() to efi_setup.c
   - efi_net: Add efi_net_do_start() to efi_net.c
   - efi_device_path: Pass net udevice as argument
   - efi_net: Add device path cache
   - efi_net: Add dhcp cache
   - efi_net: Add support for multiple efi_net_obj

Others:

* legacy-net: wget: fix wget_info handling after new tcp legacy stack
* lib: correct description of CONFIG_SYS_FDT_PAD
* Separate setjmp.h into architecture dependent and independent parts
   - sandbox: remove linux/types.h dependency in setjmp.h
   - arm: include asm-generic/int-ll64.h in setjmp.h
   - common: clean up setjmp.h
* arm: use type jmp_buf instead of struct jmp_buf_data

=2D---------------------------------------------------------------
Adriano Cordova (9):
       efi_loader: efi_net: let efi_net_set_dp properly update the
device path
       legacy-net: wget: fix wget_info handling after new tcp legacy stack
       efi_loader: expose symbols to be used by the EFI network stack
       efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
       efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
       efi_loader: efi_device_path: Pass net udevice as argument
       efi_loader: efi_net: Add device path cache
       efi_loader: efi_net: Add dhcp cache
       efi_loader: efi_net: Add support for multiple efi_net_obj

Heinrich Schuchardt (5):
       sandbox: remove linux/types.h dependency in setjmp.h
       arm: include asm-generic/int-ll64.h in setjmp.h
       common: clean up setjmp.h
       arm: use type jmp_buf instead of struct jmp_buf_data
       lib: correct description of CONFIG_SYS_FDT_PAD

Yao Zi (1):
       efi_loader: Clean up usage of structure jmp_buf_data

  arch/arm/cpu/armv7/exception_level.c |   8 +-
  arch/arm/cpu/armv8/exception_level.c |   8 +-
  arch/arm/include/asm/setjmp.h        |  17 +-
  arch/arm/mach-rockchip/bootrom.c     |   2 +-
  arch/riscv/include/asm/setjmp.h      |  15 +-
  arch/sandbox/cpu/cpu.c               |   2 +-
  arch/sandbox/include/asm/setjmp.h    |  18 +-
  arch/x86/include/asm/setjmp.h        |  11 +-
  include/efi_loader.h                 |  52 +++-
  include/interrupt.h                  |   2 +-
  include/net-common.h                 |   1 +
  include/setjmp.h                     |  40 +++
  lib/Kconfig                          |   8 +-
  lib/efi_loader/efi_bootbin.c         |   3 +-
  lib/efi_loader/efi_boottime.c        |  30 +-
  lib/efi_loader/efi_device_path.c     |  26 +-
  lib/efi_loader/efi_http.c            |   6 +-
  lib/efi_loader/efi_ipconfig.c        |   4 +-
  lib/efi_loader/efi_net.c             | 579
++++++++++++++++++++++++++++-------
  lib/efi_loader/efi_setup.c           |  27 +-
  lib/efi_selftest/efi_selftest_snp.c  |   1 -
  net/wget.c                           |  18 +-
  test/lib/longjmp.c                   |   2 +-
  23 files changed, 651 insertions(+), 229 deletions(-)
  create mode 100644 include/setjmp.h
