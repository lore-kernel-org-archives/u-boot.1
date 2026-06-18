Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB95ECD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2621A8460E;
	Thu, 18 Jun 2026 17:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="evrZzpmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A33847EF; Thu, 18 Jun 2026 17:06:24 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3718063E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68f36e1663cso1836292a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795181; cv=none;
 d=google.com; s=arc-20240605;
 b=ezY/NYhYehwh9sSGcGNagMFEt+E3c3n1LVM5/2/xZbdB9udSc5QEbkwaP+/bQG3yde
 DirNCoV3/+Sdqpwwy8zaZDIjWIknuTF/vvl7ZQqix1L5qmwjBDVwbIlEODmORNUICphl
 OnnV2ygz7OprRCg6i/JvxtlJN1mWLGypEGTif3QStcmPi6DmIvDlCIrIeXlYvqlRQTE4
 pPkSsgnpz+sY+hQ28jMegpzfg/c7FfEjR562mOIcmq3tzSqJFdx0vWvTnYu4p6pHPkFU
 SH5ZGreYfs4VJVNPl7y8V7J2BI2h9YbazFIrAVGdY8RtNd672AD/LXB52XNvi4QlkRtZ
 X36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HnWiliT5A1K/FA/EAoXpPCJSye0HJJK6kqRtaha1D9c=;
 fh=X5Hh4wKYv4BmurRQBxfyd9vP1rEGGyHqbfepUlyr5QY=;
 b=YBQrAUITbu2iWYRS5F6M6sXWSJUfpsqrsOdfv89JPDpr7RPpfPTUbf5z/7pclxrv2F
 aZaljJzSkqKenH7v+Xpq3OF9iSwfpDjCfDvn7mvEpkYoQLIt7WqzsPbSsuslD9w+RoDi
 hcGqeacz6Gvq4SBIcIRKaKZoXNkD17QCUArPSQAzKISwjC0oj2SEajYMpeJ6CcufkkRt
 DV7oZ4hZp7gKMFoivz6xgksq1Pne3oJZmYlxCOtaOOxtijfPCaC97zsuHc8kfkpm+d19
 vu73eGKoWU8yaU0nJB68VVomdvfI7tpYmbwuP6P+H+OkmGox7e7kjw2DVWb3nnTomGJ9
 dmNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795181; x=1782399981; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnWiliT5A1K/FA/EAoXpPCJSye0HJJK6kqRtaha1D9c=;
 b=evrZzpmt4rg/1Npu7bf/mqTLa5X3jbPx2qQvtwubxyyoO3LW5dJzXvSS7ECJNQZz9w
 WQ+AgqcRMVnB391BZzwofuDx45EK1OjXJq1BJhQKY3Mp3aVV5paVw/fZ2o7im+CvUpYk
 aANe1DSz+XK/rvlXZN80VNznWIyXUZqEDMrHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795181; x=1782399981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HnWiliT5A1K/FA/EAoXpPCJSye0HJJK6kqRtaha1D9c=;
 b=RFSE338T2dtuqtikYuoKOW89y+/HmOuAFA9WBp5pqeYO1BD+4p6LgG8F5GbGYJbh26
 9iOLqJooM/ltghLnT4lZXL10FG/nFa+M8TUB/GWgig/IcTnDgQhpRFyGJ5f1Xc/a0yw8
 UEvKEAbkC1EZaQFZz2Qnsc7tTd8ZXtgolCI5HYJ7L4kikYDs88Ays+r2HmcUP+L6/rV2
 OIbQLGbERD6EgBlpK7i0uEk0/CdEeMhrTAWTZmXlYOTphaHguXfIDKAL+xHL6RCSWf0J
 6amlkg407UYWnsem8S7AGFGTVn8M1MyvEYdrpieZk9pyKImd7OBCPnOiVUxo4Ayu7O1P
 iUog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8slaFk0SAXmCvxe7BsBc+KHQZdoN4Mo4pAnSrBUPPG5h5R4aB6WE0CGqxM7ORT6PnFGj1KMsQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxud64OACsMa68NhC3rfMoDlnu68CHd0slPdOZIVYOWBxPsJywZ
 p/7XQLoheTTBDPh9WjqpMhg2qJsehCy8m10C3duFC1RkQnp2wqjgwHsNfL575e5TI5I9+wol5OQ
 RcIDDiszzHmRuvAWOJRFcZOknkYxY6W7aU3yzOCpX
X-Gm-Gg: AfdE7cnlx3xxuvZtHkdTe1z2chi7pRmLAJW1WeAcul09/udpYwVGAgT2gnQ1utT5OlD
 C9hr/Lrs/e2W9fWQWdhGnrzKoZunoj3u+RRLOb6uxztREwg6u6cqRDdSTjZX5/G6u4RKfcPDf1n
 dYqlx0giNzqhma88sX6vyoraOUA+32v/ZbKwdT+TyEM7wtk+X6wPFZb9CdIsLTi7GOM/Sz5ZqvY
 sGyY8rwCjiGIw2eH0/csD9YAGzKcZDDqBkH0tQfwIIcKz6012DIz9jaJAY1SD0z8T7bBsq92g==
X-Received: by 2002:a05:6402:380c:b0:691:b158:b413 with SMTP id
 4fb4d7f45d1cf-695473ff239mr4919366a12.3.1781795181196; Thu, 18 Jun 2026
 08:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
In-Reply-To: <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:06:08 +0100
X-Gm-Features: AVVi8CcFYc9QWWuKhgDzOd3eC_OvxF5BWkzMSjGjpaWo0x-xjaw9_1BKZNeS6oI
Message-ID: <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Fri, 12 Jun 2026 at 19:33, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > > I would like to introduce the U-Boot Concept tree along with a few =
thoughts
> > > > on its role in U-Boot.
> > > >
> > > > By way of background, I have been a contributor for about 15 years =
- around
> > > > 10k commits and countless reviews. I have introduced many innovatio=
ns into
> > > > the project: e.g. sandbox, device tree, C test infrastructure, Binm=
an,
> > > > standard boot. Of course I could not have done any of this without =
the
> > > > U-Boot community (nor would there be any point).
> > > >
> > > > As the U-Boot project has matured, the demands for mainline stabili=
ty and
> > > > rigorous review have created a natural friction for landing complex=
,
> > > > large-scale feature and refactoring series at the necessary pace. T=
his
> > > > structural reality, which has slowed the adoption of ambitious effo=
rts like
> > > > bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the =
Concept
> > > > tree is designed to alleviate.
> > >
> > > The main issue to land complex large-scale feature and refactoring se=
ries is
> > > mainly the lack of human highly qualified reviewers, proper shared pr=
oject
> > > infrastructure and funding for paid work. Not developers.
> >
> > That's not quite what I am seeing. I am actually seeing quite a bit of
> > rejection and deferring. Perhaps that is just because of what you are
> > saying, but in any case, it is creating challenges.
>
> Well maybe others in the community don't see the value it provides.
> Not everyone sees ideas of others as good ideas, people have varying
> opinions on them, that's fine, but we as a community decide what lands
> and what doesn't, some times we as a community disagree and that's
> fine. Not every idea will land upstream and that's not necessarily a
> bad think. For example I see little value in mouse support in an early
> bootloader.

I agree to some extent, but in general I believe that code should
land. U-Boot is a general-purpose project and we have quirks for all
sorts of hardware and situations. Better to bring it in an solve the
problem properly and generally, than force vendors and users into
using downstream versions.

U-Boot (Concept at least) can be built as an EFI app and therefore
replace GRUB, so it isn't necessarily an 'early' bootloader. When
running on embedded hardware where Linux is installed using
u-boot-menu or systemd-boot (ie. extlinux / 'boot loader
specification' (BLS)), a mouse and proper display also allow
dispensing with GRUB and even EFI.

>
> > Re infrastructure, I am already providing a lot. I have offered to Tom
> > to help with other pieces, if needed.
> >
> > >
> > > >
> > > > I strongly believe that projects must evolve in order to stay relev=
ant in
> > > > the long term. This includes code-refactoring, new features and sub=
systems,
> > > > along with migration of old code to use them.  A look back at the U=
-Boot of
> > > > 2010 shows how far the project has come. I don't think anyone would=
 still
> > > > be using U-Boot if it had not evolved.
> > > >
> > > > I have set up a 'Concept' tree, a possible future for U-Boot, as a =
way to
> > > > regain the old pace of innovation. This environment is a proving gr=
ound for
> > > > new features where we maintain a lower bar for risk tolerance and
> > > > completeness. We will accept partial and speculative features, prov=
ided the
> > > > underlying code remains robust and of high quality, with the shared
> > > > understanding that features may be dropped if they do not prove ben=
eficial.
> > >
> > > I'm clearly against having a separate official "U-Boot" fork tree, th=
is will
> > > only lead to confusion to users and contributors if it shares the sam=
e
> > > mailing-list and name.
> >
> > Yes it cannot share the same mailing list - we tried that last year.
> > Do you think "U-Boot Concept Tree' is different enough for "U-Boot",
> > to avoid confusion?
>
> The time where it should share the same mailing list is when patches
> are moving from your concept to the main tree when undergoing review.
> Do the patches your pushing to your concept tree need to be sent to a
> mailing list?

That has been my approach to date. Even if not, though, I think a
separate mailing list makes sense, to avoid confusing people.

>
> > > > Another difference is AI. I believe that AI is the next step on fro=
m
> > > > compilers, which also took a long time to produce good code and fin=
d
> > > > acceptance. The Concept tree welcomes (and encourages) high-quality=
 AI
> > > > contributions and reviews. It accepts PRs and allows reviews on PRs=
 or the
> > > > mailing list. It relies 99% on automated tests (sandbox, QEMU and l=
abs) so
> > > > sets a high bar for testing. It uses a separate Gitlab instance for=
 now and
> > > > of course uses a separate mailing list and Patchwork project to avo=
id
> > > > cluttering the main list. Concept runs an AI-powered cherry-picker =
so that
> > > > it keeps up with mainline. In no sense is it operated as a fork.
> > >
> > > I'm clearly against using AI for any of development or review work as=
 it
> > > can't be fully trusted and will monopolize precious reviewers time re=
viewing
> > > AI code instead of reviewing legitimate contributions from individual=
 and companies.
> > >
> > > Using AI for CI testing and regression testing could help if it doesn=
't add
> > > a burden for maintainers by reporting false positives.
> >
> > RIght, Tom has been very clear about this too, even suggesting that AI
> > is actually unethical. This is indeed one of my motivations for the
> > Concept tree.
>
> To avoid the scrutiny of using AI? If that's the case and you're
> intention I have further concerns.

Not really the scrutiny...the more scrutiny the better, I think. But
if mainline is anti-AI then Concept can provide a place where people
can make use of it.

>
> Also it seems you are even using AI to reply to people on serious
> mailing list things, I have concerns of your use of it there too!

Yes I use Patman to at least queue up some of my reviews for code. But
it is a long way from being a substitute for my own review...we'll see
what happens and I admit I have not put much effort into a full AI
reviewer - at minimum we would need lots of written rules whereas for
now it mostly relies on the patterns it sees in the tree.

>
> > > > Once features are landed and functional in Concept I hope that many=
 will
> > > > find their way to mainline, although inevitably some rework will be=
 needed.
> > >
> > > Still I don't understand your point, Linux or Zephyr can land very co=
mplex
> > > features with a single tree, what make U-Boot different here ?
> >
> > I made some guesses above ("the demands for mainline stability and
> > rigorous review"), but I'm open to your thoughts on the root cause.
>
> I made some guesses above too.
>
> > No project is immune though. I worked a lot in Zephyr - one-hour
> > meetings every week across several areas, lots of engagement, but even
> > then one feature we did took over two years to land (luckily the
> > company could afford the cost :-) You may be aware that FIT (a fairly
> > minor feature) was kept out of the kernel for 15+ years. Another
> > example is perhaps the bootph tags. I introduced these into U-Boot in
> > 2015 and found their way into linux around 7 years later.
>
> So some time things take time, if they're not right or ready I don't
> see the problem there. If there's demand for it people tend to find
> the time to review it to move things forward.

To me that is a quite a rosy view of things, TBH.

>
> > > > I recognise that introducing a new 'Concept' tree might initially c=
ause
> > > > confusion or concern. This is an invitation to work together to def=
ine its
> > > > role. I welcome all feedback - positive or negative - here on the m=
ailing
> > > > list, privately, or on irc. Let=E2=80=99s discuss how this initiati=
ve can help
> > > > U-Boot remain the defining firmware for the 2030s.
> > >
> > > Our immediate priority is helping U-Boot establish the proper technic=
al and
> > > legal infrastructure to receive funding. Adding AI features, maintain=
ing
> > > separate forks, and managing competing domains only distracts us from=
 the
> > > critical task of switching off the dying Denx infrastructure.
> >
> > I am not aware of what is going on there, but am happy to learn about
> > it if you can share details. From my experience, apart from patchwork
> > being down quite a bit, the infra is mostly holding up. In any case
> > you seem to be making my point about the limited bandwidth people have
> > to land features.
>
> The infrastructure really isn't holding up, the patchwork is run by
> ozlabs and is currently unrelated. We have a deadline on the denx
> infrastructure and your failure to hand over the domain hasn't helped
> there.

OK, well it seems we have figured this out, so I hope it can also get
done before the deadline. I'll reply separately.

Regards,
Simon
