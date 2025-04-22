Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF52C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5726381E25;
	Tue, 22 Apr 2025 16:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d/jAwlxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF10281E25; Tue, 22 Apr 2025 16:52:52 +0200 (CEST)
Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com
 [220.197.31.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A87C81273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b460;
 Tue, 22 Apr 2025 22:52:44 +0800 (GMT+08:00)
Message-ID: <f843f5fc-cfe5-4e5b-bfe9-0e3193716e68@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] arm64: dts: rockchip: add rk3576 otp node
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-13-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-13-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0seVkpLSB4ZHR1PTEtIHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfcb5c503afkunm12bf5b460
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Mzo*CTJWFkkyEQEJAysh
 MRFPCjNVSlVKTE9OSEhITk1NSENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUhKS083Bg++
DKIM-Signature: a=rsa-sha256;
 b=d/jAwlxW7qU/KGf0dTJZplzTn7oYKg5FvxgHKClFbCRtDt5N+9NBARk24B/LwGe8ifrGVNIru82rpWROPwhdv/Z7XlKIm0N5hOpkxmgj+i8McSMECs+l29OMVrbhlOD51poe5wvY0d6Z6fUpUGyNfTtbOCzwah2ODByMWNREOVo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=kwUFEC1eXT1m4i33VvBHHayxVETODkq96rnLXyo76xk=;
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
> This adds the otp node to the rk3576 soc devicetree including the
> individual fields we know about.
>
> Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20250210224510.1194963-7-heiko@sntech.de

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> [ upstream commit: 8715d2eeb062f6859c252bb6c87b363230b66e9f ]
>
> (cherry picked from commit d67cf6de8aacb4abcdfb516eeb8a511a4a657bc1)
> ---
>   dts/upstream/src/arm64/rockchip/rk3576.dtsi | 39 +++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> index 4dde954043e..29b47799849 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> @@ -1260,6 +1260,45 @@
>   			status = "disabled";
>   		};
>   
> +		otp: otp@2a580000 {
> +			compatible = "rockchip,rk3576-otp";
> +			reg = <0x0 0x2a580000 0x0 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
> +				 <&cru CLK_OTP_PHY_G>;
> +			clock-names = "otp", "apb_pclk", "phy";
> +			resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>;
> +			reset-names = "otp", "apb";
> +
> +			/* Data cells */
> +			cpu_code: cpu-code@2 {
> +				reg = <0x02 0x2>;
> +			};
> +			otp_cpu_version: cpu-version@5 {
> +				reg = <0x05 0x1>;
> +				bits = <3 3>;
> +			};
> +			otp_id: id@a {
> +				reg = <0x0a 0x10>;
> +			};
> +			cpub_leakage: cpub-leakage@1e {
> +				reg = <0x1e 0x1>;
> +			};
> +			cpul_leakage: cpul-leakage@1f {
> +				reg = <0x1f 0x1>;
> +			};
> +			npu_leakage: npu-leakage@20 {
> +				reg = <0x20 0x1>;
> +			};
> +			gpu_leakage: gpu-leakage@21 {
> +				reg = <0x21 0x1>;
> +			};
> +			log_leakage: log-leakage@22 {
> +				reg = <0x22 0x1>;
> +			};
> +		};
> +
>   		gic: interrupt-controller@2a701000 {
>   			compatible = "arm,gic-400";
>   			reg = <0x0 0x2a701000 0 0x10000>,
