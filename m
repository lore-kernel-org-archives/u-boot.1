Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E11BC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD7E874D5;
	Thu, 21 Dec 2023 10:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leg+d0XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D48787851; Thu, 21 Dec 2023 10:19:27 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2690686DD1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cc6b56eadaso5936481fa.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703150364; x=1703755164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uDemSrSCC7wapOEhjkIyzvOTULVkxQZLwLP09D5fI7c=;
 b=leg+d0XJVbBOuDkxEarY5Gd8YaXXb0UoIJBl1ebIq3hUd7dTLo2z4dPGplluOOxmFL
 1+xBYusND1Vq4bITJyn0NKYzQXFHpcfTUcgefV0WhBAlSVxHO7rKx6nNKURffDoV+Ks6
 DiUBWY1WrUGmbUykxPTz5oJ2mjgE6CsUemNIRhjyRMyvWiMrBz0BwVxa0B25Lv+GT4Ls
 qf/QupC1LXzo7cc+7/hbSQoxwMMOMLFO560uf3YrhZNk+4C3LFMgCNlUmJH+s7fz9/1s
 jhXHFFwMYYlsErb4ITlN5Ug44RSr1VYM4hfomUqt6gHuP0aOWwAiQ3bK2bWQN+fb6d8J
 IlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703150364; x=1703755164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uDemSrSCC7wapOEhjkIyzvOTULVkxQZLwLP09D5fI7c=;
 b=HZ9ndSZ82hWe1r+N8tc8r6toOr6GtqNNmwgxeoAe7zv08cyIi6ZpbF+OV7/HIvCWb8
 TVEQd1mEVdrDj1Vdi1jKE1fuAFohiLnyxAyKokyqyULpVbpQCF/hN50ChVn/nhNeKVvo
 ftYLxTGD/Od4FCCwxCevFzPi0X9KU8EntgMi2zTeu3tliaKMN7VboQrZPbA7J5MY/ABl
 0JgZ8ADNhmBzXblNtXWTEHagXBgaGBge8XHEwvjX2vCvW4GuLhH9+FQe+Z9tQhtz85MX
 Ms+tn3TvlVCLr0xN2SZPBanHpqqnR3xcags1raILKth58p7aVQDBu90atNrvdLkcQBVb
 jIBg==
X-Gm-Message-State: AOJu0YwMwey/bzzVDoI6lRD34jvlUa6444c86BVhpwv0k+s5QPNi0d9W
 mVMtUJjtWRD6u1llqc8uSGT31sU3FJedf2W3bhf8iA==
X-Google-Smtp-Source: AGHT+IFDb/fRT4H9Ss0Iws+GADNg1oT6Y+PYscLymCMpNT4sK83WIIRt400XMVY5/rdm7Fv0Vdb4r7s8vNxSv2KTO7o=
X-Received: by 2002:ac2:4e06:0:b0:50e:553b:2883 with SMTP id
 e6-20020ac24e06000000b0050e553b2883mr1356904lfr.85.1703150364186; Thu, 21 Dec
 2023 01:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <22dc0cff-ab4c-4a07-9aa5-da30eec4877d@linaro.org>
In-Reply-To: <22dc0cff-ab4c-4a07-9aa5-da30eec4877d@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Dec 2023 11:18:48 +0200
Message-ID: <CAC_iWj+VeijvDvfakcVybhNSPACc5DYwk1xnTDm=ZwxdqdC6jg@mail.gmail.com>
Subject: Re: [PATCH 0/2 v2] Provide a fallback to smbios tables
To: neil.armstrong@linaro.org
Cc: trini@konsulko.com, sean.anderson@seco.com, sjg@chromium.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Thu, 21 Dec 2023 at 11:18, <neil.armstrong@linaro.org> wrote:
>
> On 27/11/2023 18:10, Ilias Apalodimas wrote:
> > Hi,
> > Tom asked me to clean up and resend [0].
> > I've made some adjustments -- The DT nodes are tokenized and a single
> > string is used. The DT node 'model' is used to fill the SMBIOS
> > 'Product Name' and 'compatible' is used for 'Manufacturer'.
> >
> > The reason is explained in patch#2 but the tl;dr is that model doesn't
> > always include the manufacturer despite the suggestions of the DT spec.
> >
> > [0] https://lore.kernel.org/u-boot/20220906134426.53748-1-ilias.apalodimas@linaro.org/
> >
> > Ilias Apalodimas (2):
> >    smbios: Simplify reporting of unknown values
> >    smbios: Fallback to the default DT if sysinfo nodes are missing
> >
> >   lib/smbios.c | 109 +++++++++++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 92 insertions(+), 17 deletions(-)
> >
> > --
> > 2.40.1
> >
>
> I did it already offline, but:
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on libretech-cc
>
> Thanks,
> Neil

Thanks for testing Neil!
/Ilias
