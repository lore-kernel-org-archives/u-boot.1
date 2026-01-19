Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7275FCCF2E7
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF48B80B98;
	Mon, 19 Jan 2026 12:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jdITN8mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED5A83015; Mon, 19 Jan 2026 12:19:10 +0100 (CET)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6625800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b453b17e41so2672436eec.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768821544; x=1769426344;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bbg+DYVwwiNscJ+CP/UZSn3znRTbgjGLqHq2xOISdGA=;
 b=jdITN8mjNtOu3W/j+EZf6kHQ0gUvFLiqiYJqqI7oNaxbVUE0dCGsX24o0Xqho7AP05
 xyifUNuWIyAp1AEP52oCU255jPD/V4ot74bNb0E+YZSi7JLdy5SFHdACm1GmCN8v6WjF
 887WE+3KkWTVTrMzra9LomePGj19RCYJwYF5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768821544; x=1769426344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bbg+DYVwwiNscJ+CP/UZSn3znRTbgjGLqHq2xOISdGA=;
 b=ZtGxNsV80plz3qWmK6C+bTndZNxLnY8l7B8E4jPcnoYNBY/YC3z7lXmM/Zmno+8q/G
 zsGOvQZaPDb7ym39L5q8gjQDl5T7QJz8SfmLqtwJEa4QBafu260l7/GaS41f8DFWokm1
 CwpPKi9JzSjJsNJiXLmyNK2x3P0/2AW0NQLDKhtHHe2YMiMLdPx8tmpl2J3RHLWU+uie
 nXpQpvLzrkGdUiVYMR3JeY246DlyWMl1nFlGCrlBGWSZYiTiCn9yOcGU9xwVIdbnIU0L
 1MEZZa4kNaJGD3VQktN1B5Q0nbsS6W0xhEC9y9iHH8stsgsmUYZkGSD3uIWGFDjoPiZL
 GSIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxeuEUg2eqrL4Rp9GjowQUlAmDogbEX07t6wR4Mt6n0v9QqD1I2JJWDAgZTKj7FJu+SpB9T/M=@lists.denx.de
X-Gm-Message-State: AOJu0YxwgqxhK8/KTDy32ovCJmDB93viSpFrkkG9EMXFof8QAnk+iFd5
 BFEgKA3S6bywYC2NTWjM4o1rPdNfEze08+fc9titSQk9U4ZMsLceAuieT1jByzP6xNoe1HoltPW
 TvSmCT289oArtA2Jondo4X2gONEaWE/MDBQV8I19P6Q==
X-Gm-Gg: AZuq6aIdOZNR7/BOhHZOFCFjpCs4U0y0AqK9pZU7lQ/pyaFod8blzV25mbcZfSJkOQv
 UpVSanjQfUDp8tVJhj4PeXGwR4Y0wbCdTUtDBVHTBP5ckHAELuxVO1WhijvQdnxJGP+ONL4xYp+
 R0GBbxSjkNCqFMsq+kEyh3jcG+VvzTEMzBBbSaJQKuwtJqGHWKO9oIwpbDdTpeg+Z8o6BVBP6CP
 DTKFazVGVrgYJJxhDnHMOJKQ7zCfWly0bqWLbHlWJGupVc52wIfGmv2Qdd9mXUCPJ2Sei3CEZRF
 Z1mirRnLsE0knt9wKC/JGOwfG98=
X-Received: by 2002:a05:7301:19a9:b0:2b0:6a03:f08c with SMTP id
 5a478bee46e88-2b65b8e4982mr15145804eec.5.1768821542719; Mon, 19 Jan 2026
 03:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20251028083733.574757-1-richard.genoud@bootlin.com>
 <87bjlruzxg.fsf@bootlin.com>
 <e83f6caf-0a31-4899-ac28-3a24e0ac7fba@bootlin.com>
In-Reply-To: <e83f6caf-0a31-4899-ac28-3a24e0ac7fba@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 12:18:50 +0100
X-Gm-Features: AZwV_Qjrb9Ig4_Qu55PJkwpH0OpyRa6HqPMWoKnBGI2IjobrTWp9R4tVbg_vV0w
Message-ID: <CAOf5uwkwcewc0_h_YoyDrk+wgk2rbsyP-4W9-SKvZ9Cb44NfdA@mail.gmail.com>
Subject: Re: [PATCH v3] tools: sunxi-spl-image-builder: support H6/H616 NAND
 boot
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Anand Gore <anand.gore@broadcom.com>, david regan <dregan@broadcom.com>, 
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 James Hilliard <james.hilliard1@gmail.com>
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

Hi

I will drop my request now, and prepare a new one and including this one

Michael

On Mon, Jan 19, 2026 at 12:14=E2=80=AFPM Richard GENOUD
<richard.genoud@bootlin.com> wrote:
>
> Hi Michael,
> Le 28/10/2025 =C3=A0 10:40, Miquel Raynal a =C3=A9crit :
> > Hi Richard,
> >
> > On 28/10/2025 at 09:37:33 +01, Richard Genoud <richard.genoud@bootlin.c=
om> wrote:
> >
> >> The H6/H616 boot ROM doesn't expect a SPL scrambled the same way as
> >> older SoCs.
> >> It doesn't use a specific seeds table, it expects a maximized ECC
> >> (BCH-80), a specific BBM (FF000301) and doesn't work if empty pages ar=
e
> >> skipped (it needs its specific BBM, even in the padding).
> >>
> >> So, add a --soc=3Dh6 option to support H6/616 with:
> >> - more ECC strengths
> >> - specific BBM
> >> - default_scrambler_seeds[] with all values
> >> - no empty pages skip
> >>
> >> In Kconfig, select BCH-80 by default for SUNXI_SPL_ECC_STRENGTH to mak=
e
> >> BROM happy.
> >>
> >> And in scripts/Makefile.xpl, use --soc=3Dh6 option when building for a
> >> SUN50I_GEN_H6 SoC.
> >>
> >> Tested on Whatsminer H616 board, booting from NAND.
> >>
> >> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> >> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> >> ---
> >
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Thanks,
> > Miqu=C3=A8l
>
> Sorry, I didn't remembered until now, but it seems this patch also got
> forgotten.
>
> Regards,
> Richard
>


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
