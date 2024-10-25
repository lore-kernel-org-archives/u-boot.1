Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60658D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7299B888EB;
	Fri, 25 Oct 2024 13:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y8/g+QtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F82B8901D; Fri, 25 Oct 2024 13:58:49 +0200 (CEST)
Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com
 [220.197.31.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B8288FAA
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5822;
 Fri, 25 Oct 2024 19:58:38 +0800 (GMT+08:00)
Message-ID: <68f0cb1b-434d-4329-8c6d-e6589e0c6e05@rock-chips.com>
Date: Fri, 25 Oct 2024 19:58:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] arm64: dts: rockchip: add stdout path on
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-6-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-6-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxPQlZLGhpMHx4dTB4aTkNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38afc6009d6kunmebe5822
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgg6Ihw6GjIsORcaOQgYLzxN
 OStPFAhVSlVKTElCQ05MTkpCT0hKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUxNNwY+
DKIM-Signature: a=rsa-sha256;
 b=Y8/g+QtPfW99eeb2acK/RGf3ycfWdDvuzKmQKBmSCbGzxKaMlFVtWJYanaCuhOdoF+5lAd2MQiwXu3VsHM/q3z/ufy/0fYu3p/376basE6BIc//iCZKvDCuOvqi4y8dfKsgt0QSt3YITofhDwM6EN9SfArb24dLEF5XPLzobYmc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=w3YXnhCfuvZ9RClwzlKo+askTa64nAj7yYGQQ0LNQEM=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> As most Rockchip boards do, the TS433 also uses uart2 for its serial
> output. Set the correct chosen entry for it.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-6-heiko@sntech.de
>
> [ upstream commit: e1cb5d8a92e41171bf4d5ddc459bd96372500901 ]
>
> (cherry picked from commit 1e1af2af2192490a3d174624ac1bb976aa6afffa)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index da735c4764f..be1c2286c2d 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -13,6 +13,10 @@
>   	model = "Qnap TS-433-4G NAS System 4-Bay";
>   	compatible = "qnap,ts433", "rockchip,rk3568";
>   
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
>   	dc_12v: regulator-dc-12v {
>   		compatible = "regulator-fixed";
>   		regulator-name = "dc_12v";
