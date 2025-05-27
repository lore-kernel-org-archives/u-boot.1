Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70754C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 07:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DE582FD2;
	Tue, 27 May 2025 09:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mLXwAshP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0CD82FD4; Tue, 27 May 2025 09:34:50 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0127982FB9
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 09:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60462000956so3191623a12.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748331287; x=1748936087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btqsDpVBErEc6y40WxRRPUOZrtOamgjdlf+iuOg8Ge8=;
 b=mLXwAshPUqp4HQDwzg5RvSrB/FLXjZMPAgiz1eQrLS/xUpVvW8YiRpBmE4TvbVcQtB
 Ao8VirEmd6CaYMg45S4NP3fgmMUfV+9j2bMbEcGgz4V4/n3qukG3DY7J4Fx4r8kBoRuL
 iLP5s7yAR0r2jx+AqCn6mVvmKCftAJNE1X3dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748331287; x=1748936087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btqsDpVBErEc6y40WxRRPUOZrtOamgjdlf+iuOg8Ge8=;
 b=mSEylddzBxiU31GCvI+yHG8pHamjC/6lRH3Swi3+oSDLonYT9+jekxPA0qYZKIoi/o
 8LwqLtGpF/htkEMWZ6sYklEuC1icS25BdjxbImJzYRLETH0EXbuyYpw4FR6OeVdIjqLW
 h0lcyGuKKxstPfkWNmtMW4S9VtmBqW5/UMN8FsdLE4n3m9cxtSgf+qYwG/A9/QxDAEQV
 zWmSQ7tExdA0vlz7eb+eA6DoWDIXvmLDjDzv282BoX1O/K8/4eA6QM2bHfdee4sX2dbf
 vqlnE8k3/k4JkeO/b6B8BoJTGaBik/9yocwZyARh3IXE8+AbuqIgjEI4hWJoF3/pddcV
 pddg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGx2Js8PRvxewOS0Rbj2QYpT0LClWGxkzW4qz1A6/IZ6QuAPakvves8gf3LVbP8hIAMOmzqVU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxyk/PXlRzq+5yDHhmgLQbprLhYJLxgctJpQ/lLRoTVYBo4BI+R
 NIMKlv4A0QTx4WuTJAa+cylQSAUWtkgO5BrkOW4MNs5shmpG2bP6Bah9TwECdplrJG0JNyWYVc/
 SWu1AIgjvQUp7pgh3wQBLoOCcAoWkE+8gSMYjgwWlPQZ748Ganlprtw==
X-Gm-Gg: ASbGnct76WxZtYpRhznVwTW0nprX+Q0sOTTDgou783/VjH9KJ70YOyk2AhhmKAfG9/d
 V85avpu/RwRdUTmUZE30ZoDsLq3xsM5zx/8SjauJY0eaGvU+AuHwrgPrt9qLzd4qdYs+akfIoWS
 ZdXGpT8aHLROmCTsdfZ6USL1oaBG/YDyg=
X-Google-Smtp-Source: AGHT+IFYctthYRJXe06tecaftsNkpmWZKxtQsq3ZLV9SiqtA37SVCyKe+YTDnhph3q81sm1TWP2quM6cbWxys9OTx0M=
X-Received: by 2002:a05:6402:27d1:b0:5ff:abc8:97bb with SMTP id
 4fb4d7f45d1cf-602d9163815mr7266068a12.9.1748331277292; Tue, 27 May 2025
 00:34:37 -0700 (PDT)
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
In-Reply-To: <CAFLszTinxMvBiz8sWC8+qEiHUHXX6LFgw1FnC8kNY1DMG8AF9g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 08:34:25 +0100
X-Gm-Features: AX0GCFu3f1HfJqyft7-BpLMlAqqxftxOnOIF0S9jMCh2ZAX334ome8VEezdZS2o
Message-ID: <CAFLszThotL8ufW-qkc2Eo3ooyf7MMHFfr_OB-H6u7kV3BTt4Jw@mail.gmail.com>
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

On Wed, 19 Feb 2025 at 00:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Yannic,
>
> On Tue, 18 Feb 2025 at 06:15, Yannic Moog <Y.Moog@phytec.de> wrote:
> >
> > On Mon, 2025-02-17 at 06:13 -0700, Simon Glass wrote:
> > > Hi Yannic,
> > >
> > > On Mon, 17 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 2025-02-14 at 06:48 -0700, Simon Glass wrote:
> > > > > Hi Yannic,
> > > > >
> > > > > On Fri, 14 Feb 2025 at 00:05, Yannic Moog <Y.Moog@phytec.de>
> > > > > wrote:
> > > > > >
> > > > > > On Thu, 2025-02-13 at 07:01 -0700, Simon Glass wrote:
> > > > > > > Hi Yannic,
> > > > > > >
> > > > > > > On Thu, 13 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > On Mon, 2025-02-10 at 06:08 -0700, Simon Glass wrote:
> > > > > > > > > On Wed, 29 Jan 2025 at 03:30, Yannic Moog
> > > > > > > > > <y.moog@phytec.de> wrote:
> > > > > > > > > >
> > > > > > > > > > The binman documentation of Optional entries is not
> > > > > > > > > > accurate in the
> > > > > > > > > > sense that it does not cover blobs entry type. As this
> > > > > > > > > > is also the most
> > > > > > > > > > widely used type to have the optional entry, document
> > > > > > > > > > the interaction
> > > > > > > > > > with faking blobs.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > > > > > > ---
> > > > > > > > > >  tools/binman/binman.rst | 9 ++++++++-
> > > > > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/tools/binman/binman.rst
> > > > > > > > > > b/tools/binman/binman.rst
> > > > > > > > > > index 990fc295770..2bafa6ca408 100644
> > > > > > > > > > --- a/tools/binman/binman.rst
> > > > > > > > > > +++ b/tools/binman/binman.rst
> > > > > > > > > > @@ -1145,7 +1145,14 @@ called on all entries.
> > > > > > > > > >  It is not possible for an entry to mark itself absent
> > > > > > > > > > at any other point in the
> > > > > > > > > >  processing. It must happen in the ObtainContents()
> > > > > > > > > > method.
> > > > > > > > > >
> > > > > > > > > > -The effect is as if the entry had never been present
> > > > > > > > > > at all, since the image
> > > > > > > > > > +The effect depends on the type of entry.
> > > > > > > > > > +
> > > > > > > > > > +Blobs
> > > > > > > > > > +~~~~~
> > > > > > > > > > +For blobs, the effect depends on whether --fake-ext-
> > > > > > > > > > blobs is passed
> > > > > > > > > > +to binman. (This is the case by default)
> > > > > > > > > > +In case --fake-ext-blobs is set, any missing entries
> > > > > > > > > > will be faked.
> > > > > > > > > > +If not set, it is as if the entry had never been
> > > > > > > > > > present at all, since the image
> > > > > > > > > >  is packed without it and it disappears from the list
> > > > > > > > > > of entries.
> > > > > > > > >
> > > > > > > > > I'm not quite following this. The text seems OK but your
> > > > > > > > > heading
> > > > > > > > > implies that things other than blobs can be faked. All of
> > > > > > > > > this
> > > > > > > > > functionality is only for blobs.
> > > > > > > >
> > > > > > > > The heading is a subsection of "Optional entries". To my
> > > > > > > > knowledge the "optional" property
> > > > > > > > is
> > > > > > > > not
> > > > > > > > limited to blobs. But blobs get special treatment in
> > > > > > > > regards to "optional" due to the --
> > > > > > > > fake-
> > > > > > > > ext-
> > > > > > > > blobs option. Hence the subsection.
> > > > > > > >
> > > > > > > > What would you like me to change to make this clearer?
> > > > > > >
> > > > > > > Oh I see. Are you saying that optional entries end up in the
> > > > > > > image
> > > > > > > when they are faked, external blobs? If so, that seems like a
> > > > > > > bug to
> > > > > > > me.
> > > > > >
> > > > > > To clarify, optional images are faked only when they are
> > > > > > missing. So in case the image is
> > > > > > missing, a
> > > > > > faked image is indeed packaged into the image.
> > > > > >
> > > > >
> > > > > OK, but I still think it is a bug.
> > > >
> > > > I didn't question your judgement, I simply don't have the broader
> > > > goal of binman in mind to be able
> > > > to judge if this behaviour is unintended.
> > > > What should happen instead? Should the image simply be absent in
> > > > the final image?
> > > >
> > > > > Why add an optional thing in this way?
> > > >
> > > > Because it seems like a simple, elegant solution.
> > > > To elaborate:
> > > > The goal (in case of OP-TEE) is to have the binary packaged when
> > > > its there and not packaged when it
> > > > is not present.
> > > > Precisely because it is not required for a bootable image, but may
> > > > be added to enhance functionality
> > > > . I.e. it is optional.
> > > > I found the U-Boot doc to explain optional entries and thought it
> > > > to be a perfect fit.
> > > > What do you have in mind to achieve this goal?
> > >
> > > I think we are talking about slightly different things.
> > >
> > > If a binary is optional then I don't see much point in including an
> > > empty (or faked) binary. If it is the only thing missing, the image
> > > should still boot OK if it just doesn't appear in the image.
> > >
> > > The idea with Binman is to produce a functional image, where
> > > possible.
> > > An image without an optional blob is functional, so we should not
> > > need
> > > to add it.
> > >
> > > I'm not saying this is a big problem, just that it seems surprising
> > > and not what I intended.
> >
> > I am with you on this. It was suprising to me, too. And I agree there
> > is no point (at least to me) in including it in the final image.
> > So we were talking about the same thing, I simply want to make sure we
> > are on the same page.
> >
> > >
> > > Perhaps we do need to fake the blob in case it is used by some other
> > > tool. But I wonder if we can stop Binman adding the faked blob into
> > > the image, if it is optional?
> >
> > From my point of view, It would be better to stop binman from adding
> > faked blobs than what I proposed in these RFC patches. I didn't know,
> > however, if there was a use case for adding them to the images that I
> > am not aware of.
> > Since you now confirm that it was never your intention to have them
> > included in the first place I think we can go ahead in preventing
> > binman from adding faked blobs to images.
> > I'll work on it for the next version.
>
> Thanks, and also for spotting this.

Did you ever get back to this series? I'd like to get it in if we can.

Regards,
Simon
