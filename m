Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D37F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9048419E;
	Sat, 11 Apr 2026 16:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iyra3Gku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66DC841A2; Sat, 11 Apr 2026 16:57:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B059B8419C
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c62fc8debso472191866b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919431; cv=none;
 d=google.com; s=arc-20240605;
 b=KfHXX7F8mIBn1Jif6jFm+5UnKG59KFEAeuQa25O8BdXp5M8Y5riHJJCXe2WaZUk2cl
 dZAOxpaf7SCQtSATwS79R0Yu0zoApEqX3Oc49Xo9iuaFrAOEkNU215mPBSCtyFxsTm+z
 LlTjIKRhLQ2tDbZZHtoeKoe2aNFdlCk4IiAx9qj4hQ3idj6em/iDenj14pLW4+4/p5kK
 lNF8qDyi8m48EbWmndVknobCe4zYgPrcbi8rMTmGu//BNpeZ0hXQGdnPZzoRqbnbLovJ
 4547PNYSOnUj+3ptU8nORejBR4zxMZPUUvsUxfvAZ+Kjvtv8Z30ChKNQkZGX4jo0CIYm
 3Wug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2yTxcu0vqVkq4t0aYNsq0rwov/lbEN+SHNZC9AMfSWU=;
 fh=1mukGU/SZ5ROZsZbRem9cL3HCU+61MKGHAeqvmJgawU=;
 b=MQaK5pqSprkKj69Pn3k5K35VqmcYENdwMgYD9v65MCLG4DSngfq1zaKoOS1XGR09Xa
 ngIvqHuMZuPNkDSOxvTtPmvyrYtsa1wQMBq3mqUtZjvjV0Gk+HcQAADq5XjZhn0iPYT5
 LC1V7MAc3ydI4Ov58XZqaARuwQ2ak56HzOtcKuUEevsCf7bpVwQC+GFBQUPyV+YZsy83
 Y0AK/UDU/0zfsD7nwSQgv9XbYw4l4fRxBQrt+/2ks7Wgjg5H+vspa82VqgcT576fpLAv
 3spxZm1wiAF7qaolVIGvSYbHQGTesMNGj3KvEBwi9/mVRhWYg0Qkd4e6xLKcAluZS2Lh
 KOuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919431; x=1776524231; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yTxcu0vqVkq4t0aYNsq0rwov/lbEN+SHNZC9AMfSWU=;
 b=Iyra3Gkuzpg5ud7Zp2S2nWGFNCiTqZz9Y3mtMw4WUd+qJzcq7Z8v9MOuwp1A8SpAK4
 zjHc6csbkI9Q6d8FXuPI8aU7oBmTyYjy+QA+0NXVuURGFcRCah3pc4yOWGlA4o0RqIyj
 cEEz4N2qRtm6DAgkAXgyHDH8o/lFYTIVa9ngw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919431; x=1776524231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2yTxcu0vqVkq4t0aYNsq0rwov/lbEN+SHNZC9AMfSWU=;
 b=HhbcX2rT+dtm1E+R3SIxT1674aNcJj4aRoMo2Il+m3xXtIj8EKe7NRjtV4FMwfOJ7l
 o1nEDjx1jlhhdA4UTOn/fHXr1Nm52gldiqEkgfOfGxh5vve5+yRBB3Wgrdzv1kL/Tq0T
 F3wkUO19p4xfogekajyqlfut6qcr2stH7fCxoOa1fcF20A0Xp7+4rjv0h5ZZ9rPCAABv
 SzjAK7UUEbn8/jXfEcCCNaE9hljF2x4ySf1jF/tqPGkQnGfUohB3mnKBLzUQcBk1rerj
 +5kg0UfU7a1WchUa98toLo6ORTZPSDgdNdfMO/qGWALAsTkknHhpYUg5nx5RKdjqDVt0
 wPug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcTDVrUSATTC0NFp7WeznWLiVdiuaeTAZNRoQ/UdylJYmJ+MpYysTpOwyuTD6OriGXbCDWR7c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9V6ReXeqrsF+NEr6/OQ4y9KGEeJCGQZBAwrLP21vpuYDej6tb
 xC8HZaHF1OWnPviGPyw5I8qCNtShz1h8ZX3hiVebdiSvLSoT0O3wGcNHdBiguUlszEZqr4ZgR9m
 E0PFwtOGXHS6nNvVtuL5WdgsFZGR3q0VksZPV9kLb
X-Gm-Gg: AeBDiesK6KxJq6VrerogPorFik8o/SDXAfu2/xJper7tbbo7avL4iYIXUpXClbnwdC+
 ypWXDzYhzjZ2t+CV6YP7sLTNNShlF1OEUSII5IcJvtkDqCFkyfwEPYpEGYMv58HY8fQ7z40cADk
 Bvqu+Mj1b2jnXVvoYqojkKRNqc9iQTvfiBbHKCskBQHr3nPxhvzB84yojtpSbMgTxzcfifRROvL
 T/6j+32Ks0771V55K0A6k4xRgXO+N+iQcNddzyNBGIWlDc6naWecyDVSpnIthSEg8vDtt4FMca6
 6oZY9w==
X-Received: by 2002:a17:907:c20:b0:b97:9636:5aac with SMTP id
 a640c23a62f3a-b9d727a057fmr386830766b.13.1775919431120; Sat, 11 Apr 2026
 07:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-3-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:56:54 -0600
X-Gm-Features: AQROBzC99YcOor7CpdzFCw1WvRag49RkCKXs8wtRR1YEsTZ392QSmSb8d4D_a64
Message-ID: <CAFLszTiJtK=ODNfy3nNBJDpJhe6xDvehvcDRvU1UTpc0rCMQgg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-09T13:32:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS loader and FW UCLASS
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader UCLASS and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
> While at it also drop some redundant check and rename some variables as w=
e
> are updating the code for the UCLASS rework.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/Kconfig                      |   5 +
>  drivers/misc/Makefile                     |   2 +-
>  drivers/misc/fs_loader.c                  | 328 ------------------------=
------
>  drivers/misc/fw_loader/Makefile           |   4 +
>  drivers/misc/fw_loader/fs_loader.c        | 186 +++++++++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c | 147 +++++++++++++
>  drivers/misc/fw_loader/internal.h         |  73 +++++++
>  include/dm/uclass-id.h                    |   2 +-
>  include/fs_loader.h                       |  47 +----
>  include/fw_loader.h                       |  19 ++
>  10 files changed, 438 insertions(+), 375 deletions(-)

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_=
loader/fw_loader-uclass.c
> new file mode 100644
> @@ -0,0 +1,147 @@
> +UCLASS_DRIVER(fw_loader) =3D {
> +     .id             =3D UCLASS_FIRMWARE_LOADER,
> +     .name           =3D "fw_loader",
> +     .pre_probe      =3D fw_loader_pre_probe,
> +     .per_device_plat_auto =3D sizeof(struct device_plat),
> +     .per_device_auto =3D sizeof(struct firmware),
> +};

The uclass uses per_device_auto but the code uses
dev_get_uclass_priv() to access it. Please can you use priv_auto in
the driver, or per_device_auto with dev_get_uclass_auto() in the code.
I suspect you meant the latter.

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_=
loader/fw_loader-uclass.c
> @@ -0,0 +1,147 @@
> +static int fw_loader_pre_probe(struct udevice *dev)
> +{
> +     struct device_plat *plat =3D dev_get_uclass_plat(dev);
> +     ofnode fw_loader_node;
> +     int ret;
> +
> +     if (!IS_ENABLED(CONFIG_DM))
> +             return 0;

The IS_ENABLED(CONFIG_DM) check is not needed since this code is
inside a uclass =E2=80=94 driver model must be enabled for this to compile =
or
run.

Regards,
Simon
