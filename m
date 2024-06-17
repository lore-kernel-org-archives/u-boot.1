Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732D6C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B9B88283;
	Mon, 17 Jun 2024 15:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zVhYtmVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3DD8829B; Mon, 17 Jun 2024 15:26:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A2388271
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7b9=NU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718630778;
 bh=BnvtdxPGWwZXFCseV6XaeUO/TQ4IgWHw6JVGpWKBZyY=;
 b=zVhYtmVFZE+vo3ynk2tfZqzOBRZm8sGnEs3i3BlGSHRhE2qUDYBAJiJb3LD/qe0h/6x3GlhCX
 QzfCSgg4KqxraxHJjEKDwGrXmx8HCB7GdXDAzN+UD7c1LoUH7jkUxoml+Ka9rtTdfdUnnbZoES8
 sR9U2VuExkDE0Y4LQYJ0v1blaV1CeJFMpkyW5fJUuHegSawyPva9b0WM2QIZhnVCL/ei0ddee5a
 +3iwb75rR8QJE4+QcifwTd0f2EthLQC4N18ZTwEL4UCrDPvLTgYX6cJaK6yeORAhLw+w/YzKVY0
 Y/ZZDQ9AZrub5CXbfcCHvyqIyB0le8itOBclEHvhCppw==
Message-ID: <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
Date: Mon, 17 Jun 2024 15:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6670397659463b7f09c510d5
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

On 2024-06-17 15:10, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
> when booting from eMMC"), the spi1 bootph properties were mistakenly
> removed meaning, so re-add them back to fix SPI-NOR flash not being
> found in U-Boot pre-reloc as required for RK3399 Puma.

Good catch, for TPL/SPL the bootph props is propagated, something that
is not done for pre-reloc.

> 
> Fixes: 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  arch/arm/dts/rk3399-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index b6b43271172..2bec139d833 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -145,6 +145,11 @@
>  	bootph-some-ram;
>  };
>  
> +&spi1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>  &spi1_clk {
>  	bootph-pre-ram;
>  	bootph-some-ram;
> 
> ---
> base-commit: 2248c96ea1cf0b65377040d9f87ce7d8cf534c63
> change-id: 20240617-rk3399-fix-d8c8d3ce844e
> 
> Best regards,

