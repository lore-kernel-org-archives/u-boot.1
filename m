Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16759C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128D6800B3;
	Tue, 11 Feb 2025 12:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RsS3xXg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF32180104; Tue, 11 Feb 2025 12:35:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B3280079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739273737;
 bh=SEDGdqEWXM8aRnn2s7hmzmXg1jOBq6+CDIS2Up1G78k=;
 b=RsS3xXg+/fFtrfkP3vu1RE4/jneHTeOSFaDGAOI1c1Y6NDsb5ADsmaDaECoW76/XqPfrLE5mz
 BE8We+U/qYQZ8UIFbK82R9Fo4QbiiIwm4QVPIgvz3eymGAmcjZ149K0XsQokOYqyYhswxneI0ep
 6eakopU4jjf79D1IvRslzH3IfwSzg1LMdqZpbvf0R+xgoA877gIou71AO7KhB3/gE7cd06uOPna
 oHrqLa74c64WpKa6gr84MsJVvEWzvW0VEXTkAyfndJ3jSONPNI+66rFkufPCEkF8JZGBEzxWD8/
 nNOuw33mF5dzh6GHW2oOaW+kH+amiO/mSg2zGCIaZ20Q==
X-Forward-Email-ID: 67ab36022c3b8c8cd9bb4dbc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d46f46fc-4300-4bf1-b547-c1e87e066e67@kwiboo.se>
Date: Tue, 11 Feb 2025 12:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
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

Hi Quentin,

On 2025-02-11 11:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Essentially the only differences between u-boot-rockchip.bin and
> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
> proper is flashed, the content of the binaries are identical otherwise.
> 
> This fixes some issues[1] where binman tries to find the symbols defined
> in the proper binary to install them in an xPL binary. However, because
> we use the binary for proper (on Aarch64) generated in simple-bin image
> node and not simple-bin-spi image node, binman doesn't have access to
> that symbol anymore. Therefore, let's depend entirely on binaries built
> by simple-bin in simple-bin-spi so those issues do not arise anymore as
> nothing is compiled essentially, just assembled.
> 
> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -187,18 +187,28 @@
>  			};
>  #elif defined(CONFIG_TPL)
>  			u-boot-tpl {
> +				type = "blob";
> +				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +				filename = "tpl/u-boot-tpl.bin";
>  			};
>  #endif
>  			u-boot-spl {
> +				type = "blob";
> +				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +				filename = "spl/u-boot-spl.bin";
>  			};
>  		};
>  
>  #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>  		fit {
>  			type = "blob";
> +			/* sync with /binman/simple-bin/fit */
>  			filename = "u-boot.itb";
>  #else
>  		u-boot-img {
> +			type = "blob";
> +			/* sync with /binman/simple-bin/u-boot-img */
> +			filename = "u-boot.img";
>  #endif
>  			/* Sync with u-boot,spl-payload-offset if present */
>  			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> 

I think changing to using a template may suit binman better, however it
will be at the expense of having to re-generate the FIT, not sure what
option is best.

It would be great if Simon can split out the rockchip-u-boot.dtsi
improvement commits in a separate series as I suggested in [2].

That patch also solve the build issue this patch intend to fix.

[2] https://patchwork.ozlabs.org/project/uboot/patch/20250209211502.2299245-15-sjg@chromium.org/

Regards,
Jonas
