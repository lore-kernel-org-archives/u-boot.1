Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B0C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1495780759;
	Mon, 20 Jan 2025 20:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gpq1NuQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EF080771; Mon, 20 Jan 2025 20:21:44 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A23F8078B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so817719566b.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400900; x=1738005700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muTzZGvk4vEJAiUQGAXvVtBwG/96Tuo+iSaQ5fbh27M=;
 b=gpq1NuQqs5YvnBmZkacEufENDL/zUhKzIssogbqafIq00dZDkUSxgKTghzUZMZEluA
 2ER2hnDyupYJzXrAdFjRCkEBqKzClSkVE13R/qLyVM0bqOPytpnguwmXsqPfZRWxnQ2q
 fN0ikQq3mF7bZJIZ8e94f7oDMLxQbWBA0hUEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400900; x=1738005700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muTzZGvk4vEJAiUQGAXvVtBwG/96Tuo+iSaQ5fbh27M=;
 b=uqeIGYNuX3bkMYviJN3TjMyTkaLFztAm5mRZdig8flF5SG7+DslxYFiAHbQeoS1SVy
 L4RCj/2gFgaswm5StZLLyC6J3oI4lIQ/mEXDZrxmpztseurDQePNx34jQzMcpxyLt8JQ
 dpU57oq8pyRnDpBeKx7FOQdpdPuDaNn2EAOEb5k369GPvX7IWdJffpk+AwMA1jy5DChs
 Fx0FunZdpOR0TI15n1EjzYumBrSTslzmvlHyWlN43apeNoLfLLYdCLIJIpkY1gu3ZvF2
 +BBZuJ9rmhJG/hIjYlAlZam4L31PaG8FOCdxF6mpzQesVJCkK1uZ2cEJVngeu9ZNn/oW
 XCsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx3UGSfjtuhiw+d9TkSkSp3XcsVEdHmadM33uJZ8byRwJlsKCRMWO9tpzldfa9hq8DpnQx64w=@lists.denx.de
X-Gm-Message-State: AOJu0YxJQ374cceF4vXnbKPKA2xOFuAi5cIzoQZ6F2fSNcq7801xbM9U
 CihugBJkG7XcyrP7r1g3sL7DndsD+6ioqhuLnYZRGOlIhqv77m14xSDiRdyTzHranovuo7m+L/1
 Bb1AXRd8rCBH5fi88M86rwf+JQt2ZZdB94RLJ
X-Gm-Gg: ASbGnctxZLeRyShqEhvZvY2fTyQYdVBF39fbH1OPAt47UGhTGkvS90uvzMWBO12Ktk/
 bYcPQHMmxTdiho5nPAt5o6u2g028bzLqvVLOpmMV2ArU4VB+wBYCn
X-Google-Smtp-Source: AGHT+IGHvXEjthPntDSZf4gH+1cwaOlZnxup6zo9b1UyhtBElrAI5Fxnl0cUjHw4gVOe7ebsRfdsxFgdvG0fONt1GZI=
X-Received: by 2002:a17:907:3e1e:b0:aab:eefd:4ceb with SMTP id
 a640c23a62f3a-ab38b0a2b92mr1435705866b.10.1737400900303; Mon, 20 Jan 2025
 11:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <2352334.ElGaqSPkdT@jernej-laptop> <20250119222530.1fd97018@minigeek.lan>
 <4622391.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <4622391.LvFx2qVVIh@jernej-laptop>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:21:28 -0700
X-Gm-Features: AbW1kvZ4uL025Zh0CyxnFCAVNDg-HM-Yt2Se1k0y2SpyS0gYLi8HjRn7ulftZFw
Message-ID: <CAFLszTjDq4E05Q_esYA2tAGOYdhgbRp3B38gAsF0hX44Nf-34A@mail.gmail.com>
Subject: Re: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, linux-sunxi@lists.linux.dev, 
 Parthiban <parthiban@linumiz.com>
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

On Mon, 20 Jan 2025 at 09:42, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Dne nedelja, 19. januar 2025 ob 23:25:30 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > On Sat, 18 Jan 2025 08:21:31 +0100
> > Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> >
> > Hi Jernej,
> >
> > many thanks for the review and your opinion.
> >
> > > Dne petek, 17. januar 2025 ob 02:45:31 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > > > Some of the X-Power AXP PMICs can be ordered with an alternative I2=
C
> > > > address, for instance an AXP717 could be shipped with address 0x34 =
or
> > > > with address 0x35.
> > > > The datasheets for the AXP717 and AXP803 list two possible addresse=
s,
> > > > and they are always consecutive. For DM (DT) based drivers this is =
no
> > > > problem, but the Allwinner SPL code relies on a hardcoded address.
> > > >
> > > > Add a Kconfig variable that will add "1" to the existing address if=
 it
> > > > is set.
> > > > This enables to use the AXP717 as used on boards with the new Allwi=
nner
> > > > A523 chip.
> > > >
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > >
> > > This works until some board vendor start mixing one or another addres=
s
> > > PMIC. Note that BSP boot0 does address autodetection, so it's not ent=
irely
> > > out of the question. Anyway, let's hope we don't see anything like th=
at.
> >
> > I looked at the datasheets for all supported PMICs, and they either
> > state one or two supported addresses, in the latter case both
> > consecutive. Autodetection sounds nice, but also unnecessary: we surely
> > know what address it is for a certain board? And with those A523 boards
> > having two PMICs, autodetection might become sketchy, as we don't know
> > for sure which PMIC we got?
>
> Speaking for T527 BSP boot0 - they check version register to make sure th=
at
> correct PMIC is installed.
>
> >
> > But that got me thinking: what about putting the I2C address in Kconfig
> > directly, with defaults depending on the PMIC type?
> >
> > config AXP_I2C_ADDR
> >       hex "AXP PMIC I2C address"
> >       depends on ARCH_SUNXI && !SUNXI_NO_PMIC
> >       default 0x36 if AXP305_POWER
> >       ....
> >
> > That's should work seamlessly for all supported PMICs, and we just need
> > one line for the Avaota, same as with this patch here.
> >
> > What do you think?
>
> Yeah, looks more universal and avoids code changes in pmic_bus.c when
> adding support for new AXP PMIC, which is very nice indeed.

Shouldn't this be in the devicetree?
[..]
Regards,
Simon
