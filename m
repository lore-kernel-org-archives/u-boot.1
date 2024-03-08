Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B4C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 03:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3F387DC4;
	Fri,  8 Mar 2024 04:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jOJjl1KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7089487DF1; Fri,  8 Mar 2024 03:44:41 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0EE87DCD
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-68f41af71ebso14789456d6.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1709865877; x=1710470677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JxG3C1fNlHZOl1qKhga4bIFtxN+IbPgWY3WbkNFh0bI=;
 b=jOJjl1KHvPN0Nsv8UkU1wsAodVEFOlotnKA8eK5dzjxB5QG8PLTfizJ4D92NsX3Bgo
 qiHJTqDRafnHpu4hYDGnp2hn9Tp2qHEQzDH6VEY7AiYp5yUMcKBMPK82sz4mrfvz8CdU
 nahWOKeLHsLpseTIvv/Gdnmu4mC1ZWtO9Lsj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709865877; x=1710470677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JxG3C1fNlHZOl1qKhga4bIFtxN+IbPgWY3WbkNFh0bI=;
 b=H/0aYJml1zQHTqwVxQdTWyDD9vFAQtuXitfqMtTFfasDl4D9joaQTtqHKNcRDBC/7C
 gVBm+5unN2tJDlV4r7RbQcdp3fi2Np/cpXgS6MB52F/ghBq8lkyEiL+7fORST9R9D5Y7
 z1chmcAgIhosCqQM6qsKUY35cVHVSnXtvbPesfyVKNN2+AFMgcNQND6uiH1GGZPCcSwZ
 srajX+9YGwrE6uYYweXA+zDQn1tn3MMwarmND4yWTywO8UBUMWY1gD5pjj+5s8gcvicx
 op/uuw9N8tycqdUV8RvpBshcZMbmfqhOrOv9t3JVOpHNlMsHPjuKND6YGD4rMjHouoxL
 +SVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8aO3cMYCm/EXCGadKyv+g1FyPyOGWG3nxx3NVFRG/LI2C9lDqVjCThEMpnD5DYCMCzO+MN5xRWYjg2thTkBg30wtdpA==
X-Gm-Message-State: AOJu0YxW7FER/5O10yovv66aOPKgvbwgBqWkq1dAec2+/adzp+NWHc4i
 yNiyswh085nk/vVlL/JLhMS7jbnIC+Y1+M+b/LiROF5XMRLyT1QKgnbMVqz2DRNbcB+9y+/8213
 UVGB1o9SJei1GTMmO4iz+dcvox5end1qNGDyn
X-Google-Smtp-Source: AGHT+IHLOplxAthwVDMa5iIYXqMD2Wnv9EgNG65kksgNcwXIp1Hft/8lhsMRr2JKI0egPut76qGLphqo65qwRyxwU6g=
X-Received: by 2002:a0c:ec47:0:b0:690:aaa8:a019 with SMTP id
 n7-20020a0cec47000000b00690aaa8a019mr2720578qvq.47.1709865876833; Thu, 07 Mar
 2024 18:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org>
 <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
 <20231214172702.GA617226-robh@kernel.org>
 <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
 <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
 <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
 <CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com>
 <20240205085056.44278f2c@xps-13>
 <CAFLszTi+8ygXOidnhxj7sdJwc6X5i+++QvnUyfe-kde5eSts_w@mail.gmail.com>
 <20240205131755.3462084f@xps-13>
In-Reply-To: <20240205131755.3462084f@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 Mar 2024 15:44:25 +1300
Message-ID: <CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 08 Mar 2024 04:32:33 +0100
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

Hi Miquel,

On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > > > > > > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > > > > > > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > > > > > > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > > > > > > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > > > > > > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > > > > > > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  Once processing is complete, input properties have mostly served their
> > > > > > > > > > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > > > > > > > > > +  information to read the firmware at runtime, including decompression if
> > > > > > > > > > > > > +  needed.
> > > > > > > > > > > >
> > > > > > > > > > > > How is this going to work exactly? binman reads these nodes and then
> > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > > > > > > > > > specifc parts needed for repacking.
> > > > > > > > > > >
> > > > > > > > > > > No, they are the same node. I do want the extra information to stick
> > > > > > > > > > > around. So long as it is compatible with fixed-partition as well, this
> > > > > > > > > > > should work OK.
> > > > > > > > > >
> > > > > > > > > > How can it be both? The partitions node compatible can be either
> > > > > > > > > > 'fixed-partitions' or 'binman'.
> > > > > > > > >
> > > > > > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > > > > > response to feedback but perhaps the feedback was leading me down the
> > > > > > > > > wrong path?
> > > > > > > >
> > > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > > fixed-partitions.
> > > > > > >
> > > > > > > Can we cross that bridge later? There might be resistance to it. I'm
> > > > > > > not sure. For now, perhaps just a binman compatible works well enough
> > > > > > > to make progress.
> > > > > >
> > > > > > Is there any way to make progress on this? I would like to have
> > > > > > software which doesn't understand the binman compatible to at least be
> > > > > > able to understand the fixed-partition compatible. Is that acceptable?
> > > > >
> > > > > There's only 2 ways that it can work. Either binman writes out
> > > > > fixed-partition nodes dropping/replacing anything only defined for
> > > > > binman or fixed-partition is extended to include what binman needs.
> > > >
> > > > OK, then I suppose the best way is to add a new binman compatible, as
> > > > is done with this v6 series. People then need to choose it instead of
> > > > fixed-partition.
> > >
> > > I'm sorry this is not at all what Rob suggested, or did I totally
> > > misunderstand his answer?
> > >
> > > In both cases the solution is to generate a "fixed-partition" node. Now
> > > up to you to decide whether binman should adapt the output to the
> > > current schema, or if the current schema should be extended to
> > > understand all binman's output.
> > >
> > > At least that is my understanding and also what I kind of agree with.
> >
> > I do want to binman schema to include all the features of Binman.
> >
> > So are you saying that there should not be a 'binman'  schema, but I
> > should just add all the binman properties to the fixed-partition
> > schema?
>
> This is my current understanding, yes. But acknowledgment from Rob is
> also welcome.

I am trying again to wade through all the confusion here.

There is not actually a 'fixed-partition' node. So are you saying I
should add one? There is already a 'partitions' node. Won't they
conflict?

Would it be possible for you to look at my patches and suggest
something? I think at this point, after so many hours of trying
different things and trying to understand what is needed, I could
really use a little help.

Thank you,
Simon
