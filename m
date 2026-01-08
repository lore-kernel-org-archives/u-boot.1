Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22203D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0377083B87;
	Thu,  8 Jan 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6zjFfWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C973F83A26; Thu,  8 Jan 2026 04:57:43 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECFB839DE
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 04:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b728a43e410so471285666b.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 19:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767844661; x=1768449461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HnZZBp8tdpXublulLQkCuxbCwo62i4pWSSkiwBTq2CE=;
 b=N6zjFfWMZkFgfa7mPhQJxCyxGhTTjDWL9hCG2+v11Aj5fWodJwJqgcAn4lSyk7+2Dw
 csVNUcU0L/VWf/xBh8UZOR9kjlUu3+eyQS5llL/iWY5Uy6spQL63xeICKXxhy1WnQ3yG
 FqNPMS5SeMd/2QR7SvUoyEbqe4A/u6sThLFPQfzOg7+cfECCoMAdnKKuqQTAH7vhJdC/
 k3fzE8chlL0nkn0i2G5GFhVEyeM1W2227X26Ur9HbD/jwRHYIzq4zABkuoTuVy93CoIH
 VYrPjRS56Jg0GeAyjVbHJiXaRV24h/F0WU7Pncu6vZ4rJFt1wYVhgQdduqnNsZTUQnR3
 Wg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767844661; x=1768449461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnZZBp8tdpXublulLQkCuxbCwo62i4pWSSkiwBTq2CE=;
 b=EvZBmzBmR4vnpr5l91p3kmWZS43qPnUWa/Hsf+dmRGeaIWOUCE124X3rCf03yf/fa8
 nq81dsVQUghBMSf6g9Ep+Id8aGTYJZAgWQRj9enhcU3cip0qZx9PH1Ns1tyvMsfgJUoN
 TWQrR9MS7qB5//WJ5GdSQ1VHzyNN6PcyBZGsGne0TlTIWDWPrDtTZPpAiaPL6fjyKN1T
 d0P1GXJojES3Oc0A5WXZiWrgzWtDvJSgJHVvNJEsFMaTxUmZrnnwarG1IY2ccJIUtz4X
 VOftc7LrNi6Uhk3t+zw2sfc71CH79A7Dgwbkhpcj9ePSIk6zOg6teKih3N/3Rs/CCFed
 SBqQ==
X-Gm-Message-State: AOJu0Yzu6rPnxdarf5N7MY+q1oFsBaAQRCRLObIl0+oZl2fw5YUBN7E4
 IdT1HT1jSJJYI1um4RwFVm0WUobU2e8GrHoWxRkmqhcr8AQHCkDigtb+43S6j5PRqrQeLjtWmLK
 laAHIJmlGnxDgzRdfLn5y19ZutFvwFuE=
X-Gm-Gg: AY/fxX5Dh16yxnRETYcFyqnTp9UgmCTEOp2wtDvZ8+tgj0p9OwOuGutLNNq/cxnq1lm
 rST7jIbwanvlUrSdIblYH3hnI6h1ecjhzaKjcRX/D33lnySWzP6Kv3aWMIfPYh3HB13ybZVqal9
 65FN6GdL6ctDI28uqI7FfOEbtsZ6dcJan6qHN/khxzKr19jQheOQJggSrrXT5eQp7o6JNWra6lY
 yoHINkHL7vUJpWT+kUhZoXJtPNKpd1wJR+sT5hjFhPAmhecgm/O5jM4F+pi5ewpmxpXsjX0y2Kb
 kCZDhRa8dSEaFymhh0axkDZAEU61Ng+Dk0l7wPr/jKj0LZrZSYkoLqQwvcw54mAsVOja9vXfvTC
 9GILfDe1UDUnkF42hsfVUwY3HXFP3h0jzvV8g
X-Google-Smtp-Source: AGHT+IFrjpYeF2K+rXG/pgDkBMhHQjeNnRXuX+gc3VMWNuEH5cc6VoSwxN6V2xUuUrn9ptp6Fy9iK4XLrul0+0n855c=
X-Received: by 2002:a17:907:a08:b0:b7c:e320:5250 with SMTP id
 a640c23a62f3a-b844517a24amr377766666b.7.1767844660737; Wed, 07 Jan 2026
 19:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <CALeDE9OP8qZAtWykrBDu95qx=Sp0jP7BK2BE0H1d1pfz6_YJNw@mail.gmail.com>
 <CAFLszTjQB1NBAKzTxsXKW-0d-V11BbzaLHswxSDAdbZ=3zbsTg@mail.gmail.com>
In-Reply-To: <CAFLszTjQB1NBAKzTxsXKW-0d-V11BbzaLHswxSDAdbZ=3zbsTg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 8 Jan 2026 03:57:29 +0000
X-Gm-Features: AQt7F2rbUdLig0kmdiIBlqLX8q_z92MsykTYWr7brcuQR6tvQWuJOm5q69yIOLs
Message-ID: <CALeDE9N0-BFVR6RwMcXVEUhUhYuG6yETYJp7pqw5kFwhEdMR6g@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

Hi Simon,

> > > Each arch does something slightly different before booting the OS. Some
> > > archs even do different things depending on the CPU type.
> > >
> > > EFT_LOADER has its own special code, regardless of which arch is being
> > > booted.
> > >
> > > It is quite hard to know what actually happens in the final milliseconds
> > > before the OS boot.
> > >
> > > This series attempts to clean up U-Boot in this area.
> > >
> > > The basic approach is to create a new bootm_final() function which is
> > > called by all archs. It provides some flags for a couple of necessary
> > > variations but otherwise it is generic.
> > >
> > > RISC-V, x86 and ARM are converted over to use this new function. For
> > > consistency, EFI loader is converted as well.
> > >
> > > A noteable change is that EFI_LOADER now does bootstage processing
> > > before boot, if enabled, thus producing a report.
> >
> > Why is the change needed, I don't see it explained in the patches or
> > here and what the implications might be.
>
> At present EFI_LOADER ignores bootstage and so there is no timing
> report produced even if enabled. It was probably an oversight.

So please include that level of detail.

> > > There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> > > recently on the mailing list.
> >
> > That appears to be unrelated to this series, it should be a separate
> > standalone patch else it needs to be described here why it's a
> > dependency, and even then likely still posted separately as a
> > dependency of this series.
>
> In what way is it unrelated? In my view this is related as it is a
> pre-OS cleanup. What do you mean by dependency here?

It is unrelated because if you remove it from the series the series
would still generally work as expected and if I apply the patch on
it's own without the rest of the series it works as expected. It is
only related by a vague association hence it should be sent separately
and discussed on it's own merit.

> > > Future work could take this a little further:
> > > - Drop board_quiesce_devices() and rely on driver model for that
> > > - Similarly with udc_disconnect(),
> > > - cleanup_before_linux() could use more details as to what it is
> > > supposed to do, to reduce the number of arch-specific variations
> >
> > What do you mean by that statement.
>
> Well, the function does different things on differents archs and is
> mostly uncommented (apart from an ARM-specific note in a README).
> Ideally it would be commented with exactly what it should do, ideally
> at a high level so it is not just arch-specific.

Well I would expect different arches to potentially do different
things, but your response doesn't explain to me why doing the same
thing is the right thing to do, why not doing the different things
won't affect the arrch, I want to know why the details of change is
good not a hand wavy thing (you yourself have asked others to do
similar explanations in the past too).

> > > Note: This is the first 10 patches for an 18-part series from the
> > > Concept tree, as requested. The patches after that complete the cleanup
> > > on ARM and RISC-V.
> > >
> > >
> > > Simon Glass (10):
> > >   boot: Create a function for final pre-boot steps
> > >   efi: Make use of bootm_final()
> > >   bootm: Add a message when booting
> > >   bootstage: Add some missing dummy functions
> > >   bootm: Do bootstage processing in bootm_final()
> > >   x86: Call bootm_final()
> > >   riscv: Drop board_quiesce_devices()
> > >   riscv: Call bootm_final()
> > >   efi: Drop EFI_GRUB_ARM32_WORKAROUND
> > >   x86: Add cleanup_before_linux()
> > >
> > >  MAINTAINERS                           |  1 +
> > >  arch/riscv/include/asm/u-boot-riscv.h |  1 -
> > >  arch/riscv/lib/bootm.c                | 24 +------------------
> > >  arch/x86/cpu/cpu.c                    |  5 ++++
> > >  arch/x86/lib/bootm.c                  | 14 +----------
> > >  boot/Makefile                         |  2 +-
> > >  boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
> > >  configs/mt7623n_bpir2_defconfig       |  1 -
> > >  include/bootm.h                       | 17 ++++++++++++++
> > >  include/bootstage.h                   |  8 +++++++
> > >  lib/efi_loader/Kconfig                | 10 --------
> > >  lib/efi_loader/efi_boottime.c         | 30 +----------------------
> > >  test/boot/bootflow.c                  |  2 +-
> > >  13 files changed, 70 insertions(+), 79 deletions(-)
> > >  create mode 100644 boot/bootm_final.c
> > >
> > > --
> > > 2.43.0
> > >
> > > base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> > > branch: bootma-us
