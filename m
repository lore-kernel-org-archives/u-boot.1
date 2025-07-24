Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D19C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66DA8390B;
	Thu, 24 Jul 2025 23:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRfnv6AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E768390D; Thu, 24 Jul 2025 23:18:04 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7CD835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-55502821bd2so1658008e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391881; x=1753996681; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEBT+SJ3256CSzrTCv4lTFzPHgZSa2Rqf37uNjec7W0=;
 b=SRfnv6AARtad4vWiny1NwoXdrEup9HTSaPee4SYJ5AUS7YlIcUEcuiFSlKFkj7644J
 1mtCbSpyCZkAJXgg3IuA1SzmShiOz1lX/Vor5Ekpi7TwLOT7CuFviaWFfKiwqGFWj27L
 bnqi3bs23lHvE38HuQTnlzQ0Cx19WcSpeHEKwwlgMU/HXGjYZpIa8ghNPNPwn3PRE6gb
 QNLt0u/37k9MBPLa1nUBpOQdy+wGAwKvMUeYyWoNXFeGHbR6r59nZpGWiNSZJjtYAi4+
 JO3Tv5Lx+KGhJbINi25w57/yrXBZ6870XYBlqw/I3vN0c/oeJ1Mze3ZtQ2SQMXANxlFN
 3Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391881; x=1753996681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEBT+SJ3256CSzrTCv4lTFzPHgZSa2Rqf37uNjec7W0=;
 b=IlZ420Wl/85A+9JvRWETX/OWNqCTK4msrjA9W3Yx99Kea6uDWedibNmCVX/QZvPCjU
 VST3meWIy7TtOABl9LULE96Ttsp0gMKZ3h+h3tr03cVoYaXlBrHdjxFQp8zgB/3uonmz
 OPjrP1wLlHetRzHjmev4lJ4Ewl2yJEoidIOvksAri0gvEtlK1//urWyh2pktAg/SaqIu
 S/D1avxC/zN5zE1rtYr7OagMPehsd6mY282x7RBvSjd8BI2wbdhJF6rzf2hZzQri7qrx
 b+bMCyi6pK6F/FqTRpv25cwBPP4RVDKjvDqM6RBIErLYKhAJZDMb1WWTmMG3+4Ywleww
 E+Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXexbwTg7etWmWPt1sdlsDJKdJV5ouN0ecvmfxRygREB7A6N5e7buZpQ/bWXxWAHUa2gL8dLms=@lists.denx.de
X-Gm-Message-State: AOJu0YyE4ipeX8DDGCB0hQKIIqmqu0GR5IslHi/wqf5vwa8G0SAKfPuA
 YkgY/jf9CZb4iPHb+mQEMZ7ChdnlIYmDDL5xy05wTKWCkrjcC+AW3mPEQclav4e3fGLe9nOvgqu
 a+M83FM3mN4yoyCa5VBdA713PHoDqB8T2+w==
X-Gm-Gg: ASbGncsRyDgghvUFXIIIllPlSXqvRZTRfjSLfazuM3jb1Ta34GoJA8MNH4w0GnChRPX
 H9Q1h5mDMcEcRpWeydlb0aFVIhFYE4r5Cx4Xz6Wh7co4U0N+WLUmRNPunggGjnu/6zcwrkW4x/m
 XuvlgSlBiMQTOH/vdwpvgeeYRcnhsWVchlZ8HcbGXFDMkyf51TGle8QNvTLraaK8YWUvyy8l6ax
 QlYAT6UkTzWQpvwH7DWQuXf0TGdkmIT29mxHiQ=
X-Google-Smtp-Source: AGHT+IFt9psAxND0+2TQ1hA5mrbewpMQW4qWwlGYNvFgB3bzYxJoGOh1oBrX+mxVhaMpULuO59lhUKR1hhNYL2ThYF8=
X-Received: by 2002:a05:6512:ba9:b0:55a:e1f6:bd98 with SMTP id
 2adb3069b0e04-55ae1f6c27bmr2389531e87.6.1753391881071; Thu, 24 Jul 2025
 14:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250723134557.1972331-1-festevam@gmail.com>
In-Reply-To: <20250723134557.1972331-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:17:49 -0300
X-Gm-Features: Ac12FXzXigLry7f9i7yihQMvpyHX_zxmsyVf0mEotVQZhbtBzeSLysqPM2Z853c
Message-ID: <CAOMZO5DRLueuA2nJ6FWe1vxrNbuuFrjdJk3dpBogVyHM6NYJTQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] imx93_evk: Fix the board name in MAINTAINERS title
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, Jul 23, 2025 at 10:46=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> The board name is "i.MX93 EVK", not "MEK".
>
> Fix it accordingly.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied the series, thanks.
