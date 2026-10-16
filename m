Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A5CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26DCE40982;
	Fri, 16 Oct 2026 09:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2CVY44rEgFd; Fri, 16 Oct 2026 09:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 610B240927
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792142346;
	b=gDEKQrUu5gbs6A5BIlbGkirozN43yPTj2xPPH+2rn1RRPA5Hb0QOGzB7gZIwg0RrQNBw
	 HfvLmeSsphew6/6v5e6SRaOAra8nAC1EkZYWa8xLHkHmxdRizEOBxc2m4UNT13/EDwDKI
	 VwxJZMTol13ou8H7pxR3PVJIepcC6Er3Y037yD9kv0O1cyxbN3+ErPKsP+2sPoUWS7k1R
	 ZQMLtnxWAhbx5gW5XIAo31mHoLYdvpUDTPnd+GZWIcFixM/5gOYABCHpf3BmYklgDCkrx
	 n/gtfEfKWBFZwmhf+MwKUZ731MRifyMRBhH7M/vre0FrkkJo/frQDOatpu90Wqq5SoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792142346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YPhxbBjTK/cbCeUUFIKHxKy82yZ9NblP/Ykp7IiHWrU=;
	b=BKPf1c6SgthO5M/7q0Q3C1KNlgGEymgj0PQMB5F/nX8/bm2MTGjAV67vvdgWFgua9G7k
	 6gLb/b8OB8g3+LSuzEDHVwdNWQ75+R8hRYy/yHQ4cwxP+saduvaXRClyFXUvxBdBvXZ0Z
	 JjKBdoULcYmOsYZEu5Fg6c5uXSK6CZIO2noQBSoW8tgz4llF1FI/7Z2RpkIE5IY+WB/4l
	 guYDdt+rx6QlKBUaj3NFVgW/Zhoinqmz8IPH0YDNSBbAJDGJ8OygcZyubgsfZoFqnmf3w
	 oDtticm+L3SReHKtbt06ALCF6z6Q3TbI0kj28IOoSFLKWafiVHwoeGibkNFhK7FlcnQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792142346;
	bh=YPhxbBjTK/cbCeUUFIKHxKy82yZ9NblP/Ykp7IiHWrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQODBuprFl8CSqnvzwipDMJRw8qbccg5uaK7QC4+I2wIp0WDmT1giT4aomh+YptK2
	 Fpx9sCMMaZQ9h3TgEEnSE3WeiiPoNyRWGnfa6+vY2scVBVf0nCAcTdhKs5s3303ibZ
	 8pOYf7ja9itRpvTQULamSCotWAGYJcA0/O6Lz+/9G4pxvWApkiFUEgSpq452AyBZeL
	 6vD10USejnE8EpNVh5tGqWGLpQyxKCCsb2ppQ596NyunkMIWDXRlogMYXZIk54G5Gd
	 8PVfE/+pq3KWoBrvJLsG15v1hYussjVciBvkRII0h2CTBmoysN8x7TvMI+Dn84j0wD
	 iaxN1vNiV43hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 610B240927;
	Fri, 16 Oct 2026 09:19:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 109C9105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02728812B4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSVj9XwrjwGR for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC0DE81115
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::bc0c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142344;
 b=hfPRsot5JH3P/CHwD0TkdU4yWlu8PxY9dfmyLUl8UrOolMVrAYNHWNDhjo4kG2KhXIsY
 fE5Exg+voYoOAXxUuBAZHXDxiVaABHHEeREn1xjCC7hwcq5Ta9JuaSjpuyGWFCH1XHFgF
 Fu/u3aSZomW/QzOf69QOo7ZVXwvLtu/7IlfsuO/pcHBVRavTUVRTY3rC2ThMfGLPVdEqf
 NL51MQS/gZvuX25fr+JbUIQNH7qN/ke3qu5vG9ivs3dQszZ66QnFOcKc9CQ9mOyhNVFrE
 fI0SlBUfaLZmvdmdIbLPmnaFEjbI44iqQE+/NYVw8zsYGfIcOajKn0NVq4yWBcIDjVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142344;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=YPhxbBjTK/cbCeUUFIKHxKy82yZ9NblP/Ykp7IiHWrU=;
 b=qIncxzfRANaUT7kHcBmc9P2opufPB0d5nlede6xePTolvEkBqg0Q3IyBlJ27RWNTDpMm
 cwl6PBUowvYzSYdyP4XUlUykM9kK2Q9wdgEWjEb7QC0X7ZGtTIDzpL/GmDGrL6MnRZhel
 1DqvaqIgULuSjz54YxmydmwE770xxkvEa6etsWjaQB0RqiBaq/EJ0O7MYwcRQEQPpuuuD
 td8PG06TClS159gxOA7HTkebpQM26nO0VeWFQNIX8qxSOh1g77XAr94t4cxrCLQ8I/Tvy
 VP/Wdli4wQ5/9U6erFuycLqPiVDjMkTgE3Qnbt1l/KiE1qpCX0ODVZ+AivLFnLiOcSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=YHHUtRqI; 
 arc=none smtp.remote-ip="2001:1600:19:5550::bc0c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::bc0c; helo=smtp-bc0c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=YHHUtRqI
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC0DE81115
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:19:01 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5fWk6tyDzVsB;
 Fri, 16 Oct 2026 11:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792142338;
 bh=YPhxbBjTK/cbCeUUFIKHxKy82yZ9NblP/Ykp7IiHWrU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YHHUtRqIZ4gCk6SjDxkp2MH/XH5idZ7ahTfklVgAwyB5IiJgd1SeyOBixFmMo3ZrC
 yKsZg2uHowBWTg3UqWC55Hr+1NIHV3wwF1QmjAX0R5JrPLYeQd2dZIdkxqdNd8Xfby
 8f9b9kNzq6sq4BYzZZtQeGsuxFvlWFTq1IS6U0ww0YzPmnCvGMTYpdbiidmfQfPtYg
 vWhO/O28hyHFoU7vWFGdwo3/typsw6Ga1AL6UsBHzVvhIG+eKRl1b/Lra72eE/6/m9
 mu//VpNJx5sX0gpwLHeD3rhd4/2sDDfbqXKtfxf+LSohXCDuE5rC5PpYDlDQNiNy7S
 2grJGYAYd1U/Q==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5fWj0fTRzfvc; Fri, 16 Oct 2026 11:18:57 +0200 (CEST)
Message-ID: <efd080ea-60fd-4c15-858d-d63da9016be3@0leil.net>
Date: Fri, 16 Oct 2026 11:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: Declare unaligned access safe in the
 ARM64 SPL
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-2-675466ced78a@flipper.net>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261002-unaligned-decomp-v2-2-675466ced78a@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Alexey,

On 10/2/26 12:04 PM, Alexey Charkov wrote:
> spl_board_init() enables the MMU from ARM64 SPL, and runs before
> boot_from_devices() loads anything, so the decompressors can use
> unaligned loads.
> 
> Select it under the same condition that code tests before enabling
> caches, so the two cannot drift apart. SPL only: U-Boot proper is left
> as it is.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/mach-rockchip/Kconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e7..cc108e9679d3 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -631,11 +631,16 @@ config ROCKCHIP_COMMON_BOARD
>   config SPL_ROCKCHIP_COMMON_BOARD
>   	bool "Rockchip SPL common board file"
>   	depends on SPL
> +	select SPL_ASSUME_UNALIGNED_ACCESS_OK if ARM64 && !SPL_SYS_DCACHE_OFF
>   	help
>   	  Rockchip SoCs have similar boot process, SPL is mainly in charge of
>   	  load and boot Trust ATF/U-Boot firmware, and DRAM init if there is
>   	  no TPL for the board.
>   
> +	  On ARM64 it enables the MMU from spl_board_init(), which runs before

No? Only RK3399, anbernic-rgxx3-rk3566, jaguar-rk3588, RK3066, 
ringneck-px30 have CONFIG_SPL_BOARD_INIT() enabled AND it does not seem 
to be doing anything related to the MMU. I think you meant 
board_init_f() from SPL? But then the arch_reserve_mmu+enable_caches is 
only called when TPL is disabled (note that it is NOT "not in the TPL 
phase" check, it's whether U-Boot will have a TPL built at all), or 
SPL_RAM is enabled, which doesn't match the dependencies listed above 
too. Please add a comment next to the ifdef condition, the calls to 
arch_reserve_mmu+enable_caches and as a Kconfig comment next to the 
select that they need to be kept in sync.

Cheers,
Quentin
