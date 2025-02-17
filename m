Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E4C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C09680104;
	Mon, 17 Feb 2025 14:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JDoY6b7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1980C80C7E; Mon, 17 Feb 2025 14:16:17 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B9980017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abb75200275so274772266b.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798174; x=1740402974; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVXHTcZJbuBhQaBn+fqYCdWjlzuNb1I/9f3EwiJRMZE=;
 b=JDoY6b7C4op5spnOVAWCc++cbJDcPkPtAZNiuuifNSaOm0iUB+NGjx9gukRgft4QeW
 C8LtZ6MW/9RPX01KxtcC8yWDutw3JX8mBNRotPf15bdkAA1ohMrVAVPfoYQ+AVl0RTlx
 Me2Kh3BqJyHRMXWPi7jKIhURutBjmuyLfkfX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798174; x=1740402974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVXHTcZJbuBhQaBn+fqYCdWjlzuNb1I/9f3EwiJRMZE=;
 b=Mna5hw5mnZm5yR/u5O2ZNgxp7yNC+eVA8OPzt2zXLIK7fe4b8Qw3vbg7DZevG7ohHo
 J4S/NsosE5XGJ/En6i/ujdCTQpiYEgTECbU5MPo1GEqb6U9bOJEkTCw3sTfq87HrQQ9w
 MRDNDOHXbKyqDIQtxL7LmHau8w9OlnyKJtkUuzD7x4JiHtY+6dGuFsUNaI1w4vdXUn9V
 dvlkFknFaYfMXq2p/pNwiDwAbPBiwzfavHOVpuuwWGSWpqbPTEDCwgWh2EtpIz4KLYZX
 Te2Fmc0fQ5qwKW1aHkukTuoyQNZd2MOCflIBViSbJZNj9/ShSBN0Lv6nAfVNWK2xJeqF
 pVRg==
X-Gm-Message-State: AOJu0YyvZoHsxSn7+KKgFI1+pVjyclf1p4Nq6p4ytYmDGl2hE31l7rny
 8pV0aSLQJyI8KVJDYsZdooPKYCtZfhtTdXHFrcLkjLt1dcQZkz9NgmJxNyrr26/Ne0VvaxXJC0b
 xfSNIrb44Zwkc9zsQ1UZhHkAgvhUGdDoYCcN8
X-Gm-Gg: ASbGncvL/4KMYUrlvt74vxLUNte8D2kZxtukH/8h3QGmrCnJ9BsFf5UbSG8DfwymTOR
 /yrTy4Az1pzE3I6z1bhacAqGa5bf5qS8QUSjvoErqHz2nV9ftkH9hUe+L5Vw2wahLkVw+EhCaxQ
 ==
X-Google-Smtp-Source: AGHT+IEd0bb7JlHqbvqKvKHlKs0GbDXZyEvMvZ1xLXm79Qkl/EkClX2eYBr3MkgKCUphln4ZYOcfgzYltcr80u/2lSA=
X-Received: by 2002:a17:907:1ca1:b0:aa6:6885:e2fa with SMTP id
 a640c23a62f3a-abb70b2087dmr1015940366b.14.1739798173866; Mon, 17 Feb 2025
 05:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <2af835ff-e93f-4674-a6ee-9e697109651c@redhat.com>
In-Reply-To: <2af835ff-e93f-4674-a6ee-9e697109651c@redhat.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:16:01 -0700
X-Gm-Features: AWEUYZn7dQD6byprZ8zUKcYYz9pu2gmV8mhQfn9AKRUa88BsGV7IEK9V7g0RkB0
Message-ID: <CAFLszThsMgmgAULOXS1TtqMQ8KCfmpZqApnoSAGnLHyBQaB6aQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 qemu-devel@nongnu.org, Tom Rini <trini@konsulko.com>
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

Hi Paolo,

On Sun, 16 Feb 2025 at 14:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/16/25 21:43, Simon Glass wrote:
> > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > is not perfect.
> >
> > With both builds, executing the VESA ROM causes an intermittent hang, a=
t
> > least on some AMD CPUs.
> >
> > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit=
)
> > is done in a way that works on real hardware but not with QEMU. This
> > means that performance is 4-5x slower than it could be, at least on my
> > CPU.
>
> Do you have a reproducer for this?  It shouldn't happen... also, do you
> know if this is broken for both Intel and AMD CPUs?

You can see this if you build the right commit (e52e307c7ca) from my
tree[1], i.e. after U-Boot changes to Bochs and before it changes the
64-bit entry mechanism:

04:57 $ pe
e52e307c7ca (HEAD) x86: qemu: Switch to bochs display
83f8b00df47 x86: Expand x86_64 early memory
71a6c3eb3d8 Revert "efi_memory: do not add U-Boot memory to the memory map"
d9d87e11e97 test: Make net tests depend on CONFIG_CMD_NET
3c67e62b109 test/py: Show info about module-loading
7059d976d22 test/py: Drop assigning ubman to cons
e361abfc638 test/py: Drop importing utils as util
460ecb6e5cd test/py: Drop u_boot_ prefix on test files
cc5600e734c test/py: Shorten u_boot_console
777c7a0c20e test: Update documentation
=E2=9C=94 ~/u [:e52e307c7ca|=E2=80=A66=E2=9A=91 1160]
04:57 $ ./tools/buildman/buildman --bo qemu-x86_64 -o /tmp/b/qemu-x86_64/ -=
w
Building current source for 1 boards (1 thread, 32 jobs per thread)
    1    0    0 /1              qemu-x86_64
Completed: 1 total built, 1 newly), duration 0:00:02, rate 0.50
=E2=9C=94 ~/u [:e52e307c7ca|=E2=80=A66=E2=9A=91 1160]
04:57 $ qemu-system-x86_64 -bios /tmp/b/qemu-x86_64/u-boot.rom
-enable-kvm    -nographic
Running qemu-system-x86_64  -display none -serial mon:stdio

U-Boot SPL 2025.01-rc3-00635-ge52e307c7ca8 (Feb 17 2025 - 04:57:59 -0700)
Trying to boot from SPI
Jumping to 64-bit U-Boot: Note many features are missing
(hangs here)
QEMU: Terminated

I am running this on an AMD system. But I just tried it on an Intel
laptop and it has the same issue.
>
> Thanks,
>
> Paolo
>
Regards,
Simon

> > We can work around the first problem by using Bochs, which is anyway a
> > better choice than VESA for QEMU. The second can be addressed by using
> > the same descriptor across the jump to long mode.
> >
> > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> >
> > Changes in v2:
> > - Redo commit message
> > - Add new patch to rename the _D dirty flag
> > - Add new patch to support CPU functions in long mode
> > - Add new patch to tidy up address size in MTRR calculations
> > - Add new patch with a 64-bit version of is_power_of_2()
> > - Add new patch to set an MTRR for the RAM in QEMU
> > - Add new patch with a helper to send characters
> > - Add new patch to allow tests to be filtered by role
> > - Add more patches to support booting with kvm
> > - Add new patch with a test for booting Ubuntu 24.04
> >
> > Simon Glass (28):
> >    x86: Expand x86_64 early memory
> >    x86: qemu: Switch to bochs display
> >    x86: qemu: Enable dhrystone
> >    x86: qemu: Avoid accessing BSS too early
> >    x86: Drop mpspec from the SPL build
> >    x86: Add some log categories
> >    x86: Drop use of CONFIG_REALMODE_DEBUG
> >    x86: Avoid clearing the VESA display
> >    x86: Add 64-bit entries to the GDT
> >    x86: Use defines for the cache flags
> >    x86: spl: Drop duplicate CPU init
> >    x86: Drop the message about features missing in 64-bit
> >    x86: Include stdbool.h in interrupt header
> >    x86: Tidy up the GDT size in start/16.S
> >    x86: Disable paging before changing to long mode
> >    x86: Use the same GDT when jumping to long mode
> >    x86: Use a simple jump into long mode
> >    x86: Rename the _D dirty flag
> >    x86: Support CPU functions in long mode
> >    x86: Tidy up address size in MTRR calculations
> >    Add a 64-bit version of is_power_of_2()
> >    x86: Support MTRRs of 4GB on 32-bit machines
> >    x86: emulation: Set an MTRR for the RAM
> >    scripts: Expand a few options
> >    test/py: Add a helper to send characters
> >    test/py: Allow tests to be filtered by role
> >    RFC: test/py: Deal with timeouts
> >    test: Add a test for booting Ubuntu 24.04
> >
> >   .gitlab-ci.yml                   |  5 +++
> >   arch/x86/cpu/cpu.c               | 24 +++++++++++++++
> >   arch/x86/cpu/i386/call64.S       | 35 +++++++++------------
> >   arch/x86/cpu/i386/cpu.c          | 41 +++++++++---------------
> >   arch/x86/cpu/mtrr.c              | 12 +++++---
> >   arch/x86/cpu/qemu/dram.c         | 15 +++++++++
> >   arch/x86/cpu/qemu/qemu.c         | 20 ++++++++----
> >   arch/x86/cpu/start.S             |  4 ++-
> >   arch/x86/cpu/start16.S           |  3 +-
> >   arch/x86/cpu/x86_64/cpu.c        |  5 ---
> >   arch/x86/include/asm/cpu.h       | 35 ++++++++++++++++++---
> >   arch/x86/include/asm/interrupt.h |  1 +
> >   arch/x86/include/asm/processor.h |  5 ++-
> >   arch/x86/lib/Makefile            |  2 ++
> >   arch/x86/lib/bios.c              | 27 +++++++++-------
> >   arch/x86/lib/bios_interrupts.c   |  8 ++---
> >   arch/x86/lib/i8259.c             |  2 ++
> >   arch/x86/lib/spl.c               |  4 +--
> >   configs/qemu-x86_64_defconfig    | 10 +++---
> >   configs/qemu-x86_defconfig       |  6 ++--
> >   include/linux/log2.h             |  6 ++++
> >   scripts/build-qemu.sh            |  4 +--
> >   test/py/conftest.py              | 22 +++++++++++++
> >   test/py/console_base.py          | 33 ++++++++++++--------
> >   test/py/pytest.ini               |  1 +
> >   test/py/tests/test_distro.py     | 53 +++++++++++++++++++++++++++++++=
+
> >   test/py/tests/test_sleep.py      |  1 +
> >   27 files changed, 273 insertions(+), 111 deletions(-)
> >   create mode 100644 test/py/tests/test_distro.py
> >
>

[1] https://ci.u-boot.org/u-boot/u-boot/-/commits/qemu?ref_type=3Dheads
