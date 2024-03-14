Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF5FC54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6450587DE3;
	Thu, 14 Mar 2024 04:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BieLOSDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F848869F7; Thu, 14 Mar 2024 03:15:45 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AC387ED3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 03:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4d419b03fd9so184492e0c.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1710382541; x=1710987341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cn3bs1YfzZryCc5H7gkVB2XqHmwH+85IGt+IRJDcw7s=;
 b=BieLOSDyVJwcARONxSGWtlTW3whNMWpAJwHGf69Zm9f+jNXn1KZLh/DDNO97E1UtqX
 WSomQ3pJ0enM4OP0uLfPUE+GKhlsMxWbd9lQtTc/PQlJKPar1/8mZ7QqEK79OltVgh3P
 e+409XmQHWIpiiRBKNz7L2ZYGSvFeUW8aN/0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710382541; x=1710987341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cn3bs1YfzZryCc5H7gkVB2XqHmwH+85IGt+IRJDcw7s=;
 b=A+jbIoOkWoD7d7dXQeOBMs4SbH6r2bDBUQK82mRA6hj2Cyq1N+ahJSHcVJ/EezV/BO
 23Tol22A835Wz7lWe0GKftpXcBVMK9TMrkA7uxJdLj6ZfVsNG+zqorpfzAg/8VpSekT/
 kkpmCHfg4IuHwsQ5VxgY5pLfazE3U5/Fdo9/sreK31D0LwyGxO+XPj9J6sUP1t9lyEFV
 o6VZH+94lrg3mAfNHTins6nzCYEsQxrpEl0W/5MYGTS94EpPt9vXb1NKGNA3540hKes8
 o8bl44kYzNRW41YiZpUoswrPf/xXgqdVoUL5SUqa7sRVYDTCcALW11PQKcTb26wGUfmY
 5a5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgmjI0gHgZ303FNTbHA+abzebKA+VrI2IyPXB5i6XKTbWggobM068/rMYJvRHfXCqF4T50Q0Mq+uxaAf2tOTB4gcGy2A==
X-Gm-Message-State: AOJu0YwrcdCWiwhhcI4ajwjfW1ZCuagXgHvEsPV739m4XKIy6+iLRUnx
 +af/kO1NPHKiAu+iU7sQXXWnKrlB4CF5HWcQg/I5SoBZKYawK4ygC08VRgrifAnv/jgvFxJShYV
 dU84sKs0wKcc2vi2nepkfb2y3hUA5rVS220Av
X-Google-Smtp-Source: AGHT+IGcS4zTmTCpGZzm3ppXJXHiKW2RGfHCRm/zeO4viqblfB1ZUUXPJ6w9vvXza7ULZzQ1Y7mQUYRoZ7cwdlpkkjE=
X-Received: by 2002:a1f:fe8e:0:b0:4d3:3a8c:13ad with SMTP id
 l136-20020a1ffe8e000000b004d33a8c13admr655409vki.8.1710382540960; Wed, 13 Mar
 2024 19:15:40 -0700 (PDT)
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
 <CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
 <20240308084212.4aa58761@xps-13>
 <CAFLszTi8w4gBoa-6uoKUN-Ng07ieA+DXy3gm2cdxfwgAybrgsQ@mail.gmail.com>
 <20240313083541.1e7d4a2f@xps-13>
In-Reply-To: <20240313083541.1e7d4a2f@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Mar 2024 15:15:30 +1300
Message-ID: <CAFLszThe8qTWM4GtpsLyy1+yyhN-MEfcPT2OcU1sd4ST=3n55Q@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 14 Mar 2024 04:11:57 +0100
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

On Wed, 13 Mar 2024 at 20:35, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Wed, 13 Mar 2024 11:25:42 +1300:
>
> > Hi Miquel,
> >
> > On Fri, 8 Mar 2024 at 20:42, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > sjg@chromium.org wrote on Fri, 8 Mar 2024 15:44:25 +1300:
> > >
> > > > Hi Miquel,
> > > >
> > > > On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > > > > > > > > > > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > > > > > > > > > > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > > > > > > > > > > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > > > > > > > > > > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > > > > > > > > > > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > > > > > > > > > > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +  Once processing is complete, input properties have mostly served their
> > > > > > > > > > > > > > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > > > > > > > > > > > > > +  information to read the firmware at runtime, including decompression if
> > > > > > > > > > > > > > > > > +  needed.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > How is this going to work exactly? binman reads these nodes and then
> > > > > > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > > > > > > > > > > > > > specifc parts needed for repacking.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No, they are the same node. I do want the extra information to stick
> > > > > > > > > > > > > > > around. So long as it is compatible with fixed-partition as well, this
> > > > > > > > > > > > > > > should work OK.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > How can it be both? The partitions node compatible can be either
> > > > > > > > > > > > > > 'fixed-partitions' or 'binman'.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > > > > > > > > > response to feedback but perhaps the feedback was leading me down the
> > > > > > > > > > > > > wrong path?
> > > > > > > > > > > >
> > > > > > > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > > > > > > fixed-partitions.
> > > > > > > > > > >
> > > > > > > > > > > Can we cross that bridge later? There might be resistance to it. I'm
> > > > > > > > > > > not sure. For now, perhaps just a binman compatible works well enough
> > > > > > > > > > > to make progress.
> > > > > > > > > >
> > > > > > > > > > Is there any way to make progress on this? I would like to have
> > > > > > > > > > software which doesn't understand the binman compatible to at least be
> > > > > > > > > > able to understand the fixed-partition compatible. Is that acceptable?
> > > > > > > > >
> > > > > > > > > There's only 2 ways that it can work. Either binman writes out
> > > > > > > > > fixed-partition nodes dropping/replacing anything only defined for
> > > > > > > > > binman or fixed-partition is extended to include what binman needs.
> > > > > > > >
> > > > > > > > OK, then I suppose the best way is to add a new binman compatible, as
> > > > > > > > is done with this v6 series. People then need to choose it instead of
> > > > > > > > fixed-partition.
> > > > > > >
> > > > > > > I'm sorry this is not at all what Rob suggested, or did I totally
> > > > > > > misunderstand his answer?
> > > > > > >
> > > > > > > In both cases the solution is to generate a "fixed-partition" node. Now
> > > > > > > up to you to decide whether binman should adapt the output to the
> > > > > > > current schema, or if the current schema should be extended to
> > > > > > > understand all binman's output.
> > > > > > >
> > > > > > > At least that is my understanding and also what I kind of agree with.
> > > > > >
> > > > > > I do want to binman schema to include all the features of Binman.
> > > > > >
> > > > > > So are you saying that there should not be a 'binman'  schema, but I
> > > > > > should just add all the binman properties to the fixed-partition
> > > > > > schema?
> > > > >
> > > > > This is my current understanding, yes. But acknowledgment from Rob is
> > > > > also welcome.
> > > >
> > > > I am trying again to wade through all the confusion here.
> > > >
> > > > There is not actually a 'fixed-partition' node. So are you saying I
> > > > should add one? There is already a 'partitions' node. Won't they
> > > > conflict?
> > >
> > > Sorry for the confusion, there is a 'partitions' node indeed. This
> > > node shall declare it's "programming model" (let's say), ie. how it
> > > should be parsed. What defines this programming model today is the
> > > 'fixed-partitions' compatible. I think we (Rob and myself, but again,
> > > Rob, please confirm) agree on the fact that we don't want to duplicate
> > > the fixed-partitions compatible/logic and thus the binman compatible
> > > was rejected.
> > >
> > > Hence, in order to move forward, I would definitely appreciate an
> > > update of the fixed-partitions binding in order to support what binman
> > > can generate.
> >
> > OK, so I think my confusion is that I thought you were referring to a
> > 'partitions' compatible. But you are just referring to the name of the
> > node being 'partitions', with the compatible string being
> > 'fixed-partitions'.
>
> Yes.
>
> >
> > I believe I can make this work by adding a new 'binman.yaml' with the
> > compatibles that I want to introduce. I cannot change partition.yaml
> > since it does not itself specify a compatible.
>
> What about fixed-partitions.ymal? The yaml file name should match the
> compatible.

But we already decided we cannot add a new 'binman' compatible but
want to use the existing fixed-partitions.yaml

I cannot add compatible strings into that, since these are defined by
the default files which make use of partition.yaml

Anyway, I will see v7 so you can see what I mean.

>
> > > We are here talking about the output of binman, not its input. TBH I
> > > haven't understood the point in having binman's input parsed by the
> > > generic yaml binding. I would advise to focus on binman's output first
> > > because it feels more relevant, at a first glance.
> >
> > Yes that is fine.
> >
> > >
> > > > Would it be possible for you to look at my patches and suggest
> > > > something? I think at this point, after so many hours of trying
> > > > different things and trying to understand what is needed, I could
> > > > really use a little help.
> > >
> > > I hope the above details will help.
> >
> > I think so, thank you. I will send another version.
> >
> > Regards,
> > Simon

Regards,
Simon
