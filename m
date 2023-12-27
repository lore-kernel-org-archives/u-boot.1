Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E132C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A933C87801;
	Wed, 27 Dec 2023 18:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HP2iWmJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C910F877E2; Wed, 27 Dec 2023 18:48:57 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBBD87801
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67fe0264dd2so26185006d6.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699333; x=1704304133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S70iHfHDl0UwY2czxszAU8oZT3aFsjjpvyBWGMjIXc8=;
 b=HP2iWmJEf8xVRIciLkyc+GExqr2OZo/XkR+Aq0CAjbVzm+FbbAiO7HBaMK4xrbkuzS
 emu6x5wOgqUvKx0fLmmikT+t3NKlyADGb9hhDqL8UpzEJTdZPRiGwFHQHPkwfeNviqSS
 XYjw0UZwm8sVyN195FJJEhyNPrj6sgkyEahDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699333; x=1704304133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S70iHfHDl0UwY2czxszAU8oZT3aFsjjpvyBWGMjIXc8=;
 b=rzeLCyudPEB3M31LzOsEG3NZKRKeSTPD3YnBwTfo58UrjcnZdker1/moXhMY4xqsCe
 zOHd0NF/+4EJbdu7RG8D9fXMlWtr5LeTXzW7cMbIE8bTEYlascdDiNVVUgpmQT9hsPkz
 U4q5J8FZ3oNgZ5WwnxeIoufcDvxQpMeo/GHC3p12I9uJuaIcjz1ofKNnN8MgZ0qyd2Js
 RVpXRZqshykobDomnbPrWYzbuHZMMtUICM8PZaNTALWtsH4XaJ/Ff6IE+l/CeuvIXRXY
 WJntOnpsMbIcvkKq65JoiCJWlNzGkChRUQ5g/s27ZTXDwfEwwTYqq1DB46ye5quol/p9
 FTsA==
X-Gm-Message-State: AOJu0YxQCUtN/BwDIl2CY9oqEzayBJf0R9O6B0Fb6O7rq7J1vgwaG+sR
 YozA1SsdB+E0Yix4NZSZ64NjqCz40Sn4El0hxWPh2f2HhXh2
X-Google-Smtp-Source: AGHT+IFPcytirlqPKrgn4f1ctrnV4Zz5FMXcbcGxwT9E0JjnhmsZRHrliuBmuVZLD35GTh/YYvFXSVV3FNBJIdGK0u4=
X-Received: by 2002:a05:6214:4112:b0:67f:2195:a5ba with SMTP id
 kc18-20020a056214411200b0067f2195a5bamr16031945qvb.50.1703699333087; Wed, 27
 Dec 2023 09:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
In-Reply-To: <20231226120710.GH2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:42 +0000
Message-ID: <CAFLszTjouSz2ExX7iWu8PjjWDF+F=bsuEX9hKCjuyUFbYXtvwg@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
>
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as wel=
l.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> > The discussion on this was not resolved and is now important due to the
> > bloblist series from Raymond. So I am sending it again since I believe
> > this is a better starting point than building on OF_BOARD
>
> I really don't like adding another option for "DT is given to us". Why
> isn't adding another enum to fdt_source_t sufficient

That is added by this patch, but...

>, and if we have
> bloblist enabled, that will look for and use if found?

...this is the question. I would like to be able to enable bloblist
without *requiring* the DT to come from there, hence the separate
Kconfig option.

> Maybe some other
> code needs to be restructured and cleaned up too?

Possibly, but I really am not keen on this board-specific solution. I
believe Ilias & I agreed that OF_BOARD should fade away, so I don't
like adding another thing onto it.

Regards,
Simon
