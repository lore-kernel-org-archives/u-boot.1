Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F45FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 11:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3CD82D06;
	Mon,  7 Apr 2025 13:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JGOTT+Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8989282D06; Mon,  7 Apr 2025 13:22:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BB882CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 13:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=13a0=WZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744024972;
 bh=gK1QVNSNXu0XOXTFNNdYGwyvz/9E3Bhmzl8qNXnX5/Q=;
 b=JGOTT+TdPvnMeFjxpRvh12c4ZOsaNuupY5eWr+equpibYxR0KDM7nfbFCcQmqyL8FMFbRjPns
 IrqEObwqndsGXLelkdawItWchlirt6hnU5bsb1+M3SLg/6fOqBtoQDkoAkkuCith3SVjzchrizX
 c5TJ0uLLSDHOK649u3nA620QnlsegOPZDP3pyqemXWrcgnZfWqs7ZpUsZ37tnZpWwsejybCa+Eq
 Srq6pto1qLsLh9VyBX1xdG/cuOZRlNaxoFlDXppuT593Am/VSwg1ix6IWtfIj5USewPziFMiyTp
 w00pgzHbmfOJ1uCGsLw8GMzr8zM4gjLmAbMsFd1caNBw==
X-Forward-Email-ID: 67f3b582454af5417a2dffa2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <662e8417-1651-4a36-97d8-e46c30c7b16b@kwiboo.se>
Date: Mon, 7 Apr 2025 13:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by
 default
To: Yao Zi <ziyao@disroot.org>
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-2-ziyao@disroot.org>
Content-Language: en-US
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Trevor Woerner <twoerner@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250407033744.4025-2-ziyao@disroot.org>
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

Hi,

On 2025-04-07 05:37, Yao Zi wrote:
> The default binman configuration of RISC-V wraps proper U-Boot into a
> FIT image instead of shipping a plain image, thus there's no
> "u_boot_any" entry by default. Let's disable the option to prevent
> binman from looking for a plain proper U-Boot image, failing the build
> with message like
> 
>   Section '/binman/spl-img': Symbol '_binman_u_boot_any_prop_size'
>      in entry '/binman/spl-img/mkimage/u-boot-spl/u-boot-spl-nodtb':
>        Entry 'u-boot-any' not found in list (u-boot-spl-nodtb,
>        u-boot-spl-dtb,u-boot-spl,mkimage,spl-img)
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  common/spl/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 7d6780936d1..356ddab38de 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -214,6 +214,8 @@ config SPL_BINMAN_UBOOT_SYMBOLS
>  	bool "Declare binman symbols for U-Boot phases in SPL"
>  	depends on SPL_BINMAN_SYMBOLS
>  	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
> +	# A FIT image is created with default binman configuration of RISC-V

Use of a FIT does not really matter, Rockchip use a FIT for U-Boot
proper and symbols can be located.

> +	default n if RISCV
>  	default y
>  	help
>  	  This enables use of symbols in SPL which refer to U-Boot phases,

Maybe something like this is what you instead want to use:

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index ceb916b74a73..e1a5ad573bbe 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -30,20 +30,19 @@
 				uboot {
 					description = "U-Boot";
 					type = "standalone";
-					os = "U-Boot";
+					os = "u-boot";
 					arch = "riscv";
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
-					uboot_blob: blob-ext {
-						filename = "u-boot-nodtb.bin";
+					uboot_blob: u-boot-nodtb {
 					};
 				};
 #else
 				linux {
 					description = "Linux";
 					type = "standalone";
-					os = "Linux";
+					os = "linux";
 					arch = "riscv";
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 05787bdb92db..6e083bf0537a 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -20,6 +20,7 @@
 			args = "-T sfspl";
 
 			u-boot-spl {
+				no-write-symbols;
 			};
 		};
 	};

Regards,
Jonas
