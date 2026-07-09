Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B4EC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6376C84AB5;
	Thu,  9 Jul 2026 08:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aUlOFiIX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tr9l/7W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2845584AB5; Thu,  9 Jul 2026 08:45:34 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B029584AC5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwlpM2R9DzKvyY;
 Thu, 09 Jul 2026 08:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783579531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceJFBJUn5YhpXNih4dD7JMiBuvoW4y+Y9edixLScbA4=;
 b=aUlOFiIXiF+zYR9tVW3jsWkjKm+rmBpdmW2v4XSruOvpQSzD/9a12C+fBfaUx8i7nDAA/n
 o8bTeey/fuAIQsMinErjI6S9r6fCaUEDffDMKBn/99d/AAT/UG5q+yCJuVudCfw1aClYWM
 zSstvSrCC9AHJ0uTh6+k8YLnLBGUAyk3zI/hrRTu1MZXMCxoDKG82Z2xRpM2znEfI2oECz
 hfMCrI9H/nTsfn+BSQkxZ4LwBga6D6evtRcaaYm3hptakXOUzN6+TSRX79h+Wb9vOqczSF
 IUv3RxdAFfabAc4RjC3CAzoXxp1oECcxifYFt5kvuEWjaEQgqIBR6tRXZEJYxw==
Message-ID: <4db10c8c-e8ab-4a9c-9114-87d195754e15@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783579529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceJFBJUn5YhpXNih4dD7JMiBuvoW4y+Y9edixLScbA4=;
 b=Tr9l/7W1MYnQF79NknzP3PkcnyoRzJGq086OwDsOUg7WIO6ln+/I7RSj0McucOHK3kjr+P
 jT67Kh/W+JDO12Twf0dz+4T7oe1379rCPgf+oFGUj9UKHjeayZUUhkexjarsxrWl2SBca/
 80MGBTuWzwwesu5jtp0TCEXzDO4r4s90/M02AEG3aGvQAEWMO16i/T6Ig/+v9RlNxPZAQF
 e2YRLuuljwa2hzPTJZMo41AFcupQreiitoj7AJP/jyXlh0LyYo7aAjAJdh/7pgr1NOfa4R
 KCb5bSuEMTBO2HsYrwyOB/F5pczCLvqtw1QOdgP2X3ja7gRULE4ZYtJR6G9XSA==
Date: Thu, 9 Jul 2026 08:45:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: ast2600: add AST2700 support
To: Ryan Chen <ryan_chen@aspeedtech.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260702-aspeed_wdt-v1-1-1c44c38430e6@aspeedtech.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260702-aspeed_wdt-v1-1-1c44c38430e6@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 870979b2e9c39371f06
X-MBO-RS-META: i7t14sfnw3qiwzfi7814bs75s49qqqxj
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

On 7/2/26 09:17, Ryan Chen wrote:
> The AST2700 reuses the AST2600 watchdog block unchanged. Bind the
> driver to the aspeed,ast2700-wdt compatible and enable WDT_AST2600
> on the AST2700.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> The AST2700 reuses the AST2600 watchdog block with an identical register
> layout and reset behaviour, so no new driver is needed. Bind the existing
> ast2600 watchdog driver to the aspeed,ast2700-wdt compatible and allow
> WDT_AST2600 to be selected on the AST2700.
> ---
>   drivers/watchdog/Kconfig       | 6 +++---
>   drivers/watchdog/ast2600_wdt.c | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b91727e1265..3c56c541505 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -130,11 +130,11 @@ config WDT_ASPEED
>   	  Second Boot.
>   
>   config WDT_AST2600
> -	bool "Aspeed AST2600 watchdog timer support"
> -	depends on WDT && ASPEED_AST2600
> +	bool "Aspeed AST2600/AST2700 watchdog timer support"
> +	depends on WDT && (ASPEED_AST2600 || ASPEED_AST2700)
>   	default y
>   	help
> -	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
> +	  Select this to enable watchdog timer for Aspeed ast2600/ast2700 devices.
>   	  The watchdog timer is stopped when initialized. It performs reset, either
>   	  full SoC reset or CPU or just some peripherals, based on the flags.
>   
> diff --git a/drivers/watchdog/ast2600_wdt.c b/drivers/watchdog/ast2600_wdt.c
> index 190490f3692..5eb9b4ba96f 100644
> --- a/drivers/watchdog/ast2600_wdt.c
> +++ b/drivers/watchdog/ast2600_wdt.c
> @@ -87,6 +87,7 @@ static const struct wdt_ops ast2600_wdt_ops = {
>   
>   static const struct udevice_id ast2600_wdt_ids[] = {
>   	{ .compatible = "aspeed,ast2600-wdt" },
> +	{ .compatible = "aspeed,ast2700-wdt" },
>   	{ }
>   };
>   
> 
> ---
> base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
> change-id: 20260702-aspeed_wdt-76e73f1c8853
> 
> Best regards,

