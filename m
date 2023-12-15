Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3278AC46CA2
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 19:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B49C87A8C;
	Fri, 15 Dec 2023 20:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JqbOwgvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0391C87695; Fri, 15 Dec 2023 20:07:41 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9717E87C09
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 20:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28b18920659so98848a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702667257; x=1703272057; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp75lNQ43fZfW/exxNNUrw/R2bauqCmpG/PaWPVF83I=;
 b=JqbOwgvS6WGDK2p8dyCDpP+NfvBf+m0zkXOwGsulUOOB6h+cM6gZeTX9DXeUGe1iW2
 bZOolQRkTLDx1M8RBfEabB3Wsc/5KwUXDnOQQuUdWUDYduaZswuVKQWgydI5PfWBsQF6
 3AadehMnpUIZz3WuV5+TIO2gb13ny+pw+cJPxVL2slhBC8ISFgZuaie8wZJ4Ai29bzCL
 RWbvtnm2PB2tswkEQnZqj0ALlo8oB2oJK37n9udtporsvVQzKBMlJP2z19zF6e59bD7K
 fhx99PEs3DBqhm5aNspnrsVks2+ScADyEtiXWCbmIAKVhRkr2TEcv25WhHUI45EssP8/
 ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702667257; x=1703272057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tp75lNQ43fZfW/exxNNUrw/R2bauqCmpG/PaWPVF83I=;
 b=dO0GQE59Kq1bPnNzoPFDc57eFje7mLPk+qnS83GJVHJ4O7B0ABDJwE4tKvdcGvKZh5
 MIDVlhkNI6kV1T61hWxXz7RYxHvL5FNuUtJmKyaOGrx3tiYS+/UWGy/FggXlMJkRY+FX
 Qp8QMxveTSsZB9nXRvZ6YFVp/Cg51O/hDYktmSb2Ie1/+MK1yxDus0tc0rFYoXPPsd6Q
 j0Y6Su33MUHl4neavcVlXYU2S9Vrk5CdJ/GWX3DnXzrH8hww5NblyxyeLjMZS0pHwhUD
 g2i8owKl6kq42ZtVLs9MJXdhkVmLB2xv5SPgq5WXRVCgFqRooLqmHjJKfa7lneKdnWT9
 aDDg==
X-Gm-Message-State: AOJu0YzZ8DyMt2fg0ke514SA+8kWRJ0aEl4ygFd913xlgqrdOcbHCmcf
 Kv6ZEszvwVtKaOOWL5QWIuP+ubhnDMsPbHeO8S+1g90L3BU=
X-Google-Smtp-Source: AGHT+IFgFRNTJmLtMaKty20rGNJxUz8NoTpANl06SvLRKf0tD5zrqyw9ubELpyBWs/Av9LP+OCMcSe9gj052A95Go2c=
X-Received: by 2002:a17:90a:9e1:b0:28b:3288:d9b8 with SMTP id
 88-20020a17090a09e100b0028b3288d9b8mr2069759pjo.3.1702667256839; Fri, 15 Dec
 2023 11:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20230926065438.418051-1-akoch@initse.com>
In-Reply-To: <20230926065438.418051-1-akoch@initse.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 16:07:24 -0300
Message-ID: <CAOMZO5CvK+9REbnQn3nSD2XbyNS=kvveFeg1KuKOUcLq2TftRg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm_evk: Fix PMIC definition
To: Alexander Koch <akoch@initse.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>
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

Hi Alexander,

On Tue, Sep 26, 2023 at 3:55=E2=80=AFAM Alexander Koch <akoch@initse.com> w=
rote:
>
> Newer revisions of the i.MX8MM EVK are equipped with a different PMIC tha=
n
> the initial ones (PCA9540 instead of BD71847), which has already been
> reflected in 4c07a21e5.

This commit hash does not exist:

$ git show 4c07a21e5
fatal: ambiguous argument '4c07a21e5': unknown revision or path not in
the working tree.

> These changes have been reverted implicitly as part of the device tree
> re-sync with the Linux kernel done in 24a7a3c1c.
>
> This lead to an inconsistent state: while the device tree describes the o=
ld
> PMIC again the code in board/freescale/imx8mm_evk/spl.c tries to initiali=
ze
> the new PMIC:
>
>     ret =3D pmic_get("pca9450@25", &dev);
>     if (ret =3D=3D -ENODEV) {
>             puts("No pmic\n");
>             return 0;
>     }

Yes, I agree this is inconsistent and we need to fix it.

>
> This leads to the expected error message from SPL:

> -       pmic@4b {
> -               compatible =3D "rohm,bd71847";
> -               reg =3D <0x4b>;
> -               pinctrl-names =3D "default";
> +       pmic: pca9450@25 {
> +               reg =3D <0x25>;
> +               compatible =3D "nxp,pca9450a";

If we change like this, we will lose the change after a sync with the Linux=
 dts.

In Linux we have arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi that contain=
s:

pmic@4b {
compatible =3D "rohm,bd71847";

and arch/arm64/boot/dts/freescale/imx8mm-evkb.dts that contains:

&i2c1 {
/delete-node/ pmic@4b;

pmic@25 {
compatible =3D "nxp,pca9450a";

We need to have a new imx8mm-evkb_defconfig in U-Boot to deal with the
PCA9450 PMIC.
