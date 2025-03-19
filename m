Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52A8C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 16:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336CA81EC5;
	Wed, 19 Mar 2025 17:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euZf7NM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FBF81F59; Wed, 19 Mar 2025 17:39:16 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6C181E6C
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 17:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so7481049a91.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742402352; x=1743007152; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzOpl2LRj9R8K6mU2e6SvGCxhSh6AQ4cU1XJ3+gjejA=;
 b=euZf7NM6SxZf2h6DtsVQTf6zp0DwbVOQrcszLboBeKZyLV6XxvAdvUil3/N/xc23Ep
 jmFaccpy5zoKyku1PxyKMlsc55Qi1YZZv8X8AeS0xI5ZWlFTKx3vys/1Cp3GP2Bx5UL8
 TgyncmJAmiDcPWIHwg0W0FNOqWjporbtZb9PRF9CfUmWTmvpsCuI6NwcypxcODzpgdd0
 MYXq5FCbIaOrkX9rMuY/LyCc9bb8fzH8Irot//KEZs6Hjw7h8ySVA8zfeogJzE5BsHJV
 KGXdzyEecfKDpkTZ9fCWp5zbU8IiM44z9WKMdivvTNGUzuQ2BAp+xuNehwfeuvOLJxep
 uPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402352; x=1743007152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzOpl2LRj9R8K6mU2e6SvGCxhSh6AQ4cU1XJ3+gjejA=;
 b=ooUXDEGFHfUe+s6czAvmKTJ9DqrsL36kBcvFkj1hLGBtxpvZ9Ulc2o87praTt/Q8xF
 Gm3R+jjqxGUVAkhSq6n8kRyvzZz+HyDJWt9t/TlpZB4gW9ut5DMJaLAEpd4ZjQbZ3VDy
 IMBt6jyztL2pm9QumBQ79PWnyObZnReX3gdbIx8r4USmJv35WKtuYjlWcEomKBxN16d0
 AKKR2iZ9wivg7nmr0Hnm6zYRpwUG0Ai2rad9AaZ4UWOmMZ2oebP9LsooXNDzVGGliCHT
 BBA438yzw7ZY3P52W3srqNThC+56MXw6kHe9dH1Gp1+srogzldIc3mCFMgL3PLmIJ9GS
 9ieA==
X-Gm-Message-State: AOJu0Yz8L7KhWFLTtBRZ223/Dv/yOCRnAAPEmRUDYHZQM2y/dov0kVRD
 YpcVmSr4R7zwN/aN8L2GmMTMu/kLSoHO0Xk79xhIqLzhiEkDL0OFRrfD+06+KDGpOsfcmenTCy0
 apbBva8i+W0kGDvWDcsgXru6I6Ko=
X-Gm-Gg: ASbGncuuFASMud8FKPQjmcu/Pp0KJyFp71okTrV/t3meO6sV5Ll70bquyyL9sPglvVP
 jp7TNFkFitT8C8bPR5J7q56I0x+A54WOkLUR8Hviucygt/oqIPA31h5nxRn5KCBNOo7UVZFqWgO
 5mTzwX2gdgEx7ZAvBTURR96vzutg==
X-Google-Smtp-Source: AGHT+IFh7khwljbF8dJokcw8mZgjovua7ngDmy87cFbSnsduDD6LD0uN8GTCFmwc5Ch5QMkmj81IZ7l9DwVvAYVWZNE=
X-Received: by 2002:a17:90a:dfc8:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-301bde54d03mr4362812a91.9.1742402352002; Wed, 19 Mar 2025
 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
 <20250318233849.587520-2-aford173@gmail.com>
 <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
In-Reply-To: <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 19 Mar 2025 11:39:00 -0500
X-Gm-Features: AQ5f1Jr0417KGqoZ-2A1qmMMqGCIRnCBln1uHlq6nusc7DJbYUP9oA_ibCPmMuA
Message-ID: <CAHCN7xKd2geEkK77kYBp1jQJpiM_NNpTPP43ONNYsUNgEtaVrA@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Wed, Mar 19, 2025 at 11:15=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Tue, Mar 18, 2025 at 8:42=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > +       if (of_machine_is_compatible("fsl,imx6qp")
>
> Missing closing parenthesis.
>
> > -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> > -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 1=
9, 6));
> > +       if (of_machine_is_compatible("fsl,imx6qp")
>
> Same here.

Sorry about all the noise.

I think I forgot to type 'git add' before the "git commit --amend" so
the fix didn't get applied, but because the same file was shown in the
commit message, it looked like the fix was in place.  I'll have to
confirm when I get back to my build machine.

I'll manually build a few more mx6 platforms and try to spend some
more time trying to figure out the CI/CD tools.

adam
