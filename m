Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1847C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 16:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A10082D2B;
	Sat, 24 May 2025 18:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FmbeFjQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6A482ED0; Sat, 24 May 2025 18:03:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A2582D06
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 18:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=efaa=YJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748102585;
 bh=eU3tfuJkoYP5KR0CuStX14fVGSMVkRilAA3L2sVVkAU=;
 b=FmbeFjQJPzjB6tj3Yl0acuMBrxWJHCQHg+MmmCV9I8brJDZc/zi+Xr43u7vlhYTCY1qG/mwH8
 ruGJor3ZvVFkXkErb+fAtkRUsPpQSR2tRpVzW5m28kYcQJdFlhDxlbF59VKC7lShBVmzbveUN7R
 uR7SwB9nSgnsJlQiO/li80VeVpa5jJ8PJ8OkEo08br6237cmxFCUG85HV1X9K58oS9EcD43OHIs
 Evo1vHQGOVCuIYe1tS2nRIYDrAdjUs5abuZeUr25CLYchZ/yG8Nbl9HnW2rS3NrMbLFOtX/zyi5
 FHkOGfGtnkBUWQyGjuXrLcDIZSubwAgtZdLqlqyGiBhg==
X-Forward-Email-ID: 6831edb6c9f5592e59ab7f5f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <65b2368d-fed5-4633-b9e6-25ab9d151d1e@kwiboo.se>
Date: Sat, 24 May 2025 18:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3328: Fix Synchronous Abort on usb start
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250524142258.297397-1-alexthreed@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250524142258.297397-1-alexthreed@gmail.com>
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

Hi Alex,

On 2025-05-24 16:20, Alex Shumsky wrote:
> Remove incorrect assigned-clock-parents in rk3328-u-boot.dtsi.
> This incorrect parent has become a problem since recent commit with parent
> clock enablement.
> 
> Currently assigned-clock-parents is not a CLK node, but rk3328-usb2phy.
> It looks like a mistake in dts made a long time ago (~8 years ago).

No, this is very much correct, u2phy is a clk provider as can be seen
by the use of the '#clock-cells' prop so being able to use it as a
parent clk is allowed and the device tree is correct.

> 
>   => usb start
>   starting USB...
>   Bus usb@ff580000: "Synchronous Abort" handler, esr 0x96000210, far 0x4
> 
> Linux dts source reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c60c0373a5e85d8bd0bb026cd5440576249d2299
> 
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
>  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index b0e50a973a..39dcc2313b 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -150,6 +150,10 @@
>  	bootph-all;
>  };
>  
> +&u2phy {
> +	/delete-property/ assigned-clock-parents;
> +};

We should fix the driver code and not modify the device tree to fit the
code.

The u2phy ofnode is tied to multiple uclass drivers so is it possible
that the parent clock lookup from commit ac30d90f3367 ("clk: Ensure the
parent clocks are enabled while reparenting") is not getting the
UCLASS_CLK driver?

Regards,
Jonas

> +
>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>  &binman {
>  	simple-bin-spi {

