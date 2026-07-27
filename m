Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB68C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 919E460602;
	Mon, 27 Jul 2026 07:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZD6MhWhAvoZ; Mon, 27 Jul 2026 07:14:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B4EA605F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785136461;
	bh=22+4RgzSJRq09QiiSP4ZPCrE379bm2PuSSWotd8CsFg=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N8oYdNbO7Gr5bAy5m3b0dgusKE/Cdf6FvFkE/enyvMhKm3JuX8qr98C/ZjSm4kRV9
	 ohAgtr6zzFlOydEUJ5dF5Nja/57TN5X5UJ2dpfhKOLI5CIr1tunGDwdSmg9zXHm/YC
	 7DaligNdh1eSrUW6pfcfe7Aa7Tzi8BQ3/BzmXwfcHGlsk5OXhdoVbKZqRaxYxQ49qy
	 npumeQatsPIz6MXOqfU2A5rcS83gEZPRby4GzDurCuXoSywZvIx7wmJhcJGIlUo3NP
	 huvu55IAuwWuLPFogMsPZXWoxEHw+hUMdqULFYed8M+F5pQj5JV5O2FQvax+Tv3SBG
	 +yKTkBnnD8Fzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B4EA605F5;
	Mon, 27 Jul 2026 07:14:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A73A83B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CE9940623
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IG8aFKYmVrOK for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:14:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C27F40621
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C27F40621
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C27F40621
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:14:19 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso20143541fa.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136457; cv=none;
 d=google.com; s=arc-20260327;
 b=HJZ15r9Pk4UqRxpq1UhgTpeUTTcCjw6dIyZs/6tHHBxVVS8nFGyE0fD/KXq56VPq8R
 J6TUSVD/oPcoOxRUnQ3fthbMHg+hvfm3Dj0vR821m+rg5aXu3RyFHLCdXgJRd3nO5eIU
 o8FkbmxICcKucBOtRI7gnUVa4fJ58lYHgzoXEKKauidTgZl9nObZMssrkNvW+2cxPycc
 PANwknCu8jMI3/H4/Vp/XRRSj5S+75W3+tQL45V7TsAoawDvXlLYMZUQXt1Il1g/9McW
 qW9iIlRijHeZN2LMZhll9STVdeeMlYl6xtC2lB/v6203c+GcPPfSqwzaIl8h7wrQPd5k
 ThHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=22+4RgzSJRq09QiiSP4ZPCrE379bm2PuSSWotd8CsFg=;
 fh=d39asfb45lnrRkjFlz7i1tiVsVO7hWxPLqeLiy4+HHM=;
 b=VHM1PP7lhedWe/mor50xck1SS7TJOP4TtZ5HRCpTbjI3FQ8asPLmmu6a7vnYBrktZ/
 54qL3sr+/VdjaSSthUuUxYHX1DcA044TIzcFfTcNvSOndUq9y+k/aKgxcOpjYzfy6Dzr
 VCjh6sd4bzhQ9ofVZAHjtRxttGlUFZyNHgbMO2xthqrEGb2F/9UYVyWgq0aX+Romaogw
 eawLFArK/7nPWbyu+ibIXW0V5L02aWbtOSHL/HUWOmd/gpeOBPboVmFjyjXu2lPrChI8
 nbRYl7QuFXWRI0bnCKz4Wtisx2SDxhuEGlzRD9xQuiNJnM4T6FHWx/gEn/z4J/V/gDnV
 Qf9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136457; x=1785741257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=22+4RgzSJRq09QiiSP4ZPCrE379bm2PuSSWotd8CsFg=;
 b=UuiUrdvOWTqd4aQPMydIfytVrMR7TzyanZEOH1v/88iQMzPjjm9M1PO2K4fLJ3eXg+
 Fi8DCe3D8rc0x4b/9JnD/gGPBdTqvuoWdEAWhLzBMb7+n1Ihu9AYl9uU58PS9ZOOLjwB
 lp0Slj7Gp1XZ9n5he1K4dv0OJe9pdjEMLNq5nTTRnb8kuCfgeAyftOkYmZ6tA4wVXrJm
 ZiDjQSs2uss0YPJCDcMtdpAv6hgnh+NcMq+Jk0TKEFoa5+0LiRlA86wX4vaUG/P7bgkq
 fDiaNT2ZPsnvCE2vUJugZLf1JTjiA9D8VMvSLQMYUD5RybHQQMGe9Fgr03S2O5h56Htt
 3sbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmP4ckY9scMzC1pmL1BNrN/6MV5YV22q6Puu9nkvEy+V7A5tHMe9/LTcXkMXXNk3L8uhSrTJQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxExrxot6aKiLIS/fRuTwhd4fyOmUIloAfEe+Nbto8kDLwgt5kW
 /3duzCVTkaM6mHlMUJX7W1e8Tf7RFzpnZHB4ruII52Sq7Q3ZC0KiAprBBU+nDNIcAweSa3vrNk+
 ewZzlWPeKTYwuQzF0opTOcf+YUrGZZRL5VmQny6n5+g==
X-Gm-Gg: AR+sD11BMMT3kngamH3LQSUvL/XkrElgl62lzCLhb+ypJWcgPxfq3KPVVaUus1Xy5e6
 hWIm+s+4qvx/OLAf5YAZzz/GMhml4HMDfx9w+G3Qflv9fBSQHD1w2tURCTDIoGikyLYYp6rqIkX
 Ocl2f/eiBHQbcfdI5V50za02pvsjoJ3s+VSPfz58MXjMbxhhWDWgjK8BgYAGNYsTNRcST4v1fd/
 3L1flxGcaZuevZE7Uep/77MKvi0j5FBtvCUqiotLo23JnrVwZFIa8Pn16VxOYQF
X-Received: by 2002:a05:6512:a91:b0:5b1:5a31:8603 with SMTP id
 2adb3069b0e04-5b2c1b3fc9cmr1100584e87.55.1785136456906; Mon, 27 Jul 2026
 00:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
 <20260722154602.3373184-4-jamie.gibbons@microchip.com>
In-Reply-To: <20260722154602.3373184-4-jamie.gibbons@microchip.com>
Date: Mon, 27 Jul 2026 15:14:04 +0800
X-Gm-Features: AUfX_myBVWPcPTm0uJPfK0mPvA7vz3MrEKUtrrb1KSpNDKCBsArCt-n7Qw8klRQ
Message-ID: <CAC7DN2CW0VU3MBycsLzKoB0LztjC-DuVj1AbDYFFDPK4sMYxMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rng: add Microchip PolarFire SoC hardware RNG
 driver
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785136457; x=1785741257;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=22+4RgzSJRq09QiiSP4ZPCrE379bm2PuSSWotd8CsFg=;
 b=DqQpeHLIfLjz5sOXx0mAugEdlDwPg0vTbFcTC0CLRIWamLgekkOJBotGGShjYJQVMl
 e0HDsc7Fun4XLzKMsi3FyYmjKRm0ENBJOdQrvLjvIuc7+tn6vE0l/RMopa6SOH7yXXqx
 rAhLncB+JIvSlpj921+ZUxTw6nu5/P9VjGedTHFd46Gdxxam33vRkPWn4ymI+vklrbOu
 tDZ4/MPtiFvqd1vUxa6Io8uNd6JU6STxNgMCNfeq/nUPHLfH7wZNKMeuLw5FKq7r7HN6
 Pdvlo9oyyNipB8PhVVVS+/JpPkkq6i90DcQKe/e3rInPHsB2tImkJFo6NgBtE6cT5LEp
 hpGQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=DqQpeHLI
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jamie,

On Thu, Jul 23, 2026 at 8:52=E2=80=AFAM Jamie Gibbons
<jamie.gibbons@microchip.com> wrote:
>
> Add a U-Boot RNG driver for Microchip's PolarFire SoC (MPFS). The
> hardware RNG is accessed indirectly via the MPFS system controller using
> the mailbox interface.
>
> The driver implements the UCLASS_RNG interface, requesting random data
> from the system controller and returning it to the caller.
>
> This allows use of the PolarFire SoC hardware RNG via the
> standard 'rng' command and DM RNG API.
>
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  drivers/rng/Kconfig    |   7 +++
>  drivers/rng/Makefile   |   1 +
>  drivers/rng/mpfs_rng.c | 101 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 drivers/rng/mpfs_rng.c
>
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 19b2b707677..856ffda2f5e 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -23,6 +23,13 @@ config RNG_MESON
>           Enable support for hardware random number generator
>           of Amlogic Meson SoCs.
>
> +config RNG_MPFS
> +       tristate "Microchip PolarFire SoC Random Number Generator support=
"

Is there a special reason to use 'tristate' instead of 'bool'?
If not, I could convert it to 'bool' when merging the patch,
so you don't have to respin the patchset.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo

> +       depends on DM_RNG && MPFS_SYSCONTROLLER
> +       help
> +         Enable support for hardware random number generator
> +         of Microchip's PolarFire SoCs.
> +
