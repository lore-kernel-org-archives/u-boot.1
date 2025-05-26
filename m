Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F51DC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C5082E34;
	Mon, 26 May 2025 21:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RDax3iHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BC482E52; Mon, 26 May 2025 21:33:17 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A4282D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so1164679a12.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748287993; x=1748892793;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gws6wh1ickP/zmVN0inpgWyNann1wXtk8LUN4q6GkJI=;
 b=RDax3iHf5aX+GrTr1zhU+thLtx2Dtyu4j3KnSDWODi+f1zMIXISZae3cehcgp3vYqh
 Jr+OrXjPChK+lozFBEqMkzXAaA+9w5lwWDTtc0N4H9sJjPWC3kBNIAX7Sd4iU2pgtweJ
 PhfSLlowcwcHpF5eNdLCyVSXC2+XB0lSB3s2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748287993; x=1748892793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gws6wh1ickP/zmVN0inpgWyNann1wXtk8LUN4q6GkJI=;
 b=IkUqp+mwwpFQEjA+dsYa31xPKA2Sdir2+NEibK+XVVQCniTp9a28UEAumu/spwbapI
 ukEqxdKoyzChM5JU+cPoE8IlVWkPaPssHI9T5oKnU9l6O9Yh3zoS6LTAQrrV4CtGgeG/
 N7VOaes7DeofUwERd7KuarUOUseLbrKUrxbSraOzM2kzE5rYBX0kjmkQu7Hh8S12Uo6J
 nJLMsUT/qRb8bdbZzHw0FW+7TDiReO2k0LGBoXXAYyu/5KgBxUUkpsZ9ydGWwwHdaYEr
 s8wocLu0Oasf2XQGyooSaxuALEKmhC3YSBvudOZiop3j4lVKJ0qHt7s+mWXsALABKvjM
 JP7g==
X-Gm-Message-State: AOJu0Yx/SS2ewP5oovNN9mLvn4Ajc0mDBK+JZl4nSONJSqv5xcgFHfYe
 P0R6OVXhOp2I0Ni3yip3U8HUGJH1QvKWEOCQJg8wh+FPmEb2/nE+HuRPq10eslMT0dsZVKga83m
 2abfaWul3ivTxbe9zuBwQ9lbGzt+w60gA4p590fPCrw==
X-Gm-Gg: ASbGncsHaHhn/fvhhyVSrj/hDhMsCjZerlN+a6Y2J0z64rocvgWuhGxkLDV6QsRLRso
 R+flyL+uDFSjfbdKH4HtQS9h59mjzc2U3EkdN1cigEhZQRP6O3KpuPwd+BYZIxcmwLwouRyz4y+
 DhYzN4NRfXO/FTS6mo/97NPQIodyC2k77EhmsJyA3lSGMMZ2iJ9yTzvalrEgdH7A==
X-Google-Smtp-Source: AGHT+IErwp5hX/mMeAceDw6kuVbug8p+tef/axxRLlodnWjhz05c0JedbpuamIREP1xciFet9pXCNSi9AiwRSXFOj0w=
X-Received: by 2002:a17:90a:e7ce:b0:30e:9349:2d96 with SMTP id
 98e67ed59e1d1-311106abb15mr15058464a91.28.1748287993331; Mon, 26 May 2025
 12:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-3-michael@amarulasolutions.com>
 <CAOMZO5CdLBngWjE=ozR-sFdXRUS36t-PKiG1O5L1JujrxUWAkw@mail.gmail.com>
In-Reply-To: <CAOMZO5CdLBngWjE=ozR-sFdXRUS36t-PKiG1O5L1JujrxUWAkw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 May 2025 21:33:02 +0200
X-Gm-Features: AX0GCFtgJ8poonDJ1egtyuJ8PPga6nGVIwZG9LttqV_bGnbZX1e6XjXga6ov1nM
Message-ID: <CAOf5uwmO-YjUTw5s9WuobT0pd8ANzZWyYC7iZ6=mT+t-yXiOcQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

HI Fabio

On Mon, May 26, 2025 at 4:27=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Sun, May 25, 2025 at 9:33=E2=80=AFAM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > The clock driver allow to burst the performance of the nand
>
> allows to boost....NAND
>

Ok

> > controller. Make changes to let it use the new clock driver
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >
> >  drivers/mtd/nand/raw/mxs_nand.c    | 12 ++++++++++++
> >  drivers/mtd/nand/raw/mxs_nand_dt.c |  2 +-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs=
_nand.c
> > index 80d9307cdd1..2679b6ab650 100644
> > --- a/drivers/mtd/nand/raw/mxs_nand.c
> > +++ b/drivers/mtd/nand/raw/mxs_nand.c
> > @@ -1507,8 +1507,20 @@ static void mxs_compute_timings(struct nand_chip=
 *chip,
> >         writel(GPMI_CTRL1_CLEAR_MASK, &nand_info->gpmi_regs->hw_gpmi_ct=
rl1_clr);
> >         writel(ctrl1n, &nand_info->gpmi_regs->hw_gpmi_ctrl1_set);
> >
> > +       /* Clock dividers do NOT guarantee a clean clock signal on its =
output
>
> their output.
>
> > +        * during the change of the divide factor on i.MX6Q/UL/SX. On i=
.MX7/8,
> > +        * all clock dividers provide these guarantee.
>
> this guarantee

This comment coming from the kernel and I don't know if is english wrong
>
> > +        */
> > +       if (IS_ENABLED(CONFIG_MX6ULL)) {
> > +               clk_disable(nand_info->gpmi_clk);
> > +       }
>
> Please remove { } for single-line statements.

Done

>
> > +
> >         clk_set_rate(nand_info->gpmi_clk, clk_rate);
> >
> > +       if (IS_ENABLED(CONFIG_MX6ULL)) {
> > +               clk_enable(nand_info->gpmi_clk);
> > +       }
>
> Ditto.
Done

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
