Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07625C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB768291D;
	Fri,  6 Jun 2025 11:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bX9U5LQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCD88291D; Fri,  6 Jun 2025 11:20:42 +0200 (CEST)
Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com
 [220.197.32.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A51803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c35c137;
 Fri, 6 Jun 2025 17:20:33 +0800 (GMT+08:00)
Message-ID: <ef282298-b056-4024-8ed6-28584da035b9@rock-chips.com>
Date: Fri, 6 Jun 2025 17:20:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] rockchip: io-domain: Add
 CONFIG_SPL_ROCKCHIP_IODOMAIN
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Anand Moon <linux.amoon@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250523165406.40915-1-justin@tidylabs.net>
 <20250523165406.40915-3-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250523165406.40915-3-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU8eVh0YT0pIGENLSk9DSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448ac1ff03afkunmea05b0551ebfb7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6Ehw6KDE5ExlMDksPSA5R
 HC0aChpVSlVKTE9CSUtKTUhNTkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlPSk43Bg++
DKIM-Signature: a=rsa-sha256;
 b=bX9U5LQZa4xjhRnl6CuVzNm+IAQjZNPOkkSkfjiDe4OGGpWNCgSGBS3IFEb4TxJJO5D98oEDtm8vWp7Jb2DxgFBD9q5Z8rK3YAT29btYNxsRRFkQ/X1JOzKwm9qgZw3Pq5aQLdjhVDapaEPuNHmFZ3jQ6YzutuMlDSDC+rT2TUc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=gs165ifat49em/2kIboB2DFsJaSAqRkFHE4cjITDoqo=;
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


On 2025/5/24 00:53, Justin Klaassen wrote:
> Allows use of the Rockchip IO-domain driver in SPL to configure
> the GPIO to match the voltage supplied by specific regulators
> (e.g. "vcc_sdio").
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add depends on SPL_DM_REGULATOR
>
> Changes in v2:
> - Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig
>
>   drivers/misc/Kconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ffc5868c0dd..8b8f6309ada 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -114,6 +114,14 @@ config ROCKCHIP_IODOMAIN
>   	  for the IO-domain setting of the SoC to match the voltage supplied
>   	  by the regulators.
>   
> +config SPL_ROCKCHIP_IODOMAIN
> +	bool "Rockchip IO-domain driver support in SPL"
> +	depends on SPL_MISC && SPL_DM_REGULATOR && ARCH_ROCKCHIP
> +	help
> +	  Enable support for IO-domains in Rockchip SoCs in SPL. It is necessary
> +	  for the IO-domain setting of the SoC to match the voltage supplied
> +	  by the regulators.
> +
>   config SIFIVE_OTP
>   	bool "SiFive eMemory OTP driver"
>   	depends on MISC
