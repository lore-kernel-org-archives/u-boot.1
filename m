Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5038BC36013
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 06:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8F98129B;
	Mon, 31 Mar 2025 08:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ga70GNMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74975812BC; Mon, 31 Mar 2025 08:55:54 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4512980F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso38288275e9.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743404152; x=1744008952; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/LDoUuuCa/kXmEXmDyNlxtLI7KTVpWPhSBOke3c2Do=;
 b=ga70GNMlsQcDMFwyaI2236NZsuvjfjSDmtjlkKWDhrkrwpi/pp6UuqdieTEP0v1Yfx
 ZeWq3fP8a3lTJWbLeIkLjZZ9DYH3Fg7b3FqlbyFKb7/MENQF6zdRtwAJ8j/fsPj6dLhl
 50FzRSQw0ALgawvSfzvqDbSiQKeN3bxnJU84kMHGpSBVCPoyx/5oHzst8kxyiMxM4wv/
 k7RDkZJycVRcQ33yFSsNQZiQxOoDfZYPnULfq6Sl8VGHOD5MbMkS92l58RjU4SPRbXBJ
 2MqdsCRCVoGyNyIQjsekORLi4FdwRYdXzK968Gx+7JMnCMBgglwQ4dKuifPJElZpok4V
 3E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743404152; x=1744008952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/LDoUuuCa/kXmEXmDyNlxtLI7KTVpWPhSBOke3c2Do=;
 b=TuL/l49YcP3Gjqf+bW7qVKODpQ6onMdELlwXVYGXwoyBL30qOflQPn8Dkp7hvuqHKV
 +kmfGtdVvae/rcq6bnDy+GgxVKo/31TdZRSFK6jmnhZhiCUMX/ycZSbILu+w3Ob+oIMg
 wCwIxrI7KjL3gbWNZkPJjTxsvLZ5QzJDdyJ7tOlD2BjdKYZ3g4lAbHk30fTedca2tARE
 jVZ/S0aFAOtDw8heHItEKhWb6U7hT9Cxe2l0MXNVHkw71+lQJsQKun9MBV6zJ1XxAi7u
 slePDfWCPR5lg3PePC3HOD9K4e7Ipj2s1cRO0KV3cW39IScbQmfBVIEkqVCz41COVWuF
 TfrA==
X-Gm-Message-State: AOJu0YwOMf2Jzoxj1GUgMWBQZZHVARafBHiKsRMzE5Uv62O9sJlYBs7u
 JbCuSY5yKAHO+sA4t/wAYv8Ia9/cSCdaoVxE08cjd5hOP0JK1jQqCe1hbpH7NyUiYL8kFN4i4YN
 I1VIHEv8nGUbp4D4haHAAyk8oTyk=
X-Gm-Gg: ASbGncvgokS3dr4/4PeasF7jd7EnWqWsK1YjIBQ4K+nTTGjh5+oZSUJPauyN/7+pSFO
 Gzc2agG2iNeQGHh06vvBc+h/sQPiDi2weTOh54phC+545jHoJ5Fm6Wk6ZnITFze/HRfeau/0JRS
 IAiAs52fh5ejSo8KGtvFFwQ3a7N1Y=
X-Google-Smtp-Source: AGHT+IFrA804Kjo1qT2v1v6vtHs9FcwE1JR0wLX1fExu5r/AzQAforVx/xSnEdGiTjJLLxqfjXc21liyumfTlULN1i8=
X-Received: by 2002:a05:6000:2510:b0:39c:16a0:fef4 with SMTP id
 ffacd0b85a97d-39c16a10a1emr4758679f8f.24.1743404151456; Sun, 30 Mar 2025
 23:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250330211153.RFC.1.Iebf436d41ff5f52c0b11aaf9e8f98d6a2d4d56bc@changeid>
In-Reply-To: <20250330211153.RFC.1.Iebf436d41ff5f52c0b11aaf9e8f98d6a2d4d56bc@changeid>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 09:55:39 +0300
X-Gm-Features: AQ5f1JpEA1KeZ6U07cav2IPrLuh5uECaxXg_9CxuN8UbnEtR3C7CoPX5CTU0scU
Message-ID: <CAPVz0n3wC2dWtBq+tkVL_p5OwUJYPN8p7TQMN8qxdvGf2ox7Yw@mail.gmail.com>
Subject: Re: [RFC PATCH] pinctrl: tegra: detect unknown/invalid pin/func
 configurations
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:12 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Tegra20 driver doesn't know about some pin configurations and even about
> some pins. In case when pin configuration is unknown the pin would be
> muxed to whatever is under function 0, in case when pin itself is
> unknown, it could cause out-of-bounds array access in pinmux_set_func
> and pinmux_set_pullupdown.
>
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
> This allows to detect some unsupported/partially supported pinmux functio=
ns.
> Without this patch, U-Boot boots "normally" on Transformer T20, unless
> we enable debug by defining DEBUG in include/log.h, then we will hit an
> assertion in pinmux_set_func: pmux_func_isvalid.
>
> With this patch I get following warnings:
>
> warning: not muxing i2cp(18) to i2cp(64): invalid pin or function
> warning: not muxing ld0(64) to displaya(64): invalid pin or function
> warning: not muxing ld1(65) to displaya(64): invalid pin or function
> warning: not muxing ld2(66) to displaya(64): invalid pin or function
> warning: not muxing ld3(67) to displaya(64): invalid pin or function
> warning: not muxing ld4(68) to displaya(64): invalid pin or function
> warning: not muxing ld5(69) to displaya(64): invalid pin or function
> warning: not muxing ld6(70) to displaya(64): invalid pin or function
> warning: not muxing ld7(71) to displaya(64): invalid pin or function
> warning: not muxing ld8(72) to displaya(64): invalid pin or function
> warning: not muxing ld9(73) to displaya(64): invalid pin or function
> warning: not muxing ld10(74) to displaya(64): invalid pin or function
> warning: not muxing ld11(75) to displaya(64): invalid pin or function
> warning: not muxing ld12(76) to displaya(64): invalid pin or function
> warning: not muxing ld13(77) to displaya(64): invalid pin or function
> warning: not muxing ld14(78) to displaya(64): invalid pin or function
> warning: not muxing ld15(79) to displaya(64): invalid pin or function
> warning: not muxing ld16(80) to displaya(64): invalid pin or function
> warning: not muxing ld17(81) to displaya(64): invalid pin or function
> warning: not muxing ldi(102) to displaya(64): invalid pin or function
> warning: not muxing lhp0(82) to displaya(64): invalid pin or function
> warning: not muxing lhp1(83) to displaya(64): invalid pin or function
> warning: not muxing lhp2(84) to displaya(64): invalid pin or function
> warning: not muxing lhs(103) to displaya(64): invalid pin or function
> warning: not muxing lpp(104) to displaya(64): invalid pin or function
> warning: not muxing lpw0(99) to displaya(64): invalid pin or function
> warning: not muxing lpw2(101) to displaya(64): invalid pin or function
> warning: not muxing lsc0(91) to displaya(64): invalid pin or function
> warning: not muxing lsc1(92) to displaya(64): invalid pin or function
> warning: not muxing lsck(93) to displaya(64): invalid pin or function
> warning: not muxing lsda(97) to displaya(64): invalid pin or function
> warning: not muxing lspi(96) to displaya(64): invalid pin or function
> warning: not muxing lvp1(86) to displaya(64): invalid pin or function
> warning: not muxing lvs(90) to displaya(64): invalid pin or function
> warning: not muxing rm(25) to i2c1(64): invalid pin or function
> warning: not muxing uad(53) to irda(64): invalid pin or function
>
> and pins:
> warning: not configuring pull/tristate on lc(121): invalid pin
> warning: not configuring pull/tristate on ls(121): invalid pin
> warning: not configuring pull/tristate on ld17_0(121): invalid pin
> warning: not configuring pull/tristate on ld19_18(121): invalid pin
> warning: not configuring pull/tristate on ld21_20(121): invalid pin
> warning: not configuring pull/tristate on ld23_22(121): invalid pin
>
> Going back to what was before the patch, here is what happens in release =
build:
> tegra_pinctrl_set_func iterates over tegra_pinctrl_to_func to find
> matching func_id
>
> if (function)
>         for (i =3D 0; i < PMUX_FUNC_COUNT; i++)
>                 if (tegra_pinctrl_to_func[i])
>                         if (!strcmp(function, tegra_pinctrl_to_func[i]))
>                                 break;
>
> If there is no match loop exits with i =3D PMUX_FUNC_COUNT which is then
> assigned to func_id (if function were NULL, func_id would be
> uninitialized). Similar logic applies to the loop below, looking for
> pin_id, and to loop in tegra_pinctrl_set_pin. All these loops are fixed
> by this commit.
>
> But, going back to what was before: pinmux_set_func is called with
> PMUX_FUNC_COUNT, in effect we end up here:
>
> if (func >=3D PMUX_FUNC_RSVD1) {
>         mux =3D (func - PMUX_FUNC_RSVD1) & 3;
> }
>
> As PMUX_FUNC_COUNT =3D 64 and PMUX_FUNC_RSVD1 =3D 60 this becomes:
>
> mux =3D (64 - 60) & 3 =3D 0
>
> In effect U-Boot sets some pins (look at logs above with (64) after
> function name) to whatever is under function 0. In case of LD* pins
> this is displaya, exactly what we needed, so we still have working
> display. This seems to be the case for other pins too, however I still
> need to validate that.
>
> In the case of pull mode, PULL_SHIFT macro internal accesses
> tegra_soc_pingroups, here causing out-of-bounds access.
>
> For now, this patch only add warnings and some IFs to prevent undefined
> behaviour but doesn't address missing functionality yet. I'd like to fix
> that in another patch/series in following weeks.
>
> Device still doesn't boot in debug due to some other issues which
> require further investigation:
>
> clk_set_defaults(regulator-3v3)
> clk_set_default_parents: could not read assigned-clock-parents for 3f33a5=
18
> ofnode_read_prop: assigned-clock-rates: <not found>
> regulator_common_set_enable: dev=3D'regulator-3v3', enable=3D1, delay=3D0=
, has_gpio=3D0
> regulator-3v3@vdd_3v3_vs: set 3300000 uV; enabling
> initcall: 00112c70 (relocated to 3f73cc70)
> Osc =3D 12000000
> CLKM =3D 12000000
> PLLC =3D 600000000
> PLLM =3D 600000000
> PLLP =3D 216000000
> PLLU =3D 960000000
> PLLD =3D 1000000
> PLLX =3D 1000000000
> arch/arm/mach-tegra/tegra20/clock.c:492: get_periph_clock_source: Asserti=
on `!err' failed.
> resetting ...
>
>  drivers/pinctrl/tegra/pinctrl-tegra20.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/te=
gra/pinctrl-tegra20.c
> index d59b3ec7b5d..aa73ada92ba 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> @@ -37,6 +37,12 @@ static void tegra_pinctrl_set_pin(struct udevice *conf=
ig)
>                                 if (!strcmp(pins[i], tegra_pinctrl_to_pin=
grp[pin_id]))
>                                         break;
>
> +               if (pin_id =3D=3D PMUX_PINGRP_COUNT) {
> +                       debug("warning: not configuring pull/tristate on =
%s(%d): invalid pin\n",
> +                             pins[i], pin_id);
> +                       continue;
> +               }
> +
>                 if (pull >=3D 0)
>                         pinmux_set_pullupdown(pin_id, pull);
>
> @@ -58,13 +64,16 @@ static void tegra_pinctrl_set_func(struct udevice *co=
nfig)
>         const char **pins;
>
>         function =3D dev_read_string(config, "nvidia,function");
> -       if (function)
> +       if (function) {
>                 for (i =3D 0; i < PMUX_FUNC_COUNT; i++)
>                         if (tegra_pinctrl_to_func[i])
>                                 if (!strcmp(function, tegra_pinctrl_to_fu=
nc[i]))
>                                         break;
>
> -       func_id =3D i;
> +               func_id =3D i;
> +       } else {
> +               func_id =3D PMUX_FUNC_COUNT;
> +       }
>
>         count =3D dev_read_string_list(config, "nvidia,pins", &pins);
>         if (count < 0) {
> @@ -78,6 +87,12 @@ static void tegra_pinctrl_set_func(struct udevice *con=
fig)
>                                 if (!strcmp(pins[i], tegra_pinctrl_to_pin=
grp[pin_id]))
>                                         break;
>
> +               if (func_id =3D=3D PMUX_FUNC_COUNT || pin_id =3D=3D PMUX_=
PINGRP_COUNT) {
> +                       debug("warning: not muxing %s(%d) to %s(%d): inva=
lid pin or function\n",
> +                             pins[i], pin_id, function, func_id);
> +                       continue;
> +               }
> +
>                 debug("%s(%d) muxed to %s(%d)\n", pins[i], pin_id, functi=
on, func_id);
>
>                 pinmux_set_func(pin_id, func_id);
> --
> 2.48.1
>

Ignore the last comment of previous email.

Applied to u-boot-tegra/staging with slight debug message adjustments.
Thank you.
