Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CE0C36011
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 01:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C11805C8;
	Sat, 29 Mar 2025 02:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4HaG/qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DC080ECC; Sat, 29 Mar 2025 02:00:44 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EFC800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 02:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3014678689aso4017553a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743210040; x=1743814840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TA164+3zJJVMerjLATb3sD9+1tNkbDdpo76/yS1c6h4=;
 b=K4HaG/qnvZfjT1VmBBmrdkDvNMUFlUKvcRGKJEtUbRjJ83hx6cJyrxumakzd/qEYGQ
 zy4pI4z8V8mkF5fTxH0pFJMgazv5b1Ig2r6FPCiZGMPsLFtUDVMBOGBJzNKX1dRLlOwa
 K4al/PhkZqC97CRzhwKGbfqMzSoBdLIrwuhOrTM/V5L7kiOsWMtLEfIW+ePEazuZTBIF
 ypC+qrhmuW7PMT705iQX2S/G9LJg0vNxHek8WvhBt7v4Bjzr71dve6ilqJSNRzXSTJSS
 RhhgNojv+MutZfGyZf35NoJOLKxZLhs30gc7xWbI9CgNlfiBeWLLc4+h3yo+OIhjrUh8
 ilTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743210040; x=1743814840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TA164+3zJJVMerjLATb3sD9+1tNkbDdpo76/yS1c6h4=;
 b=KgBxjnXUA4BaU0HVGm6qTVf5EP6Mjd+WTumVRmkzXHVYYZnOcAi2ZkXr8iYt1Slncb
 z4Y4si4DFwVHiXyv4pzNfRj7l4wDHWCJD0gWuzv+CTA/elBNBWQusbAUS/Qg7ePjPp1Z
 PWeZi0HrnwbaEx78piJGKI25JRpXw9HK61hLIQouCZXKuMAS9Hu8OCwTEQGa7hzJ++9a
 4s6CM8JVEbFpbWI4NSKvPzsOI0d+Nwz+YoIRgIZ2lNRkCao/y2ypYoKk0TUghFXIn8oK
 QXYvyrfrTC/xxXJ4ElCfPUSLvSXZl/WkZ8yqoSPqegxGvzsreqzdzD7MC6vtQBs+guB/
 ZPRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNwriqNua971jt2cK3SWryCQnvl5akbnOn+j49yBOuMCWuZY5nuE8ixf9l+VR2JMqvTy4/32I=@lists.denx.de
X-Gm-Message-State: AOJu0YxdyqV3zGhyldYAa7SBGer3WnPRVsiDQXK4RGxH+FPZPzdLQhYq
 vIslzgvrr3H1Xo2LmLrv314czjrmnCf5DuHHt2vGB4i5PYyuXgge5Pnv/KBvYAVM4ecQcDMaDsr
 SkLzV3rknAlS326Qs0TXQ2rG8kn2IekMLjen+6Q==
X-Gm-Gg: ASbGnctKdI50bNgsm7j+pHF7uGC084J78G2mgWIUsVatZhIeZiE9F2hpJllHph3CmME
 Odsw/LRLZc+XwsjNCm8cqCXoWVgx9DJCKWRqVUev6VWKyqNCm3GwFwgHLlcfK4xbVH3pTq1WDxc
 nTilR23y8P6LQD3rZlzfLLy1ezdPBN
X-Google-Smtp-Source: AGHT+IGiXzI7Dg+JbQGUukFmx5lvQLke303mYVs7DhpGMhSvC1nDBnWjJGqpKiGQhhgMRTPWch0jKLkcNPK74twvyxM=
X-Received: by 2002:a17:90a:c88c:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-305320afc37mr2001662a91.16.1743210040062; Fri, 28 Mar 2025
 18:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
In-Reply-To: <20250329000211.GH93000@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 21:00:26 -0400
X-Gm-Features: AQ5f1JqLhbP9i6G34A5SDR2O0lL762i_UZHjslmDtE5WM1fX5jIDIM0dzJAdEkU
Message-ID: <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

Hi Tom and Simon,

On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > >
> > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > so that it is simpler to understand and manage.
> > > >
> > > > - Unwind some of the nesting in bloblist_init()
> > > > - Avoid needing to init the bloblist just to get the FDT
> > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > >
> > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > be resurrected to give some coverage.
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > >
> > > Based on how it's documented to be run in
> > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > that platforms using the handoff spec still work?
> >
> > I believe so, yes. I don't have that board to test it though. Raymond
> > may be able to test this series on QEMU?
>
> I was pointing you at the docs so that you would have access to testing
> it. That's part of the docs, running the emulator.
>

I can help to test the firmware handoff on qemu.
I have all the necessary changes and unit tests for the OP-TEE repo
qemu v8 build to test this.
I will try to find some time early next week to review and test this
series before turning back to you.

Regards,
Raymond

> --
> Tom
