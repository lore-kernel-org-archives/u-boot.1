Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FFEC282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C5380F96;
	Tue,  4 Mar 2025 16:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jL5vjObl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF0F81253; Tue,  4 Mar 2025 16:35:25 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37F1808A2
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac0b6e8d96cso327259566b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102522; x=1741707322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sFY0tygyfn/VrqHjlij4+J9ggEQ55H53Ysx0eKW/Iu4=;
 b=jL5vjOblv4ooCOE5VJVfjeIlf9sy/rFxl6j5O2Ah0EbXaX3Qe4tgzAj78MUW8+qG/v
 g86N6gZHTv9X0fYd6xSZHp0nqY2K3Z+K6FvYo/EclkuEYrNOtzA4KZlZAQkINrSebSsD
 FyBjkJrWC5BGzoVe1yyDzdjSyBP0RBnz40z/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102522; x=1741707322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFY0tygyfn/VrqHjlij4+J9ggEQ55H53Ysx0eKW/Iu4=;
 b=C9svoHmnmQ21FK288FPqkyooO5fSO1V5bfH6AkS7DgKt6XkZiMSVPJVB8UkjebDjHi
 B5bU2qG1p73FPlBjS0mEheaNyGu22Ors3lP+Ullncr0WmDD1L1PoAuRHOH1G2lj5MGSU
 oziwuu0XJMUC+C2zWT0gTftxrNI+/h6SgOG0VzaTcn2ECUtcHnYQwNUl9wij1m71hfkt
 VwJRujlZ/KMv2lTLbGwBX3++3DpTOq9bs4bxRBNJs7PnqXg56JOA+qjxaFi4TH6jxIHL
 LVN97VAYoDNebK+mgN/O5rzA3NjigxAUr5AIopjyi0dYWl8gVIKgzXLvqC1hswio6HYD
 /jYQ==
X-Gm-Message-State: AOJu0Yx1RRH9HL7laVPoUtVL73V7x8B3md/CAaBFONrkkxaa4PpWEgCt
 m4HASW1c9feeJ4eAvjhhCmzwa4iaxIdx2z1NaJ7lA0slCfbJFSeJK8zSKyKlVE2L6ugHIaSmTJo
 n+ej9fZUK0lDXMi9EC/+h/wZoIev+a6BMoVs4
X-Gm-Gg: ASbGnct4DimfwGs5nGLxjBZoLjJSW1sTzVl6VyRHB078Cn30ZvmLtiy57yg3rQ7X3m5
 xdw00jSaEWhez911PqLKBBTr+xWLBl6q9JJaBJt3SnOL4da1Crl2EyEDsQwYQse+OZx1+KNHwg5
 dOo32/Yq37h5/5d6XNGw84vgxuzCc=
X-Google-Smtp-Source: AGHT+IFxIcpS9w4ukkK8dIylvoNPcvqThtPtvS+aM5D6ECqlzq55N5Cz5NcDZM4Lly9t6au8xQ12pXhey0/r6/L0uAs=
X-Received: by 2002:a17:906:840d:b0:abf:53ef:6584 with SMTP id
 a640c23a62f3a-abf53ef731amr1499308366b.50.1741102522249; Tue, 04 Mar 2025
 07:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
 <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
In-Reply-To: <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:35:10 -0700
X-Gm-Features: AQ5f1JrC-YPUQT84GPu78uPAfR4c0d2QctOyxvyY4dawr3kFzrjDSTYcusyKk4I
Message-ID: <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Fri, 18 Oct 2024 at 08:55, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rasmus,
>
> On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >
> > On tor, okt 17 2024, Simon Glass <sjg@chromium.org> wrote:
> >
> > >
> > >   membuf: Support a flag for being full
> > >
> >
> > No, that is the worst of all worlds, especially with it being a
> > build-time flag. The right implementation is the one where the head and
> > tail indices are free-running, where you get such a "flag" for
> > free, because you're not wasting the top bits of the indices.
> >
> > https://www.snellman.net/blog/archive/2016-12-13-ring-buffers/
>
> Thanks for the link. It is an interesting read, including the
> comments. I've only written one ring buffer in my life and this is it
> :-)
>
> Which option do you suggest? We don't currently restrict the size to a
> power of two and that does seem like a strange restriction. It will
> make it less useful, e.g. in extlinux_fill_info() and potentially
> replacing memgets().
>
> We actually don't have to worry (today) about threading, so option two
> could work, I suppose. I don't like the 'length' field any more than
> the author, but we could have a simple function to turn it into
> (pointer plus an empty/full flag)
>
> The power-of-two restriction could be lifted by use division instead
> of masking and making sure that the indexes keep to reasonable values
> (say no more than twice the buffer size). In fact with the limit, we
> could just subtract the length from the index when accessing it, if
> needed.
>
> But overall I think I'm with Chris.
>
> >
> > If you want to do the churn of renaming anyway, I suggest doing it by
> > adding an implementation using the proper scheme under the new name,
> > switch users over, and dropping the old. IMO, this series as-is brings
> > no value (except for the tests, of course).
>
> OK. Do you think this series gets us closer to that, or further away?

I didn't get a response to this (which is not a problem, I miss things
all the time). Anyway I don't like the power-of-two restriction and
you can see my other responses above. I've applied this to my tree as
I want to have the tests in place.

Regards,
SImon
