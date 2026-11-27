Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA96606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VpTC+zMR;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=GnkgeXdz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E3CD40925;
	Fri, 27 Nov 2026 11:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cU2CGXhnuoKl; Fri, 27 Nov 2026 11:40:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6719F40913
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795779652;
	b=r4VbzZRBJryfp0s2oOZDTxFIss9FTMRq/zZdiR7ud04rSUv2SbVq8Ha5+hal5V9dXvIj
	 X8T2qjq0QXumuVL8pcXF3XDHkUYF6goUVH345i7QmjDpxgOwFoGONk6pAeCPzz6nn1p1L
	 vcbEadVhYujD0ofI9Mmc2OesFMmBqb9a3qQFEkafD8MlDxO1x32+YAFbU0BJuJ4/weEdr
	 6gVVn8YKcVndyExaZNSPxsLsLsdEqwXX18LCxm0GZxYTXCZ5kPqB1DxSvgScGEUDEy1s6
	 K7jUbEDZ4Y04f72HTK6+4QKpnU8H3ZDhd/5Pt6Yl1fdhVQt5zgssNEkyRlVMSoDZ9PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795779652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cCUBm7M05OPM/nBhqld/D8wkgdKiqpRelj2P5+X81Ds=;
	b=BxG57wpYMcvxlzl3u+gL6BXOsOzUk1TpVWeocWFet2024Rr20M9hUj1a42TLgaboQFPK
	 szU8XcHiIufffa1Pp3pY0nxV/yIEqlfEpC4ZLmDxEtNSee1ZNQMfjlThKCXa1h/2OGMUT
	 82vD2FF+TpPEUI6+R+HsMML4vFKBE7lxgnpD5TnASE6zySXkXTlToP6kL9NvBzNpqmxqv
	 d9QaczcLpr+lTDmR2MYFnTW0HZNbjX/T5g53y7BY7ZBnL9g/6z73RL53qIGMkaN9ODhR6
	 ZBXTTuXr/IeSqLWaAM2Vw5eh1ULxrNtXuPndODn3tmQC6mdENZZXHac23lNKiJkDF9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=GnkgeXdz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795779652;
	bh=cCUBm7M05OPM/nBhqld/D8wkgdKiqpRelj2P5+X81Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpTC+zMRznmKte7bLwL338k93XS18u8fm0+OwuNx+cuz/NStTNz0pIwzm5bGj2z2Y
	 lFN+69xJu0YWcW2EP80qfCUtwN2WRzDPXosQnuE8Ua703IdQGDVcDLz0/XlpxQmke4
	 gHxFc60nQNkbP3LmtZ3mz1i0uC2tG8/3E59V3joR9TTA1yJjZPqyCXzNkkBrp5m+9r
	 nAJ2QBIzuLuScy3k5T3em6sbi/JwlKDTc8VCGRDcGWoMySBfBFoRxSv/pEIOja0Knb
	 qhLKhZ5tAQlVquE1xSqyx1tJTmB4Hakozw1drkmL2Ah35wyAQt9tDjNaqiYWGYuLO1
	 abm6d4O//pFog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6719F40913;
	Fri, 27 Nov 2026 11:40:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DCD53D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E99C40913
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHBEicjjK53a for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AE334066A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=GnkgeXdz
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AE334066A
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795779631;
 bh=cCUBm7M05OPM/nBhqld/D8wkgdKiqpRelj2P5+X81Ds=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GnkgeXdzhEakqaBhvbc/RdykDkLCtdZyqGkQs4BTbxm4cpEIef2DmRAFi7J/bYuUo
 jIYIOX0sVOw5Hdiq7z10tNA0BKpbq788v3CARTNfqLvl/mr6Mj212npBCFkUVzdRj1
 1s/oeWWGES0Y2oSFwvcjl+YxwvOEjFEslQAeI8bm5oFuv6H98/Suk34qK67aPseUGV
 Nt4EB2q1fENS9OnwvdaFv4DhNgirOR0U84p+KwV4uW/h8do6wW0Klnaj4UNCnMJ1/6
 yAwQeot+PH7G9aB8LL+s/X9JLfoI/y7u2HUccp3T0Q0Tv0x6yswdeJN35CKf+2OjT8
 dhM115n1CXw+w==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B4238B220131;
 Fri, 27 Nov 2026 12:40:29 +0100 (CET)
Message-ID: <07f3c2d9-5d77-4f96-bb6e-5cfa67bfcf61@freeshell.de>
Date: Fri, 27 Nov 2026 03:40:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] gpio: spacemit: Add SPL support for K1/K3 GPIO
 driver
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-7-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-7-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 02:30, Anand Moon wrote:
> Allow SPL to access GPIOs on SpacemiT K1 and K3 platforms during
> early board initialization, including GPIO-based card detection
> for SD controllers.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/gpio/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7f12e39dad8..ac7bd642cf6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -457,6 +457,13 @@ config SPACEMIT_GPIO
>  	  arranged into a number of banks (different for each SoC type) each
>  	  with 32 GPIOs.
>  
> +config SPL_SPACEMIT_GPIO
> +	bool "SpacemiT GPIO driver in SPL"
> +	depends on SPL_DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
> +	select SPACEMIT_GPIO
> +	help
> +	  Enable the SpacemiT GPIO driver in SPL to provide GPIO
> +	  access during early board initialization.
>  
>  config SUNXI_GPIO
>  	bool "Allwinner GPIO driver"

Reviewed-by: E Shattow <e@freeshell.de>
