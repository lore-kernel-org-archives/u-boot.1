Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247D4CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 23:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1336B83677;
	Sat, 25 Oct 2025 01:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h+MLC+wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DFF836AC; Sat, 25 Oct 2025 01:07:15 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C122F83655
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 01:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6360397e8c7so2942105d50.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761347231; x=1761952031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiVGfFJuj8BvTNn8o+mWhK9ioeP+880QldI0vkbAapk=;
 b=h+MLC+wr9gujZZqoy84ADxXuBBtLh+N/P99crmCsoADxwfMz1V1DrXbZP71iDJWV3z
 7DO8yJMS/R40i9p6hJrUBJKULSpN0Q/2O90GUYlsMjA0yq4Bl85R7C4Xlwrddi0c4cli
 Fko9+Cex3aJ7vAAOpR5H4ywlH4ZKYYLWY88P06x6gDFw9hOpx0hdX7hRkRaVggUKTLdZ
 denrINoU1c7/mj/KNMmEjTVFqZc7lUa5TfZw7Ry2jtY6ABseT7gUGGmhcKVua9v8RGDT
 dmDnysK3BO3IvZE3suV7FiO+3MX+rfa0efOlOMFL7MW8DqZj621GzbzwAwATvcDpds8U
 aHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761347231; x=1761952031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iiVGfFJuj8BvTNn8o+mWhK9ioeP+880QldI0vkbAapk=;
 b=tDsNsrPEBam2HqA0YLGgdedDWvrdHyXvJDf9tuiI/+732LidKZhOCuCGPNiMf4MvCb
 mtlZUATsHNVY6wdba0xucDGImWwZu8/SOYjGI+RCHKFdU45LOuKJfNFh1NyGT08DGDO5
 2Q9NUPZTidwvuWsri0vBJbWHVtCpWikJ9XRDjvrKAM2Tvz2psGVoGHdg5yrm4LI4X7No
 gxT6LV2Q7Qypdiu66aKkBOvdvMD6CnMjmlLNPCygsaCJAMlQ5gG90p+oJcd+fF149u+G
 eFqDdkxJ3wqM8bTOYKzX5pckstC8qrDdQC3JHVhQs3M8ohG70fc8ASnS/TrU6UnrW7GP
 gdmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz085egHtyb9wA+S6Unj+M0+Dk0XRgPMhgfIy1LZnVO88fhhyg7lSClMDfmjR1KqfoTNxgLyg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs+Et9ay17FAk6JLq36JlsBAUQm5a4oAIwpaFF0Gd8TNaN67CT
 cFGCKJAfrXIHLUy78h5OK/s4/soQnqE535JgALoE0PZuEvlql5747rNJhBHQ5NBhtA7E0YaDTOs
 wbOk1DkH9BWyIiLE+0w2jLGYmlB8acx4RkJGxwmJjyQ==
X-Gm-Gg: ASbGncsWOo1VKErQu5hh7eOX77VWX1P5XlnyyEJmg6jPdowEIlczKw2flBlpBKcGJAZ
 rVFYENhB3XTcx2aYrvPGLAsntFMZeZi/B5DFMoqRqynvAdX1paEpqW+e1BZ1I4OL8aKnLA87C9c
 43/xk9MrQTLKNfLFtyNlQZpnLCOb6Ld+1kdVqOh78NZETJRlpFolgyfP6XwIIe5CKHquZWKLlDV
 Gyp8fcfVZgRPLdloWDnqoaMt+0sHbAfhLacLAbuAWaSJtn5S9Z7mycHcXrTBgifBrJs8NXX4VZp
 s1EpRt2VO9KnpiriKdnOIjEpaQldeQ==
X-Google-Smtp-Source: AGHT+IF+dlXkz1pGU1go2N+6TWrmBhcUTVTodKuoYTBNnq8KIapnZczC3eZzx994KOzvnslurfwJKDh3AeKs1Q+AQXc=
X-Received: by 2002:a05:690e:418b:b0:63e:34ed:a11e with SMTP id
 956f58d0204a3-63e34eda7ebmr14651119d50.63.1761347231329; Fri, 24 Oct 2025
 16:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251006232538.5109-1-semen.protsenko@linaro.org>
 <CAPLW+4nSaDC02AfatZdMtsrp_7amF=wxB0XofioB+400heXKoQ@mail.gmail.com>
In-Reply-To: <CAPLW+4nSaDC02AfatZdMtsrp_7amF=wxB0XofioB+400heXKoQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 24 Oct 2025 18:06:59 -0500
X-Gm-Features: AS18NWDu80RYj1mUuNeq1ppbLACyadm0dv7lgYwNG6Fz9NM_5FEx-bfP4xpU_10
Message-ID: <CAPLW+4k7-kKAC88q89jJ+n7Uh8Cmei0hh7=TVXnrGh+pr3zazA@mail.gmail.com>
Subject: Re: [PATCH v3] doc: samsung: Extend E850-96 documentation to be
 comprehensive
To: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Oct 23, 2025 at 4:55=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Hi Minkyu,
>
> If you don't have any comments on this patch, can you please take it?
>

Apologies, I can see this patch was already applied on October 18 by
Heinrich. No further actions are needed.

Thanks!

> On Mon, Oct 6, 2025 at 6:25=E2=80=AFPM Sam Protsenko <semen.protsenko@lin=
aro.org> wrote:
> >
> > Add more bootloading details for E850-96 board. New sections cover next
> > topics:
> >
> >   - Hardware configuration of the boot device
> >   - Flashing and updating the software (multiple methods)
> >   - Booting with Standard Boot (multiple methods)
> >   - EFI System Partition structure for E850-96
> >   - Loadable firmware (LDFW) note
> >   - Ethernet and USB Host Support
> >
> > That documents all recently enabled U-Boot features for E850-96, which
> > can hopefully make U-Boot more useful for the users and developers of
> > this platform.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
