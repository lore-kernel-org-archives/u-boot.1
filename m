Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF95C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 17:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E159C801BE;
	Wed,  4 Jun 2025 19:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hBd4y017";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AF180584; Wed,  4 Jun 2025 19:07:16 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264828006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 19:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-553246e975fso36163e87.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749056833; x=1749661633; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6Fkbpb5rWzzY6Tu5LuabyhObjhgLsT4+OY7HLMhoPo=;
 b=hBd4y0173/0VMxrz9H4jWc6ciABsATyrqhzQMIYjUKBOl8Hcm1P38wtVMzgQTqgaXW
 0im5D2kfaBIPe1fI19zZYk79hjvN8+syDW18iHx7JYJ5cg6XpZAMJWWQrqbSw8RlzlK6
 f0Inqz++WikLZPhHyFh24imp9kiaORHoEqbbQcUQaguYlEELhC4Sh+J3W3zIYayZrd/Q
 EulKKTkDXHVLmMBaMGXUoSZKDQliE7cAkr3IuK/+kOtsZOR348U/XTV4vQ0ASuuR66om
 1rMuIH3sdxe9eBSGA+/JD0UPe34+Mpch5/pUcupCu7E2zDO8stnoTRxSO51/7FyYepKx
 Hl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749056833; x=1749661633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6Fkbpb5rWzzY6Tu5LuabyhObjhgLsT4+OY7HLMhoPo=;
 b=v1BB1sofP4yLA5bXq9CIxd1UZOm1rw5DSLhPjs7rLnIXpRKLi6PjQ2l40Z5yol+jkW
 wer9uffIEMddCDpaXtpmR2ZyzUCvt+scHCc34ZpZzeYO7GZ/cIlHz7WoADCQqfYmhiGV
 vlO7wbR3buAvWyhNCYU5FRQK7sEJraoymfbgAge+7xRfqxKrLt7SwGR0BiqKfvWtH1bo
 d8VNcgixOlEsF/puE9oKHsHFO53j+dAdu6gY1B1P3ke0G+pNqdBA/2dp/YF9Bf1zXWgA
 D+pOl9/d7dfUQZnDW/8/xgcHHm9VgpA5vZ3SCaPziTGD+rFWos+OLcpQgci71Y9wMda2
 EGkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVbL2UH3m/eZaTpfwaxkBuWF+baS5m/BgIxBCx/pqmigr6zmlbBeTsuiKYPENUK6Q5DJm+FxA=@lists.denx.de
X-Gm-Message-State: AOJu0YwbXF/1GgzV7O7daQlBS89lRVIXr2IG0EvuAflkfzh6hguBV5H+
 gbkBswesoR93+oYzofW6rrPiHSX+WCb2Rao9Wfk1PdJ0h97uJaY9w2h9zeLFJe7jSHlOXC7oOyo
 DSPWrfdqUQ5UNRB+kNrNcWCNq60+hA5c=
X-Gm-Gg: ASbGncvX56eGzI/Rbvc5TQQ3FopFoiVVaL4PhD9QpJd2acSCsVeQ+kca6Za1SEdRKxx
 jj8ybjzjFgijCcoaEVlFAM/J1D49TC9JLQakfPiiv6KZVaOLCuHna5zkzL94ATxuml86HydHkxw
 SuiHKQQOOV3jp9qY5fESDEsNEZzSgtOVMLrNur71pB87+dLFlnQoeeGsuv3hyIq0Vf+oRHata2V
 Ew=
X-Google-Smtp-Source: AGHT+IEjAfeCsOXI5vokQy2+R7DBpWcmkkfPK1Qq4MsQWw0wT0C5yhLo7Sc59SkN9O/TfVJdOCu6SPLl4DkdY3LFcpk=
X-Received: by 2002:a05:6512:108e:b0:553:50f6:ebcd with SMTP id
 2adb3069b0e04-55356ae56a2mr1190492e87.10.1749056833068; Wed, 04 Jun 2025
 10:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250604112507.11358-2-Wojciech.Dubowik@mt.com>
 <20250604140949.GO1382132@bill-the-cat>
In-Reply-To: <20250604140949.GO1382132@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Jun 2025 14:07:01 -0300
X-Gm-Features: AX0GCFu0Yk7jQxROnHvKWLLGBU8F9zpxCJiaZiR6mCRZo2YG52xLR5cTd3AsE5E
Message-ID: <CAOMZO5Dw4s9+omhVR-FHp2Z1boRioyrPStYEeft9ThycMr2tHQ@mail.gmail.com>
Subject: Re: [PATCH v7] arm: imx: Add support for Mettler-Toledo snowflake
 board
To: Tom Rini <trini@konsulko.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Manuel Traut <manuel.traut@mt.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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

Hi Wojciech,

On Wed, Jun 4, 2025 at 11:09=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Jun 04, 2025 at 01:25:05PM +0200, Wojciech Dubowik wrote:
>
> > From: Manuel Traut <manuel.traut@mt.com>
> >
> > The board is similar to "Kontron SL i.MX 8M Mini" SoM.

I think you meant that the snowflake board is a carrier board that
uses the "Kontron SL i.MX 8M Mini" SoM, right?

> > There are two variants. Snowflake_v2 has an external SDCard Interface.
> > LEIG is the same but without display and with emmc card only.
> > Both variants support 1GiB of main memory.
> >
> > [ bigeasy: porting and a bit of cleanup ]
> >
> > Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> [snip]
> >  arch/arm/dts/imx8mm-mt-snowflake-v2.dts       |  127 ++
>
> What's the upstream status of this dts?

To expand on this, in U-Boot, we are migrating to OF_UPSTREAM, which
means that U-Boot will utilize an upstream version of the device tree.

It is OK to use a temporary dts in U-Boot while the dts is still not in Lin=
ux.

When the dts is accepted in Linux, and U-Boot dts repo syncs with
upstream kernel, then the board can migrate to OF_UPSTREAM.

Please submit the imx8mm-mt-snowflake-v2.dts to Linux, wait for some
feedback, and then resend this U-Boot patch with a reference to the
Linux dts submission.

As Tom mentioned, the bootph-* properties are valid upstream, so you
can submit the dts with these nodes and get rid of the -u-boot.dtsi.
