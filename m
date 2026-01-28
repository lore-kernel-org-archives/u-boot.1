Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD47D340BD
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4AA83EC9;
	Wed, 28 Jan 2026 15:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="W43UcA6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2877183D0F; Wed, 28 Jan 2026 13:08:42 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECAA83C39
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3831ad8ae4eso59378451fa.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 04:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769602117; cv=none;
 d=google.com; s=arc-20240605;
 b=bxq+NH4MziAj/ltGrgHV/+8jCseObred9kbTCI1mLa5JHj1fFwI+4l/J69agwYOLkG
 wyA+RY6x8AJyp5wIliwP7NsdyXuuYQ5GD76QkedzdcjE7Mg5NFAS1hin5QwpZXnBXhRe
 s1mH7BliAC46+R1aVGeGOg2YslQmvlw2ce3c/tulQVwytCjR75QNjSefbYGB6veRerXQ
 qrtIHrsQ3nr8djfhzzf3ZFzvbMZKMi9u3F0Zlx/Y9LXW7k+cpIOS9/qaAjzPXj+RXQs5
 7lmhCB7DvzhGYIE9nP5ilr5OI53BYMRGRUYIupieH18bEVIfN0ugXx1VEbSqEjjotCAy
 ZJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0NYcMotSpZ2Ldfz7x2QZFod1kxVmcKgdaOz9MKnPjxk=;
 fh=m+dtN6TUifFvJayOKgarS1jFh3gWqlunOAdIPbgfjVM=;
 b=byRFe/JnzWVdV86CAG6My8UJ4JWKz/2cu9+crUdwFDi0ooj8EvDxT6+CGLbPr1DDwy
 40PUxbsuyJ9wtDbRwbycMe9IIAnkDdz+IxMVyn8RNmGug7rX3qvakbxU1Z6GOhPsZJvl
 Vz1WZfIbj5ok1/fNqW4fI2ZJ5zOON75W/+SPD8FAtE7GY9Ssylfoq0cTVAeQBSSeGzQ2
 3OvvjGzaqpH0eAdZ1FxufCw6XXeldfI5dmv1OvLAMGm22J7DGG+1o1nVhE5Gi9JLs7vz
 6reJ0O7mq7ScMjLSID/I1lFr+7JyKPhP32EZ3FUG1xXROaungga0A0we4W/7sjGwPO2r
 sYkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769602117; x=1770206917; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NYcMotSpZ2Ldfz7x2QZFod1kxVmcKgdaOz9MKnPjxk=;
 b=W43UcA6X6beKMFHJeMgy/+1ytKUUc3z7j2Xz7ZDIIPevWgwl1swhW5v9OcaJ2sgsWN
 JJ/+Ou+JXzK3CUHA236kLMCydrpQUfRy1I5JJngZsMa5WvoLG1oeBQKx/eAkVZdOEnLU
 /QOyUpWSsWuM7s08qPWsb+NrcJyJvqwI5mlH6l2wd/Q2I1KXTHQEzJz1ec6wUZuZds0w
 A6EuMEDOxg0H7QebB2kImRht1/HPNX4345NSkNrSck8bThYWfaDc8M3tdefZQc0H1SUS
 YlW0fvEKper7TvQdaTpsw8qMfQqHxvvv05iXcLKv4sfG0gYjHyz4O17pViPPed80EoY1
 RI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769602117; x=1770206917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NYcMotSpZ2Ldfz7x2QZFod1kxVmcKgdaOz9MKnPjxk=;
 b=lANKQb/6YkjMHN43RHFkQrnJqpTSmmTh4jwei8zLcXFxqCnQ08cSQwu0CeAY9B/Ecy
 o/bC3kpGsVIMZAut4cqv1iQmFIWwpa9LgGcp+lK/p63c+qKeurtgtqZozVboHyzGBWlw
 FtmNL6RMSl0Y0Fm2Fx1SbVMRgg47YXGcGBqu+b+ROwRBxfMAVjClaW7jc+yp0oAS3hEG
 v+y1HUTqUIKEuct4j61ISMYHdLYaWXRNK9IFK25CvAn8QIqJyhY31tfRll4G14EWJsyb
 1oCwbrTWTF5qoAqC4vU0Eb9Ah3Xkj+oPb7RRE1t9w+EBLWCqpTnEL3rw966383QuUvtU
 EZ8w==
X-Gm-Message-State: AOJu0YxfvqHNKauG2zolWABinUPziXKzUm9e0MTjnMTnGJjhgvRf6JN9
 auaMYBMkNgylDea0UsXII6lIh34YZlVD4uxEbPrDOTpPw07nwBlfug5xo6JnpxnsWIbFREs4dfG
 g8lNBDnf3xPDIWJoPp8Yd+nyPIt0RfCeATPBOuC3P1hfzpHuUkCLpy6c=
X-Gm-Gg: AZuq6aLd/7aPPxEQ6w1WEvg8tDIdcUnXNv3fXwflDQ40UrUJju33Yf1tCa57j0krCci
 EiRtwNN1xaGDYnXAbe2YIGTj2YcXPPSbbYzxGs+hAWu3YleTrF3xQeFSdycnNFuD6giNAfh3Sqs
 6pDo3qVArLRj4KkyDShb4yhQ9QrIsb4Yut6pzqjxO1EdGoECrEj4KksC2NWU4earVzj+eA6DF5I
 hYeM6EIfj0ilS5Wvm6x89L46Ji4Ttql6NBEkP2mbc7BB6qCl9vcF+pz8YfSlAqMhMLH8+n07Vra
 7nyNRoVr
X-Received: by 2002:a05:651c:4cb:b0:37f:8332:6ae0 with SMTP id
 38308e7fff4ca-3861c93f352mr22727911fa.33.1769602117385; Wed, 28 Jan 2026
 04:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20260119055523.13460-1-jimmy.ho@sifive.com>
In-Reply-To: <20260119055523.13460-1-jimmy.ho@sifive.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Wed, 28 Jan 2026 20:08:24 +0800
X-Gm-Features: AZwV_QjG45WkBXxttAgh4A6sFGB9wRSqodxIhOzRQ03EPedAyl0-E9qIVEp8zA4
Message-ID: <CAJh9TS+u5VYevuZ8cbUmBNk9NjpykMn7OD8ipJyPmzpgygV7Og@mail.gmail.com>
Subject: Re: [PATCH] driver: cache: Remove SiFive PL2 driver
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, nick.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Jan 2026 15:01:19 +0100
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

just a friendly ping to see if you've had a chance to look at this.

Best regards, jimmy ho

On Mon, Jan 19, 2026 at 1:55=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> From: Nick Hu <nick.hu@sifive.com>
>
> Under single core boot platform, the secondary cores won't enter the
> u-boot spl. Therefore we move the pl2 driver from u-boot to the Opensbi.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> ---
>  arch/riscv/lib/sifive_cache.c | 3 ---
>  drivers/cache/Kconfig         | 6 ------
>  drivers/cache/Makefile        | 1 -
>  3 files changed, 10 deletions(-)
>
> diff --git a/arch/riscv/lib/sifive_cache.c b/arch/riscv/lib/sifive_cache.=
c
> index d74544b93d8..9a0519af494 100644
> --- a/arch/riscv/lib/sifive_cache.c
> +++ b/arch/riscv/lib/sifive_cache.c
> @@ -41,8 +41,5 @@ static inline void probe_cache_device(struct driver *dr=
iver, struct udevice *dev
>
>  void enable_caches(void)
>  {
> -       struct udevice *dev =3D NULL;
> -
> -       probe_cache_device(DM_DRIVER_GET(sifive_pl2), dev);
>  }
>  #endif /* !CONFIG_XPL_BUILD */
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index 4f358657444..28446c479dc 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -45,11 +45,5 @@ config SIFIVE_CCACHE
>           This driver is for SiFive Composable L2/L3 cache. It enables ca=
che
>           ways of composable cache.
>
> -config SIFIVE_PL2
> -       bool "SiFive private L2 cache"
> -       select CACHE
> -       help
> -         This driver is for SiFive Private L2 cache. It configures regis=
ters
> -         to enable the clock gating feature.
>
>  endmenu
> diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
> index 2f683866b87..05ad7d8a33e 100644
> --- a/drivers/cache/Makefile
> +++ b/drivers/cache/Makefile
> @@ -5,4 +5,3 @@ obj-$(CONFIG_L2X0_CACHE) +=3D cache-l2x0.o
>  obj-$(CONFIG_NCORE_CACHE) +=3D cache-ncore.o
>  obj-$(CONFIG_ANDES_L2_CACHE) +=3D cache-andes-l2.o
>  obj-$(CONFIG_SIFIVE_CCACHE) +=3D cache-sifive-ccache.o
> -obj-$(CONFIG_SIFIVE_PL2) +=3D cache-sifive-pl2.o
> --
> 2.43.7
>
