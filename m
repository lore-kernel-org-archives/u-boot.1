Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10659C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 10:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1FFF60670;
	Wed, 19 Aug 2026 10:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ng3UoS3280Ee; Wed, 19 Aug 2026 10:04:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787133887;
	bh=Ez8Qaci/pb9Oup0HkTeIwaP8EhTUsFo7leMNl83ZS/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hemgmjyzj4qIrfkwpAdoPMEJApGCYADW9JvXbt/ejkV+x6a36CAdsKt5zIj0pgM70
	 0AHDpYiWTINIKrLg8ZDXwgWqYFfb8Myjsl6JfEbLzJvdy7Tk76J4j/+CgsgpOTtIiy
	 hHX+TLaB9PX1JvR7XskM6wTDDHGqQEKZIos7eAezkcRJJIFXuPJU4yfXm8dp26Hx1T
	 9tS/pxGNByIyClSnVweDzBQK4cfnpVktoiWRIfLzpwPw91oSFGFf25tclY0clfubzf
	 exBQiysVYF7C4WoGQ/Rppkc1jUbGYl7mKBkKTouiWxh39YoOKXe1aWij0K4AyvSnDX
	 mt6qlTiK1TGAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 239536061F;
	Wed, 19 Aug 2026 10:04:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0D4B230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6CEA405E7
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCL2xsfwLUQr for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:04:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=cEHSnJlL
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A34CD40592
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 010B1107AE7; Wed, 19 Aug 2026 12:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787133878;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Ez8Qaci/pb9Oup0HkTeIwaP8EhTUsFo7leMNl83ZS/4=;
 b=cEHSnJlLHx9T5wIiZ3Kae2wfWbRQOhhf2IfrExITVxatCrixIdfInm8kHcy3zgVMxoUPKi
 oAEmGCb+gTqXseaivphGBFfJZPvbvpjZAM3JJlqlgB38AuWtdNnS8jczJUqRZz3ad0yT9+
 l/oFeXfXyvOIv9Dy+XgWIlbminGLRYRSYxoJSZwRz9mvZgUmg8rQxFEg2/ON4v4pAxvhNw
 shlkwpVz31llD/rKdLko0KhFEMhzKxQBfVECy0e4air0+UT/32uYSYyc65IPGTy0aoGp5Z
 F81OcHNaw/1BM63ycBd1gKaca7rks5HCO4ym9LM09xjPl2Bs7W5E4+z/MxK1aQ==
Message-ID: <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
Date: Wed, 19 Aug 2026 12:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simona Toaca <simona.toaca@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260819070758.51350-3-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/19/26 9:07 AM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> In some cases we need to call ddr_init() multiple times to try
> different configurations.

What different configurations ? Details please ?
