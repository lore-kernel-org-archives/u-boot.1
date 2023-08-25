Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD3C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68F086A9F;
	Fri, 25 Aug 2023 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tf6Qsh6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A738286AA5; Fri, 25 Aug 2023 16:49:06 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB0886A9C
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58d41109351so28511777b3.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692974942; x=1693579742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xK4YA7r3jDWn0SeoA5H4LvUEqLxNvDfAuI4oRArpXj4=;
 b=tf6Qsh6ZHfpUlz/xp23kyN+o7mIdsaLUPjvtsytzuI2qsW6IIjtohmtGWCoe8wKwoM
 tlUvcWu+RFeONI3CIBpo7tg4Ud6HChahLdDy+QMkD+OHeUoU+d4YeAt/hdG8XHPXtBkf
 qu8UNOqlupPO3MIL7Z6bChlw2B2XPGxg4LIak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692974942; x=1693579742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xK4YA7r3jDWn0SeoA5H4LvUEqLxNvDfAuI4oRArpXj4=;
 b=gxew+SED2Fwfb4PdNTIAknR+Okgu0Xad93O1mVLjKPXalhYVz9CVHtkhk9ux1zWD+9
 l+Yw7V48hL+YFKJX1yH7mC4K9SDAaEqvfAZpx5xtxJxT+3TmHELr08qAUuKliTzNUwr7
 iaMs0N9ky3X/0qUH5c9amPpl/apMEXjhUZZlH8qKEcJPAD4mYZBAj8ycVde/IrtUHsIZ
 prdTzrbavu4aYjwBPzZCSZYbIfw4JqcpwJrRQqRCOVam6XWtwcjdOhhELjDPbqLQ4Dg6
 h/DRIpoe47hUIFxlV15lHL9duf1XBHWvFA6rpPFDkhvMCNR5GNIbjugTnQMGXU/L/YDr
 xmjw==
X-Gm-Message-State: AOJu0YwTVwK+APPxPgFYTguLkkwU/WerYdSGfJp2dz5su48CMxeh49hY
 beQ+6NLO51MhoyPVXGA0esXAOQ==
X-Google-Smtp-Source: AGHT+IF2v8T54qlfoN46dT7oOqs6zz5OrjJ/fXQohpDi3Q89cXemPlo6f1Kgz5okTmjc44eKhF3+1Q==
X-Received: by 2002:a0d:e6d4:0:b0:56f:f0db:759a with SMTP id
 p203-20020a0de6d4000000b0056ff0db759amr18121512ywe.13.1692974942620; 
 Fri, 25 Aug 2023 07:49:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 k189-20020a816fc6000000b00565271801b6sm528529ywc.59.2023.08.25.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 07:49:02 -0700 (PDT)
Date: Fri, 25 Aug 2023 10:48:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH v2] Convert CFG_SYS_UBOOT_START to Kconfig
Message-ID: <20230825144859.GI3953269@bill-the-cat>
References: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D3SUbHLuEvxnWHwq"
Content-Disposition: inline
In-Reply-To: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--D3SUbHLuEvxnWHwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 09:59:48PM -0400, Jesse Taube wrote:

> Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
> renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> this meant that the value was no longer available to the Makefile. This
> caused imxrt to fail to boot. All the other boards that used this
> variable were unaffected because they were using the default value
> which is CONFIG_TEXT_BASE.
>=20
> This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
> value to CONFIG_TEXT_BASE.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
[snip]
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 5e2d4286ae..3883cae2ba 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -738,7 +738,24 @@ config TEXT_BASE
>  	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >=3D 64
>  	hex "Text Base"
>  	help
> -	  The address in memory that U-Boot will be running from, initially.
> +	  The address in memory that U-Boot will be copied and executed from in=
itially.
> +
> +config HAVE_SYS_UBOOT_START
> +	bool "Use custom U-Boot Start"
> +	depends on HAVE_TEXT_BASE
> +	help
> +	  By default, the address in memory that U-Boot will be copied from (TE=
XT_BASE) and the
> +	  entry point are the same. Select this to start the execution of U-Boo=
t from a different address.
> +	  This may be required if a header or vector table needs to be copied b=
ut not executed.
> +
> +config SYS_UBOOT_START
> +	hex
> +	depends on HAVE_TEXT_BASE
> +	default TEXT_BASE
> +	prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
> +	help
> +	  If TEXT_BASE differs from the start of execution, this sets the addre=
ss in memory that
> +	  U-Boot will start execution from initially.

A small point, these help texts should wrap at 80 columns.  If there's
no other feedback I'll just fix that up when applying unless you want
to.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--D3SUbHLuEvxnWHwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTov1sACgkQFHw5/5Y0
tyz9Xgv+LXbufDCyTPbuj+xP+HHTf/P9KoSsAPizCslZUwBF0hd7RiOadJC+4v5r
f+NOBpTqEwHZ5imZYGfnEoq809sgY9RpSn0WN7CrtyWq65l6Wfo1zMeHhnT/tCnA
/lbO4GjAFlTHNBJLTlMyCgNGRXZgF9rkVb6RG7lZEW6VD02Nm5NROn3yCXM0Lcad
e4bz/BBV47Mul+hUr/cNUsF/Nu81twxjLS6kQ2nSY7C/aoz8mpvact++/5O9OSk7
7+Vt6jz81dcGZ5JwISfmymRzBXVfhj+1t3s2LoTUbxpbTz423XpioHieAWd8LCAJ
4av0IlbMo89kIO+jV46bw18ATvW0GZrh7EOn3oj+rwsU1dhXXUNqV3c9hXJa0Wpd
aeut0PoFUys/d2LUqIE+5KVF6Sp6NRJh1k0tB2WdlQBZ+FPH0LKLbOT01UbhMIr7
lPMh8p0shGcAzXr1OtJ8A85rhg/z26gDEZJAAh3ljdphtj3k1OGm/qsPXzUwZzNK
/PA6ldVl
=Clhy
-----END PGP SIGNATURE-----

--D3SUbHLuEvxnWHwq--
