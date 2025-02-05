Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5270C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440EA801BE;
	Wed,  5 Feb 2025 17:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="kH4sq8z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3794480762; Wed,  5 Feb 2025 17:13:08 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A18E80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so6152761276.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1738771984; x=1739376784;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LEqYOw0X3Mtsluuj3AvUiS7zAqAaZmUhj5O+9R1dRk=;
 b=kH4sq8z2hqgzZJ1NnNJrmwkIBMGp64d825Q1GAEFCAKxx+Nvg6l/GLfb64WikxX6DS
 XO7IlzrSDViD3Gvs3PjktoICUhVTBvT30R/CEYsbRZWV2YdCqFc4CH1+vfrjz5R1UGln
 MBJDOhbx3g+HBydsUzWFEIwhgcq/zaWWdp7gyayAYl+1xjxyRkqn5EZ1TMFU5JtyzNnh
 d0oh3DJi6X2dWugXvr/BkKX/Pra8kr4/19IM7vhmEHDUst3mPzeCMFJlOKrbqxlYtesi
 jtkHuX9qF6tR4+z9ONQvusu0dzJnlv2WC+L1QRE89GuvMdtcA68+vkk0gIkJm56xHBXl
 sV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738771984; x=1739376784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LEqYOw0X3Mtsluuj3AvUiS7zAqAaZmUhj5O+9R1dRk=;
 b=Itbzj7dNPKxZflqVR+mmW1AeqkTe5Qd4UxOomzbY+yBZ0Mvp8jHUg6TpqgKJLY6/BB
 rBix/OeH/+S5UMZv3J12/NYFgaBObYLk7ZtK+k5KZeVlbVTBkNrI78DAsgDHFUKl0o/F
 dElzJTjnzETIH8SPZ8y6fR9zAhHZneLIGEiMLmxj1mXaI5ZOTQWyaXo5OecYwGuLcclz
 4mLe/+6IFw5Y4hLZoMBExFPalTZzad5/+lGjIXpdwN9AC52FDdm/WwIqb1aDDUgwUpNE
 a9+uMwSeOHCpKVFslqghr3PbHA882jGamZIRGiGaDiduA25oPlH3vFwI20SOLugO6Z5L
 BwOg==
X-Gm-Message-State: AOJu0Yxr9anCH0l+NtVghwn3cL149OPXuPC0I09Xzb2xG51RS2rrmIpK
 TVWxZrynSfDDx5T0fdW4oBRASHkl94O0jDJFbzikhiuB0IhhcN1XoZ5B1c6MtR62PObDyE5N5Ei
 OPczp1t3qNZmFrSP25GYUQ1PsYNgdpNVW39hf
X-Gm-Gg: ASbGncslMQ5lgRKgILbQpuYju88GTBDRxWw8UoLbnK7E+N2bs6UnIEBy3YovnhFGJJb
 QNOvObp+7ecEEi6LDiBDKrKejUifDRCgxqXVp/eHIc0nr2ifn3B6g3pvBeRsYSaWEqLoqNpMXeQ
 ==
X-Google-Smtp-Source: AGHT+IEFY5PKbEds8A6BAOMTCf/Pa3KqBWDptJwYNplwBZ++L5mGNrvpAuL2h2LVU9PqtwZ599pyH1vFBD5dZPoZWXo=
X-Received: by 2002:a05:690c:4c09:b0:6ef:77e3:efe3 with SMTP id
 00721157ae682-6f989e365afmr35340107b3.13.1738771984217; Wed, 05 Feb 2025
 08:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
In-Reply-To: <20250205015606.2686149-29-sjg@chromium.org>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 5 Feb 2025 17:12:51 +0100
X-Gm-Features: AWEUYZloAdWu6P34XEekjFpdM6yi27r4iS-6roEPIG_7ZhcmFuMOC-yP24ten9U
Message-ID: <CAHTX3dJA-FkzC3ejeW4edWqRDNsU_2rJFpk2hPHiCD2bEbB0Og@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi,

st 5. 2. 2025 v 3:00 odes=C3=ADlatel Simon Glass <sjg@chromium.org> napsal:
>
> The logic of this has become too confusing.
>
> The primary issue with the patch is that U-Boot needs to set up a
> bloblist in the first phase where BLOBLIST is enabled. Subsequent
> phases can then use that bloblist.
>
> But the first phase of U-Boot cannot assume that one exists.
>
> Reverting this commit seems like a better starting point for getting
> things working for all use-cases.
>
> This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
>
> https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn7QZ5=
hKU8Wjo8igw@mail.gmail.com/
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  common/bloblist.c  | 64 ++++++++++++++--------------------------------
>  include/bloblist.h | 10 --------
>  2 files changed, 19 insertions(+), 55 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index e8acfc74331..7eda94ecdf9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
>         return 0;
>  }
>
> -/*
> - * Weak default function for getting bloblist from boot args.
> - */
> -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> -                                 ulong __always_unused size)
> -{
> -       return -ENOENT;
> -}
> -
>  int bloblist_init(void)
>  {
>         bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret =3D -ENOENT;
> -       ulong addr =3D 0, size;
> -       /*
> -        * If U-Boot is not in the first phase, an existing bloblist must=
 be
> -        * at a fixed address.
> -        */
> -       bool from_addr =3D fixed && !xpl_is_first_phase();
> -       /*
> -        * If U-Boot is in the first phase that an arch custom routine sh=
ould
> -        * install the bloblist passed from previous loader to this fixed
> +       ulong addr, size;
> +       bool expected;
> +
> +       /**
> +        * We don't expect to find an existing bloblist in the first phas=
e of
> +        * U-Boot that runs. Also we have no way to receive the address o=
f an
> +        * allocated bloblist from a previous stage, so it must be at a f=
ixed
>          * address.
>          */
> -       bool from_boot_arg =3D fixed && xpl_is_first_phase();
> -
> +       expected =3D fixed && !xpl_is_first_phase();
>         if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_B=
LOBLIST))
> -               from_addr =3D false;
> +               expected =3D false;
>         if (fixed)
>                 addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>                                       CONFIG_BLOBLIST_ADDR);
>         size =3D CONFIG_BLOBLIST_SIZE;
> -
> -       if (from_boot_arg)
> -               ret =3D xferlist_from_boot_arg(addr, size);
> -       else if (from_addr)
> +       if (expected) {
>                 ret =3D bloblist_check(addr, size);
> -
> -       if (ret)
> -               log_warning("Bloblist at %lx not found (err=3D%d)\n",
> -                           addr, ret);
> -       else
> -               /* Get the real size */
> -               size =3D gd->bloblist->total_size;
> -
> +               if (ret) {
> +                       log_warning("Expected bloblist at %lx not found (=
err=3D%d)\n",
> +                                   addr, ret);
> +               } else {
> +                       /* Get the real size, if it is not what we expect=
ed */
> +                       size =3D gd->bloblist->total_size;
> +               }
> +       }
>         if (ret) {
> -               /*
> -                * If we don't have a bloblist from a fixed address, or t=
he one
> -                * in the fixed address is not valid. we must allocate th=
e
> -                * memory for it now.
> -                */
>                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
>                         void *ptr =3D memalign(BLOBLIST_ALIGN, size);
>
> @@ -545,8 +525,7 @@ int bloblist_init(void)
>                                 return log_msg_ret("alloc", -ENOMEM);
>                         addr =3D map_to_sysmem(ptr);
>                 } else if (!fixed) {
> -                       return log_msg_ret("BLOBLIST_FIXED is not enabled=
",
> -                                          ret);
> +                       return log_msg_ret("!fixed", ret);
>                 }
>                 log_debug("Creating new bloblist size %lx at %lx\n", size=
,
>                           addr);
> @@ -559,11 +538,6 @@ int bloblist_init(void)
>                 return log_msg_ret("ini", ret);
>         gd->flags |=3D GD_FLG_BLOBLIST_READY;
>
> -#ifdef DEBUG
> -       bloblist_show_stats();
> -       bloblist_show_list();
> -#endif
> -
>         return 0;
>  }
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 1e1ca34aa92..5063ab66e4a 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
>   */
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
>
> -/**
> - * xferlist_from_boot_arg() - Get bloblist from the boot args and reloca=
te it
> - *                           to the specified address.
> - *
> - * @addr: Address for the bloblist
> - * @size: Size of space reserved for the bloblist
> - * Return: 0 if OK, else on error
> - */
> -int xferlist_from_boot_arg(ulong addr, ulong size);
> -
>  #endif /* __BLOBLIST_H */
> --
> 2.43.0
>

First of all if this should be reverted you should also remove
arch/arm/lib/xferlist.c.

But we plan to use this feature and TL list will be passed via
register as is defined in firmware handoff spec.
In our configuration we won't be using any of TPL/VPL/SPL and A cores
will start with TF-A at bl31 which gets
TL list from the coprocessor. And TF-A should be passing TL list to
TEE (optional) and to U-Boot.
If only hard coded address is supported we would have to recompile
u-boot based on location where TL should
be which is an unwanted limitation.
If current implementation is not correct it should be fixed but revert
seems to me too early without saying
what should change.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
