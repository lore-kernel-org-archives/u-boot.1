Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C9C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 21:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C582F8043C;
	Mon, 10 Feb 2025 22:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WT9sQYIn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E229480548; Mon, 10 Feb 2025 22:39:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6D5803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 22:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739223571;
 bh=PT4HwlEWWgxjuphn2p+ek2KKVp8Li/I2TVmjqYhxGaw=;
 b=WT9sQYInE5BS0MgbZY3r3dl+nlSP+/QGMDpspQujCzJeEmYwWHt6rnE9byhSLO6fyEzOm285X
 pZwklQWhfmmJBq8B5P67UrWPl0tUwQoj+XBcSYD6ooMAS4CpZQrcEwaGo3+GWMn3KZCL8CEm25e
 2YkOyxVn8vHHL401zmrCgSpUCTqyByqIIBRUA4WYtdcap6Y20DEx0IRdCJqSsdDZzjKJE0WJNWg
 fEg486jm4035qcSBvco1T1l7o/+AjtsK0Eny2ajfJ5ULFrd+1tTQLuJYbZkeby+imt810MvtPkV
 DWF5K6yUuzKpS5QCKE9HRCMd5r1ikQQoKYB4dlouBTsw==
X-Forward-Email-ID: 67aa7211e0c507d2fc8fbc5f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <98d1577b-a33e-49f6-bb61-eaa312f220c1@kwiboo.se>
Date: Mon, 10 Feb 2025 22:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/35] rockchip: dts: Add an fdtmap
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-12-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-12-sjg@chromium.org>
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
> Add an fdtmap so it is possible to look at the image with 'binman ls'.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 2b01dc66056..64a6b57d5fd 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -170,6 +170,8 @@
>  			offset = <CONFIG_SPL_PAD_TO>;
>  		};
>  #endif

Nitpick:

The Linux Devicetree Sources (DTS) Coding Style [1] recommend that each
child node is preceded with a blank line.

Please add blank line before the fdtmap node here.

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +		fdtmap {
> +		};
>  	};
>  
>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> @@ -203,6 +205,8 @@
>  			/* Sync with u-boot,spl-payload-offset if present */
>  			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>  		};

Same here.

With that fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +		fdtmap {
> +		};
>  	};
>  #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
>  };

