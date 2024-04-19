Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8E7C04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 08:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69F9881A4;
	Fri, 19 Apr 2024 10:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="KuaqutIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56DD881F1; Fri, 19 Apr 2024 10:28:14 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E59C88191
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8f06af55-fe26-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8f06af55-fe26-11ee-b571-005056992ed3;
 Fri, 19 Apr 2024 10:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=NHhqh3O/or1fjJv4v4yAfQQWEbO2lgFVF5MDLfpQ7X0=;
 b=KuaqutIj+vi34/Mca+53p+c/xNanAznyxU6kPqDPpOzP9HnXKx5iXt6yw23TvRrs+1z29eywvLcxk
 q4haPRa/xYTlGTK/E53O/whpACUeJIuch0+C56xknn5sNp3INCOoQ47+qun7rc0tLqGLsZIJu1la3T
 tnX1p7/jzvwlZHNKilE1yAaFEeGKuWlnYjFLwlqcIxT+sPW5FreXdviF1rWWgclBJgRmHx2mtkQhM6
 FlLMgQMNGTLkQNEt58UBplFrpAoZciyorQO0Bil2zKI4DzUk3NAlo8BFGbqN097R6BAcPdaOnSfl0x
 Al28mNh1ybYeGNvYj4PS7q89+MEGeCA==
X-KPN-MID: 33|vYY4LZgbLjsOVaAnapRQ2MQfGnNQi82JIcH/UpJqJWlq6FI8hPeksl7Jm+77nay
 BnsmvIRs7XcmwQJIyBOe2vcJg7iyhINS7heZyoqsDG0I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PcUiV460QhCgLl0Fl1WsuISEkPLtR7finQx17+Klo7ql0PnC7J69q5Z82WAE2P2
 oSskfcBoK8/nA4O42VyBYyQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c256d62a-fe26-11ee-9ed8-00505699772e;
 Fri, 19 Apr 2024 10:28:12 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:28:11 +0200
Message-Id: <87plulg3j8.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: j@jannau.net
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20240418-apple_config-v2-5-7e5c6b9a9db3@jannau.net> (message
 from Janne Grunau via B4 Relay on Thu, 18 Apr 2024 21:00:29 +0200)
Subject: Re: [PATCH v2 5/5] arm: apple: Do not list bootflows on boot
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
 <20240418-apple_config-v2-5-7e5c6b9a9db3@jannau.net>
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

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Thu, 18 Apr 2024 21:00:29 +0200
> 
> From: Janne Grunau <j@jannau.net>
> 
> The bootflow list is only seen briefly and is probably more confusing
> than helpful.

To be honest, I think that applies to all boards using BOOTSSTD_FILL.
Which probably means the -l should be dropped from the default
BOOTCOMMAND for BOOTSTD_FULL.  But until that happens:

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  configs/apple_m1_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index c30aec7c55..4eac1a9e2d 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -8,6 +8,7 @@ CONFIG_SYS_CBSIZE=256
>  CONFIG_SYS_PBSIZE=276
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_BOOTCOMMAND="bootflow scan -b"
>  CONFIG_BOARD_LATE_INIT=y
>  CONFIG_CMD_SELECT_FONT=y
>  # CONFIG_NET is not set
> 
> -- 
> 2.44.0
> 
> 
> 
> 
