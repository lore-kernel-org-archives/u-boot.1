Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DBFEE14D4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 05:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2F386410;
	Thu,  7 Sep 2023 07:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y6Qyk0pZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEAC86571; Thu,  7 Sep 2023 07:20:08 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B849C85FD3
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 07:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so525753f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694064005; x=1694668805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bWnyNjuKkJmCuvM0S4BKE6PTUxEHxGTwaij1j0O5u8k=;
 b=y6Qyk0pZk05frv957H/THlDPUdzojSmXvUs5Hkk2pj99jE/XRoa4rHWlW77uvQuOBF
 lzLSd8LFHxtjXdGcZGfsRyGGR3JJUtDECZslMMtwNhcuXYh8vKtQRfOpaMDWnSfE2hHd
 VQJJY4rC6EZYd9Vf213JyocO0xzBcUu2fB49ct2u4iMmBYuwGAIC6/++0raRg1jQBAga
 cYCq0nfKAbwzNwCT07Qp0zBduw2fjJJyfUJCX9Ao00eaLnBbr8bn0fl5QbFg/K5JVm4R
 VHBdf+d5MnjF+Pa4MMDffwiXRe6UaX1PmhSYYPxckN2zNOJ1ZTA7nnHcbggaqQQIfbgz
 jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694064005; x=1694668805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWnyNjuKkJmCuvM0S4BKE6PTUxEHxGTwaij1j0O5u8k=;
 b=Dv8AFp1aZke6PY9y+Vs31K6ac1QYZKvf+904JwPAfdyVsl5fZpeKUyDQI/P1psZImr
 uvwrGU3jN+FFmNXotSOTzjDKQUuBbentjL6UW+eTsyczo1T27tualjfOfAeWH0O+/LQ9
 WOR1+3lqAkwrotilxB/26fiibYT6XO2fm2+1XUXbNjVSU50AmOZAfI1DyoVkIJ49gGJ9
 LGHLoLT8DDDiKoQ3Sbmx8vdkxp8SfBXetGlLe7heYbdM2l1d9Agerh169B+J9iABSPiG
 Zuou61cLhwlEmsBdLg96xaMNWEhHF5BjNWgY5yXrPa46SnU/W5skg0zdmFTppuj3TSqv
 uvqw==
X-Gm-Message-State: AOJu0YwM4qdIwAQaNN7mS35hKm2AXrOZausmndB2qUxqm8zhjxg1c8FD
 wiK1VPv5vEBsn8MPtWap06kUKw==
X-Google-Smtp-Source: AGHT+IHFnc3ocY3qFSKrV8ESrTGgxtDMkXQ1nSM95MEldr8v3Qt9+oblG1jL+PANuqwyCWV3MsZdTQ==
X-Received: by 2002:a5d:4041:0:b0:319:68ce:2c53 with SMTP id
 w1-20020a5d4041000000b0031968ce2c53mr4012529wrp.25.1694064004642; 
 Wed, 06 Sep 2023 22:20:04 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 i11-20020adfb64b000000b0031f729d883asm254350wre.42.2023.09.06.22.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 22:20:04 -0700 (PDT)
Date: Thu, 7 Sep 2023 08:20:01 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <ZPldgbS8mu+5DG7Q@hera>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906142139.GA1236014-robh@kernel.org>
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

Hi Rob,

[...]

> > > > > >
> > > > > > What is the point of removing them? Instead, we should make sure that
> > > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > > ground.
> > > > >
> > > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > > useful for HW related descriptions or for Linux or another OS being
> > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > some degree for not defining hardware.
> > > >
> > > > I have started the process to upstream the binman bindings.
> > >
> > > I don't think they should be in DT at all, they don't describe
> > > anything to do with hardware, or generally even the runtime of a
> > > device, they don't even describe the boot/runtime state of the
> > > firmware, they describe build time, so I don't see what that has to do
> > > with device tree? Can you explain that? To me those sorts of things
> > > should live in a build time style config file.
>
> For the record, I tend to agree.
>

+1

> > I beg to differ. Devicetree is more than just hardware and always has
> > been. See, for example the /chosen and /options nodes.
>
> There are exceptions...
>

We've been this over and over again and frankly it gets a bit annoying.
It's called *DEVICE* tree for a reason.  As Rob pointed out there are
exceptions, but those made a lot of sense.  Having arbitrary internal ABI
stuff of various projects in the schema just defeats the definition of a
spec.

> > We need run-time configuration here, since we cannot know at build
> > time what we will be asked to do by a previous firmware phase.
>
> Really, I don't want to have to care about the binman binding. If it is
> u-boot specific, then it should stay in u-boot. I took /options/u-boot/,
> but now I'm starting to have second thoughts on that being in dtschema
> if it is going to be continually and frequently extended. Validating it
> in SR does little. If a vendor is abusing /options/u-boot/ in some way
> they could just as easily remove the node in their u-boot fork to pass.
> SR is certainly not going to require the node be there.
>
> On A/B updates, that really doesn't seem like a u-boot specific problem
> to me. No one wants A/B updates in EDK2 or anything else?

A/B updates might be implemented in EDK2 or any other bootloader that
chooses to implement it.  The metadata information a bootloader needs
to implement it are documented here [0].  Those metadata are not part of
the DT.  If they were it would make sense to add them on the schema.  The
DT entry we are using though serves a different purpose.  It tells the
bootloader the location of the metadata (iow where can I read them from the
disk).  Since bootloaders have a different way of storing their
configuration, I don't think this needs to be in the spec.  EDK2 for
example doesn't always use a DT and I don't think they'll ever use it to
store configuration information.

[0] https://developer.arm.com/documentation/den0118/b/?lang=en

Thanks
/Ilias
>
> Rob
