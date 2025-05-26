Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E743BC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D39882C96;
	Mon, 26 May 2025 09:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KZRTuYEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FE082A8B; Mon, 26 May 2025 09:43:11 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E1B82CF5
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b26f5f47ba1so874466a12.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748245386; x=1748850186;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7odlvDyAU9ZHNr3rnwrP48JAgpWN711mRXaxnQ0zRU0=;
 b=KZRTuYEFiOzrLzMqJLp3hj3XbO4Rto0BX3EuRqCIHfWiqkl8jhZd3Nk5G4SGPGBwkA
 HQ3aKVnPU6P9fPYklTynkv9CNkXNEYteLT8Y1Bh/0dJ/MkxiNdiAICHWUOGWeLsLLl1G
 /qHulqqfHK+eObudOEw0onCnHARXpJl3RpSHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748245386; x=1748850186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7odlvDyAU9ZHNr3rnwrP48JAgpWN711mRXaxnQ0zRU0=;
 b=EVKsww4f9HqIKhCwllsaEjcaFjmCAcYnL/6laYTW76/XQ8Bkm8aWBNpwq5HazWN2or
 EelgfZ6NvXPg5DygCMLUf47okqVoBEIouh/WmI+ww31cCUX+QO5RaVW1uWd6l7yoZnP6
 HXZoGss01uA5jVDGISNx2U6iRDMI8zUwdlo4eo3fugeIesoaBDYnvnnD2+6mZEXXLQ4h
 Gg1qZJQd1DrS4n779zfxQmw2/gCMoOKKiSnbXfCSFdQiy8TRHVXakhYF4fOV1LXp0C4g
 F4Y5RdYVWk2VWXu6qdsUkRSqG556m2FWxSpQ3bV/15Mn+zv63Eug9fIswAzylar57YxF
 9SUw==
X-Gm-Message-State: AOJu0Yzaa1206Dh+sWoRRo3jsAGQZPXbfqBPlXxG/MWywhRuVjm3qhUv
 VGVqbI62wpWGMchNLciYguB8A1aF5AbnbdLwbACiqNEeYKl8fZ+BrVcIyyQ0nZ3WGcirtGtm3KV
 WdLjIG1Hy1bRexcr+foEpIZWrgDUVOFco4aMtzdHNxQ==
X-Gm-Gg: ASbGncuWl9Gt0U3zlBtI5Iesvc7Uj9SnWbhSnUyz/ab3FC2qMWjAE3iRWGuPOFiTc/1
 FsiCf4C5wd+IsUUthpa9WgfPmJBMwIGIWujbHR72OcAKjFzVUXRcaAWQuEUanCx+Rr+5TuAH/vi
 O+TeOmaWXhgv0p7OoRtZ0VWaE/M0ljZgVJUHCar8O9go4rwXKMxLDg1P/Tt1wwGQ==
X-Google-Smtp-Source: AGHT+IH8x5UBaT9jejCadoLvX/BTy3fY1mfQdHHk9xxIIMYX3IbfJ40YfOjJhUXFT3b8sXjH1yEtCBT6XUzfH1pCNps=
X-Received: by 2002:a17:90b:4b51:b0:308:7a70:489a with SMTP id
 98e67ed59e1d1-311119433eamr11147172a91.30.1748245386561; Mon, 26 May 2025
 00:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-2-michael@amarulasolutions.com>
 <20250526084356.GQ19264@nxa18884-linux>
 <CAOf5uw=Fk0y0G24f2JWcDiWdvWEUUTRWsD5v3ugBxRjSZGrtAg@mail.gmail.com>
In-Reply-To: <CAOf5uw=Fk0y0G24f2JWcDiWdvWEUUTRWsD5v3ugBxRjSZGrtAg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 May 2025 09:42:53 +0200
X-Gm-Features: AX0GCFvFuzcvHK4ZFyWCSzdMrj3XaILQpq_L_K2aZQYGRaWLOcOEp5YSIxwtb-o
Message-ID: <CAOf5uwngXsW9_A+XdA4emgzg7mRkGEcfAioD6k-4YviLCuue-A@mail.gmail.com>
Subject: Re: [PATCH 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
To: Peng Fan <peng.fan@oss.nxp.com>
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

Hi Peng

On Mon, May 26, 2025 at 9:38=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Peng
>
> On Mon, May 26, 2025 at 9:34=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> w=
rote:
> >
> > On Sun, May 25, 2025 at 02:23:10PM +0200, Michael Trimarchi wrote:
> > >Make simple the clock registration and enable and allow later
> > >to add support for other platforms
> > >

Ok, I think that I need anyway to disable the gpmi_io clk because the
driver should
handle it during nfc timing calculation

Michael


> > >Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > >---
> > >
> > > drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++-------------------------=
-
> > > 1 file changed, 5 insertions(+), 43 deletions(-)
> > >
> > >diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw=
/mxs_nand_dt.c
> > >index 11dbcbbf442..b62474bc5ab 100644
> > >--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
> > >+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
> > >@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
> > >
> > >       if (IS_ENABLED(CONFIG_CLK) &&
> > >           (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
> > >-              /* Assigned clock already set clock */
> > >-              struct clk gpmi_clk;
> > >-
> > >+              struct clk_bulk clk_bulk;
> > >               info->gpmi_clk =3D devm_clk_get(dev, "gpmi_io");
> > >
> > >               if (IS_ERR(info->gpmi_clk)) {
> > >@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *dev=
)
> > >                       return ret;
> > >               }
> > >
> > >-              ret =3D clk_enable(info->gpmi_clk);
> > >-              if (ret < 0) {
> > >-                      debug("Can't enable gpmi io clk: %d\n", ret);
> > >-                      return ret;
> > >-              }
> > >-
> > >-              if (IS_ENABLED(CONFIG_IMX8)) {
> > >-                      ret =3D clk_get_by_name(dev, "gpmi_apb", &gpmi_=
clk);
> > >-                      if (ret < 0) {
> > >-                              debug("Can't get gpmi_apb clk: %d\n", r=
et);
> > >-                              return ret;
> > >-                      }
> > >-
> > >-                      ret =3D clk_enable(&gpmi_clk);
> > >-                      if (ret < 0) {
> > >-                              debug("Can't enable gpmi_apb clk: %d\n"=
, ret);
> > >-                              return ret;
> > >-                      }
> > >-
> > >-                      ret =3D clk_get_by_name(dev, "gpmi_bch", &gpmi_=
clk);
> > >-                      if (ret < 0) {
> > >-                              debug("Can't get gpmi_bch clk: %d\n", r=
et);
> > >-                              return ret;
> > >-                      }
> > >-
> > >-                      ret =3D clk_enable(&gpmi_clk);
> > >-                      if (ret < 0) {
> > >-                              debug("Can't enable gpmi_bch clk: %d\n"=
, ret);
> > >-                              return ret;
> > >-                      }
> > >-              }
> > >-
> > >-              ret =3D clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_clk)=
;
> > >-              if (ret < 0) {
> > >-                      debug("Can't get gpmi_bch_apb clk: %d\n", ret);
> > >-                      return ret;
> > >-              }
> > >-
> > >-              ret =3D clk_enable(&gpmi_clk);
> > >+              ret =3D clk_get_bulk(dev, &clk_bulk);
> > >+              if (!ret)
> > >+                      ret =3D clk_enable_bulk(&clk_bulk);
> >
> > You enable clk bulk and together with a standalone gpmi_io clk?
> >
>
> I need to get and refer to the gpmi_io because it is used then by the
> driver. I think
> that this does not change what was before. Am I missing?
>
> Michael
>
> > Regards,
> > Peng
> >
> >
> > >               if (ret < 0) {
> > >-                      debug("Can't enable gpmi_bch_apb clk: %d\n", re=
t);
> > >+                      debug("Can't enable gpmi clks: %d\n", ret);
> > >                       return ret;
> > >               }
> > >       }
> > >--
> > >2.43.0
> > >
> > >base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



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
