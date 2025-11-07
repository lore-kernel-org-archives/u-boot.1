Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989EDCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B59C83CB9;
	Fri,  7 Nov 2025 11:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="fAkZVS7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BF483CDC; Fri,  7 Nov 2025 11:21:44 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E080D83CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1762510899;
 bh=IMc+wQBuJA5P5cEtzSeW3dpRoiYmyJQoajT7/8S3ToA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fAkZVS7/XQ9vZ2Yb+jTi8/tsxvO5zhQvIRzTLO9d1MQw5dGUCM9OVe6m4a76pHvXO
 HYEsmbqTWQYosoXglw9Apc0fSLDYZeTY5QRVWd+sA7MwOuXa04Oquxhmc21WxSQTPR
 3QNItSFzQNmIFR242nF71TElszHkRtIZYg7cOeQBp8fJD3/Eu6Z/83wthlssWMPQZI
 po3UyZBivAR3daorVyh3sTGSLaqOUaNKzhrv77qDJlWVK1RXPSKkkks+TsGTTihLw3
 GQPC9pBJcLE5TRj2Szw8zw0TvH+xRr2+auv+wUb/Tk/wK0uALUYSLcYbwHbTVD9N7O
 iqGGpWjUwG0EQ==
Received: from [192.168.2.54] (unknown [143.105.119.212])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EC625B22042C;
 Fri,  7 Nov 2025 11:21:37 +0100 (CET)
Message-ID: <6bacfc20-965d-4750-afd1-8421f4db0d8a@freeshell.de>
Date: Fri, 7 Nov 2025 02:21:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, E Shattow <e@freeshell.de>
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <dd079318-795e-46a9-8123-2e8b7c5758fd@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <dd079318-795e-46a9-8123-2e8b7c5758fd@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 11/7/25 01:00, Heinrich Schuchardt wrote:
> 
> Hello Hal, hello Minda,
> 
> Marek created the patch below, to find differences between Linux device-
> tree and what U-Boot uses.
> 
> For all JH7110 boards I find these differences which are due to arch/
> riscv/dts/starfive-visionfive2-u-boot.dtsi. Could you, please, check if
> these are still intended:
> 
> @@ -533,7 +617,7 @@
>              #clock-cells = <0x1>;
>              #reset-cells = <0x1>;
>              assigned-clock-parents = <0x28 0x0 0x28 0x2 0x28 0x2 0x3
> 0x59>;
> -            assigned-clock-rates = <0x0 0x0 0x0 0x0 0x1dcd6500
> 0x59682f00>;
> +            assigned-clock-rates = <0x0>;
>              assigned-clocks = <0x3 0x0 0x3 0x5 0x3 0x4 0x3 0x5a 0x3 0x1
> 0x28 0x0>;
>              bootph-pre-ram;
>              clock-names = "osc", "gmac1_rmii_refin",
> "gmac1_rgmii_rxin", "i2stx_bclk_ext", "i2stx_lrck_ext",
> "i2srx_bclk_ext", "i2srx_lrck_ext", "tdm_ext", "mclk_ext", "pll0_out",
> "pll1_out", "pll2_out";
> @@ -996,6 +1080,7 @@
> 
>          memory-controller@15700000 {
>              bootph-pre-ram;
> +            clock-frequency = <0x855>; // 2133 MHz
>              clock-names = "pll";
>              clocks = <0x3 0x1>;
>              compatible = "starfive,jh7110-dmc";
> 
> Best regards
> 
> Heinrich
> 
> 
> -------- Forwarded Message --------
> Subject: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
> augmented DT if DEVICE_TREE_DEBUG=1
> Date: Thu,  6 Nov 2025 22:08:18 +0100
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> To: u-boot@lists.denx.de
> CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Adriano Cordova
> <adrianox@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
> Apalodimas <ilias.apalodimas@linaro.org>, Peter Robinson
> <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>, Tom Rini
> <trini@konsulko.com>
> 
> In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
> DT with U-Boot extras, to show how much does the U-Boot DT differ from
> the base DT. This is particularly useful together with OF_UPSTREAM, to
> minimize the diff between upstream DTs and U-Boot DTs.
> 
> Example usage:
> $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=1
> $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff
> 
> This still has a downside. Even 'dtc -I dts -O dts ...' applied on
> base DT and U-Boot augmented DT can produce different phandle IDs
> for the same node in those two DTs, which results in a lot of noise
> in the resulting diff. The only way I can think of is to patch DTC
> to emit full paths in those phandles instead, something like a
> phandle = <&{/full/path/to/remote/end} ...>;
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  scripts/Makefile.lib | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5db2fbc418a..2d8bf3c04f4 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -386,10 +386,31 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
>  DTC_FLAGS += -@
>  endif
>  +# In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT
> and
> +# DT with U-Boot extras, to show how much does the U-Boot DT differ from
> +# the base DT. This is particularly useful together with OF_UPSTREAM, to
> +# minimize the diff between upstream DTs and U-Boot DTs.
> +ifdef DEVICE_TREE_DEBUG
> +cmd_dtc_diff = \
> +    $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o
> $(dtn-tmp) $< ; \
> +    $(DTC) -s -O dts -o $@.clean.dts -b 0 \
> +        -i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
> +        (echo "Check $(shell pwd)/$< for errors" && false); \
> +    $(DTC) -s -O dts -o $@.full.dts -b 0 \
> +        -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
> +        (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
> +    (diff -Naru $@.clean.dts $@.full.dts > $@.diff || true)
> +
> +dtn-tmp = $(subst $(comma),_,$(dot-target).dtn.tmp)
> +else
> +cmd_dtc_diff =
> +endif
> +
>  quiet_cmd_dtc = DTC     $@
>  # Modified for U-Boot
>  # Bring in any U-Boot-specific include at the end of the file
>  # And finally any custom .dtsi fragments specified with
> CONFIG_DEVICE_TREE_INCLUDES
> +
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>      (cat $< > $(pre-tmp)); \
>      $(foreach f,$(subst $(quote),,$(dtsi_include_list)
> $(CONFIG_DEVICE_TREE_INCLUDES)), \
> @@ -400,7 +421,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>          -d $(depfile).dtc.tmp $(dtc-tmp) || \
>          (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>          ; \
> -    sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp >
> $(depfile)
> +    sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp >
> $(depfile) ; \
> +    $(cmd_dtc_diff)
>   dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst
> $(quote),,$(dtsi_include_list)))
>  -- 2.51.0
> 

Neither property is valid and should be removed, but the drivers need to
be fixed/implemented. For both matters please refer to discussion at:

https://lore.kernel.org/u-boot/ZQ2PR01MB13075C0C6A214EC48174F248E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/

-E
