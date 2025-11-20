Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74183CFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECDC840F8;
	Fri, 21 Nov 2025 00:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nDK1RqhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D595D84106; Fri, 21 Nov 2025 00:40:39 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E3B8405F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7370698a8eso183894766b.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763682037; x=1764286837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MLVbixVEleg+9DRhD21hWmlZYkZ457DTndXxj1OVCHI=;
 b=nDK1RqhBxfqC8bz6JPfWPuhOlVzi5Uhffsljn5YnbqjoCut7IZ+T0jMjcGcdPTCSp3
 Sx6ti5D99GoQzPd1n/+BeiicZaoYWAh4xGoyyy0CVmLI3erRANjJ7XNyGji34/MFRl2J
 1MsbCUBSUPwemt8wQaUtlz2320IU23G1M1q6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763682037; x=1764286837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLVbixVEleg+9DRhD21hWmlZYkZ457DTndXxj1OVCHI=;
 b=mLsiOwFZb6IiraVh4z7WqRcujHgKpHdDAPbgLLY4tlYmUY77iva1nS5IYVsyA4bTLr
 Zg5BBGFjeSfiOLeimH0DML4bT7wKpfW9VaUB1fa3OGiGwTLJXdUPerVn3qRlQkfG1CRZ
 n+JD2+kwwUnlzsJ+tgXQ+ZLtJH71GH7cJLeb7aTZ8RZ2W/Om9kqEoRczW0IWDbIxzRuG
 SmFyVtsgPklrQN/dxkI4rLZChYgXn+EQ7rBT/zWUOVK4XAaAk+nd5hUWe8T+U7Hpx3LN
 xN36mkb49RThW1LU5FYV+bF8TPS2oqU5wuL8XeoA2NA9csF5DXs/WcEB7eK1wnrPQQTn
 xREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxYYuzxsVlkvG/vgi8WI5i5aYS1KDcGdtzt2kJIJD205vSygQ8FSGthQOaKo9oO/qU3cPdpDs=@lists.denx.de
X-Gm-Message-State: AOJu0YxRGtoDVPNohD5aNJzAmoHY+i6nI4+TOPD38Js9DtDt0DoOTMda
 17NyMmTyVKURkfyFD2p6n1EvUPai33JAmQHLw+zcvhpXb6bl8A/atYGor3cdcXGeD2qZXJDQ1ZU
 9w0WpvfDQT+yJ9C9P/TVywTFlKPfjIvV16z/oj1kG
X-Gm-Gg: ASbGnctOjpPG8AUKoIg20N3pwcENIJe8CY8+ucIKSO/0fMFMxk7j3ywh1mGYFLQDwdO
 sTeWpsUbpzl/squyIbIKZf496QJ1uqJ0VmGO9WcFPTF4o+yg1VhVTHHTDbdauYPe9QlrPpPCuOt
 Ozlk+WfpPzc5fcC4MB6hjdJn4bZ3I566Gdf1LflWZ5Wf77bqQRs9MxOrRdUQohWcQUpn9kraxof
 smQfTGUnwGNv1usN099UzWbaWWGnRH+S113TEV/miXwXhpj0Hk3uyREf+DVJWOS6J+CCt3wFr3B
 KhpL
X-Google-Smtp-Source: AGHT+IGIoUz7NUOJzT95y2RoyeYhFtw9pDQgHjUzTjYyeNUjOEa5Om5XqZ8gBF1H7O3hV8P55Lq49zjkPGX//a91On4=
X-Received: by 2002:a17:907:3f1e:b0:b73:5acd:465e with SMTP id
 a640c23a62f3a-b767153ee39mr13658566b.11.1763682037129; Thu, 20 Nov 2025
 15:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
In-Reply-To: <20251120212909.GQ2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Nov 2025 16:40:22 -0700
X-Gm-Features: AWmQ_bmCMHsh1ow-89rrQSyDC_3JoXaG4xv9v2CBOFjTnugld5H0dN2bQNwX7I0
Message-ID: <CAFLszThb85y4zaWfcwKcxNW2wOoYB1O_aYe-7h_UPQk2-60-ZA@mail.gmail.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
To: Tom Rini <trini@konsulko.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
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

Hi,

On Thu, 20 Nov 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 20, 2025 at 11:42:53AM +0100, Markus Schneider-Pargmann wrote:
> > Hi Tom,
> >
> > On Tue Nov 18, 2025 at 3:08 PM CET, Tom Rini wrote:
> > > On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (TI.com) wrote:
> > >
> > >> Currently once a driver matched the compatible string of a device, other
> > >> drivers are ignored. If the first matching driver returns -ENODEV, no
> > >> other possibly matching drivers are iterated with that compatible of the
> > >> device. Instead the next compatible in the list of compatibles is
> > >> selected, assuming only one driver matches one compatible at a time.
> > >>
> > >> To be able to use the bind function to return -ENODEV and continue
> > >> matching other drivers with the same compatible, move the for loop a bit
> > >> to continue the for loop after -ENODEV was returned.
> > >>
> > >> This is required for ti-musb-host and ti-musb-peripheral which both
> > >> match on the same device but differ based on the dr_mode DT property.
> > >> Depending on this property, the driver is either UCLASS_USB or
> > >> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> > >> function and returning -ENODEV the other driver can probe instead.
> > >>
> > >> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > >> ---
> > >>  drivers/core/lists.c | 62 +++++++++++++++++++++++++++-------------------------
> > >>  1 file changed, 32 insertions(+), 30 deletions(-)
> > >
> > > This seems like a big generic change (with potential performance
> > > impact?) for a rather specific case. I assume the linux kernel simply
> > > doesn't have this issue by handling OTG differently. So is there some
> > > other way we can handle this here?
> >
> > I didn't find a nice way to do this differently. I did have a different
> > idea to do this by overriding the compatible of the parent node of the
> > usb devices. But I didn't like that idea so I proposed this solution.
> > But I would be happy to hear about other ideas.
> >
> > For the performance part: I don't think this reduces performance in most
> > cases. This will only add overhead through additional iterations if a
> > driver with a matching compatible has a bind function that returns
> > -ENODEV. In all other cases this should not add any iterations to the
> > loops. Grepping through the code a bit, I don't think returning -ENODEV
> > in bind() is widely used at the moment.
>
> OK, thanks. I guess barring someone else having a better idea, we can
> try this direction.

This seems fine to me. But please add a test, e.g. in test/dm/core.c

Regards,
Simon
