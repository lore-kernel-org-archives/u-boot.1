Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6B8E7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DFB80352;
	Thu,  2 Jan 2025 09:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="S1icQ4En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7FD80374; Thu,  2 Jan 2025 09:54:28 +0100 (CET)
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com
 [220.197.32.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283F980196
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77de8bcb;
 Thu, 2 Jan 2025 16:54:20 +0800 (GMT+08:00)
Message-ID: <74925df0-12bc-4cf7-b856-58e0cb37f87e@rock-chips.com>
Date: Thu, 2 Jan 2025 16:54:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: rockchip: sort props in pmu_io_domains
 node for NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-5-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-5-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJMHlYYT0hCTUgZTkofQklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a9426390e4903afkunm77de8bcb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Cgw5DDIQAyhWCU49NDMV
 NB4wCQtVSlVKTEhOQ0tDS01JSkxKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSENDNwY+
DKIM-Signature: a=rsa-sha256;
 b=S1icQ4EnkewCYPsyfvUWVgpZVmmQOYh7N+xL+pE46Lf+AH8Rsxi8RqCwnoN40A4vxs0alrW0H6+OOCYnkswgwm2d6NIs2bPI92hT/3ysylqtZY2tpLn2EzncKEJSK4U17v/fzDDNNdaHZ1Be5VoeeEIteaqhmM/2WgjzwXeiMJU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=isSGWdaoAvJln8G8nkDV4kZfyTtPV0u7G6Xywqymitc=;
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


On 2024/12/26 17:20, Tianling Shen wrote:
> The status prop is typically the last prop.
>
> Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> Link: https://lore.kernel.org/r/20241022193537.1117919-4-cnsztl@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 17e150fdd983c7e59b9240e34a166285f3c3fb39 ]
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> index 66a00cddda..243574f8da 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> @@ -476,7 +476,6 @@
>   };
>   
>   &pmu_io_domains {
> -	status = "okay";
>   	pmuio1-supply = <&vcc3v3_pmu>;
>   	pmuio2-supply = <&vcc3v3_pmu>;
>   	vccio1-supply = <&vccio_acodec>;
> @@ -486,6 +485,7 @@
>   	vccio5-supply = <&vcc_1v8>;
>   	vccio6-supply = <&vcc_3v3>;
>   	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
>   };
>   
>   &sdhci {
