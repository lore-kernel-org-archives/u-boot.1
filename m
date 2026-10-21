Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA915606A33B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EWYB7/8j;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSTyJDR0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A6464051C;
	Wed, 21 Oct 2026 08:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_8v7-E30-Og; Wed, 21 Oct 2026 08:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8D3840728
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792569684;
	b=siQCLnH0BsOt42jK3rCi8sQfL0l1A3CypGPoFs2YmNkDYjT1UwglEPsdAnr2aa0fZKp3
	 9e6Ok7gAqktw5uckRvxRbo3Ia1MmPYNZiugN6sJZ4qnBlb+QtJmYs1uGIbiyQgVRaMMZH
	 bVs5A611oUAAN9263HhOicowTWdOXVSi8utSRWe+kxYZzu31kTZIFbioLhbRz2z0bgVZM
	 5lqoR/9pOLH6X5v2J3626jZpcYoPggKCvLJkXnYom/eCDhxJ379e3182/Rb5B3NnPtZhl
	 Fuc7xrTo1vFFsIg0slztQSlPNSIoZrrJmznlXUyLZhDSDu5RzxMvAELaJy3/MZG0+dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792569684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NaJ+mb0BqyJ5ZQygBKC4Hb4pDg15HxXFUlAgfN3idgc=;
	b=KAys9dR0iys78ahVRetZGW/i3joTdoJVQzAUeKfRngQolzeGUYI90mNqQDhpvBDpeGeM
	 dFeeAly3yPXtpCLfjlKCYNvWliW2elmV645MIMwZmOGkmPJWrrxnsCOtfjGU+H47mBuTm
	 GUKpAAuuEDGzdMSwm2FbxrAcXznxRsqa3XanDjvCBLLMCagpB9KIJJ6LCe/aE8jSeA9mz
	 vcHuZQwLZT56YqGgpsTr2C9Fi9rXN5HIYniW9JiJijmjXZBWHaf06xEGOg8VvtElvOoyk
	 FB4mh60VVNZUzRjjsTHLgOylrbitYXUkxHazN0dS0oQgfmWSgauPSu75bkx5gRxVOVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792569683;
	bh=NaJ+mb0BqyJ5ZQygBKC4Hb4pDg15HxXFUlAgfN3idgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EWYB7/8jeXSjnr16RLsfSpMAvCTRWP+Wxe0RGBOeVF3vjE8gcO2TmvrbjAxS8ZXrx
	 BrMLkl67pkVjU1NBYeP4n+QuVEh1J7SLkZYtd4rGwzwz4K0BLKcaXXgaNMyQL3r9m9
	 ZFnHJf0riOQo+xayPh06kaFBcD0MorqXVfPu85VXBeekCVS7gz3kYq0b+oVoSGEfbm
	 PRLuF4yHPcKxraB8wN2EcUu5bAVk7ANQMSxpeiJG2cPHBzM0KEG1lWH/ZF/CP22qDp
	 tjousn/o/tLZzcIHNRdF8ftU93ZE7O53IKgjdiX2urTVKthhvZplpHhFRH9RtnxV/3
	 umUbpkoL6UflA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8D3840728;
	Wed, 21 Oct 2026 08:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 040EF769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEBB740060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6i_eRWIkEbL for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E9BD40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792569682;
 b=frm8HeEnxhAI8Zyxxq2lnBKQlmbZ/NNk7ZHmw3H2TXTCL6z/G8rUAr3RDryKNfD4QVUP
 4OAdO0mI61mIDnJBG4sLlQiiUAnHZtNtJqQekDTYUZydfVbDqgMPRns1s94JPirkMSQe2
 r0CjYSN1dLXHBJJ8EMUpCI/5ndPgtqLq59mBWhi2vT8HdVBHWPhfMqUY2B3nDpk+wkoAd
 7otiMzrOPpSLmFKJAqAnVoGlA5EthSceYGP+xYU8ueInSmabDcDo+aAmuaQTORnH0nlYX
 Ot1rpyzkLceSVp2cxCek7VBFuC2o5NZiiS/KNg9jApr3JEaX+pZtkd8D9ie6xvyufrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792569682;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=NaJ+mb0BqyJ5ZQygBKC4Hb4pDg15HxXFUlAgfN3idgc=;
 b=SHs4BhxXlO6RebFHctctBRuTnXST7qXlnQX7YR+VzQ23ylLSt4N6QuBAf3VbnKUxmTVI
 XLKgzO8rdlCVWXbmBBt10HtCOWrRwzPe4heOSNJXjRchCk4oDF60RkG299SVDkg9Vvv2x
 8BwlnsP1+oxa8rOVswVLS/BWVi+fPPJvdbGkYHls5y7rVAZDb5cXUswNIKZ56OoWbiN3j
 1xexiulzeRtasKI+YrACgO8uqt2kUKDhkKGMk6cj7GXxE9hW87tpggk48gt2sZItASW22
 duKPHpUHG8UfUSMhUCITalN9gA1Zz1ubQfd//90vr4BGVDiGezRr0MHIwgZYeQf/VRg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MSTyJDR0; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MSTyJDR0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E9BD40050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:01:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80E7340796;
 Wed, 21 Oct 2026 08:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFF31F000C9;
 Wed, 21 Oct 2026 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792569679;
 bh=NaJ+mb0BqyJ5ZQygBKC4Hb4pDg15HxXFUlAgfN3idgc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MSTyJDR05HCLmIoZOiYDZARJXhODCnscISJP2VHp3yZ1//O17ExjUzb2iCwovMqNZ
 3ZhhMPkyXxIZDHuSO/ro4KT7EUG4tR62VBhsXcZAdzI0CXIDXnY+WWi/qUKLsPFwSC
 k0CRaTSN0EMyLnkx5e8QqrgEEkFaVR0B7EpcxgSNyHECIJSot6paXAnsJFlnv0QezP
 Dsg/FuiFLqmgLifxa30uRG2B6tsX/tGdQ811z1ftdqCTLh1EZiX5MCvHHQhd9++kJ/
 F+KcW4JVvTOAzA0rwznE5tTMYkUT7cmGDZrNFEBTJtluj9g3HK/d7U5yhfhso8FzGA
 D9Sbb7wvsgRPg==
Date: Wed, 21 Oct 2026 08:01:17 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] configs: spacemit: k3: enable spi nor flash in main
 app
Message-ID: <20261021080117-GKE65567@kernel.org>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-2-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020195126.1325187-2-e@freeshell.de>
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

Hi E Shattow,

one more comment

On 12:51 Tue 20 Oct     , E Shattow wrote:
> Enable sf command and env storage in SPI NOR flash. SPL is not yet
> upstream so this is only in the main app, and depends on vendor SPL for
> clocks setup ahead of SPI NOR flash probe.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/cpu/k3/Kconfig     | 1 +
>  configs/spacemit_k3_defconfig | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
..
>  CONFIG_SYSCON=y
> @@ -44,6 +48,7 @@ CONFIG_SPACEMIT_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>  CONFIG_MISC=y
> +CONFIG_SPI_FLASH_WINBOND=y
I've also tested on com260 board which use GD25LQ64C chip, same 8MiB
but need to enable CONFIG_SPI_FLASH_GIGADEVICE=y, the patch 2/2 also
works on com260, so I'd suggest to make the commit message slightly
 more generic? not specific for Pico-ITX board

-- 
Yixun Lan (dlan)
