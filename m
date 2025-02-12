Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A9C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 11:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B437809D0;
	Wed, 12 Feb 2025 12:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XT+e7rRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B80480BAA; Wed, 12 Feb 2025 12:21:08 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF8180842
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 12:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so1828293f8f.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739359266; x=1739964066; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWHc7aaqOGiheMgr0STZA0dQhikMaUZOELwd6HDq/sY=;
 b=XT+e7rRt93xkgoxgWJ+cWWu5KekqAPxG2X4Fxq4d2mSHrTYzri8hqtst24fMhnB3th
 4c6/Ql6MajvoMUI3+UJoDHISSAdhPKc8HpQHhkGd+hk1iZwypo211p//ohZtow12gVl2
 TnjTesDHlByHiDZoPG9qMUo2i7ibKo1jgjJoE1YfFApmGD2hOjsxnYzFQV2uv0twd2kg
 mia6iAcbmtwh86d40K1hvYC8/asq1ZPRE9Pg8XMjuCjHXgd5Z9jCA+E3YKolFn3/9s1v
 QOXtbeEOJ3em8KHj4DhINvGnB4Iql3CdfHIQoXgCrWEkEzoTk6jIDicyEGw//v3yeAqf
 LS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359266; x=1739964066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWHc7aaqOGiheMgr0STZA0dQhikMaUZOELwd6HDq/sY=;
 b=Iw9du0zCmFy/9xqrJyjkPV7MsGtkEmCV6ucQ5tndE/2SIe4KQWL9zRhQhHEiST7sbY
 Ku2aLocy67JfXpc1PjNST3MYW1/qaYbTW27Vf94wMqmMQBXlqW6TwwwGD2HwKxBIHbJH
 Dwj9HA20rnCpIdA0mtaKORBgQQnIFKi2VVvwwzUrxZGGpscqwxAlv1mzI5J+CfdpV0DI
 E73YkF1VDdUEk5u2b6n5hp1oBeKiMz+B97pVAmg3iEdocZc03oPVOkU0/QrunWMuiENX
 TJm/4vPLNsvaoFvpz9I7E4NpdC2PpCYycdu+zVW6iN9+z42+QDWPFQck60WikPhqyNwu
 icCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDVm5kPYVO7GS/wKVch0oinjD1tm0QI/1BDEZMUNAgPo96bIjkqce4f6ji34IkX76M+fhi+SA=@lists.denx.de
X-Gm-Message-State: AOJu0YzMwXWeCrNDGzK6wpIidsILdbtG0+CmPQ9NWazzD9mDHTtkkyp5
 3RG4ItzfcCPRlrjtM4wnvSPdq+Z1uLRSGp59MEzuNuRyDbULH4ECkc/+D1OWLh35QoRP8tCuPRs
 NkBPn83DPfwBn92IBWD4V9N2P3uc=
X-Gm-Gg: ASbGnct/roeF/WsySp8Drip0BFWtPCxyHB9DbZOT99uLdpxGIcal2SM0rNZxz7TjTht
 l3C1WwJKrTTP/OBmcmIL67dfWjjOBnd9v+KdRf8xlVP8Y2U0PFNU7YMJ9b9MCqB2BkMs3r9Sfmg
 ==
X-Google-Smtp-Source: AGHT+IGJNTU3WHsg/y1oO0UQreR6PQNkwX1X1NfGpQWj99mClCVuS5FmSFd19Ku8nyzej0H+D+68wFinZw09nVkbRH0=
X-Received: by 2002:a5d:648d:0:b0:38d:e02d:5f43 with SMTP id
 ffacd0b85a97d-38dea251538mr2529908f8f.2.1739359265547; Wed, 12 Feb 2025
 03:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20241212101331.6135-1-clamor95@gmail.com>
 <20241212101331.6135-6-clamor95@gmail.com>
In-Reply-To: <20241212101331.6135-6-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Feb 2025 13:20:53 +0200
X-Gm-Features: AWEUYZnLvbRYZYUg7EyHqfLE6utZ6U6MR395s9ZFWwgLJdl1w84Z5ttGv-B0dSg
Message-ID: <CAPVz0n3Ek8Nchc9ZDzLKd03ac2H2Di=Z_NY3LqxruycL85VouA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ARM: tegra124: dts: mark HOST1X and DC with
 pre-relocation flag
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
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

=D1=87=D1=82, 12 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 12:1=
3 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Same as on previous SoC generations this is required for proper
> video output work.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/dts/tegra124-nyan-big-u-boot.dtsi |  7 -------
>  arch/arm/dts/tegra124-u-boot.dtsi          | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi b/arch/arm/dts/te=
gra124-nyan-big-u-boot.dtsi
> index 376dcdf68fb..79de06761bb 100644
> --- a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> +++ b/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> @@ -7,13 +7,6 @@
>  #include "tegra-u-boot.dtsi"
>
>  / {
> -       host1x@50000000 {
> -               bootph-all;
> -               dc@54200000 {
> -                       bootph-all;
> -               };
> -       };
> -
>         spi@7000d400 {
>                 spi-deactivate-delay =3D <500>;
>                 spi-max-frequency =3D <3000000>;
> diff --git a/arch/arm/dts/tegra124-u-boot.dtsi b/arch/arm/dts/tegra124-u-=
boot.dtsi
> index 7c119725528..6a02714a258 100644
> --- a/arch/arm/dts/tegra124-u-boot.dtsi
> +++ b/arch/arm/dts/tegra124-u-boot.dtsi
> @@ -1,3 +1,16 @@
>  #include <config.h>
>
>  #include "tegra-u-boot.dtsi"
> +
> +/ {
> +       host1x@50000000 {
> +               bootph-all;
> +               dc@54200000 {
> +                       bootph-all;
> +               };
> +
> +               dc@54240000 {
> +                       bootph-all;
> +               };
> +       };
> +};
> --
> 2.43.0
>

This commit for some reason breaks u-boot build for nyan-big
https://source.denx.de/u-boot/custodians/u-boot-tegra/-/jobs/1020521

Video device 'dc@54200000' cannot allocate frame buffer memory -
ensure the device is set up before relocation

Indicates that bootph-all is missing though it should be present, just
moved into tegra124-u-boot.dtsi (this is required for any other
tegra124 device which would like to have video output). Isn't
tegra124-u-boot.dtsi applied if device specific -u-boot.dtsi is
defined? May anyone clarify this?
