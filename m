Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DCEC44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 12:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A6884B01;
	Thu,  9 Jul 2026 14:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsMhzzEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA2584B2C; Thu,  9 Jul 2026 14:22:46 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7D584ADD
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-51c2a449c57so10935661cf.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783599763; cv=none;
 d=google.com; s=arc-20260327;
 b=OLagUWNr9Y2hiSJKQYncep8B+kAcZhvskIclnhDezrmKf6eyVK3u93PgJja5/27oQj
 mYxnawPq4QB4op6Lg1sgCS9rItX5ZoQAGveW4JfDNL8crR4HI4QCACn8rsyMEapvco5V
 k/+LKKY3td3nL7klKCK8GsLKiENXtklnVDUmUs8Q8vG/xovXcbs5M6pL/MeqelSN4xOL
 pqp9snY/arVV0j5R/p0RI8CliXS04rK8uK26XOB0VPUZh7QaYMT6vFQ+F9ShJ4z8uFar
 6le5TKHU3dfCKLm5QqnxWtosTgVBUQ7Wvd2nRajj/rPnKXeWmyP1T9RrgsF+4zMJNzH8
 38UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d3I2V3U0lh1k/Uph66nK5PcFuSdWa7GZdhkWR98p7qk=;
 fh=CgzkqVp1CcUAbz5widuZB2NcSANHTuSUxmKLbgBQrHA=;
 b=UAlkQ9KIWKYZvxp4Gwn+EgZxFN6o153nrUm/JVx3I2XgXJGtIAewa58OphMPcxDtrc
 sPf+wMmF2MaLd45G91BrK4GmfPd1fZxcfYn8dh53yWXAqBjhXsNeKtLErBSs6/vnNFLh
 L1G4EgRPMAlfaRABQYvL81ifajyyeqVK8WZ/m3oDuSSGktx8WxcisOjaNNIvfL7vPkUH
 dlatMzPhSyH+J8ILCV/jh25aIQdpMXnZ+ssZ3q19gVVWKRYWYG9vV49Cp8ljsJAGf8kB
 P2yvtokfNRpGSk4rDWXcT8N/1Gfdfvqz0jcMlmZi9IGQfB9j5OVXFEfVoR282PffQ3vx
 euPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783599763; x=1784204563; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d3I2V3U0lh1k/Uph66nK5PcFuSdWa7GZdhkWR98p7qk=;
 b=KsMhzzEEl5Fxwf/KgPEIWiXi7bMLEapkkam5uCD8ebAJqGHJIavHS0yeVWnz3TNVqN
 ec5z4j0uI3PexqLZZnRZp2G1gAQk9ioTCn1/P0EuHbp4mkw+Bwp1m1sexBpe534hV4da
 qQgeevR4b924ADwooc8NIq3pK50+ws/tKVDjH+EWj20o+OTxHyhVTIf6BLQM9OIIUZdt
 ce+AuuYM2qRjrUihTFueIh+GTjdg+bMzoQ3YgWfoKQJ7GQylEEq1bO97OsYypjRpbFEj
 3tKmEwN0ybdFv9mz+yeJ9jidArJQuysqHgOSt7WQrbq5pC9IVjiedaUS2cllTdYtdUMe
 d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783599763; x=1784204563;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d3I2V3U0lh1k/Uph66nK5PcFuSdWa7GZdhkWR98p7qk=;
 b=YoOamthcTqIln3XsuBRxzD6eXXtmEeud7D1LNrJq8lpB+aacf7vxaN9XfKNPHcutHD
 1DWsbFnm3C70kyqny9gxRjSgHn2eCtyCsfZxIJDb+ns5n2tSq5LS42K+c3PI3vpXDreO
 sal1F+Nm+4FJkitGohAIOcmGKNmi98b1sVP0qUgKPYNx9kSwMbQF8Vm4AfU+7ZPBgpWI
 ueGTr+ap2bAcHhve6zu/3EmBQlLIWyVOfknQ8NaREHNCuGwrp0ykAP50pWRCRiG29+6w
 pYJMZqNkvChDldJcMx0UmOSVMxuvB+FXtELx57973VMA4RYDAswxmflurVfIiz7xGBpE
 YjRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/zRUxCrN0p5/Ha6G392ddVXIBtaB79eYYAV4O1WASRFDXdgEvOkLnqNyDYIuikSQowb+6kL4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5I997F9+5soPTehBIjekZwFhWRs8vwi7COz3CQNInedUWi9M4
 LZxpZNUFXRHmeA+sySMAwkj4QkLdRE2cax8pC4p2JQw90cSjKSw8xBOGW+X2w+2RA7O3jng6rCj
 edP+W8nr7mv3hKdlOqPcJv/74ThVS9Xk=
X-Gm-Gg: AfdE7ckRMUfllmR944a8pknAkSi3xRl9CHO3SrEeW77e9jAb4amjexPzl/8vNixy5lw
 S7ozNU6d7icfG16QxMV9L0pUPKlcent/GH++KGj/sdE+/lfJhaDx1cj3kho8qRUWfevRgvtbD7a
 W1dNmf2GQEUeBZJnpugzpXkwukMymjHIw7FjnnL1NHoZm22gO7E3jFlNQYA7/adi2qjbRY8Un0p
 +e1kL3MFXAE55t1pCFcNBLlXLzrM4lfc9U11ufpy3z7mPhSFIL4TTXrJLsXaHi7xvM4e9qgUKBD
 Jd2a4PFCjSn1Tq9uTPeP0kKyq/wY0u75TU5C720XK2tVSAYzRjn9PVr8wXHK2QmE02gyoII7Z9c
 IZw3EnCET1W0N45KZLsbEqDDRNi7M1gTf/ZuoevUrhnnVNh4rkV36VSA0gfBf1xNYrkXQiokIPB
 4U8w==
X-Received: by 2002:a05:622a:1312:b0:51c:7b13:62f9 with SMTP id
 d75a77b69052e-51c8b439112mr74793081cf.79.1783599763252; Thu, 09 Jul 2026
 05:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
 <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
 <CAFLszTg24RTHi0A0vWfv62FfZhm1Uz4iw=4m7NZ6_4W3R3kwyQ@mail.gmail.com>
 <CALeDE9Mcg2TUcnv3LD4k2pmCnogV97KqjUn-dQiDfAZt+hPN4Q@mail.gmail.com>
 <CALeDE9O4cPp7aWsiHreqOt_sE4t=y5MzvnyuCCGpwzD6hFjuAg@mail.gmail.com>
 <CAFLszTgRUEGG6UpfE0X83RXPU_pb8ZAMv18zNrmcHbrvyg=k5A@mail.gmail.com>
In-Reply-To: <CAFLszTgRUEGG6UpfE0X83RXPU_pb8ZAMv18zNrmcHbrvyg=k5A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 9 Jul 2026 13:22:30 +0100
X-Gm-Features: AUfX_mz-ygK6ApQ9AeC9tPVOsYXKnjCsfSDER8orp_tOhHqXCn1Ty8C_aDbyMGU
Message-ID: <CALeDE9N0e-K52+Qucy5bjJefvQJx0jM+3+XJQUsNo=yg_Ab3VA@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, tom.rini@konsulko.com
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

Hi Simon,

> > > > > In the follow up private discussions about it after it was clear as a
> > > > > whole that the PLC was uncomfortable with a specific websiite (we
> > > > > don't plan on supporting forks, would we provide that feature for all
> > > > > forks?) for concept. I offered the idea of a custodians tree to allow
> > > > > you to develop and maintain the features that you were preparing for
> > > > > upstream in your concept tree to enable easier collaboration for those
> > > > > that wished to work with you on those specific features. Maybe I
> > > > > wasn't clear enough in my communications but it was never intended to
> > > > > be the location to host a fork.
> > > >
> > > > A fork would be something which forks off mainline and goes its
> > > > separate way. Concept is not a fork. Perhaps a constantly merged,
> > > > multi-feature branch would be a better term. Please read my original
> > > > email again on this point and I'm happy to explain it further. Quite a
> > > > few series have already found their way to mainline.
> > > >
> > > > > So I think you need to revist what the idea of concept actually is and
> > > > > come back to the community with an adjusted proposal.
> > > >
> > > > It seems that you are rejecting the whole idea of a Concept tree (my
> > > > original post on this thread). Can you please confirm that? But if you
> > > > have ideas on how it could work with modifications, please share them.
> > > > There must be some common ground somewhere.
> > >
> > > Nope, not at all rejecting it, what I was saying is that I don't
> > > believe you have got the community to buy into your idea. I don't see
> > > it as the PLC's job to reject/accept it, as I've always stated it's a
> > > community decision, of which I am but one voice.
> > >
> > > On ideas I believe I have already shared the idea of working branches
> > > for features you believe should be in mainline U-Boot. Outside of that
> > > I don't have other ideas, but it's also not my concept.
> > >
> > > > > First though, I repeat again, would you please explain to the
> > > > > community why you are holding the u-boot.oirg domain hostage to try
> > > > > and force the PLC to accept an idea that we have been explicit about
> > > > > the need to get the community to buy into this "concept". I think the
> > > > > community deserves an answer.
> > > >
> > > > This is a bit of a one-sided view. The real situation is that for many
> > > > years to implement major features and improvements in U-Boot, but that
> > > > became progressively more difficult as Tom started refusing to accept
> > > > series and I have no ability to get PRs applied. Perhaps I was naive
> > > > to expect our good working relationship would continue forever, but I
> > > > have contributed a huge amount to U-Boot and having the rug pulled out
> > > > felt very unfair, not to say bad for the project. Regarding the
> > >
> > > So that gives you a right to hold the domain hostage why?
> > >
> > > Also your past contributions doesn't give you a free pass to force the
> > > landing of patch series that you think should be in there. That's not
> > > how open source works, it's certainly not how this project works.
> > >
> > > I think you need to step back and ask yourself why you're finding it
> > > hard to get patches reviewed and accepted.
> > >
> > > To give you an idea I have had numerous community members complain to
> > > me about you, I am sure Tom has similar, some are to the point where
> > > the only way they will deal with your code is if it's part of the
> > > subsystems they maintain and hence it ends up in their patchwork queue
> > > and otherwise they actively filter mails out from you so they don't
> > > see them. I don't keep a count or details but it's well over 5 and I
> > > may even have to start using something other than fingers.
> > >
> > > To put in straight forward terms, a lot of people are fed up with your
> > > behaviour, then when you get called out for it, or Tom has to have a
> > > conversation with you about it rather than addressing the actual issue
> > > you "take some time out" and come back a few months later without
> > > actually addressing your behaviour.
> > >
> > > Now you're holding the domain hostage which is similar bad behaviour.
> > > Not to even mention that you registered a US U-Boot charity and
> > > attempted to register the trademark all without telling *ANYONE* in
> > > the community what you were doing. Did you think you could just walk
> > > away and keep the project "Because of all your contributions"? Again,
> > > while you have contributed a lot I think the wider community of
> > > contributors as a whole have contributed more, and by contribute I
> > > don't just mean purely on the lines of code, but reviews,
> > > architectural discussions and all sorts of other things that actually
> > > make a community and it gives you no right of ownership over the
> > > project.
> > >
> > > I'm sorry Simon but the way to get your patches reviewed is to rebuild
> > > your standing with the community not by trying to force an official
> > > recognition of a fork by holding the domain hostage.
>
> Reading this I feel that you have imputed all sorts of motives which
> are not there.

Maybe they're not their from you're perspective, but there's a lot of
questions there for you to answer if it's not actually the case.

> > > > domain, I have offered to point subdomains to anywhere you wish, which
> > > > would resolve this. In the meantime I have mirrored the website and
> > > > moved various things away from the domain. But I cannot support the
> > > > sort of split that happened with Barebox, if that is your goal.
> > >
> > > And as I've stated we can't use it that way, the SFC has requirements
> > > around the project's assets (which include things like domains) as
> > > Neal has explained and I am fairly certain as has the SFC. Also
> > > there's dynamic infrastructure where we need to be able to move things
> > > with little notice so it would cause outages without the control of
> > > the domain.
> > >
> > > > I don't mind hosting a separate tree somewhere else, if that is your
> > > > preference, but it needs to have some relationship with U-Boot and a
> > > > clear understanding of what that relationship is. If that is not
> > > > possible / acceptable, then I suppose we should close this thread. I'm
> > > > skeptical of our ability to resolve complex things on mailing lists in
> > > > cany case, although I started this thread at your request.
> > >
> > > As I've stated numerous times before you need to get the community to
> > > buy into this.
> > >
> > > You have kept this "secret" from the community for a very long time,
> > > and by secret you've not been open about your intentions, until we
> > > explicitly asked you to go and explain it to the community.
>
> Well my hope was that we could make some progress and I did take up
> your suggestion. But it seems to have just resulted in creating more
> disagreement. I'm sure that wasn't your intention, but it seems you
> were genuinely surprised by what I wrote.

Because I was somewhat because it wasn't my understanding from what at
least my intentions from my understanding of what you wanted to do.

> I don't want to suggest that I had a clear idea or plan about any of
> this when I set up my tree, other than trying to figure out a way to
> unblock my efforts. But in writing up this Concept idea I thought it
> would add real value to the project. I still recall that you shot down
> standard boot and that was around the beginning of all this.

I'm not sure what "standard boot" means in this context, that term is
used in a number of contexts in early boot firmware. I think of
standard boot as UEFI, there's also you bootstd and a number of other
options. You would have to provide more context.

But I am ultimately allowed to have an opinion, as are you, and
everyone else in the community, some ideas individuals think are good,
some bad, ultimately the community as a whole will generally end up
with the overwhelming opinion that somethings are good and they
ultimately land as a feature in the project, thinks like DM and UEFI I
think are good examples of that, some ideas don't get that backing and
shouldn't land just because they exist in code, and that is also
alright. Ultimately I would hope that an individual takes their ideas
to the community sooner rather than later before the individual does a
large amount of work so as to not invest large amounts of time in
something that the community isn't bought into.

Peter
