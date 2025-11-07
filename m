Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB9CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 09:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E065183CB9;
	Fri,  7 Nov 2025 10:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HAlYW3Gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372FB83CCA; Fri,  7 Nov 2025 10:58:28 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D156483CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 10:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7260435287so79851766b.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762509505; x=1763114305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cC2+63F0oy/+sUosYJaB7UVjW6R25xwc5MVCrSvEOFY=;
 b=HAlYW3GxSTVTyVx75l7lMtI5YSWw42+UiVVKq2LDVDzxJdVxTEWZ/C21XdK9uPOZe9
 l88jlnegqqDf7bLl4/nLu8GrQfKrk5kNEYCl+3xrIm+MW9SGbNbLBXB23RKTLhfuDZas
 JSRVu6xy0LQg+17bsnpum7M6rUwQAqZFd7iiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762509505; x=1763114305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cC2+63F0oy/+sUosYJaB7UVjW6R25xwc5MVCrSvEOFY=;
 b=PG9I7Vtz7iG4J8KqQvcb4G9cXtNkFeynP8nd0L0y/oBON7cIwBKoNFznmcD3ZVS6af
 LCEg0dIb19naoMzrw2zOzXZmrY6yK0Dk1J+eVxGvd4w0uM7YBcEY+3mY3vZMhxM4gimH
 G+ypBqp+rT9YxDLth/vVcA24kLmVmURqwiz1VrDSAddDB/mWk4jTNo3joPqvrBkuVewA
 Li1jrGFPyMz7kC+pjwTUe/UpjQE5nknIlPuHUriTiTdK0/DAODjyv9U0cTAAoHIg85+/
 sbrZ3bfLOuZRJxSAuO/nB9zSSn6FKlvbC9gH7yUjdiUi2gN/16JAQQaVgZzQIlaP5208
 A2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58w9HMNXGM3QQmQn//cjqdojPUoendxxUR/up74kk/R3hCSy0V0I/w8w8TLDjb4CdbeKvtxI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5WMG2LbFsAS17mN2j1JTrIbiiRy8+JN+p2KV8iB5cAzI+zE5b
 bo6vj2EbrOQ5ZEmjM9+4OtsnDaw8sY+etX6MmtHVDTMqaSyyDmBGF9AE7YqWae3wMxNevnJYgsf
 QjZwgEm2MtZGYUGD85MKasM5vbKaEx4wqcsXUjFg9
X-Gm-Gg: ASbGncs3sYSQJ2y/Qd9u6XfGwwHMqDk+q8i5OcuAMUDncedM8wUgCtch1IDToHFhdXA
 T+KiTy3hviwoGpKycrvhIFzGOEZZ45d41dOZq40MJiXUdCQEKe3G20paptj4m827EuAichN0t0j
 q9m5xL/NRoC2YXvaTf3kEJuamnpfHPY4xkOWAk+0GVZ8n4CdW/JwQorwpeYe14ycQkw++++AzB2
 oI/Ai8kAkzPYtkBM9ZjIvEAoM0k5tGQ1OA99Rlra8eRQ1hVB6rQJKhvfxW9zWqrvEB8tolyoJOi
 71DgnQ==
X-Google-Smtp-Source: AGHT+IFG3jnsWa8EiVi7/NLQ5zTzu3vSQyP7GlIwl300EwO5ExEFr2g9fYNrOU6Q8QCyQWaM6NR1N8q18wcKK6bxj2A=
X-Received: by 2002:a17:907:9623:b0:b72:67c2:6ed4 with SMTP id
 a640c23a62f3a-b72c091ee0emr225209866b.8.1762509505241; Fri, 07 Nov 2025
 01:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
 <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
 <20251106182329.GY6688@bill-the-cat>
 <20251107100517.6c79a976@kmaincent-XPS-13-7390>
In-Reply-To: <20251107100517.6c79a976@kmaincent-XPS-13-7390>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 10:58:13 +0100
X-Gm-Features: AWmQ_bl9WYVZy2j6ycdZh96IVyhMT-d1yW31yhCWXJJKgJ4HPOKBNqttCDBuxEs
Message-ID: <CAFLszTiWZXcGyGMWkjfSFdV4E0PCz5eB=6T6jMVvy1e6yMjF+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, "Bajjuri,
 Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
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

Hi Kory,

On Fri, 7 Nov 2025 at 10:05, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> On Thu, 6 Nov 2025 12:23:29 -0600
> Tom Rini <trini@konsulko.com> wrote:
>
> > On Thu, Nov 06, 2025 at 07:00:01PM +0100, Kory Maincent wrote:
> > > On Tue, 4 Nov 2025 10:38:16 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Other question: Is it possible to not add the environment to SPL image using
> > > the new text environment format. I have tried to update am335_evm board to
> > > it but I got a SPL too big error.
> > > I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
> > > It seems the same generated environment file is used for all images.
> > > I still haven't found were it is included in the build of the SPL image.
> >
> > It shouldn't change the environment size, but also environment is likely
> > being pulled in to SPL for network boot support which does require
> > environment. What do you mean by "same generated environment file is
> > used for all images" ? And are you building in separate object
> > directories for a given board or is it not being re-generated on config
> > changes? Or did I misunderstand? Thanks.
>
> Sorry if I was not clear.
> For the am335x_evm most of the environment is only in the main u-boot image
> (i.e. not an xPL image).
> https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am335x_evm.h#L78
>
> I would like to do the same but with the new text environment format. Is it
> possible? Something like: board/ti/am335x/am335x.env for main image
> and board/ti/am335x/spl_am335x.env for SPL image.
> If that is not the case could you point me where the change need to
> happen to help me on that. I didn't find yet where the text environment is
> pulled into the images.

Some developer info at
https://docs.u-boot.org/en/latest/develop/environment.html would be
useful, if you have time.

In Makefile:

ENV_FILE is the filename of the .env file. This is run through the C
preprocessor with all Kconfig options and also DEFAULT_DEVICE_TREE set
to CONFIG_DEFAULT_DEVICE_TREE which produces env.in

env.in then goes through scripts/env2string.awk to convert it into a C
header file containing the full environment (#define
CONFIG_EXTRA_ENV_TEXT "..."), in include/generated/environment.h

generated/environment.h is then included by include/env_default.h

Regards,
Simon
