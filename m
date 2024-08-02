Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B700AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C4A88B81;
	Fri,  2 Aug 2024 08:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VZ9IOEi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFF188B89; Fri,  2 Aug 2024 08:18:55 +0200 (CEST)
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com
 [45.254.49.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D0387C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VZ9IOEi7nn9992V2ND2LWjV+jiP3MYg5EwiXCZYxOE6SPAHgXKuqhprt+uAv8GCIIi/UymuvKZuZOskSa2VXd/8JJMg2iSA/UAHBw2/Cz5aEMWMmU55DVkMTxztiOTRIim6a4Tmpr5/EEjmzSgRJBH4g9IkdjnDM6p1bYj1Chiw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Yt8iMbkWTdbNlRrBPcGV6qR9vu3zGX5XkpdAruLbMug=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 09F4B900486;
 Fri,  2 Aug 2024 14:18:40 +0800 (CST)
Message-ID: <81a1bbe7-33fe-4b95-9656-f0680897448b@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: rockchip: Add io-domains to
 rk3308-rock-pi-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhKSlZNGUsfHRoaGElMQh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bd90c003a9kunm09f4b900486
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6Mzo*CzIxLSIDEgMMFDki
 PkswCRVVSlVKTElJTkxCTklJSElOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0NMNwY+
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


On 2024/7/30 22:51, Jonas Karlman wrote:
> The VCCIO4 io-domain used for WiFi/BT is using 1v8 IO signal voltage.
>
> Add io-domains node with the VCCIO supplies connected on the board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-13-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 100b3bdee6035192f6d4a1847970fe004bb505fb ]
>
> (cherry picked from commit f93b224359278728f01767a4701678ada9c25570)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> index f6fb90e13ad0..5c702f00b27f 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> @@ -231,6 +231,16 @@
>   	status = "okay";
>   };
>   
> +&io_domains {
> +	vccio0-supply = <&vcc_io>;
> +	vccio1-supply = <&vcc_io>;
> +	vccio2-supply = <&vcc_io>;
> +	vccio3-supply = <&vcc_io>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
>   &pinctrl {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&rtc_32k>;
