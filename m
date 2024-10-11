Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7228BCFD342
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 11:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABA8892EF;
	Fri, 11 Oct 2024 13:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MtQpmPsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6728892EF; Fri, 11 Oct 2024 13:06:48 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7EB892C6
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 13:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a993f6916daso329236666b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728644805; x=1729249605; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=el7QvebJBqJazeio0zbC//yyMZERhus2FJwWCLkrKA0=;
 b=MtQpmPsKDHQN2hDwmCy39KpxlK2aHhEWL3BZIEc4ifp6DViZIZW6VVuI5J/wN8ZQfw
 7uSaxscX00h+/QdSA7YMTkx0zu2pqumgqSbjLLb+RNQQ0WL9OR2PTaV0eX93bZITmwwU
 1NjiQZnmp5iHAqckXXMP38exQx5IHfB0bxntdv+F2x4HvuZZAi3UHEYCle0/Tg81nmVE
 2n1ZRPgWvmHEwHNTmp+I8sIwHAq3ymNrsa6LiGZVDHmvmuXVaa1EFebE7Xnb0Cg1IKBQ
 UTeRhDWlqEs9QJ0LnlmmKxhj7OHi5w2xnGe1D7qEuPXuVuORjxh6nvpjNhKO6+2J4apm
 Lf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728644805; x=1729249605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=el7QvebJBqJazeio0zbC//yyMZERhus2FJwWCLkrKA0=;
 b=hygdl99fkGamfuGYc6b1rHl5G7pVCdYc/6BGv0Vez3918Ed341F/i0RbYzx+lR5BZA
 6J8du0DJOVx6mvKhupz8/UTOhhFNJtUHYk9Z6gzeeStRAhKJxTjgmrZoINQyU7XwLrWG
 Y3I7megjILJLaKTX82bhwsJNHd8REzuggPFKJ6u/tDIkMf0svIlJzf9PsBXbdDjfG19c
 sHQ1eV1ZkUdUAk9/+xOIcZonl7PQC+CFVRdeYvh2hka0qaRBidabphTXNVxTnkVRf99V
 Y+HnqLx3W96gqkTsrFuxaKFuXrto7voy4RHiVLAoKDpO4dd9CM0rHZIiqdbOwpMbys9B
 X4ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkFrHKMhy/G2XzLDltP0HL7n260CFtdc6Ni9buqk/lNyQyvTsDUX9tqV491FsbcKEBOB0U2n4=@lists.denx.de
X-Gm-Message-State: AOJu0YwXpBTlDh5+gZ+jUCUtTBU088H8G391nEc6PMZkzqe3HKCW7/sb
 VqHqd0lqXSKZb2HEc7g7yP9Wckamld06Oda10OjeyCIF3Xm+2DNgVM5V0i6Kpxt5svOnagW+4iS
 iyfmIV2BKfj3Nw8BP/Irk0Y9nURU=
X-Google-Smtp-Source: AGHT+IGGhec0SMqqnLjGSUjJYD6ZvGBOuayONKb2dTcCUHwMTsoYVcFMg9iMbvVm5Pv+0CuP6LV3zCXEiUEn5OTpDXo=
X-Received: by 2002:a17:907:7fa8:b0:a99:4f28:c437 with SMTP id
 a640c23a62f3a-a99b9305edcmr163148866b.7.1728644805289; Fri, 11 Oct 2024
 04:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241011112402.3168-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241011112402.3168-1-peng.fan@oss.nxp.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Fri, 11 Oct 2024 07:06:33 -0400
Message-ID: <CAKcgs2w1nhEMunjEms3ddzGb9wLZLvUo_XSxmEPbsz+3Jh+13Q@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mp: Add i.MX8MP Dummy clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de, 
 uboot-imx@nxp.com, gilles.talis@nxp.com, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

Le ven. 11 oct. 2024 =C3=A0 06:20, Peng Fan (OSS) <peng.fan@oss.nxp.com> a =
=C3=A9crit :
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8MP SDHC use CLK_IMX8MP_DUMMY clk entry. Without the clk, the bulk
> api will return failure.
>
> The correct entry should be replaced with IMX8MP_IPG_ROOT clk in device
> tree. This will be done in Kernel device tree and sync to U-Boot in
> future.
>
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk=
 API")
> Reported-by: Gilles Talis <gilles.talis@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 34d91cd6880..1d04090ca00 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -197,6 +197,8 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         base =3D (void *)ANATOP_BASE_ADDR;
>
> +       clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0=
));
> +
>         clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", b=
ase + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", bas=
e + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", b=
ase + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
> --
> 2.35.3
>
I confirm that the issue I was seeing on my i.MX8MP-based board goes
away with this patch.

Tested-by: Gilles TALIS <gilles.talis@gmail.com>
