Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920ADC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 21:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92158819D;
	Sun, 23 Jun 2024 23:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pt/+swJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6AF882A5; Sun, 23 Jun 2024 23:52:27 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A8988137
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 23:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f95be3d4c4so1541682a34.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719179544; x=1719784344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9xI355us2m4zNUxKQgv3Ug9YyAuYfioMd9BoRz1pxUY=;
 b=Pt/+swJLQpNM6YryHW/8GuPGK2E59uT+5VBcZHidrx/Ge6AJi5pfxyObpJEQGDvzC3
 789bvozGlhSYH/f1XdmqpNdbM5y4c9+tmx5U/7tL3NVNzxkSJXhvMEjXTNTCKkxTZ7bu
 Hv/+ynsqNHxADXl2HTsWnAOXnvMPfyMHf8JMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719179544; x=1719784344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xI355us2m4zNUxKQgv3Ug9YyAuYfioMd9BoRz1pxUY=;
 b=T00LNjYJCNk1namh2A+YxkWzFEG6UTw4HivnDGOXEVz2f8E3oYhFImAX0I2z+K9Zdm
 //R6rSEkmB1401+jdaYM1sBsWYq5pnQPDe/HUDO60y3aGHOaweJNogXZcEjDw9R8Adeb
 Eq5HrIcn3RPqsfM7IMPaZI3R1IP/xNuFEaEKog0ygFQeiXFdx/L8+MptSmpT5xT15GX9
 7nyyNbYHxr/Ac022J1k+wDtGlIejC5ppWzTuh2nfPrr3JMaTAKjeMwOgDW/6KP5Xhhcr
 v9x5N6dqVOKFG7nhOwHdznws2y9XAhvPpg0XBLQ2SKStffHA7r0enCwXDqLvUtcp9kfl
 t/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/h8tEfh+dqIILOPQjysugkemgaUUlfcTy0nKcIV8K2xlhcvfUHjnHNsSf5NdtX824PQhuTss4UG9/7kxzOC8/Y6DDgg==
X-Gm-Message-State: AOJu0Yx8S8hxj+zAr6q5k/xhSXgpR3BI+CUOht4dSgRDQVmhtnMufPZD
 +SdI+lBXHk259KlA+p1LlysFYEXGLmFPTakZzRe8h5z890vIbdRMdcFzvN0nFrl0pETwzW2YMQD
 nr8QBfLw4Zi83uHNhJv6CGJ+/nQ6WOILQZXKk
X-Google-Smtp-Source: AGHT+IH3mKMzUo/4CTARNM0GjJUuSa7Ab/6BLvNurD6ErhrbkBygfDS7Rdvo6EPQetDvSfmLW3NcZDXyy2cBO34Jlmw=
X-Received: by 2002:a9d:4d18:0:b0:700:b24d:53d0 with SMTP id
 46e09a7af769-700b24d5540mr3111891a34.14.1719179543715; Sun, 23 Jun 2024
 14:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
 <20240621160514.GY68077@bill-the-cat>
 <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
 <20240621191915.GZ68077@bill-the-cat>
 <CAFLszTjdDSVsMPTU0OU09JrD0Njxb6NXmb_KKk4gUXC_JAgv8A@mail.gmail.com>
 <20240621221209.GD68077@bill-the-cat>
In-Reply-To: <20240621221209.GD68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 23 Jun 2024 15:52:12 -0600
Message-ID: <CAFLszTi8YoYuNf2-c5TeRDMYGERBVm-w6kTX_B5uUao147Zmuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
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

Hi Tom,

On Fri, 21 Jun 2024 at 16:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 21, 2024 at 01:38:07PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 21 Jun 2024 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 11:55:42AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 21 Jun 2024 at 10:05, Tom Rini <trini@konsulko.com> wrote:
> > > [snip]
> > > > > Yes, I very much do not like guessing about 3 numbers instead of
> > > > > guessing about 1 number and using the standard mechanism we already
> > > > > have. Please use BOARD_SIZE_LIMIT as this is the standard mechanism to
> > > > > enforce size limits on U-Boot itself.
> > > >
> > > > If it were that easy I would have sent a patch :-)
> > > >
> > > > Here is the map for this board:
> > > >
> > > > ImagePos    Offset      Size  Name
> > > > 00000000  00000000  00800000  rom
> > > > ff800000   ff800000  00001000  intel-descriptor
> > > > ff801000   ff801000  001ff000  intel-me
> > > > ffef0000   ffef0000  000999f0  u-boot-with-ucode-ptr
> > > > fff899f0   fff899f0  00005554  u-boot-dtb-with-ucode
> > > > fff8ef50   fff8ef50  00000000  u-boot-ucode
> > > > fff8ef50   fff8ef50  00000571  fdtmap
> > > > fff90000   fff90000  00010000  intel-vga
> > > > fffa0000   fffa0000  0002fc94  intel-mrc
> > > > fffcfc94   fffcfc94  00000000  private-files
> > > > fffff800   fffff800  00000070  x86-start16
> > > > fffffff0   fffffff0  00000005  x86-reset16
> > > > fffffff8   fffffff8  00000008  image-header
> > > >
> > > > What limit should I set on what?
> > >
> > > Is this a trick question?
> > > $ printf %d\\n $(( 0xfff90000 - 0xffef0000))
> > > 655360
> > >
> > > Of course since we're less than that today, you can reduce it by
> > > whatever other magic numbers I'm not seeing but are part of your assumed
> > > sizes.
> >
> > That limit is on u-boot-nodtb.bin. Even with a size (for that file) of
> > 634816 it doesn't fit. I need to calculate a size based on the size of
> > the dtb and the microcode...which of course can change.
>
> Yes, and you're able to assume some size for them, which is what you
> put in the dts file?

I just put in a limit for the blobs, whose sizes are known.

>
> > > > - the U-Boot is the thing you are wanting to limit
> > > > - the dtb has microcode added
> > > > - the ucode is empty in this case
> > > > - the fdtmap is variable in size
> > > >
> > > > So this all seems a bit backwards. The actual limit is that
> > > > (u-boot-with-ucode-ptr + u-boot-dtb-with-ucode + u-boot-ucode +
> > > > fdtmap) fits in the space available. Note that some boards don't have
> > > > intel-vga or intel-mrc.
> > > >
> > > > With the other patch I sent I can have a sensible limit for all x86 boards.
> >
> > Did you miss the comments above?
>
> No, I saw them. They're similar constraints to other systems.
> >
> > >
> > > And you can set the same sensible limit with the existing mechanism with
> > > the bonus of it not making x86 different from the rest?
> >
> > I understand that it is possible to set a limit for u-boot-nodtb.bin
> > but that is not accurate nor sufficient in the presence of blobs. The
> > solution belongs in Binman.
>
> Your series puts reasonable estimates on the size of the blobs and then
> will give a failure such as:
> binman: Node '/binman/rom/intel-vga': Offset 0xfff90000 (4294508544)
> overlaps with previous entry '/binman/rom/fdtmap' ending at 0xfff902e1
> (4294509281)
> Which is not as nice as (I just threw in a limit):
> u-boot-nodtb.bin exceeds file size limit:
>   limit:  0x927c0 bytes
>   actual: 0x9a810 bytes
>   excess: 0x8050 bytes
> make[1]: *** [/home/trini/work/u-boot/u-boot/Makefile:1359: u-boot-nodtb.bin] Error 1
>
> And tells us how much we need to get back size wise. Aside from when
> using the actual blobs (and in which case a real error will be shown
> when trying to use them), it's always about making an estimate on the
> part of the system that we control.

Thanks for digging into this.

I wasn't aware that the limit was just an estimate. Since it produces
a build error it seems to be enforced as a hard requirement. But I can
set a limit and we'll see how things go.

I still like the binman block-size thing though. The error message
binman provides actually tells you what to do (reduce the space of the
things that are overflowing into intel-vga). So I'd like to add that
too.

Regards,
Simon
