Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89204D149F8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8BB88FC7;
	Sat, 26 Oct 2024 02:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HT/hhvFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001C78902A; Sat, 26 Oct 2024 02:24:27 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F224A88FBF
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso25027851fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729902262; x=1730507062; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdGWwWSleaNmsDaqyWTYms7q30sWogvTBkJqnLqo7ks=;
 b=HT/hhvFkQBP7HckCa9CMBN8xAjFtbdL0orHC5IpTrHjLM3EQj48a2guNOs4aqJ3aRD
 36ki9n9ysRG5LTwdS70EcSEyHza+6312J0Q2FYGir8igMJkvJ3lECVkE22gQPFJWnk8d
 Nl/IjmvTsnzToxCDcD6Ji3h7EWerrLLZfY15rGBewN2B8Zw4JiNmAEt3jY976Csz5hg3
 WuG4rYcgvgMGqVHCmZOIjdm9DaduSJQrBLFvjgGKTLVzTFdponBAb+/gRaAKEr8RLJly
 267P/ePEqXRuVsIV6F7ySPhUjmpCqKK+9Hy2ngpnjKohRZQP5RDiGQQJ5HbbW9QQKFg/
 uJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902262; x=1730507062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdGWwWSleaNmsDaqyWTYms7q30sWogvTBkJqnLqo7ks=;
 b=HOd6Wr2DezfWSwdF2OIJbndCeR1n5lwfXyjCg+2fXfftR84EGLPT28aQnVV8rCETjN
 j8PZD7RuAyeLiPnp4qnJKfSPsa6Pwuu9b3anSEs8seYa46iukJZV5BYf7qulp41eC1y8
 kK5b3u4ztamfCeyNWTaBM9SX4bOOUsOFdSnTfU/I0gTxtFvZArshpw0azgM+FEMmbdJE
 cXkr6KTpu8d9fQw3l0HmJknjji6tHWSYnl4rkNbRqX9ZHyyL0p+kDR038mTctW4n4DMN
 AVWb9CtmtLX1UkGCA5qGX7k+qCIqUpddxEXY6b1uJzfkGS1mfxHGsNWbvSycBQp7UA2Q
 fflA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDMW1KsE1oMylvL1OLUx3kJqdCmVD97yXV7xm/ndo4NMBkPnqrNDz7P9dcQA2MeVn+D/WEvJQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfw3hPO4+4mUoaYw6qtjWxPLcmNCfSNJQH34vmLqofZK8Eb7mZ
 74Ij6pGmGt211vf/zkg5WCPi/bi+MvL9gLWvc/Bk0XxtbQdmZygYXSIjS99VC1NHzItbn2SImFY
 mCyg04iKxvlaHAJuLIzvMCS3fG0Q=
X-Google-Smtp-Source: AGHT+IEf6gHK4lQLim80WddeadokrigEx1aQMCh+WWUuL0yNehLACM/oXCC4r0H+HRoHQqQ7dprztu2oPQKBlculrQ0=
X-Received: by 2002:a2e:b348:0:b0:2fb:6169:c42d with SMTP id
 38308e7fff4ca-2fcbe08deb9mr3848701fa.41.1729902262011; Fri, 25 Oct 2024
 17:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
In-Reply-To: <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 21:24:10 -0300
Message-ID: <CAOMZO5DtDDOqmWuQbbDWqAaDzszyFsYud-JRGiwr5zeHiXveqQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
To: Marek Vasut <marex@denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de, 
 Tim Harvey <tharvey@gateworks.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Oct 24, 2024 at 8:51=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
> > I enabled IMX_HAB on an imx8mp board, but even though I knew about the
> > implementation, I forgot that I had to provide a sane value for
> > SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
> > implicit requirement, and there's no build-time warning; the default
> > 0x0 value just ends up being returned from
> > board_spl_fit_buffer_addr(), obviously resulting in a non-booting
> > board.
> >
> > The existing imx8m* board configs that set a non-zero value currently
> > all use 0x44000000. The actual value doesn't matter too much, but 0 is
> > always wrong for imx8m platforms. So just use 0x44000000 as default
> > for those platforms.
> >
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Applied, thanks.
