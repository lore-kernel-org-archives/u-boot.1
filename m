Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A27EC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421078829E;
	Thu,  6 Jun 2024 08:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MbSdARgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0225D87C86; Thu,  6 Jun 2024 08:59:24 +0200 (CEST)
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com
 [220.197.31.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D93881AC
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MbSdARgGINZbA+LaiSngG4yp1cqBf7ylfEOaOPfpkR2bLqM1UCV8nbWAn9EblnzPtZzedIRtdTv8JgT5IcKDsNFkn3RSw17eRUhu3x99Us/tPl4QpQpWqxnoa1fdDFJtKh/1XT9pTQTs3CfRchCvt5ONBfUT2jzGTSKhXswfdIE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ENeyeyurfwfr97Dc5KR8f2nHMaN+fwGqM42FtP1iQz8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B3C6D900543;
 Thu,  6 Jun 2024 14:59:06 +0800 (CST)
Message-ID: <089848ad-c6d0-41d5-bdf6-b55f2cc73385@rock-chips.com>
Date: Thu, 6 Jun 2024 14:59:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] arm64: dts: rockchip: fix usb2phy nodename for
 rk3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-4-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-4-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8dTFZIHUJKTUseGE1JS0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec58188703a9kunmb3c6d900543
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6NDo*OTMMNDZKHi1PQhgo
 KB4KFChVSlVKTEpMTU5MSk9DS09KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITklDNwY+
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


On 2024/5/29 01:03, Jianfeng Liu wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> usb2-phy should be named usb2phy according to the DT binding,
> so let's fix it up accordingly.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Link: https://lore.kernel.org/r/20240408225109.128953-5-sebastian.reichel@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 4e07a95f7402de092cd71b2cb96c69f85c98f251 ]
>
> (cherry picked from commit 5a3e4638492497ae81b9bd4a8627f4727e312ccc)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index ac5bd630f15..87df0902273 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -599,7 +599,7 @@
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> -		u2phy2: usb2-phy@8000 {
> +		u2phy2: usb2phy@8000 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0x8000 0x10>;
>   			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -624,7 +624,7 @@
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> -		u2phy3: usb2-phy@c000 {
> +		u2phy3: usb2phy@c000 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0xc000 0x10>;
>   			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
