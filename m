Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDBCC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8CE87C68;
	Mon, 11 Mar 2024 10:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gOerLotf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FAC87EF5; Mon, 11 Mar 2024 10:40:50 +0100 (CET)
Received: from mail-m19731101.qiye.163.com (mail-m19731101.qiye.163.com
 [220.197.31.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F858780E
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gOerLotfm573sJEaVo6UKs4KlmX1yAMIYDJXi+d4eQCMwECS0CRyLGq+oyJ7sTrdeZgGGY6cdOR3SeMqffod/3W+zCGBzQV9uN+Q7sMg6nfFE418hhixnFyyAXdDEKjfkJq43xqwqU5LTbGK6+tBts4qG/9jSBz7JuKPoL/fGS8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=7EUdg6GA/hVqg054GboDdYZy8epIiVWW2YmgULk6REI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1915C900411;
 Mon, 11 Mar 2024 17:40:29 +0800 (CST)
Message-ID: <c452cf93-066f-4a3f-9e03-c9e126e72a20@rock-chips.com>
Date: Mon, 11 Mar 2024 17:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm: rockchip: sync ROCK Pi 4A DTS from Linux
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
Cc: kernel@collabora.com,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240302143417.164560-1-chris.obbard@collabora.com>
 <20240302143417.164560-2-chris.obbard@collabora.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240302143417.164560-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1NTlYfTEwYTEkeQ0gfS0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2ce2909f03a9kunm1915c900411
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Eww*NjMJDjAoIzM#SixN
 ClEKCi5VSlVKTEpLSk5LS0lCTENOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUtMNwY+
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


On 2024/3/2 22:34, Christopher Obbard wrote:
> To prepare for ROCK Pi 4A SPI flash support, sync the DTS from Linux which
> includes an SPI flash node.
>
> Kernel tag: v6.6-rc1
> Kernel commits:
>   - eddf73029770 ("arm64: dts: rockchip: Enable internal SPI flash for ROCK \
>                    Pi 4A/B/C")
>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   arch/arm/dts/rk3399-rock-pi-4a.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts b/arch/arm/dts/rk3399-rock-pi-4a.dts
> index 931334aa3d6..d5df8939a65 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4a.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
> @@ -12,3 +12,13 @@
>   	model = "Radxa ROCK Pi 4A";
>   	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
>   };
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
