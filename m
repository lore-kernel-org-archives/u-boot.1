Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45AF606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X3FYx2GX;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=iYU0b/8J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A496B60730;
	Tue, 20 Oct 2026 19:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wz3m_PH5Ketc; Tue, 20 Oct 2026 19:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5419260773
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792523157;
	b=WrkBaJxX7EZ6ggsK+FrFbFVJcg2Q5jCJ+MU8FPeO9CL/mow2NYO+Utjke5lKij1bZqwz
	 2yNzPUTq6JIJeqV9jFMd4jeRcbXSIs6A14fkPfMn4B2pgLfcKAV/8EYcArGeL4jrTC9qQ
	 kc9ItgxmTSM8yWPPtZfprs5DTGwQRgO2f/IgiCzs8fFHepSF3Q3NtZffQfaaW1ruE38st
	 DTn0WAyl33GSAnimiCmg7msEj3L+JI6YDBZk7RfwgP3M0ZMm13oRWHJ4PQmsUm8o6lEgl
	 EyTiUGLYrjw5SQBuGSJC8AaUXiaYfAj3MG4P/qHtMYXxnNttIl3Cr2A4WAOx23dE/BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792523157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E5ku/GHOugBlg7l6QIpVvozxT2WONfOUQpHpyCRsUnw=;
	b=hDs5txrSCQvNYhynKwsrAC6Rq8LypZCLfqw0Vi0Ies4adU6eZFIQ5qV3UEzOm0erKaRF
	 Z6c3IVZyBUN3uH/d546tPkswEkJ+6eJVzY3ppTvPz8ovG/eF8KasBFukeHMVQUnui+HUa
	 HXbwVjflgFmo3V9NToMGm2auaS+Iqmbp4gJD6VTgLWZ4GF/R2M25WYM/b4SQcGgD9ZDDb
	 4fdcA98uuKo1nnO7sPYAFklOHG35QqM2dJvnT4uHDQ0zL5QeOufs/Xa+JX1Pc7jRknanW
	 WbD5GL2OEKwNOao9wdXgbpXGe1f2fo+NcPcMNAsZBKfvNogXS7o+6NC4ayW2Rus0BCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792523157;
	bh=E5ku/GHOugBlg7l6QIpVvozxT2WONfOUQpHpyCRsUnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3FYx2GXIBSTFTVHX2Te0nzBq1i3c5/+45UDqHr2+ekkGwTUfvDdhioi0fsXwN/NI
	 hIGBKHkMGywV9E7/fbKmeyvxSoAOhyi3enlJ05snmvkUDsKTyrS7yDfs57e4UFAxnr
	 Fe/Ec8/lYlhrAvMXR38sHaJdJUbjNi+nYalazdRW1NvVPVeVUGjXvINkUoYnRpX7Nm
	 5Q4NGK7RfAzLOhcVPCckQykaq6u7otzbJAEy1Kkq6SB/tfZ1U193yiLhNogBQq9sfu
	 0IIKpqY919rsQuFBiOoegO62JTI2aNBaLo8DB8IKSh4r+GanqWLbzKxwnlzrUzSrkQ
	 eM7rdCOOxu5OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5419260773;
	Tue, 20 Oct 2026 19:05:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E537255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F4A6407A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAZ6dOV-suHI for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A31DC40775
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792523154;
 b=jsJGruEj3DEj/9xSorA3NA+rSqSGfnQk3i3aD6o1gE//SP09lihAC49POpcsjqclRMOk
 QdsIWl/b2v//auch7vx32o9FdqYpTiEDL0cwyEkx1keKZvdSGf2U18u4n6vAt+8PxWQDx
 kys560mbpfCMtwZSaq/+FhoBcwryvqPeIyTpg1Ltl2dc1q+rtnoYSkwp/DDgurD8kWYNb
 wVWiuGjV99FJ8wO2NTlD2ExStcTu2ZTGkg+qyELtRZHlGYY9zIo/zWbOsJEToCCDNIgEf
 8pIxfAGUd5ThB4hR+Cqk9XHZ0VV9/BTS9/61P50OksYPE594Bz/YDCKAUl/SxE2yeTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792523154;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=E5ku/GHOugBlg7l6QIpVvozxT2WONfOUQpHpyCRsUnw=;
 b=K9DPiXx9AKV1C34upQCr2zITUOGpDxvUQNMG9MoKWYtb0+mKS13j6sW0HdVZtiHkq+1E
 e3HPdQaDbMHdvhoFLQAA9zEiHEYu+zw6BpPHtHht9bhqgvJlB2DmpFNB14qiGU4o/w3FS
 SjeVNErwWapCIHxZndfrupeqXPW+JcMr5mKF/OM0QwdcDPc7CgIlsrf2wOCdmeJJBPyH2
 oTdRZy5W3M45NHPbfX/Y2wlRXHzAEMV0ovAU1ppTa5TS07xVOTDk5YZBZ6uUTIJedWo3y
 sMvAaG5SCQ46/nsinyexV00ZUOX7Tj8H+pxjqQzWe8Gif7bvuSBHpx9zSB12I5cPytw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="iYU0b/8J"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=iYU0b/8J
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A31DC40775
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792523143;
 bh=E5ku/GHOugBlg7l6QIpVvozxT2WONfOUQpHpyCRsUnw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iYU0b/8Jiqo5Sq6fR2ays2574wa1Surz1t/qlCxd0ho4O+nVKmoCF4MeKKzciM3sk
 3jNsFgr0u17l6wPRZnvrSGj+lkl4HXIAj9tylpA09Zi9Sr1/WgmbUYqbUpz0xmlsdW
 w2AJywUxbbO6lgdLMqQPh078cXjCQa1ZeFCplipdVciH94JjQ9gONNhGKRyHeUOH6j
 a73A6bkVQw3Qm9Ilyh1TKP55bRGRQulNP1XJqSUsai4TwqD1j1L3wizsK5ttUlpdMT
 mBLNBo5kLh7477/YaZfG404X0Bj4Hh6cIRHEmBjwEQSn9syyvRr4VSF4lahr4tPIkE
 bOmOCeRXr0uvQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5D4AEB221DC7;
 Tue, 20 Oct 2026 21:05:42 +0200 (CEST)
Message-ID: <2cb12d28-968a-4198-ae70-4490f16b84f7@freeshell.de>
Date: Tue, 20 Oct 2026 12:05:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: starfive: enable mtdparts on visionfive2
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Liang
 <leo.liang@sifive.com>, u-boot@lists.u-boot-project.org
References: <20261010084940.62326-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261010084940.62326-1-e@freeshell.de>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/10/26 01:49, E Shattow wrote:
> add default mtdparts and mtdids consistent with jh7110-common.dtsi
> ---
> 
> This allows us to update the documentation to be slightly less likely
> that the user would type the wrong offset by using mtd part names:
> 
> -    loady && sf update $loadaddr 0 $filesize
> -        StarFive # loady && sf update $loadaddr 0 $filesize
> +    loady && sf update $loadaddr spl
> +        StarFive # loady && sf update $loadaddr spl
> 
> However that documentation update is planned for after the mtdparts
> addition lands in release. It would be preferable to derive mtdparts
> layout at runtime from device tree; if there is some way to do that
> sensibly please offer some advice how to do so in the review. Thanks!
> 
> ---
>  configs/starfive_visionfive2_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index 45de1c1cb671..2bc39593849f 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -78,6 +78,9 @@ CONFIG_CMD_WDT=y
>  CONFIG_CMD_WGET=y
>  CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BOOTSTAGE=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
> +CONFIG_MTDPARTS_DEFAULT="spi0.0:960k(spl),64k(uboot-env),-(uboot)"
>  CONFIG_OF_BOARD=y
>  CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
>  CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
> @@ -107,6 +110,7 @@ CONFIG_SPI_FLASH_EON=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_SPI_FLASH_ISSI=y
>  CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_MTD=y
>  CONFIG_DM_MDIO=y
>  CONFIG_DM_ETH_PHY=y
>  CONFIG_DWC_ETH_QOS=y
> 
> base-commit: 837387a5aebc5cd53b9143926891cec024fcad3e

Signed-off-by: E Shattow <e@freeshell.de>
