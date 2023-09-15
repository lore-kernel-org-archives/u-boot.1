Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1009EE644C
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 09:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6B38647B;
	Fri, 15 Sep 2023 11:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pKCmrKp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C45C86489; Fri, 15 Sep 2023 11:49:53 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE82186431
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 11:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bfc1d8f2d2so23724331fa.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694771390; x=1695376190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wruyElrlWxgsuoUV4xBfB9N0vmHSwLxyzsiOOjH/7+4=;
 b=pKCmrKp/HMS2THg/o4OhDDy0tJmAKWkgVAzsR2+EAnco8xtF5nohQbPOHmWtK0OJyT
 mVuR1HWou6XJKmaL8sHx3Ir3lPUwCPizSKtS1SoWdOSAjcmir5vwFi4U3FgJas4fxz3t
 9nK0llyrK3FftbuYa5yKfNvhNxzX1ulF7k9Nz++NpVvxWN3o/F6O2SAv71pufpmZZ1UV
 E4UxTtoBU+c0DdL8MYFpMhVZkJ6L6Ne2mkOaKR9aq5xDg3JOK1vdVj0M6r4/hRMEBJbJ
 JleRNzKlwaSXikuV2GOvbIa/+rnztxSY1HPdUv7MPNCaxOlWWwhdc1wOIuDOPKcc77Mb
 1H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771390; x=1695376190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wruyElrlWxgsuoUV4xBfB9N0vmHSwLxyzsiOOjH/7+4=;
 b=TKIGXFZ8IpDhzOJt/SjYTHKtXWY6ALYd5+FYFALUIFedfEFFIGQZjj2tItk2QZx1QU
 r7r4owH9JcbuhScKCsVBQdEMrO7pRqN2OVq4yiq83lrb1+lVGH0sqap5qUEgD3qtbSUb
 uxm1Ho1RCSe9ROj9syitQibbVP6rWFOPHP3iHFO8huZQ2nHN3bxEBdy1Rks7VWfm9we1
 awEx86UWH0E/nLGTzCQKnP+63Y0RAb8KKxHAQrj5FVQ0sz4HVKuuoHdXT+wKD+HBy7FY
 6sg/FakaSQDviA65dyJYpd0U8e57eyE3XrTEoV5+n35uDS38gBphF0kRob2MN7GMDeVv
 jsqA==
X-Gm-Message-State: AOJu0Yx7yYVwmwueKI/9P3UC4LOVG+QzZ0ZR/4gmBJUnTCsh1eHaGjb4
 k5culIKYSmKo443hS9wY/x52e9uxqZLLJaHi1q6H3w==
X-Google-Smtp-Source: AGHT+IET9eMKGtXIAzQGNlwzky5qGh6zrfTsRqA84+S0cgPKhZ3uf1UJS5XgUzK/z+o+5kDavtKfRDFTPALez94ySAs=
X-Received: by 2002:a2e:920d:0:b0:2b6:c3f9:b86b with SMTP id
 k13-20020a2e920d000000b002b6c3f9b86bmr484444ljg.15.1694771390145; Fri, 15 Sep
 2023 02:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
 <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
 <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
 <20230914233826.GE305624@bill-the-cat>
In-Reply-To: <20230914233826.GE305624@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Sep 2023 12:49:13 +0300
Message-ID: <CAC_iWj+w++z2FQUBFzuR_LFom9rfpNvpZbP5Yd2ACU9DtG4R_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Jassi Brar <jassisinghbrar@gmail.com>,
 pbrobinson@gmail.com, 
 sughosh.ganu@linaro.org, u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Jose Marinho <Jose.Marinho@arm.com>
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

+CC Jose who's maintaining the metadata spec from Arm side.

On Fri, 15 Sept 2023 at 02:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 14, 2023 at 04:41:43PM -0600, Simon Glass wrote:
> > Hi Rob,
> >
> > On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
> [snip]
> > > I don't think we should decide what to do here based on said
> > > certification program. It can adapt to what's decided. Probably, the
> > > /option nodes will be stripped out or ignored for certification.
> > >
> > > I accepted u-boot options node schema into dtschema, but now have
> > > second thoughts on that. Now I'm getting more u-boot specific
> > > (perhaps, not clear) stuff and widevine stuff internal to a TEE.
> >
> > Where should these bindings go such that ARM / Linaro are not trying
> > to remove them? I would be OK with moving them out somewhere else, but
> > how are people supposed to deal with such fragmentation? My
> > understanding was that dt-schema was an attempt to set up a neutral
> > area where bindings could be accepted that were not just for
> > Linux...did that change?
>
> Well, part of the problem here is that I've been talking with Ilias more
> about what's intended here and the fwu-* stuff that Rob rejected is
> indeed not right.  We should drop it and replace it with something that
> really addresses the underlying problem (which is how do you know
> how/where to find some GUIDs) and I think we think it's something that
> can be shared between projects too and so be easier to convince Rob that
> the next form of it is right (or the right direction).

Tom, I gave the discussion we had last night a bit of thought (thanks
for that) and talked with Jose.
The spec as is written right now recommends a GPT-based partition.  It
then has various GPT UUIDs that indicate where to find the metadata as
well as the various firmware banks that participate in the whole
scheme.  If you have that GPT, then the only thing you really need is
to find the metadata UUID and handle the various banks.

However,  the synquacer which boots from a NOR has no GPT.  What that
fwu node entry does, in order to abstract the rest of the
implementation, is map UUIIDs <-> offset + length.  That way the core
code still thinks it's trying to discover UUIDs but the eventual
reads/writes end up on a NOR.
That box boots via SCP [0] , which has no understanding of device
trees, instead they hardcode the UUIDS, offsets etc for the Synquacer.
But if they ever wanted to switch over having that information would
come in handy.

Jose and I discussed this a bit.  I'll backpaddle and have someone
look into upstreaming the fwu part.  There are a few changes required,
since we already have some MTD information in the DT and those entries
would make more sense there instead of inventing a new node, but we
can discuss this when the patches are sent. Once those are sent, we
can add a recommendation on the spec, pointing to that DT entry for
any future early stage boot loaders that want to implement it,
pointing to the DT entry.

That only solves a fraction of the problem though.  Other nodes, like
the EFI public key etc. still need to be removed.

[0] https://github.com/ARM-software/SCP-firmware

Thanks
/Ilias
>
> --
> Tom
