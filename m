Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3096D3C54D
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 05:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB4A891E0;
	Fri, 18 Oct 2024 07:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Q7GOcJ/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A90089231; Fri, 18 Oct 2024 07:35:29 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C60A891A5
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1729229726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBaJYlSjYY3ZGUrQNVRiikhy/ZWrT7IR5GQ0p7t/UKI=;
 b=Q7GOcJ/xvvlpUDEkLyiUmONpzKfGWXKl7rmUYcp1g2ot5+HwjdDKja14qi9oscbVBwH6rv
 CkOEGT5Lifat+48acV7E52XuQB/pffF+DAA2tv7WBgUROIiWY4b1bfrbwM7L7r7tyZg/NE
 G/odaOSrkIWkjiBWu894SNsF41CAW6eqVq9pcCqr6CkvGQ3bGrK6DytoVa4qipfIZqzyvh
 OPSWQ/WNH6//MUo7/QCIndYgQo3xwoXk7+emuqwOQ7NAPtdIzT2yTJhguzq+E2dvztK0gD
 efGoznvj0JtevslKtFFGH1XmzXurE1Sl4nIh3xfkHcssMSUOsQhPfK+JbxqcUA==
Date: Fri, 18 Oct 2024 07:35:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/8] rockchip: Add support for FriendlyElec NanoPC-T6 LTS
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
Message-ID: <b103c7b4d3b5a21cb3379cad12f40ef5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Jonas and Marcin,

On 2024-10-17 22:00, Jonas Karlman wrote:
> This series picks minimum required commits from v6.12-rc1-dts to add
> initial support for the FriendlyElec NanoPC-T6 LTS variant.
> 
> The adc-uclass and rockchip-saradc drivers are adopted to support cases
> when DM_REGULATOR is disabled and using a fallback voltage reference
> from the vdd-microvolts prop in DT.
> 
> Finally board specific code is added to help detect non-LTS vs LTS
> variant at runtime and nanopc-t6-rk3588_defconfig is extended to enable
> Kconfig options for updated DTs.
> 
> Please note that this has only been runtime tested on a non-LTS variant
> of a NanoPC-T6 board.

Could you, please, have a look at my patch that I recently
submitted to the linux-rockchip mailing list? [1]

To sum it up, my patch does some of the same work you did in
this series, by resolving the troublesome inclusion of all
Rockchip board dts files in one fell swoop, and I'd appreciate
if you could review those changes.

[1] 
https://lore.kernel.org/linux-rockchip/f3d789c14fe34a53327cac03cd3837e530e21f5c.1728937091.git.dsimic@manjaro.org/T/#u

> Jonas Karlman (4):
>   rockchip: rk3588-nanopc-t6: Drop upstream props from u-boot.dtsi
>   adc: Allow use of adc with DM_REGULATOR disabled
>   adc: rockchip-saradc: Use vdd-microvolts prop as fallback
>   rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS
> 
> Marcin Juszkiewicz (4):
>   arm64: dts: rockchip: prepare NanoPC-T6 for LTS board
>   arm64: dts: rockchip: move NanoPC-T6 parts to DTS
>   arm64: dts: rockchip: add NanoPC-T6 LTS
>   arm64: dts: rockchip: add SPI flash on NanoPC-T6
> 
>  arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  16 +-
>  board/friendlyelec/nanopc-t6-rk3588/Makefile  |   3 +
>  .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       |  59 ++
>  configs/nanopc-t6-rk3588_defconfig            |  12 +
>  drivers/adc/adc-uclass.c                      |   4 +-
>  drivers/adc/rockchip-saradc.c                 |   9 +-
>  .../arm64/rockchip/rk3588-nanopc-t6-lts.dts   |  60 ++
>  .../src/arm64/rockchip/rk3588-nanopc-t6.dts   | 909 +----------------
>  .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi  | 943 ++++++++++++++++++
>  9 files changed, 1092 insertions(+), 923 deletions(-)
>  create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
>  create mode 100644 
> board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
>  create mode 100644 
> dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
>  create mode 100644 
> dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
