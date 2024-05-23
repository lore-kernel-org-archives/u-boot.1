Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B97AC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB46B87F8B;
	Thu, 23 May 2024 17:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M3tQuGLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8F3885A5; Thu, 23 May 2024 17:47:38 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903DF87F19
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51ff65b1e14so9182681e87.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716479256; x=1717084056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wp/GOE1/Y75SbW24mwNo6ZGcjTnH5totoaemVEdfba4=;
 b=M3tQuGLjd0ZFp5JjRMSZJR2dHnEZ9meLKFV40YA1PUVzPkPeT+/i7UGbpUnTVaIHlm
 XT8ubV2Oct2SOO9GfEDqQGiYk2Cy2CqgMf2rzbrXoQIj9pmQRou95xAcYYq6lI1WshRO
 EWQ/OWQdk2ryfnR7pqF1TIOCjJJUTqbEHMx0rxye/7lzmdH3GgbCRRF8VA+lG1aGrlZR
 IreSfeEEteB1L1vA4HYL7ObujHsOrzpC4HUtmGMip3kP0VcGqDBqLR2ijlY8q0+ECIEr
 7HmrZXK2jK+zAVJN0UQui7HfNUo1CNSBpuPjJj38I52q4Xr3ZR0Rr8sUnVggUVR3+qwG
 Wa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716479256; x=1717084056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wp/GOE1/Y75SbW24mwNo6ZGcjTnH5totoaemVEdfba4=;
 b=jRlpgu7KOcVAq+o0xduLqzJKmOKiKr9R9TbTcK2miZuSsS5n7YxtAmEmIIp/lBe3FZ
 RVCQ+uhXuY339qoaCm9iioPBCTBgXaUa4Gn3h1IlAEF/oaEZiBAvh/3vl0ZnJoBejg4N
 L4o+xJxFq6TzCscMM8Vo/+Yn/+QjKDMrOw40TeAoqEDdBBClu88F6H7k7yyqAxdO2NtZ
 2Spg5TFRyTPHiypZ2M++vxyQyv4i6CsiiGe5F23ZDc8WQL/OGGVjQblMchm5qO6N9vJm
 s7y71fkcs+bF4Jjw+rilHNDbSr6GlhxKlZGlg6EP5dwdwxlPjGW9/I94fqiI2qj3EQoO
 3d0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8f0AMfrF+DHDXtcjvFn6JKqHCwP7sNwSCJDIw00jqqoZ1uivtj0KuuvP45iwLd5zSudC+VL3KLUk9lOQXwRDdV5K9/w==
X-Gm-Message-State: AOJu0Yy2v0toJE0iM9loco5UEeqGiy8YoFq5B6IC9NWb8AUcMbAKMP9V
 +rPG1A89ZFxz88fLR/bK45wyZ353gJL7GUQY3Jg9uVnSwXQyBqN/k5hXzPpZ0JeR4LbfxGPhI/s
 kNCIMYjeQ0hOPbiFuQkAdvGYTvIY=
X-Google-Smtp-Source: AGHT+IFcvJPlMZy8gb+DMNI0GxspJYNHWB0hWk1L3tFWsKVgYeqMPZWjBOhPFrxx9yMNl5Xx3zLQ7zEG8N3nLo0SHMU=
X-Received: by 2002:a19:640a:0:b0:521:b1ca:9c99 with SMTP id
 2adb3069b0e04-526be8d483cmr3433479e87.5.1716479255498; Thu, 23 May 2024
 08:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240523152540.GR2568172@bill-the-cat>
 <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
In-Reply-To: <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 23 May 2024 16:47:24 +0100
Message-ID: <CALeDE9PFa-KOD1dhNumuek3kodn7FeOwoEZ=-5zmA7bahWevNQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] LoongArch initial support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Thu, 23 May 2024 at 16:39, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=884:25=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:
> >
> >> Hi all,
> >>
> >> Sorry for flooding the mailing list recently, yet another huge RFC ser=
ies ahead.
> >>
> >> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, as =
suggested
> >> by Heinrich.
> >
> > My big feedback here, and it applies to all of your other series as
> > well, is to please update CI to make use of and test this. On the Docke=
r
> > side, update tools/docker/Dockerfile as needed. For Azure, you can tell
> > it to use a different image and then follow the documentation on
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html and for GitLa=
b
> > you can at least use their "linter" to make sure that your additions
> > have the correct syntax. Thanks.
>
> Hi Tom,
>
> Thanks for the feedback, I thought CI is for custodians only :-)

Well when this lands you'll become a custodian ;-)

> Do you mean I should include azure/gitlab pipeline file to create
> pipeline for those new qemu targets?
>
> Thanks
>
> >
> > --
> > Tom
> >
> > =E9=99=84=E4=BB=B6:
> > * signature.asc
>
> --
> - Jiaxun
