Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F244ACD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6316484C19;
	Fri,  8 May 2026 13:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="htOxTyvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C61384C60; Fri,  8 May 2026 13:49:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B52584A5A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBnV13tvrz9v3M;
 Fri,  8 May 2026 13:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778240985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC0EMYzkjXK2//0krFxwtEYcpcxF7kQ7S/BwIki3ijo=;
 b=htOxTyvEVIiE0gdE2KcDCjkkDQjiZj63D5vstrN2/M8067dSy9JTEZgG8oATgal3DR85Q/
 lrtemuU5tAONWb9ubyXBC+94wkrz0YsqGDp4fIToRvxG+ju1dRheb/1WAh96wFnHAegy1/
 nTuva7akUT+4nJUCwL+4ltK+h+tqrOIQjNNLZjXR40r5+LA5AHllDFch9JD/GhMZzmuze6
 c1aBZWXx+gUa+ggIaHAdMO7su+5aXCQZ2hf5GgbjwJxMc8As5PGT02TKB5AXsETGLNv2DF
 3J4tsCy4PIa5NMlOPLZSBO7D01SVGXHONBsrW7pipqLvCdFYm+EZZ5a/kl0Crw==
Message-ID: <a42da35f-e230-4d60-a0e2-37b2c2d8c5bc@mailbox.org>
Date: Fri, 8 May 2026 13:49:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
To: Juuso Rinta <juuso.rinta@nokia.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 67b52a3ebed689f7ae4
X-MBO-RS-META: gudauwfq1sp3kckdgf1zq1t5ucxybii1
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

On 5/4/26 11:36, Juuso Rinta wrote:
> The OcteonTX watchdog driver currently matches arm,sbsa-gwdt.
> On systems with multiple watchdog devices this can be ambiguous since
> arm,sbsa-gwdt is a generic SBSA binding.
> 
> Replace the SBSA match with SoC-specific Marvell compatibles
> marvell,cn10624-wdt and marvell,cn9670-wdt.
> 
> These compatibles align with the upstream Linux device tree binding:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
> 
> Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/octeontx_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
> index c79d9539c13..7299a9f9739 100644
> --- a/drivers/watchdog/octeontx_wdt.c
> +++ b/drivers/watchdog/octeontx_wdt.c
> @@ -159,7 +159,8 @@ static const struct octeontx_wdt_data octeon_data = {
>   };
>   
>   static const struct udevice_id octeontx_wdt_ids[] = {
> -	{ .compatible = "arm,sbsa-gwdt", .data = (ulong)&octeontx_data },
> +	{ .compatible = "marvell,cn10624-wdt", .data = (ulong)&octeontx_data },
> +	{ .compatible = "marvell,cn9670-wdt", .data = (ulong)&octeontx_data },
>   	{ .compatible = "cavium,octeon-7890-ciu3", .data = (ulong)&octeon_data },
>   	{}
>   };
> 
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-rinta-octeontx-wdt-compatible-0ca7b83e634e
> 
> Best regards,
> --
> Juuso Rinta <juuso.rinta@nokia.com>

