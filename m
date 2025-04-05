Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF42C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CC982AB2;
	Sat,  5 Apr 2025 22:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hN2qZd2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441FE82ABA; Sat,  5 Apr 2025 22:46:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F9A82AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso595036766b.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743885974; x=1744490774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MHnvoWLJFSJs8SXVDL1xxyX19yPp9Rqc2Kv4in0AWGU=;
 b=hN2qZd2kB3KIslJqlz4V+nvokId7O/HPgVc8Be9jipJmD5xWwszCwOennD0UccQl1I
 FUSxxTl6+jFXiHMHdDoLKtRoyJ1ON+9qJfgZcZaDeDy5metYgiF7hDO6zO/eCeSh1++l
 lDpqPwSi5Nc+i1ok5aaI7zgSFd90OftJgFnOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743885974; x=1744490774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHnvoWLJFSJs8SXVDL1xxyX19yPp9Rqc2Kv4in0AWGU=;
 b=tPNipnX+FQsrvAYkrE1aWm0q4PR1ibCYUvCn6Y1Flh6LykYy0Y5gxnDYu7i/ZjFVvZ
 qAU4okm2I8N/jWywWPu4yJfN1Rn03J9lKoXWhRY+8JxZWAdmOv7U9cMCxDBqMdKsnfru
 e+7JxXxKtwSw1rwHzwo3xP/UKjKlK6H4O8wFhRhyZxBiuQnjulVduRTVtdedEPObJC4V
 YfvXBEEswEmBo5ekpOZ1VI7iNCz9VlsXPPZHFMpVcf6r+/BEa8mIpuAfdbWwl8h+H3Ma
 eHHhz1ARCqjbwCP+bXV1VB0LvSPOQrYKzPXJyyDVYl+2jNrr8LvBihDjkCu4GvZO5PiY
 pY6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnd1QDbusfFeQpVdj4O1C+8z9aBuTpTEdOCBhJ4U38bP5Y9vRsDLp1xw2hMnQxmURTG+r8G00=@lists.denx.de
X-Gm-Message-State: AOJu0YxQH8/1YDl1UC4DveKZWP2iNM7Q3HU6/VSuuDV91EA86giKJFNd
 Fm7TZiGsYDGoBds2W9pzkmVrCi/T2+E7wrm1aR11T8gbZlKsc1+ybOOyepMgdbDni45Cp+VRZ8T
 l+xmakD0BdMygtcGzv0g2Iao0A9gbOBe+NVbf
X-Gm-Gg: ASbGncvAXl7tpKqy3WZnJI8t1TnMREGoepjONzVQk3gbPoCfo/6PjZZyYYMNipBBOov
 H1Ixqxehoxq2/TVDDy/9ALJoGDHmuISRpr70shLMpWKjetO+8cAshloKLR6WyqgCHDKckbFM+zz
 rsWSEgV7p41I9pxIPO6vfy76/JRPhC4KToOTJx78A=
X-Google-Smtp-Source: AGHT+IHREbXMqLxcKbNr23q0QY/Rf65+BxdKBHoPuUY/n7ojPQN4sBy+ERHUs+I3D3P2nR25g8462EIgjCKiP9ZKt/U=
X-Received: by 2002:a17:907:6d24:b0:abf:d4a9:a096 with SMTP id
 a640c23a62f3a-ac7d6e3d174mr587199966b.37.1743885974063; Sat, 05 Apr 2025
 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de>
 <20250404163315.GS5495@bill-the-cat>
In-Reply-To: <20250404163315.GS5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 6 Apr 2025 08:46:02 +1200
X-Gm-Features: ATxdqUEVsDofjyvcqAyAQECYO34QBvBZix1SF2w9PtNtDynXLhllr8PsFAaTvjA
Message-ID: <CAFLszTi33T=zaJJksP-qadoh2DZF6T2Xy-8M6f7CoJMbYXEz2w@mail.gmail.com>
Subject: Re: SMBIOS tables missing on 2025.04-rc5 on qemu-x86
To: Tom Rini <trini@konsulko.com>
Cc: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

+Heinrich Schuchardt

Hi,

On Sat, 5 Apr 2025 at 05:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 04, 2025 at 03:10:29PM +0200, Niklas Sombert wrote:
>
> > Hi all,
> >
> > I've written a small EFI bootloader and I'm testing it on QEMU with OVMF and
> > with u-boot (with the qemu-x86_defconfig as -bios in QEMU).
> >
> > On upgrading from 2025.01 to 2025.04-rc5, I've noticed that the SMBIOS
> > tables that are passed via the SMBIOS EFI config table are completely blank
> > (just zeroes instead of starting with SM3).
> >
> > This is pretty easy to reproduce:
> >
> > git checkout v2025.01
> > make clean
> > git clean -xf
> > make qemu-x86_defconfig
> > # edit .config: CONFIG_CMD_SMBIOS=y
> > make -j4
> > qemu-system-i386 -bios u-boot.rom
> > # type "smbios" in the prompt and see information about the system
> >
> > versus:
> > git checkout v2025.04-rc5
> > make clean
> > git clean -xf
> > make qemu-x86_defconfig
> > # edit .config: CONFIG_CMD_SMBIOS=y
> > make -j4
> > qemu-system-i386 -bios u-boot.rom
> > # type "smbios" and get the following error:
> > # do_smbios() Unknown SMBIOS anchor format
> >
> > This is on QEMU version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.25), the one
> > Ubuntu 22.04 currently ships, but I also get the same results on Ubuntu
> > 24.04.
> >
> > Bisecting leads me to the following commit:
> >
> > commit d5bc5c6cb0291203fe848a8532a7ecbcd44cfe9e
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Fri Jan 10 17:00:26 2025 -0700
> >
> >     x86: emulation: Enable bloblist
> >
> >     Add bloblist support so that tables can be generated and placed in a
> >     bloblist, then passed to a payload using UPL
> >
> >     Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> > index 2771a4b9e19..792ba06c2b8 100644
> > --- a/configs/qemu-x86_64_defconfig
> > +++ b/configs/qemu-x86_64_defconfig
> > @@ -1,6 +1,7 @@
> >  CONFIG_X86=y
> >  CONFIG_TEXT_BASE=0x1110000
> >  CONFIG_SYS_MALLOC_F_LEN=0x1000
> > +CONFIG_BLOBLIST_SIZE_RELOC=0x20000
> >  CONFIG_NR_DRAM_BANKS=8
> >  CONFIG_ENV_SIZE=0x40000
> >  CONFIG_MAX_CPUS=2
> > @@ -33,6 +34,7 @@ CONFIG_LOGF_FUNC=y
> >  CONFIG_SPL_LOG=y
> >  CONFIG_DISPLAY_BOARDINFO_LATE=y
> >  CONFIG_PCI_INIT_R=y
> > +CONFIG_BLOBLIST=y
> >  CONFIG_BLOBLIST_FIXED=y
> >  CONFIG_BLOBLIST_ADDR=0x10000
> >  CONFIG_SPL_NO_BSS_LIMIT=y
> > diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
> > index 947d15cd727..0b0e10c795f 100644
> > --- a/configs/qemu-x86_defconfig
> > +++ b/configs/qemu-x86_defconfig
> > @@ -1,6 +1,7 @@
> >  CONFIG_X86=y
> >  CONFIG_TEXT_BASE=0xFFF00000
> >  CONFIG_SYS_MALLOC_F_LEN=0x1000
> > +CONFIG_BLOBLIST_SIZE_RELOC=0x20000
> >  CONFIG_NR_DRAM_BANKS=8
> >  CONFIG_ENV_SIZE=0x40000
> >  CONFIG_MAX_CPUS=2
> > @@ -23,6 +24,9 @@ CONFIG_LOG=y
> >  CONFIG_LOGF_FUNC=y
> >  CONFIG_DISPLAY_BOARDINFO_LATE=y
> >  CONFIG_PCI_INIT_R=y
> > +CONFIG_BLOBLIST=y
> > +CONFIG_BLOBLIST_FIXED=y
> > +CONFIG_BLOBLIST_ADDR=0x10000
> >  CONFIG_CMD_CPU=y
> >  CONFIG_CMD_BOOTEFI_SELFTEST=y
> >  CONFIG_CMD_NVEDIT_EFI=y
> >
> > Just setting CONFIG_BLOBLIST=n solves this problem for me.
> >
> > I'm not sure how to debug this further, because v2025.01 doesn't build with
> > the config from v2025.04-rc5:
> > ld.bfd: arch/x86/lib/tables.o: in function `write_tables':
> > /home/niklas/Build/u-boot/arch/x86/lib/tables.c:171: undefined reference to
> > `acpi_write_rsdp'
>
> I think for the v2025.04 release we should just put BLOBLIST=n (so long
> as CI passes still), and file an issue to sort this out for the next
> release. Can you please file something at
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues ? Thanks!

Heinrich wrote an smbios test[1] so I wonder why it is not catching
this problem?

(looks)

CMD_SMBIOS is not enable for qemu-x86. When enabled, I see:

=> smbios
          do_smbios() Unknown SMBIOS anchor format

The test should really be written in C, not Python, though.

The root cause is my patch which switches to using bloblist, as the
EFI code still uses the SMBIOS address in global_data, which is now
not set.

I'll send a patch to fix this. As I mentioned to Heinrich in another
email, at some point we should drop these table points and always use
bloblist.

Regards,
Simon

[1] test/py/tests/test_smbios.py
