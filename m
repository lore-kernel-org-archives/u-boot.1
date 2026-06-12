Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F0CD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8B58488A;
	Fri, 12 Jun 2026 20:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qij6hJwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7989F8489D; Fri, 12 Jun 2026 20:33:35 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0E38063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8ccf7b7d188so14975206d6.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289212; cv=none;
 d=google.com; s=arc-20240605;
 b=Gzgks9Zl5taZ7fuCk11B85eMGcJP2Hwrj8wB6k3NSozA2tdR3T31WUIKqmPMNI5zpy
 Ldcds3tojcnbCnG82z1GHNDC1VtzKlGZBXMC8uiJS9WIY9VGJ+jg7+nFjlDv9F++l2dm
 8PlHflBtYqPkRfAq8p1Wpw7sy4brTQYPrHO1FJGWXSWwRTBtAzdUf0h3fgTgYI+5Rl7+
 0s4A+eVGtVOEW1kowBPq9GdtdcQFYXTW/C2XVWgMGoREytI9gx7vaj6LhhSHf+h/u3hB
 QOEnSs81CZa7lo3udxUFM/W0Zq4+zwE3546jtRVM8h8ICAqUOWyAZl2kY3a0VyDBVoca
 Imjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IVxFtNAWCQnrWSuE8iLwybk+0OmopUgSjYIUv3mnnFk=;
 fh=HOiqdjCWYJw1Oik81ZH1k5v0vAJgHyZD72FSNIi54QE=;
 b=gbfMAbCm/aNmAvuB+MYwvQR2Sd5Lamd3Lf77F4fI+/bj2LmKfl/DOWbPNCSVkmIR6L
 kDaxXOHWcbdEcUDdROHXtbUdhYDfo8EGfd8fjYl7OF83oLqu+rKNuufYcALapSIpAVh0
 b3kw3PJjYJ7Kocbb7CXxD1oxUTdR0+hVJHuuQnOPjz2RMnlTF19I6tnvj7DuTeKBB6qS
 LiC3bC1p9L4IDItB0BOaq0ByXlc6sNIwIyqd9wz75oL/CStKoZjRf7RSdf6WeV88D69G
 vc/p/eLiKVs/p8li6Gt4AVl0yz+qV/T4YgCbUDVwpkU69Mmt7CHJfbJUFNsg7iudw7a5
 ftsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781289212; x=1781894012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVxFtNAWCQnrWSuE8iLwybk+0OmopUgSjYIUv3mnnFk=;
 b=qij6hJwcTOJGrhz9iPxTJKz/kHmF/1qR/COAy8qOQCOmYk05nhr6jqxVbezvia68VR
 Jdd8DDINEprYchRqHtyhvBjA5QiMmclqWQ21zK/SEpRtg53BXAuN2unHgnbWnZVEJw5Z
 ZuZJJkdktXyNCMq7vlKG38p9tojZBRAktB8Iq5l6KK9wl2B/VCiNpr0rR1XHd9Ugnfqn
 Zxz/HLsfP5fICwBPZ2sXxbxnGWGHftBDwg/QcQtMZg8XxVxsvw6SiLnPSgguRVJr1mar
 aFRaKZYwZtSiC+VnXExtFLKK/Dm5p9eivN2VHuJly8TUCAEJvlqeRWD40+dCTXyWRJvd
 ouRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289212; x=1781894012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IVxFtNAWCQnrWSuE8iLwybk+0OmopUgSjYIUv3mnnFk=;
 b=PeAOMsO8UaFdEkeDIOe6iSWcHro+Kx/ZT1Tiy+Q2Ju0EgJVvkxlLhTcep+82Fflwx6
 aFWfkNPeG0dWPw6LzCJt13xRPxUgc5vdQD57fDB8YJeYZF6C4FyuCQHEktmek6zbfLtU
 MQKb9ahTih907i5QVr7RBEDaRV2TtBcHrrksQA8RT/1EElvGKdW3G/LwhCTuNA1uJA7d
 jtE4TSnPvzJVNx7N01Fq9WryprGFhqRSn3GcEYSArHjgy3GEo/uNPWxogdyAlxQYWu8q
 ASUSYGghprWmTSyrUpjSF97rBTcEcjcocZDpMSzLKepCnZ8ZM2cYd1ryUMNP9vNfGw4t
 BF1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NDEu60C61H0dXYN0/3sKZ57lOhDexcJD6ly6nsBYtnqSjgwNvobHQIiSdFiBRKwE3igpXr1A=@lists.denx.de
X-Gm-Message-State: AOJu0YzPYMgiRK/zzfaMX2JmnmrcAlDOTIEw/jQSfZhQHUwUBnY0YqLe
 YFdGdxePtKVip63/TQRezz6TmFFdxoE9jUmpe69jDBpZ9TVRJmtRWnQ2Wm6N293V6kxqvj9nMHh
 ns/wMKKgmuwy9qnG1v2LV1QbOA0QfV6FMRQ==
X-Gm-Gg: Acq92OFHON58cDgnovxt51+kWacc36ugqkfuE7LUjZ5Yjz3V3lwJHFJblcdEix45TdW
 k8YVrR+n59IbWR0MaN400rWC4qrDHo0RThTgNqeEThO5j12pzWuQh4V7D3ODYZncxXTeQCpKNAi
 ILPA3yhpEnzt1nYTdB/4Mpr+Dexdp4AcFaJRGVvWwZYNwq+/dGrKcq9Bw4alvS+WW17u9mcZYNL
 WlxrfCP+FbW4HW275Zwc8HxvOsrswTXgKb8ra38qPNhCv6gAhZXdS7EtSh8GyJzcec4/uEfnuEC
 ozPs4NOZmznylg6A8Kdspr3/S8jbspv9PpKl0Erfr1AVSx9qOZmSREcGwMF8VpJckktwDRksP0f
 XZ/n7QreKavy0OnN4kqRLHznh+L/ptMqLjiph6DLmJ0rMDNrvLnBw5BZsLfSfoyvngOJ4SHiIhv
 bGVA==
X-Received: by 2002:a05:6214:2625:b0:8cc:d29:9f78 with SMTP id
 6a1803df08f44-8d32c5e0d6cmr69575136d6.11.1781289211458; Fri, 12 Jun 2026
 11:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
In-Reply-To: <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jun 2026 19:33:18 +0100
X-Gm-Features: AVVi8CeIxFKx7is0i6l4_Vu-KJAAGYdmGI8uIMAt6_C4vE14UEiiBynIddgWk5s
Message-ID: <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

> > > I would like to introduce the U-Boot Concept tree along with a few th=
oughts
> > > on its role in U-Boot.
> > >
> > > By way of background, I have been a contributor for about 15 years - =
around
> > > 10k commits and countless reviews. I have introduced many innovations=
 into
> > > the project: e.g. sandbox, device tree, C test infrastructure, Binman=
,
> > > standard boot. Of course I could not have done any of this without th=
e
> > > U-Boot community (nor would there be any point).
> > >
> > > As the U-Boot project has matured, the demands for mainline stability=
 and
> > > rigorous review have created a natural friction for landing complex,
> > > large-scale feature and refactoring series at the necessary pace. Thi=
s
> > > structural reality, which has slowed the adoption of ambitious effort=
s like
> > > bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Co=
ncept
> > > tree is designed to alleviate.
> >
> > The main issue to land complex large-scale feature and refactoring seri=
es is
> > mainly the lack of human highly qualified reviewers, proper shared proj=
ect
> > infrastructure and funding for paid work. Not developers.
>
> That's not quite what I am seeing. I am actually seeing quite a bit of
> rejection and deferring. Perhaps that is just because of what you are
> saying, but in any case, it is creating challenges.

Well maybe others in the community don't see the value it provides.
Not everyone sees ideas of others as good ideas, people have varying
opinions on them, that's fine, but we as a community decide what lands
and what doesn't, some times we as a community disagree and that's
fine. Not every idea will land upstream and that's not necessarily a
bad think. For example I see little value in mouse support in an early
bootloader.

> Re infrastructure, I am already providing a lot. I have offered to Tom
> to help with other pieces, if needed.
>
> >
> > >
> > > I strongly believe that projects must evolve in order to stay relevan=
t in
> > > the long term. This includes code-refactoring, new features and subsy=
stems,
> > > along with migration of old code to use them.  A look back at the U-B=
oot of
> > > 2010 shows how far the project has come. I don't think anyone would s=
till
> > > be using U-Boot if it had not evolved.
> > >
> > > I have set up a 'Concept' tree, a possible future for U-Boot, as a wa=
y to
> > > regain the old pace of innovation. This environment is a proving grou=
nd for
> > > new features where we maintain a lower bar for risk tolerance and
> > > completeness. We will accept partial and speculative features, provid=
ed the
> > > underlying code remains robust and of high quality, with the shared
> > > understanding that features may be dropped if they do not prove benef=
icial.
> >
> > I'm clearly against having a separate official "U-Boot" fork tree, this=
 will
> > only lead to confusion to users and contributors if it shares the same
> > mailing-list and name.
>
> Yes it cannot share the same mailing list - we tried that last year.
> Do you think "U-Boot Concept Tree' is different enough for "U-Boot",
> to avoid confusion?

The time where it should share the same mailing list is when patches
are moving from your concept to the main tree when undergoing review.
Do the patches your pushing to your concept tree need to be sent to a
mailing list?

> > > Another difference is AI. I believe that AI is the next step on from
> > > compilers, which also took a long time to produce good code and find
> > > acceptance. The Concept tree welcomes (and encourages) high-quality A=
I
> > > contributions and reviews. It accepts PRs and allows reviews on PRs o=
r the
> > > mailing list. It relies 99% on automated tests (sandbox, QEMU and lab=
s) so
> > > sets a high bar for testing. It uses a separate Gitlab instance for n=
ow and
> > > of course uses a separate mailing list and Patchwork project to avoid
> > > cluttering the main list. Concept runs an AI-powered cherry-picker so=
 that
> > > it keeps up with mainline. In no sense is it operated as a fork.
> >
> > I'm clearly against using AI for any of development or review work as i=
t
> > can't be fully trusted and will monopolize precious reviewers time revi=
ewing
> > AI code instead of reviewing legitimate contributions from individual a=
nd companies.
> >
> > Using AI for CI testing and regression testing could help if it doesn't=
 add
> > a burden for maintainers by reporting false positives.
>
> RIght, Tom has been very clear about this too, even suggesting that AI
> is actually unethical. This is indeed one of my motivations for the
> Concept tree.

To avoid the scrutiny of using AI? If that's the case and you're
intention I have further concerns.

Also it seems you are even using AI to reply to people on serious
mailing list things, I have concerns of your use of it there too!

> > > Once features are landed and functional in Concept I hope that many w=
ill
> > > find their way to mainline, although inevitably some rework will be n=
eeded.
> >
> > Still I don't understand your point, Linux or Zephyr can land very comp=
lex
> > features with a single tree, what make U-Boot different here ?
>
> I made some guesses above ("the demands for mainline stability and
> rigorous review"), but I'm open to your thoughts on the root cause.

I made some guesses above too.

> No project is immune though. I worked a lot in Zephyr - one-hour
> meetings every week across several areas, lots of engagement, but even
> then one feature we did took over two years to land (luckily the
> company could afford the cost :-) You may be aware that FIT (a fairly
> minor feature) was kept out of the kernel for 15+ years. Another
> example is perhaps the bootph tags. I introduced these into U-Boot in
> 2015 and found their way into linux around 7 years later.

So some time things take time, if they're not right or ready I don't
see the problem there. If there's demand for it people tend to find
the time to review it to move things forward.

> > > I recognise that introducing a new 'Concept' tree might initially cau=
se
> > > confusion or concern. This is an invitation to work together to defin=
e its
> > > role. I welcome all feedback - positive or negative - here on the mai=
ling
> > > list, privately, or on irc. Let=E2=80=99s discuss how this initiative=
 can help
> > > U-Boot remain the defining firmware for the 2030s.
> >
> > Our immediate priority is helping U-Boot establish the proper technical=
 and
> > legal infrastructure to receive funding. Adding AI features, maintainin=
g
> > separate forks, and managing competing domains only distracts us from t=
he
> > critical task of switching off the dying Denx infrastructure.
>
> I am not aware of what is going on there, but am happy to learn about
> it if you can share details. From my experience, apart from patchwork
> being down quite a bit, the infra is mostly holding up. In any case
> you seem to be making my point about the limited bandwidth people have
> to land features.

The infrastructure really isn't holding up, the patchwork is run by
ozlabs and is currently unrelated. We have a deadline on the denx
infrastructure and your failure to hand over the domain hasn't helped
there.

Peter
