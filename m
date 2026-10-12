Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C6CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 244FA40434;
	Mon, 12 Oct 2026 09:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lEbGd7YeCO6; Mon, 12 Oct 2026 09:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FE9340533
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797856;
	b=hwzSP3spZAXU1O3AWMFoX3P/lzgoHhqOAWa0sQbcrCfd27fTT6IuvLd7cPo8f79J5/Fh
	 Iv1lejZcHQqdJpFbf871R16UMoToLWEEHNvQcULQmaD00S3zSFtjCX1q41fkkJPHc7auj
	 x2ZOJFj66jnEV5sGAFe3jKeIapsRo6tDf4/ucfpGRTa8O46Sorm4QAqfM/S5gOOZCuY1S
	 wPxeLbzeY6qVuhjLp37VBORqRZPd0j3KwI8fa2h8im59ES+cVMr/BUmJDkW1w6nh3LWVt
	 NQMTpd9t6USRcEZGfae8jQJBrtQgG3sV4fRKJqqdNF29l0EdcZ2ALKTBBguoE/4nq3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NA/rgy5MbLiMkufMR9hnw2LdCEZ8asX4yEaBDL/j0Bg=;
	b=NDEeiyoPtqq/vk0EWDtHdbFU8TkwW/+obOKx1ljs5WgHWj9P1DzYy+PyNPqzHjDT3bo0
	 ln/zJIsLsL6JRb9BERDhs3Y29w6wHylgkJ9W/nwJIY7vJh3bkh/fV1p7inML+/sEBhbvq
	 BvXqzae2+uuXWTVxfEGhJiJ7fVaaVR3hu/kGPnqv4QE5YoCNOStVytcTHdzQbs18adWab
	 tqv2Poz7674OTNYQNzIVDdJdPrG6qY726HsRZhTdTEmA9mhBPr+2NS7Wnae1otK8P8J+S
	 rVx0/mCrum1R2bQzOukJOfNc7boyR5/bEnNTWg58/jpLJAlFEzKg1QeL6dakRrH/t9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797856;
	bh=NA/rgy5MbLiMkufMR9hnw2LdCEZ8asX4yEaBDL/j0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdMCSGNo00X7uotpwdAwlz2TtUWkqWMM1usHPe/2Qn/1hDvtEwUjiO49Mh8wXeBiI
	 /Y5C9YNCIAvtFSYnkF8L4u5aGhMQmVmG8jHJVN3dpeltpOQbQT2mYJRHx+s+dOld8V
	 EvG9nd2LK1sivdxcIrxyuBtLRegMPXikNR7D1nKJBehpTnDi1rL/HYgYgBfU7SqdnN
	 mheyIfEEGXHopqNcOkf9GJJxrrQZ1xU8sbuKQ0wUxy6jzToC8OtfEIwOb9J6hbpcFq
	 CvGHFxK6nAfWGPU5ILe8W0av7cR7gwPlhlk7JQTQG0XwsPDONFvPtqrfIpbZdwlDDd
	 MxpnDYle9j1Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FE9340533;
	Mon, 12 Oct 2026 09:37:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41F54179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2797280874
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZMd3xbwQLjh for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8416580838
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791797854;
 b=bKf5lIHp6yG4ruqGGbj2tm+8lYib/oHzrBrHGsRYpY4Eat8QJ2tEOHlf1Hn9jSPgw53a
 7qXUHNS5wCzHk19PiIXR/yPndrGkCx+omJMVlzN0VZsysDbEICXSP8zFuJT2RySDcvBPp
 wPoRftWphd9Hg1EJy/1rvOg+j6D5S+2krswHUNVPuOAUUorh25ZEje/55Ss2AB6atqVsY
 H/MbaRLi5OERW4NvcZSO6Cwi3dfe3P3FLBclkWsMa7Er3TXMHQpgdlLR7OrGoFIoUk5qw
 YeRLsJLSBo7gDZ5z+PHTlPFB/CVMJVx7jAG8BlGrIHul0zOwfibU5vfunshvIXa8Kmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791797854;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=NA/rgy5MbLiMkufMR9hnw2LdCEZ8asX4yEaBDL/j0Bg=;
 b=oLhkbT9bWpZOJEZNvJfKft4sc5fPqR+Cto2QDiHwm9len0RWT5cm3bKA5NpQeGo0GyHg
 /9GluSLNDcOdsbf3j84tzg3mDqvoyDIdNFLzO64Pt9UsltSJhpl7VVjQVUVLX307Pe7m8
 2vI1M/5PZR/e8nfUYoST00wkNNGMXP1ocvDKRrAHgTyRoOW/9LA1u62qtloj6Bn80InHV
 M+4ROMtjB+xEE8c5rcLUObUZ1jEMdBU0eiiK+GXCNwqwsIgWaw0UI/d1PH57X8Er7PkUJ
 vqnNce6tO9dHSXL6lHJi6oEtDkpFReAR2v5dWCt9lfd0t7tmhWuQfi4LclWGHBfuFnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LhsAWzGW; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LhsAWzGW
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8416580838
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:37:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E5B1418EB;
 Mon, 12 Oct 2026 09:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D11F0089B;
 Mon, 12 Oct 2026 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791797853;
 bh=NA/rgy5MbLiMkufMR9hnw2LdCEZ8asX4yEaBDL/j0Bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LhsAWzGW9PyRinUpRfiHqbUW1mAWzM4lMsx3tpSOpDCWyE+DIKcjEAjIWnxe6h7di
 tLr2855iedsmDAfgy42n9aRHw8zkrk7fiWVYe+T6OagZnbGa31NVQ+Cq79p1AkgGFs
 2iHNLOOY3mzBFCsJ9e+o3dduRPM/AWeRHAUj5oihgxCZCt3z9b0r3BORBU4BMdv5Ee
 nI3vTHfcZDycm1UgCd1smu+0sk7EztpdeodVYNpUB45qpmeiHpJNWLHy3Sgi17bQCt
 0VA/ZCdlTJh69uBfCxxaVCNL65A1v5Qx6uf9iYBR+WshMRdXGBrNJTcqv/+a11mXgI
 zN+iKmbFXorvQ==
Date: Mon, 12 Oct 2026 09:37:30 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 1/2] phy: spacemit: add K1 USB 2.0 PHY driver
Message-ID: <20261012093730-GKG26088@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
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

Hi Dave,

On 12:32 Tue 06 Oct     , Dave Klotz wrote:
> The UTMI PHY at c0a30000 ("spacemit,k1-usb2-phy") feeds the K1's DWC3
> USB 3 controller. Port the Linux driver: enable the PHY clock, program
> the PLL divider for the 24 MHz reference, wait for the PLL, then release
> the PHY's resets and enable its clocks, the HS TX clock and the
> automatic host-disconnect clear.
> 
> The divider has to be written before the PLL is polled. On the OrangePi
> R2S under FreeBSD, a driver that polled first and never wrote it left
> the PLL stopped: the clock enables did not latch (0x60ef read back as
> 0x60e9), the PHY gave the controller no UTMI clock and the xHCI reset
> (USBCMD.HCRST) never completed. Warn if the enables do not latch.
> 
> Also apply the vendor's HS DAC current setting (+15 %), which the
> FreeBSD driver that runs the R2S port does.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/phy/spacemit/Kconfig       |   9 ++
>  drivers/phy/spacemit/Makefile      |   1 +
>  drivers/phy/spacemit/phy-k1-usb2.c | 173 +++++++++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c
> 
..
> +
> +static const struct udevice_id spacemit_usb2phy_ids[] = {
> +	{ .compatible = "spacemit,k1-usb2-phy" },
Since K3 SoC share this IP with minor difference which we don't
care in U-Boot, and also I've tested, it works fine on K3 SoC,
so please add in next version, thanks
	{ .compatible = "spacemit,k3-usb2-phy" },

> +	{ }
> +};
> +
> +U_BOOT_DRIVER(spacemit_k1_usb2_phy) = {
> +	.name		= "spacemit_k1_usb2_phy",
> +	.id		= UCLASS_PHY,
> +	.of_match	= spacemit_usb2phy_ids,
> +	.probe		= spacemit_usb2phy_probe,
> +	.ops		= &spacemit_usb2phy_ops,
> +	.priv_auto	= sizeof(struct spacemit_usb2phy),
> +};
> 

-- 
Yixun Lan (dlan)
