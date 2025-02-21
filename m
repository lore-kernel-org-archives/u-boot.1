Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA50C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E192180EC0;
	Sat, 22 Feb 2025 06:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="oCk35jqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE623806FE; Fri, 21 Feb 2025 21:55:32 +0100 (CET)
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90A7800C1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1740171330;
 bh=4zeexbtJH6hUBgCYEAnnEsBvUITTyWtZtsJYaSNIB9U=;
 h=Date:From:To:Subject:Message-ID:References:Content-Type:
 In-Reply-To:From;
 b=oCk35jqotbL7jBBCUvx4BmBroCUZ9P7wuTXg9bcBeyslYb/QiWpiGxijgAUTuqR0H
 LJOfjWhzH+DSoD/xfxh8aq82cCNQ0PbxY/AmG7oI7FbjDSgvQvoyHgKXQwj8ck8z5m
 lE7xPW4Fu+YTFv70a8hYp9FXx6CxBoZcy51iTUyA=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr3.vodafonemail.de (Postfix) with ESMTPS id 4Z02TG3hRYz2GF5
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:55:30 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-107.um34.pools.vodafone-ip.de [95.222.25.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Z02TB1Qhcz90pm
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:55:23 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id C8EC62E0108; Fri, 21 Feb 2025 21:55:22 +0100 (CET)
Date: Fri, 21 Feb 2025 21:55:22 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=y in
 sifive_unmatched_defconfig
Message-ID: <Z7joOimtALeZ5qtX@tachyon.qrv-systems.net>
References: <20241119205959.13579-1-yuriz@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119205959.13579-1-yuriz@vodafonemail.de>
X-purgate-server: smtpa07
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1337
X-purgate-ID: 155817::1740171326-9ACB450A-16D3F80B/0/0
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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

Hello,

On Tue, Nov 19, 2024 at 09:59:59PM +0100, Yuri Zaporozhets wrote:

> Currently, the PCI subsystem selects the small "region 2" (which starts at 0x7000000)
> as bus_addr/phys_addr. As a consequence, the BAR0 on PCIe video card cannot be initialized,
> because it simply doesn't fit into 0x1000000 bytes size of "region 2".
> 
> U-Boot should use "region 1" instead (the one which starts at 0x60090000), because
> it has much bigger size (0xFF70000), and easily accomodates BAR0 of the video card.
> Linux kernel also uses 0x60090000 as bus_start/phys_start.
> 
> Signed-off-by: Yuri Zaporozhets <yuriz@vodafonemail.de>
> ---
>  configs/sifive_unmatched_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
> index 058e5fab68..d5c7d5bfa3 100644
> --- a/configs/sifive_unmatched_defconfig
> +++ b/configs/sifive_unmatched_defconfig
> @@ -36,6 +36,7 @@ CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_ID_EEPROM=y
>  CONFIG_PCI_INIT_R=y
> +CONFIG_PCI_REGION_MULTI_ENTRY=y
>  CONFIG_SPL_MAX_SIZE=0x100000
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_SYS_MALLOC=y
> -- 
> 2.39.5
>

This is reviewed by Leo Yu-Chi Liang. Could you please apply? Thanks!

-- 
Regards,
Yuri
