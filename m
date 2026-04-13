Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D682EBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF2883F75;
	Mon, 13 Apr 2026 11:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PojuR+H2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C87F984119; Mon, 13 Apr 2026 11:24:55 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692F68352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EC4EF433A6;
 Mon, 13 Apr 2026 09:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49ACC2BCAF;
 Mon, 13 Apr 2026 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776072291;
 bh=kUmBrFWXYRy5T1m3MMSgFB/BGp2Fvwrp0q1e5tiAcpM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PojuR+H2KvTcoIg5oqgGBwV6kYzoOUEsaM0diVGa298xohOdGw6Nwuy+hQMz318xC
 NiYc25FcXkbU79LVIzUw4yJoVOj6wurqUnR6v+oboMfz9WR6fGpqd2QR6aucexmfjy
 xpO0aAuwfKjxNEdfabzVTvACNB6+94IFGkKKdKYu2Bt2ZFu5JrnhsKYnabJZEioDZo
 SCjPuwMtMN/G6tDLYvuc2zcVUXqJ461IYbMWn4vsH4vmLkvBO5D5XcplUXVunY2WY8
 cdrv8lc4me8Xbcjdrnuo/P/m66166zFqVY02834OeOIEN7iFA1EJfGgDwhF6ZvdOVc
 0k95/Ivw5VnHg==
Date: Mon, 13 Apr 2026 14:54:45 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Ajit Singh <blfizzyy@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] clk: qcom: sc7280: add missing SDCC1 clocks
Message-ID: <ady2XTeps3DzzL-g@sumit-xelite>
References: <20260226193217.82657-1-blfizzyy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226193217.82657-1-blfizzyy@gmail.com>
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

On Fri, Feb 27, 2026 at 01:02:17AM +0530, Ajit Singh wrote:
> Add GCC_SDCC1_AHB_CLK and GCC_SDCC1_APPS_CLK gate clocks.
> Required on platforms where SDCC1 is used for eMMC.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a3cc092196ef63570c8744c3ac88c3c6c67ab44b
> 
> Signed-off-by: Ajit Singh <blfizzyy@gmail.com>
> ---
>  drivers/clk/qcom/clock-sc7280.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 7b6ed826023..acdaccf7462 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -155,6 +155,8 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
>  	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
>  	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0)),
>  };
>  
>  static int sc7280_enable(struct clk *clk)
> -- 
> 2.50.1 (Apple Git-155)
> 
