Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E27DC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 801324192F;
	Wed, 23 Sep 2026 20:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jA03-bl2EaQ6; Wed, 23 Sep 2026 20:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEEBD418AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790196068;
	b=C6GpHfai797V28OKsgYpIqsyEtyWv79C+yHIJDOvn2a6Pd412cxtBs31r5+aYu2RZY1k
	 pf4sWeTpeeGTBTPQlJxmjF2RUpreENnatrCyLh+hUq4yIRpQi1cvoFP4fR+wKLug1jbfb
	 LjVAKU7LcftHhauFj4aIdizxzT4aNZpV5TDNN4G3lrZwRjyJEPBWLekuMuEeu3P1FyPE2
	 DrNioGyZRKI72fCm1ewm+i6KjquptGmxdNBj+IBeaH2Gq56rBnQCe1sjeCcAWVHvZ5ftS
	 +kT5QKS3ooKvDFCDSuxQtmP984Ot8aiX/AGp8ngdidJ5AE1MSoMHv4U08+hRO/ghE7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790196068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x2OQr3wnDHoo6+DaO9GKHHG1aMZ8uTvKTCLh1gKq/aE=;
	b=juS2nVmJKF+g34fvm77snXx5fFhq5Ujmd5uUnncbLwj2qwSSkOF3TbKH6rv2LCPs80lT
	 wwwrtThDVR/lGpVQ7x5ExmiQwEtX0T/p/Ug39pyOdDqpDxcVHyLsaHwifFp1w/SSDwFax
	 Jx3aRprnXp2PEy1joBXE1aslnsf8ti0Oi4glqbWaXxChM4ZYzw47VxR8pzwBZylB4Cyk2
	 97WlhLFTiH/oRSBFY0zL971Ze/+3t21KnM4avn4oN1hpZ44rcVbiGKzD+qL0D+atD154l
	 CO61PLX7Vh65WgU8gmwT0ruWhjOvVlJMvGxJuMX1GVrnpAr+X6g59x1qHU5WeDkYSOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eG3jHHQm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790196068;
	bh=x2OQr3wnDHoo6+DaO9GKHHG1aMZ8uTvKTCLh1gKq/aE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9mhOO05v+IyIMY6oWllUULei6lCewdMGL7KmxJQiLB3w1v2g8ccaUX7Zo2FZ7Xta
	 4sA8vmEH93USjNVqm6gc6unkHEm/6q5Z6SMmf2evSWk+b6olMzk4G6ryXS+fv+o4ej
	 DVIq6hirkgNQ5fDHH8aSucmYaHLwi6KR/DTyRl7pVVAojK879i+wABPhtORSBluhq5
	 ZR4rE4pVgBLg/0xNRYyrjTHosjrszYD54maXZvBPfmwaZ3nHqk7+Id3S1c8Sh8lWWU
	 KutWpbyjBM6DEoYnysmXVDqVAs/qjPDRQ+MgjKrYTpHv5+RY2CfDEqQXMlxCy6utoR
	 djvmUzsEFYJTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEEBD418AE;
	Wed, 23 Sep 2026 20:41:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D632C32F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C78F9418AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0cLQxHgsADg for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 64D0941857
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790196066;
 b=qKBj6aft0dwhEWYXk/JU5dlXl9mmNlfo7McVcgPvG1iFLsWLqcjKTC2SvH9bqNebaqcO
 xbT3gsMHx5m5r4HxdrUbnHb4UiiK5NR3oxTTUJ3TraDHeqjSmmzxKAmQ3s/00E4KYqZmD
 2MmfwMxZbf3Jlmao9q3tRjTIP2LghCL4UnN9Goff423DiMgDhnhvSXRrReNXmmOvaJErU
 agxaHy4V0Ajv/F9UMVNaul+RY/jzH5+OfnzBvAmagtIS1d78px64zj/WDLQy19eFeGYjJ
 d+iW7jc8Vdek+KRE7MU3atsmZIbA2ouvkyt5bFjXVg73IZmXhKyhf3rVTKKEnqQGLig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790196066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=x2OQr3wnDHoo6+DaO9GKHHG1aMZ8uTvKTCLh1gKq/aE=;
 b=g2SlMJrl2e02o+KCZRLBiVXX/nTz95OIdV4pQcYRw5Ohro2DEzdrawGQ5vOPm6A801hN
 JCjDc65TU+No+onVS+kzl0YvPIDP+hoSAG2U5QZjidYp04ftmLudv4K82lDJxvgGM+DDJ
 m6+v9eP9oBp+V/Efvdz2Br5nEZhYKbBrWCgWuVqdg26yntkjipVWaEjX6OV1IfgspM4S6
 HHfqWySMN/WH8+qU+D8fqfpPJhY+B3nXhVV9xRObCxmOH/Ati28GZyV7i83VqUA/tEDGs
 KYwKbPTTuTIQNvg8kIlNvSxBKGFqa3UfF2RcXOjMhJEXqtvla7hS967ytuPjQ1JLpYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eG3jHHQm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eG3jHHQm
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64D0941857
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:41:05 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b4bff33ceaso791127eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790196064; x=1790800864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x2OQr3wnDHoo6+DaO9GKHHG1aMZ8uTvKTCLh1gKq/aE=;
 b=eG3jHHQmca2hySCJ9o+U5n5/Da0OOsIXEToUtEnzK9c85eGPlXJxLkMaCjIJeSiwzi
 AZMFuCcebPrgR4IQFb/iFU32WEDyioQenVdHBXVlfZFJCzFVloipnRPE1+3y0/noajlM
 YbJaC2vnGR/LIX3/A9d76cRofynFeGIjAC9FZ5p/CYsASt7jMVRl0JeQkEnm+aJGtQpD
 7+g32Hc4rc5+gAoPkDJKd28JCA53KEGHZNXQLTQffyA+AhHtYwJWeEcrE4UpmbndFTJq
 ENBoPgM73849Qe4qVODwVeULipnBO7asgoNqSBwOyAaPBMAT8AcQ5gpahxDG4ILBvdrW
 pC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196064; x=1790800864;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x2OQr3wnDHoo6+DaO9GKHHG1aMZ8uTvKTCLh1gKq/aE=;
 b=C5VMobH5NYLa1YcYf1lV5Taymk/KB88H67C0mQ1Vu9Tyi0aCb/SbxIeR7My0PUXaNn
 JQVRN3Lkju3ABDeJj+kVH9eXvJuKuNbMqqvd9Ia70KVI/DiSnOY3n56YSkikSsg+FLr1
 +wNLKyZOIndLpvX+vgva0W2hWkZNt9Fx6sn+nYqPyFBkw21lkiqeQNolXzW+iFCloYEH
 qM7dUEaCDybEUoaet4fJm1D1DUHk4quEzKxaMiS3a3EdYYjmUj5IHfFhzGXOVKqa/LBl
 J4ZVjUyPMneG+A0kqktpHIzfOXuCuzFziXuyDLF91Tq4cBnxrc7ZsPD5ZwYDvN7m51oi
 WVeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoPg597o0rV9BlX/qH37g1fAjnK4mBSFkjlK9D0agYX6FOQr+Oo6rnyHM5naOTAXchcZwmZQA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++llUT9cQQzdCqvWFenOJUsJIqhWMN80Pc5ArXsKYJ66Ry9f7EWq
 Ej+PDJRrGFj4nHg5pUpjgr4kk2VGdrRxqKTfcRF9wrLhGdBcv2HlgjypgbDoNYMZbJ4=
X-Gm-Gg: AYBFou2p+nhP5TS1L15ebPVtGZM2+OnqLNRkSZ9nO06RP4RJEPjelXtMkKt+B6TUGSp
 hA5y0w7nl46D1JCOvzUJMLOYL0kfOxfKPVmbvVXIsv20hGJ/oWlKyr6jPQfFbGtghWr4jhxlkhF
 wsABeQ6qV0NWXc5TpwDqwt5YpEAT65/KTCy+GMLi8KPVxgbmKNJHBhIoOfU2DUWDXJtJqWTF2U1
 YEB9+qFIrC06ynsUp4wnhU6KDZn5OEtGIh/LawGg7Ni5Y4R2tSS+jMe/5AQQvF0Ul/NYV7dfakM
 9cEZM6wIEPeMg2tiKuVTvh3skd/0FVDsNIIjHZRfGIISy7GYZDEg9qLlqpZ1FLw4ReM755IR+7O
 ONNNfC3dLwCVqBWo+9el6W7um5XwTcxUTekjWW8glNCZZ59vsfjsH5ULLAHMglLho3C2PKonMrw
 PAMYVWAkNWVmQK/DJtoGaqxyaj5CFOinj/5DV79wuKrNux1dijKaT3fIrTPd7bpJzeTMHX8zr51
 eQLXCDg3xRh/LGLTDLF+ZRYBlP+mgmOQrh1f1Rpgt+fVlIJ7kUXE35qaT0=
X-Received: by 2002:a05:6820:2d0b:b0:6cd:3ffc:ad09 with SMTP id
 006d021491bc7-6d4420659f0mr388449eaf.89.1790196064111; 
 Wed, 23 Sep 2026 13:41:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491edc59b07sm224104fac.12.2026.09.23.13.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:41:03 -0700 (PDT)
Message-ID: <defe6ba5-2625-4e9a-9472-3ca20b0e1c2b@baylibre.com>
Date: Wed, 23 Sep 2026 15:41:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] clk: mediatek: mt8183: merge the clock drivers into
 a single driver
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Chris Chen <chris-qj.chen@mediatek.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
 <20260917-clk-mediatek-cleanups-v1-4-4dccf8ed98fc@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-4-4dccf8ed98fc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/17/26 7:51 AM, Julien Stephan wrote:
> The topckgen and infracfg U_BOOT_DRIVER entries only differ by
> their of_match table: they share the same probe, ops, private data
> and flags. Merge them into a single mt8183-clk driver, the way
> clk-mt8366.c already does, so that a new clock block only needs a
> new of_match entry.
> 
> No functional change.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8183.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 13fee7a75a0..08e06c60f68 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -797,15 +797,11 @@ static const struct udevice_id mt8183_apmixed_compat[] = {
>  	{ }
>  };
>  
> -static const struct udevice_id mt8183_topckgen_compat[] = {
> +static const struct udevice_id mt8183_clk_compat[] = {
>  	{
>  		.compatible = "mediatek,mt8183-topckgen",
>  		.data = (ulong)&mt8183_topckgen_clk_tree,
>  	},
> -	{ }
> -};
> -
> -static const struct udevice_id mt8183_infracfg_compat[] = {
>  	{
>  		.compatible = "mediatek,mt8183-infracfg",
>  		.data = (ulong)&mt8183_infracfg_tree,
> @@ -823,20 +819,10 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
>  	.flags = DM_FLAG_PRE_RELOC,
>  };
>  
> -U_BOOT_DRIVER(mt8183_clk_topckgen) = {
> -	.name = "mt8183-topckgen",
> -	.id = UCLASS_CLK,
> -	.of_match = mt8183_topckgen_compat,
> -	.probe = mtk_clk_probe,
> -	.priv_auto = sizeof(struct mtk_clk_priv),
> -	.ops = &mtk_clk_topckgen_ops,
> -	.flags = DM_FLAG_PRE_RELOC,
> -};
> -
> -U_BOOT_DRIVER(mt8183_clk_infracfg) = {
> -	.name = "mt8183-infracfg",
> +U_BOOT_DRIVER(mt8183_clk) = {
> +	.name = "mt8183-clk",
>  	.id = UCLASS_CLK,
> -	.of_match = mt8183_infracfg_compat,
> +	.of_match = mt8183_clk_compat,
>  	.probe = mtk_clk_probe,
>  	.priv_auto = sizeof(struct mtk_clk_priv),
>  	.ops = &mtk_clk_topckgen_ops,
> 

It looks like we are losing .flags = DM_FLAG_PRE_RELOC from
mt8183_clk_topckgen. So there is a functional change. So not sure we
want to make this change or most of the rest in the series without
better reasoning.

