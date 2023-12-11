Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2BC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 20:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B7A80790;
	Mon, 11 Dec 2023 21:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="uEPNDnEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54ECD87734; Mon, 11 Dec 2023 21:42:36 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A618037B
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 21:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4b2eaa89796so1248426e0c.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702327350; x=1702932150;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFBYUk8rStODWhPN1nUT8+mdTaHS1GVgslB0bcsAbSk=;
 b=uEPNDnEUTBEyK6FfWc1g9NRt86czCL3Xf7jh/iM+t080zqbintUm1SjL+xqG1/tklR
 rqdBhKNPau1C6v1U1Da4aqPGo+EEjeyiVHn2gZlr3bTqCCAVfA76AlrSOsCCIIEZVbJW
 0xZljwzA5DV9rPoXusWdkayOmktpjkTT6diTtBzEuq+v8NGhf8Vg95ryyEeEfZnnezMA
 SNBVhUJU+WVH1uU+UyLI+duQX6rNV9mhvTJhhBBCodNt8n+3Lpq9ue2TrO6FV6FpYQMt
 MAdZzqVYaQ6bioBOqFJVMVJnsNbX2DQUVG7XhpMp4PpVPuARqYe5BBjantZjw9iqmPFc
 3GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702327350; x=1702932150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFBYUk8rStODWhPN1nUT8+mdTaHS1GVgslB0bcsAbSk=;
 b=OPj4R+ZKbumHO+k+dKsY7z8LvbVNNNUojZiqiYKD+X/KV08QID53ImrqgSDDuTu7ae
 c+pI3oQ7Nea6IVlngR0VxzA1KljhFYeMoV2qfaZbTVtfFf1yywpnevJ7mL8fA0mH3UJr
 RP/YPyi9V2ms4E1USC5tZM6rBYij5//KqTVw/ILaBb9rGcU+4ExkuVKKYwXO9iSsqtQB
 5dt/d1RZwZIQfysiscTnmBY+IKMsLPawfZijcNRN/XBu4/arjtHyxnY6f8XEOzAZkH+3
 tqk6YUtH1VXa/GmxSt8Rw0I3iZtgy4EK/zmyxSHFDwytD90E7HgQqgcTT+WON/6WUgxV
 QzLw==
X-Gm-Message-State: AOJu0YycUmsdUsCCJ4od6tzL57BeJMBmgydLdg7CeeKYOH6lQjd5EYzo
 Zla68KvOxSe89d6qFRQq5m/7rFUqEgkhKjRyWwiMVC3T0E9cUB7pg50=
X-Google-Smtp-Source: AGHT+IEXBzcqYctEASjBWAhjH9RTTidnjpHoQOO5UUuZFCtPiC/VtM5xKgUbo12tMZFHt+sR/1vX8X8a/I7KDhkNZ9A=
X-Received: by 2002:a05:6122:250b:b0:4b2:e4e1:8286 with SMTP id
 cl11-20020a056122250b00b004b2e4e18286mr5167323vkb.0.1702327350207; Mon, 11
 Dec 2023 12:42:30 -0800 (PST)
MIME-Version: 1.0
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
In-Reply-To: <20231113112309.730323-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 11 Dec 2023 20:42:19 +0000
Message-ID: <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, 
 trini@konsulko.com, jagan@amarulasolutions.com
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

On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Add smbios information for Pine64 RockPro64 board and enable in
> config
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  Changes
>  v4: Change PINE64 to Pine64
>  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
>
>  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
>  configs/rockpro64-rk3399_defconfig        |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3=
399-rockpro64-u-boot.dtsi
> index 732727d9b0..089732524a 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -9,6 +9,28 @@
>         chosen {
>                 u-boot,spl-boot-order =3D "same-as-spl", &spi_flash, &sdm=
mc, &sdhci;
>         };
> +
> +        smbios {
> +                compatible =3D "u-boot,sysinfo-smbios";
> +                smbios {
> +                        system {
> +                                manufacturer =3D "Pine64";
> +                                product =3D "RockPro64";
> +                        };
> +
> +                        baseboard {
> +                                manufacturer =3D "Pine64";
> +                                product =3D "RockPro64";
> +                        };
> +
> +                        chassis {
> +                                manufacturer =3D "Pine64";
> +                                product =3D "RockPro64";
> +                        };
> +                };
> +        };
> +
> +
>  };
>
>  &sdhci {
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk339=
9_defconfig
> index 4cd6b76665..affb6137e0 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -90,6 +90,8 @@ CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
>  CONFIG_ROCKCHIP_SPI=3Dy
> +CONFIG_SYSINFO=3Dy
> +CONFIG_SYSINFO_SMBIOS=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
> --
> 2.40.1
>

Can this please be merged if no changes are required?

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20231113112309.73032=
3-1-i@shantur.com/

Kind regards,
Shantur
