Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56308C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C57D988315;
	Tue, 18 Jun 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9P9RWVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5876088137; Tue, 18 Jun 2024 14:44:00 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7323E88315
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f986b92acaso3078978a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718714634; x=1719319434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+3aUTCzpArwR0EBhUUyywknXULzUclPRSf1ivPCJ90=;
 b=X9P9RWVB4U7cQjofpwZav6KcXnLBGtrRQRFs9zcf2EwcPfK1+obsLnrBPp7g1i2dsP
 /tifG+IOoVIFUIk5WBzb/DKXjzbx38eqnrnLEcyzhzHPVW+2LmUyn4E4Pqu5/3V8C+2R
 e9cUxNuitkrqUYvCVDDfqjNwzwPR8h7SoVVRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714634; x=1719319434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+3aUTCzpArwR0EBhUUyywknXULzUclPRSf1ivPCJ90=;
 b=h/VcBIABcCdGuMw5ij+Ce2Ruz/aMITpBJe2/QgECwISLW9VYvFJAlBywVuR/Xbful7
 H6XzTQSJlZRACrB0J9h8Z3YfdTwncdpaXBzIIAnaIQFiGnYK/Bapf/LDgt0FAvRWild6
 zMl6aOFm/IrTYSx4E2Iaq5O24dml6AH8iLTggA4NKiOwOrPTUFlO4QjeSABgAN3TUC2y
 YnTDmsD25zsm085WARdbYs+FHNgGO/1QNSSNLRU/C2bM865Tj3kKL+8Gklj46id+Bntg
 bHzQP0cvVC2Y/K6NmUlbu1/tRBB83U4+ZLv4DbPVKY4NtmuJygeA6ywIJxu0ZG/GzaDX
 Lk/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNBGBcGyM2rO7ryOC1/KHwfTExC4qY0zy4/UaBHTGs/YwIVUYwLmsHV4Z8qu2aq3qftoXfeheoWSOAy76h/qWS3GPNMQ==
X-Gm-Message-State: AOJu0YzHLZi8VCDhMWLqm0Bwxi49mGvX0DDnl7l8u8incrLmQ8GWd89H
 yp1rcMFELWUFUs4LKp4ew1sdCtk3Ml3ZqPPUh0GypK9itarMxUojq1l3Ac22/bFnZ4DpexFYOYH
 P/UsYueMAmvq6IhTYm/43SKTNu0zvWXs6IE9/
X-Google-Smtp-Source: AGHT+IEvlV53DwrYYAJFFwhf7ROSNA30HHBIiRoWpccyGuubhZE5NWKVNH903tJ/6JT+4feXtyurPT0SfbN6Eo1XLAA=
X-Received: by 2002:a9d:7597:0:b0:6f9:afb5:9e0c with SMTP id
 46e09a7af769-6fb9375ecffmr12956673a34.10.1718714634140; Tue, 18 Jun 2024
 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
In-Reply-To: <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 06:43:42 -0600
Message-ID: <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, anton.gres@ifm.com,
 ch@denx.de, 
 Tim Harvey <tharvey@gateworks.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
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

Hi again,

On Tue, 11 Jun 2024 at 12:51, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Fri, 24 May 2024 at 10:26, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Tue, May 21, 2024 at 7:48=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> > >
> > > Add new binman etype which allows signing both the SPL and fitImage s=
ections
> > > of i.MX8M flash.bin using CST. There are multiple DT properties which=
 govern
> > > the signing process, nxp,loader-address is the only mandatory one whi=
ch sets
> > > the SPL signature start address without the imx8mimage header, this s=
hould be
> > > SPL text base. The key material can be configured using optional DT p=
roperties
> > > nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key=
 material
> > > names generated by CST tool scripts. The nxp,unlock property can be u=
sed to
> > > unlock CAAM access in SPL section.
> > >
> > > Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> >
> > Applied the series, thanks.
>
> This lacks tests - can you please add sufficient tests in ftest.py to
> get the cover coverage back to 100%? Please try 'binman test -T' to
> see this.

Any thoughts on this, please? At present -master is broken for one
file and -next has three problems.

master:
tools/binman/etype/nxp_imx8mimage.py                       38     26    32%

next:
tools/binman/btool/cst.py                                  15      4    73%
tools/binman/etype/nxp_imx8mcst.py                         78     59    24%
tools/binman/etype/nxp_imx8mimage.py                       38     26    32%

All the others are 100%.

This is clearly covered in the Binman documentation[1].

I will see if I can add this to CI.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#code-cove=
rage
