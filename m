Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C345C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFAE88377;
	Tue, 21 May 2024 19:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zS8B4/0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F5488381; Tue, 21 May 2024 19:33:05 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F7C882A7
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5238fe0cfc9so80647e87.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716312782; x=1716917582; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94TAcHmgVWv6vmoOc1ayPV0eHjLfndNJMmOHpKwcvPA=;
 b=zS8B4/0ozxBWc4eZBdY6Ho8bT5p+SRAXnyrzeK2drZR2EJfXg58fuC52jbj+0Jrf/h
 ihE9pW7vx6AWMndGGTKTB3Y6ucgGNMPnrFcmumt12kA9Tuhjqvv+zscQFMXAN7KfnKss
 nGjTig2AaMGeXiqex1R6FxBKuP9LuVnGVCp2a7mnO9deNUM6D5G/cRbxkUtM398RfBJN
 jaM/5LaOgVQlz9i8GtZ1kZOM5aUlNuAkEESXg2kxMaEg7xfN4ox7R0Z9sT/HGK4EVki+
 6FjBEUF/aHf1+O4mNIW2QQ1qDWDTaJ1EcbAIZDrYovhcrM6XpW9x7fdmTWJ84ZKBCheK
 so2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716312782; x=1716917582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94TAcHmgVWv6vmoOc1ayPV0eHjLfndNJMmOHpKwcvPA=;
 b=rjAMyFl4JgruphbvQ+0VAAzDTNbfFtZoSFKXv+hlaaLIkwlNIaoMqLz+YzBrYV4xDu
 zQTnwYvFJaFPRWMYhf0kquS4uOlFjLrnaWGCxuvmY/nCRq/VrqqGZwqsxVGphL05ky3T
 Eo+s1SBJTU/18KpeY9jP/xe//EQyFqSRL5yIcmWgoCSZ+Me+sri/1U2yfYCj4cuRhTa4
 B+gxIkHhVJ54bg4vZpO2H8ISjA45vTRbXFjc/aONGJwOx8VCmVIZ0a4lWLoX3vDzuWhR
 XuIhLPGnQLHHm7JNbqDXk1cibIHYfvp18UbO/0U6k92XF8al+krnH/Q86lUzSVLl13S2
 tcGA==
X-Gm-Message-State: AOJu0YyjFvYtMeMx494LvEJhKRboR+p/NPxu118HYSH0OWi47JpyXnIE
 PMZUA6duS4hMmDV2YAoOELxnay1RHx/rGovQ8vYRLbK75w4d24Zzs2u2mgviHjZdgBAhaZ049BF
 3ULD1mAu9aW7q/cppLvUWyOnoJu9PydJ1xeviFw==
X-Google-Smtp-Source: AGHT+IFGEUJ3Ew0/F8hYU0iMPt6wMAUDfdmoX/e9pXvHbxrWahcHem17ciGOPYQrQf9MceRM+1MgB5e5jlENEUFyIgM=
X-Received: by 2002:a05:6512:1587:b0:524:60d9:3a7a with SMTP id
 2adb3069b0e04-52460d93affmr1886502e87.31.1716312782403; Tue, 21 May 2024
 10:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
 <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
 <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
In-Reply-To: <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 20:32:25 +0300
Message-ID: <CAC_iWjJuMkmHJvs6r3yd+fB=tGZKV0+CkaykEfjiwaC8NikfHQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] efi: Allow runtime relocate to be disabled
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 21 May 2024 at 17:42, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=882:58=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Jiaxun,
> >
> > On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
> >>
> >> Allow runtime relocate to be disabled because on MIPS we
> >> never do that. It's guaranteed that OS won't call
> >> set_virtual_address_map and convert_pointer as well.
> >
> > Who guarantees that? Is it only for Linux?
> Hi Ilias,
>
> It's guarantee by all the existing implementations, ventoy,
> linux etc.
>

What's ventoy? Googling it seems to be a tool for writing images?

> It's nearly impossible to run MIPS OS in virtual (or paged)
> segment. All MIPS OS and bootloaders are running in KSEG/XKPHYS
> segment, which directly mapping lower bits of virtual address
> into physical address. So I suppose set_virtual_address_map
> is unnecessary on MIPS because the mapping for U-Boot is
> always here and can't be disabled in hardware.
>

Fair enough, I am not too happy with the restriction but I think it's
ok to start with

> >
> >>
> >> On MIPS KSEG0 is always mapped to memory and there is no
> >> way to disable it for kernel mode. Both EFI runtime and
> >> kernel lays in this segment, so relocation is totally
> >> unnecessary.
> >>
> >> Also U-Boot does not use traditional .dyn.rel to perform
> >> relocation on MIPS, that makes implementation of runtime
> >> relocation pretty hard.
> >
> > It already works on other architectures so I suppose it's only a
> > matter of adding it?
>
> MIPS is odd here, we are not compiling U-Boot with -fPIC, instead
> we use our own tools to generate relocation records and embedded
> them into U-Boot.
>
> Adding relocation support requires modifications to that tool
> "tools/mips-relocs.c" and also processing our own record format
> here.
>
> Given that set_virtual_address_map have no practice use on MIPS,
> I think the best way to handle it is to leave set_virtual_address_map
> alone.

hrrm any idea why? Was that a pre-existing state in mips? Perhaps we
can fix it in the future.

That being said, I was away on a conference, I'll have a look at the
mips patches, but probably next week

Cheers
/Ilias
>
> Thanks
> >
> > Thanks
> > /Ilias
> >>
> [...]
> --
> - Jiaxun
