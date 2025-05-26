Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24571C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726AD82C57;
	Mon, 26 May 2025 09:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cCrOQQZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA0682C96; Mon, 26 May 2025 09:38:23 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A79B829E4
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-31122925a18so870346a91.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748245099; x=1748849899;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrsnZPmvqv/NSFsE4I1eq1RrNGJhrUmUreAV9OqHGWI=;
 b=cCrOQQZ2ldiS1h421blowgIupmYV4XdlTdWWkOqlrCS0IICWCiaWvKTl4yIxi9uka8
 VI+HVi+QiKeVtBq9Q8v5xRth8oz3rPFTUri0UJHkLtradP3wLFIfhpeOKkHM6cFPMb94
 h9KXeathtaDV55hUnUjhMcTBovggS4nwIzHqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748245099; x=1748849899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrsnZPmvqv/NSFsE4I1eq1RrNGJhrUmUreAV9OqHGWI=;
 b=JtfrvBXHpawvBXBy3++rlCII/6xP3m3EGDpfG+BeFt6/tGUs89PunNBkq54nJ16Ca9
 oR07epSn3NBOypnzQFS84LdJiyypMKhp9Pqp+PAk9GnK+5ugQTvm7XEuYxybjEo4phaG
 EhH2n+GDm/AK0xGjUMC0MbjEBxuRb2P/uSlMMXn+6Nl0/+l1DKU8PCsLq3MnH58GjBrA
 Xv1McEpQAQX8CmrLDTvgVNORTJqSUIqt//ybrwrFDSlTOt9H31947QVJf+Ol5Z9auM8m
 RtvHkyz/jsjmoGMWO+LrtzzpBfFhRrjIJn+f1EpTchZ9lw/cjCklNSqj+DSoriABk56/
 JAWA==
X-Gm-Message-State: AOJu0YwWboegqtBu1mG1aigEPEPJrXJT/dNmFf8gtmnKhuzCaTNsbAfQ
 bVOwYl0gdZgo4e7+2uLylhzHPujYr//6YiFklMzI+It0B7Jjqm+bkysk0YG28RApo/mmWyvO9Ll
 wpoCr+Jps+tRDvw/IldGnDi65OWNWdW4jH/E1C2XTtQ==
X-Gm-Gg: ASbGncumiOcSqZIkiJBkMAMfWww7RMgHfaV5UjyBBmNFJmPsK8/QB8Cnyg8iy4uTTlj
 XSC/ep4vgj8ICkncAAKUIE/QXfDqOHDgYTVBJTjCdXW8fhiQxOhYmV347v7RS28CKLoXtasjhec
 cXEDbIKT4CdZBc4wMXPhxJIsTrKXbw24FOJN9SQTRtMq355aK+GkNeHQi/mh7lz7hleCEiBwWB
X-Google-Smtp-Source: AGHT+IGMQEpEbFL7pH8eFwtESnImrCLondTt5HIrUT/4bhUw6iKlcp3Sucf5yN7uKKrG8m9AsXFwTdPGud9ht7Bw9+c=
X-Received: by 2002:a17:90b:380f:b0:2ff:7ad4:77b1 with SMTP id
 98e67ed59e1d1-3110f31c388mr14039743a91.2.1748245098899; Mon, 26 May 2025
 00:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-2-michael@amarulasolutions.com>
 <20250526084356.GQ19264@nxa18884-linux>
In-Reply-To: <20250526084356.GQ19264@nxa18884-linux>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 May 2025 09:38:07 +0200
X-Gm-Features: AX0GCFuOfki5ryO752P2RtxtWiQ9_cHz8oKGpkRFKdbE2TXFc70kvnPC4prD8PY
Message-ID: <CAOf5uw=Fk0y0G24f2JWcDiWdvWEUUTRWsD5v3ugBxRjSZGrtAg@mail.gmail.com>
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

On Mon, May 26, 2025 at 9:34=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> wro=
te:
>
> On Sun, May 25, 2025 at 02:23:10PM +0200, Michael Trimarchi wrote:
> >Make simple the clock registration and enable and allow later
> >to add support for other platforms
> >
> >Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >---
> >
> > drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++--------------------------
> > 1 file changed, 5 insertions(+), 43 deletions(-)
> >
> >diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/m=
xs_nand_dt.c
> >index 11dbcbbf442..b62474bc5ab 100644
> >--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
> >+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
> >@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
> >
> >       if (IS_ENABLED(CONFIG_CLK) &&
> >           (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
> >-              /* Assigned clock already set clock */
> >-              struct clk gpmi_clk;
> >-
> >+              struct clk_bulk clk_bulk;
> >               info->gpmi_clk =3D devm_clk_get(dev, "gpmi_io");
> >
> >               if (IS_ERR(info->gpmi_clk)) {
> >@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *dev)
> >                       return ret;
> >               }
> >
> >-              ret =3D clk_enable(info->gpmi_clk);
> >-              if (ret < 0) {
> >-                      debug("Can't enable gpmi io clk: %d\n", ret);
> >-                      return ret;
> >-              }
> >-
> >-              if (IS_ENABLED(CONFIG_IMX8)) {
> >-                      ret =3D clk_get_by_name(dev, "gpmi_apb", &gpmi_cl=
k);
> >-                      if (ret < 0) {
> >-                              debug("Can't get gpmi_apb clk: %d\n", ret=
);
> >-                              return ret;
> >-                      }
> >-
> >-                      ret =3D clk_enable(&gpmi_clk);
> >-                      if (ret < 0) {
> >-                              debug("Can't enable gpmi_apb clk: %d\n", =
ret);
> >-                              return ret;
> >-                      }
> >-
> >-                      ret =3D clk_get_by_name(dev, "gpmi_bch", &gpmi_cl=
k);
> >-                      if (ret < 0) {
> >-                              debug("Can't get gpmi_bch clk: %d\n", ret=
);
> >-                              return ret;
> >-                      }
> >-
> >-                      ret =3D clk_enable(&gpmi_clk);
> >-                      if (ret < 0) {
> >-                              debug("Can't enable gpmi_bch clk: %d\n", =
ret);
> >-                              return ret;
> >-                      }
> >-              }
> >-
> >-              ret =3D clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_clk);
> >-              if (ret < 0) {
> >-                      debug("Can't get gpmi_bch_apb clk: %d\n", ret);
> >-                      return ret;
> >-              }
> >-
> >-              ret =3D clk_enable(&gpmi_clk);
> >+              ret =3D clk_get_bulk(dev, &clk_bulk);
> >+              if (!ret)
> >+                      ret =3D clk_enable_bulk(&clk_bulk);
>
> You enable clk bulk and together with a standalone gpmi_io clk?
>

I need to get and refer to the gpmi_io because it is used then by the
driver. I think
that this does not change what was before. Am I missing?

Michael

> Regards,
> Peng
>
>
> >               if (ret < 0) {
> >-                      debug("Can't enable gpmi_bch_apb clk: %d\n", ret)=
;
> >+                      debug("Can't enable gpmi clks: %d\n", ret);
> >                       return ret;
> >               }
> >       }
> >--
> >2.43.0
> >
> >base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c



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
