Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA4606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m9yrmJcv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEOYeduy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7577810E8;
	Wed, 21 Oct 2026 06:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5uC6YHZud_1; Wed, 21 Oct 2026 06:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4754810DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792564004;
	b=liMN/zrxCUJCywr0quIvHRz9hxV6yei6Fou2KXPheNfICFCRRHLKDjAxD+u7BOTiwvt/
	 4xrFYYwZfPKvINaHXewyRlmaRJ0kguwY2qtKH+PxKej2v+cwWhBe6pMqz6P9Xa9f1aKrs
	 MGHEQ98FvnkZU3dUs7p1Z50DriRyUn4yyyT14mSiLhbwC6lRhAOZ1KZcpohleiGJsa8x0
	 rswddP1H5UbZlLocgm0qgSwzOKhSoai7mqKwHAYDVxtI1JDGkca+rfIUaA+kmQgt2o78C
	 YjN5cnuC7CajL+yF14/EovGccqPT5Gc93kYkkbenxgrF7uzuqXbtZ/FmsIb9DEuDceA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792564004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t4dlu9Ub1cInduYTCndyoS83B2FM3z7nRLJgWbo8i9M=;
	b=a1u40fFO11dLzCzg7jJ3RCkBb2ry/+lxFUBz0jC0IPo97ASQ+RGZUVePjNGaMcbsg/ug
	 twmrtymffCpW48FigibFUTUvPXwoEYoKObGhOa963YH0vdJQsVZBoAgni+gme17dPNv9x
	 wgUIq/j5zXhaLRm5nFH3vc7xU/XRwe29nLqsEvUS7KNzLn567PK4WzODuCbnIfwVx2ylQ
	 hgOHLmbHzvYfKDYzMs26N6m9swPdxg+enDnP079Y55xjFQtRq320W0AocNmu3ssqoshi5
	 MXXvFahJ8YaoDiixjQ4wWn8unojhb2DZKo70807sSX9bzQ4zRoNun5C5R5AZTfOKPWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792564004;
	bh=t4dlu9Ub1cInduYTCndyoS83B2FM3z7nRLJgWbo8i9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m9yrmJcv2WF6ViC5SkV1DR34FPJwv/H7agGY1pHZOdyMDwA3yBFYsI2HAP/wGoyk+
	 0wAFIik5XdljlOXGU3ELfG78QjZfNAkNOX42m0w3sb6A8BGAFUX60nyj5WlWKEcgRB
	 RQs/RGopDehEDp+lXHeNlakUT6nOIUOO79vSv+PaqK558epy08XezE8thliP+eoWUy
	 2Da8HFb4wti3oz51+VH+l0FGbONpSvcfEy9n2Ongz84qRPwzlPjTSCGEsU4lDai/Sp
	 Vx1WpTeOSgoidDr4duRP3hHasEXdPzS1xLwEYiwpgTH9R9SUKibJNCb8YoslYmgQGl
	 HVVjhJSmYGNdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4754810DF;
	Wed, 21 Oct 2026 06:26:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 091FE3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFAB460762
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KlnGhZrqPsZ8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7215060755
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564001;
 b=R+50ZI/AzGU7qNN/3OXMeqXJ+RBBzJp/WlIKYosDdzSDE9wXrNVxt3qKEdLd/17DwoCK
 nB6JyTO5vzwD+dzEe9saU32deh92OZ/lcWJM0xKxHJn1z/5CzdtTR46Zv+AMfQETsJb6F
 PgTHRFnAyomxpeXvL4Ja0lkH57hxzq4Kb8SEsV5omCdA/gTChP/tOBHgjTcOKOeTewj4d
 wl/aY2chVjqhg1YfjQcE+MzSdvbJ5P9hgekqpNDe3oFD0jNd8RTQ2ziOaIQHRWC869Uti
 Gem3Qctn/v6TtoXNg0NhuRtK8rmgaPBrcuhzg3WejiOHITwlszJO4jdagsT513wPD0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564001;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=t4dlu9Ub1cInduYTCndyoS83B2FM3z7nRLJgWbo8i9M=;
 b=COkQ1GIcVyAU6cnUhSnrFrrzHAZfpkp7EQfjRoMSOnMcpByRmVYJtkCwdjyt1F1FpeC5
 YMnQySoxMj3s2Uyt8+R7gLMdWbWZrH9em0uhifEhpYvE4xLtu4RzGhXuQK++qwWvFcs19
 MOUOiu3j9J4S45ffo/VGuYhiWbOnjpPPNraph27ghf9WYiGmkCLT0Xk2Ss5D27TFMf2xQ
 kKSo4hfRxeAXsJ4zNDjEi9gwoOwcSBUCFeCOohVBsfhGcGqi3dcxwpTveIlIXwcRN9wXI
 u7QPGlXEgLDv/7iCEfgC9MZMTGrZw9JxfEf/5acWg0qDzObxlfZr81BJtvlh5KKhgzw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DEOYeduy; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DEOYeduy
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7215060755
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:26:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1233D415CB;
 Wed, 21 Oct 2026 06:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795E1F000C9;
 Wed, 21 Oct 2026 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792564000;
 bh=t4dlu9Ub1cInduYTCndyoS83B2FM3z7nRLJgWbo8i9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DEOYeduyTmxA23GUeIPwr1EZ1PKyZIx7Rg0YBB3kgichAObpgy7CD79DaNnmnVBnE
 mayMghL2kx/OovVp7N24U/PoYcQQfbLVCnCr0fq/s7IvMTCymQB1JGAxupIqD2zy1j
 3RS8jgFBrrZA1/MbFBdBJdgzniT6hx5Ou5nb88AClsdUrj/J5J/eFwlT9SLIbFGFNQ
 5YSakGLHIImDZ14Nugp8y+FRigrVMQiHMPGBKGIJNAhgyIb1RAJ7kIj/oYsTv53jEU
 iPtlvhp4dYNzD9fxWZgouiuzoopwXlDG+s7g38E+qfdcK57a70Z4n2ALmwK3VE+1DM
 vbobu9IRL3mnA==
Date: Wed, 21 Oct 2026 06:26:37 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
Message-ID: <20261021062637-GKA65567@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <cover.1792007916.git.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave,

On 19:59 Wed 14 Oct     , Dave Klotz wrote:
> This series adds USB host support for the SpacemiT K1: a driver for
> the K1's USB 2.0 (UTMI) PHY, which the K3 shares, a flat-node entry
> for the K1's DWC3 controller in dwc3-generic, which already handles
> clocks, resets, PHYs, VBUS and the host child for other flat-node SoCs,
> and the defconfig options to use them.
> 
> The v2 USB 3 tests also used my combo PHY series [1]. This series
> doesn't depend on it, and USB 3 on main without it is untested.
> 
> Yixun asked what "polled first and never write" meant in v2 1/2. It
> described an earlier FreeBSD driver, not this patch. That driver waited
> for PLL_RDY without ever writing PHY_PLL_DIV_CFG, so on the OrangePi
> R2S the PLL never locked and the xHCI reset never completed. This
> driver writes the divider first, as Linux does, so v3 keeps only that
> reason in the commit message.
> 
> On VBUS (v2 2/2): the dwc3-generic host driver already gets
> vbus-supply and enables it before registering the xHCI controller,
> which is what Linux commit 764c2e6e60bf adds for the K1. The R2S
> device tree describes VBUS as a GPIO-switched fixed regulator, so the
> board needs CONFIG_DM_REGULATOR_FIXED, which 3/3 enables, but no code.
> Details are in my reply to v2 2/2.
> 
> Changes in v3:
> - 1/3: drop the read-back check of the clock enable bits, drop the HS
>   DAC +15 % setting and match "spacemit,k3-usb2-phy".
> - 2/3: add Marek's Reviewed-by; also match "spacemit,k3-dwc3", which
>   shares the K1's flat-node layout (not tested on K3).
> - 3/3: new; enable USB host and DM_REGULATOR_FIXED in
>   spacemit_k1_defconfig.
> - Rebase onto main.
> 
> Testing: v3 has only been build-tested. A RISC-V build of main with
> the updated spacemit_k1_defconfig compiles the changed driver files
> with W=1 and no warnings, and builds SPL and U-Boot proper (the FIT
> image needs OpenSBI's fw_dynamic.bin, as before). checkpatch reports
> no issues.
> 
> v3 has not been run on hardware. The v2 R2S and RV2 USB results were
> taken with the HS DAC setting that v3 drops, so they do not cover v3.
> 
> [1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633775.html
> 
> Dave Klotz (3):
>   phy: spacemit: add K1 USB 2.0 PHY driver
>   usb: dwc3: generic: add SpacemiT K1 and K3 support
>   configs: spacemit_k1: enable USB host
> 
>  MAINTAINERS                        |   1 +
>  configs/spacemit_k1_defconfig      |   8 ++
>  drivers/phy/spacemit/Kconfig       |  10 ++
>  drivers/phy/spacemit/Makefile      |   1 +
>  drivers/phy/spacemit/phy-k1-usb2.c | 153 +++++++++++++++++++++++++++++
>  drivers/usb/dwc3/dwc3-generic.c    |   2 +
>  6 files changed, 175 insertions(+)
>  create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c
> 
For the series, looks good

Reviewed-by: Yixun Lan <dlan@kernel.org>


-- 
Yixun Lan (dlan)
