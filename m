Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B0D10F43
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4754B8421F;
	Wed, 26 Nov 2025 14:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmVUNYXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BC98309A; Wed, 26 Nov 2025 09:49:06 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8097A82B20
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37d13ddaa6aso2870141fa.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764146943; x=1764751743; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=76mUxHBfC6++dnFYIxbh9eOWXfwXMyWH+zx4w684j+4=;
 b=VmVUNYXwVOyQ0Xf49KylFSv9WCI7tbfHCVAX+U9sV2YeomN7u5VQZGIGoSMTmYgsKb
 0dAL09AQlPhv8MFBuIv663dJ77L8MKY4T2W70RZ++RhJi/3r6UYMAkZAptbTbH9fymkQ
 qFCziyplKFHZyIeZKgNlQ9ZN4PFuzJMMQIKS2/VjteJexzAc64jLjhspSxUaQgFdHKzD
 Ek68/WSrPidqdrJRedbYe5ra9rRdctQQRmcKBt1GOyDmtCcwwzY7m+eqrfRrwfjJVk9N
 7Kcq7jg0az+ug2BB828bftR32ATlxC+yhPhl1KXPQLpqxOo0jOG0GR+ok/M9P87FAyQI
 EPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764146943; x=1764751743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76mUxHBfC6++dnFYIxbh9eOWXfwXMyWH+zx4w684j+4=;
 b=WptMFwOB7thNpCPa4sW1RP5lCq4neCzOpwR2EWrn1TvPNvqae/nP4TVqoKrNxsCYPb
 VJM3mdg8Hmp67fnJWjxb/vYW1RZaT9SsHWEwNz34S7obD4Ff5nZ3tps1LRnAblsJFLSy
 MaUeI5MBhSaMPv1LblhDJY4/rpZ5lbCU9LRjQrvvg1nOSZS7wZJ3qnoMHLJAPqoyexrd
 kzoU7uDIFZWY8HlwGuwh+D0Brm5dCir+QN1/TpLiS98La8zV9Oic8PKoF6xWqOvgeOU0
 F3hzStpi1E+EVMboo71r9prrxIaLFvrJNtCm9lqrFl8Do1hnMdRH0dPperlRKPLgPDVG
 OUPA==
X-Gm-Message-State: AOJu0YyEk0+Efy8+DJg4yS+RDTRIaRuaYhuq2zb1S7vd7Gz6b3RJGW4o
 vSxdiUL0X1jpYo77BngAeiZwV98UqssVy4L7+uNHQDAJp4Va6OPJqfOuiUT1c9UcKogPoc3oWdg
 nGBza8jrDpKp25oJdI6OxRqrfTgdEWj4=
X-Gm-Gg: ASbGncsSFugOJbnLCWb84J8pPi534jI7tdCPcMo84odapOSIYfgl7glJG0EjvL9yxvD
 goWn5khHYn/9kRJkThhxo3hX/CokDH/t2T4plsK5BfGEMUrXkzVluQJ+1vKLqmkwTHTw3XUDYqA
 kr74ho7tnW4twR/eRdAR8VYVpzAYAopbzugdDgpl5ApZolh0o8kUkRGuQksOVV5bJvkTmqPvWyz
 5XPfb7WbnAJhiIQFv//arOh2wu4n/pmpoNpWM79djeo21PJT/gtmi3OD9nyaVnVcyAV2fFsEV7n
 kA/XK4t4t9FvUx9onmdwOXl7i89Sb23eW4qBBGI=
X-Google-Smtp-Source: AGHT+IFXDPqFNNukfUR6XVFzQ2FVdZKdfLM6i1PqCGjRvJfS2+IPjoG1sTOwqUDnsoy8G+XdoET5f/8Y9FP1g0D6O4A=
X-Received: by 2002:a2e:7d13:0:b0:37b:be38:75ec with SMTP id
 38308e7fff4ca-37cd91cb59emr45136581fa.18.1764146942423; Wed, 26 Nov 2025
 00:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org>
In-Reply-To: <20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 17:48:50 +0900
X-Gm-Features: AWmQ_bmiYGhWjYCq5AbmVnlxyco0W2_RBBJ9HgQFsYd5n7nN35R6lA54zBikjag
Message-ID: <CALrBrZ036FUXkk-jM40Q7S9NADpxFu-HDkg7NwbwabUhW8kT-A@mail.gmail.com>
Subject: Re: [PATCH] soc: exynos-pmu: add support for Exynos7 PMU
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
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

Hi,


2025=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=ED=86=A0) 01:12, Kaustabh Chakrabor=
ty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Add the compatible string of Exynos7's PMU as defined in upstream
> dt-schema. This also supports derivative PMUs as defined in schema.
> There's no additional setup required here, so pmu_init is skipped.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c
> b/drivers/soc/samsung/exynos-pmu.c
> index
> 233ad4a908f5469e1ef210ddba6d7ec573fd4e15..0f533bcdae52adeafba4790e50bcf97=
ed34fc606
> 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -85,6 +85,9 @@ static int exynos_pmu_probe(struct udevice *dev)
>  }
>
>  static const struct udevice_id exynos_pmu_ids[] =3D {
> +       {
> +               .compatible =3D "samsung,exynos7-pmu",
> +       },
>         {
>                 .compatible =3D "samsung,exynos850-pmu",
>                 .data =3D (ulong)&exynos850_pmu_data
>
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-soc-pmu-exynos7-f0887231babc
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
>
