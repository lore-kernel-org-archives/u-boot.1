Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eAo35jo9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9wK90nO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E834C40719;
	Wed, 21 Oct 2026 07:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOVbBibiQqEX; Wed, 21 Oct 2026 07:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4099E407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792569372;
	b=rEZlKB/3SW42iMUe5FQ796z7y4ODNAMRJ+Lczi62BQ/Q9XAlmREeJ2akYC41KYvt9XK0
	 /4HIUvEzxaO9ugrVO3GhO2A0GKMZF5IGrfrpHXC5HJ+eHuHQtqm2TAigI2hHLMimGNYQ/
	 CpNSwBbXftBPo9vCklAf33ueg9m3ZIHVvFfV9agSbrip411wnEMg8xMrpQeUqLvYxvASZ
	 1DSiCdmwNzpv/YkHgFRGU8pc+Lmi87c9A59trbuHlJDlP0kYRXc6QW6ZUoYWXfMDWkfOS
	 cL5ZrY28eBNVisfO2qNaGaRQK8zO9G/fnOi5OTwOuIBsSPOnNnqdf1Tz1xwh9yAiOLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792569372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qs4moc3PJKKsTvJb6ZEwt0nfnyoBn0fr/AqVOE8EJ+A=;
	b=H/JHbidU/6CHBBONt9Chpkq3e4XgIqkW7PwEfQHRkicmgbGvfUKXrYLYBtszMtmfeeHZ
	 7n4A8cQM4FgBJypqEdiAuPSWrN4NPWKT9CKQJHFIDio2hA/tyw1wSuuVq29K9d7yhYZkz
	 Z0gDjD8P7OwjwozbNW2e4FtIYh7Tg6EBsanuRJw50oxWHGx35qH+e0+GU9HMvd6WbSzIM
	 hTXlJTytlNWtEGDEc95wVmzFkQpqABh06XTMDY7915K6BlOE/1NN6FM619ykb2bVlvhZL
	 6UwKbW75PCoz8eetdS2k3a/N6a/EBLfiptuyH7wJ/a/E2GsgmdPO5NALUpXrwOfnmaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792569372;
	bh=Qs4moc3PJKKsTvJb6ZEwt0nfnyoBn0fr/AqVOE8EJ+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eAo35jo9IhgFS++0HnwsdxbZ0IOizPm1TBww6+I9fzKEnH7j4SfCmZsWQcgDpgRAK
	 39imvJ2Qve43SHlNLe0qN/cZvCkW0D/4ifs+d4H54rbnWbZjVwPjvGu33NVGVp2uHj
	 2lOPQTHp2mM0FyMVi89x9EOsiSw7BbptqKLjvfwDuskdSukxf4BSXvQ4e5+GTWiUMk
	 B37Beng6djAi+U8wd0/D8sXXHyImKIFs0tc7VJswz58c6UtzsuePVuB/Y1fxiDH9zn
	 JDjW6mr+Pazh6gg8bQsdkXP2m0EoiWIVw2MimA2vLSIo6iXpkqPZG++5hsHEpsC63a
	 D3/AnNANl6OAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4099E407E8;
	Wed, 21 Oct 2026 07:56:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21410995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 130F380EB3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06thuO_2_nND for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E36E80E48
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792569369;
 b=MWoaz9xnfXEbIhFophFh5zLx5PfpTjAVyCvNLbCD1xWMn2o0EpwWcQJ10VFDguDWJkHu
 A2UKlVvBKp8PfrLDFgbXjpo7q+0WrxiTvmcBjbHRMMXiMc8jeRn2M+XhBvb66aq0Ox79D
 KJktuUr5dbvr0ST/EbbkiOwbMuJxQT5X+Ut8Om1/ID6tUJ1WIUkiJyRNGbUwhC3gK8i+f
 6hhNFkXx3jibF+tD2ca2yxbPaZ04p3L+mdSYpi8YLRer62PxpHhAV0ZjW8/h1EFdbEebL
 DfFgEZ/XfEHYkJp1SLyh9H3VKXZRfEPiaybd9EiEzl3xuih12MMlrIjYDbaBX9DeVWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792569369;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Qs4moc3PJKKsTvJb6ZEwt0nfnyoBn0fr/AqVOE8EJ+A=;
 b=Qe1hxJ5wz05YYNuQWBtobMmVWf/imR1Po71W7t9dEoyE52Smc2Uvte5M/3ZrXAB+UeQl
 JWs83ba0PeVgiVuuLkj+BhVlhdqdz2Mzptxw7NTFHfUId5MmpT8c3vREdwKL4ent8YD5d
 H68m+LvoG0Eey9hciuvj9BQ+3bf7NNkG+A8uGBKYiQDaIsRPER+hIhHmBNZquBKsBUuGc
 PU96dHgjbGF6xctv8s1n3Kwhisc2l+mdWyFOZyxNTkk85tMXgZgOW5kNUL0IPFxfwoJgY
 0XfsoF28DdpoZ70q7QbNmr59cFfdF+KkuM36qxBTEZn0rWBDHoP3Kj/sStPsIZK8X7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X9wK90nO; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X9wK90nO
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E36E80E48
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A2DC43D76;
 Wed, 21 Oct 2026 07:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA511F000C9;
 Wed, 21 Oct 2026 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792569368;
 bh=Qs4moc3PJKKsTvJb6ZEwt0nfnyoBn0fr/AqVOE8EJ+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=X9wK90nOKATlT5SfkzCt2lJidW36Zv5BmIOiNk/7Go41xU2HN+ELVMA4TrC3Bcdxc
 cjg5xz++9UnY53zDO5/4cTV1OfXD1ntfw/RlRvxtS9w0ky2mYrfXcw97hDD0+d796a
 O8YBkpSXBEknoNXIUfVdEjqegKm4hzWyExochFYMbR1YIKXPwRDwDTTaFACTGQl8C6
 lGoNR+yUuJzFpe/4fFw+lwWxwBWpPZJx3WCJ1Zs9CXcsg9QFvr6n9TAXoKtzXAk6+6
 LdJxhWczt+uic9gnhmzFcITl67/mzHtTghSBEthMpgKwY2Ine6V6JrqRbI15sx6ZXY
 O2f7B4gwRY+hQ==
Date: Wed, 21 Oct 2026 07:56:05 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] configs: spacemit: k3: enable mtdparts on Pico-ITX
 in main app
Message-ID: <20261021075605-GKD65567@kernel.org>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-3-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020195126.1325187-3-e@freeshell.de>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,


On 12:51 Tue 20 Oct     , E Shattow wrote:
> add default mtdparts and mtdids consistent with k3-pico-itx.dts
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  configs/spacemit_k3_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> index b333e708d01b..2ca912556a88 100644
> --- a/configs/spacemit_k3_defconfig
> +++ b/configs/spacemit_k3_defconfig
> @@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
>  CONFIG_HUSH_PARSER=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
> +CONFIG_CMD_MTD=y
>  CONFIG_CMD_DHCP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_MII=y
> @@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
> +CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
or make it more specific? s/spi0.0/d420c000.spi/ 

>  CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> @@ -49,6 +53,7 @@ CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>  CONFIG_MISC=y
>  CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
>  CONFIG_PHY_GIGE=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_SPACEMIT=y
> -- 
> 2.53.0
> 

-- 
Yixun Lan (dlan)
