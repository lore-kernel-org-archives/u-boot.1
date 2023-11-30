Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F9C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 03:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C767186EF6;
	Thu, 30 Nov 2023 04:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L1D5qLs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0951186D34; Thu, 30 Nov 2023 04:04:12 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC2487076
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 04:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5cc642e4c69so5114947b3.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701313446; x=1701918246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1tuDkSkgVfV3q6tQCYzA2xuGGi8Ty1sy+Qrj0rDlAIo=;
 b=L1D5qLs0/dZbSy5CIv9jkzmanDoMqCO6eFrSR3SrmFS6QVzHedVQRsZt+VKnobJLIT
 4qXyW1XfKrSjHF9+oQVpZwqqHGHSK/0MpNzGy6+zLSs4RqbZutIgJI9YJncrbo9slPzK
 /Ib5I7oeSxZyoP/clIjcVAVAu4kyUzqG60yVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701313446; x=1701918246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tuDkSkgVfV3q6tQCYzA2xuGGi8Ty1sy+Qrj0rDlAIo=;
 b=H2jH7qviNxqOUR7BQnS0H/Vt87FViXi1TT4ztUt/qYXvx52udK7YU63ccSMQi/Fpl3
 NX/yq6U2ie8CgiLn/wmPqbMIqTxmIyKu1o/NLHOy/oI0H8utWq206vTKXgcCkvVGxxi0
 9OpTz4yImrA3GHAtnDG2Kc3bvsn/01j2etnoXByPy78PUcVne9z2Txr05E4/aTxRfv2A
 zd5r+7vzvNKBBtNAczqn/Z7dNTBVl2tdqri0+v6p7TZ0fjJc3bMb01CJAOPvUTz/tIyn
 p/N2NgDWW0PLWLKZapbAdQoQcvBBaDbnZadhSbPxzPLmT9U5d0BiNkd7jIZw3zAQtAOu
 MYdA==
X-Gm-Message-State: AOJu0YxlvAJNWSH8RT6hpeSMvsk7DVyC+JK6QAuT4ylzcgI/4GX03A/L
 Tg1vPumMPH/YzsARXYsldA/h1Pc0wFthnLBlSj2juA==
X-Google-Smtp-Source: AGHT+IEy397wcx8U2HOmqst8LWvcuzh7/vbIU9eQbcbE6Me6fNhoN4arlzEuCyAr3Av6ShiXopBWEkwD7eqhnmaD4oQ=
X-Received: by 2002:a81:7c83:0:b0:5ca:9ca4:f412 with SMTP id
 x125-20020a817c83000000b005ca9ca4f412mr17134113ywc.43.1701313446134; Wed, 29
 Nov 2023 19:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20231121183510.6451-1-clamor95@gmail.com>
 <20231121183510.6451-5-clamor95@gmail.com>
 <CAPnjgZ14yKRz06=j5+_e7XE2G82PWRb2QijkYsCPXkpqSFtbaQ@mail.gmail.com>
 <e824f58c-499c-4f2f-9742-9e28f1e8bfc7@gmx.de>
In-Reply-To: <e824f58c-499c-4f2f-9742-9e28f1e8bfc7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 20:03:54 -0700
Message-ID: <CAPnjgZ2edghFowOt018oO73-0p9LE_ktOLKK=ukvfb1oZJkBDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] lib: membuff: fix readline not returning line in
 case of overflow
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>,
 Harald Seiler <hws@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi,

On Tue, 21 Nov 2023 at 21:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/21/23 19:40, Simon Glass wrote:
> > Hi Svyatoslav,
> >
> > On Tue, 21 Nov 2023 at 11:35, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> >>
> >> From: Ion Agorria <ion@agorria.com>
> >>
> >> If line overflows readline it will not be returned, fix this behavior,
> >> make it optional and documented properly.
> >>
> >> Signed-off-by: Ion Agorria <ion@agorria.com>
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> ---
> >>   boot/bootmeth_extlinux.c | 2 +-
> >>   common/console.c         | 2 +-
> >>   include/membuff.h        | 5 +++--
> >>   lib/membuff.c            | 4 ++--
> >>   4 files changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> >> index aa2a4591eb..ae0ad1d53e 100644
> >> --- a/boot/bootmeth_extlinux.c
> >> +++ b/boot/bootmeth_extlinux.c
> >> @@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
> >>          log_debug("parsing bflow file size %x\n", bflow->size);
> >>          membuff_init(&mb, bflow->buf, bflow->size);
> >>          membuff_putraw(&mb, bflow->size, true, &data);
> >> -       while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' '), len) {
> >> +       while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
> >>                  char *tok, *p = line;
> >>
> >>                  tok = strsep(&p, " ");
> >> diff --git a/common/console.c b/common/console.c
> >> index 8a869b137e..cd56035171 100644
> >> --- a/common/console.c
> >> +++ b/common/console.c
> >> @@ -846,7 +846,7 @@ bool console_record_overflow(void)
> >>   int console_record_readline(char *str, int maxlen)
> >>   {
> >>          return membuff_readline((struct membuff *)&gd->console_out, str,
> >> -                               maxlen, '\0');
> >> +                               maxlen, '\0', false);
> >>   }
> >>
> >>   int console_record_avail(void)
> >> diff --git a/include/membuff.h b/include/membuff.h
> >> index 21051b0c54..4eba626ce1 100644
> >> --- a/include/membuff.h
> >> +++ b/include/membuff.h
> >> @@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
> >>    * @mb: membuff to adjust
> >>    * @str: Place to put the line
> >>    * @maxlen: Maximum line length (excluding terminator)
> >> + * @must_fit: If true then str is empty if line doesn't fit
> >>    * Return: number of bytes read (including terminator) if a line has been
> >> - *        read, 0 if nothing was there
> >> + *        read, 0 if nothing was there or line didn't fit when must_fit is set
> >>    */
> >> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch);
> >> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
> >>
> >>   /**
> >>    * membuff_extend_by() - expand a membuff
> >> diff --git a/lib/membuff.c b/lib/membuff.c
> >> index 36dc43a523..964e504d5b 100644
> >> --- a/lib/membuff.c
> >> +++ b/lib/membuff.c
> >> @@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
> >>                          (mb->end - mb->start) - 1 - membuff_avail(mb);
> >>   }
> >>
> >> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
> >> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
> >
> > Shouldn't that be the normal case? I might have this wrong, but this
> > looks like a bug fix to me.
>
> For the extlinux.conf case assuming that the file has ended if a line is
> truncated seems to be the wrong thing to do.
>
> Currently we return a value <= maxlen - 1 if no truncation has occurred
> and 0 if a truncation occurred.
>
> I would prefer if the function would return maxlen in the case of
> truncation and the truncated string. This will allow us to detect
> truncation without mistaking it for the end of the buffer.

OK I have taken a harder look at this now.

Wouldn't that indicate that the string was exactly the maximum length?

Also, what happens to the chars after that on the same line?

What is actually going wrong that is leading to the need for this
patch? How can it be correct to parse just some of the line and leave
the rest for later?

I think this needs a harder look, but I don't have enough info to help here.

>
> Best regards
>
> Heinrich
>
> >>   {
> >>          int len;  /* number of bytes read (!= string length) */
> >>          char *s, *end;
> >> @@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
> >>          }
> >>
> >>          /* couldn't get the whole string */
> >> -       if (!ok) {
> >> +       if (!ok && must_fit) {
> >>                  if (maxlen)
> >>                          *orig = '\0';
> >>                  return 0;
> >> --
> >> 2.40.1
> >>
>

Regards,
Simon
