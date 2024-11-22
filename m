Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DB9E6ADCA
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 21:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E9B8938D;
	Fri, 22 Nov 2024 22:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KjHggqJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E83589382; Fri, 22 Nov 2024 22:42:53 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B33E897D0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 22:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ed91d2a245so521055a91.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732311769; x=1732916569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81TogTZU6WedpTmcpIg9p0DBTRWAp2RIT7f4k+z8i1w=;
 b=KjHggqJSvWuQUQMKeSl+u58KDv32yWy8zSkCCRg5ohHuYw88ApubYfJVzH6IrSsij6
 uZfWLxh6Of9AQke9waHACMnT7UKMtGL2Wfefy8nTyPAmyNfz2eRING7SZPGRU4v0fn7T
 9EgqXPD8hp/LVY3BDOCxQH1X1fGsal9E5jqkRnDA2wAByBzS5IFBPpYjgrB9nYMCmAu6
 OHFOvKKFOA1qUI8LBIpB8OuBdSmZAZecEGPyXHf2UcXXbTX+jlj6D1XOMtTRADbN0ZGr
 Jb/uyJWMPWYih5ja3Fy5EFur2zwzmTvH3seq9+U79OoYlaa1CyE1wOry+zrk2rA6E9GV
 UU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732311769; x=1732916569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81TogTZU6WedpTmcpIg9p0DBTRWAp2RIT7f4k+z8i1w=;
 b=gq0CYIjkxzlF4O4jNIfels0JI0PWfShl28ElAwoWpx03f+uA5NLCbXFQIKLaxHiix+
 uPRjeMOqfhV0QY64g9qy47MDLlWs599PH4BMy5AYhqn1bjR8FoMbOM9S2i25kcRN/cd4
 CKY3fiLciXoKi5Ye513fgFUOpuuxafzrSgihH+eTo6Rdyzu01sb0RfE7gAyA8TGf+Vd0
 ci1L03loBOqXkTaSCyXN2uq466mvydFiEG7eOe9AVZMTnrNuzmaqRrGE/Bh1OzsV9v8v
 F8TyacJzxTv0y7HD1dvk/SfrJzUCSMhdWcdFcC/mBaxNbH9BCFmn1rXkkejVwpozVPb3
 C9Dg==
X-Gm-Message-State: AOJu0YykijZzGJuzzZ+QpgNy51417H7wZvmZeqEHqyVjdt1pqwFP3kYU
 xpZVcIHN+1pZZh3IapB3nrbdlr6rNzK11NPf/2V5XR1gD1RwVG/38/8HSipshVjYPFYVriRQ6m+
 1YIJziUeOPX36TtheUv1aaoforf4=
X-Gm-Gg: ASbGnct+bstygP1laA/6SwXBlxuiKIq6PRVNvoJmIcBsohG6k7FO/8jwd0WjoVQ7+n2
 5/idt+FVeN1dZ2EelY5NtDKHtzkpaRuw=
X-Google-Smtp-Source: AGHT+IGbI88BOTDxFrwXh0i/cQThFdQYtiYU2xu3A92U3+95J4v5SyShRvte5VCtp/JexWwWIayWkoUHsF9zU2tyDMI=
X-Received: by 2002:a17:90b:4c8e:b0:2ea:3aeb:ecca with SMTP id
 98e67ed59e1d1-2eb0e8847b1mr4957775a91.31.1732311769353; Fri, 22 Nov 2024
 13:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
In-Reply-To: <20241122015858.557561-1-marex@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 22 Nov 2024 15:42:38 -0600
Message-ID: <CAHCN7xLNU=skeRJ0apT=URnEiqqW2FJDS6OXE6uxNmpB-mS_0A@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Include 32kHz oscillator clock in
 SPL DTs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

On Thu, Nov 21, 2024 at 7:59=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")=
,
> drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk=
)
> fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in =
the
> end calls fdtdec_parse_phandle_with_args(), which iterates over all phand=
les
> in clock-controller@30380000 { clocks =3D <&osc_32k>, <&osc_24m>, ... } n=
ode
> 'clocks' property in an attempt to find the "osc_24m" clock, but fails to
> resolve the &osc_32k phandle and returns with -EINVAL.

Thanks for doing this.

>
> Include the osc_32k clock in SPL DTs as a low risk fix for v2025.01 relea=
se.
> This way, fdtdec_parse_phandle_with_args() can resolve both the osc_32k a=
nd
> following osc_24m phandle and successfully look up the osc_24m clock.
>
> Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"=
)
> Signed-off-by: Marek Vasut <marex@denx.de>

Tested-by: Adam Ford <aford173@gmail.com> #imx8mn-beacon
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Malysa <greg.malysa@timesys.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonathan Humphreys <j-humphreys@ti.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: For v2025.01
> ---
>  arch/arm/dts/imx8mn-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 6875c6d44ff..6d80d856365 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -68,6 +68,11 @@
>         bootph-all;
>  };
>
> +&osc_32k {
> +       bootph-pre-ram;
> +       bootph-all;
> +};
> +
>  #ifdef CONFIG_FSL_CAAM
>  &sec_jr0 {
>         bootph-pre-ram;
> --
> 2.45.2
>
