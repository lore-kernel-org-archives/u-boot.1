Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3907CC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED3B80F0B;
	Sat, 15 Feb 2025 18:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XuxA7q2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 812D580F10; Sat, 15 Feb 2025 18:25:06 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3399A80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so577408266b.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640303; x=1740245103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duYdM7u2xBJR/ndMeOZ52jlX2EPfxtWiwjV3BEfe+9Y=;
 b=XuxA7q2sq5g3JBT17nlNpqf6V0lrlkwUxM53eTzt83IEO0sOPLYRgDqcKZetF0b2lx
 w8yQ/WjPnPUPAb9Qla28fVbnzWxC4eP/BDAZN3yG9pEaupl4tUtYh4MCEG+29WA/FzUj
 WwIlNxuQPn5KcTGnIuBTYDd/tw/nYTGco9W6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640303; x=1740245103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duYdM7u2xBJR/ndMeOZ52jlX2EPfxtWiwjV3BEfe+9Y=;
 b=l+5IySuK7Zntjkx34mD9pzUMt4s97sMZdFumr3ecTYRg8RfbUE6+UzSecB7q79y+lh
 +nU8YMuM24hBXpGNWlCvcCRYpAlcABIdoEt9RvGa9uC6UZkk+0yNYhdLkuxeV9rmE/av
 Vji9m2Hy3X5+ID99msxCQBP3IzS4LjuEU250+eoWCVzCan5C+gKPCoYPuIH/Zl5UZjir
 uDBg8iFgh7cMEg0Svp2kNn9OpCeeTYb2Fe7ouT1P7wLBGfu/RW6veSFoDAZQ/W0wRo93
 ZinqnrVNd5mZNORaBtP2YVw8syTaDUKjWYmhuRsDDWh2pJNDnrX3DwfAH6aYzMn/D3TZ
 M9Ag==
X-Gm-Message-State: AOJu0Yzy4H0fqZy9wyz5hbLYnEDKfxhYvyOMh4Q6ytAQZyKpAhYVKzE2
 W3v65HI9ElRcDun1rIPOvEV0YG226h5/+0NUyPD/kDihcdVFrOobDCkJI9wSTCcL2klPhu9U2Jd
 RBZC3zhRFCMNZvsVxQSPnceibhB+orNWLK7FdZL08TFso+n8=
X-Gm-Gg: ASbGncvrYeJqppvzZ7Ws+FvK6U7ymQ40bikj2kii56lEAfOZtZpHHP5v6K/xi7WUnFZ
 YOUnzbS9kTf5oTiHtk1j+lPRnuT3JVtmCchQ8s374AYzWLfWy5n1hZa6S7iPo6bTjMZmMCp86GA
 ==
X-Google-Smtp-Source: AGHT+IGHACOr9aoT9aAYoHyisUIR/38nEJITgOwF33jZZzVURn6gtfZLG5VotiHVj6JGshFiW9cY00Yf35E/Hoa3fJY=
X-Received: by 2002:a17:907:9692:b0:ab7:bc36:f4ad with SMTP id
 a640c23a62f3a-aba50feca36mr1012101966b.16.1739640303594; Sat, 15 Feb 2025
 09:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
In-Reply-To: <20250215150116.GS1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:24:50 -0700
X-Gm-Features: AWEUYZnMNXjpk9SNsd6g-htKOOfHv35HQ8FSVdaK3xrVDJLGC0Ir69psU9wlZOA
Message-ID: <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > The logic of this has become too confusing.
> > > > > > >
> > > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > > phases can then use that bloblist.
> > > > > > >
> > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > >
> > > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > > things working for all use-cases.
> > > > > > >
> > > > > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > > > > a revert is the easiest path.
> > > > > > >
> > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > >
> > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > > >  include/bloblist.h | 10 --------
> > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > >
> > > > > > We aren't reverting this change so if you plan to move this series out of
> > > > > > your downstream fork you should start from that and stop posting it,
> > > > > > that just leads to confusion.
> > > > >
> > > > > Who is 'we', and start from what?
> > > >
> > > > We, being the community, in here, the community mainline U-Boot project
> > > > tree.
> > > >
> > > > > My goal with this series is to have something that actually boots on a
> > > > > real board, so the bloblist changes are needed for that, particularly
> > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > deliberately put these two patches at the end of the series so you can
> > > > > ignore them if you'd like.
> > > > >
> > > > > But for now, as I understand it, there are no users of standard
> > > > > passage in tree, so actually it would be fine to apply them.
> > > >
> > > > And you can ignore all the feedback you like for your downstream fork,
> > > > sure.
> > > >
> > > > Part of the feedback in this series already was "Yes, we can clean this
> > > > up a bit more if bloblist will do its own thing instead".
> > >
> > > So I see that Raymond's patch is a significant rewrite of what is
> > > there today, with multiple aims and changes. I would rather add my
> > > revert and start from a cleaner place.
> >
> > Also, I forgot to mention that U-Boot doesn't seem to support the
> > firmware handoff protocol in SPL? If so, could you point me to the
> > code?
>
> Yes, you never implemented handoff between stages in U-Boot via
> register. That's not a use case for the platforms that don't use U-Boot
> for SPL.

If you let me own bloblist, I'll own it, but for now I am staying away.

Regards,
Simon
