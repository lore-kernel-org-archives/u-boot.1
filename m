Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C32E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F618036B;
	Fri, 10 Jan 2025 17:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J+05kbdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA4A801F5; Fri, 10 Jan 2025 17:45:29 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952DA805E9
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.kiernan@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54024ecc33dso2384282e87.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736527526; x=1737132326; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwZlQhuq/jGyP2sDlLjjMtx0ytVEHiT9DtggRvZM7GA=;
 b=J+05kbdj8wbKrnHYgHSLXcV0DNoLC3yTRN4o/iHcyRsOj5VipoOzZwQEO5fQazCs3X
 R9W+x3xrT0fhEUB6FsmArTWYzpu/17pBs2TspWQqzuiU6/4LTxXyrUZfsfWZK9Lk2atT
 N6tcGdIkZSMGxIi9EmKHkmDpYjbNyfi1EccChvA5rTmt8ddLQVEyTR4Yw3rEOV3VlOHy
 VBCtaDWYF5b3pmdxUr/X8yZZC1lAhyiBPwX2HJxqoUjgczmK/2/xGftPOBOaYau00fGs
 d3pSqaY3AmN/Z7MSAxYvuax/gYiIH0sodjbYDWg0LUpTkhZhvhZkXt92dBm0WHeKHjit
 5+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736527526; x=1737132326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwZlQhuq/jGyP2sDlLjjMtx0ytVEHiT9DtggRvZM7GA=;
 b=XqGMTLEwHl1WuKus2UCZ1/Qm9BjymMzzb+ED56SgeRFcx1RkwAiaKD+MRx/Gu3L3fq
 Kdb75d362cwTi0J7J4hNluv/FF82kHWlb9Giw9vLTHOIMMr6Wq8zefSxTlRYGGCXJtPX
 Eal7uuksl6Y1rsSmBuDSaebZRZTDCha7C62V66/xNqo7Qcxe0yrS9ECKRIT5s8EqcXuw
 xl1WON1KjLp+yFdWRogoUQJ1FNZbrDFLqpt3nQnCeZG1nqKFti3FkN4LTkLb4pf3F37h
 zXjZskRrbYqgehd792gOEUf/mk9xxakhLSg6rDLRvFZvRKsvEU/eNyQNJeawu8CPzxlv
 /QHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd217vUK3E18JZ7c/SmhuxxcOrjFkRLIJkdOMBOSHPrOObobikAFHrNTSkbOqfs1nb2PGctuc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5BtM+JgCqE7/Pn88aeo9BO79KQtMQyfY8kOfHg7ZU1dJRvLOm
 mo/tX/tcQEzNBZw2FisvTcOSqv373XlODC6PuciyCFD0nwxrWjab+McxbO6AV5HKcsYaw2p6N9+
 Kw56UvLe3+pXLdQTyH2yisWEqloI=
X-Gm-Gg: ASbGnctqzIeD2YRaChx3t91uRknm+7OpnsO1W1PGZjVATjGzT31j+GQwmeMTXSJAb8l
 lpFVE5IRqH/eg2fgpaVzol+hlxclS6sh/XVP6
X-Google-Smtp-Source: AGHT+IGbV8NWjX+6AQKpizofpQscbC67SblJHQqJetF0dwug/D35cF3pJkaR+52Pn0OBpzqGEjYVUDuCvpSjj+qIbcE=
X-Received: by 2002:a05:6512:10d4:b0:540:1be6:f15f with SMTP id
 2adb3069b0e04-5428444c0f4mr3916127e87.0.1736527525501; Fri, 10 Jan 2025
 08:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20250102161313.GP3476@bill-the-cat> <Z36DdfO_EH454Xdw@hera>
 <CAOf5uwnODo9ZpBMDBi6LGG3Fx-cggiryDZ_mrrTEV+S9mx7s8g@mail.gmail.com>
In-Reply-To: <CAOf5uwnODo9ZpBMDBi6LGG3Fx-cggiryDZ_mrrTEV+S9mx7s8g@mail.gmail.com>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Fri, 10 Jan 2025 16:45:15 +0000
X-Gm-Features: AbW1kvaupdfulz5t_fVwfsgfPqVJpV69p94OJPs3okCeo-T5_68LxWoLfSdQJdE
Message-ID: <CAO5Uq5S9DraM5_R97VRqDumdOcTqLVOH4wdwBf9oQY3E6RmP2Q@mail.gmail.com>
Subject: Re: Simon Glass's future with Das U-Boot project?
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jan 10, 2025 at 3:51=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Wed, Jan 8, 2025 at 2:54=E2=80=AFPM Ilias Apalodimas <ilias.apalodimas=
@linaro.org>
> wrote:
> >
> > Hi Tom,
> >
> > On Thu, Jan 02, 2025 at 10:13:13AM -0600, Tom Rini wrote:
> > > Hey all,
> > >
> > > While I had hoped that the quiet of the last week or so had meant tha=
t
> > > things would perhaps return to how they had been before, Simon's larg=
e
> > > patch series and then comments on the TPM+bloblist patch have shown
> > > otherwise.
> > >
> > > At this point, I do not know how best to handle Simon's behavior,
> > > without soliciting feedback in public first. At best he's created a
> > > soft-fork of the project with his "sjg/master" branch. I've asked him
> > > repeatedly to explain how he thinks this is all going to work out, in
> > > public. I've had private conversations with him, but I want him to
> >
>
> I have some private fork of the project and have some project that
> implements
> some features that are still not in the mainline. I think that forking
> u-boot in general
> is not a good idea.

This (with honourable exceptions) is the SoC vendor model - in my
current world I'm stuck on 2015 U-Boot for goodness sake... forking it
is a terrible idea.

> > > But what's going on now is towards the worst end of
> > > possible outcomes I think for the project itself. And by that I mean,
> > > one prominent contributor steam-rolling over others and doing as the
> > > please and implicitly acting as an authoritative voice for the projec=
t.
> >
> > I personally don't want to pay attention to out of tree patches.
> > Simon randomly responds to emails 'applied to sjg1/master' or something
> > along those lines, which further complicates things as people might thi=
nk
> > their code got merged.
> >
>
> Me too. I don't have that time and for the moment how the project is
> progressive is fine.
>

Sitting on the sidelines mostly these days, when I dip in, then
realising that I spent time reading a thread which isn't on code which
is heading towards the mainline, is at best annoying and frankly a
waste of time.

--=20
Alex Kiernan
