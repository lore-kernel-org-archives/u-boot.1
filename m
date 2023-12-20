Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3028C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E688750C;
	Wed, 20 Dec 2023 11:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2PLqWpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FD0876DB; Wed, 20 Dec 2023 11:49:07 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFD28701C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d3d3f0afc4so5599675ad.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703069344; x=1703674144; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0Sjgk7uJm06wiMKETGer54EWLvqrE7/UWJ3T4wIPzE=;
 b=D2PLqWpeFzdAJzUlFEswhpN9LpzyMx5Wds8nToy6XCSlU5NpRrXfufPJLDXMAuLu7m
 7eRLoaEbiNSmHx4V3CmUIexsItLek7r0BRCyjBNjBuUM8nTZuEyY4ogPp3Z6Iad0qDpW
 AqTSEwhDJFkwv1M3PgF7ciSouDfRmYjlmo6QDNdG7YmbSPkO7dXyFVxL9hRnlHJsOJ89
 BcCh0XOZdmHqO3B5vauLyt+YkPawXRssGHyqyNA+23Vsa19HEgBUOJFsbv7IbKuPGNHW
 hYpNfH9n2fRCe8LAsDueWnleE40UOuVPk4bZviv/C8Egyzz5mlisNTIyPeqHFxPZpvri
 47Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703069344; x=1703674144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0Sjgk7uJm06wiMKETGer54EWLvqrE7/UWJ3T4wIPzE=;
 b=RMftyWVjqB44nGfo/GRVkBcEGi2wxP0kmLlUkQb1ZRv0YgRAPE3KAmSeiEOM0fucgq
 pkbd65jyh7qDg7aj9qkR/5aTov2i09x9vr6a7MjnTWk64Es0Fh7WaMJzbR2gQFwMhEM4
 yBgnXRqmzyecySF6N8Arxs1314QRdalxVv4cHgrxzWrrKX0JzLFNRx8PKz0M1b8TTtZj
 dtkBa5aUOLu4JuUU7Zh3Ftd4+kCM9hMOgonBGdG5ssL1ap2XCfkZS5ozFEwcsmWgQamU
 kj6VeIDjQBqBwh9uIHRo+VSIoC9i39jazWp3U9CtCDlrLxGIhqKxdgCVhpFaV2KKia4g
 fddQ==
X-Gm-Message-State: AOJu0Yxd1VqZnPAiotdsjpnch4vy9Kj+Tp02EEDOgL0H47yJLKEQT/2H
 nuuGjWzLUtfu96XfGgLuSWqJTDNeebL/GPCnrPI=
X-Google-Smtp-Source: AGHT+IEJyIcSWutasoJ4IeJtde6cMwiYXC9an5Al0tk4DDjGI8kEAJvAkd6dhQDcYTeqNQ6+Kgj6L7oKcF+HAgGU/q0=
X-Received: by 2002:a05:6a21:148e:b0:194:c6d0:8d5a with SMTP id
 od14-20020a056a21148e00b00194c6d08d5amr2072674pzb.6.1703069343822; Wed, 20
 Dec 2023 02:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
 <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
In-Reply-To: <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Dec 2023 07:48:50 -0300
Message-ID: <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

Hi Andrejs,

On Wed, Dec 20, 2023 at 7:39=E2=80=AFAM Andrejs Cainikovs
<andrejs.cainikovs@gmail.com> wrote:

> diff --git a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi b/arch/arm/dts/=
fsl-imx8qxp-colibri-u-boot.dtsi
> index a6af4e5e2b7..6ab6b1f9ee6 100644
> --- a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> +++ b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> @@ -84,6 +84,21 @@
>         bootph-some-ram;
>  };
>
> +&gpio_expander_43 {
> +       usb-bypass-n-hog {
> +               gpio-hog;
> +               gpios =3D <5 GPIO_ACTIVE_LOW>;
> +               line-name =3D "usb-bypass-n";
> +               output-high;
> +       };
> +       usb-reset-n-hog {
> +               gpio-hog;
> +               gpios =3D <4 GPIO_ACTIVE_LOW>;
> +               line-name =3D "usb-reset-n";
> +               output-low;
> +       };
> +};

Patch looks good from a U-Boot perspective, but just want to
understand why the imx8qxp/imx8qm boards
in U-Boot use devicetrees based on downstream NXP instead of the
mainline kernel dts?

Shouldn't this 'hub out of reset' be added in mainline Linux first and
then just sync the dts in U-Boot?
