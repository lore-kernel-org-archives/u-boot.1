Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF92CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 15:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CE58486D;
	Tue,  9 Jun 2026 17:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HS7NHXyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07D984894; Tue,  9 Jun 2026 17:33:42 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400E88466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 17:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so9492291a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 08:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019220; cv=none;
 d=google.com; s=arc-20240605;
 b=B1KOUMxRBvLhoLS24RJtBGDsaKWTMEYhCu2fPFtMeufVSPEgLou+AyVkqSIky1ByWx
 ZN570wonOpLiEmWyIXmye0vuGJZpIEO3/42Aw26WQ8zaqKyZlhrlLFVx54Gn78BZVaTh
 GUg8znjOzqUh+Baglkh+5BzRAdChywc0NzpYWNV84Y7nV960myact7ChJqFP30Dnmrj+
 Nc6oRUt+iwKryyCiJNaiCy/XTeZxtoaQu7hlxIR0iUSxmrUu6nMYvEbI/UuL4M0s2WXT
 xpLngYs5E/IuMvqzFohJhwuNycNBnZQwW0mTlXhx08ODPtT61SxiON2U5qkivvicJ1se
 mVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m9jF6FzjjTCEE6ZPs7kvf3cngCJJAFFDMJxEcDVjixs=;
 fh=U1QJJtF9Jr5DOtmWDaHm5WEM7IuMpvyjxQ4jIqbYIZA=;
 b=EPMpe3XUnRlbM0K98r0VIRUAElS9WQjye7WKtMKm8OutPWBjBhxOZURwO2PlkA7ade
 vO9WGMjX3Jp5uVn11dfcsStVDLqlW1WBaZTPIBwMSnd2rN9Dc1pn2lq05Tw9AwAAvpXz
 TJydjruRc+m0jRjmu8qNJ4zm0hxxunSzpMR7k1Z4vuqVw1ZGvjg2iOmg76jVeMdBes4t
 AsQAqn7TddQ/YzgtAQl5ZsChJgSnRm6U+6OW7cOvy/gWiwP/zpNN0CAQtpZ3o6+ViBbu
 GiE8JHQUANr1PojW+mtxcJZqVW6025VfCo3S4PRhG3f0K8hADR6G1/ZQT/N214TLK6j7
 Q17A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781019220; x=1781624020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m9jF6FzjjTCEE6ZPs7kvf3cngCJJAFFDMJxEcDVjixs=;
 b=HS7NHXylQFetqkjU8m7oNLWbx8UXIEw1fQD0xD0XkAPrAM9Ky+Gun6q4Q8a6+mXjZk
 qjTEYcLLRI2FuFA8pyKvUVC1X0tu2iJnm4zJSe6OmixuMkEpi90GbMqSakzmYXr5IZlP
 hZDiF4imleUxWZm5+Wbo9uXxZo+5yVIJWt/OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019220; x=1781624020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9jF6FzjjTCEE6ZPs7kvf3cngCJJAFFDMJxEcDVjixs=;
 b=Cnb/FQbPh8QIPxLA04uPZQVqMEGp/cg3rtleTpCh0Qu07E124vkZ1DvuhmM+fA8q9q
 FtquuS2Dtv0+0boL9mTcF6GLsvKRqS0Ufd//tJBymYfe+EfmhydwJbdzukuAL1gfQ3Rt
 vBrYMw0ZiH+m+cH802lDb3oxLW6fr2KYV+z/ROxuXL4Wf6H3YlSP6xvPfg0RUHC2CV0z
 XmdzmXdcRTad6pHnmqNuqWjOuzHbpTZvRdJ8DJxD6I8AeMJEdiVCN9aYafuAhjXw5Oqo
 9J8H1nyQuLcGf1cqk2x3kikLlgS/iooN4jdh3FuohouErq+pXWylj69nrfNpZjlC2m+i
 3rGg==
X-Gm-Message-State: AOJu0Ywn/VtCcUZNB4AN0BZ0BDGPk642lfLjVL2iIIpk3iERzmH17MLr
 kAkGQN0AXeOE5TbCaq3zZcn7SD9Fb8tbFkI5WjWO/Vf5ROCz8jaqLCR/yNE54WSdbtKMI2OIAU9
 /VZ1UG6j0etbM8ggzV/cQlp1lY7EstHqCL0XjOAtm
X-Gm-Gg: Acq92OHCkee2a+OqAwqi9gbOggnxl+aiBrAlutNKT1cudyIJrClSl8LtQKv4JDZX706
 arTlSxewpwggsCwnXP4gRBFcB7ABHArVHi7dbnJv4grUWqnmswLnap85Wutj5vIYovSKPGGU8sT
 XU4ybZ5pdSzsm0tRSnGAaGFZQKu2c33alE9DhS7S1CI/DF28GImxs9P/0214urt/9J35+/Rzji1
 eQvil1fb/JuHw+a5tcV9SuUmttXj0Qa3AFepUgOA9oA1eJrov+Dd0vRyOkAybdCdpYP777IcC8V
 +JbkBhKDE3t4ezf8lnVVIUI4GK8=
X-Received: by 2002:a17:907:989:b0:bed:25a6:1c89 with SMTP id
 a640c23a62f3a-bf373407e0amr1082998866b.25.1781019219376; Tue, 09 Jun 2026
 08:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
 <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
 <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
 <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
In-Reply-To: <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 9 Jun 2026 09:33:26 -0600
X-Gm-Features: AVVi8Cc6fG32syE8MudCC5CxIAI2ySNjOZjRxi2os3q3cHS33Uo5pR25hknHepw
Message-ID: <CAFLszTgcmUN8cbVjwrX0+fmH=gL5ufSXV46H_qsXWvWvHD3TgA@mail.gmail.com>
Subject: Re: Binman with Qualcomm
To: Casey Connolly <casey.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>
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

Hi Casey,

On Tue, 9 Jun 2026 at 06:10, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 09/06/2026 01:31, Simon Glass wrote:
> > Hi Casey,
> >
> > On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.org> wrote:
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
> >> I wrote a whole big reply here but then I realised it was not likely to
> >> be productive, so I'll keep it short and sweet.
> >>
> >> For binman to make any sense to me, it would be a very simple frontend
> >> and library for vendor/board specific image processing. Configuration
> >> would be static and defined in the Python scripts, dynamic configuration
> >> is huge scope creep.
> >>
> >> If that's all binman was, and it was co-maintained and used by other
> >> custodians then I would definitely see the value in using it to avoid
> >> dealing with makefile fragments and other nonsense.
> >>
> >> Instead, it is a massive and overbearing "feature" that does stupid
> >> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
> >> (which crashed for me btw). The moment I try to use a tool for
> >> post-processing and it changes U-Boots runtime behaviour like this I am
> >> fully out. Choosing to design and implement something as overbearing as
> >> binman is just absurd, it prescribes a lot of functionality that I do
> >> not want or need. I'm just not willing to invest so much time figuring
> >> out how it works so I can fix it if it breaks something for my boards.
> >>
> >> As-is it seems much more appropriate to stay within my means and ensure
> >> that I feel confident that I can maintain whatever Qualcomm-specific
> >> tooling we have. Vendoring a Python tool and making a tiny wrapper for
> >> it is just the plainly obvious solution, I know exactly how it works, I
> >> can fix it if it breaks, and it doesn't fuck with my U-Boot image or dtb.
> >>
> >> That you are so clouded by your own perspective that you feel the need
> >> to email me on the list to ask about problems with binman as if I
> >> haven't already expressed myself clearly both in my mkmbn series and on
> >> irc (and as if comparing my patches doesn't reveal the issues) makes it
> >> quite clear that I'm much better off keeping CONFIG_BINMAN=n
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
>
> Did you really just put my email through an LLM?

I copied my full reply (including your context) into Claude along with
some patchwork threads to make sure I had not missed any points you
raised in patchwork. It gave various suggestions which I think helped
avoid my bias creeping in and to improve the tone. I don't mind
avoiding that with your emails in future.

I suspect Gmail also highlighted various sections and I accepted some
of those changes too...in fact there are four suggestions in these two
paragraphs right now.

>
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
>
> Well this is what it all comes down to I suppose. I have nothing against
> having a common framework, it just shouldn't be so opinionated on things
> that really aren't related to image processing.

Do you have any thoughts about improving / resolving the points above?
For example, you mentioned at one point that it should use yaml rather
than device tree. Perhaps we can discuss it on one of the calls, if
that is easier?

- Simon

>
> >
> > I would be happy to take a look at this to see if I can figure out
> > these issues. Most SoCs that have moved to Binman have needed at least
> > some additions and changes in the tool and I don't mind digging into
> > the issues you have and coming up with proposals / solutions.
> >
> > Regards,
> > Simon
> >
> >>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
> >>> [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/
> >
> > [3] https://www.youtube.com/watch?v=L84ujgUXBOQ
>
> --
> // Casey (she/her)
>
