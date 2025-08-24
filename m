Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2C2CA0EEB
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 10:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E190828A2;
	Sun, 24 Aug 2025 12:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nA2TyStm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1BF83020; Sun, 24 Aug 2025 12:38:57 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDAC800C1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 12:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2460757107bso30444825ad.2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756031933; x=1756636733;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xG9fE1lwVf+4LP4t33FpIM+S8mwlJJT9y/NhXVzP3w=;
 b=nA2TyStmWkWUW2T+vRo8KRrj7mcrSBg6V2ZVHda7BYLo2uP5+ooHerlWhhPiozrdtf
 8JKPDmUDyHoWnUiZJAMcYq/UniYbKqshu7y46dHgdOjQYCX4nrdK1y8rwJXzbohPEV2N
 KbBtHkosvlwkkXR5+UhSEAyu2CrgRO+FAkRvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756031933; x=1756636733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4xG9fE1lwVf+4LP4t33FpIM+S8mwlJJT9y/NhXVzP3w=;
 b=qAWrhIEWcOc1khmp0qqAG8LGNn9MVPgdZ2ZbNIa0OQhhv3g0/r2fb4inigOrs0I4i7
 opXHc+613c6Lyyv1+8EEjpkVm38x72obs0RyJMTeVrGVU4qn+t21BpmOtKP9K3gLEhQw
 ga9QP/MmJnte+evXkqA+20+xGZqOAa/ftL7xG+YB+majncnPztpg18nzELNDoA5zWiAW
 J/NCskHQ0zxTFyLR/aPaItHyHhhx5LCoSrxRcYTYq0UWAhm2aYdM56TUc4VmmNGNgI51
 MAZlDzlFPAlrxcIkCgzu6aCx4e95/uko5pifpQ6VZrJc81ndehobAd++7u+EXZKgZBCJ
 hj/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFsc63afaYSIUOyHrYu1IDU5YsSJvp4QEaTLvxwgbPfRGlRuvyCn3MNffzKQLi55PVbe95IPg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq6SVMVlWAutDnX2xgbmME3Dpe3WgMKS3IgJOIkeAZ7dEreN0N
 YKvxtJhEvf2OfRgARZjqLWHCyI7iPqfxb0J5RBX1IKpObQ0W61N+8i5MybtnvU4nNC/dSl4zE0Q
 BRHkFcDWtklT5qZC/ycmgsE7DEdcvhFyr688ktvmBxQ==
X-Gm-Gg: ASbGncslP8G6w/ln9N5P5YSm6Xm1se4fNF9aKYnxjPBcZ2wgFNwu5+A5ytF0U/i+Sb0
 VCLx5FVE8BNi5JaqijhCrmNMkr7XXb0cALiwO2f00HZDJFsIpoGB0M3XHbNXGvo2jwKhT6+PyTG
 ywiELRDqsWeOoG/hfC1+Weoa9X4PJdkRiz7KrLLPX8kmubLp6cBUaQOE1a5mVzWdoBQN/hfTkda
 ZZ0vuQ=
X-Google-Smtp-Source: AGHT+IEY8qirDXi1j6bYoKu8uvMIi/XciUpWapFHYUMbHAbzfyBrvRDGJNN24ssyQrLIAe7ZbFXMVHXuwLtkMLMx5UE=
X-Received: by 2002:a17:903:8c6:b0:240:92f9:7b85 with SMTP id
 d9443c01a7336-2462eb19bc8mr113018975ad.0.1756031932871; Sun, 24 Aug 2025
 03:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250731-nand_core-v1-1-b4d16bc29169@linaro.org>
In-Reply-To: <20250731-nand_core-v1-1-b4d16bc29169@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 24 Aug 2025 12:38:41 +0200
X-Gm-Features: Ac12FXyJAELGHHxbYXGfhh_pehgg6ep1N6B08T0t5C-RO8T0z4ELN0R71pBc7NA
Message-ID: <CAOf5uw=J9BMGbfxWhE8=oYkR+LuNjct72+FsJ1TkpepNQ3mAJg@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: Do not dereference before NULL check
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Thu, Jul 31, 2025 at 6:21=E2=80=AFPM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In nanddev_init mtd and memorg are assigned values that dereference nand
> but this happens before a NULL check for nand. Move the assignments
> after the NULL check.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> index 472ad0bdefb..01ff6e3befa 100644
> --- a/drivers/mtd/nand/core.c
> +++ b/drivers/mtd/nand/core.c
> @@ -201,8 +201,8 @@ EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
>  int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
>                  struct module *owner)
>  {
> -       struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> -       struct nand_memory_organization *memorg =3D nanddev_get_memorg(na=
nd);
> +       struct mtd_info *mtd;
> +       struct nand_memory_organization *memorg;
>
>         if (!nand || !ops)
>                 return -EINVAL;
> @@ -210,6 +210,9 @@ int nanddev_init(struct nand_device *nand, const
> struct nand_ops *ops,
>         if (!ops->erase || !ops->markbad || !ops->isbad)
>                 return -EINVAL;
>
> +       mtd =3D nanddev_to_mtd(nand);
> +       memorg =3D nanddev_get_memorg(nand);
> +
>         if (!memorg->bits_per_cell || !memorg->pagesize ||
>             !memorg->pages_per_eraseblock || !memorg->eraseblocks_per_lun
> ||
>             !memorg->planes_per_lun || !memorg->luns_per_target ||
>
> ---
> base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
> change-id: 20250731-nand_core-399525609ec5
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>
>
Applied thanks
Michael

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
