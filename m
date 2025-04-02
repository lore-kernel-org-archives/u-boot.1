Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E68C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 23:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3092810E8;
	Thu,  3 Apr 2025 01:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZZAeYyu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A26181DE3; Thu,  3 Apr 2025 01:54:58 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2D18035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 01:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so50129566b.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743638095; x=1744242895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/dTrQKIiuAR3Ey4C2ZvN2zohdTulmlRrobiGMdbWgA=;
 b=ZZAeYyu1KThirq1Qs6RT4QflzmS8SJkHlBiipl3megOxoxInNmeSP2yi9fqRIozsxE
 R86PNzE0+KvOFPGvgir5jNafwIftVHuuN4/Z7h50JSrGZDAmBW54p1vvXUKJ4PADvo0r
 kPlfKCkItpt+UsfF9I0SddZzDBKwuxekidZ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743638095; x=1744242895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/dTrQKIiuAR3Ey4C2ZvN2zohdTulmlRrobiGMdbWgA=;
 b=h2HclT+XVRWrVMKKLLOVbTk/K+eOWcF9E1xDeiOmgKpb4R+/E+eHSp0Yj3fUx+rN+F
 IWj6K2f25U0H9KRgE6bFEjDsB/67buEZdyryeaGuwMbtpaBSocftHJSBp7EhfXBKOW/+
 iO8JLcNHM5gIGPmF+z4JdfPN3Vgg+OAvtZDT1oVXoyCc8k8O6cekr70e5R+XavkpEHO6
 nCDVS5ipIV9D172CfUqjsE8TA8Qh5eHbIg2A4eYJYoECpPHjuTeePbti8okQvM2asSEh
 sfcIEd7aSKixyBAbSTR2HDr90djoBAg8LEMjJA2IKST6l/Yg20ZGRhyESCLqBwV4UQEJ
 ja3A==
X-Gm-Message-State: AOJu0YxG6NMTyMPkb7ekGowpHIX8oyspdWg8HZne9ETXmhKkbN/ZILFY
 g5AtuFsBirhhfMG0ExOaurjTYE8w4EsKvsLPBSOlSr8O84rXDsnTtHfEeS6mxtObrAC0a6bp5DC
 g+iLPmz4nJnpodOR7+75UXrDcMZT6DFRHp9rQ
X-Gm-Gg: ASbGncudT9W9jnwRP2PjdtT9/q8+DjS1TOBFbPOyv5u/ZOjMRzeD6lALjDkbM1lbddt
 3JwM3oOv36jVgmdHSMHuBFYS3/I4aYeKAiSo0Zhv6Soc3T1AWUHbyN82DlMMDRtsSlHeQb0Ww5f
 jO6jw+7rjvBbpwS/KhStmIk+T6Bhv8
X-Google-Smtp-Source: AGHT+IHGqyCVl023NkZAD52R6hfj8S2cmP02xDkmvWmhiLaQPZymq7LsKQjEaM6mGOQVkhuC27kzHoK7aMiiz6KmGRE=
X-Received: by 2002:a17:907:1b10:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-ac738c23ea2mr1742607266b.50.1743638095436; Wed, 02 Apr 2025
 16:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
 <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
 <20250402195033.GB5495@bill-the-cat> <20250402195656.GC5495@bill-the-cat>
In-Reply-To: <20250402195656.GC5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 12:54:42 +1300
X-Gm-Features: AQ5f1JqrdYdkyoX3dHMzf9yn6ecqxGyd-AsP9s6vTv7_H27Am5OJ0S7hYvgy954
Message-ID: <CAFLszTjPi5=ro_4n8oF+ZX_OtzvKxWZvz=ipmXCnEhysVZb9-w@mail.gmail.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Thu, 3 Apr 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 01:50:33PM -0600, Tom Rini wrote:
> > On Thu, Apr 03, 2025 at 08:22:44AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > > > > Update the string to take account of UARTs which are connected on I/O
> > > > > ports, as on x86.
> > > > >
> > > > > Fix a typo in an error message in the same command, while we are here.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v3)
> > > > >
> > > > > Changes in v3:
> > > > > - Add new patch to support IO UARTs for earlycon and console
> > > > >
> > > > >  boot/bootflow.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > index 58a1afa7a75..4054a966af8 100644
> > > > > --- a/boot/bootflow.c
> > > > > +++ b/boot/bootflow.c
> > > > > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
> > > > >       *buf = '\0';
> > > > >       if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
> > > > >               snprintf(buf, sizeof(buf),
> > > > > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > > > > -                      info.baudrate);
> > > > > +                      "uart8250,%s,%#lx,%dn8",
> > > > > +                      info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
> > > > > +                      "mmio", info.addr, info.baudrate);
> > > > >       } else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
> > > > >               snprintf(buf, sizeof(buf),
> > > > >                        "pl011,mmio32,%#lx,%dn8", info.addr,
> > > >
> > > > I suppose we're well past the point where we can delete
> > > > bootflow_cmdline_auto() itself because that's just going to lead us to
> > > > trouble down the line (5 years from now when the kernel adopts a new
> > > > preferred way to pass this info) and grows every platform by some amount
> > > > of space every time we add something new here.
> > >
> > > Well firstly, why would you want to delete this command? It is very
> > > useful to be able to change the cmdline.
> > >
> > > This command is only available with BOOTSTD_FULL, which is less than
> > > 10% of boards.
> >
> > Because it's automatic non-obvious stuff. We should not be modifying the
> > command line at all. Is it even documented that we're doing this?

Yes, the command is documented. It only happens when you run the
command. Otherwise the command line is not modified.

As you know U-Boot has bootargs but that doesn't work with extlinux
and the like, so we have this command, which does.

>
> To be clearer, the more I review your changes, the more I see a blurred
> line that I do not this is good between "I found this handy while
> doing something" and "This is a good generic design / feature".
>
> That it can be annoying at times to add the debug uart information is
> not a new unique problem. It's something that's generally normally
> solved. I assume you hit this on x86 where it's more annoying than most.
> But a generic feature it should not have been.

I'm not even sure why you wrote this email, then.

U-Boot has all the information needed to set up the UART correctly and
it is extremely tedious to do otherwise. This is a bootloader, so it
needs to support kernel development. I actually think this is a really
cool feature.

At this point, I really would encourage you to look at what you are
trying to achieve with all these 'no' emails. Collected together they
create a substantial corpus of negativity. Why not just start saying
'yes' instead of 'no' for a while and see how things go?

Regards,
Simon
