Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F7D44D41
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403DF891A4;
	Wed,  6 Nov 2024 11:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KtU2+rCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE42B891CD; Wed,  6 Nov 2024 11:14:14 +0100 (CET)
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com
 [101.71.155.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CD288DB6
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f7e3e56;
 Wed, 6 Nov 2024 18:14:08 +0800 (GMT+08:00)
Message-ID: <9c15211f-01fc-4777-89f3-d25a96a4210e@rock-chips.com>
Date: Wed, 6 Nov 2024 18:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk3288: Use rk3288-power.h from dts/upstream
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241104205906.986837-1-jonas@kwiboo.se>
 <20241104205906.986837-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241104205906.986837-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRodHlYfGEkaSxkeQkIaHRpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300f79e4e03afkunm1f7e3e56
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6ARw*NDIiKDEfGTVLTFYI
 MlZPCSJVSlVKTEhLQ0NDS09DQkxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTU9JNwY+
DKIM-Signature: a=rsa-sha256;
 b=KtU2+rCHzbCNKViw+jo3GpTlDDRDKYlDPAPMDL9ALLLGG5A9vx00opSel+TVYjz+sGhhaSCq7Em886mfbIZT55Jkqs9kI4xEHIbYj2grhIH4TWCrvcCZbIc0CGBHuUMsJ1Cj35VnMAri8R8smYoCzQUClhWc2B/pxFBpnLcv+Nc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=aceZQtsCG8nr3mW8P4Xq/9qprjC5Abtpaf7uNdRD+HQ=;
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


On 2024/11/5 04:58, Jonas Karlman wrote:
> power/rk3288-power.h in include/dt-bindings is identical to the version
> in dts/upstream, remove the copy from include/dt-bindings to only use
> the version from dts/upstream.
>
> No functional change to board DTs is intended with this removal.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/dt-bindings/power/rk3288-power.h | 32 ------------------------
>   1 file changed, 32 deletions(-)
>   delete mode 100644 include/dt-bindings/power/rk3288-power.h
>
> diff --git a/include/dt-bindings/power/rk3288-power.h b/include/dt-bindings/power/rk3288-power.h
> deleted file mode 100644
> index f710b56ccd81..000000000000
> --- a/include/dt-bindings/power/rk3288-power.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __DT_BINDINGS_POWER_RK3288_POWER_H__
> -#define __DT_BINDINGS_POWER_RK3288_POWER_H__
> -
> -/**
> - * RK3288 Power Domain and Voltage Domain Summary.
> - */
> -
> -/* VD_CORE */
> -#define RK3288_PD_A17_0		0
> -#define RK3288_PD_A17_1		1
> -#define RK3288_PD_A17_2		2
> -#define RK3288_PD_A17_3		3
> -#define RK3288_PD_SCU		4
> -#define RK3288_PD_DEBUG		5
> -#define RK3288_PD_MEM		6
> -
> -/* VD_LOGIC */
> -#define RK3288_PD_BUS		7
> -#define RK3288_PD_PERI		8
> -#define RK3288_PD_VIO		9
> -#define RK3288_PD_ALIVE		10
> -#define RK3288_PD_HEVC		11
> -#define RK3288_PD_VIDEO		12
> -
> -/* VD_GPU */
> -#define RK3288_PD_GPU		13
> -
> -/* VD_PMU */
> -#define RK3288_PD_PMU		14
> -
> -#endif
