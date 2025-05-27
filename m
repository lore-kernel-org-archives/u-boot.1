Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D329CC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A88983046;
	Tue, 27 May 2025 14:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dGckL4dI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3037C8304F; Tue, 27 May 2025 14:05:02 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07C78301F
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad8826c05f2so243380966b.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748347499; x=1748952299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ojbzc0weJ6rPToVb9THvkXFnSyNhJb0z0P5xUeSGcgg=;
 b=dGckL4dIGAepjcq+vL8SsRbrGeHW4icgO3ctSexcqTuy47SJLuE5V5GoH0JFhC6Q6y
 fN/RREmtVCGSvYL7jJhZae7skGfSfLLSqg+QD8yNX2wALLXB5d/cnpp3EKzFueA4e2SM
 7QTCdtCCTGxpmcBqQuLP2f6gGCNzFjJPik948=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748347499; x=1748952299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ojbzc0weJ6rPToVb9THvkXFnSyNhJb0z0P5xUeSGcgg=;
 b=YcJ/H7/GbBZ6cG3xq0MvLaYgxcMV6maVe9lAvSk+qe1ctjByxu4IBLHbiLm2dyUfDj
 Wkw042JFFRsHt/2akb4F7xhsA+CwcjlhGIpRMaukDgbg2ehjSmz+yrKCl0UwApB3C0yv
 IN8fJ//XkUQX91p58nVTPf5mXZmOU/QB8RnvHmobeF60jcC/d7qkupRKRPEughmKse0d
 JX0Dky0Bn0GeJFsA2+Pxs+F4dLxe+vJiVzNd0tZUOgpUdlauEyeRW2gMqCNaB2fqqei5
 EJvpBCOg1/5KV5AHRUPtuoQ/M7AelZawqHcEsxeSnAiq2REafrdZVy4tplX/XVylu+qr
 QbEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV234gk1V2v/32J5Q/56m+f2WPa1esdGOwln7/Cw1QtFq1E4LguArNDgHiCNbrQ0EUyQvJGYjE=@lists.denx.de
X-Gm-Message-State: AOJu0YwPfm7xq/lEjj0dBCt7vwOjHG190b+ai55ZH6vTJz79bTmFOlaM
 kSVcDhTSFBSqPwpqs2q69XrquFSF7mG/INxza5iq2GgByIYRMJuYYcJ9pD3Skrp/sTmNQccqwCZ
 mn+j27Z8iOy9EspQNPcHoNQ+nPEOTFHjI+WBvzhwx
X-Gm-Gg: ASbGncvD8UXl0Vjv2qvCt6aP6RrMzoaMnfB2qfNPUHB1Inr1GSVoZACZ0/HkG2W2GBN
 +8CtGk1TmbpH9fy3I3MgmpPXT4+x5cxXqX2HfSNhRKM9KqPbvtXPD1B9gVnn8usw0HPEDIMi7IW
 eJLgz7OZ67SAhCHI/4+MEy3kpRRsAJvLU=
X-Google-Smtp-Source: AGHT+IEB7VyncAtddusDfikjYyCqEJ9uV0zMi3LaWhZ8LUC/bZ1zKoBUR4rSSpG/q+2adLtx8kr3xZmYv6AdjYsjjOs=
X-Received: by 2002:a17:907:26c9:b0:ad2:52c3:2083 with SMTP id
 a640c23a62f3a-ad85b0fa46dmr1051716166b.28.1748347499244; Tue, 27 May 2025
 05:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
 <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
 <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
 <CAFLszTg0UXfcsy8-A9QMq5CSsAvAXHLKRBpHyzdNuwdj17VwKQ@mail.gmail.com>
 <150cc82d61583d092aed27ce043c6316b093a13a.camel@phytec.de>
 <CAFLszTinxMvBiz8sWC8+qEiHUHXX6LFgw1FnC8kNY1DMG8AF9g@mail.gmail.com>
 <CAFLszThotL8ufW-qkc2Eo3ooyf7MMHFfr_OB-H6u7kV3BTt4Jw@mail.gmail.com>
 <e9cb52aa883c5f2372084fcf4c1c06ea23fe47de.camel@phytec.de>
In-Reply-To: <e9cb52aa883c5f2372084fcf4c1c06ea23fe47de.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 13:04:45 +0100
X-Gm-Features: AX0GCFsszGn6sQjKvx9TOhD28pDn_PWf6eygTCY0R6QmtlTj0buJBM1xlVkHvW8
Message-ID: <CAFLszTj2-=hZ=cBO8Yi58cueM_XMxsZ8ty0R=qZ_hJF=DC9A2A@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, 
 Yashwanth Varakala <Y.Varakala@phytec.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>
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

Hi Yannic,

On Tue, 27 May 2025 at 09:12, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> Hi Simon,
>
> Am Dienstag, dem 27.05.2025 um 08:34 +0100 schrieb Simon Glass:
> > Hi Yannic,
> >
> > On Wed, 19 Feb 2025 at 00:01, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Yannic,
> > >
> > > On Tue, 18 Feb 2025 at 06:15, Yannic Moog <Y.Moog@phytec.de> wrote:
> > > >
> > > > On Mon, 2025-02-17 at 06:13 -0700, Simon Glass wrote:
> > > > > Hi Yannic,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Fri, 2025-02-14 at 06:48 -0700, Simon Glass wrote:
> > > > > > > Hi Yannic,
> > > > > > >
> > > > > > > On Fri, 14 Feb 2025 at 00:05, Yannic Moog <Y.Moog@phytec.de>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > On Thu, 2025-02-13 at 07:01 -0700, Simon Glass wrote:
> > > > > > > > > Hi Yannic,
> > > > > > > > >
> > > > > > > > > On Thu, 13 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de>
> > > > > > > > > wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 2025-02-10 at 06:08 -0700, Simon Glass wrote:
> > > > > > > > > > > On Wed, 29 Jan 2025 at 03:30, Yannic Moog
> > > > > > > > > > > <y.moog@phytec.de> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > The binman documentation of Optional entries is not
> > > > > > > > > > > > accurate in the
> > > > > > > > > > > > sense that it does not cover blobs entry type. As this
> > > > > > > > > > > > is also the most
> > > > > > > > > > > > widely used type to have the optional entry, document
> > > > > > > > > > > > the interaction
> > > > > > > > > > > > with faking blobs.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  tools/binman/binman.rst | 9 ++++++++-
> > > > > > > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/tools/binman/binman.rst
> > > > > > > > > > > > b/tools/binman/binman.rst
> > > > > > > > > > > > index 990fc295770..2bafa6ca408 100644
> > > > > > > > > > > > --- a/tools/binman/binman.rst
> > > > > > > > > > > > +++ b/tools/binman/binman.rst
> > > > > > > > > > > > @@ -1145,7 +1145,14 @@ called on all entries.
> > > > > > > > > > > >  It is not possible for an entry to mark itself absent
> > > > > > > > > > > > at any other point in the
> > > > > > > > > > > >  processing. It must happen in the ObtainContents()
> > > > > > > > > > > > method.
> > > > > > > > > > > >
> > > > > > > > > > > > -The effect is as if the entry had never been present
> > > > > > > > > > > > at all, since the image
> > > > > > > > > > > > +The effect depends on the type of entry.
> > > > > > > > > > > > +
> > > > > > > > > > > > +Blobs
> > > > > > > > > > > > +~~~~~
> > > > > > > > > > > > +For blobs, the effect depends on whether --fake-ext-
> > > > > > > > > > > > blobs is passed
> > > > > > > > > > > > +to binman. (This is the case by default)
> > > > > > > > > > > > +In case --fake-ext-blobs is set, any missing entries
> > > > > > > > > > > > will be faked.
> > > > > > > > > > > > +If not set, it is as if the entry had never been
> > > > > > > > > > > > present at all, since the image
> > > > > > > > > > > >  is packed without it and it disappears from the list
> > > > > > > > > > > > of entries.
> > > > > > > > > > >
> > > > > > > > > > > I'm not quite following this. The text seems OK but your
> > > > > > > > > > > heading
> > > > > > > > > > > implies that things other than blobs can be faked. All of
> > > > > > > > > > > this
> > > > > > > > > > > functionality is only for blobs.
> > > > > > > > > >
> > > > > > > > > > The heading is a subsection of "Optional entries". To my
> > > > > > > > > > knowledge the "optional" property
> > > > > > > > > > is
> > > > > > > > > > not
> > > > > > > > > > limited to blobs. But blobs get special treatment in
> > > > > > > > > > regards to "optional" due to the --
> > > > > > > > > > fake-
> > > > > > > > > > ext-
> > > > > > > > > > blobs option. Hence the subsection.
> > > > > > > > > >
> > > > > > > > > > What would you like me to change to make this clearer?
> > > > > > > > >
> > > > > > > > > Oh I see. Are you saying that optional entries end up in the
> > > > > > > > > image
> > > > > > > > > when they are faked, external blobs? If so, that seems like a
> > > > > > > > > bug to
> > > > > > > > > me.
> > > > > > > >
> > > > > > > > To clarify, optional images are faked only when they are
> > > > > > > > missing. So in case the image is
> > > > > > > > missing, a
> > > > > > > > faked image is indeed packaged into the image.
> > > > > > > >
> > > > > > >
> > > > > > > OK, but I still think it is a bug.
> > > > > >
> > > > > > I didn't question your judgement, I simply don't have the broader
> > > > > > goal of binman in mind to be able
> > > > > > to judge if this behaviour is unintended.
> > > > > > What should happen instead? Should the image simply be absent in
> > > > > > the final image?
> > > > > >
> > > > > > > Why add an optional thing in this way?
> > > > > >
> > > > > > Because it seems like a simple, elegant solution.
> > > > > > To elaborate:
> > > > > > The goal (in case of OP-TEE) is to have the binary packaged when
> > > > > > its there and not packaged when it
> > > > > > is not present.
> > > > > > Precisely because it is not required for a bootable image, but may
> > > > > > be added to enhance functionality
> > > > > > . I.e. it is optional.
> > > > > > I found the U-Boot doc to explain optional entries and thought it
> > > > > > to be a perfect fit.
> > > > > > What do you have in mind to achieve this goal?
> > > > >
> > > > > I think we are talking about slightly different things.
> > > > >
> > > > > If a binary is optional then I don't see much point in including an
> > > > > empty (or faked) binary. If it is the only thing missing, the image
> > > > > should still boot OK if it just doesn't appear in the image.
> > > > >
> > > > > The idea with Binman is to produce a functional image, where
> > > > > possible.
> > > > > An image without an optional blob is functional, so we should not
> > > > > need
> > > > > to add it.
> > > > >
> > > > > I'm not saying this is a big problem, just that it seems surprising
> > > > > and not what I intended.
> > > >
> > > > I am with you on this. It was suprising to me, too. And I agree there
> > > > is no point (at least to me) in including it in the final image.
> > > > So we were talking about the same thing, I simply want to make sure we
> > > > are on the same page.
> > > >
> > > > >
> > > > > Perhaps we do need to fake the blob in case it is used by some other
> > > > > tool. But I wonder if we can stop Binman adding the faked blob into
> > > > > the image, if it is optional?
> > > >
> > > > From my point of view, It would be better to stop binman from adding
> > > > faked blobs than what I proposed in these RFC patches. I didn't know,
> > > > however, if there was a use case for adding them to the images that I
> > > > am not aware of.
> > > > Since you now confirm that it was never your intention to have them
> > > > included in the first place I think we can go ahead in preventing
> > > > binman from adding faked blobs to images.
> > > > I'll work on it for the next version.
> > >
> > > Thanks, and also for spotting this.
> >
> > Did you ever get back to this series? I'd like to get it in if we can.
>
> Yes, however I took a break due to other work.
> Anyway, I had taken a look at it the other day and found it very difficult to
> get the GetEntries(omit_optional=True) route working as it only goes 1 level
> deep in the "entries" tree and we pack and write the image in multiple steps.
> Essentially, we would have to make a copy of the whole tree as far as I
> understand (one copy including absent images and one excluding absent images).
>
> >
> > Perhaps we do need to fake the blob in case it is used by some other
> > tool. But I wonder if we can stop Binman adding the faked blob into
> > the image, if it is optional?
> >
>
> Imo keeping the drop_absent function and adjusting the tests is a more promising
> solution; less complex. We could only drop optional images but then still have
> faked blobs in the final binman image afaik; rename drop_absent to
> drop_optional_absent?

OK, can you please send it again and I'll take a look?

Regards,
SImon
