Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F15C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8319280104;
	Mon, 17 Feb 2025 14:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d0WMfjaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C4D808B6; Mon, 17 Feb 2025 14:13:37 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F314F80017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abba1b74586so114346466b.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798014; x=1740402814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L55e+F4XjCYS5Izof120wh5M8F3CRl1lLDRbPnGLobg=;
 b=d0WMfjaCZ5hWKyK7AGwkvrOBb3Q0aNZW8sLEfsh0ccC2mV0L9aWHkO4mPmCsRL/KLa
 9bZ0q1j5Q6ptChKIBEcSTmmcBjBGDNuOrGNj627C/ERHGkBnOqdiMrJkDHesN/hBkcXt
 EKj1mStyoGOZzZtk3WvRSaxHRDAkWJmeTy8Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798014; x=1740402814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L55e+F4XjCYS5Izof120wh5M8F3CRl1lLDRbPnGLobg=;
 b=wQ8Q4be/czGppLwXJULyK+5NQS+d+6qgsMCHkm5REnlBTbPfjQ5B12IbiimZi19cS3
 rPvj37f8RDusmnNz/COjECNo4m1cqeFlzUPirPW/02Y9/DRXcCDlQThBL9ccSy3NmLQK
 4uXMypPbgJekgLnyPTarsuFGycqzCep7wdvWxDK1vMTW9TeU6Ocnq8hfsvLKOEYPInAO
 NafCEKuRnLV7k2sGOIVlQ1E7KC57yGhSnbnI0HfOaj12ZTW7BwIX28iLC7qOV6awCB+P
 pNIM8VKcgvpDzKzZOkNaHvc2LeGILCT6Vy0EsDmMf6bCyT8RDUZlkiNYPFWe/rbt4Gom
 UWvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6k+CZeLHPdG45luMS/4T4cflQwtLWohJ027CKmUsJQ+kB4nwEF9kQnHfwgzqHW9/G0O2VvQA=@lists.denx.de
X-Gm-Message-State: AOJu0YyiWIHHqVcN+/LHUkIGVjiZMkq1WHNk4G60VJj1UDCa9IvoTrx5
 xdMOdAwWY4ulvndoET/gI3hFKvcke+CEoBWgwxGV9dDWlCwdFetltvI4L5SEfoBZiH1Ky2MSdk9
 qPcTzDeCvt4RWT5tZ9CFgg85YwucOp4Qfsa9R
X-Gm-Gg: ASbGncv28iRO4vDF7LY8wLGHAemUNb+LUksxhi0Z9Kw8XThPMQPKi5y4XQRfaffetlI
 Hca8gUTGZTUoFaKXBFPRChJ4ypF94fJeoAa+8i6q2xn0HMIy8FpH8veajsZ/zn6G9vudY4uEcWw
 ==
X-Google-Smtp-Source: AGHT+IHxQvzhCsLKp9jDGow7n0JsaXm5/ZbG5zVKh/4E8IGdyT3ecvtXzN5ax/elVriH/jzS5Kv+AXnpLenK/9wKR7o=
X-Received: by 2002:a17:907:9716:b0:ab7:e3f4:51cc with SMTP id
 a640c23a62f3a-abb70c314bemr1118423766b.33.1739798014068; Mon, 17 Feb 2025
 05:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
 <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
 <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
In-Reply-To: <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:13:22 -0700
X-Gm-Features: AWEUYZm4CxRL4oAmb9aJrCJClJsxZIVuu80qpv2RMdNj6D9Tf6tFg6qfwr5w0dM
Message-ID: <CAFLszTg0UXfcsy8-A9QMq5CSsAvAXHLKRBpHyzdNuwdj17VwKQ@mail.gmail.com>
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

On Mon, 17 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> Hi Simon,
>
> On Fri, 2025-02-14 at 06:48 -0700, Simon Glass wrote:
> > Hi Yannic,
> >
> > On Fri, 14 Feb 2025 at 00:05, Yannic Moog <Y.Moog@phytec.de> wrote:
> > >
> > > On Thu, 2025-02-13 at 07:01 -0700, Simon Glass wrote:
> > > > Hi Yannic,
> > > >
> > > > On Thu, 13 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
> > > > >
> > > > > On Mon, 2025-02-10 at 06:08 -0700, Simon Glass wrote:
> > > > > > On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
> > > > > > >
> > > > > > > The binman documentation of Optional entries is not accurate in the
> > > > > > > sense that it does not cover blobs entry type. As this is also the most
> > > > > > > widely used type to have the optional entry, document the interaction
> > > > > > > with faking blobs.
> > > > > > >
> > > > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > > > ---
> > > > > > >  tools/binman/binman.rst | 9 ++++++++-
> > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > > > > > > index 990fc295770..2bafa6ca408 100644
> > > > > > > --- a/tools/binman/binman.rst
> > > > > > > +++ b/tools/binman/binman.rst
> > > > > > > @@ -1145,7 +1145,14 @@ called on all entries.
> > > > > > >  It is not possible for an entry to mark itself absent at any other point in the
> > > > > > >  processing. It must happen in the ObtainContents() method.
> > > > > > >
> > > > > > > -The effect is as if the entry had never been present at all, since the image
> > > > > > > +The effect depends on the type of entry.
> > > > > > > +
> > > > > > > +Blobs
> > > > > > > +~~~~~
> > > > > > > +For blobs, the effect depends on whether --fake-ext-blobs is passed
> > > > > > > +to binman. (This is the case by default)
> > > > > > > +In case --fake-ext-blobs is set, any missing entries will be faked.
> > > > > > > +If not set, it is as if the entry had never been present at all, since the image
> > > > > > >  is packed without it and it disappears from the list of entries.
> > > > > >
> > > > > > I'm not quite following this. The text seems OK but your heading
> > > > > > implies that things other than blobs can be faked. All of this
> > > > > > functionality is only for blobs.
> > > > >
> > > > > The heading is a subsection of "Optional entries". To my knowledge the "optional" property
> > > > > is
> > > > > not
> > > > > limited to blobs. But blobs get special treatment in regards to "optional" due to the --
> > > > > fake-
> > > > > ext-
> > > > > blobs option. Hence the subsection.
> > > > >
> > > > > What would you like me to change to make this clearer?
> > > >
> > > > Oh I see. Are you saying that optional entries end up in the image
> > > > when they are faked, external blobs? If so, that seems like a bug to
> > > > me.
> > >
> > > To clarify, optional images are faked only when they are missing. So in case the image is
> > > missing, a
> > > faked image is indeed packaged into the image.
> > >
> >
> > OK, but I still think it is a bug.
>
> I didn't question your judgement, I simply don't have the broader goal of binman in mind to be able
> to judge if this behaviour is unintended.
> What should happen instead? Should the image simply be absent in the final image?
>
> > Why add an optional thing in this way?
>
> Because it seems like a simple, elegant solution.
> To elaborate:
> The goal (in case of OP-TEE) is to have the binary packaged when its there and not packaged when it
> is not present.
> Precisely because it is not required for a bootable image, but may be added to enhance functionality
> . I.e. it is optional.
> I found the U-Boot doc to explain optional entries and thought it to be a perfect fit.
> What do you have in mind to achieve this goal?

I think we are talking about slightly different things.

If a binary is optional then I don't see much point in including an
empty (or faked) binary. If it is the only thing missing, the image
should still boot OK if it just doesn't appear in the image.

The idea with Binman is to produce a functional image, where possible.
An image without an optional blob is functional, so we should not need
to add it.

I'm not saying this is a big problem, just that it seems surprising
and not what I intended.

Perhaps we do need to fake the blob in case it is used by some other
tool. But I wonder if we can stop Binman adding the faked blob into
the image, if it is optional?


>
> Yannic
>
> >
> >
> > > Here is the image map from an (phycore-)imx8mp build.
> > >
> > > Missing tee-os (faked):
> > >
> > > ImagePos    Offset      Size  Name
> > > 00000000  00000000  00159e10  image
> > > 00000000   00000000  00159e10  section
> > > [...]
> > > 00058000    00058000  00101e10  fit
> > > 0005b000     00003000  000e4910  uboot
> > > 0005b000      00000000  000e4910  blob-ext
> > > 0013f910     000e7910  00008458  atf
> > > 0013f910      00000000  00008458  atf-blob
> > > 00147d68     000efd68  00000000  tee
> > > 00147d68      00000000  00000000  tee-os
> > >
> > > tee-os present:
> > >
> > > ImagePos    Offset      Size  Name
> > > 00000000  00000000  0022b5b0  image
> > > 00000000   00000000  0022b5b0  section
> > > [...]
> > > 00058000    00058000  001d35b0  fit
> > > 0005b000     00003000  000e4910  uboot
> > > 0005b000      00000000  000e4910  blob-ext
> > > 0013f910     000e7910  00008458  atf
> > > 0013f910      00000000  00008458  atf-blob
> > > 00147d68     000efd68  000d17a0  tee
> > > 00147d68      00000000  000d17a0  tee-os
> > >
> > > Yannic

Regards,
Simon
