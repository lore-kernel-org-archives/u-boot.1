Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061FAE64007
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3DC839DF;
	Mon, 13 Apr 2026 13:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEZgckjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC14B83DC9; Mon, 13 Apr 2026 13:27:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF9C839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BCF442E2F;
 Mon, 13 Apr 2026 11:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C686C116C6;
 Mon, 13 Apr 2026 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776079616;
 bh=s6ZPJlTbY0jT5QtFtOCUw8ABRtzqlTmuvVZpYAompKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BEZgckjgKwd14VjxAmOUuNhZUejL/lWyEUibh/UvLbQXUemOJC5joYNmMkXhePCYj
 S7VRNPT4i8r65mdhaO0F87VXJ9g/GQAKyPToLQ3NSobIRP4qKdaH6BsvO8EpslE+uS
 AjOAmJ5ECLzjtLsJ7OayVZYcZrcz2TKK7dLtYZTDgQZ+84qXJdV4EQTgZidWGUJ3fX
 hGWntvr9X80bkEutRYtovmLLUjfepGBwjqgfu5d0V94fs9Hy0w0gRNJh6CiJ7Cg4JW
 4XL+/YSfZQL3kcAu9ij0WaPRoXizpMTFUs8gYTvUcqGkjVv5TBE9dejeNnp4HaxBiZ
 2CQYVPU+tEJ3A==
Date: Mon, 13 Apr 2026 16:56:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com,
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org,
 marek.vasut+renesas@mailbox.org, hs@nabladev.com, msp@baylibre.com,
 ravi@prevas.dk, dinesh.maniyam@altera.com,
 sajattack@postmarketos.org, peng.fan@nxp.com,
 quentin.schulz@cherry.de, jamie.gibbons@microchip.com,
 mateuslima.ti@gmail.com, justin@tidylabs.net, wens@kernel.org,
 n-francis@ti.com, ycliang@andestech.com, jerome.forissier@arm.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 4/7] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode
 support
Message-ID: <adzS9Ji2iQ7Q-gXX@sumit-xelite>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
 <20260408121841.186410-5-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408121841.186410-5-aswin.murugan@oss.qualcomm.com>
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

On Wed, Apr 08, 2026 at 05:48:38PM +0530, Aswin Murugan wrote:
> The PM8150 PMIC on this platform uses the older PON (Power On) register
> architecture rather than dedicated SDAM regions found in newer PMIC
> generations. To enable reboot-mode functionality with the unified
> NVMEM-based approach, add a compatibility wrapper that exposes PON
> registers through the SDAM NVMEM interface.
> 
> Add device tree configuration:
> - NVMEM node with compatible "qcom,spmi-sdam" wrapping PON registers
> - Uses 'ranges' property to map the PON register block at offset 0x800
> - NVMEM cell at offset 0x8F (PON_SOFT_RB_SPARE register)
> - 7-bit field (bits [7:1]) for reboot reason, preserving bit 0
> - Mode mappings: bootloader=0x02, recovery=0x01
> 
> This wrapper allows the SDAM NVMEM driver to access PON registers
> transparently, providing a unified interface for both PON-based (older)
> and SDAM-based (newer) PMIC generations.
> 
> The PON_SOFT_RB_SPARE register persists across warm resets and is
> automatically cleared on power cycle.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v4:
> 1. Changed bits property as 'bits = <1 7>'
> 
> Changes in v3:
> 1. No change in v3
> ---
>  arch/arm/dts/qcs615-ride-u-boot.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> index 68fffc70fcb..687e9a67a9f 100644
> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,30 @@
>  		      <0x0 0xc0000000 0x0 0xc0000000>,
>  		      <0x1 0x80000000 0x1 0x00000000>;
>  	};
> +
> +	reboot-mode {
> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +
> +		mode-bootloader = <0x02>;
> +		mode-recovery   = <0x01>;
> +	};
> +};
> +
> +&pm8150_0 {
> +	/* Virtual NVMEM node for PON-based reboot reason storage */
> +	nvram@800 {
> +		compatible = "qcom,spmi-sdam";
> +		reg = <0x800>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x800 0x100>;
> +
> +		/* Reboot reason cell at PON_SOFT_RB_SPARE (0x88F) */
> +		reboot_reason: reboot-reason@8f {
> +			reg = <0x8f 0x1>;
> +			bits = <1 7>;
> +		};
> +	};

Please push this DTS feature patch to upstream kernel. There has to be
proper DT bindings for new compatible being added.

-Sumit
