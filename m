Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6730ECD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 17:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CE784869;
	Tue,  9 Jun 2026 19:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zfEy0CEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303938486D; Tue,  9 Jun 2026 19:55:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8213384704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 19:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2121=EG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781027697;
 bh=FpoORA4fNWtjVdbln8IYBlOt/s7A568d+HkRfzMr+Sc=;
 b=zfEy0CEd/x+LMYh6MkQ9sVN3j4cvgGulUQ/bOmcsdWNjUah1npBgO/UkBk3s+SIJJrpc+5B2P
 dguiDym1X1Q1TFhuSpbtrHLtkYnuZ5CtxyaQpGRuXRkGztS7PZsohrc5fqbXr/4Tt5Srt+Aw3t+
 T3pZ6erfS4fl5zXEn8gRDoPHy9pnf7EMyM7AM0zPwtYx/kqNe+IkxZaf1g553ptjeKh5ohyoJok
 KAa8+dW8lHsLJAefQWJPd4Yp6boacjkgrbibb35CMN5UAZ5lVT8wB3YX8497MVKYwmYOgd+89Ec
 FBFwjGsRkkenms1Nqm6I0fgw1KJWhLbMy+on4aRimUSA==
X-Forward-Email-ID: 6a28536f6aea394eda20130d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.22
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
Date: Tue, 9 Jun 2026 19:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Alexey,

On 6/9/2026 6:52 PM, Alexey Charkov wrote:
> Modern Rockchip SoCs such as RK3576 require ATF to be running to provide
> firmware services to the OS. To enable booting Linux in Falcon mode on
> such SoCs, add binman support for generation of FIT images containing
> appropriately split ATF raw binaries (as is currently done by binman for
> U-boot proper images), externally preprocessed DTB and a Linux kernel.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  Makefile                           |   2 +
>  arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++++++++++++
>  tools/binman/etype/falcon_fdt.py   |  26 +++++++++
>  tools/binman/etype/linux_kernel.py |  22 ++++++++
>  4 files changed, 159 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 4e5c1dd6a1c4..844e5adb7b31 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1690,6 +1690,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>  		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>  		-a atf-bl1-path=${BL1} \
>  		-a atf-bl31-path=${BL31} \
> +		-a linux-kernel-path=${LINUX_KERNEL} \
> +		-a falcon-fdt-path=${FALCON_FDT} \
>  		-a tee-os-path=${TEE} \
>  		-a ti-dm-path=${TI_DM} \
>  		-a opensbi-path=${OPENSBI} \
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 4ba6a87e78ab..866a6ab654ca 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -161,6 +161,96 @@
>  			};
>  		};
>  	};
> +
> +#ifdef CONFIG_SPL_OS_BOOT
> +	fit_falcon_template: template-falcon {

Not sure it is possible, but this looks to add lots of duplicated
content. Could we try to re-use more, e.g. is it possible to extract
@atf-SEQ, and I also think we may want to support loading of TEE-OS?

> +		type = "fit";
> +		description = "FIT image for Falcon Linux with bl31 (TF-A)";
> +		#address-cells = <1>;
> +		fit,fdt-list-val = "u-boot";
> +		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> +		fit,align = <512>;
> +
> +		images {
> +			@atf-SEQ {
> +				fit,operation = "split-elf";
> +				description = "ARM Trusted Firmware";
> +				type = "firmware";
> +				arch = FIT_ARCH;
> +				os = "arm-trusted-firmware";
> +				compression = "none";
> +				fit,load;
> +				fit,entry;
> +				fit,data;
> +
> +				atf-bl31 {
> +				};
> +#ifdef FIT_HASH_ALGO
> +				hash {
> +					algo = FIT_HASH_ALGO;
> +				};
> +#endif
> +			};
> +
> +			kernel {
> +				description = "Linux kernel";
> +				type = "kernel";
> +				arch = FIT_ARCH;
> +				os = "linux";
> +				compression = "none";
> +				load = <0x48000000>;
> +				entry = <0x48000000>;

We should not hard-code these here, they seem to be RK3576 specific.

> +
> +				linux-kernel {
> +				};
> +#ifdef FIT_HASH_ALGO
> +				hash {
> +					algo = FIT_HASH_ALGO;
> +				};
> +#endif
> +			};
> +
> +			fdt-1 {
> +				description = "falcon-fdt";
> +				type = "flat_dt";
> +				arch = FIT_ARCH;
> +				compression = "none";
> +				load = <0x52000000>;

Same here.

> +
> +				falcon-fdt {
> +				};

If I am not mistaken we can already inject an external DT to be used as
control fdt during U-Boot build using EXT_DTB env, maybe it is better to
use that instead of passing in a new FDT?

We probably also want to use @fdt-SEQ and @config-SEQ to be able to
dynamically load a config based on e.g. board_fit_config_name_match()
that some boards already use to select config/fdt for U-Boot proper.

> +#ifdef FIT_HASH_ALGO
> +				hash {
> +					algo = FIT_HASH_ALGO;
> +				};
> +#endif
> +			};
> +		};
> +
> +		configurations {
> +			default = "config-1";
> +			@config-SEQ {
> +				description = "RK3576 Falcon Linux via ATF";

This is rockchip-u-boot.dtsi, drop RK3576 specific parts :-)

> +				fit,firmware = "atf-1", "kernel";
> +				fit,loadables;
> +				fdt = "fdt-SEQ";
> +#ifdef FIT_HASH_ALGO
> +				hash {
> +					algo = FIT_HASH_ALGO;
> +				};
> +#endif
> +			};
> +		};
> +	};
> +
> +	falcon-fit {
> +		filename = "u-boot-rockchip-falcon.itb";

Do we need to export this file? the old .itb-file is exported because
some distro build scripts or flash instructions still use the older
files instead of the preferred u-boot-rockchip.bin.

> +
> +		fit {
> +			insert-template = <&fit_falcon_template>;
> +		};
> +	};
> +#endif
>  #endif /* HAS_FIT */
>  
>  	simple-bin {
> @@ -260,6 +350,25 @@
>  		};
>  		};
>  	};
> +
> +#ifdef CONFIG_SPL_OS_BOOT
> +	simple-bin-usb472-falcon {

Do we really need this? As you notice the BootROM loader is not really
optimized for large payloads, I thought using a 1-2 MiB payload with
TF-A + U-Boot proper was stretching it, sending a full Linux kernel seem
like a big stretch, as evidenced by the 6 minute load time?

> +		filename = "u-boot-rockchip-usb472-falcon.bin";
> +		pad-byte = <0x00>;
> +
> +		u-boot-spl {
> +		};
> +
> +		payload {
> +			type = "section";
> +			align = <CONFIG_SYS_CACHELINE_SIZE>;

nit: blank line between props and nodes.

> +			u-boot-any {
> +				type = "fit";
> +				insert-template = <&fit_falcon_template>;
> +			};
> +		};
> +	};
> +#endif
>  #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
>  };
>  #endif /* CONFIG_SPL */
> diff --git a/tools/binman/etype/falcon_fdt.py b/tools/binman/etype/falcon_fdt.py
> new file mode 100644
> index 000000000000..7c5b13b60d05
> --- /dev/null
> +++ b/tools/binman/etype/falcon_fdt.py
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2026 Flipper FZCO
> +#
> +# Entry type for Linux DTB used in Falcon mode FIT images.
> +
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> +
> +
> +class Entry_falcon_fdt(Entry_blob_named_by_arg):
> +    """Falcon Linux DTB for Rockchip maskrom Falcon image
> +
> +    Properties / Entry arguments:
> +        - falcon-fdt-path: Filename containing the Falcon Linux DTB (optional,
> +            defaults to 'u-boot.dtb')
> +
> +    This allows selecting the Falcon DTB from an environment variable passed
> +    through binman entry arguments, while defaulting to the built U-Boot
> +    control DTB when not provided.
> +    """
> +
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'falcon-fdt')
> +        # Entry_blob defaults filename to etype when no filename is provided.
> +        # Treat that as "unset" and fall back to the control DTB.
> +        if not self._filename or self._filename == self.etype:
> +            self._filename = 'u-boot.dtb'
> diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/linux_kernel.py
> new file mode 100644
> index 000000000000..15a1da690c4f
> --- /dev/null
> +++ b/tools/binman/etype/linux_kernel.py
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2026 Flipper FZCO
> +#
> +# Entry-type module for Linux kernel binary blob
> +
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> +
> +
> +class Entry_linux_kernel(Entry_blob_named_by_arg):
> +    """Linux kernel image blob
> +
> +    Properties / Entry arguments:
> +        - linux-kernel-path: Filename of file to read into entry. This is
> +            typically an uncompressed ARM64 Image.
> +
> +    This entry allows binman FIT templates to consume a kernel provided via
> +    make variable, similar to how BL31 is passed to atf-bl31.
> +    """
> +
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'linux-kernel', required=True)
> +        self.external = True
> 

New binman etypes require new tests for 100% code coverage.

Also do we need to update Rockchip documentation to cover Falcon mode?

Regards,
Jonas
