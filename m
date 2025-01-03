Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE20E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDE280079;
	Fri,  3 Jan 2025 04:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iIw7dfi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026338034E; Fri,  3 Jan 2025 04:08:43 +0100 (CET)
Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com
 [115.236.127.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF6F6803AB
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 791518e1;
 Fri, 3 Jan 2025 11:08:34 +0800 (GMT+08:00)
Message-ID: <7489d750-beb6-4a4f-a626-507f2480152b@rock-chips.com>
Date: Fri, 3 Jan 2025 11:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] dt-bindings: power: Add support for RK3576 SoC
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-4-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241121142731.1202209-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxITlYdShhPQ0wfTEMfGEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a22d79e03afkunm791518e1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6Kzo4EDIRSC0BEjcsMA4Y
 PwowCgFVSlVKTEhOQ0xITEpNS0xNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0hPNwY+
DKIM-Signature: a=rsa-sha256;
 b=iIw7dfi4o1SVN7WnY4y2m7pMr5GAYPm2teFaA2YDAg8mQC551QfmIjrXQkcXfNVvLYolpR3GFrhVNaroP8JmyxmEZgNeuyjjBznmupq96FuDEGQ8ZIywU/3YlqJLCMI9RzxkENS3k+JfpwgaUtYOX9tnkv1Hr8b8bHVamNBEnjw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2geKTOAq+7mrsEHH+7o8qkub+nA4ay4cM8GAhVR8urg=;
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


On 2024/11/21 22:27, Heiko Stuebner wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> Define power domain IDs as described in the TRM and add compatible for
> rockchip,rk3576-power-controller
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Co-Developed-by: Detlev Casanova <detlev.casanova@collabora.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20240814222824.3170-2-detlev.casanova@collabora.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> [ upstream commit: 77c5e7b623032502ee49fe7e7868eaca6786d7ed ]
>
> (cherry picked from commit 4f3821f3803953f291bbc957dc5a8aaa3f61e1d3)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../power/rockchip,power-controller.yaml      |  1 +
>   .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
>
> diff --git a/dts/upstream/Bindings/power/rockchip,power-controller.yaml b/dts/upstream/Bindings/power/rockchip,power-controller.yaml
> index 0d5e999a58f..650dc0aae6f 100644
> --- a/dts/upstream/Bindings/power/rockchip,power-controller.yaml
> +++ b/dts/upstream/Bindings/power/rockchip,power-controller.yaml
> @@ -41,6 +41,7 @@ properties:
>         - rockchip,rk3368-power-controller
>         - rockchip,rk3399-power-controller
>         - rockchip,rk3568-power-controller
> +      - rockchip,rk3576-power-controller
>         - rockchip,rk3588-power-controller
>         - rockchip,rv1126-power-controller
>   
> diff --git a/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h b/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
> new file mode 100644
> index 00000000000..324a056aa85
> --- /dev/null
> +++ b/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3576_POWER_H__
> +
> +/* VD_NPU */
> +#define RK3576_PD_NPU		0
> +#define RK3576_PD_NPUTOP	1
> +#define RK3576_PD_NPU0		2
> +#define RK3576_PD_NPU1		3
> +
> +/* VD_GPU */
> +#define RK3576_PD_GPU		4
> +
> +/* VD_LOGIC */
> +#define RK3576_PD_NVM		5
> +#define RK3576_PD_SDGMAC	6
> +#define RK3576_PD_USB		7
> +#define RK3576_PD_PHP		8
> +#define RK3576_PD_SUBPHP	9
> +#define RK3576_PD_AUDIO		10
> +#define RK3576_PD_VEPU0		11
> +#define RK3576_PD_VEPU1		12
> +#define RK3576_PD_VPU		13
> +#define RK3576_PD_VDEC		14
> +#define RK3576_PD_VI		15
> +#define RK3576_PD_VO0		16
> +#define RK3576_PD_VO1		17
> +#define RK3576_PD_VOP		18
> +
> +#endif
