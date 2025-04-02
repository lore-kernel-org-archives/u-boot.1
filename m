Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A85C3601B
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BB381F6B;
	Wed,  2 Apr 2025 21:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g4SDHNkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6176B820B7; Wed,  2 Apr 2025 21:23:08 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8776B81FC6
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so22173266b.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621784; x=1744226584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5z/Y4J3XH/vD6zQKp4nDvroityeg1/zm0nbU76F2h6o=;
 b=g4SDHNkKnR1qhmDfmmFljkej21ePjiVG77ji05znAsCO+cpWrxZDGxi5PlX6cp6l3n
 dY2WAurxabCOFTPvv6WBne9GXdP25rUHLqX71ZUgtm0mNTi0iuQR1GnoLqTcnoVwL8hy
 oYD2nP/503y9DQCBOwHRETFcwtSuHvF8D8PZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621784; x=1744226584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5z/Y4J3XH/vD6zQKp4nDvroityeg1/zm0nbU76F2h6o=;
 b=VvGeyMQxgHPCdJ/nI9yfTFgTDLXErFl8EzCR6y4YUflOzme5pLH70miqCI73hS6G4V
 NX3tmwZpjPELavwBKfgaOhz2g1+K69GQyLvqpT1eQLWqJxrMlVZ2SPNgWxUuhiAicldQ
 YRfUknetDDKeuKQtJ/BfIyCmMu9WMizLXzWS4HQSx02KVL7UEbJ3ALaIty4+GM7peYh2
 z+mag2MTDNWpNIyc65o7qAkay9R5Jc6Mrm3DlGfQwIewNY2I1M4dEd025JBViYaTbKVO
 EEe+ehjN2RLM52LNpp9WOOoTfkSjqqT2ewLK2lGrNU7qTQ8wSbUmn1qco61g+ZXX+OaF
 H+3w==
X-Gm-Message-State: AOJu0YwFq1ektE83Tg4bIi5zcaPJkJ8MsmVkydYrxKa7mn24Lt//17FA
 F1u4HwmMCoLXjxDu+zG4fdZ8O2wgKGHiGgS2l8CUzWQIde9Pe79OpGCJn08Z+umU3nAX8cqT7ut
 6cLj3gSWC5P4AYc4qSUMs1SzJvHtZK3vp2c6IznLMfmyGgWHQWQ==
X-Gm-Gg: ASbGnctg7z66W1XUaD7LjtjJSTsd2bLyHvxJcZ6Ztbf7nqvSowbgrTasX1bveeC3Vpj
 RGHlc4NSo2uOU0Sfv0KurnaD3ZATNRPMbZEjDRD3eN0lbmQkGD4LD9sRSzCJw7D3Ra5i9q6Wd+3
 e4uIJes5pm6FfclC4ZQhzrOMx9ykwC
X-Google-Smtp-Source: AGHT+IEI6m7RTjV2cLX6ysqhtp+PwvpwSufTRyP2Rn+TNuHcypCU/wOpxve9bObjPgSefjn0s1m2kq19u5sKliq+NgM=
X-Received: by 2002:a17:907:2d07:b0:ac3:ed4c:6a17 with SMTP id
 a640c23a62f3a-ac738a36df5mr1411959566b.24.1743621783731; Wed, 02 Apr 2025
 12:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
 <20250319142438.GF2640854@bill-the-cat>
 <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
 <20250319153847.GL2640854@bill-the-cat>
 <CAFLszTgZV8A9HcmS=3nHdz2M_+eGLdX9qnEnYzJAEJ_QgoWSxg@mail.gmail.com>
 <20250320141518.GO2640854@bill-the-cat>
In-Reply-To: <20250320141518.GO2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:49 +1300
X-Gm-Features: AQ5f1JpMH9CSJlxZx4Kvn7BpT-0kK5mN99vyvF8m0aASLnUXNoWHTG4xUP4rTHM
Message-ID: <CAFLszTifMyUG-xbCg4jRwRtPRNnvPd-PDrwudsb2iK9RBPYj5g@mail.gmail.com>
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

On Fri, 21 Mar 2025 at 03:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 20, 2025 at 03:43:30AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 16:38, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:04:16PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 19 Mar 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:
> > > > >
> > > > > > This function trims whitespace from the start and end of a string. Add a
> > > > > > test for it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 31 insertions(+)
> > > > >
> > > > > This got me to ask "What even is using strim and where did it come
> > > > > from?". To which the answer is:
> > > > > - A few places, but it's probably reasonable.
> > > > > - Linux, pre-2011.
> > > > >
> > > > > I say the latter because we're missing a bug fix to the strim function
> > > > > that's been there since 2011:
> > > > >
> > > > > commit 66f6958e69d8055277356d3cc2e7a1d734db1755
> > > > > Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > > > Date:   Mon Oct 31 17:12:37 2011 -0700
> > > > >
> > > > >     lib/string.c: fix strim() semantics for strings that have only blanks
> > > > >
> > > > >     Commit 84c95c9acf0 ("string: on strstrip(), first remove leading spaces
> > > > >     before running over str") improved  the performance of the strim()
> > > > >     function.
> > > > >
> > > > >     Unfortunately this changed the semantics of strim() and broke my code.
> > > > >     Before the patch it was possible to use strim() without using the return
> > > > >     value for removing trailing spaces from strings that had either only
> > > > >     blanks or only trailing blanks.
> > > > >
> > > > >     Now this does not work any longer for strings that *only* have blanks.
> > > > >
> > > > >     Before patch: "   " -> ""    (empty string)
> > > > >     After patch:  "   " -> "   " (no change)
> > > > >
> > > > >     I think we should remove your patch to restore the old behavior.
> > > > >
> > > > >     The description (lib/string.c):
> > > > >
> > > > >      * Note that the first trailing whitespace is replaced with a %NUL-terminator
> > > > >
> > > > >     => The first trailing whitespace of a string that only has whitespace
> > > > >        characters is the first whitespace
> > > > >
> > > > >     The patch restores the old strim() semantics.
> > > > >
> > > > >     Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > > >     Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
> > > > >     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > >     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > Here is the comment for the function, of note given Linux's disdain
> > > > for commenting code:
> > > >
> > > > /**
> > > >  * strim - Removes leading and trailing whitespace from @s.
> > > >  * @s: The string to be stripped.
> > > >  *
> > > >  * Note that the first trailing whitespace is replaced with a %NUL-terminator
> > > >  * in the given string @s. Returns a pointer to the first non-whitespace
> > > >  * character in @s.
> > > >  */
> > > >
> > > > Given that comment, I don't see a bug here. But of course we could add
> > > > a test for it and adjust the function too. PLMK.
> > >
> > > Did your test add a testcase for the situation described above?
> >
> > No. I didn't know about that case. The function comment does not
> > suggest that it handles a whitespace-only string in that way. In fact,
> > even the Linux commit which changes the behaviour doesn't update the
> > comment to mention that behaviour.
> >
> > Anyway, let me know what you'd like to do.
>
> Well, being a function we borrow from the linux kernel, we should follow
> how it works and backport the trivial change to match how it behaves,
> then add tests in 2/2.

OK.

Regards,
Simon
