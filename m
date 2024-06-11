Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1631BC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9B78864D;
	Tue, 11 Jun 2024 20:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JVVZIgQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF69886F0; Tue, 11 Jun 2024 20:52:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281F78871B
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f96445cfaeso786664a34.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131927; x=1718736727; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLtd9gQDYOJsP717Q3Q1HIqxNVr2Iapx0vmvE7q1nZ4=;
 b=JVVZIgQafSLoFl+NBXOtvpWtnUzp3UP6e6pe9wRAlJNnmK21UsnA+SZOGHtidLeBJY
 EPK5w/t6+RoHVnJOfTV63aLgKgFRYA7qsjXWQUWe6/Mfaye9v7P1f//if+DGorf+JL7E
 jzw5wK1EuOWVe2xe5TTSQa4xKwBxkxH2kUfOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131927; x=1718736727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLtd9gQDYOJsP717Q3Q1HIqxNVr2Iapx0vmvE7q1nZ4=;
 b=HqGy2/DZbUQdl25gkRTa6lE70kZnKDzFMgkeXAx1MdWTMWdTT4jNZiF7TbtoRgPNMw
 5QjC1JNZrpPcAoAXuuF0AdSQ2bwOCpSjU7kW4Ia1Cq4FjynnRlKaSaXpKsGD+VfY47Dq
 Kv1b0tPFp2HrhYxYGxX2txlZwNiEK4ur8Cfyt/8IuScDuqqzjndPEdfHrYx2p5O7uMKo
 iYM1bo150YN7AuZQh1BL/oU+P8S/axau9dpsOCO7CuQk8sPwKp6tY76jo22CT6oogvGN
 5UN3XCYfp+/uLJ+RFDPhcUfzsGgKfhQabI0s5eHY+IaX0W2YhIrncPm8FzIcQW9XhWQp
 bMlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ6GTh5ypyghZKpLr5leh7sB4uJvGoeQZ1pXsLDkpe1iLVdKUGQMaEjLFyoUecIXQXeguMnu9m1Lv8B6SrHrPqSv6VzA==
X-Gm-Message-State: AOJu0YwRYXyAW7Hf/xBnBVpPuuyrM/XHg3jDBKK+na4Nz2sWdsg5rx6y
 bDVRTZ0f6dvJ5Gl73Ir5sDMut9AzPUMGhLyIro6n3rOXuqPjSYWk7qrSqRH66sDRh4t7Vf0/ltB
 GvT0urqNsBUd/kVZuyixU5CtLD8P6Un4EzURC
X-Google-Smtp-Source: AGHT+IEFZYVBelB6g3V7bNLWKqFRQHKc71pHnTgPEE58v/M9hgIms1/CQBBPXjKLnGyXUewVFoCa1QwdTIWeisic2ko=
X-Received: by 2002:a9d:6c06:0:b0:6f9:9d00:553d with SMTP id
 46e09a7af769-6f99d005605mr7546862a34.7.1718131926850; Tue, 11 Jun 2024
 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
 <b723aa8e-1d29-4904-953d-160caf097136@gmx.de>
 <5bd109ff-73ef-4bda-8b5b-2ab583c064d8@app.fastmail.com>
In-Reply-To: <5bd109ff-73ef-4bda-8b5b-2ab583c064d8@app.fastmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:55 -0600
Message-ID: <CAFLszTiU17kEPC4JGX4j-KJG7Ff=-fFnV9i2Ua0yvi-v-n6zhA@mail.gmail.com>
Subject: Re: [PATCH 01/16] lib: fdtdec: Handle multiple memory nodes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Jiaxun,

On Tue, 11 Jun 2024 at 07:48, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=881:26=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> Hi Heinrich,
>
> Thanks for your comments, will fix most of them in next reversion.
>
> [...]
> >> -            gd->bd->bi_dram[bank].start =3D (phys_addr_t)res.start;
> >
> > The conversion is superfluous.
>
> This is necessary as phys_addr_t can be unsigned long or unsigned long lo=
ng.
>
> >
> [...]
> >> +    __maybe_unused const char *final_name;
> >> +    __maybe_unused int final_reg;
> >
> > '__maybe_unused' is superfluous.
>
> This is necessary as when LOG_DEBUG is disabled these two variables won't
> be referenced. Compilers would complain about it.
>
> >
> >>
> >>      gd->ram_base =3D (unsigned long)~0;
> >
> > gd->ram_base =3D ULONG_MAX;
> >
> >>
> [...]
>
> Thanks
> --

Can you please add a test for this function? Perhaps test/dm/fdtdec.c
might be a good place?

Regards,
Simon

> - Jiaxun
