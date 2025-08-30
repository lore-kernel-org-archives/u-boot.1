Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5892ECA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC48838E5;
	Sat, 30 Aug 2025 17:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TxvxPRso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA3A838EC; Sat, 30 Aug 2025 17:27:29 +0200 (CEST)
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com
 [117.135.214.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0069E8341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98ed;
 Sat, 30 Aug 2025 23:27:21 +0800 (GMT+08:00)
Message-ID: <bd6755c5-e651-4a81-8c15-62157343bbb9@rock-chips.com>
Date: Sat, 30 Aug 2025 23:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: add header for RK8XX PMIC
 constants
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
 <20250813-rk8xx-rst-fun-v2-2-a2223e17cb2c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250813-rk8xx-rst-fun-v2-2-a2223e17cb2c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb971d3003afkunmf81b6dbf4161cb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUNDVhlJSkkYTxhKS01ISlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=TxvxPRso5dkpPo6M9SbhH2IBYOCm7YEa+0VdNoJNxsO04SFGL93EKNps2pyCigQuC1vq3KocukCO+9gnmDARgjQhSrWgjPoUoDwNHCN4QAulmm/1RQPr10xUzqjQ53kUDtojVdawOyN+J69sezXy1FC6Pt1G6mIF4yOK+e7VHR0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=M/US4LthPcPvHEH3dNYY+Hhys36vP0PWPUi5WG9x4+U=;
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


On 2025/8/13 22:07, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> To make it easier to read the device tree, let's add constants for the
> rockchip,reset-mode property values that are currently only applicable
> to RK806 PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> [dt-maintainers did not consider this part of the binding, so we're
>   keeping the header in the devicetree directory]
> Link: https://lore.kernel.org/r/20250627-rk8xx-rst-fun-v4-3-ce05d041b45f@cherry.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 304be20e65ca08fc2e9cb58eb939a0054d8a8b81 ]
>
> (cherry picked from commit 0e417bfcbc385c127c7f5ea01df6289aed8325c2)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk8xx.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk8xx.h b/dts/upstream/src/arm64/rockchip/rk8xx.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a6fbef71c06493c35b0f3697476167aaafa24f30
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk8xx.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
> +/*
> + * Device Tree defines for Rockchip RK8xx PMICs
> + *
> + * Copyright 2025 Cherry Embedded Solutions GmbH
> + *
> + * Author: Quentin Schulz <quentin.schulz@cherry.de>
> + */
> +
> +#ifndef _DT_MFD_ROCKCHIP_RK8XX_H
> +#define _DT_MFD_ROCKCHIP_RK8XX_H
> +
> +/* For use with rockchip,reset-mode property */
> +#define RK806_RESTART		0
> +#define RK806_RESET		1
> +#define RK806_RESET_NOTIFY	2
> +
> +#endif
>
