Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A02CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1103C84704;
	Tue,  9 Jun 2026 14:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="alwEaXAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD618484C; Tue,  9 Jun 2026 14:33:59 +0200 (CEST)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch
 [79.135.106.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA6D846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781008435; x=1781267635;
 bh=wcTjahWeaE15rK43qb4yngrN2O3peFXTAPp1REl9D5I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=alwEaXAyKn56MgeZJBmduvjrE9jd/cLnH/s4o07xGpMODGh5wsgCUGWIxWHEOzZK7
 kzDVLWKbVu8XOlUT/XZmYaJt7GTz4AVseImaTARzSU/oadOqYudUpgECuigf4cQSj2
 cMcur7WHf80zZjI14nj9v4ZzAi73EmGmTz0Jv5bqcABgYF0BTiMVU+c7ak/GVbeYQQ
 pov7qe61Wpda9+DLF6opTs3E26VNtzzhLFLr0km8e8DbYYwSGvJWSeUNeEzHqGXgT4
 n+xWSQmId0hfbW0OyjxxSxU0SOdtY3N+4IVdbZdwfIJ2vmBpcSC0HEciLmFKHUN9D2
 Mk9Og+beCRuow==
Date: Tue, 09 Jun 2026 12:33:50 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: Binman with Qualcomm
Message-ID: <fBFdR32iMUBnz1xt4ThcZauDJSvuuDHGxDM160ek7-UCIG77hsz0xK9HKeW3kMgiQUJiYPUEuz9MeldVw_03Mg6iyvTrRheaf5oF-mIo1hs=@samcday.com>
In-Reply-To: <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
 <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
 <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
 <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 012c9df389e5d2eafb26f9a91d8710b959cc9e54
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Casey,

On Tuesday, 9 June 2026 at 10:10 PM, Casey Connolly <casey.connolly@linaro.=
org> wrote:

> Hi Simon,
>=20
> On 09/06/2026 01:31, Simon Glass wrote:
> > Hi Casey,
> >
> > On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.org>=
 wrote:
> >>
> >> Hi Simon,
> >>
> >> On 08/06/2026 19:13, Simon Glass wrote:
> >>> Hi,
> >>>
> >>> I want to start a new thread to work through the issues which result
> >>> in later versions of [1] moving to custom build rules instead of
> >>> Binman.
> >>>
> >>> From what I understand there are some things unique to Qualcomm here,
> >>> as well as some general comments [2]
> >>>
> >>> Let's first get a list of the problems and then we can look at
> >>> possible solutions.
> >>
> >> I wrote a whole big reply here but then I realised it was not likely t=
o
> >> be productive, so I'll keep it short and sweet.
> >>
> >> For binman to make any sense to me, it would be a very simple frontend
> >> and library for vendor/board specific image processing. Configuration
> >> would be static and defined in the Python scripts, dynamic configurati=
on
> >> is huge scope creep.
> >>
> >> If that's all binman was, and it was co-maintained and used by other
> >> custodians then I would definitely see the value in using it to avoid
> >> dealing with makefile fragments and other nonsense.
> >>
> >> Instead, it is a massive and overbearing "feature" that does stupid
> >> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
> >> (which crashed for me btw). The moment I try to use a tool for
> >> post-processing and it changes U-Boots runtime behaviour like this I a=
m
> >> fully out. Choosing to design and implement something as overbearing a=
s
> >> binman is just absurd, it prescribes a lot of functionality that I do
> >> not want or need. I'm just not willing to invest so much time figuring
> >> out how it works so I can fix it if it breaks something for my boards.
> >>
> >> As-is it seems much more appropriate to stay within my means and ensur=
e
> >> that I feel confident that I can maintain whatever Qualcomm-specific
> >> tooling we have. Vendoring a Python tool and making a tiny wrapper for
> >> it is just the plainly obvious solution, I know exactly how it works, =
I
> >> can fix it if it breaks, and it doesn't fuck with my U-Boot image or d=
tb.
> >>
> >> That you are so clouded by your own perspective that you feel the need
> >> to email me on the list to ask about problems with binman as if I
> >> haven't already expressed myself clearly both in my mkmbn series and o=
n
> >> irc (and as if comparing my patches doesn't reveal the issues) makes i=
t
> >> quite clear that I'm much better off keeping CONFIG_BINMAN=3Dn
> >
> > Thanks for the candid response - I'd genuinely rather have the blunt
> > version than a polite one that leaves the real objections unsaid.
> >
> > Starting a fresh thread wasn't meant to suggest you haven't already
> > explained yourself; it was to give the topic enough focus to actually
> > resolve it, rather than have it scattered across review comments and
> > IRC. I've read the mkmbn series and I want to make sure I've
> > understood the concerns correctly, so let me write them back to you as
> > a problem list and you can tell me where I've got it wrong:
> >
> > 1. Binman is too large and prescriptive - what you want is a thin
> > frontend/library, with configuration defined statically in Python
> > rather than driven dynamically from the DT.
> > 2. It modifies the board DTB, which you don't want it touching.
> > 3. It adds code to the U-Boot image that changes runtime behaviour -
> > and it crashed for you.
> > 4. The maintenance cost is unacceptable: you can't be confident you
> > can fix it yourself when it breaks one of your boards.
> > 5. A vendored Python script with a small wrapper gives you full
> > understanding and control, which a shared tool doesn't.
>=20
> Did you really just put my email through an LLM?

Why are you jumping to this conclusion? I read Simon's response and didn't =
get
LLM vibes from it...

Also, FWIW, point 5 seems like it has grammatical errors (though I am no
English lit major!). Dunno if a machine would generate such a sentence.

But anyway, more importantly, what parts of Simon's summary, LLM-generated =
or no,
do you agree or disagree with?

I read Simon's distillation of your feedback to date, and found it to be
quite succinct and reasonable.

Whether you agree with the existence and/or usage of LLMs isn't really rele=
vant
here, is it? Simon began this thread attempting to solicit your concerns wi=
th
binman so that we can connect that to tangible follow-up actions. Could we
please focus on that?

Thanks,
-Sam

>=20
> >
> > The runtime crash is the one I most want details on. Binman's runtime
> > support (reading its tables from the FDT) is optional and shouldn't be
> > pulled in for a board that doesn't ask for it - if it was, that's a
> > bug I want to find. Are you sure you have CONFIG_BINMAN_FDT disabled?
> >
> > Perhaps Qualcomm's images are so simple that it isn't worth using
> > Binman. That was the view I took when I saw that you were just
> > creating an extra binary. But then I see Sam's series and I wonder
> > whether there is more to this?
> >
> > There is considerable value in having all boards use the same
> > image-creation framework. The data-driver approach is much easier to
> > configure and understand. See [3] for a talk on why Binman helps.
>=20
> Well this is what it all comes down to I suppose. I have nothing against
> having a common framework, it just shouldn't be so opinionated on things
> that really aren't related to image processing.
>=20
> >
> > I would be happy to take a look at this to see if I can figure out
> > these issues. Most SoCs that have moved to Binman have needed at least
> > some additions and changes in the tool and I don't mind digging into
> > the issues you have and coming up with proposals / solutions.
> >
> > Regards,
> > Simon
> >
> >>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom=
-tooling-improvements-v5-2-df143f1247fc@linaro.org/
> >>> [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom=
-tooling-improvements-v3-0-76f34cf216e2@linaro.org/
> >
> > [3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ
>=20
> --
> // Casey (she/her)
>=20
> 
