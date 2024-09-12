Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21DEEED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 16:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AA38904C;
	Thu, 12 Sep 2024 18:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XCPHraLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F81B890C4; Thu, 12 Sep 2024 18:00:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9ED8904C
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 18:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7d5dso1303347a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726156853; x=1726761653;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9oEq/eYPcb9l3Z9/k7FehnAwr6KHb7fhEIGuawtpLc=;
 b=XCPHraLVtK/aLPGjaA2mTipGiiSMbiV/LdUYBPLDLrpeHBFDi5OpiOR174qAYla/Yf
 rtZ5EJN8Px7LZrFBxRH3SaHcFDsyHGu/Agynqm6VKHPWPsaLkkrVpQcIOxlc4Bb4bxFG
 SNMkLymdf8toqUEdxkq6uIc8JPTl/TNDQ8438=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726156853; x=1726761653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9oEq/eYPcb9l3Z9/k7FehnAwr6KHb7fhEIGuawtpLc=;
 b=L9g27u6mC39VnE4QRNt5Y8yFSSIT3Qa0X+cL4IGpVMr1N1+ZnsCypAmNEwpmJZdtZO
 5JV55E0nb63RJZ6Ua/JXnMLvrSRM/tpGGGQztN58ItRaVIx3kqegJTmS+MkO7YtiLRD9
 IrW5hPInlz3kAaQHR0pDP4Y7pPdsdWK5Y11uMgIWJXcaOuoSv5Yy5IFK98jRoHZVlTWk
 xZpx8ZV86nvKuxpRH0m4LYUmI5xFr4Fxl6BfzH+53TtA/QDeeosWyeZNijFJCHwaslew
 0uBjIEW/MvQ8A9tjeKNDhte21IbQ//Npm48SEkNRc1WSRw4F79nvhDh/fv7qgGlqowj0
 9DoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU+W88A/qaW4eqHFKfBpcFVqG6/5lre5VymtDl68INXSMrihH3lMf+bSFwG/kQsgz/om7opnk=@lists.denx.de
X-Gm-Message-State: AOJu0Yya1moLhgvbXFVYUtFcxYP4rfHHiYYJfd+QLQqOg9OdmIrq0VkN
 qGZ6Jv47u2pvfrQH6/IL5Mn+iwR0/uCfsKOllB4heEZo00wLUR+224SBW2bVQ8OI3N7iandYNr/
 /C0XsRVR6ESKDLcnbOp0yaW+hY+tlRhvy0ha2bA==
X-Google-Smtp-Source: AGHT+IErSCFHYrBE1//tdQXOHpj4fQQ8pNo3uVAkvZGFaqBxbeEE+ye9NAp9DbG9duSfPk+HC7/G6b46kbrCdj1qAoQ=
X-Received: by 2002:a17:907:e21b:b0:a86:842a:104a with SMTP id
 a640c23a62f3a-a9029636efbmr317075266b.57.1726156852978; Thu, 12 Sep 2024
 09:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-4-miquel.raynal@bootlin.com>
 <CAOMZO5DxLh24w4owJ63z-aEfRtu0gct+DzGPbZQdyFBt7NO1uA@mail.gmail.com>
 <CAOMZO5D_-49AdXCe-O5NRqw91oJ4WwpHqEomKBAd_hn9qxYPeQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D_-49AdXCe-O5NRqw91oJ4WwpHqEomKBAd_hn9qxYPeQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 12 Sep 2024 18:00:40 +0200
Message-ID: <CAOf5uwmJf+eu9ViS5zEzvfRSXUe=iP5rL=KBoOTBD7vqMCrPiA@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: imx8mp: Add media related clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Fabio

On Thu, Sep 12, 2024 at 2:30=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Miquel,
>
> On Wed, Sep 11, 2024 at 4:48=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Miquel,
> >
> > On Tue, Sep 10, 2024 at 7:14=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > >
> > > These are all the clocks needed to get an LCD panel working, going
> > > through one of the LCDIF and the LDB. The media AXI and APB clocks ar=
e
> > > also described.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > This one does not apply. Please rebase it against the next branch.
>
> Also, shouldn't we restrict registering these clocks only if DM_VIDEO
> is selected?
>
> clk-imx8mm.c and drivers/clk/imx/clk-imx8mn.c guard some clocks with
> their respective CONFIG_ options.
>
> We should do the same here to avoid unnecessary code growth for those
> who don't need
> splash screen on i.MX8MP.

I think that we can wait a bit on those patches, I will send my video serie=
s
and try to arrange it back and rebase and work together with Miquel

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
