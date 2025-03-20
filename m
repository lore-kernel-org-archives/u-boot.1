Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA1C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297A980FF0;
	Thu, 20 Mar 2025 04:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kxQ/X7er";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8CA819B1; Thu, 20 Mar 2025 04:43:47 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159B38083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e686d39ba2so715207a12.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442223; x=1743047023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4CUzQ19Hf8JqFQbPExE08614y3HDVgf+IOFEOSuzp9c=;
 b=kxQ/X7erPpL5WjatVhnZs1SQMGT7hB1jwmodUnG+XaSsou1ExcaOkk207+p1DNBoi+
 nUUvsrMVWZSqLPAT9tCm5/fS3Kq9p8rGjjvxMq+7PmCH7/JH8WiRf1b8aivuwIpC2nor
 OP/njMTtouwRq35nVSefoX+w2bB94BW7BAc7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442223; x=1743047023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CUzQ19Hf8JqFQbPExE08614y3HDVgf+IOFEOSuzp9c=;
 b=selwS9JCK3/RoNLJHsJU2GysyOzZl1AWTJ0GRZ4MtrZPYDHSGsr0np2P8B5+9tuq/d
 tj1d49FY/Q5xO8N49RkQMfKLmV/P3iwFrLUtZe6pybRv4QjG6jlGJ3pO7Ak9BrgOnUmF
 EkgaDdALYhcwEw3EhwSq/IGfojeGxqt+WiEoq4M51Rfb9nyqCV+HkWcmaqQe0Bhtx6Sc
 kWUJHFvaHeu4MvQhMJWyXWCBxt/aXD5zbhsBO6jFjN3IhwS7oREsb1oGQ5K7TiVk1veF
 11Yax2J2G+ib7qvfTzfipD827vgZB3uiagRmqp/B6VpaEEhdC7qBp5nhtBFyrrJ5bnqv
 uvVw==
X-Gm-Message-State: AOJu0YzZ9326oCFCnShEBBdiKrda164NxxQ8+6Yz5l9qvFE+Une6kxQb
 gnr2LokRensPb83TGMyZKaObCcKpyeBJV6dI55zELYxVvS8SjIYJvVLgrC7AS1LXnljxXkd036S
 DtYcEy5BuSlCbt3zUy++Tu/E0y2Cd1xfGQd0e+VYHejiE4tQ=
X-Gm-Gg: ASbGnctHB59mUAbuzYjiBNpn0bhFyaLttnkDL/fTQf0NuA38oua5sJheA5Rf6TBsm9M
 oSY3xo1fx0wQRQdI+Hj2STeKpOflklwiuHpTX9Ln2V8IuM+RKpnkU5aFXZGDX9Ubi7ZtEP1wvBh
 bYcSnf29d+02mnADnvgmD97JxW4tI=
X-Google-Smtp-Source: AGHT+IFA9o7RZel4s1109P0S/gw7GgVUoUr64TtzWffr1X6j6aYPZGpP5YzbszKwFL4TvnpgZ2UM1WVejEFy6ggRNcQ=
X-Received: by 2002:a17:907:728d:b0:ac3:25d7:6950 with SMTP id
 a640c23a62f3a-ac3b7d9417emr559186766b.20.1742442223447; Wed, 19 Mar 2025
 20:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
 <20250319142438.GF2640854@bill-the-cat>
 <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
 <20250319153847.GL2640854@bill-the-cat>
In-Reply-To: <20250319153847.GL2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:43:30 +0000
X-Gm-Features: AQ5f1JpJsiT8zEnLPaje-NJPrUB2Mxpi4PpX52rzc-VisFKl9H0joxJmsOBBFYs
Message-ID: <CAFLszTgZV8A9HcmS=3nHdz2M_+eGLdX9qnEnYzJAEJ_QgoWSxg@mail.gmail.com>
Subject: Re: [PATCH 3/6] test: Add a test for strim()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 19 Mar 2025 at 16:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:04:16PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:
> > >
> > > > This function trims whitespace from the start and end of a string. Add a
> > > > test for it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > >
> > > This got me to ask "What even is using strim and where did it come
> > > from?". To which the answer is:
> > > - A few places, but it's probably reasonable.
> > > - Linux, pre-2011.
> > >
> > > I say the latter because we're missing a bug fix to the strim function
> > > that's been there since 2011:
> > >
> > > commit 66f6958e69d8055277356d3cc2e7a1d734db1755
> > > Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > Date:   Mon Oct 31 17:12:37 2011 -0700
> > >
> > >     lib/string.c: fix strim() semantics for strings that have only blanks
> > >
> > >     Commit 84c95c9acf0 ("string: on strstrip(), first remove leading spaces
> > >     before running over str") improved  the performance of the strim()
> > >     function.
> > >
> > >     Unfortunately this changed the semantics of strim() and broke my code.
> > >     Before the patch it was possible to use strim() without using the return
> > >     value for removing trailing spaces from strings that had either only
> > >     blanks or only trailing blanks.
> > >
> > >     Now this does not work any longer for strings that *only* have blanks.
> > >
> > >     Before patch: "   " -> ""    (empty string)
> > >     After patch:  "   " -> "   " (no change)
> > >
> > >     I think we should remove your patch to restore the old behavior.
> > >
> > >     The description (lib/string.c):
> > >
> > >      * Note that the first trailing whitespace is replaced with a %NUL-terminator
> > >
> > >     => The first trailing whitespace of a string that only has whitespace
> > >        characters is the first whitespace
> > >
> > >     The patch restores the old strim() semantics.
> > >
> > >     Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > >     Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
> > >     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > >     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > >
> > > --
> > > Tom
> >
> > Here is the comment for the function, of note given Linux's disdain
> > for commenting code:
> >
> > /**
> >  * strim - Removes leading and trailing whitespace from @s.
> >  * @s: The string to be stripped.
> >  *
> >  * Note that the first trailing whitespace is replaced with a %NUL-terminator
> >  * in the given string @s. Returns a pointer to the first non-whitespace
> >  * character in @s.
> >  */
> >
> > Given that comment, I don't see a bug here. But of course we could add
> > a test for it and adjust the function too. PLMK.
>
> Did your test add a testcase for the situation described above?

No. I didn't know about that case. The function comment does not
suggest that it handles a whitespace-only string in that way. In fact,
even the Linux commit which changes the behaviour doesn't update the
comment to mention that behaviour.

Anyway, let me know what you'd like to do.

Regards,
Simon
