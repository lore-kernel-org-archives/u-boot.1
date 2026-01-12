Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F46CF45D9
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 23:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C373983759;
	Tue, 13 Jan 2026 00:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AgC60Y0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7298883966; Tue, 13 Jan 2026 00:44:43 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8FF83759
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 00:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b86f3e88d4dso302722966b.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768261480; x=1768866280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad6Gobzs/6lj5VA69zJId53Qi4iGqPKP5u/Cylmz5dQ=;
 b=AgC60Y0v31PUCq59yKmT58jjz8mZ01mxJCv1fbNeazHcpdTeXyJAgi3JdgNkt2ciO4
 FF2IhAB03EmJtCqFUTbP80ldrEVOT4u6ukRCK4P0V6J/lnAGyGeaxDUPGjT4QMFXf/R2
 qBYFYN5rdq0VVjggbSnzAmkcTa35nFrGwbMtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768261480; x=1768866280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad6Gobzs/6lj5VA69zJId53Qi4iGqPKP5u/Cylmz5dQ=;
 b=HxJc2RXcA7G9QZHu+HhZvqFBdt1fQaXNutPrFH4bbsn/28fj++j9HHII767PXTH3UE
 KRpvpQ6SKENapPW7an0i4dhN71eRFB//Qls2JQl8u250ghFz4j4LYn/gEViSzDicYSQn
 bMtyyTxWgnaJ+ol9ZzlKCZyuDndALqCHf5yhEE4H+n2YV7L0qSDU/qMk+davhZoMs1vl
 Sa0IC1BONbne+0SN4weAZZvDFpWOvN3OMek4f3ajTx+XHW2105hKeTYnj789K086E22+
 7Tb1uFRuh6NdMP9KQCkb6/DJbVaAqh0yfgVn79EKaw4MEE5iYqRhv2BsL9uOhlY9g5fG
 R25w==
X-Gm-Message-State: AOJu0YzZSgUWEpxNTfNeVNrP1245ik/pe23WUB8S0CMJjLGo8sUFavoU
 xdOHBx4QSyqy7q8bV0pT17It8m9IZL5J2/Eazszx1SU2AuudqzeUE3TjHJ8BcgB/AcgEEIUS8WB
 7S2qsXGT73GiJiIyOLEvMv/euuExgreyoh27ZKlXY
X-Gm-Gg: AY/fxX5j4x7qv72JZRkm62xsUJQgoZPlvuF5aXYCWF+xO+SSEhZmoiLhCum70aknHTt
 PWP71gTL8r3extI6T8pNwS+HvsrS4ntzFvv7wUfXFDaUtIzu3DM4US88sqDjalEMwDTe7kPO5KZ
 /uFgod6z+ovqZiGxU62Bhr2TncMMhkMMq+/uyKG7D4AsVrkQqbzbyhUEJWfGC/bhvXbbYVwbBJ3
 6jv0/9RV1gAU/27rZNoBMK5BUOGlO3E0lxdyNquI58Fbz2QtrIIZ9/e1vcBhBq4pHvdjw==
X-Google-Smtp-Source: AGHT+IGr6aqMNVfK2iP3qX9Jm4e9weh/ib74GXCzutBL90PvfYFly0oUDPXV20xwi7CP6T+wuUONdGcd/YLwFRUnS+0=
X-Received: by 2002:a17:907:3d42:b0:b80:46f5:cabe with SMTP id
 a640c23a62f3a-b8444c4d2aemr2044092866b.4.1768261480374; Mon, 12 Jan 2026
 15:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <CALeDE9OP8qZAtWykrBDu95qx=Sp0jP7BK2BE0H1d1pfz6_YJNw@mail.gmail.com>
 <CAFLszTjQB1NBAKzTxsXKW-0d-V11BbzaLHswxSDAdbZ=3zbsTg@mail.gmail.com>
 <CALeDE9N0-BFVR6RwMcXVEUhUhYuG6yETYJp7pqw5kFwhEdMR6g@mail.gmail.com>
In-Reply-To: <CALeDE9N0-BFVR6RwMcXVEUhUhYuG6yETYJp7pqw5kFwhEdMR6g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Jan 2026 16:44:28 -0700
X-Gm-Features: AZwV_QiOfbky_YCtnjCnC0FUX7vErYVfrBrVJRZEtLACIXNqMdqzX4Kb0KGxUyE
Message-ID: <CAFLszTiCDO=xO8fW-hwdm0FD9EXynNJWLpq9h+F8gKA9ZCZCpw@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
To: Peter Robinson <pbrobinson@gmail.com>
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
X-Mailman-Approved-At: Tue, 13 Jan 2026 00:47:40 +0100
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

Hi,

On Wed, 7 Jan 2026 at 20:57, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > > Each arch does something slightly different before booting the OS. Some
> > > > archs even do different things depending on the CPU type.
> > > >
> > > > EFT_LOADER has its own special code, regardless of which arch is being
> > > > booted.
> > > >
> > > > It is quite hard to know what actually happens in the final milliseconds
> > > > before the OS boot.
> > > >
> > > > This series attempts to clean up U-Boot in this area.
> > > >
> > > > The basic approach is to create a new bootm_final() function which is
> > > > called by all archs. It provides some flags for a couple of necessary
> > > > variations but otherwise it is generic.
> > > >
> > > > RISC-V, x86 and ARM are converted over to use this new function. For
> > > > consistency, EFI loader is converted as well.
> > > >
> > > > A noteable change is that EFI_LOADER now does bootstage processing
> > > > before boot, if enabled, thus producing a report.
> > >
> > > Why is the change needed, I don't see it explained in the patches or
> > > here and what the implications might be.
> >
> > At present EFI_LOADER ignores bootstage and so there is no timing
> > report produced even if enabled. It was probably an oversight.
>
> So please include that level of detail.
>
> > > > There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> > > > recently on the mailing list.
> > >
> > > That appears to be unrelated to this series, it should be a separate
> > > standalone patch else it needs to be described here why it's a
> > > dependency, and even then likely still posted separately as a
> > > dependency of this series.
> >
> > In what way is it unrelated? In my view this is related as it is a
> > pre-OS cleanup. What do you mean by dependency here?
>
> It is unrelated because if you remove it from the series the series
> would still generally work as expected and if I apply the patch on
> it's own without the rest of the series it works as expected. It is
> only related by a vague association hence it should be sent separately
> and discussed on it's own merit.
>
> > > > Future work could take this a little further:
> > > > - Drop board_quiesce_devices() and rely on driver model for that
> > > > - Similarly with udc_disconnect(),
> > > > - cleanup_before_linux() could use more details as to what it is
> > > > supposed to do, to reduce the number of arch-specific variations
> > >
> > > What do you mean by that statement.
> >
> > Well, the function does different things on differents archs and is
> > mostly uncommented (apart from an ARM-specific note in a README).
> > Ideally it would be commented with exactly what it should do, ideally
> > at a high level so it is not just arch-specific.
>
> Well I would expect different arches to potentially do different
> things, but your response doesn't explain to me why doing the same
> thing is the right thing to do, why not doing the different things
> won't affect the arrch, I want to know why the details of change is
> good not a hand wavy thing (you yourself have asked others to do
> similar explanations in the past too).
>
> > > > Note: This is the first 10 patches for an 18-part series from the
> > > > Concept tree, as requested. The patches after that complete the cleanup
> > > > on ARM and RISC-V.
> > > >
> > > >
> > > > Simon Glass (10):
> > > >   boot: Create a function for final pre-boot steps
> > > >   efi: Make use of bootm_final()
> > > >   bootm: Add a message when booting
> > > >   bootstage: Add some missing dummy functions
> > > >   bootm: Do bootstage processing in bootm_final()
> > > >   x86: Call bootm_final()
> > > >   riscv: Drop board_quiesce_devices()
> > > >   riscv: Call bootm_final()
> > > >   efi: Drop EFI_GRUB_ARM32_WORKAROUND
> > > >   x86: Add cleanup_before_linux()
> > > >
> > > >  MAINTAINERS                           |  1 +
> > > >  arch/riscv/include/asm/u-boot-riscv.h |  1 -
> > > >  arch/riscv/lib/bootm.c                | 24 +------------------
> > > >  arch/x86/cpu/cpu.c                    |  5 ++++
> > > >  arch/x86/lib/bootm.c                  | 14 +----------
> > > >  boot/Makefile                         |  2 +-
> > > >  boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
> > > >  configs/mt7623n_bpir2_defconfig       |  1 -
> > > >  include/bootm.h                       | 17 ++++++++++++++
> > > >  include/bootstage.h                   |  8 +++++++
> > > >  lib/efi_loader/Kconfig                | 10 --------
> > > >  lib/efi_loader/efi_boottime.c         | 30 +----------------------
> > > >  test/boot/bootflow.c                  |  2 +-
> > > >  13 files changed, 70 insertions(+), 79 deletions(-)
> > > >  create mode 100644 boot/bootm_final.c
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > > base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> > > > branch: bootma-us

Just stepping back a bit...I haven't seen any patch collect a review
tag and the feedback seems less than encouraging. Here is the
patchwork link:

https://patchwork.ozlabs.org/project/uboot/list/?series=487409&state=*

It is always hard to 'put the genie back in the bottle' once different
parts of the code base have diverged.

Would anyone like me to pursue this, or would it be best to drop it?

Regards,
Simon
