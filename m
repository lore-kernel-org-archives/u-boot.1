Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50A0CD8CA7
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 23:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060438466E;
	Tue,  9 Jun 2026 01:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L4IcKTTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A74847B0; Tue,  9 Jun 2026 01:31:17 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B9F83FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 01:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68ca6f01079so5795475a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 16:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780961475; cv=none;
 d=google.com; s=arc-20240605;
 b=ZjB/uzjbLp5hZFwzq9FcywscV3dQtPBXP/Grr0yu1OKZxC9thJKGSMSSKD11WtLxO2
 yeo/Lly8qJPLX9Us2Q2LwSZlnDAwqyQL79hYZrcq2KqeWt9e2r8ftaJ9P4TX4G3kGp9z
 dj9w1iIrJ+tZn0qw9SzsJJ4tbhjQzb6RMtfQbrd0DZzl1MfF0/lPsdsYVse++7Z9jr9o
 yi3JL0quVkBqSpNEdbw5KlwUYqgXaQSBEYWpbBUhtNMagnTzq5tEVHwHbvOZ/Ki6u/s9
 YE54AjpW/uEQxZ6pHD98S/M7ynodRQ2ScEvLGxo80ArDsqLqjqCrpJwqumoDgIgcLPVo
 XStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DtBYDf4CruzwXifjlcfZ/51Bt3WY/IKuODtXk3kMiwY=;
 fh=U1QJJtF9Jr5DOtmWDaHm5WEM7IuMpvyjxQ4jIqbYIZA=;
 b=UlZettYxbKSfkZqVv8SS4qFRkkGGs9QD1azW6J+f9sba0O8qx4teUVTwHxj+EWHGSz
 9uzBqGDwcqjuLhEQMkAWWcgzWLF8aR/Oy31oXghU4aQQVegwOJPnyxlIp+jqMNqK2jxd
 6TmwDGQ0Ci0jW4/OBDmquh6I1+avg2G6CTmIhqKvb/C+CRDS5r4DCzqds2StnKyoeq/C
 y/+bEi15IuhcX5z5C2JUbXYz7cDRdpNZHHcRXvRD2hWOfN0lptcqA3oO1CJy+tOcH3KN
 /mroU+ijrlEAMCG15cJZY3Q1XxskuacsrU7YZjqYTmrAuAEk9zHVRWiQ4YH+8a1DYfJO
 09Nw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780961475; x=1781566275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DtBYDf4CruzwXifjlcfZ/51Bt3WY/IKuODtXk3kMiwY=;
 b=L4IcKTTYREecuFbvbeQnn6b9c//Bk/WMT5Q++6FTX/vDQLDW5pVaGG/F9g2jmXz6HH
 p3d4NVuA4hwt6HxLIbZwQb6n1KhYda9AhF9ZFH1kz1l9hyWdsBNXpfHM3xpBNnO5X5aZ
 jrj3NmhiIyr/J53dHMz7hZ1/o7D1u9X5zkMms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780961475; x=1781566275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtBYDf4CruzwXifjlcfZ/51Bt3WY/IKuODtXk3kMiwY=;
 b=S3D71I6RtlGfmY8sIEeoTX4oSbWlVNapSB2YXQBNCDohhHwsKN8NkdtRdUVGKRINTg
 vfVcVbc5T6kFCFs0T6AJbh5n1YCko+qm/Ox+qKEO3a1y+PbGFonBlggax7hQlD+acnEW
 IUPnkSw3m2ZNMJE+x57lCOegnQOz9vWpM3Y6IVxBLXnHrzarhDsfMCUNEiX0k31iBb0n
 eidHx2IuD3udO47pq5mFS/b6nx+t91qaIhyVmju+DCkjDzCETh1I3DIUqC6Uj+BcL/Eq
 jJHMf998FlYLe5SuW8FwoMojD5Oe/1D6LQzavQpjT2idZcacVfEh1q9RDfHZR5YYBoJr
 Hc0A==
X-Gm-Message-State: AOJu0YyQtPjscPGW9vxst6ElujSiboqa/KtSKpwplTDiWKs5gcCqcqIV
 SE4sVstNDIKoho/z8mXXziUUMyq/OjCMuE6oVTr4+9567mQdRo2zG5gHdUagEtsehVaLavnjuNu
 roshwWlQmZhAn/X2unvzNlQsEWQ8KrfjdcO+xATVUYPq1O+Ju09DCZQ==
X-Gm-Gg: Acq92OHsml2p53m7pUOqJSO03UatAmD5ClHcttsC+N413XPcuexr/Kpg1PMiM+tzL7s
 NJc9fCO0rTumB2PfSkOlBSiLQ6pfHizH/NgR1z+dkTzyJahOHqPAT3pf31Z0+ksn0sOhlQ5KD1L
 Hh1Ov9b5RNvRvND9iW6Fb6caj3WIz9pgT/8LIH8QSb2+s7V+iH48Mo9dLf2CSAm97qgHP2XFSiT
 lp9KdtOvoKBwm/eWFdPbSlwmfnY5ZjtHj+ygwVVu24gNGxO5zj3jEjAkZ7CvuYhA8l7hUGKsNAp
 wUntNd4ZLuFlOMyE
X-Received: by 2002:a05:6402:a508:10b0:68d:9272:d0a8 with SMTP id
 4fb4d7f45d1cf-68fa5035b36mr5108920a12.13.1780961474520; Mon, 08 Jun 2026
 16:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
 <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
In-Reply-To: <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 17:31:02 -0600
X-Gm-Features: AVVi8CfE0SF3ZG285wiZCE0UfI7dqN209ZXnyC6A6FNEqslQA6SiQxmCy3X-g4w
Message-ID: <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
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

On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 08/06/2026 19:13, Simon Glass wrote:
> > Hi,
> >
> > I want to start a new thread to work through the issues which result
> > in later versions of [1] moving to custom build rules instead of
> > Binman.
> >
> > From what I understand there are some things unique to Qualcomm here,
> > as well as some general comments [2]
> >
> > Let's first get a list of the problems and then we can look at
> > possible solutions.
>
> I wrote a whole big reply here but then I realised it was not likely to
> be productive, so I'll keep it short and sweet.
>
> For binman to make any sense to me, it would be a very simple frontend
> and library for vendor/board specific image processing. Configuration
> would be static and defined in the Python scripts, dynamic configuration
> is huge scope creep.
>
> If that's all binman was, and it was co-maintained and used by other
> custodians then I would definitely see the value in using it to avoid
> dealing with makefile fragments and other nonsense.
>
> Instead, it is a massive and overbearing "feature" that does stupid
> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
> (which crashed for me btw). The moment I try to use a tool for
> post-processing and it changes U-Boots runtime behaviour like this I am
> fully out. Choosing to design and implement something as overbearing as
> binman is just absurd, it prescribes a lot of functionality that I do
> not want or need. I'm just not willing to invest so much time figuring
> out how it works so I can fix it if it breaks something for my boards.
>
> As-is it seems much more appropriate to stay within my means and ensure
> that I feel confident that I can maintain whatever Qualcomm-specific
> tooling we have. Vendoring a Python tool and making a tiny wrapper for
> it is just the plainly obvious solution, I know exactly how it works, I
> can fix it if it breaks, and it doesn't fuck with my U-Boot image or dtb.
>
> That you are so clouded by your own perspective that you feel the need
> to email me on the list to ask about problems with binman as if I
> haven't already expressed myself clearly both in my mkmbn series and on
> irc (and as if comparing my patches doesn't reveal the issues) makes it
> quite clear that I'm much better off keeping CONFIG_BINMAN=n

Thanks for the candid response - I'd genuinely rather have the blunt
version than a polite one that leaves the real objections unsaid.

Starting a fresh thread wasn't meant to suggest you haven't already
explained yourself; it was to give the topic enough focus to actually
resolve it, rather than have it scattered across review comments and
IRC. I've read the mkmbn series and I want to make sure I've
understood the concerns correctly, so let me write them back to you as
a problem list and you can tell me where I've got it wrong:

1. Binman is too large and prescriptive - what you want is a thin
frontend/library, with configuration defined statically in Python
rather than driven dynamically from the DT.
2. It modifies the board DTB, which you don't want it touching.
3. It adds code to the U-Boot image that changes runtime behaviour -
and it crashed for you.
4. The maintenance cost is unacceptable: you can't be confident you
can fix it yourself when it breaks one of your boards.
5. A vendored Python script with a small wrapper gives you full
understanding and control, which a shared tool doesn't.

The runtime crash is the one I most want details on. Binman's runtime
support (reading its tables from the FDT) is optional and shouldn't be
pulled in for a board that doesn't ask for it - if it was, that's a
bug I want to find. Are you sure you have CONFIG_BINMAN_FDT disabled?

Perhaps Qualcomm's images are so simple that it isn't worth using
Binman. That was the view I took when I saw that you were just
creating an extra binary. But then I see Sam's series and I wonder
whether there is more to this?

There is considerable value in having all boards use the same
image-creation framework. The data-driver approach is much easier to
configure and understand. See [3] for a talk on why Binman helps.

I would be happy to take a look at this to see if I can figure out
these issues. Most SoCs that have moved to Binman have needed at least
some additions and changes in the tool and I don't mind digging into
the issues you have and coming up with proposals / solutions.

Regards,
Simon

> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
> > [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/

[3] https://www.youtube.com/watch?v=L84ujgUXBOQ
