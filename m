Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70401C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 18:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8D386BD4;
	Mon,  6 Nov 2023 19:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nyYRrQqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52EF86BA9; Mon,  6 Nov 2023 19:16:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B688644E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 19:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ee6a=GU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699294559;
 bh=dSvfgiR/1758LmYoY4GIKgBpFvTIsQ0bzFF/Io3NxqA=;
 b=nyYRrQqUqzUd1TY/6+Uw0/z3gvIh+KF5wZUoFziBu76TjI0f9DwRlEJm7+u7RxRrX+pg2AgM+
 Y+YWiXppO8nG2hjofUpGOXicf8ZXy6gwuoVi7gApj37JKB7e1O056AONOrlSxjMxVnBr9of6qgO
 ATb9jxA0iBbKeL/bowy3vBJD5HnAErWGnU4FWdFhdjlRh40+yKPhWrZDO98PoE0G07YF8dFMd9e
 HzbZ1oLWu9zZnh9+TErTNTU9vGv/hg6/YzqLRHRdeBdNVuK7I4XJAH1PHSfVF3l8W1xcfOtrs9D
 AjP2/1IqUg9Vt9JvYyhG7fzrEshTHYHOJ14Zs430P6bA==
Message-ID: <ef28a2eb-131c-4b43-b048-f8af3160ddbb@kwiboo.se>
Date: Mon, 6 Nov 2023 19:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to
 support EFI networking
Content-Language: en-US
To: "=?UTF-8?Q?Martin_Roukala_=28n=C3=A9_Peres=29?="
 <martin.roukala@mupuf.org>, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20231104130451.111020-1-martin.roukala@mupuf.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231104130451.111020-1-martin.roukala@mupuf.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65492d5f80eea5435c4cae49
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

Hi Martin,

On 2023-11-04 14:04, Martin Roukala (né Peres) wrote:
> When u-boot chainloads an EFI bootloader such as iPXE, we want to have
> already initialized the PCI subsystem so that network driver is loaded
> and ready to use by the bootloader.

This change slows down boot from emmc/sd-card where scanning for pci
devices typically is unnecessary.

If pci must be initialized and scanned before an EFI app is started to
find pci network controllers, then pci should probably be initialized by
the efi bootmeth, not by enabling CONFIG_PCI_INIT_R for a single board.

Regards,
Jonas

> 
> Fixes: 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards")
> Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
> ---
>  configs/rock5b-rk3588_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 0595325e81..938137c851 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -36,6 +36,7 @@ CONFIG_OF_BOARD_SETUP=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_PCI_INIT_R=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y

