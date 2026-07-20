Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E1C44512
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 01:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046C580517;
	Mon, 20 Jul 2026 03:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GR2qvNQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5C582991; Mon, 20 Jul 2026 03:53:44 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CAAD80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 03:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-9034b6b7674so77855456d6.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 18:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784512421; cv=none;
 d=google.com; s=arc-20260327;
 b=eZfWZ2gIErY6tfkSCvXgErtDE4EV8Y9zVqfoSaU6+X97HWSi79qsy0ZsXfQN2IT+TV
 Cba1R1aF7M0pw++kmZre51u6VGA6XZP317TXKe9shAwKRjAMUpUavBT8dc3N/Y0W3lRh
 62CBLnO0SBz9pJoNKok1rTalkZJX4pTukoIZ3cq+gMyLJzFJ7Mtzg/3o++2nsNQ/Dcyc
 F6mgkuxBCSmVlZf7TeLyANByCq9IfGkBhlZLIb91u+TXpw0ynKTaxAY1cVQ4xdB383dQ
 Si7m0xeGIHq3QMpgjP3wKKVuXxCg1GVfckyU+V5gdmBbNh7akJ0XDT4Fca2dDVDPwCjB
 7j1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BWoRFFaEiNkrOJUwYWMehlqChLL3TJQ3G9ZQwc3gFUs=;
 fh=dePVnCh6v+jngadykHgK1XA7ACHCLhGSPRjAN5kJ4eU=;
 b=UL67AW8WIbo21gCgXRaNyZTWpGPMLW85ReuSukAc5H4Rrp/o78hOKh8YZXVSPCMyDC
 UuUtQka4Lj1z5NFYsyDTCPm/vX3ZNJ43WuoEcUZNfok6v6548q+xXkAYtfMIjFGA5Q2X
 u+vdOnXQkKTRzU6IgqmNPzK70tV+h43504i+q+hD+xHfumMGPYBeokl2VIEa4e96d4Lz
 gd3/e7djGLRYSGGb8wRz/FXYgzQOxEdHKXqnZ4TQINCD5TaEVhxKs5GihL1LBUsdNo7L
 w+JBQx7VNwKS6GsOpv0SNvTjPyYlD0pf4AgmUVciiW2IJ5jAerJiMMAaJIod8aayI4Ax
 tatA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784512421; x=1785117221; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BWoRFFaEiNkrOJUwYWMehlqChLL3TJQ3G9ZQwc3gFUs=;
 b=GR2qvNQc849Lsd51zQNHSRlr0iN7E+TXjvy///wjiRH0Zn6wQezQlpUHOOYp57s5ca
 LGnmb8CT5mm0GuJYo8C7uWIx9A8/vmw/OISVdwU5sa8OyYMJialpA0+scaLJAGxGtAll
 dlB7ri0S7eqiyAC4Iknx+s/lVD8PJi9rMRvV5smNSlkC8cyIXPoF6x1PtqLzjxBV4Q4+
 vHC43Vipuycq+Hf3zY3kPR50dMeBwNCa1VWEPOCpBw4LzMfLhXvsd4slk3CGx4tpvD94
 94nohfCALrrz095XMSDLYDHnYFW+Ubx3b6+bSWRUxFxdV8uSHkyQIY+Oy9MoChXwWdJa
 Vfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784512421; x=1785117221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BWoRFFaEiNkrOJUwYWMehlqChLL3TJQ3G9ZQwc3gFUs=;
 b=A1NsgaOwl7yW2cmRwwSVaaIEidqLsyjjtwS0eKyvBtMyuTpDUGjd3OKbmXN8V4W1b8
 FZG7ZCtxP7AhhD0KOxHmg6bX3r6rBwkWw/Utaisk6u++7j5q8RyFzRD/wk3CK4nTIUth
 2aPUl//EGMblEEBp9ESBVW5OXJJEOVWzNahvc/jASD+/Z1YPX4W3jv+XhQ4Bo6k/wkzH
 SrUg0YdMKL9IO8JnO2dMvam8KxDOS1eaAmF1TaFWO38VVHr8cVSPQvPz81o0R8ZcKqJm
 S6+IZPeZXpRT6dZuurM3uFtx8r7DMBXV/mQotkpChuqyiq1fOcqRZwkiWAhaMO20nbpv
 5MlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLgmWfzfiLxSsXhZi2T5EG1LeVM3DeG5Nu2lG40hw163+aqWfAICb+RF2LdYa/PfHgZ5nSzQw=@lists.denx.de
X-Gm-Message-State: AOJu0YwcUvKhQF3Wrc+jQSPS65s/0qdqOT8CR9ZPGGoxQgZGjsz7vcV7
 nGlcUCv3jKJKeybgM0/7jol8dES4vyR0GITQ9Jym/DeafsVT8EMm2qZQlIMl/rB5Tib4PUMiQqs
 5OrvKNkQmzr6vdEE91b/ckwGjr6gji4c=
X-Gm-Gg: AfdE7clhN/Rqr9UvD8P3dpa40TyHiLbSvfH6ILSfquE0OCiyumCgw43KzIHPQq4UAXK
 oM+evzQsFfrvqBfGfwBMerhwQZq1UYyLyr96AuP0K+ALgv4BbSy1wzzjk3eUHXgPQzikTf8zzJm
 eo5sdRLZ9TlmmYCcTHs6nx9a5ifww4fQ6icYKRvz8rETUQDIeyvVS+YFY1psPYmqcw+SI07sn6v
 MUXPnrzHcC1HBoXB5XRUuGg28eateoLGNcvBvfFB3a0aPXvDQ2RMe3RB0hLjA==
X-Received: by 2002:a05:6214:5d8f:b0:907:5516:3d61 with SMTP id
 6a1803df08f44-9077833840cmr130874626d6.21.1784512421135; Sun, 19 Jul 2026
 18:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
In-Reply-To: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
From: Tianling Shen <cnsztl@gmail.com>
Date: Mon, 20 Jul 2026 09:53:29 +0800
X-Gm-Features: AUfX_mxYmw6JU-aqyG6dXEw-KsZyZDiTejx57SHw5D1alsuMRPDAQP_nJ5od-Kg
Message-ID: <CAOP2_ThcJNDU1Q8Otvg37LXjOTZGVoR5XruDBBypGqJ3Q8E=KQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: rk3568-nanopi-r5s: drop eMMC HS400 modes from
 the U-Boot FDT
To: daniel@makrotopia.org
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

Hi Daniel,

On Sun, Jul 19, 2026 at 9:53=E2=80=AFAM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> U-Boot passes its control FDT to Linux, so the &sdhci override adding
> mmc-hs400-1_8v and mmc-hs400-enhanced-strobe reached the kernel, which
> unlike U-Boot actually drives those modes and then failed on the eMMC.
> Keep HS200, which works, and leave HS400 out. Affects the R5C too, which
> includes this dtsi.
>
> Fixes: 0ef326b5e92e ("rockchip: rk3568: Add support for FriendlyARM NanoP=
i R5S")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk=
3568-nanopi-r5s-u-boot.dtsi
> index 64c43374c04..7e0b2ba02e4 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -15,8 +15,6 @@
>  &sdhci {
>         cap-mmc-highspeed;
>         mmc-hs200-1_8v;
> -       mmc-hs400-1_8v;
> -       mmc-hs400-enhanced-strobe;
>         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };

The whole sdhci node can be removed from u-boot.dtsi since these props
are already included by upstream dts.

Thanks,
Tianling.

>
>
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> --
> 2.55.0
