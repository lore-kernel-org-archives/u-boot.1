Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EF1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FA6870B7;
	Wed, 20 Dec 2023 08:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MdLNVqFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE688700D; Wed, 20 Dec 2023 08:52:05 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CA08751B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e51a7545dso431859e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703058722; x=1703663522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TK9oujUSnCTLzz5ayFBiTm0Cib9LJs+GXoi/tIzj02I=;
 b=MdLNVqFiXx9/hnaArrWLTWuCDD+io7v2Lc4s3Ha7Z/WFxBPzNnejZRd3O6lHVNmFq5
 1/VvcO4pTQ+3w2J0sfcNlZgiXsFQP+mxUJi5XyULJoOJouydZWWL988v0qZzb3yVe9Xv
 x+uZWK7N3kbWXrWJEt2ehe1LPmkxP7i9C0LPZUF86Zc9RpKwFPRGi/nIB3Z08lqBd6Hp
 kLAYag0fo+xbuSElOsfb3vyDLcBr5hZlpftgal60HD4yCERLAMZdeaK/d4D5s74Xxo6W
 4mvPFjQiAmdnz8v4H3jSI9GEf0KiQcWpuVGe+0xqlsOStgFIjNzb0TF2c2RdHQjh0bbu
 Pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703058722; x=1703663522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TK9oujUSnCTLzz5ayFBiTm0Cib9LJs+GXoi/tIzj02I=;
 b=Mp8JLYbfavRJr8FR2wixYib3MFfDJaB8rI6QozY5Ci0Cki0GvJl7TOE4MlallzKJKq
 BGONGr5Fp4nkpy3IZWjr8GK5RXST2aZASsUI0uJW1SWS4PV78/3CCtiZlwJg4k8HLnS/
 p5PESBsFQEki4W2Rk5i0JogXNRPwfcyyaMeG+m2OhQcqVnYUwCTKnsIE8xYA57tmrXME
 XU1YEM9vcKDXsZKO79tgt9DPqHufv4imPBLMwhfzb8fgqW82PqJGBbzE63qxyVHHFcD6
 qyKajut/Gdb51Q74VsnYa0FsEWQHnsWIiuBAPY9OwdYYCGhW63wich0PucYf2Avm3SVv
 18WA==
X-Gm-Message-State: AOJu0Yz3e/zF0tErP6gpxPqxRoocrl2w2ccbQInv72PVaZHrEbmUDcRc
 HIz9XDkyH+LZkRYdNlmpCnekfEfbtsCjAGV4lMNx47TNhpMqrBdl
X-Google-Smtp-Source: AGHT+IHhHAjZDYgj+sVQhQ1JNib7Un2UBO6cUtJxV8PFb3N3TLqeqy/2kC8hRDtDsGRdfHoiLjZ3w4ZJ5Pvw7Pih0Rs=
X-Received: by 2002:ac2:548b:0:b0:50e:399d:f0d with SMTP id
 t11-20020ac2548b000000b0050e399d0f0dmr1964514lfk.93.1703058721755; Tue, 19
 Dec 2023 23:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Y5Dzhp2c5qsoDEjY-w8NsueEHgvCSfTEbtEOPMTJ9wA@mail.gmail.com>
 <CAC_iWj+zd5X7FiM7XQVPSj9a7cwxpo-VHR6TV36y98ust-Ckpg@mail.gmail.com>
 <CAPnjgZ1b3tSR3nh0H6Xu1RCp=Zid+TXfUVr0C4HvDtqWvyiMog@mail.gmail.com>
 <CAC_iWjLJo7zNBJ3N45ctDeuJSzKgQiZqQEQ-kRUFurehXpcArg@mail.gmail.com>
 <CAPnjgZ3BWYKiOowJV83WUgKmY3dWZmUy2a0fJ75=88Sb+OpS1Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ3BWYKiOowJV83WUgKmY3dWZmUy2a0fJ75=88Sb+OpS1Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 09:51:25 +0200
Message-ID: <CAC_iWjLs8+dUa1g5E10zwOQ7P2jCCSWsnC-CBQgmU8o5AiyfSg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

[...]

> > > > [...]
> > > >
> > > > > > 2.40.1
> > > > > >
> > > > >
> > > > > From my understanding, the only thing your fallback adds is the
> > > > > manufacturer ('vendor' from DT compatible = "vendor,board"), and the
> > > > > product (from DT model = "..."). This is an awful lot of code to make
> > > > > that change and it seems very, confusing to me.
> > > >
> > > > Can we please comment on the current patchset? Future history and
> > > > digging becomes a nightmare otherwise.
> > > >
> > > > >
> > > > > Instead, can you do something like:
> > > > >
> > > > > if (!IS_ENABLED(CONFIG_SYSINFO)) {
> > > >
> > > > That beats the purpose of the series though, we want this as a
> > > > *fallback* not disabled in the defconfig.
> > > >
> > > > >    const char *compat = ofnode_read_string(ofnode_root(), "compatible");
> > > > >    const char *model = ofnode_read_string(ofnode_root(), "model");
> > > > >    const *p = strchr(compat, ',');
> > > >
> > > > No. This is just a quick and dirty patch that allows you to split on
> > > > the first comma. On top of that it won't work for cases like 'model'
> > > > which, most of the times, only has a single value (which is again
> > > > explained in the patch description) and you have to add a bunch of ifs
> > > > on the code above. You could only parse compatible only, but model
> > > > tends to be way more accurate than the one added in the compatible
> > > > node. The first is a full description of the device while the latter
> > > > is just a trigger for driver probing etc.
> > > >
> > > > random example
> > > > model = "Socionext Developer Box";
> > > > compatible = "socionext,developer-box", "socionext,synquacer";
> > >
> > > But your code does the same as my fragment above, doesn't it? Only the
> > > compatible string is split, and only the first part (before the ',')
> > > is used.
> > >
> > > For the model, the whole string is used,
> > >  so having a function to split
> > > the string, which doesn't have a separator in it, seems unnecessary.
> >
> > No, it's not. the spec says model = <manufacturer, model>. Some of the
> > existing DTs follow that pattern. In that case, you need to split
> > those as well and that code would start to look really ugly and non
> > extendable. NXP and Qualcomm boards are just some examples
>
> Oh that's interesting, for example:
>
> model = "Qualcomm Technologies, Inc. SM8550 QRD";
>
> But I don't actually see any use of 'model' in Linux that has a
> vendor,model approach. Also the existing values are clearly indented
> for display to the user. I wonder if we should change the spec at this
> point?
>

I don't have a strong opinion on this. I'd prefer if we left as-is and
slowly fix the existing DTs to include the manufacturer. It would be
way easier to parse those values.

> >
> > >
> > > I am not talking about the end result, just trying to make the code
> > > easier to understand. It is very complex right now.
> >
> > The function has a pretty clear comment on what it tries to do.
> > Also if we do what you suggest, adding chassis-id would mean that we
> > need another round of strchrs and ifs and who knows what else.  With
> > the current patch, you just need to add an entry to the array
> > something along the lines of
> > { .sysinfo_str = "chassis", .dt_str = "chassis-type", 1}
>
> Yes I agree that it would be easier to do such a thing and now I
> understand why you have done this in the code. But why would we do
> that? We might as well use the proper sysinfo binding in U-Boot,
> instead of inventing something like this?

This has been discussed over and over again on why we need this. I
don't see any point in repeating the arguments. FWIW the sysinfo node
on u-boot is the invention and this is re-using existing DT entries
that dont need extra work.

> Or would what you propose
> here be easier to upstream? I'm just not sure it makes sense, which is
> why I feel the code is over-complicated (and still has no tests even
> after all this work).

I don't see how a for loop and strtok are so overcomplicated.
The code *never* had any tests. In fact, it has been broken several
times and Heinrich and I are the ones to fix it. No one argues the
need for tests, I just don't see why this is a blocker.
As far as upstreaming is concerned, I would approach the problem
differently.  The model, manufacturer and chassis information are
already in the DT, so I don't see why we should touch that, apart from
amending the existing DTs with 'better' values. For the rest of the
info SMBIOS lacks (memory, cpu etc), I'd look into the existing DT
spec and add the missing bits if they can't be discovered
automatically.

Thanks
/Ilias
> Regards,
> Simon
