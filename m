Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576C6FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F81784673;
	Mon,  4 May 2026 14:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PMyMb287";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F5284673; Mon,  4 May 2026 14:16:46 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FFF484663
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso1749420b3a.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897002; cv=none;
 d=google.com; s=arc-20240605;
 b=dxC2sqQ5elt+pZ+LzAeJWnFEHKU9lpIA51UsESyjBbfvOXtZxZmNhvLBuZQRMNEtgE
 Kaz5aLtnub8Rp5J2z7Mm43/RRGAkuIt0TJShAWvJk1TYvZGuEWdtC+zhs5mLcGdQNmti
 cJ33yaCQSAeninvUUEJWgG3GfIGzIHMz42oigJTx21qZ6ITmNaeKo5bwjDPGfkwaat43
 1Q+6o31BXeoV+1lrc9vWDinvyBYDa5ZbEDae4lwcHJE9ZfDqP68KO1fTfUdMDaBMOsee
 OEIKG51oCFak4rfM878jtrIlxpIGTRntm7jAh/Up94u7rL/eNI+AMn1k7aidkVNu910r
 kl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qUve8GeSVgIzrF1mwLQJ7ctb6wXkdzjw6Z+W1w05Oao=;
 fh=51sHaI3B98u7y1AgT4RjsCwcRy6oCoxLvFWnfuUOOFM=;
 b=FaQ11YvuarkGDauhxqoVGCH7Tp+kPa5S+wXkzSZ6JkRM2GGnfddXHAk+jJDWDWEd9D
 e/WXZ86+OuX2/0+rs4JMpU2PPs5JRoxShg9ItXfXl17nv4c0eFnWUJ1EQrPIoqLpKXYP
 XW8js6hXC5QnGvBiH+d47layrjh0fQkkBbuF6U+vnF9Og3oMoYlAj6k2cSszmUPGpp71
 Olp9k1stzd0Wxi/pZDr+Hknwu0hRkmBYSxYLons24u2WdJ4CneWBnT1+qdIp7AobD826
 wSV+PrGZLd2Dq0gmkTgwLPSXbav6jzZNc66MTzqNKCvv028MW/MbYnQFb5KkTBj08CJ7
 8tqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897002; x=1778501802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qUve8GeSVgIzrF1mwLQJ7ctb6wXkdzjw6Z+W1w05Oao=;
 b=PMyMb2878cCeA3Sn/DYgrl/8TSeOwSVK9K+nP1jNE6foAREMYUfRk0Hu9v7+b1CcIj
 NLROIUZM0b6igmsGvgh5rThOlLtEkpuk/bC+1B2Obt09Z6um16+beM4q3RFlPy4oPRH5
 RqVKRbytN5P6lD8M+QNE0UKVKWKMZ7PYKGgKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897002; x=1778501802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUve8GeSVgIzrF1mwLQJ7ctb6wXkdzjw6Z+W1w05Oao=;
 b=jDWK0S76jJsNqpgh5GAlYF1ZuOQ71xg2jvUibfo0WCx4y50HZD55r0eAb+DW5Rpuq4
 POvH9e3LkKtAy8c8RuzuuPdsT0pGsLERaivBR+bfOsS4W9ad7kXvGNweT10ULJv+E91D
 yWkQQ6sHoMymsr/bxMZWe6gpun5yMj8W4gG2oSRHKpkDazhvWsKmOxAHO8uEiFsu92Zt
 wK40qcdcjIytRR53NL9dgjFB6fioioXmtK7axDcRPoX7ghGF9USqG003pFA0TGJwcV8A
 R7PKKQVeVJMIJAp/CNseE3YIGvrgvh+jVZzE48pVMgDtjGEB+e8ZaxS0OJtirnSozdFV
 2M8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+l/KrOuAArZtpOQeTIp2rLjK80jAkc0bQTKeFoRu1doiz1RPRg8pCoiG/Nu3sbddJQNgCTVRY=@lists.denx.de
X-Gm-Message-State: AOJu0YyjfMcP3R8MzwY69ai5LYsrBlfxexMuqXlAyHsxgk8nCZJx6FFh
 ZD9CNXQtQUilsrY/QpP3wPQi+6lhuMBDYrzDD7kN3DTE7bHZIo9OCtGHv9aLRsfZYG9Z/4AyaRS
 oVs60gIzpHhIm/eH4zNsjhbDFU6kTHyTMpOZ2uatj
X-Gm-Gg: AeBDievNJ9ZEYzvTXgQw9JotfpuLUreic+GX1ZTtl3mJhio60RDpCrBnhz/L8zC7rt1
 FHjwOrtgkjaCvTFoEZ88yIINcy5JteSILzczaJv4IPswuXprny/cKJu/qXsx65zoi6Kn/GNIAQ+
 e3jDZvpx9Mc0w3bgHcUEiortpCPSCePv9SDqn+JdeMxHwNJCznnSjQQuG6/UM2G92tBPW6HQXBD
 cINOXYMuo66gU2kUunjrfMzC6AvqtMjDWOZtD0VaKTUj4fXig00kDQ5e8j1vV1+DlwrMFLjnxRr
 KJwANcysgTfuBVsr
X-Received: by 2002:a05:6a21:3282:b0:39b:ae5c:164d with SMTP id
 adf61e73a8af0-3a7f1ad06edmr8949368637.4.1777897002472; Mon, 04 May 2026
 05:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb> <20260402233029.GI41863@bill-the-cat>
 <ac-ADDwtwS-xuFTE@livingston.pivistrello.it> <87v7e0o624.fsf@prevas.dk>
 <20260504045636.GA5660@francesco-nb>
In-Reply-To: <20260504045636.GA5660@francesco-nb>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:28 -0600
X-Gm-Features: AVHnY4Ke1LhlVkJ77BZyejTYzhaP4i9optVmy73SKxv6apSEh96SVzqBpOb2Yi0
Message-ID: <CAFLszTjVD0Cw_cFdvEkcUd3_+A2GLng8hQD81e4R=Gwrfmzksw@mail.gmail.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>, 
 Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
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

On Sun, 3 May 2026 at 22:56, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> +Simon
>
> Hello Tom,
>
> On Thu, Apr 09, 2026 at 11:07:31AM +0200, Rasmus Villemoes wrote:
> > On Fri, Apr 03 2026, Francesco Dolcini <francesco@dolcini.it> wrote:
> > > On Thu, Apr 02, 2026 at 05:30:29PM -0600, Tom Rini wrote:
> > >> On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
> > >> > On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> > >> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > >> > >
> > >> > > With correct POSIX handling, unquoted empty variables can turn the
> > >> > > expression like
> > >> > >        test -n ${fdtfile}
> > >> > > into
> > >> > >        test -n
> > >> > >
> > >> > > The POSIX handling for single argument `test` evaluates it as true,
> > >> > > so the fallback initialization will be skipped unexpectedly.
> > >> > > Quoting variable expansions in `test` expressions will always result in
> > >> > > correct behavior for empty and non-empty values.
> > >> > > This change was triggered by
> > >> > > commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> > >> > > The aim is to have a less fragile codebase that is not dependent on a
> > >> > > quirk of the shell implementation.
> > >> > >
> > >> > > Use quoted variable expansions in `test` expressions throughout.
> > >> > >
> > >> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > >> >
> > >> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >>
> > >> I've decided to go with:
> > >> https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.401876-1-ravi@prevas.dk/
> > >> to make sure that everyone that might hit this problem doesn't end up
> > >> broken, thanks.
> > >
> > > I am wondering if you should apply this in any case. This change is generally correct.
> >
> > I agree. And note that this really isn't anything to do with the 'test'
> > command per se, it's simply that using any variable whose value can be
> > empty or contain spaces is prone to produce something other than exactly
> > 1 word, exactly as in userspace shell, and once the shell has done its
> > parsing and word splitting, the called command really has no way of
> > knowing that there's an empty argument missing.
>
> Tom? I think this should be applied, see also the related change from
> Simon.

Ah, I didn't see this one.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
