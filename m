Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26430C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 17:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512458043C;
	Mon, 10 Feb 2025 18:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UwLf8Dvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EDB80548; Mon, 10 Feb 2025 18:45:49 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB4B80079
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 18:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso9102009a12.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 09:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739209547; x=1739814347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X6OUrceIlApw0xY8GQF+3pbS0eSboCUarSM8uSPGEzU=;
 b=UwLf8DvfNO9WigO0ckOTu0EyF6qowR9pGKLxVdJJOwhHRBK1zF3uFGq6ZInsTxLvY4
 LYDTpeZY3Id4AMqv6DGdH6y8+SHbcD2kuSOpBuSCJ699jgeL2FpXSjQTCXe/5VDrQnkl
 rU2Vpont152mOY5SqCdJlz3whBsoaziKIKhnqEgpIdkxH1o64ve5vd5moBr6vgpskvCv
 RbumWC4IhX7rk11dDnmdZ9mFGsCPHaYa/i9jM2Z+FdBQxI7xwj8BoMDNjBCFDu8HnPsN
 rlbTtrkuR9GrwgmnJq39Rb+JwbBAGvBFHsvYj37lad8ct4GFD7LkaS2YK4qeFC0o0+UZ
 McKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739209547; x=1739814347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X6OUrceIlApw0xY8GQF+3pbS0eSboCUarSM8uSPGEzU=;
 b=Tm3+KxKb0To/U8wyzK+eyb+qUid5hCaKL/TtTkGuGE0RVROyjC69DIP8X4UaTHTN3U
 Nny4A6ASNDUP9XuR43EW3rysVJInz5WZOpPzlC6q4m94hl6DpTVPBB4ukbQS72qvma4+
 Me0dwljnup4B3xSZVZGbBWafQunFV4Bd6xUAfCdz969eSmPCAYSPC3bolxBOR19o8rDz
 bLBIvP2mnxH/FnnK5gHi4vYonlA1LEsLH+3787LT0caTP4jKtaGjFvxBVmKLDs61m8j7
 Px5gYmlmyfvO+dRcvLZaZK3wAvxLW6sB8sBgYfTu2fJV2oLXJ8zuulTNf4XbtixVsBJV
 blgw==
X-Gm-Message-State: AOJu0YxPBctrTr1WcvU4FS+K24SUtGtUMwKY4arSjtQkWvEVy9rVzudk
 9YMN0n6ue+mWMrZGXT8pdd7nwuRmcACpOFVyhleAFzWuUT3yLEEsc/0Vbc8TMI7cuCktlUU55Qq
 qdzoyoQc3hN2esDfQQj36vyTk+qM=
X-Gm-Gg: ASbGncvWipYWFztIObk+JjYvPTJTE5v0c7HxH7M2pWGAUZF26fcMYIBa/itHEOO/v3z
 y/l97YB28QjDpQPWdwzCVPJ2DCmNMCONlfR6Ie2R5ZGQcdCrIxW4Sa3OQCW1v5Etzr8E5AKMbuz
 s=
X-Google-Smtp-Source: AGHT+IEwdt/g2k+FpvyHNhBGl6WWggBPE6i4snL2tecBZ2m+2uB96LDu5arBHeYPKc7O9KdauGelbfyZnDNPTzkprNY=
X-Received: by 2002:a05:6402:3581:b0:5d9:f9b8:e7fb with SMTP id
 4fb4d7f45d1cf-5de45107515mr13916340a12.22.1739209546710; Mon, 10 Feb 2025
 09:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 10 Feb 2025 17:45:35 +0000
X-Gm-Features: AWEUYZn_E3Uqm1WEdL6QtW7K6FKyGESJe1g7e-UNrtEqhqeNp8lDfLA5UCZNLSY
Message-ID: <CALeDE9OwSs9acLKUa2LAoHYq+dbhzkj1usNq0p0h2BZ3W-mreg@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] net: ravb: Drop empty init callback
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu <JJLIU0@nuvoton.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Marek,

In the future if you're doing a large series like this please do a cover
letter outlining what the series is trying to achieve.

Peter

On Sun, 9 Feb 2025 at 12:04, Marek Vasut <marek.vasut+renesas@mailbox.org>
wrote:

> The init function does nothing, the bb_miiphy_init() already checks
> whether the .init callback is assigned, and if not, skips calling it.
> Remove the empty init function. The entire init callback will be
> removed in follow up patches.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Jim Liu <JJLIU0@nuvoton.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Drop the = NULL assignment early in here.
> ---
>  drivers/net/ravb.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 7286ad19598..5df557da7da 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
>         return 0;
>  }
>
> -static int ravb_bb_init(struct bb_miiphy_bus *bus)
> -{
> -       return 0;
> -}
> -
>  static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
>  {
>         struct ravb_priv *eth = bus->priv;
> @@ -626,7 +621,6 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
>  struct bb_miiphy_bus bb_miiphy_buses[] = {
>         {
>                 .name           = "ravb",
> -               .init           = ravb_bb_init,
>                 .mdio_active    = ravb_bb_mdio_active,
>                 .mdio_tristate  = ravb_bb_mdio_tristate,
>                 .set_mdio       = ravb_bb_set_mdio,
> --
> 2.47.2
>
>
