Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CF8C021A0
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 01:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F80807FE;
	Sun,  9 Feb 2025 02:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KnH2HG71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB6080805; Sun,  9 Feb 2025 02:36:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4D5807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 02:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739065006;
 bh=zWrKzWNDSUTCgaboYk93+iROaUFcgZH7/UcXD+rm1Xc=;
 b=KnH2HG71nFvN/W2w4hjElsNXdyQh7fCc8I4aR20Bc3gEgpxK0DNdXi6k5QcTPjKLyohURoBgq
 ZKxpTVOJzhC2CSR4+LHFJnJL0DvhLBJqkXQXxSyIcPuzK2dNTyTv2UbOSwQ2qK8uVGRxC/RfojI
 c6msJqB7fsI6jhZ/xpDXCLpwiGV6ioxbDlYg6GBLxJcLKY++ZXAZs3CxsCXoaGOCLD30k/0G+9m
 L4E40yZpQeGcOBxrNe3KaKelapeTBjudJ3cKMRAgPQOxGP7odPufHNZcSlsapz7MZluQbeAgChI
 X3i7EvJMovO8AjAzKdrqOW6sBu3lxMoiipI2a9rfuVaQ==
X-Forward-Email-ID: 67a806adae24fcf613ed65f5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <39c87a74-3fe0-475c-a98f-fda1181d6e00@kwiboo.se>
Date: Sun, 9 Feb 2025 02:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] rockchip: Add SPL into the main FIT
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-15-sjg@chromium.org>
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

Hi Simon,

On 2025-02-05 02:55, Simon Glass wrote:
> VBE may want to load the SPL image from the same FIT as contains U-Boot,
> if there is enough memory, so add it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 7cce213c32e..39908495894 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -72,6 +72,25 @@
>  		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>  		fit,align = <512>;
>  		images {
> +#ifdef CONFIG_VPL

Is VPL intended to be exclusive to VBE? This (and others) should
possible test for another Kconfig symbol?

> +			spl {
> +				description = "U-Boot SPL";
> +				type = "firmware";
> +				os = "u-boot";
> +				arch = ARCH;
> +				compression = "lz4";
> +				load = <CONFIG_SPL_TEXT_BASE>;
> +				entry = <CONFIG_SPL_TEXT_BASE>;
> +				phase = "spl";
> +				section {
> +					compress = "lz4";
> +					u-boot-spl-nodtb {
> +					};
> +					u-boot-spl-bss-pad {
> +					};
> +				};
> +			};

Is this spl part really used for anything? Later you are adding a spl
template and using that for other vbe parts, it is not clear for what or
when this is intended to be used.

Regards,
Jonas

> +#endif /* VPL */
>  			u-boot {
>  				description = "U-Boot";
>  				type = "standalone";
> @@ -172,7 +191,11 @@
>  				description = "NAME.dtb";
>  				fdt = "fdt-SEQ";
>  #ifdef CONFIG_ARM64
> +# ifdef CONFIG_VPL
> +				fit,firmware = "atf-1", "u-boot", "spl";
> +# else
>  				fit,firmware = "atf-1", "u-boot";
> +# endif
>  #else
>  				fit,firmware = "op-tee", "u-boot";
>  #endif

