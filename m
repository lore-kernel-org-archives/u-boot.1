Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4835FC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9772282D34;
	Mon, 26 May 2025 11:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f83ShLBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2BC982CED; Mon, 26 May 2025 11:25:25 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED7E82D34
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-310f082a677so1520151a91.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748251521; x=1748856321;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02rHxee/xjRtm6LV5Y0KGjxhMXZVsf0iOJsLeMtd3BE=;
 b=f83ShLBMC7ur79s7ydGKVt6dnhJkkPidXY8mz+vTmfvPELfRcTpkTYhFklgO6Z4kbc
 l/fLzGKp9jq9AH0zGwi4TU+izUf7Wru/ScaD/dy1ML+NIKif3C8g7no5dFF6dOLzVi7g
 2xcQHY5bQrF+g7/VJr5bfotUAEScG/VWFEHIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251521; x=1748856321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02rHxee/xjRtm6LV5Y0KGjxhMXZVsf0iOJsLeMtd3BE=;
 b=iS7wTNF/k6tf5egvbtNuaQUdHWq6jUYRgaIUlvgrrDedCYEDIYYrFxU/qomJ2bzXua
 +v0nure0y3Qo25RMkHGcKy07SWPPEPegnLUO4bLLGYw0dOnvmrliIxHzCOIvxg65jKjL
 LKoR4ZPwo8nKMGJe28LI1o8JLFeY8QXhHgWIQNR5G0ST8IR5l+yQfuQnJI2ZD4o8s/hg
 J++EfhEDtDYoEEgkn1KHsn+M/rIcsMbI4luM25m1dB4YYc5aHm+7ca8U3XKNLH+MNSHU
 fpAlRhaCoeDwMVcUzU1ovOUD2tolJ1NColCKVGIgvl8gap1I8I751OZBhyI2CDF0uPtw
 RSEA==
X-Gm-Message-State: AOJu0YxBGgN4JRZ+SG9AUksep1u+oYfYVyoVb8i4ALuWpPGRl6YbGi1q
 EICouT7XhCLBglmSogqLr4MZs21/t0F2MF1+FEsbiXKxQS6dRAwA0Fav50zToooMAk3Mg0QLTqf
 +IT694k/C+hYyYuL+Ya2qgCJZWBxW1S/akPspyblzmQ==
X-Gm-Gg: ASbGncu7O+UIdnlFZ/X8rdlalnoLnDJnRD3/OMr3cd/6WYz9lQ5PPfn1Ygb1DgEnAuf
 IYJr/orQxlz2x0fMBkI2HXdDOm5TOozK5BZSszyW4WWnpaPhnZRFlkT2GeUq/p5vfgUO6tlD6NZ
 D6Vy9Ix6+3iVDWvgTrFdn1gVzwDU/JgFE+ZPd9MCQgaQDnjCDS6Xj9qQTdD9c8F9dgIOnr95+U
X-Google-Smtp-Source: AGHT+IGAwnP/3Rs5ewb1U/772d+pQSQNPgyju5aQywaDrg4cDFHrtJRhICR7a5uUfavi8LEB3C/Vn+l5EsX++2mz7GE=
X-Received: by 2002:a17:90b:2e4e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3110f30d83bmr14462973a91.15.1748251521551; Mon, 26 May 2025
 02:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-2-michael@amarulasolutions.com>
 <20250526084356.GQ19264@nxa18884-linux>
 <CAOf5uw=Fk0y0G24f2JWcDiWdvWEUUTRWsD5v3ugBxRjSZGrtAg@mail.gmail.com>
 <CAOf5uwngXsW9_A+XdA4emgzg7mRkGEcfAioD6k-4YviLCuue-A@mail.gmail.com>
In-Reply-To: <CAOf5uwngXsW9_A+XdA4emgzg7mRkGEcfAioD6k-4YviLCuue-A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 May 2025 11:25:09 +0200
X-Gm-Features: AX0GCFudMrag2C9m7Z9sYTZGWXQ4yaDQqSSxuW0AYm0zKfoX-A7vFcKO_W38vmw
Message-ID: <CAOf5uwm4zgghtJDvPOFg0Sh_CHbEUiXmjhqj2cajSzddCnf0jg@mail.gmail.com>
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

On Mon, May 26, 2025 at 9:42=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Peng
>
> On Mon, May 26, 2025 at 9:38=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Peng
> >
> > On Mon, May 26, 2025 at 9:34=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com>=
 wrote:
> > >
> > > On Sun, May 25, 2025 at 02:23:10PM +0200, Michael Trimarchi wrote:
> > > >Make simple the clock registration and enable and allow later
> > > >to add support for other platforms
> > > >
>
> Ok, I think that I need anyway to disable the gpmi_io clk because the
> driver should
> handle it during nfc timing calculation
>

No it's ok this way, the driver expect the clock enabled

Michael

> Michael
>
>
> > > >Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > >---
> > > >
> > > > drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++-----------------------=
---
> > > > 1 file changed, 5 insertions(+), 43 deletions(-)
> > > >
> > > >diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/r=
aw/mxs_nand_dt.c
> > > >index 11dbcbbf442..b62474bc5ab 100644
> > > >--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
> > > >+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
> > > >@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev=
)
> > > >
> > > >       if (IS_ENABLED(CONFIG_CLK) &&
> > > >           (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
> > > >-              /* Assigned clock already set clock */
> > > >-              struct clk gpmi_clk;
> > > >-
> > > >+              struct clk_bulk clk_bulk;
> > > >               info->gpmi_clk =3D devm_clk_get(dev, "gpmi_io");
> > > >
> > > >               if (IS_ERR(info->gpmi_clk)) {
> > > >@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *d=
ev)
> > > >                       return ret;
> > > >               }
> > > >
> > > >-              ret =3D clk_enable(info->gpmi_clk);
> > > >-              if (ret < 0) {
> > > >-                      debug("Can't enable gpmi io clk: %d\n", ret);
> > > >-                      return ret;
> > > >-              }
> > > >-
> > > >-              if (IS_ENABLED(CONFIG_IMX8)) {
> > > >-                      ret =3D clk_get_by_name(dev, "gpmi_apb", &gpm=
i_clk);
> > > >-                      if (ret < 0) {
> > > >-                              debug("Can't get gpmi_apb clk: %d\n",=
 ret);
> > > >-                              return ret;
> > > >-                      }
> > > >-
> > > >-                      ret =3D clk_enable(&gpmi_clk);
> > > >-                      if (ret < 0) {
> > > >-                              debug("Can't enable gpmi_apb clk: %d\=
n", ret);
> > > >-                              return ret;
> > > >-                      }
> > > >-
> > > >-                      ret =3D clk_get_by_name(dev, "gpmi_bch", &gpm=
i_clk);
> > > >-                      if (ret < 0) {
> > > >-                              debug("Can't get gpmi_bch clk: %d\n",=
 ret);
> > > >-                              return ret;
> > > >-                      }
> > > >-
> > > >-                      ret =3D clk_enable(&gpmi_clk);
> > > >-                      if (ret < 0) {
> > > >-                              debug("Can't enable gpmi_bch clk: %d\=
n", ret);
> > > >-                              return ret;
> > > >-                      }
> > > >-              }
> > > >-
> > > >-              ret =3D clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_cl=
k);
> > > >-              if (ret < 0) {
> > > >-                      debug("Can't get gpmi_bch_apb clk: %d\n", ret=
);
> > > >-                      return ret;
> > > >-              }
> > > >-
> > > >-              ret =3D clk_enable(&gpmi_clk);
> > > >+              ret =3D clk_get_bulk(dev, &clk_bulk);
> > > >+              if (!ret)
> > > >+                      ret =3D clk_enable_bulk(&clk_bulk);
> > >
> > > You enable clk bulk and together with a standalone gpmi_io clk?
> > >
> >
> > I need to get and refer to the gpmi_io because it is used then by the
> > driver. I think
> > that this does not change what was before. Am I missing?
> >
> > Michael
> >
> > > Regards,
> > > Peng
> > >
> > >
> > > >               if (ret < 0) {
> > > >-                      debug("Can't enable gpmi_bch_apb clk: %d\n", =
ret);
> > > >+                      debug("Can't enable gpmi clks: %d\n", ret);
> > > >                       return ret;
> > > >               }
> > > >       }
> > > >--
> > > >2.43.0
> > > >
> > > >base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
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
