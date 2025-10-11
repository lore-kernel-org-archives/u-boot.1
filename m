Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A884CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 07:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D5183D8B;
	Sat, 11 Oct 2025 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XhLh5+vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3DD83C16; Sat, 11 Oct 2025 09:20:19 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B667F83C16
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-639fe77bb29so4096119a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760167216; x=1760772016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8qUv/a266xOzMI4LTOvIPmuiM50Lx54f+rb2V2yX9w=;
 b=XhLh5+vyfKw2n/3/k0wojtK7rTwitl2FDNWbX6bb6GyA2WVxfSYP03ZHwtw7sS7JdJ
 0p/F8reLOFgMD4QMNF+drJh+0g0TF39gMicaZbJRXJfetrw5+jCllbaw208/KKScCeI4
 V0AsGJF4Po/g96DcxO36sC4kx0yHWbKUi47UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167216; x=1760772016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8qUv/a266xOzMI4LTOvIPmuiM50Lx54f+rb2V2yX9w=;
 b=nTXItJbQq+SEj8zUw4cVZSPFr0vE5wxPIVH2dMxpCKSXNGVnH4s2nUnraE7Lp506Oj
 6SyyDhJChBgR1uu79WPEZaouSKeoMA398a+N/Now6/gLicgFOwNnAGFJLOA0Sij6eBZC
 xXthwZbBLjUIu8dApYTFTyvIwCO7abgSVJQDpYIXmfG1k7Lmc471fXGqzquz4G8WnhxQ
 S/qjnOGQ0LgQk6VIjN0yhC53CYJHnUsCOgukXRX1xXeohhBQ5EYheHQPs816/TY9B9pK
 IkylH3U1mTl/+u3Rsxmv/JO0dVsOVIpmAUOgI4MAnLWw93veVmInB/9XySCHNPelm7ii
 3LGQ==
X-Gm-Message-State: AOJu0YwVtytGpjwi3yLBzAZXQQv1+woGFvdsWNvD00d9i6r44UITdtdC
 OWavhXYRVqjXuxXE7LrRiUgck+utwLwmy4LAXoUoV6ve8lxCrv+GfEEZAiB8Z+Chzw1MazP6Q5v
 zRzJgsrDDf8jQyNwWMplN7C7noKQ6GHLhQOiuhgpe
X-Gm-Gg: ASbGnctAhtKUwHyd8B+eoeQSMVdjroM5ZBPqo8tEDSzVP8E4xrforDJDtO9REdD7TNP
 2XQ8WR2Q0Mkn8rENKRjvhcKW7G1VZTDle54ynI74sP3w5pIX5L3rAFLeSwEzbeDpHBrR+FkDVrx
 UpVPC8rUSpBv/4wtSdsySFdFAgXtIThFKFAoNlsPTmES12cOxQaBrg31zRfpFaZZTqoffGe12BG
 G5xGZEKJBr7OZfIVif2f2dpKaIK4fq6+Bfn
X-Google-Smtp-Source: AGHT+IF8HV2vMvRfP2rs4Lfzwn9U52HhQDE4lTNI0wBbtLnBgClj+N4+M1dejOfLL4IrdO3BbDEtZtTAu+rd+0FzVE4=
X-Received: by 2002:a05:6402:4406:b0:61c:35c0:87c6 with SMTP id
 4fb4d7f45d1cf-639d5b7f385mr12895005a12.12.1760167216211; Sat, 11 Oct 2025
 00:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-5-sjg@chromium.org>
 <20251009173522.GR298503@bill-the-cat>
 <CAFLszTisxbgD3WLLQNvfi5MO1Mhbk2V_cCEnMQSod=eE8Phijg@mail.gmail.com>
 <20251010143804.GA298503@bill-the-cat>
In-Reply-To: <20251010143804.GA298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Oct 2025 08:20:02 +0100
X-Gm-Features: AS18NWC443_-NGWAoetjWYunVyCJh33WOcZhgL1tQ1u9kSsc-st9X2gsJitDBjE
Message-ID: <CAFLszThogoq13ZrhnxkxTMQoXYPrwweriAKtDNbNKnskiAo+fA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] boot: Move preparing bootdev into a function
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
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

On Fri, 10 Oct 2025 at 15:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 10, 2025 at 11:36:20AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Oct 2025 at 18:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 09, 2025 at 03:29:55AM -0600, Simon Glass wrote:
> > >
> > > > The code at the end of iter_inc() is already somewhat tortuous. Before
> > > > making it worse, move it into a function.
> > >
> > > This is not a great commit message. Taking a look at v2 as a whole, the
> > > reason to extract this logic from the end of iter_inc is because you
> > > will be checking it in multiple places. That is a good reason to move
> > > the code. Adding another 5 lines of code (a single if test) alone would
> > > not be.
> >
> > OK, so how about:
> >
> > The code at the end of iter_inc() is already somewhat tortuous. A future
> > series needs to call it in from two places in iter_inc(), so move it
> > into a function.
>
> No, I dropped the "already somewhat tortuous" part on purpose, because
> it's just normal regular easy to understand code. It's on that threshold
> of indentation where you could break it out, or you could leave it, and
> be fine. The entire reason to split it out is because it will be called
> in multiple places.

OK, so how about:

We will want to use this same logic in another place within
iter_inc(), so split it out into its own function.

Otherwise, please suggest something.

Regards,
Simon
