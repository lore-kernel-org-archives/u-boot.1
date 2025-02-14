Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A98CC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951CE80C96;
	Fri, 14 Feb 2025 14:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J8frSOa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CD680C83; Fri, 14 Feb 2025 14:49:05 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DBA806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7e80c4b55so405356266b.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 05:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739540942; x=1740145742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PACNEytcx2WjXmoPgWZNJtLheCktNWANF0BUHjjZ5z4=;
 b=J8frSOa/f7Fg4RZ5uX8PN6ev/ZqIkr/T6kynSaXcmmTHOPjehy3UtSU9cajKNgILgw
 uAPsB9hA9cQyn5PsCwhkYKIRo4jRef9SUFMSPb18/Pxplb5U6SSYp+QwtBPlkqq+Chdr
 oie//JRQR4waS9ldaRFpmGAIGoFKIV0CZusqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739540942; x=1740145742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PACNEytcx2WjXmoPgWZNJtLheCktNWANF0BUHjjZ5z4=;
 b=BV1jztzUa/rdDzlluWfkQka8lS3x8IWjQNZXqb+JBTEa8DrDTfEE8+56xYB1SB5MHo
 ek7mkozb6NgGpC4Wl4CwAXdZG5BRI0lEel9mhwpWF4VEKBf4R3XisQ/l3xmYH6K22au2
 7kSYzZPrVLw3QQk3hZhCORm0qMZt+LY3LGhzd8toewkA1xjtjEw2Jm3wm71jWWl7wpMj
 GqVXVjSOD5ACliafWodsVAu2sgZ59Xc46auLFqaNf73XmzQmQroLylHyptmx7Iepevbq
 D3sbW+nifXOjX4AzsRR0TDGp0jkzv8gNg3pOkkJLBMvpzqC5K94O6E2glaqqo6pOKtx7
 m1Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOQKY6Bfpo5WAN8dkO04Qc1JCeyeifXYCLCFPynWVSezs3eHoVmvcHQLrXuuWk77JtgajRSlw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8VlD3CbhmqpmJm64F4Vl0csYZMFdyKMTtT7OjJEhG6P6s7HFT
 eSkMJbO7Vzd3B8wpSprqCgcgTqWrBx6am6dBUBCl7Q6wG9B8NhUSW5VVraAPtpv6Nx9Ck2clmqX
 ur4Pvx+NTcQRnnqbNP0SGoWpqcAO3yd0doCTN
X-Gm-Gg: ASbGnctj3OGjL8FCDAH1IQmo8Ik2hVInoRjMlUfWToxjmfK3RpKU8CmafwFumJ1C60o
 EOg4XkGjaqam0SARiytnASa2430I6n/pUdEYLE0cSYOz/VVX0kFb/yOXXInqUTLL/KzoWnq6yNJ
 G1M9tUT9PKgzintCx1y1RnrkNxDkm2Bg==
X-Google-Smtp-Source: AGHT+IHQ4DzUqywkjqwMizj2hRpBZZtbIjBu6O7h8BIG3ey9vQltYeix3fHQzWz6eBdXAwhBoSBbQuWjA7TgphiSmDs=
X-Received: by 2002:a17:907:7284:b0:ab7:b41d:bdb5 with SMTP id
 a640c23a62f3a-aba5017e5e4mr676460366b.45.1739540942313; Fri, 14 Feb 2025
 05:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
In-Reply-To: <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Feb 2025 06:48:50 -0700
X-Gm-Features: AWEUYZniGCh2G3yIp0QzI-7n5QvAUROdlYbkWGSVcO9DSn2hjFcHYWByWnnALGE
Message-ID: <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 00:05, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> On Thu, 2025-02-13 at 07:01 -0700, Simon Glass wrote:
> > Hi Yannic,
> >
> > On Thu, 13 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
> > >
> > > On Mon, 2025-02-10 at 06:08 -0700, Simon Glass wrote:
> > > > On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
> > > > >
> > > > > The binman documentation of Optional entries is not accurate in the
> > > > > sense that it does not cover blobs entry type. As this is also the most
> > > > > widely used type to have the optional entry, document the interaction
> > > > > with faking blobs.
> > > > >
> > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > ---
> > > > >  tools/binman/binman.rst | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > > > > index 990fc295770..2bafa6ca408 100644
> > > > > --- a/tools/binman/binman.rst
> > > > > +++ b/tools/binman/binman.rst
> > > > > @@ -1145,7 +1145,14 @@ called on all entries.
> > > > >  It is not possible for an entry to mark itself absent at any other point in the
> > > > >  processing. It must happen in the ObtainContents() method.
> > > > >
> > > > > -The effect is as if the entry had never been present at all, since the image
> > > > > +The effect depends on the type of entry.
> > > > > +
> > > > > +Blobs
> > > > > +~~~~~
> > > > > +For blobs, the effect depends on whether --fake-ext-blobs is passed
> > > > > +to binman. (This is the case by default)
> > > > > +In case --fake-ext-blobs is set, any missing entries will be faked.
> > > > > +If not set, it is as if the entry had never been present at all, since the image
> > > > >  is packed without it and it disappears from the list of entries.
> > > >
> > > > I'm not quite following this. The text seems OK but your heading
> > > > implies that things other than blobs can be faked. All of this
> > > > functionality is only for blobs.
> > >
> > > The heading is a subsection of "Optional entries". To my knowledge the "optional" property is
> > > not
> > > limited to blobs. But blobs get special treatment in regards to "optional" due to the --fake-
> > > ext-
> > > blobs option. Hence the subsection.
> > >
> > > What would you like me to change to make this clearer?
> >
> > Oh I see. Are you saying that optional entries end up in the image
> > when they are faked, external blobs? If so, that seems like a bug to
> > me.
>
> To clarify, optional images are faked only when they are missing. So in case the image is missing, a
> faked image is indeed packaged into the image.
>

OK, but I still think it is a bug. Why add an optional thing in this way?


> Here is the image map from an (phycore-)imx8mp build.
>
> Missing tee-os (faked):
>
> ImagePos    Offset      Size  Name
> 00000000  00000000  00159e10  image
> 00000000   00000000  00159e10  section
> [...]
> 00058000    00058000  00101e10  fit
> 0005b000     00003000  000e4910  uboot
> 0005b000      00000000  000e4910  blob-ext
> 0013f910     000e7910  00008458  atf
> 0013f910      00000000  00008458  atf-blob
> 00147d68     000efd68  00000000  tee
> 00147d68      00000000  00000000  tee-os
>
> tee-os present:
>
> ImagePos    Offset      Size  Name
> 00000000  00000000  0022b5b0  image
> 00000000   00000000  0022b5b0  section
> [...]
> 00058000    00058000  001d35b0  fit
> 0005b000     00003000  000e4910  uboot
> 0005b000      00000000  000e4910  blob-ext
> 0013f910     000e7910  00008458  atf
> 0013f910      00000000  00008458  atf-blob
> 00147d68     000efd68  000d17a0  tee
> 00147d68      00000000  000d17a0  tee-os
>
> Yannic
>
>

Regards,
Simon
