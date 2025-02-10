Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D5C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 21:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27868043C;
	Mon, 10 Feb 2025 22:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="B5A+iFes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97097806FE; Mon, 10 Feb 2025 22:53:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26806803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 22:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739224418;
 bh=+KK5U5n5lH4uNDBzb2WKKoOoMh2c51cPNmquQ3+DbM8=;
 b=B5A+iFesQIsjk6h+NBdH9VjpT2hZywu0SPT2zdEthkqdhY5asGupc3S/kNKIYb34AMamLuI3N
 fRNBnyFvsDyoDplfZnIGNx1KDKKbRzLHz5EWb/4tZSiNZYzUfzOJmC20FgMSl42XSV9nWRHuecj
 Xt65m72HjYXm1yUPXw2oamtmcnwANsI7X3x95IPuQ7T/Pr2LlcrWrD4EtvplvL9mvO1gnPj7CgX
 eEIhzm8iwa9+gAIgtbopkyWp53ePK5mhl20RdUTtwGmk5Ft+nYLBxnidXUQlPQ0MLzUuR22WPKE
 kndVJKvmMOs1ebGPdp4we9zIlYHrWMraJkYyfeH6QutA==
X-Forward-Email-ID: 67aa7561e0c507d2fc8fbd7a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a1d6d8a7-f4a1-4e3a-955f-d8e08be236c1@kwiboo.se>
Date: Mon, 10 Feb 2025 22:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/35] rockchip: dts: Un-indent the FIT template
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-14-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-14-sjg@chromium.org>
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

On 2025-02-09 22:14, Simon Glass wrote:
> Fix the indentation on the template. This is done in a separate patch
> so that it is easier to review.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 178 +++++++++++++++---------------
>  1 file changed, 89 insertions(+), 89 deletions(-)
>

[snip]
