Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF2C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 21:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C268083C;
	Mon, 17 Feb 2025 22:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PLQY8F5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC0380BAE; Mon, 17 Feb 2025 22:27:13 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9319D80104
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 22:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739827629;
 bh=oUgb1l+ROY6M+AwoL3INGGHQ6M+7zbOmQzV6I9JihAM=;
 b=PLQY8F5AK/pWjMZtEzTeKhQ7MZMm/1ntX3jcvyarcaPl3SlvqYoGOhnb5UvxhqGFsECiLN0Xp
 h6hVmO5ttNi0oZ4TtLidts3q9uSuxA/D1u7N4hBWpgJr+AbL8PEw/jOj3eEbY0/fPRmb52KVYs8
 sKWJdVSQH0/jK8NLvwH1o4E/TD5HGFdcCXJn8KDkD1pwTb9hiElmYuGtcSvPu7rtNSoPIP4bhHf
 hMbPYdptMlJ5qQFgr8U4B87STSw6IIUWUwJ/U1ax8QPH9OXnwPLhHzQCTx4joxUUjqPpMUy84Hl
 7lyhopuWBBoDYgwKofgkTKYPwbIg/U4947+RQjDL1r9g==
X-Forward-Email-ID: 67b3a9aa179e723bb8e57790
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e069beb7-ff18-4e95-9d9b-e2ce0ea46527@kwiboo.se>
Date: Mon, 17 Feb 2025 22:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] rockchip: Add a template for SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-20-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-20-sjg@chromium.org>
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

On 2025-02-09 22:14, Simon Glass wrote:
> The SPL phase has a single SPL binary plus a devicetree for each board
> we need to support.
> 
> The devicetree is run through fdtgrep to remove unwanted nodes and
> properties and reduce its size.
> 
> While it would be nicer to just have a single FIT holding both the SPL
> and U-Boot images, there may not be enough SRAM to support that. So we
> end up providing this special image just for SPL.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 43 +++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c2a795957fb..9525cb9c21a 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -153,6 +153,49 @@
>  			};
>  		};
>  	};
> +
> +	spl_template: template-2 {
> +		type = "fit";
> +		description = "FIT image for U-Boot SPL";
> +		#address-cells = <1>;
> +		fit,fdt-list = "of-list";
> +		fit,align = <512>;
> +		fit,external-offset = <0>;
> +		images {
> +			spl {
> +				description = "U-Boot SPL";
> +				type = "firmware";
> +				os = "u-boot";
> +				arch = ARCH;
> +				compression = "lz4";
> +				load = <CONFIG_SPL_TEXT_BASE>;
> +				entry = <CONFIG_SPL_TEXT_BASE>;
> +				section {
> +					compress = "lz4";
> +					u-boot-spl-nodtb {
> +					};
> +					u-boot-spl-bss-pad {
> +					};
> +				};
> +			};
> +			@fdt-SEQ {
> +				description = "fdt-NAME";
> +				compression = "none";
> +				type = "flat_dt";
> +				fit,fdt-phase = "spl";
> +			};
> +		};
> +		configurations {
> +			default = "@config-DEFAULT-SEQ";
> +			@config-SEQ {
> +				description = "NAME.dtb";
> +				fdt = "fdt-SEQ";
> +				fit,firmware = "spl";
> +				fit,loadables;
> +				fit,compatible;
> +			};
> +		};
> +	};

This template look very specific to VBE/VPL and can probably also be
moved to rockchip-vpl-u-boot.dtsi. Else this could need a comment on
e.g. why this does not use COMP as compression algo.

Regards,
Jonas

>  #endif /* HAS_FIT */
>  
>  	simple-bin {

