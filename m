Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D672AC2BA1A
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 19:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381C684003;
	Sat, 16 Sep 2023 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564548468A; Sat, 16 Sep 2023 21:47:20 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 92987833F5
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 21:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 00C4A6CB5;
 Sat, 16 Sep 2023 21:47:13 +0200 (CEST)
Date: Sat, 16 Sep 2023 21:47:13 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
Message-ID: <20230916194713.GA10071@m1>
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
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

On Wed, 2023-09-06 at 14:00, Heinrich Schuchardt wrote:
> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
> prefixed header. We have referring to a vendor tool (spl_tool) for this
> task. 'mkimage -T sfspl' can generate the prefixed file.
> 
> Use binman to invoke mkimage for the generation of file
> spl/u-boot-spl.bin.normal.out.
> 
> Update the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Tested-by: Chanho Park <chanho61.park@samsung.com>

Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
> v2:
> 	Fix a typo in a comment in tools/sfspl.c
> 	Add Tested-by credit
> ---
>  .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
>  doc/board/starfive/visionfive2.rst                 | 14 ++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> index 13f69da31e..defe2b605f 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> @@ -103,4 +103,14 @@
>  			};
>  		};
>  	};
> +	u-boot-spl {
> +		filename = "spl/u-boot-spl.bin.normal.out";
> +
> +		mkimage {
> +			args = "-T sfspl";
> +			blob {
> +				filename = "spl/u-boot-spl.bin";
> +			};
> +		};
> +	};
>  };
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 941899a0a4..f5575ab68b 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
>  	make starfive_visionfive2_defconfig
>  	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
>  
> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
> -
> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
> -the below command:
> -
> -	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
> -
> -More detailed description of spl_tool,please refer spl_tool documenation.
> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
> -
> -This will generate u-boot-spl.bin.normal.out file.
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>  
>  Flashing
>  ~~~~~~~~
