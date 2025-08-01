Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA13C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 17:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3498283ABE;
	Fri,  1 Aug 2025 19:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+c38XjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780F083AD1; Fri,  1 Aug 2025 19:49:43 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E6483AAD
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 19:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3323d8e0ac4so16879221fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754070580; x=1754675380; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym6sghZJARvJYdd3BUg9ZmR6Uh7L+6M7GBYY1BeuUXg=;
 b=I+c38XjIq7He8/ac7povCXmVHZTOOmuhJxBOBQPi+uciTNnn7rDGm9VSOayKQruLP/
 wIxu1ldxg/v42ZE74NwiQryarasXmXiMJE15O3FKEeFDh3dvqw/IjfqYTKY1ZmVeD6SS
 I/hRoAy1QGlLQmOG21KvDGsFIquMRfylLti/gj+ZkgHSMVjFK3aBZOABSVH5qbu6HfyZ
 yM0/NG0eouFNDC8Qz97sZ7GdCwlTetKJD6VooytkQl1h8Ey4a3ghnykQD2epqGpcpd0K
 a54q/Bm46ipIymsGN1t74FmJm5aCzobfH5TRSMTOYCOsDEEFKANAGO1aqsYTPT4i/SR/
 p5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070580; x=1754675380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ym6sghZJARvJYdd3BUg9ZmR6Uh7L+6M7GBYY1BeuUXg=;
 b=M9NyjzUEpKDIz5P94WD0hMZLWMpLbH/B7PRPeZ0T4cyhK9KvSxtGpN9M+O5xQ/MKWD
 b5d5RPim9QqhB5q8GJ6O6gXROGsdv/lxOUcEnapl4xaG4yD3ub2WPdiMs5afRrmWpQnS
 i3WWNdcs2nuWayYtIX0HTt/w9AJ4rD0Ad17V4/mNmckS8L+w3nXUH38qnWm8f4sLzViq
 ehjdXZK8mQcMrhA6DZ3AcDQgFVojyjuYvI4O6iOAbli6xiyXeyZxtMhnsVdtjlPMi7AS
 riDmkGN5uaPN34EygS6hssjHnR7IBALTmoTVly+9bscwwAXrNX9FEwOy5qOC+OhHZzfC
 x2Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP+HLtylJtHfbdUZ3OL7xvd0OWMnBVjCgx5u1UZE/HEMMPIDc0YUHRX47toH7KGYyy4C6QaX8=@lists.denx.de
X-Gm-Message-State: AOJu0YwYWEsnj8eH91+nmAOSABMsopOy9WAJze8W2yGvqfT9xa2o93zz
 u8zu2f6J4Tq5DfjgYordmmW5jQgvMaEF2eQ6Dik5/I4uUbM9e/cWBNTLWrTAPlotwKis4sKD13h
 6wP6JCVQZqOrih4kw8j37OfJOPu9vEcI=
X-Gm-Gg: ASbGncu8f6svwaEd3XWLqCT49kVYTiWWrxuIGudxbdqj/NwCvuulefD0GGticpghn6u
 g1BQjncco1Sxz7JjoVkxiuHYXxoE0sQy89ONwyYqJjCu0q4uDdQIK15JPjI/286qJeeKdPEzQzD
 VFN3qRBDtG+RO+gufrvfM+bXYzqqJrAnYbGtWKmW/mXOlaWUHre66qD5AyeC2WK4xz8BSXIbK7j
 J+MW94UgcSgoHT3zLYV4IIjo8Fk1TqYtnmoJ6E=
X-Google-Smtp-Source: AGHT+IHYIf1K8XolS9w8qc8q7V04//DxBmYpb8gg8H+kkbIN7bSeyfBDyPLIbQAicI8/QtoUmDAjtUHn8q/KzxHU3tg=
X-Received: by 2002:a05:651c:31db:b0:32a:7826:4d42 with SMTP id
 38308e7fff4ca-332567e7391mr773921fa.31.1754070580107; Fri, 01 Aug 2025
 10:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250722204709.2075421-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250722204709.2075421-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Aug 2025 14:49:28 -0300
X-Gm-Features: Ac12FXx4uOoDzGPSTGs7t2VQnGGRFbkEC4e0XSIFBYSfjFbxZFY6vHZbvKlT24Y
Message-ID: <CAOMZO5A1q1vhDV7rR1i-qu7A8n7bcL9pXgCMdzGNnO6BY=dggw@mail.gmail.com>
Subject: Re: [PATCH] imx95_evk: Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: tharvey@gateworks.com, sbabic@nabladev.com, uboot-imx@nxp.com, 
 trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, alice.guo@nxp.com, 
 sumit.garg@oss.qualcomm.com, marek.vasut+renesas@mailbox.org, 
 aford173@gmail.com, sjg@chromium.org, Zhiqiang.Hou@nxp.com, 
 u-boot@lists.denx.de
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

Hi Alice,

On Fri, Aug 1, 2025 at 6:52=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:

> +config IMX95_A0
> +       bool "Choice i.MX95 A0"

"Support for i.MX95 A0 silicon version"

> diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x1=
9_evk_defconfig
> new file mode 100644
> index 00000000000..e3b17152b50
> --- /dev/null
> +++ b/configs/imx95_a0_19x19_evk_defconfig

Instead of duplicating the defconfigs, please create a common
defconfig that can be shared between imx95_a0_19x19_evk_defconfig and
imx95_19x19_evk_defconfig.

Then include this common defconfig. This helps reduce the maintainance effo=
rts.

Check this idea in commit b2a39e4cb893 ("arm64: imx: Deduplicate DH
i.MX8MP DHSOM defconfigs")

> +i.MX95 A0:

i.MX95 A0 silicon version

> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3=
.0-17945fc.bin
> +   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
> +   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctr=
ee)
> +
> +i.MX95 B0:

i.MX95 B0 silicon version

> +
>  .. code-block:: bash
>
>     $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0=
.2-89161a8.bin
> @@ -53,12 +63,24 @@ branch: master
>     $ export TOOLS=3D$PWD
>     $ git clone -b master https://github.com/nxp-imx/imx-oei.git
>     $ cd imx-oei
> -   $ make board=3Dmx95lp5 oei=3Dddr DEBUG=3D1
> +
> +i.MX95 A0:

i.MX95 A0 silicon version

> +i.MX95 B0:

i.MX95 B0 silicon version


>  Build the Bootloader Image
>  --------------------------
>
> +i.MX95 A0:

i.MX95 A0 silicon version

> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ make imx95_a_19x19_evk_defconfig

There is a typo here (should be a0 instead of a).
