Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEECC282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 19:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436DC80ECC;
	Sun, 16 Mar 2025 20:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNjVpdWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9457D810E8; Sun, 16 Mar 2025 20:32:11 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70939801DE
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 20:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so5561291a12.3
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742153528; x=1742758328; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HNcsKQPFZ2FHZbkD/7OXxWpEAsLaCS0S6qGobISXnQ=;
 b=dNjVpdWrTsQ2imyYdMex3Mk4el22qZ1EYkyn753N/Ei89or9L7sxIucDv+lNHUPc/Z
 Rvip4PQmyDMUcQGlKYSsHFjcxCRfA3L76/2bivPXpRLAeiPK6nWM9H3prqJJgpr75cH/
 DW8oKz3hz3DeC+loq6V4ebLItqzIRwv5GZIr0FsysiLfsaNmZdY9Sym5AMvEcnZs8Dvy
 959JorTzM/xk/YtlOZPviM/NAiuiVDg2w7o3Wv3tQB5QeVQ2UiBCuTmU13lk7efR1RO6
 sY+UnlZsPKBB60AC0wE63V++JmmDXAB8O7ykHCL6jkO2jhwEbETH1dssLcajiOLbeE7b
 napQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742153528; x=1742758328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HNcsKQPFZ2FHZbkD/7OXxWpEAsLaCS0S6qGobISXnQ=;
 b=Xms3LpPY+CxZZyE8/9jUCcruDN06vl5zBi2zbp/Y5HPDIf9DX76tcfZsbpOg+Om+8s
 etQeYGpW5xAaZFYpvuxcKeUYsFg+F8NlMx2T66ExD8WhgUi6lsRME9Auq3AF5Bg46PzD
 dnC/HIJwLbH3QtYMBKJmFLaRpuOxu3BJ5oxWbUdY6jIcvLMNCxeTR531r/+sAZSV3Dvp
 Qh9hBjoBuZkvtpmE7bgIP5E3on13OdE0tr93/khIKA4fpfEIi0IJ4L1hOID5OjSn18w8
 WGXP++HtcjuIxW2Vz/chSyElxc5OrfVYgAaSD3hiNtp4732DOKEXL4fcN+F9Zz4eZO8j
 2oHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNdotReQE5VpyvDBLBKaN8x0D2VUB1F3ieACKJIAMN0bRjrfUpzIPMn2n6JHLzkN/jobzQFmQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzzIt8jK3Gk6HcUKm/nAVoXsu98Neg6UWD4hrwJcZSYTYsqOrCD
 HnJfQ1I4nGn8JWkc4WNDqQq16xSxlV1XcBYxjUkXWSUgAAhi23t8l7BTbMVc2t9NmJ3Xf+IGzDB
 zGniCBdD5t6wmjHtFMvkJrVwnMvI=
X-Gm-Gg: ASbGncuMtthpz3rLaXy/K/VNtOm7Lw+1OVDumnJSyAAHVuBxd5ZyJT+HC3o9b3JHmWi
 PJlPtyaocARCxvUi/06ZPHaZWRuG1dxpr9035wYhThN8dl+eHrkmih2XZVgUgwtCJSo4GdQ+JlV
 F4EYLRoIEakoa02DQOUXVMzN5GPjhxJUfIazM/CPw5v5gdSHIjuWq1tW8BJbs=
X-Google-Smtp-Source: AGHT+IE5wBYu155s0QdOVDlKeQ2KQppTygVW872ZJkAB9bR/0hnnIOAHj/T5MmjYY2HywQ/Osm03DmEbhThTLQVOoHE=
X-Received: by 2002:a05:6402:210e:b0:5e4:a1e8:3f04 with SMTP id
 4fb4d7f45d1cf-5e89f152ab5mr6848722a12.8.1742153527566; Sun, 16 Mar 2025
 12:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <ACC5355E-F949-42BD-8BDC-C2C8C740DB34@gmx.de>
In-Reply-To: <ACC5355E-F949-42BD-8BDC-C2C8C740DB34@gmx.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 16 Mar 2025 12:31:55 -0700
X-Gm-Features: AQ5f1JpuYF6E34wKVghjfe7do1AjoPXK6Z1g6L5lYlpsEcZ-5UL19xEG_kq8zIw
Message-ID: <CAH5Ym4ipjaOiY36x+1tinFqudjpwtRRtcXRu7P8311AAKmZDwg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Various toolchain compatibility
 fixes/improvements
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Mar 15, 2025 at 10:27=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 15. M=C3=A4rz 2025 23:17:58 MEZ schrieb Sam Edwards <cfsworks@gmail.co=
m>:
> >Hello again U-Boot list,
> >
> >This is v2 of my "misc. fixes" series, sent to prepare the codebase for =
more
> >direct LLVM support in the near future. This series contains several fix=
es that
> >I found in the process of preparing that support and which address issue=
s
> >independent of any future feature or enhancement. I am sending these now=
, both
> >so that their inclusion is not delayed by discussion on my upcoming seri=
es and
> >to make the latter more manageable.
> >
> >PLEASE APPLY PARTIALLY! I have tried to sort these so that the most
> >straightforward changes come first. If any patch proves contentious, you=
 can
> >either skip it or stop applying the series at that point. Any patches th=
at need
> >revisions will be included in a future series, but I'm trying to avoid t=
here
> >being a v3 of *this* series. :)
> >
> >Happy Saturday,
> >Sam
>
> Hello Sam,
>
> I wonder why there are only ARM and X86 specific patches in this series .=
 Wouldn't some of the changes also be needed for RISC-V and other architect=
ures?

Hi Heinrich,

The breakdown of arch-specific patches is: 6 for ARM, 1 for RISC-V, 1
for X86. This distribution was only because ARM needed more work, not
because it received more attention. (Some architectures, like
"sandbox," required no fixes, and MIPS appears to need only
compiler-side improvements at this time, for example.)

>
> For EFI we have carved out a linker script include file to harmonize the =
linker scripts used by ARM and RISC-V. Shouldn't we do the same for main U-=
Boot?

I like the idea in principle, but I'm skeptical because EFI
applications have a much more uniform and constrained memory layout
compared to raw binaries on [vendor-specific board]. So while it's
possible to mostly unify the memory layout, doing so would take
significantly more effort than with EFI. Plus, most of our supported
architectures don't have EFI at all, so unifying EFI across a few
architectures isn't a strong indicator that this approach would scale
well. Also, Linux doesn't do this either, and I'd expect they would
have if it were a good idea.

That said, I'd prefer to keep this patchset focused on fixing these
immediate issues rather than reworking the linker scripts more
broadly. If we want to explore that as a separate effort, I think it
would need a deeper discussion.

Happy Sunday,
Sam

>
> Best regards
>
> Heinrich
>
> >
> >Changes v1->v2:
> >- Carried forward acked/reviewed tags
> >- Dropped two patches (one was incorrect, the other can be fixed differe=
ntly)
> >- Minor phrasing changes to commit messages
> >- Instead of removing `ENTRY(_start)`, I instead added `.globl _start` w=
here
> >  appropriate, in the EFI apps
> >
> >Sam Edwards (15):
> >  arm: Remove stray .mmutable reference in linker script
> >  arm: Exclude eabi_compat from LTO
> >  arm: Add __aeabi_memclr in eabi_compat
> >  arm: Add aligned-memory aliases to eabi_compat
> >  arm: Discard unwanted sections in linker script
> >  arm: Replace 'adrl' in EFI crt0
> >  x86: Fix call64's section flags
> >  makefile: Avoid objcopy --gap-fill for .hex/.srec
> >  makefile: Add `norelro` linker option
> >  makefile: Add READELF command variable
> >  arm: riscv: efi: Export _start symbol from crt0_*_efi stubs
> >  efi_loader: Move .dynamic out of .text in EFI
> >  scripts/Makefile.lib: efi: Preserve the .dynstr section as well
> >  spl: riscv: opensbi: Error on misaligned FDT
> >  spl: Align FDT load address
> >
> > Makefile                        | 14 ++++++++------
> > arch/arm/cpu/u-boot.lds         | 29 ++++++++++-------------------
> > arch/arm/lib/Makefile           |  1 +
> > arch/arm/lib/crt0_aarch64_efi.S |  1 +
> > arch/arm/lib/crt0_arm_efi.S     |  4 +++-
> > arch/arm/lib/eabi_compat.c      | 17 +++++++++++++++++
> > arch/riscv/lib/crt0_riscv_efi.S |  1 +
> > arch/x86/cpu/i386/call64.S      |  2 +-
> > common/spl/spl_fit.c            |  2 +-
> > common/spl/spl_opensbi.c        |  5 +++++
> > lib/efi_loader/elf_efi.ldsi     |  6 +++---
> > scripts/Makefile.lib            |  4 ++--
> > 12 files changed, 53 insertions(+), 33 deletions(-)
> >
>
