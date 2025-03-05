Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4A5C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0294E810ED;
	Wed,  5 Mar 2025 14:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oCuJCmad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7E7811B3; Wed,  5 Mar 2025 14:53:21 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E3F807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac21c5d0ea0so57411666b.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741182798; x=1741787598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YzxGQ1lpfa2gNe+A1pe6jtEzJggwgcmBhIt9dZ1CLHY=;
 b=oCuJCmadlWX1chTHBb68ldcjE/hDBA/GmR9hQaOW8PHt35kTOQM3FjEWHi5EGkW4Rs
 8vcn9ISuiNRjU9iptc1Tn6Yp1v0xtzgEI8GjjHDyaVK7RFMv+VlGTST3jZnN4Gk8qFQJ
 RDAY5H0+i+RMDpNbO5dTgCDVVSwIU2iydQHNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741182798; x=1741787598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YzxGQ1lpfa2gNe+A1pe6jtEzJggwgcmBhIt9dZ1CLHY=;
 b=EuXfsFCriuBIG5qyl6NYdKbC1ezapPB68q755UEu2rsbanLG9/+ChPvQoAKkXlecXb
 SQeNVAmk5yDmTr5e3+0UgqwsbqKTN4lDNbDnpT/ZxtCsD1PPFd+e23iEkPu4YChS3LQF
 +XQFwqn+z+wobhhxDHOq+Ux6+eCPC+Z43EcHUM9pSKb2GkWKziXIt6tsi5zR9QTzSuFk
 jJ+cMRJzwiwDY1JOmBGYPQb8+p2MR4TbiWsgQzR5YI9PP9puMwfg0C3FHrPFfrRpCpNE
 e5yptW5HdDS4WZ/ifw+tt4QWTfULCAXQQrr5o9ILtvm8baUwrUCZ1RRIUNKh+mkn+OqS
 Xo3A==
X-Gm-Message-State: AOJu0YxURY8YQcf+CgCpbfXEbwxUtnnlF8WV8aA8iNqpI7MOjJklacFn
 chkXRpDelPLjmsjP1hevyAVmh6RQ52LX+VsmF9gZZfDD0Pfs63BdBmJkzq1+lnXrGcouoFatbkH
 RdkmASP3Ep+NNRnMYEV4q33JxsqGV5tj/Y1ZC
X-Gm-Gg: ASbGncus+RaHuXIY5fT3qNX7WxQ1Te3fLEs8cz3ezuLkgKMUMyYS608YKpDiUFfHyph
 EJUfxE1gYujQ7wx2kpAunarj801rRzsBWhJLlGhVrjlQWJDTKWaKo5pX0Nuz9f0QqlfQxTTG/d1
 4o6E0g7vLi4SagJeGjTqgu0DXdf78=
X-Google-Smtp-Source: AGHT+IFI7hffnyRnj9uDXys4icFWB1hbi57roMoojGXhFCpxh/NHiW87ppJAe5Kj/27kgjs1TOevKNIwG8z8njgjgig=
X-Received: by 2002:a05:6402:27d4:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e59f3d7a45mr7995613a12.13.1741182796473; Wed, 05 Mar 2025
 05:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
 <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
 <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
 <87pliw62xn.fsf@prevas.dk>
In-Reply-To: <87pliw62xn.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 06:53:04 -0700
X-Gm-Features: AQ5f1JpOKW6qLm4YwA-EkPoF9lr1QzIUNRNsz1uTaLPrn1nrVfcWYGpqn1kpJY4
Message-ID: <CAFLszTjyJW05xpjg23B2KHMi9-tZVZhRd0Zpr3A7yfcQJc+4MQ@mail.gmail.com>
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

On Tue, 4 Mar 2025 at 11:55, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Tue, Mar 04 2025, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On Fri, 18 Oct 2024 at 08:55, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Rasmus,
> >>
> >> On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> >
> >> > On tor, okt 17 2024, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > >
> >> > >   membuf: Support a flag for being full
> >> > >
> >> >
> >> > No, that is the worst of all worlds, especially with it being a
> >> > build-time flag. The right implementation is the one where the head and
> >> > tail indices are free-running, where you get such a "flag" for
> >> > free, because you're not wasting the top bits of the indices.
> >> >
> >> > https://www.snellman.net/blog/archive/2016-12-13-ring-buffers/
> >>
> >> >
> >> > If you want to do the churn of renaming anyway, I suggest doing it by
> >> > adding an implementation using the proper scheme under the new name,
> >> > switch users over, and dropping the old. IMO, this series as-is brings
> >> > no value (except for the tests, of course).
> >>
> >> OK. Do you think this series gets us closer to that, or further away?
> >
> > I didn't get a response to this (which is not a problem, I miss things
> > all the time). Anyway I don't like the power-of-two restriction and
> > you can see my other responses above. I've applied this to my tree as
> > I want to have the tests in place.
>
> I stand by my earlier comments that this is the wrong way to implement a
> circular buffer. I hope Tom doesn't pull this.

OK. Are you saying that you think it should only support power-of-two
sizes, or something else? What specifically do you want?

This series:
- adds tests
- renames to membuf
- shows how we could switch to using an empty/full flag instead of
leaving an empty slot, so we can see the code-size image
- does all this without requiring the size to be a power of two (which
limits its usefulness IMO)

Regards,
Simon
