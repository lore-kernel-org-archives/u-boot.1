Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C45C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC148871D;
	Tue, 11 Jun 2024 20:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBgbXhgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12608871E; Tue, 11 Jun 2024 20:52:06 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA5A886F0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b0745efaeeso13827636d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131924; x=1718736724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmeLuADsrFeLKY3SSx40nwc08DVGs13MsOr2qbntFbk=;
 b=QBgbXhgLt0Y5KfMddVc8Pw7n2V/i7/0BnOdJYFCsZHfbma/byIwMay4GGWynWxQZi7
 m4rjbCYixQce2xPJ348SXBYLVRVHwAw6/pRMtUw+cBlEkjnGFBf0j3ERWI2TXYC5fptS
 iq7FaYAfOrASCJCfmw5wr3ugAz9Y4VqY3P/ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131924; x=1718736724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmeLuADsrFeLKY3SSx40nwc08DVGs13MsOr2qbntFbk=;
 b=DltCGt6L9jyKxTFhJ7BeIUJPuVEWK8TAcaymiUjGAIO9x8iqm3+PKdKHaQnf0iBZix
 GLP3baNpNwiOZ4LMNE8JUMQ5bgPGVIpNZ0unmP4v1QVzKEMx2+dSeEPE/JDU3sps5+2h
 UYSg4Ekp1+6V1DsFNhNSkJI6oiaAWg31RMMrnfU0znmNA1A117yvgtmNkLBchmxMdTA3
 DmYFrqstnXDIbABkjk9OEUzLz7QcTYyrWFUUMi7SgKsI9fN386dYA4bQUz5CxH1wR0xl
 3b9UGg7w6PTwyJvpfz9fKVO0o4GVQevDeK7yceag2j2zSzedu6F15Voz5cuI7FonNHd8
 3+sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvUDFz64z3DP5QuC6cOZD/rOqS/SuJDeFmqVHPgtgojlj60WemEEYa75VpJqR8i1u3vOWpD08YVx4rYjO85Is05j+CCw==
X-Gm-Message-State: AOJu0YwR5cczQksWtxKrL9/efdARzyxMyJfOppssbId8Vlm+1TAv1pIP
 P/6IACEQa0s3NUH0Nv4Ng9N3xKr0kdP3QKuuTmpywYnyFx/yqkWnZSYAvVj0LMVwQgg90PI7TfW
 9ODUaz+ShmkV3zDzIsMym7x/On7R8Mjqp5CFE
X-Google-Smtp-Source: AGHT+IEWNiF9cZgA5vHgGmlN+USeGVUTl72Mg0WVaczwevX3Z0aBHpY1whJRtNWyf9f2ERJGIqGpBArfXLCXNqEFJOw=
X-Received: by 2002:a05:6214:3a08:b0:6b0:8d20:e57e with SMTP id
 6a1803df08f44-6b08d20eba6mr23510026d6.7.1718131923750; Tue, 11 Jun 2024
 11:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
In-Reply-To: <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:53 -0600
Message-ID: <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
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

Hi,

On Fri, 24 May 2024 at 10:26, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 7:48=E2=80=AFAM Marek Vasut <marex@denx.de> wrote=
:
> >
> > Add new binman etype which allows signing both the SPL and fitImage sec=
tions
> > of i.MX8M flash.bin using CST. There are multiple DT properties which g=
overn
> > the signing process, nxp,loader-address is the only mandatory one which=
 sets
> > the SPL signature start address without the imx8mimage header, this sho=
uld be
> > SPL text base. The key material can be configured using optional DT pro=
perties
> > nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key m=
aterial
> > names generated by CST tool scripts. The nxp,unlock property can be use=
d to
> > unlock CAAM access in SPL section.
> >
> > Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > Signed-off-by: Marek Vasut <marex@denx.de>
>
> Applied the series, thanks.

This lacks tests - can you please add sufficient tests in ftest.py to
get the cover coverage back to 100%? Please try 'binman test -T' to
see this.

Regards,
Simon
