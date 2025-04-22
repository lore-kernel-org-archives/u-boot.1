Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B23C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25F080FA8;
	Tue, 22 Apr 2025 16:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KZmsBxJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22D58059A; Tue, 22 Apr 2025 16:53:03 +0200 (CEST)
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com
 [220.197.32.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F7A82045
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b468;
 Tue, 22 Apr 2025 22:52:54 +0800 (GMT+08:00)
Message-ID: <27ca07f2-f419-4221-a5a2-19ad737d2076@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3576-PC binding
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 "Rob Herring (Arm)" <robh@kernel.org>
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-14-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-14-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0MfVklCH0pOH0gZTkhNGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfcdd4e03afkunm12bf5b468
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6MTo*FDJCEklPEQwDAz0f
 LS5PCixVSlVKTE9OSEhITkxNT0pKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlJT0M3Bg++
DKIM-Signature: a=rsa-sha256;
 b=KZmsBxJ22Vkqr1jL7hioUaV+Bq5xCvm33VtjImWdv2hfJJiCluT52/rY8B4CfMsyJx/ZXW8bxngkB7N8PfwFOb2hoc1pxHGVtkfUvRPe4E1DbWWcoBsxKLzih96czj6efQLqYj0Ex18R9INSENxy/4X56SVo1igNt6lCDAGwDSc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CPz5A34wLoLMt39IFxRHMKHfMvJWlC6IEBEmZU/If5o=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Add devicetree binding for the ROC-RK3576-PC SBC.
>
> The board is based on the RK3576 SoC (4*Cortex-A72 + 4*Cortex-A53).
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20250210205126.1173631-2-heiko@sntech.de
>
> [ upstream commit: 2be4a4171401761cb5fb02225d8b18351f6807c0 ]
>
> (cherry picked from commit 89026942ddd0475d78b11b019285fff0c1d47266)

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/Bindings/arm/rockchip.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
> index 522a6f0450e..0f4ca08d9ae 100644
> --- a/dts/upstream/Bindings/arm/rockchip.yaml
> +++ b/dts/upstream/Bindings/arm/rockchip.yaml
> @@ -236,6 +236,11 @@ properties:
>                 - firefly,roc-rk3399-pc-plus
>             - const: rockchip,rk3399
>   
> +      - description: Firefly ROC-RK3576-PC
> +        items:
> +          - const: firefly,roc-rk3576-pc
> +          - const: rockchip,rk3576
> +
>         - description: Firefly Station M2
>           items:
>             - const: firefly,rk3566-roc-pc
