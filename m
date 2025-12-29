Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F74D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 09:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E4283B48;
	Mon, 29 Dec 2025 10:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jT21ZK0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C477B83B48; Mon, 29 Dec 2025 10:49:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD8283B48
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1fd3=7D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1767001781;
 bh=Skhg1KEmIoxU/8F+eDSKyByGrrykxSrFtQMwIob0ZYs=;
 b=jT21ZK0v0LwjJFSAPK95UukfxDzPNuNyoy190SdW5nNAgpvbPejDB79Ii5v+Z/VJut37yLOpe
 ukQc/EyN5ln5SZNdxtBOwhWoqnq5GVT2weW5srjdh0ZprOtSc6S6uilhL6kE3eOCuvu1Zd9ALr6
 SnfCRA0XvKHrJbtBAb1a8h/ftJzyXOsBJhpXTzqFPEymqSZv2Xuhk/5ttB8axYj3wF9RHlzF4S+
 g1aoWUugSDy/njuCVEacBqgrdAdCDq7BapZLlfCmKRpSYjrwa62tWYtKGHGUf8Iy9+E8Xe8b1G8
 eUMrM+ONVAV0y+BwVsVFfGreE+mB/3UmnWhDpUxvWX/Q==
X-Forward-Email-ID: 69524ea70cc3759ebd0ba1f9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.0.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <dc6ddbfe-df79-4dcf-90e3-76068e5a5e40@kwiboo.se>
Date: Mon, 29 Dec 2025 10:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rockchip: sdram: allow reading memory info from TPL
 on non-ARM64
To: Aaron Griffith <aargri@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
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

Hi Aaron,

On 12/29/2025 1:05 AM, Aaron Griffith wrote:
> The RK3506 TPL provides memory info to the bootloader via ATAGS. There
> is already an implementation that reads this information on RK3588 and
> others, but it is currently gated behind CONFIG_ARM64. The RK3506 is
> *not* ARM64.

Use of the RK ATAGS was initially only introduced in mainline U-Boot due
to a memory hole on RK3588 devices with more than 16 GiB DRAM. With [1]
applied this should no longer really be needed.

Is there anything useful encoded in the RK ATAGS that we need on any
other SoC ? (with the goal of using mainline TF-A and/or OP-TEE)

Use of ramboot also overwrite the RK ATAGS with all zero, so we cannot
expect the atags to always be there, only to assist in some cases.

> 
> This patch series aims to allow this code to be used on non-ARM64, by
> 
>  * adding a new config option to read this info from the TPL,
>  * allowing the ATAGS memory area it uses to be set in config headers,
>  * placing truly ARM64-specific logic behind CONFIG_ARM64.
> 
> I'm working on upstreaming RK3506 support, and this is the first patch
> series of hopefully many in that direction.

Nice!, please also see my rk3506 branch [2] for a mainline u-boot branch
that is mostly just waiting on upstream Linux support before being sent
out. Should have good support for most Luckfox Lyra variants and the
ArmSoM Forge1.

I will shortly rebase the rk3506 branch and can possible send out part
of it now that initial parts for rk3506 has landed in upstream Linux.

[1] https://lore.kernel.org/all/20250802220738.3018910-4-jonas@kwiboo.se/
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Regards,
Jonas

> 
> Signed-off-by: Aaron Griffith <aargri@gmail.com>
> ---
> Aaron Griffith (5):
>       rockchip: sdram: add option to read bank information from TPL
>       rockchip: sdram: remove redundant configuration checks
>       rockchip: sdram: allow config headers to override ATAGs location
>       rockchip: sdram: refactor bi_dram logic into separate function
>       rockchip: sdram: only reserve BL31 and use mem_map on ARM64
> 
>  arch/arm/mach-rockchip/Kconfig |  11 +++
>  arch/arm/mach-rockchip/sdram.c | 195 ++++++++++++++++++++++-------------------
>  2 files changed, 118 insertions(+), 88 deletions(-)
> ---
> base-commit: 0f6ff53d55ba254de8a995c2a2f5a313acd40ac7
> change-id: 20251226-rockchip-tpl-use-atags-bf3d14a840ca
> 
> Best regards,

