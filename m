Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD22CCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 08:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7634880CEA;
	Mon, 12 Oct 2026 08:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABozRJERokxQ; Mon, 12 Oct 2026 08:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85A1680CBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795275;
	b=U2/zzeEEEBu/O5p+/FSGmPOv9TYcS0Wh278AZTT3mi63zajsihOnFvDu/fl5idpvrR6p
	 ljomPW6/KgKLpqdQWVorGfnGmDXL42QFpEUYxUpJS0CjUNe9Pkz7e1AtfYT3sK57LnqbY
	 0Oc6fhmo1imW7IYmf/55lXTNIZ8LhCR3VtjYhT5SpJ03f287Ioaq3EU6z/VbpW1Jg9xh6
	 g+K5Uu6VqnhNeHfHQLrUn1j0miAYSEvjn3rh9NV648BugQqHXLcrJSuO3FgYHrbZ6UIn4
	 TZLIYaELEueCHw3UCgJUD8v65CIG+jB0bnHhJyLZn0vb5HQTwhof4gRgsdfFAWp02UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rCRSCzH0SMNzQqRdBKP/So7eeRUy8gPmxtUmM7jxaps=;
	b=r2gC35VrRyC/CC7bUNMIUUYt/kNDRWyBKP/3TUwyGH0Kq4so3BxLwYZziOBsHLL7M7V/
	 cylCDNSEi5qS0849iLBJXqBfhJ2IOH4aQpUQnEA1tN8ZRL0jN7SDvlkEXnarU6duSTlpD
	 qNNRa9TqU/u8o7+ITEadmAzoACcEmVu82FgxyqAWAhAnXX6d3MPjylcarAaEPawSj28H3
	 5CrohZZV2TuHcZGkOF32wmkXRUnXMjjKUkptydeooxmrxAiqiZJIBQ6oPa8uv+XsXm0fX
	 BM8jzGOumWRdD+qJg6bjJo3QWa5/Lfhnll5DRsg7C3AptOdf6wwQJ0y39rc+XjYmjjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=0hghDG+2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791795275;
	bh=rCRSCzH0SMNzQqRdBKP/So7eeRUy8gPmxtUmM7jxaps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OT0Ei3dlPGD1MbLZ3tIh51/RpH5wpH1SCywXjMtx5oHMw3VhZfNsq9dr0AFGdAl8d
	 Os7/our9xFUmIlg37oFe3JZNhZEhkSFaNfqPjmT0v5qX8pWxi+jXIqUencusWKhvOl
	 sX7rbBwdlKhp0XPDVd8zWG+68aIbvEWKSXY4btKnU9gl7l4rNdHb4ofxkuG75zqGvt
	 ElfbK26KndHjrE0WSejZFckwWar76E0AzmxBke7w6y5L2/BhoP2A3ZycCQsrZoUvFO
	 Djbpxa3RiTojzvQ1d3UWBohlOnXZ/ffmIvppRGo5wpe+2vhSwh6/qfZywYkt62ViLl
	 hCloK/OyXuzww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85A1680CBD;
	Mon, 12 Oct 2026 08:54:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 47A3F75
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38EC280CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUk4IhjqmtKv for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 08:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 608CB80CBC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791795273;
 b=TJR8pIP495C4WGUeEZz3uMrrHV+hE4kehLK2q2TMuSFJdacUfV48XZjBDtVzoERwym+h
 7l7AaB9kGBTR3Hhbt7ca/9XBi/cHcEWavQD9xwtK0zotVEHHKayHkx3+tCdOXJAIbvicQ
 yk+fNKL2Fh1blUmcETZRX2bCc9pF78eaXZzau/t1UBXjBDnV57YIojAVbf+xdnsX/NUf/
 ++U6FxBZ50uBB6BWp/YayK0nD6JASAz7aVbS1RFLXzkiiMg/jlicp6QXao2XoBzmrQA4z
 ngs3Lvi3rwWg46rKHnOvxXCFgqoMfN9wSfVzkYf6icssZnk0iuCKtklWhT1jHKjBZ2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795273;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=rCRSCzH0SMNzQqRdBKP/So7eeRUy8gPmxtUmM7jxaps=;
 b=ReJJUOxVhcJXArjJkGVZrtmTCXXMb+BbOSLvFX6LVxrt8akzW+IRRiFEjWQNmFtCsT9d
 6p5Kaf+w88X6/mibZxZutwcjbSDr2SHBc09+eA7L89LR4rrrcFpVMaRoeslXNY8jIWxCH
 q5Zh1ody2qzODjDkDlRTtziFmCjo88oJwDHkTL7W45NiKU+gnQRph+RSLAAeGoNifjjR+
 nf8Jr6UF3SCw4VrxtOb6yR9G/nsoAkoj6Z5kA19pqrDdriK0rEq81rDHqX5L6y4fkIvrl
 wgYWkJuoQ7IMzAZxO7/1gTnHBRRsaHohsCChFU8SNjTD14cA32zXxSlIbUrX/FSRF7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=0hghDG+2; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=0hghDG+2
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 608CB80CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791795271;
 bh=rCRSCzH0SMNzQqRdBKP/So7eeRUy8gPmxtUmM7jxaps=;
 b=0hghDG+2sldhFB2H+MJPEwx4lcHxOPBt9aEWOdJ8CPDVb1W55J0QvlVV2mT3sNIlN4mKx1+yd
 mQ/4409vvAAcxVc1detbzEhdfoqyLWA5fnWCRRH1NV0wpE/bTCUpAco/0jTWsTIeDIlLUsLA5IV
 BrSE6laEMHmSVioBoSb+xkSCJY8Neh480jvLgnC3wSmFC/2CP6inLiXr/ngLOt43YSXKXiUcY81
 KmgQBPQ0lck0urfvBO+RDL9hwTRIWzDpjIf4FQEo/+zWZ1QehhbfrVjxPxq9PRXnfAvoEh/vfi2
 /9NIUULYum6s6Wu6ZJFOjRc11vBq7uJzzcUOgPLprRuA==
X-Forward-Email-ID: 6acca0442afa432ba8be3ee1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f46b4af8-8a8f-466b-878e-2d5ffed8f132@kwiboo.se>
Date: Mon, 12 Oct 2026 10:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi R28S
To: "HystericalDragons@proton.me" <HystericalDragons@proton.me>
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz
 <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
 <20261012-nanopi-r28s-v1-2-042d62597829@proton.me>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261012-nanopi-r28s-v1-2-042d62597829@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

On 10/12/2026 8:55 AM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
> based on the Rockchip RK3528 SoC. It shares most of its design with the
> NanoPi Zero2.
> 
> Specifications:
> - SoC: Rockchip RK3528, quad-core Cortex-A53 @ 2.0 GHz
> - RAM: 1 GB LPDDR4
> - Storage: microSD slot, optional onboard eMMC
> - Ethernet: 1x GbE (GMAC1 + Realtek RTL8211F),
>             1x GbE (Realtek RTL8111H over PCIe)
> - WiFi: AICSemi AIC8800D80 over SDIO
> - USB: 1x USB 2.0 Type-C (power input and OTG)
> - UART: USB Type-C debug console (onboard WCH CH340E), 1500000 8N1
> - Buttons: user (GPIO), MaskROM (SARADC)
> 
> Add support for the board based on the NanoPi Zero2, and enable
> CONFIG_BUTTON_GPIO for the user button.

The board variant of NanoPi RK3528 family can be identified using SARADC
channel 2 (HW_ID in schematics). This means that we can combine Zero2,
R28S and NEO3 Plus in a single U-Boot target.

Please feel free to pick any part from NanoPi R3528 commit at [1] to
avoid having to add a new target. With something like that we can use
a single defconfig target and SPL will select correct FDT depending on
what board variant SPL is running on.

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3562/board/friendlyelec/nanopi-rk3528

> 
> Features tested on NanoPi R28S:
> - SD-card boot
> - Ethernet
> 
> Signed-off-by: 安容 <HystericalDragons@proton.me>
> ---
>  arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi |  3 ++
>  arch/arm/mach-rockchip/rk3528/MAINTAINERS   |  6 +++
>  configs/nanopi-r28s-rk3528_defconfig        | 65 +++++++++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst             |  1 +
>  4 files changed, 75 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
> new file mode 100644
> index 00000000000..151f1872fed
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-nanopi-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> index d1810fb0528..78e0bfb2701 100644
> --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -10,6 +10,12 @@ S:	Maintained
>  F:	arch/arm/dts/rk3528-hinlink-h28k*
>  F:	configs/hinlink-h28k-rk3528_defconfig
>  
> +NANOPI-R28S-RK3528
> +M:	安容 <HystericalDragons@proton.me>

I have this board, feel free to add me as a reviewer:

  R:	Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +S:	Maintained
> +F:	arch/arm/dts/rk3528-nanopi-r28s*
> +F:	configs/nanopi-r28s-rk3528_defconfig
> +
>  NANOPI-ZERO2-RK3528
>  M:	Jonas Karlman <jonas@kwiboo.se>
>  S:	Maintained
> diff --git a/configs/nanopi-r28s-rk3528_defconfig b/configs/nanopi-r28s-rk3528_defconfig
> new file mode 100644
> index 00000000000..f24bf2c65f2
> --- /dev/null
> +++ b/configs/nanopi-r28s-rk3528_defconfig

[snip]

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 1f4e58c8be2..faca4fc425a 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -103,6 +103,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3528
>       - ArmSoM Sige1 (sige1-rk3528)
> +     - FriendlyElec NanoPi R28S (nanopi-r28s-rk3528)
>       - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
>       - Generic RK3528 (generic-rk3528)
>       - HINLINK H28K (hinlink-h28k-rk3528)
> 

