Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F5C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3767B826B2;
	Fri,  4 Apr 2025 00:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3qVmCbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E0582845; Fri,  4 Apr 2025 00:41:25 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4CD82385
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so268046966b.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743720082; x=1744324882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tVYT77KMsk/WONYkG3I/kkXaKnT/Ng1SIjyQnnzc+pg=;
 b=Z3qVmCbe345HGTz5Df0mRpL5AAaOPSHH/63cwrQ72J/IapcJhE6W4QlxDTZcdiH1uv
 ja6xnQw2Cvdtd7LFaTYVlKFnU60DDPdaI3xYvX66714/NspxBgQJwsqX8+LYQXDL5TwT
 2YIfP6yEEDqH+OYEv3t4eRrgzKd2ollq0vgHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743720082; x=1744324882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVYT77KMsk/WONYkG3I/kkXaKnT/Ng1SIjyQnnzc+pg=;
 b=JHA6FhmPPU41ce+leaH+k8N7iEtGNudN3hiJh/xNSF1HkUoOCgNMqxoSc+JdtQAB/T
 FhtOtknlcZPPyKl3oxE6TTms21edYT9401ZlK3gRVEj5NDGV2mJpQxMo/0PCtMS0aZLE
 8cbZJeKsN8Sih/AJXU9GsNAwcX+HiSAum7C/e3UD0n7Fd5hcgGkrLsJXD80fsJziQsVB
 1W2dmBiRnEkPiUbRIzVlO63gc+NRmbUneXkdsWrpVPE01uKng/6o2aRc1AjrMCY0NYCh
 MnkUvkUsXgWnSLWHMz/85ltcwUWVNHdNHsY9zSW+S72aIpLNoCL2I/lFUK3sZh9WJ89W
 U7Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMzUr0PjqQRbV0FaBVeKeWPpQYTZ487WJDbcs9KvGmqJljx4cPjRYVf0C4P5X4I+SfKgNH8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwDZvgDpQZ8iSl2pSS0/vOJAEnNF6LWh37rL62wSVWhcXjpLONw
 uAZNBvYbC2EVHsQu80Q1PP9fZbfB2k1sg4CqNMANodrA2qYPUSVeT6d/oye3ADL1lm9h3Hem+tM
 TVWsvTTPPEBz4nkGxfmvZzj6sAoWG4mILDCc6
X-Gm-Gg: ASbGnctw1QA3KcadSKSQCFYTgVJLFpZL1QnatD6y4EFKpfUzie8CmTVTrw3tuox+yrp
 Ru9LG0wB58eDJv+U/IruWq/405ZxakMoyfujeK+Z8NzbMdNFKKpcKZm0uklmSwFKI+e3wvyvXgX
 XJAEQTTTTxFDhIxE3tuvo923dMPI73
X-Google-Smtp-Source: AGHT+IG60EDr7/JIex2FEkUu78U019s7SZha9TJZJSoq8MKS0U/fTubdZS0XlL/ZH2sU5jiwucKJS4FKkmIBrcP85CM=
X-Received: by 2002:a17:906:f588:b0:ac7:c7cd:ac39 with SMTP id
 a640c23a62f3a-ac7d18a3ee0mr101423066b.24.1743720082487; Thu, 03 Apr 2025
 15:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
In-Reply-To: <20250403215239.GO5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 11:41:08 +1300
X-Gm-Features: AQ5f1JqGv6AlzghIFcvR5g37K90gCeYWZ7dkhO8V7UtzpCeJjSSVNZ2kAwl9qNY
Message-ID: <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > so that it is simpler to understand and manage.
> > > > > > > >
> > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > >
> > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > > > mandatorily use bloblist to hand over everything between boot stages
> > > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > > >
> > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > > > > there must be a bloblist, not that it must contain a devicetree. So I
> > > > > > wasn't sure about removing it.
> > > > > >
> > > > >
> > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> > > > > selected, we can override any fdt from board or env with the one from
> > > > > the bloblist.
> > > >
> > > > Yes, but we should be explicit about what is going on here. With
> > > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > > bloblist. It becomes one of the sources for devicetree, like
> > > > OF_SEPARATE and OF_EMBED
> > > >
> > >
> > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> > > mandatorily used and override other fdt sources like from the board or
> > > env variables.
> >
> > So long as you are OK with OF_BLOBLIST as well, I have no objection to
> > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> > very much. But I can see why it is called that as my standard passage
> > series was actually never applied. So I suppose I'll need to have
> > another try at that.
> >
> > So to be clear, I want a separate option for devicetree, called
> > OF_BLOBLIST, which I can enable/disable as needed, without affecting
> > your option.
>
> Sigh. Can I ask what the use case for this will be? And we are going to
> get rid of BLOBLIST_FIXED at some point, yes?

I thought we agreed that this was acceptable. We argued the toss for
months on this point and I would rather not revisit it.

Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
pretty sure it can be done. The only tricky bit is coming up with a
bloblist protocol for x86.

Regards,
Simon
