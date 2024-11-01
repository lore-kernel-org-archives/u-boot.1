Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29D0E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FB188FBB;
	Fri,  1 Nov 2024 16:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhcR1p42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9CB88FBB; Fri,  1 Nov 2024 16:33:08 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0FD88DF5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so340819866b.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475185; x=1731079985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s11UU90IxpeajDWW6lAhihtRY7YYqUz/lB9x/h56aXM=;
 b=EhcR1p42lLnTbrdDxf9vybDZnHEvUce/ymwBrINus8LfeWV8b7qvZIgOzb9DT/fGNU
 QShlmGXBe+XDxmoyMtHkeMkzOg1nr1Y00e+na2iAPJ55Ijx3UNTmC1pPl5dgkferR1kS
 XEPvLqaEudq2lvW3mVeUQN2jiCueHWoYoMjrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475185; x=1731079985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s11UU90IxpeajDWW6lAhihtRY7YYqUz/lB9x/h56aXM=;
 b=ava18cGoFqhZknjUCV/vaGYpikjeinws27Ly0K/3P3rXt8g4175tr16nhcILtmTq/B
 UqPbaVTUH1cTpjlZFleASUwqfHjqmdyvgPQkPILT9q3ULYhmfaorOVgMo7uv7/S6/vAo
 MutuV6wMfDt/QCHmBBn45G40GECbGrxvsMVxUgYwG/uSyqRbX2aNfTT7RPtOT4ma70Fa
 skwG8fUA0+8CT1DcNmzIoeu1jWJoM0lLkXDEeQNPC/tPJ6JUKOALnyrWJQCcKZlExv3n
 ixXhr9Z7ULnIYgd+jfxheGTnWB5rjC745Wm01isi2KfbHg46jdI+UbvmzcSRICxBGu81
 8ONA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfLDEi9AGQugi30A4ny+Fr5uiVvzUbCBL7PHr6jpQEfnM3JImPuZhwQ69abuI19tlA0S4PH8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxxKzoNK84vcHWBHBqypejcJ12lgPUXsF9WGrHfbHlBB2N003F/
 4RJVDUC6UibGgmpRkcQ2gzXmtVKPJQ0BTKIL7Red0SvzUwM+OyXg2S5uT4v4SMlmAmEdRBTL64r
 jk04OHoGsADucn2yVL5DF7cDkPvblJEtyKMKT
X-Google-Smtp-Source: AGHT+IHUpC9xI5fgcwjumCEy56ijhkyijaHlRpsertr1nsRN6gOVT+OUIN2BthLdJAolH18fVFeKYRK5fJLoNM32aJg=
X-Received: by 2002:a17:907:7f1b:b0:a99:4025:82e1 with SMTP id
 a640c23a62f3a-a9de61d0956mr2125708566b.41.1730475185056; Fri, 01 Nov 2024
 08:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-4-sjg@chromium.org>
 <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
 <20241021182119.GS4959@bill-the-cat>
In-Reply-To: <20241021182119.GS4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:32:51 +0100
Message-ID: <CAFLszTgg5f+YfpgwoNgK2r8jqJVUYTJbNJE47YWDRdvheCoiog@mail.gmail.com>
Subject: Re: [PATCH 3/3] common: Move autoprobe out to board init
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, 
 Svyatoslav <clamor95@gmail.com>, Artur Rojek <artur@conclusive.pl>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Mon, 21 Oct 2024 at 20:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 06:10:09PM +0200, Jonas Karlman wrote:
> > Hi Simon,
> >
> > On 2024-10-21 17:51, Simon Glass wrote:
> > > Rather than doing autoprobe within the driver model code, move it out to
> > > the board-init code. This makes it clear that it is a separate step from
> > > binding devices.
> >
> > It could probably be good to mention that after this patch the events
> > EVT_DM_POST_INIT_R/F will happen before autoprobe instead of after.
>
> And in updating some part of doc/develop/driver-model/ and referencing
> the discussion on the list, in the commit message with some Link: lines.

Oh, nice, I didn't know about that feature.

>
> And I mention the last one because I fear this is related to the
> regulator changes from Marek and it would be good to hear from him that
> this series doesn't break his devices, for example.

Yes, given him a week or so to reply, but I'd like to get this in
before rc2 since the ordering thing that Jonas pointed out could
conceivably cause issues.. With the updated patch, we have SPL covered
though.

Regards,
Simon
