Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A220EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773228647D;
	Tue, 22 Aug 2023 18:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YriIFj7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A69286477; Tue, 22 Aug 2023 18:22:41 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8326D864AB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2690803a368so848105a91.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692721357; x=1693326157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tks0nFm8+zaS9+o7iB7Zg2nJm9t7Oag+QFyMsrwcC9A=;
 b=YriIFj7zORCRqi4QpV6SGbhiKoqpSLwrWiiWZtbepf2isuNY+hTVElB0B5HAT+b3r7
 JHg6zcRiMyT0P2//FBYJwPOGIWnSBrhuyoHfGAo86LztGAXzmDl0jtWPuy7AApoLHQcm
 7+SpK1mXiFib99pz8AjnAkXOXLbfGiiIPqD38NQz5yipagEOR8g5zX4N347/xbXnySDI
 70nQHZN1AZ/6zgzz5XQrZ1Vfi3SZWK1ZZDb191B9SkO4U8E7XrrZHGwHcL2BGB+leYMA
 9o1sKUQDotdLYw5+NFc2ElBjuBy0pCtidl2hITtUM6Qgox0J1uzzbQhN/eFilEhXNqFL
 c/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721357; x=1693326157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tks0nFm8+zaS9+o7iB7Zg2nJm9t7Oag+QFyMsrwcC9A=;
 b=lkewsZsz/SwSrNfpf/nXzkcitbmCFkJm9ZA+86L95/IbeKvh+01lP4+O+YiSxRhRvH
 uSFihcJGt0DS6y6A86QS5/kOkqCT+iYz9ihES01VvEpZpbbVOpgsnrNx+VpCPptrps2M
 goe0wRS/+nsfJkkF7INY9NeQyvJeVb2E7GMDWBQHTN98GbG8Lovi+WhIBSuvaPp/MX/M
 F5O6soIXaAJ0MKOmHrJX9iftc5Q3UL14zy9h8hFDq+0zC4LD7RJlTWgRwT9Hfp9R+hen
 6PSbUDDyAHGjdDkhYgmrgefv9yglZXOxmyBcO0utrfUefyxTZOT6kS+holV1vckniWB+
 uWJQ==
X-Gm-Message-State: AOJu0YzlQEzBHvlHltfcIEnsaGuKnNI9rsLdfuh0ah5zrqTDrgyth6os
 AxwNSRbhVyOVL0QTKSr6rjwO62QjadN/qiJkCKM=
X-Google-Smtp-Source: AGHT+IGq2vX5MxqunAWYeeT83j/WnFgivESsWELJ+GGJkPvob4VZfSve6Mx9A/wwaE48W7nJtXbCwW87JwdXkwGYMOc=
X-Received: by 2002:a17:90a:13cb:b0:26d:4695:4040 with SMTP id
 s11-20020a17090a13cb00b0026d46954040mr9122078pjf.4.1692721356805; Tue, 22 Aug
 2023 09:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230822155312.53131-1-oleksandr.suvorov@foundries.io>
In-Reply-To: <20230822155312.53131-1-oleksandr.suvorov@foundries.io>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Aug 2023 13:22:24 -0300
Message-ID: <CAOMZO5BX1+_5FxjgSVna5i3A+uWANwjfqrtgftumpq5gGcEPbg@mail.gmail.com>
Subject: Re: [PATCH] spl: watchdog: introduce SPL_HW_WATCHDOG
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Oleksandr,

On Tue, Aug 22, 2023 at 12:53=E2=80=AFPM Oleksandr Suvorov
<oleksandr.suvorov@foundries.io> wrote:

>                 ddr-1d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_imem_202006.bin=
";
> +                       filename =3D "lpddr4_pmu_train_1d_imem.bin";
>                         type =3D "blob-ext";
>                         align-end =3D <4>;
>                 };
>
>                 ddr-1d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_dmem_202006.bin=
";
> +                       filename =3D "lpddr4_pmu_train_1d_dmem.bin";
>                         type =3D "blob-ext";
>                         align-end =3D <4>;
>                 };
>
>                 ddr-2d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_imem_202006.bin=
";
> +                       filename =3D "lpddr4_pmu_train_2d_imem.bin";

Unrelated changes?
