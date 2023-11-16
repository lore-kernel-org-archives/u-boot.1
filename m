Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C6EC072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36428724E;
	Thu, 16 Nov 2023 02:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fg6BKSBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C43D87251; Thu, 16 Nov 2023 02:56:53 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0D586EE5
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50a938dd873so422107e87.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700099811; x=1700704611; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UYPEGd8Tbn49T/sf2x6G9ncU0L7nA7Gm1cxdgzY2IFM=;
 b=fg6BKSBDos29wRagFCGYwMinaJwxTJvtq+EhrpJEEfdIRNXXHjH5r3lhRt+n+A765Z
 H0RgR8fuFzipDlSDZB6hBaW1TKOYHTyr73Vs/2jTGBDbuq1llpBkXsBEY+VfhsoBEoTZ
 U90AU3MPIslNcKlnyLItorC+8hLzYHswxBoPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700099811; x=1700704611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYPEGd8Tbn49T/sf2x6G9ncU0L7nA7Gm1cxdgzY2IFM=;
 b=lKk/mtbTR/RJdK7lhBMmLLvROqAnnmHWzv8k4kilWxW/YCogW4iWtBd75HCBMG3sSW
 8/sPjcLHbB07hYFZsg5RRKcxAaW/TPVdIUL/eKxJn6OgtsaR9S7EwHO0is/enGTH1Vg4
 YQwAsjJJyzv9TaBsbdybaCJpmHlSc/e523XoaR2/EeZ09OPGWCaBR40Uo+XBoCR3pJmL
 58IeQeBbHXz1X7Ap+/YY6WR/f9ufTfd4Lwmtq4rFpc5onNN1NUtetIKvtgGCAx1Q+SI9
 J/VxtDjxBlIPe0PwuGDy1w+efAhk19KoFF2ZHZMUgH4hiZfhPWie3mwE7EG71zy1Rm7K
 UKfQ==
X-Gm-Message-State: AOJu0Yz5sIDfpNTjUTr7e/RwcUoOPLYaEsrRk9EV68RoFqC0StKEACyj
 XjR3U+o7q+p5/F9QPgEwRxSx2qQjiYgUrPdDYUECydLZXPEa4Rjckls=
X-Google-Smtp-Source: AGHT+IHzz/Ut2ZlBkeILmTq61k/lTiRd+h82g9B0JfceTSr2XuxdZ+BdfKcRjooN2eyHDVpIsD9YQ26QfppH6Fac6qI=
X-Received: by 2002:a05:6512:3ca5:b0:509:8a47:3672 with SMTP id
 h37-20020a0565123ca500b005098a473672mr9864379lfv.34.1700099810367; Wed, 15
 Nov 2023 17:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
 <20231115223800.GE6601@bill-the-cat>
 <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
 <20231116014707.GI6601@bill-the-cat>
In-Reply-To: <20231116014707.GI6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:56:33 -0700
Message-ID: <CAPnjgZ1v+ciAZGKgkgF3M1tzTdpFEMLJfj-xVQMLWpdmgYPzAw@mail.gmail.com>
Subject: Re: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

On Wed, 15 Nov 2023 at 18:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 15, 2023 at 06:42:19PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 15 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:
> > >
> > > > Rather than passing it all the command-line args, pass in the pieces
> > > > that it needs. These are the image address, the ramdisk address/name
> > > > and the FDT address/name.
> > > >
> > > > Ultimately this will allow usage of this function without being called
> > > > from the command line.
> > >
> > > OK, so this goal is good.
> > >
> > > [snip]
> > > > +             return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
> > > > +                                      argc > 2 ? argv[2] : NULL, 0, 0);
> > >
> > > That we repeat this much harder to read test/if/else three times now is
> > > less good.  Can we find some way to hide the complexity here in the case
> > > where it's coming from a command and so we have argc/argv[] ?
> >
> > I can't really think of one. Ultimately this is coming from the fact
> > that the booti and bootz commands directly call bootm_find_images(). I
> > haven't got far enough to know whether that will still be true in the
> > end, but I hope not.
> >
> > IMO the correct place for the logic above is in the command-processing
> > code, where it decides which arg means what.
> >
> > I could imagine something like:
> >
> > static const char *cmd_get_arg(int argc, char *const argv[], int argnum)
> > {
> >    return argc > argnum ? argv[argnum] : NULL;
> > }
> >
> > but I'm not sure that is an improvement.
>
> I was thinking about this more after I sent this. And I think we might
> indeed want an inline / macro to handle this case more generally as I
> suspect we'll have similar cases where we need argN-or-NULL as we
> refactor other areas of code to split "here is the command" from "here
> is the library functionality" of it. Then we'll have:
> ulong foo = cmd_arg_one(argc, argv);
> ulong bar = cmd_arg_two(argc, argv);
>
> librarycall(foo, bar, ...);

OK I can try something. But note that the one, two terminology becomes
confusing. Is the first argument zero or one? Also we often drop an
argument in a subcommand to allow things to start from 0 again.

It might be better to use first and second, instead?

Regards,
Simon
