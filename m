Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5FFC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 05:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A4F87D2C;
	Fri,  1 Mar 2024 06:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JvG41sxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860A587D06; Fri,  1 Mar 2024 06:26:52 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BB287D06
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 06:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4215Qd24017345;
 Thu, 29 Feb 2024 23:26:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709270799;
 bh=GlOLzW/Y48VFPZJKdSQgJzukCU9IBRddRRPuuODPpDw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JvG41sxCBWBdrxE2ycMsyVzJDz6rkIh7hQfltNVmqeUWMXc7STtPqf7SUdvEGbko4
 g9XkDZXun6EU+B06/b1a9SjwySMIsvTpdneEw1yo6u0CUp6orQFGF0kyXV/FHknE1c
 pU5UDZLr91UnFCbPbdwRyNzlK1yt71+N9y72Zr1k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4215Qd3e051330
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Feb 2024 23:26:39 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 23:26:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 23:26:39 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4215QcB3037892;
 Thu, 29 Feb 2024 23:26:39 -0600
Date: Fri, 1 Mar 2024 10:56:38 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
Subject: Re: [RFC PATCH 3/4] arm: dts: k3-j721e: Separate boot binary build
Message-ID: <20240301052638.iyf5o2uaznthnc6c@uda0497581>
References: <20240228112042.3437691-1-n-francis@ti.com>
 <20240228112042.3437691-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240228112042.3437691-4-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Neha,

On 16:50-20240228, Neha Malcom Francis wrote:
> Separate out the boot binaries built for J721E boards; J721E EVM and
> J721E SK by using the common templates in k3-j721e-binman.dtsi.
> 
> Only the required boot binaries can be built from the templates in the
> boards' respective -u-boot.dtsi file. FDTs and configurations are also
> moved to the -u-boot.dtsi file to allow clear distinction between the
> SoC common stuff vs. what is needed to boot up a board.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Note: I have added "dummy" sections so that node for a phandle is found
> correctly. The node for a phandle is searched for among sub-nodes of a
> section (check tools/binman/etype/section.py GetContentsByPhandle) and
> having a template as the section instead, causes failure to find the
> phandle despite it being present in the FDT. So the dummy section
> bypasses this.
> 
> Avoided correct DTS alignment for the RFC at least so that it's clear
> what is actually being changed.
> 
>  arch/arm/dts/k3-j721e-binman.dtsi             | 178 +++++-------------
>  .../k3-j721e-common-proc-board-u-boot.dtsi    | 138 ++++++++++++++
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 104 ++++++++++
>  3 files changed, 284 insertions(+), 136 deletions(-)
> 

[snip]

> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> index 7ae7cf3d4c9..ff96bc3f724 100644
> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> @@ -187,3 +187,141 @@
>  &mcu_fss0_ospi1_pins_default {
>  	bootph-all;
>  };
> +
> +#ifdef CONFIG_TARGET_J721E_R5_EVM
> +
> +&binman {
> +	tiboot3-j721e-sr1-1-hs-evm {
> +		insert-template = <&tiboot3_j721e_sr1_1_hs>;
> +	};
> +	sysfw-j721e-sr1-1-hs-evm {
> +		insert-template = <&sysfw>;
> +	};
> +	itb-j721e-sr1-1-hs-evm {
> +		insert-template = <&itb>;
> +	};
> +};
> +
> +&binman {
> +	tiboot3-j721e-sr2-hs-evm {
> +		insert-template = <&tiboot3_j721e_sr2_hs>;
> +	};
> +	sysfw-j721e-sr2-hs-evm {
> +		insert-template = <&sysfw_sr2>;
> +	};
> +	itb-j721e-sr2-hs-evm {
> +		insert-template = <&itb_sr2>;
> +	};
> +};
> +
> +&binman {
> +	tiboot3-j721e-sr2-hs-fs-evm {
> +		insert-template = <&tiboot3_j721e_sr2_hs_fs>;
> +	};
> +	sysfw-j721e-sr2-hs-fs-evm {
> +		insert-template = <&sysfw_fs>;
> +	};
> +	itb-j721e-sr2-hs-fs-evm {
> +		insert-template = <&itb_fs>;
> +	};
> +};
> +
> +&binman {
> +	tiboot3-j721e-gp-evm {
> +		insert-template = <&tiboot3_j721e_gp>;
> +	};
> +	sysfw-j721e-gp-evm {
> +		insert-template = <&sysfw_gp>;
> +	};
> +	itb-j721e-gp-evm {
> +		insert-template = <&itb_gp>;
> +	};
> +};
> +
> +#else
> +
> +#define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
> +

Trying to gauge the changes that are required for EVM to SK, I notice a
few only ( let me know if I missed ). 

1. DTB
2. Description name.

Considering this, templating does seem good but I was thinking of a
different design as well. Let me know what you think about it.

I was thinking that the binman node can remain as is with some generic
macros like taking the fdt-0 node of tispl.bin

We can have something like this.

in arch/arm/dts/k3-j721e-binman.dtsi:

fit {
	images {
		fdt-0 {
			description = BOARD_DESCRIPTION;
			ti-secure {
				content = <&spl_j721e_dtb>;
				keyfile = "custMpk.pem";
			}
			spl_j721e_dtb: blob-ext {
				filename = BOARD_SPL_DTB;
			}
		}
	}
}

And then in the board specific -u-boot overrides, we can have something
like this -

in arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi

#define BOARD_DESCRIPTION "k3-j721e-common-proc-board";
#define BOARD_SPL_DTB "spl/dts/k3-j721e-common-proc-board.dtb";
#include <k3-j721e-binman.dtsi>

in arch/arm/dts/k3-j721e-sk-u-boot.dtsi

#define BOARD_DESCRIPTION "k3-j721e-sk";
#define BOARD_SPL_DTB "spl/dts/k3-j721e-sk.dtb"
#include <k3-j721e-binman.dtsi>

I think if we have a less enough diff only between these two then I am
hoping something like this can be better maybe. Let me know what your
thoughts would be on that.

Regards,
Manorit

> +&binman {
> +	tispl {
> +		insert-template = <&ti_spl>;
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-common-proc-board";
> +					ti-secure {
> +						content = <&spl_j721e_evm_dtb>;
> +						keyfile = "custMpk.pem";
> +					};
> +					spl_j721e_evm_dtb: blob-ext {
> +						filename = SPL_J721E_EVM_DTB;
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +		};
> +	};
> +
> +	u-boot {
> +		insert-template = <&u_boot>;
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +		};
> +	};
> +
> +	tispl-unsigned {
> +		insert-template = <&ti_spl_unsigned>;
> +
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-common-proc-board";
> +					blob {
> +						filename = SPL_J721E_EVM_DTB;
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +		};
> +	};
> +
> +	u-boot-unsigned {
> +		insert-template = <&u_boot_unsigned>;
> +
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-common-proc-board";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +#endif
> diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> index 479b7bcd6f8..ca18dd5f8ed 100644
> --- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> @@ -163,3 +163,107 @@
>  		};
>  	};
>  };
> +
> +#ifndef CONFIG_ARM64
> +
> +&binman {
> +	tiboot3-j721e-gp-sk {
> +		insert-template = <&tiboot3_j721e_gp>;
> +		filename = "tiboot3-j721e-gp-sk.bin";
> +	};
> +	sysfw-j721e-gp-sk {
> +		insert-template = <&sysfw_gp>;
> +	};
> +	itb-j721e-gp-sk {
> +		insert-template = <&itb_gp>;
> +		filename = "sysfw-j721e-gp-sk.itb";
> +	};
> +};
> +
> +#else
> +
> +#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
> +
> +&binman {
> +	tispl {
> +		insert-template = <&ti_spl>;
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-sk";
> +					ti-secure {
> +						content = <&spl_j721e_sk_dtb>;
> +						keyfile = "custMpk.pem";
> +					};
> +					spl_j721e_sk_dtb: blob-ext {
> +						filename = SPL_J721E_SK_DTB;
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +		};
> +	};
> +
> +	u-boot {
> +		insert-template = <&u_boot>;
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +		};
> +	};
> +
> +	tispl-unsigned {
> +		insert-template = <&ti_spl_unsigned>;
> +
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-sk";
> +					blob {
> +						filename = SPL_J721E_SK_DTB;
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +		};
> +	};
> +
> +	u-boot-unsigned {
> +		insert-template = <&u_boot_unsigned>;
> +
> +		fit {
> +			images {
> +				fdt-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +
> +			configurations {
> +				conf-0 {
> +					description = "k3-j721e-sk";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +#endif
> -- 
> 2.34.1
> 
