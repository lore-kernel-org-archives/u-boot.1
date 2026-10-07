Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FE6CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 12:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43FAF4065F;
	Wed,  7 Oct 2026 12:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J40Fek_1lBqX; Wed,  7 Oct 2026 12:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DEEFC40655
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791374752;
	b=tZNHlEUSIZz7WcJ3kn1oW4gJdcV6ImQLupgGKNtAZsGO6usXdQvozysNbL0JfMmIvgRF
	 zsT/HGcf4FRTNeP0gftJKA+dKvHTjVU//ltrpZwdd3jPCrea+DvjFVvXTUr2Hg67ayUCq
	 +9Uu/8cFPG5vMt6JN0ZficBVPiuN4lpx0+Xu23J6BmbUm4ms1ez097zk07E3L0WLvbSir
	 XQQo5ZuTPTEXcWUQJLAfG6ynC4xzChCW8BMWKlLPg9LbTJyPxF/cbgk6s0rC9j6Bxo9HH
	 zq+Xus/idR7ZEgAAsUN/AcXi5MV3reElE5ma2yfc6JpUspNFvkRasQaVLrcGw5y8znA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791374752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xj+PbtHgr47HCTfdRIQKFK7cAtSGx0RuPkoqIriBt1o=;
	b=INJpn5sBPWHmiPV9Jyr151ACHh7Nww88n1vx3xg5LvoTmjLCwuGUS9jGVKvOFic5eUfM
	 Tb7CtpLEIMbYxF5Eeb28jdwWmx8Yt/lbhI9HiFqGKPalftz2byosQnPsDmmW9o3woqHGz
	 7z36IOypCW5vQnjciz2wseZ3fKg2TcrFl4bUwncuAZoUrjjIgDHTVteu/jEyFjpzyFUJp
	 tY/kK/B1r90+RtviIK4kNBxAlq5MFkwz6PxP959E9zCM4ldNNkeWllFJRTGSu/Y+T1EuN
	 zmk5H9Cy1CBMEEBf2yz+Rs+IVjg+fEiIOuoptwtWCit1Wku7PQJjFm0CIu9wqpV/opg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791374752;
	bh=Xj+PbtHgr47HCTfdRIQKFK7cAtSGx0RuPkoqIriBt1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1uklYkVWdfDyy9BbmvYAeje7fTUu5j3nMZ4XNzNOyfJsMO3nQKCNGhoGCDoJwVD1
	 2sJsG1c8GuvDJ86gVJqqd+lpdHrvMb3zBD2Sb4DsaMy8gdgY9264r9sZU3au2279GK
	 1WjeMLxP/E+wce0xmI8wMHSft0/uM7LZzMD211cq91U67fei6a83JQhM35Tcmo8NQC
	 M7lo6Zp5k23yAc2T641vaKejX4gBGlTyN5RvJz05dOQnFQiqVODY+jQaUix2cawE3m
	 /6pm7Z8arY/Sl7tj4mJp5r1Aaw/YvOD0BPSyDXGfAvtSCa9lbSc1oJMDzskyZUJZPD
	 Gy2bgNle6Vs0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEEFC40655;
	Wed,  7 Oct 2026 12:05:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7C112E0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF38D40080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qJMddz3YJmX for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 11:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 588D940057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791373920;
 b=iTAOcuJ+icINFYQ4V1qTofDFZ8PSkZ4cZ5p4VRotwVmwfrzv+MO2JAm/aaaghZvXiUz+
 9J9Vm5TSBMckAe4EfsKHESQmk10Z6wl+m+AZEKweyfx/1cGodrIY93+mYOYApeTmUotHq
 BpSIAG9qNJDyBhI5ESomv5uBBW/XRyW0H8kkvgvARaA28D3ZA6UINwzzhPJkTRLhZa1s/
 2lD1QOIhji9564tPxnW703AgZTveEOtlJFAapBwKtZ5n11nvVGGObYKK9ECdzLwM2p79T
 jsZuqp4BvT8mmYWUazKnPTrWIeCERgC8FgmLfJIZo/sG81Z9p+HGy24fklxcIO0cQCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791373920;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Xj+PbtHgr47HCTfdRIQKFK7cAtSGx0RuPkoqIriBt1o=;
 b=dzhn6Y+QIGe4sn9KogLVr4qEWLUJg19wevkFiks8X+0G/K9GCCcvQDc3Zepp+cPDhBTU
 n7/3d01itAV8VTL9xLmrI1LNqfcvGGJOwlRg3lAAp7U/qwaz9k/Jtzzi5LmWZFghFgOrW
 X4NtdjvMU1LmIYAcFBEtD/UWHcJdDyIEluKlS1SXbaaIdGDGWx/ZsxO0WjhFGxP01YlFz
 QrW/oQoRB7cpWv0/0g9mVOJ3pf27uiTXhC0WKElgUtHJRdZ71XdtbK0olL7FL45tNZON+
 6VdtUOJ9+yns/2akaxCl0vg6BAqTeeBx6i5CHSDPAvSJM6Jaygw2SWm3cZj2W/c4gjA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=foulKIqT; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=foulKIqT
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 588D940057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791373884;
 bh=Xj+PbtHgr47HCTfdRIQKFK7cAtSGx0RuPkoqIriBt1o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=foulKIqTjskZmmglya6pCSHwt19OnndBz3azZ2G/Ss4k1Sm6sI2N/gWe/K4Wy3TCS
 wQjT6Xt4UkzwfYH6Ti1g/VRv+dXjUdxjWYFr0O5a0S3dIwQvzwqcspouOqIkH074Z6
 QerDKC99vcw3Ed6yw6v7SDePmX8mEbtn3AL6796TVuM9qBibYTC4XCz9MLobCohuGW
 BkVEtOktx1KNoapcvXs6vstvN96cBmI2NV8LPq2Ycl9qPZoxUUXr/r7R9FvPeCqJ7n
 rJziyxGQmwTO2L6NgoCFZ9AJeTcArS9xzyh8ZiD6PXjeCZaNGCKOOOF/3MDuNogQRg
 H4pHv6ircRbOg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 53491B220491;
 Wed,  7 Oct 2026 13:51:22 +0200 (CEST)
Message-ID: <af7aa990-8c66-4cce-ace4-81770ba47ff6@freeshell.de>
Date: Wed, 7 Oct 2026 04:51:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/6/26 22:11, Yixun Lan wrote:
> Add initial support for SpacemiT K3 Pico-ITX board, the config file
> will enable all basic components which make it able to run into U-Boot
> serial console.
> 
> The series actually depend on previous sent patches, I'm not adding
> dependency to this series, but list it here for reference.
> 
> Pinctrl:
>  https://patch.msgid.link/20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org
> 
> GPIO:
>  https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org
> 
> clock and reset:
>  https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v4:
> - update doc
> - add separate binman.dtsi file
> - Link to v3: https://patch.msgid.link/20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org
> 
> Changes in v3:
> - rename header and dtsi file with vendor prefix
> - Link to v2: https://patch.msgid.link/20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org
> 
> Changes in v2:
> - drop board_get_usable_ram_top()
> - drop empty source file
> - Link to v1: https://patch.msgid.link/20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org
> 
> ---
> Yixun Lan (4):
>       board: spacemit: add SpacemiT K3 Pico-ITX
>       riscv: dts: spacemit: k3: add binman node
>       configs: spacemit: Add K3 default configuration
>       doc: spacemit: k3: Add Pico-ITX board
> 
>  arch/riscv/Kconfig                       |   5 +
>  arch/riscv/cpu/k3/Kconfig                |  18 +++
>  arch/riscv/cpu/k3/Makefile               |   5 +
>  arch/riscv/cpu/k3/dram.c                 |  21 ++++
>  arch/riscv/dts/spacemit-k3-binman.dtsi   |   6 +
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi   |   6 +
>  board/spacemit/k3/Kconfig                |  30 +++++
>  board/spacemit/k3/MAINTAINERS            |   8 ++
>  configs/spacemit_k3_defconfig            |  51 ++++++++
>  doc/board/spacemit/index.rst             |   1 +
>  doc/board/spacemit/spacemit-pico-itx.rst | 200 +++++++++++++++++++++++++++++++
>  include/configs/spacemit-k3.h            |  13 ++
>  12 files changed, 364 insertions(+)
> ---
> base-commit: cf615aafae36fc49f55e3e6a3648d29201b26d51
> change-id: 20260921-00-basic-spacemit-k3-838119645d39
> 
> Best regards,
> --  
> Yixun Lan <dlan@kernel.org>
> 

Looking forward to this series being merged :)

FYI after the merge I will coordinate to adopt any devicetree-rebasing
cherry-pick and -u-boot.dtsi overrides that are needed. When there will
be an SPI NOR driver and "sf" SPI flash command then we have all
components for using mainline u-boot 'u-boot.itb' as a board recovery
tool with uart and network download methods. The devicetree nodes for
this should be easy to adopt. I can write some documentation about
compiling and flashing the vendor board support package firmware using
mainline u-boot 'u-boot.itb', and eventually mainline SPL too when that
may be possible.

Cheers,

-E
