Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB1EB8FDE
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B132986410;
	Thu,  7 Sep 2023 14:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGcKpqd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680698664A; Thu,  7 Sep 2023 14:23:16 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6562F8620C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so1201866a12.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089393; x=1694694193; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IHfKzf2iL9gmdaIotOyaQVKh5c2nrfEF39mBFdpFhSE=;
 b=VGcKpqd0i7OKATTOtVo0VEbsKilum/mo1gqFrH1WKHgqgM2ELXfQg6O7qAaUpR7byn
 TznmsRtCu08kCY6Du6axix+nawTSKtjiaNyBdOeBF8OuQr6CKtLIQEFgEvBs8qSr4YS3
 wClyK9DrPUPjS+mvhjYOULZxXlvGhWgCTIeiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089393; x=1694694193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHfKzf2iL9gmdaIotOyaQVKh5c2nrfEF39mBFdpFhSE=;
 b=Hzj2gN1IMBU1nTmPdnauKr+2JRJrdL234Cu6xRYuPkMrytWwl3GcZfJE/fhHqruxuz
 CTwllEG/pdQzlE4YaAHOc6IymkBSEuWQwpz5oxD4hqXDnqHxm06PMqgxGZLeGBjqg0sp
 GZ/CJMljbvJVec73J/pXFDNO2WFKKDMVJTW4lvchGj79AJKFWD6Ge1TgvwTY7Li4lOwu
 0vzYqysTHuSfG74Nb43sQkntsiNoxOGoXo4izD9mKEM8vE1Y0NueHvglbbcVAKl7lMuf
 rotfrtBVc+cCo6HCMcH0IU2LcnftGsxstVAuNOXJujUzZtwN8dkAch9XEkRKhlNyEqgg
 GwCw==
X-Gm-Message-State: AOJu0Yxc9l3tkzGwMNQiYeLBdPjKI0JkwrfzkFVmZtw1GNIF2ozg7q3I
 Y/PVBwwtIySS/Pf+xokibV9g0N90EzhX0EI5SsCKgA==
X-Google-Smtp-Source: AGHT+IFg2MHvJwn3jAKWTr17/VivliHvsPyUCcxo8mHZqiw7scBu7vIcmZMr9Vgw4OSu8UGZ+J3h9sMeTetWpaYvEr4=
X-Received: by 2002:aa7:d6c8:0:b0:527:3a95:3fa4 with SMTP id
 x8-20020aa7d6c8000000b005273a953fa4mr5104623edr.20.1694089392703; Thu, 07 Sep
 2023 05:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
In-Reply-To: <ZPldgbS8mu+5DG7Q@hera>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:00 -0600
Message-ID: <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Ilias,

On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Rob,
>
> [...]
>
> > > > > > >
> > > > > > > What is the point of removing them? Instead, we should make sure that
> > > > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > > > ground.
> > > > > >
> > > > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > > > useful for HW related descriptions or for Linux or another OS being
> > > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > > some degree for not defining hardware.
> > > > >
> > > > > I have started the process to upstream the binman bindings.
> > > >
> > > > I don't think they should be in DT at all, they don't describe
> > > > anything to do with hardware, or generally even the runtime of a
> > > > device, they don't even describe the boot/runtime state of the
> > > > firmware, they describe build time, so I don't see what that has to do
> > > > with device tree? Can you explain that? To me those sorts of things
> > > > should live in a build time style config file.
> >
> > For the record, I tend to agree.
> >
>
> +1
>
> > > I beg to differ. Devicetree is more than just hardware and always has
> > > been. See, for example the /chosen and /options nodes.
> >
> > There are exceptions...
> >
>
> We've been this over and over again and frankly it gets a bit annoying.
> It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> exceptions, but those made a lot of sense.  Having arbitrary internal ABI
> stuff of various projects in the schema just defeats the definition of a
> spec.

Our efforts should not just be about internal ABI, but working to
provide a consistent configuration system for all firmware elements.

We cannot have it both ways, i.e. refusing to accept non-hardware
bindings and then complaining that U-Boot does not pass schema
validation. Devicetree should be a shared resource, not just for the
use of Linux. We already have reserved-memory, flash layout and other
things which don't relate to hardware. I would love to somehome get
past this fundamental discussion which seems to come up every time we
get close to making progress.

>
> > > We need run-time configuration here, since we cannot know at build
> > > time what we will be asked to do by a previous firmware phase.
> >
> > Really, I don't want to have to care about the binman binding. If it is
> > u-boot specific, then it should stay in u-boot. I took /options/u-boot/,
> > but now I'm starting to have second thoughts on that being in dtschema
> > if it is going to be continually and frequently extended. Validating it
> > in SR does little. If a vendor is abusing /options/u-boot/ in some way
> > they could just as easily remove the node in their u-boot fork to pass.
> > SR is certainly not going to require the node be there.
> >
> > On A/B updates, that really doesn't seem like a u-boot specific problem
> > to me. No one wants A/B updates in EDK2 or anything else?
>
> A/B updates might be implemented in EDK2 or any other bootloader that
> chooses to implement it.  The metadata information a bootloader needs
> to implement it are documented here [0].  Those metadata are not part of
> the DT.  If they were it would make sense to add them on the schema.  The
> DT entry we are using though serves a different purpose.  It tells the
> bootloader the location of the metadata (iow where can I read them from the
> disk).  Since bootloaders have a different way of storing their
> configuration, I don't think this needs to be in the spec.  EDK2 for
> example doesn't always use a DT and I don't think they'll ever use it to
> store configuration information.

In another thread with Rob involved, we are trying to provide bindings
for EDK2 to use.

Whatever the efforts of those trying to fragment the firmware
industry, there are efforts to bring it together with a consistent
configuration story. Ultimately I believe these will have to prevail,
as the complexity increases.

>
> [0] https://developer.arm.com/documentation/den0118/b/?lang=en
>
> Thanks
> /Ilias
> >
> > Rob

Regards,
Simon
