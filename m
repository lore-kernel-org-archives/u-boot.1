Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2862CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B332E605F4;
	Mon, 19 Oct 2026 09:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uW7Myz6yuGTc; Mon, 19 Oct 2026 09:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8EEF606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402955;
	b=Q+9UxOefSSMwFPRwiF16vjGpeep3GPl8rB8gjmLSt5Zqfe8QYI5BsmDYQs2kiQzLofsn
	 D8prvtcrYBeIfcGYwKhSgR9O9XK0Q1uysAwz+BTOGANpxJLff2KHK7+0uega3sKCrSloB
	 v4A1VQ0Ge8z3NUh6hsGPADLV7tg3U9KuiRsOAi9HIFvLy3mhz/NAkkpDASkAW1jwdMZzb
	 xdyA7gHdFITHsFhxmkVVjq+AR4zIuRKuPH5bgNppDCCca+Ee86q4qiZRMpvNFCP0eHygx
	 Zv6S1x5AbEWKCuW9VizLxavTyclMfTLsorpWfMFYenY5lQ1mlowaJz02arLL+/ez9cA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792402955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
	b=iBy6zjUdg38GuZRpKcaU4U7WMoehNHtC5PhWKeoQXRTpTORYicJv5Bz4jcXLTcZ/1qJE
	 Nx6pNTbl1SQXQsRLqKIZflInGIiSqJDBZ2CKwyNZf8CJfX/TQdlTeVMPGg+0ZntNtmb5E
	 tUloc/tkRVwRp/OFEgOSw7sJFPkqaB5mExxVJ7H7eVCDfLiUxd99OtajjgZUiwA0EyKmO
	 zTxvk63YlfMtVrn/WXaHhNq40O90Drabp9EzWKyvkLPwh+I9upURyiS61gczt2Wkua/kI
	 G8unOk2k8b2PFtzX/WjcvKK7JhPQPnjQZfSpWt61FGu4PMBRnZ+kcYBcAFA9NmqfCBg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792402955;
	bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBiCaqYlHE32hImVKDfiiWL/lEls3nRCegpVJmz4ye04NOetnbjWoNYwehcecdOIV
	 NBlFkQ0ZTkoZwYC1yc3NURgkRYp6V2K+PMyoZNuhoh6vsnMNPlEAVXc0veWRxnKDOa
	 SsiFruCd4a4INELfDxhtBJ731JfD94Zg0HJcsIEgwdOuxOVaVgX/2OTxf6h9o3ww0r
	 xZudH2jL//OrQ+KfppiAmVthWJcs9TcOsZ7Y6jG0tk1g3zJUZJMf4m5iAB4MvEqoKA
	 V6S29nA2G2ZnZ30mLYHUTqM08V2rS/EZkMIRYgTxNqBTFpZ7BjY+mJrGYvOXu2o3S1
	 dJTQis1CuA6ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8EEF606CF;
	Mon, 19 Oct 2026 09:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0A1E23F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D69C7406FA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ahQR-zX4ZYU for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36C5F406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402953;
 b=WVmepO1zmimtbWuQJoVn1SXpIw1Gt+fXgl7HsqhsT0FyQ4IedmQYSDL1/2mnUUqs6m+h
 11nDioqhxTrD/d9d3FkylM3J8OrYjM7yQ/6Q3q7QFT4vZGzf/aLRMiN/qB5Dmk00M68N+
 5Wt1rex3UBUs2nhbMRLwAg4boUbPPFc8fEhPMHIbt4PEb2VElJT/NeFoUwxX+ZQXqnCHr
 moSqXfRAefr/kZNp9JOb7BT8uloqPdELsm/egimUHqi7cyUZA05l3PJQYBT8lY6imcCDz
 lh8J8NxZBxWuqtDmtXOJ33EuWrW5SL4PU8Y5AjsYX3llSENqIgAp5szGhrsbZAjpF7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
 b=opPcEuQrkrF5n9MoJSzN1IjZaCpvNQ0dsxspJKVvbiIxbPuGhsgtLVmnH+OrOr9pJHQw
 jA6QX6vKMlYL3izjw42Urb7GclWkDK30Jc6BATxrX4BdFvdD+NXx+MaqTXK2FD2z96MAy
 bKaUr8rEcW/s9kR5ud4BC6+S3xAcX9w7dnu5JJKCbCfGUyGYp7T1LQKiszWuHD4spP1Px
 Qg/djbGYKrL1q0e/fZVKc3+bqNqv8YnMGO478YWFkHQghZ6I+fE6KrlbNbZ6dplcJ5cvb
 ou80moCCwJpRfFCRVS+3Q7cwrA7Y2gD4qt8l/pPgsdst/Yx/eXrnf1dkPphbmRu0v/Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=MC3pywpm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=MC3pywpm
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36C5F406C4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:42:31 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5be3cff0f6cso1323128e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402949; cv=none;
 d=google.com; s=arc-20260327;
 b=F3GAlHWEjdyU9GSTMU6LR/9H9Zr3sXjeh7HDqwqmuZXCxA/mT/rkaPisLBxeWvBqvJ
 pWLC1UO5LjDV61bpbVC+OFMI6GZ6m+/rBrmd5Cugdba1Q470OaHP/oBxR2/4LccCXH6S
 7ciRpKxeXHDZ9JXDdImHBrxGE1cuodA/JQiuN8oO9STQWlFY3sQ5R6HqCAI6HaASwjec
 wTfONw4yh/1jB3utQUL7K6zQ+Nq6qVpNU0rsfLx/v/BaPIYgkFZnRj78d7/acrA/nwtZ
 nZyzImpA92R1cotJRtYmx4RJc30DQIRCjN4m7oSmFVgSjl/k/NLGd7xTnPIV9jV52J/C
 6ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=rinzLtILDV9c3o4PTvcvmFrjphEttusdgz4C5ZRJXvJng3OaSCco4MobEa7hfIPF2F
 RMIBoeYrS9yzJSe8pe3Cc/tUy9g0MOGcA7Z/zsLgAUji5WKw1HV3BEjHvqlMfmQ/jbH6
 GSRsdHNxhOi06RC+7vmEiHJmWt/bUmYCkQC0NPd/UwupVSAV+r2AvvUwp6m21pgRNrI4
 rkTBmCZrgoDAdrtcM03637KWIGLwHFzBwH0sm/89gVnnT8VqozWWI5p5zFb7SUWlyi1p
 58Vd+jZeQE4jkh4IJLXjaf3og0PB0AXfJEFq13thHQknoOK2ihkKTxEaDAwtFt7XIW2j
 boNg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792402949; x=1793007749;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
 b=MC3pywpmBoisW0CE9ehkg5H83i+PKciCyJIcAo2IDSq7gIPSYrf38uhyYuxcEeFFcL
 Kr2Bn9t0HiUx7NPQmnHibIj1wVFSm0AoHscuDMPiDzela1a1HQdJVpbUGAhqJ9CRue/D
 RME/5RD3zO+xot4/q0bB6cTMQL3QaN+jT4Dt78vGcZYEgUMsxiEpyMJcPRkx+hVrsZIX
 bgrPVq/DvcRaF6EbFZhhnreM7CQNPohB76fq45qcA32jPtTLT30ZhVEWdKWvoj3vXw89
 ++dEelWWvcyGoDbSAY27ezMmEyWuERFZ6XtZy468V5AqTfAswwrevgRy0WL9dBpjtbfv
 jo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402949; x=1793007749;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XMNQSj3jl1Oyf8jykV9cWB99hDmIFYYov8siTvT07Zk=;
 b=RXzzwLiCyWSluxZDhwt+hNZEmsrmjh0yXLubf0L/GdvsPpTJ0aVd7+lL5/FzDmT0sy
 ctK//j+5MEd5soW5/XgytBghK0hNqvYF2rg5vWw5IRTG0fr3wZ+qmONolZ4Sc4Kgs30t
 UPfgYzSSUL2TCoRNklTjG/KrhERUOpmAHmmyJtP3yyzl+9oJmJrYSXp23Dl6IG7E+ldU
 K3gcwZp1WhVqA0I2PaR5XtYeHrSq9zobGcXIc9aAa42+/En7MzXWl+pRmiWtd99j8EIW
 E7FJ6ORRNRnbWxdt+rdx9GdqZHjfDFOvLP+ktUIIXzmExxLJElhsS55NJt7EzEuviibX
 BLJA==
X-Gm-Message-State: AFq9FYJkJ0iCB6aS0QPfTDQcRPFfjP9LWkVuryuo43POQ4epCyVy4qPc
 UDbmZ5ND6VbrIMErzq+cqh31voZpwnn0PCsRqzz03wpV3BuydnHJOeLlsPA9GTTKF1ldQNaaZu5
 Q8ki+ZD83/ZJ4Lpd4ZvijxlASciDlBP6RUhpGdUJ+N+MrKpwkx+N2Rjw=
X-Gm-Gg: AYBFou2eoyHnAxXPYZU1KafnwPue4WJNmKu7WgoyMWTskVShJdielTgqudm0CJQDyYE
 Fbd7dpu5Ti1TSIGy4SWyBnk9NHjeB21sR6DgMtfCpwdR+760HGYscvK8NSMRS4uwJI4uSfLiHmC
 R2Zu7jrMc85R6r88CCHp/j/miv9DFfWHWqmiEHKqnrICPbjCp6VSaeQ+GptnFlgCejVZ6ASTNdF
 b88Ze3spBsvMhoNjuCZ1rBURPO2hgfH3VDWOnNlHc7alAcSQdvzr6Q+aT4SbadAaOU5eC/B325B
 XcYSU+XSsYltOWhkSGEOa4FDyfPrLM7s3F0h6I7esoxZWMRcdiFauzsamIzzN1gvm1iG/n+tyrV
 6PzaiR16XICeMMp19JPNb7gCx3uhHTIHnsst6XdM9eGSg8irYrCrUnnp5p9nbqUM5X50IeI7INW
 8M5g9+BgRkqhuo
X-Received: by 2002:a05:6512:3b2c:b0:5b8:ef97:e372 with SMTP id
 2adb3069b0e04-5be50a7518amr2540352e87.46.1792402949212; Mon, 19 Oct 2026
 02:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <bbfa4cbc6c21effbb507644cfa94cfbad4ab6d82.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <bbfa4cbc6c21effbb507644cfa94cfbad4ab6d82.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 17:42:16 +0800
X-Gm-Features: AclHuK-f8Cv28HbtREt40_NVN_z_JRJ2lhoBk2CAthmOVaMI6KC363PGAC-2XeM
Message-ID: <CAH22mJzaBuRKSL6o=u00vRd-L0s0eq9kqzHJo+j9pw48Gj2sdw@mail.gmail.com>
Subject: Re: [PATCH 6/9] pci: spacemit: do not force the link to 2.5 GT/s
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The driver writes Gen1 into the Supported Link Speeds field of the root
> port's Link Capabilities and into the Target Link Speed of Link
> Control 2, so the K1's 5 GT/s capable ports never train above 2.5 GT/s,
> and an operating system that keeps the root port as found cannot
> retrain them faster either. It also writes them at the fixed offsets
> 0x7c and 0xa0 instead of through the PCI Express capability.
>
> Linux's DesignWare core leaves both fields alone unless the device tree
> limits the speed with "max-link-speed", and then writes that value to
> both. Do the same, finding the registers through the capability list,
> and drop the driver's copies of the speed definitions that
> pcie_dw_common.h already provides.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 48 ++++++++++++++++++++++++----------
>  drivers/pci/pcie_dw_spacemit.h |  7 -----
>  2 files changed, 34 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 3394ddbd18..6ac1d6bea4 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -40,6 +40,7 @@ struct pcie_dw_spacemit {
>         struct clk_bulk         clks;
>         struct reset_ctl_bulk   rsts;
>         struct udevice          *vpcie3v3;      /* slot supply, if descri=
bed */
> +       u32                     max_link_speed; /* 0: hardware default */
>  };
>
>  static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32=
 offset)
> @@ -58,21 +59,33 @@ static inline u32 spacemit_pcie_phy_ahb_readl(struct =
pcie_dw_spacemit *pcie, u32
>         return readl(pcie->phy_ahb + offset);
>  }
>
> -static void pcie_dw_configure(struct pcie_dw_spacemit *pci, u32 cap_spee=
d)
> +static void pcie_dw_configure(struct pcie_dw_spacemit *pci)
>  {
> -       u32 val;
> +       void __iomem *cap;
> +       u32 speed =3D pci->max_link_speed;
> +       u16 lnkctl2;
> +       u32 lnkcap;
>
> -       dw_pcie_dbi_write_enable(&pci->dw, true);
> +       cap =3D pci->dw.dbi_base + pcie_dw_find_capability(&pci->dw,
> +                                                        PCI_CAP_ID_EXP);
>
> -       val =3D readl(pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
> -       val &=3D ~TARGET_LINK_SPEED_MASK;
> -       val |=3D cap_speed;
> -       writel(val, pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
> +       dw_pcie_dbi_write_enable(&pci->dw, true);
>
> -       val =3D readl(pci->dw.dbi_base + PCIE_LINK_CTL_2);
> -       val &=3D ~TARGET_LINK_SPEED_MASK;
> -       val |=3D cap_speed;
> -       writel(val, pci->dw.dbi_base + PCIE_LINK_CTL_2);
> +       /*
> +        * Keep the hardware's supported speeds unless the device tree li=
mits
> +        * them with "max-link-speed", as Linux's DesignWare core does.
> +        */
> +       if (speed) {
> +               lnkcap =3D readl(cap + PCI_EXP_LNKCAP);
> +               lnkcap &=3D ~PCI_EXP_LNKCAP_SLS;
> +               lnkcap |=3D speed;
> +               writel(lnkcap, cap + PCI_EXP_LNKCAP);
> +
> +               lnkctl2 =3D readw(cap + PCI_EXP_LNKCTL2);
> +               lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> +               lnkctl2 |=3D speed;
> +               writew(lnkctl2, cap + PCI_EXP_LNKCTL2);
> +       }
>
>         dw_pcie_dbi_write_enable(&pci->dw, false);
>  }
> @@ -105,12 +118,12 @@ static int wait_link_up(struct pcie_dw_spacemit *pc=
i)
>         return 1;
>  }
>
> -static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci, u=
32 cap_speed)
> +static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci)
>  {
>         u32 reg;
>
>         /* DW pre link configurations */
> -       pcie_dw_configure(pci, cap_speed);
> +       pcie_dw_configure(pci);
>
>         /* Initiate link training */
>         reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
> @@ -315,7 +328,7 @@ static int pcie_dw_spacemit_probe(struct udevice *dev=
)
>         pcie_dw_setup_host(&pci->dw);
>         pcie_dw_init_id(pci);
>
> -       if (!pcie_dw_spacemit_pcie_link_up(pci, LINK_SPEED_GEN_1)) {
> +       if (!pcie_dw_spacemit_pcie_link_up(pci)) {
>                 printf("PCIE-%d: Link down\n", dev_seq(dev));
>                 return -ENODEV;
>         }
> @@ -380,6 +393,13 @@ static int pcie_dw_spacemit_of_to_plat(struct udevic=
e *dev)
>                 return -EINVAL;
>         pcie->apmu_offset =3D args.args[0];
>
> +       pcie->max_link_speed =3D dev_read_u32_default(dev, "max-link-spee=
d", 0);
> +       if (pcie->max_link_speed > LINK_SPEED_GEN_4) {
> +               dev_warn(dev, "invalid max-link-speed %u, ignored\n",
> +                        pcie->max_link_speed);
> +               pcie->max_link_speed =3D 0;
> +       }
> +
>         /* Derive port ID from DBI base address */
>         pcie->port_id =3D (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_=
PCIE_DBI_STRIDE;
>
> diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemi=
t.h
> index 6f198f7d58..21686de246 100644
> --- a/drivers/pci/pcie_dw_spacemit.h
> +++ b/drivers/pci/pcie_dw_spacemit.h
> @@ -12,13 +12,6 @@
>  #include <linux/bitops.h>
>
>  /* PCIe DW common registers */
> -#define PCIE_LINK_CAPABILITY           0x7c
> -#define PCIE_LINK_CTL_2                        0xa0
> -#define TARGET_LINK_SPEED_MASK         0xf
> -#define LINK_SPEED_GEN_1               0x1
> -#define LINK_SPEED_GEN_2               0x2
> -#define LINK_SPEED_GEN_3               0x3
> -
>  #define PCIE_MISC_CONTROL_1_OFF        0x8bc
>  #define PCIE_DBI_RO_WR_EN              BIT(0)
>
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
