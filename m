Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7EDC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 18:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7ED88144A;
	Fri, 28 Mar 2025 19:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AGBMzwmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D0D81951; Fri, 28 Mar 2025 19:19:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9F280F0E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 19:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743185964;
 bh=t7VQiIBFXaTT/9yXrqGQQJRQqmBKShqbFsfYHACWHEo=;
 b=AGBMzwmRbD3VbFrtQj9yWrWpb+xk5fZaRWBh7Y6/MDHlcU0gDL6eljnm2W0LHxprt43L6PuhF
 rfbUYWPsACyi3ReegQYBjiDQB57WaBRi86kEuNYQFz+BSvUxRdBr0ElZhktZWCaO4sgNrQfkpDg
 IfwYCu754y+lGm0D2dUiEFKft2cMnby5Gr32qkJ+jPT2Dnb+u5pt7LuEgpybsZ5l+/rMLuqcBsA
 BuiVmLXzBXLIpIGci0MU7+2+EsxD3jx04nxPxIoY4E39Nuqwcti7/XunvIBlEKA8hGJH5jMars9
 PrHoqEkVAUJHpZnygeewSjYTG17HYExXCaPhz5CzBlIA==
X-Forward-Email-ID: 67e6e82a99a280edf51ec9dd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <47763569-3b7b-4707-b517-b0e41a499069@kwiboo.se>
Date: Fri, 28 Mar 2025 19:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/31] rockchip: dts: Use the new binman template for
 the SPI image too
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-11-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-11-sjg@chromium.org>
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

Patch 05 to 10 should still be split out to a separate series.

They help fix an issue that already have a different conflicting patch
on mailing list [1].

The request to split these patches out was to help/ease work for other
U-Boot developers such as myself. I have a follow up patch to split out
HASH and to add support for using crc32 as hash algo, for an upcoming
RK3506 series. And I have already send a separate series to add RAM boot
that depends on the fit-template added in patch 08, see [2].

Still keeping these rockchip: dts: patches that are ready to be merged
in a series that in v3 still does not apply to master or next is
disappointing. And because it is not possible to apply this series, a
proper review and testing has not yet been done, something that is just
delaying your work more than it has to.

I can send these patches as a separate series if you do not have time to
split these patches out to a separate series, and would also include my
HASH crc32 patch.

[1] http://lore.kernel.org/r/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de
[2] http://lore.kernel.org/r/20250220231358.432367-3-jonas@kwiboo.se

Regards,
Jonas

On 2025-03-28 16:34, Simon Glass wrote:
> At present simple-bin-spi relies on the u-boot.itb file created by the
> simple-bin image. Use the template to avoid this, since Binman may
> change to process images in parallel in the future.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> 
> Changes in v3:
> - Keep the filename for the SPI FIT
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 1e4d6f71123..fb304540787 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -207,8 +207,8 @@
>  
>  #ifdef HAS_FIT
>  		fit {
> -			type = "blob";
>  			filename = "u-boot.itb";
> +			insert-template = <&common_part>;
>  #else
>  		u-boot-img {
>  #endif

