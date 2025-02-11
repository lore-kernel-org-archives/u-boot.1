Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE85C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19513800B3;
	Tue, 11 Feb 2025 12:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lp0xItpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9FE80104; Tue, 11 Feb 2025 12:53:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D118F80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739274791;
 bh=9uMb10UdOLbcvHkCSknksq87gxKDtRuZFtGJZOWsBIw=;
 b=Lp0xItprHQ4MrC5kxiF0yzqE3kTttFm4pQqajAn1f2pNUJL2XKFE/LaY/c4JZVvQjbRqlUPTf
 F7qmkZ2ePUiaSWlymt9If6kQmCnxWOFOOgkA4wPoui9nKIiFarqjNB65aPSYBttWXajQ9/fY5jk
 i037eKsvgdWKb1KcHDUdiSFaec7lTJA/Xkcn6oe34jcvujWBWrGIdAJ+xKXDvts7obvI0k0cwsn
 76yN7Z4lxYA0lZCYTkBT2DEBdt63ZqGJf6czOaTKGteJ66+IFkGdQnpaXpwzlyvYye8b3xxNzeN
 jsY/yyH9i0GFgzJ+agBSnNwP7J5GO2n6LrqkVsa3dVOw==
X-Forward-Email-ID: 67ab3a252c3b8c8cd9bb4fcb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2a03154a-2d84-4771-aec5-ae72d3d60526@kwiboo.se>
Date: Tue, 11 Feb 2025 12:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: rk3288: do not generate u-boot.rom anymore
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-2-0d77f95b6239@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-2-0d77f95b6239@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 2025-02-11 11:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This was only used on RK3288 Chromebooks and the EVB.
> 
> If it follows the same pattern as for RK3399 Chromebooks where their
> maintainer (Simon) agreed[1] to removal of u-boot.rom on the basis that
> the generic u-boot-rockchip-spi.bin is now enough, let's do the same for
> RK3288 and remove the last Rockchip users of u-boot.rom (and HAS_ROM
> symbol).
> 
> At the same time, remove HAS_ROM symbol from the RK3288 Chromebooks and
> EVB configs since they were used only for that.
> 
> SYS_SPI_U_BOOT_OFFS offset in rockchip-u-boot.dtsi for the u-boot-img
> node of simple-bin-spi binman image matches the one used in u-boot.rom
> except for the EVB.
> The EVB doesn't have ROCKCHIP_SPI_IMAGE symbol enabled, so HAS_ROM had
> no effect anyway. Even if it had, this would not have been enough
> considering that SPL_SPI_LOAD symbol is not set, so U-Boot proper could
> not be loaded from SPI even if SPL/TPL does.
> 
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for this cleanup :-)

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
>  arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
>  2 files changed, 29 deletions(-)
> 

[snip]
