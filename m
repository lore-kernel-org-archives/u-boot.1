Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1DC07E97
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBCA87239;
	Wed, 29 Nov 2023 20:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="sl+ThhXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854B987613; Wed, 29 Nov 2023 20:45:06 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AAA86E88
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cfd9ce0745so23835ad.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701287102; x=1701891902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsOV8hYGBYKCnaU1Lv7RHjfNeS74iNy9oBb+fHC1xxQ=;
 b=sl+ThhXnsCnNFvurvUFqgDDEvoCkjVxSRfKlTHOfrJCJnOTocQdhN/tH+loxE8Ca+p
 unMdqXLuwp3QATUtba3F4DwQkDnaToiz/iE+xkN27D1mNlKMVsJycSfNc3CGrqlXJB31
 fN/q5DGmX57FWWebyLUHutXPZa96mUnOn3zwy3yg+BSmW8h+Ly6EaIktKPo8mCYb+u3/
 h/Sf/sJOSf1j0Hf7pSe7DrXKKNRjYkmF7fFArZAQOjiCMf9MRvZu1rat+s1twg51bwYt
 mlZftEt/quvUFRvYSsANIIikPv+fMjF3OVY55+wn1ac1iRso5y0btfyLkO78ptHa35Nf
 MNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701287102; x=1701891902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsOV8hYGBYKCnaU1Lv7RHjfNeS74iNy9oBb+fHC1xxQ=;
 b=BQ/Sz+ch0ooY4+aIL3/YV44ZrnwiNXlb9PkMU2r42PVKJk2v7MlGXJYQXGZTYJYsG5
 eiA3hYwFspO4wT66iCAX5KQoA9KWOrfVsYJlsz+ncaJW+KyCgVhVYaNibafffkRWbQl8
 f6ZtKXKn7J8T53C+qG8Rf4We4idIiK+JkhmB5zDV3O5jEQCYv3EB7EQlkZE/5wiOsfKX
 vYhXZ5v1hY5h8OlpH2ncpbnmAsqjTkJhz9e0xFVhzUgCRyQYZYBrJH0Bo+PV+o7Ez/sp
 NUUbfZxv/Jd3jG7k8aP03NJHXvopYmqlkT6sp78W3r0yjelanuGGNfBM4nsJV6RDHimt
 xc5w==
X-Gm-Message-State: AOJu0YztkYjmlzm7CmfD5aHQxcuKguPHt7+FatCBG3s0m7b520YGBc8w
 Ku+EZp+Rk0mg8h+Al8fUEmWlx+QY0m556o4vEpMDWw==
X-Google-Smtp-Source: AGHT+IHlr5agoWPa3Zi56NEWvFL7z0wrvx61Oj+T5Y8PNFo5t6XTqO5dUMniKCBME9EM+pGKtACDwfCM2nEsVkdnFdc=
X-Received: by 2002:a17:902:f685:b0:1cf:acbf:d0b5 with SMTP id
 l5-20020a170902f68500b001cfacbfd0b5mr17587plg.1.1701287101652; Wed, 29 Nov
 2023 11:45:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
From: Moritz Fischer <moritzf@google.com>
Date: Wed, 29 Nov 2023 11:44:49 -0800
Message-ID: <CAFyOScryXf_J7ya7aFgQPQA6qLKt74EOuADw0LL1CP2nTopypA@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Simon Glass <sjg@chromium.org>
Cc: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 andy.shevchenko@gmail.com, trini@konsulko.com
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

Hi,

On Wed, Nov 29, 2023 at 11:28=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> +Heinrich Schuchardt
>
> Hi,
>
> On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
> <phanbagiabao2001@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > I am a trainee at STMicroelectronics France. I am working on a project =
"Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-A=
 . The objective of my project is to add a way of booting (with ACPI) besid=
es Device Tree available on STM32MPU.
> >
> > I found that ACPI was enabled on some x86 platforms but I don't know wh=
ether it was set up on ARM or not. I found a PATCH that discussed Enabling =
ACPI booting on ARM with Raspberry Pi 4 but I don't know if it functioned o=
r not. Did anyone here succeed in setting up ACPI on ARM by U-boot?
>
> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> but I don't think any U-Boot board uses this.
>
> >
> > What are the differences between x86 and ARM platforms when enabling AC=
PI? The architecture of my board STM32PMU is ARM so can I apply the techniq=
ue used on platform x86 for my board?
>
> Firstly I wonder why you want ACPI?

I think STM32MPU is as good as any platform to get the pipe flushed
with enabling ACPI on ARM platforms.

Overall I think it's a worthwhile endeavour to get this sorted for at
least one ARM platform as a starting point.

> Secondly, if you have the tables somewhere it should be easy enough to
> build them, building on the series you pointed to. Heinrich is
> interested in this, I think. I can help with advice. I have been
> toying with going back to that rpi series but have not done so yet.

I've started to mess around with this over the holidays. Feel free to
CC me on future work in that direction.

- Moritz
