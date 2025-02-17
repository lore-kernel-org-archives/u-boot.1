Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEBC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 21:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC5580BAE;
	Mon, 17 Feb 2025 22:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oTEfoStR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F67280077; Mon, 17 Feb 2025 22:02:09 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFFF8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 22:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739826125;
 bh=pHawD/oq4CHTsWY6CfZMUVyrjisXXxWNGxwzbNKGavQ=;
 b=oTEfoStRjgyNLHQBDQg7CsPd5tIxVjWhTjaHY3RbaNVUtRtmSSGxWSkbpMB5x2fGQYS4GK8aw
 Y1mUWIOdpxwPiJ4+Vi5q1FrpXjjgaed3a8t2wIYHnMvwTW7uDbos2AId9sJTf2UUOh/sTmulf6q
 8k6r2S4WYTd8HI9Awm9b1o+gONiw9L/9dhqO/1mJKn+w1E+iRGqcrvyyQXJrFiwgAKB8BhwrYtt
 6fnI8EHge7eDnBAJpyB9gYSfLSXvWrtZNjnrCmDx1GDxYYdp/GFo2NWxPjnnlLnqcj3WEeuTzuP
 QWOM1AWo3YS86lNkpFYFj66APYsuMP0PAK3xr1eG48MA==
X-Forward-Email-ID: 67b3a3cc179e723bb8e5753e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <747e9fb4-c749-4ce6-91ae-4ee9e4aa6efd@kwiboo.se>
Date: Mon, 17 Feb 2025 22:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/35] rockchip: Include a compatible string in each
 configuration
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-19-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-19-sjg@chromium.org>
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
> Provide a compatible string so that U-Boot can decide which
> configuration to use.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

This will be useful for more than VBE so this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 10563e273a9..c2a795957fb 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -149,6 +149,7 @@
>  				fit,firmware = "op-tee", "u-boot";
>  #endif
>  				fit,loadables;
> +				fit,compatible;
>  			};
>  		};
>  	};

