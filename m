Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538FC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6322E82139;
	Thu,  3 Apr 2025 19:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2X6Bvtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507FB82139; Thu,  3 Apr 2025 19:58:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2098212F
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so1732954a12.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703081; x=1744307881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8hwWWPgLM0OAMohNEGUkc7M5FhXplSGCetqW9ES2g4=;
 b=A2X6BvtqhEEtxRg5bBY5zudH6tepH50qkBGWg7mJua6pPDCbzhQto7MpMh63mEPFtA
 mAFjfpBL0arsHDN9Vg7LMvfIiKLx6EY0OeiE0Nd5Gut96+VjQJn8ScBlAReKBuIZ7lGl
 HGNdd3YM/yFkUjRnwCaVGKwXm/63FS41aeqNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703081; x=1744307881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8hwWWPgLM0OAMohNEGUkc7M5FhXplSGCetqW9ES2g4=;
 b=DUSCVbCW7WjFhXOabgJ5U8oVUa/WcepyrnIAhSTFkLs2FSAsgmojP9ULGR/pliFgKs
 de9tyAyZRNf5DngC9SrUmFSaOwLn24ZK4aBp5dIgL8cgDwM++SZ2pbfHJcQK7O2rlbhZ
 GP5+N+WhVkZ7okou1yUj6nQelC9xcv8s3wQoeVP/4KFlV0Jnk6+x9j6hrmd6+86x2CM1
 IK2+pIBlq1TTyAFhIXLZBsBaoOxJvJGA7H35ExakCUjBwiA3eDGiX/caBL8LIkTj3oAc
 6z2I2Pfz/UzZetTnzJrvGl2UZTOM5tB8HvyPOaZ6gSScooqwF++o2iodq0bEdQGtdYp5
 74Ug==
X-Gm-Message-State: AOJu0YxdSbL0WyvwyuvnvrQ9BazEvqKIG9HM27WukrPm8ctcgkGrWysg
 npByRmhSJGpkeXv+v0inpshteZLHR8jR/sZOvE8+5ly+t8Xie7f5xXBWD8Z7q6GnLLpgX+bqvzp
 sweTWkNFLLR42e/lFrY6Kr/k8KuLgK9MzCozN
X-Gm-Gg: ASbGncvG1AAgJiXVYpgQwS0EB81JiTdKQGATSTwXDdc+GLm5I9k11aaEzEZPx5odv0L
 ma2UGdSer3dk17Q2ns7DuoC5pOjhgLxOa6RMTVOZ+hPAagQR9Zem9byj/ug1l9KD46HgXQLQDA3
 Cnp80JLsOVOfvED/ERxBoADepCk7MO
X-Google-Smtp-Source: AGHT+IGRXR1aUQaP3b7x+j5TxW9pP2u/A6gMR6l9X/hwqIXTbnXAn5zphiFHSAxPrpIkx/acdylBtdJf5Ocuw27b5rs=
X-Received: by 2002:a05:6402:42d2:b0:5e6:616f:42e4 with SMTP id
 4fb4d7f45d1cf-5f0b450128bmr70141a12.27.1743703080423; Thu, 03 Apr 2025
 10:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
 <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
 <20250402195033.GB5495@bill-the-cat> <20250402195656.GC5495@bill-the-cat>
 <CAFLszTjPi5=ro_4n8oF+ZX_OtzvKxWZvz=ipmXCnEhysVZb9-w@mail.gmail.com>
 <20250403002643.GG5495@bill-the-cat>
In-Reply-To: <20250403002643.GG5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:57:43 +1300
X-Gm-Features: AQ5f1JrEoM0F9rcjBCqoJmnylCaGNuZUnhals5oz6BCppAIlNYbmAqAVdJQ4i4M
Message-ID: <CAFLszTj-EKx+0sC9MJOsBuuS5hY9mZjt0PTAUR7cB=PCboLf6A@mail.gmail.com>
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

On Thu, 3 Apr 2025 at 13:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 03, 2025 at 12:54:42PM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 3 Apr 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 01:50:33PM -0600, Tom Rini wrote:
> > > > On Thu, Apr 03, 2025 at 08:22:44AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > > > > > > Update the string to take account of UARTs which are connected on I/O
> > > > > > > ports, as on x86.
> > > > > > >
> > > > > > > Fix a typo in an error message in the same command, while we are here.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v3)
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Add new patch to support IO UARTs for earlycon and console
> > > > > > >
> > > > > > >  boot/bootflow.c | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > > > index 58a1afa7a75..4054a966af8 100644
> > > > > > > --- a/boot/bootflow.c
> > > > > > > +++ b/boot/bootflow.c
> > > > > > > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
> > > > > > >       *buf = '\0';
> > > > > > >       if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
> > > > > > >               snprintf(buf, sizeof(buf),
> > > > > > > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > > > > > > -                      info.baudrate);
> > > > > > > +                      "uart8250,%s,%#lx,%dn8",
> > > > > > > +                      info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
> > > > > > > +                      "mmio", info.addr, info.baudrate);
> > > > > > >       } else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
> > > > > > >               snprintf(buf, sizeof(buf),
> > > > > > >                        "pl011,mmio32,%#lx,%dn8", info.addr,
> > > > > >
> > > > > > I suppose we're well past the point where we can delete
> > > > > > bootflow_cmdline_auto() itself because that's just going to lead us to
> > > > > > trouble down the line (5 years from now when the kernel adopts a new
> > > > > > preferred way to pass this info) and grows every platform by some amount
> > > > > > of space every time we add something new here.
> > > > >
> > > > > Well firstly, why would you want to delete this command? It is very
> > > > > useful to be able to change the cmdline.
> > > > >
> > > > > This command is only available with BOOTSTD_FULL, which is less than
> > > > > 10% of boards.
> > > >
> > > > Because it's automatic non-obvious stuff. We should not be modifying the
> > > > command line at all. Is it even documented that we're doing this?
> >
> > Yes, the command is documented. It only happens when you run the
> > command. Otherwise the command line is not modified.
> >
> > As you know U-Boot has bootargs but that doesn't work with extlinux
> > and the like, so we have this command, which does.
> >
> > >
> > > To be clearer, the more I review your changes, the more I see a blurred
> > > line that I do not this is good between "I found this handy while
> > > doing something" and "This is a good generic design / feature".
> > >
> > > That it can be annoying at times to add the debug uart information is
> > > not a new unique problem. It's something that's generally normally
> > > solved. I assume you hit this on x86 where it's more annoying than most.
> > > But a generic feature it should not have been.
> >
> > I'm not even sure why you wrote this email, then.
>
> Because this is another little thing I'm being flexible on and not
> naking, I just think it's wrong-headed. And you seem to think I'm never
> being flexible. So I started this by saying I'm not naking it, I just
> think it's wrong.
>
> > U-Boot has all the information needed to set up the UART correctly and
> > it is extremely tedious to do otherwise. This is a bootloader, so it
> > needs to support kernel development. I actually think this is a really
> > cool feature.
>
> It's "cool" until it breaks. And grows platforms for features they
> can't/won't support.

OK, well let's drop this discussion, since you are not naking it.

Regards,
Simon
