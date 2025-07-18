Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AAEC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC92835A2;
	Fri, 18 Jul 2025 10:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hFUjROzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59048835B0; Fri, 18 Jul 2025 10:08:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE328353F
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 789084582C;
 Fri, 18 Jul 2025 08:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA806C4CEEB;
 Fri, 18 Jul 2025 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752826085;
 bh=RjL5VniekJ/vbeicmQYI2hWcvfCE5B4RdJtk0ChdWo0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hFUjROzYEnS6wNEz3JB9x1SCVbxwU/xYUdUGDAkgN3Jew/E9VDCUvvERtsQZrxkoA
 gPSpammkLPEEOBOe1EbNddxxtxgzuYL+H8NSy2QN8l8+Olhi0pIEfZENJrZX1A5JlU
 6foJTaYIwdvYtQTsvKLoy0Z8Scq4GvWbRk8MIIZTUmKhPEUd3YlYam8xtmOLfgzU6P
 pBKOUKNkED6RwAfiTh1uW1sZYIIMQ7P8lFXUQpNy9mq1Q8StOxB1abVOtt6CEe16Tq
 tlTeqQGir0+X4n5KPPgvY1kugEchHnW+EnPOf8r8MZ1VWY/HUwNIArXhNJ2kKXSEc3
 8gCBKtAmIEunA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] fastboot: Fix off by 1 error
In-Reply-To: <20250717-fb_command-v1-1-97695943666b@linaro.org>
References: <20250717-fb_command-v1-1-97695943666b@linaro.org>
Date: Fri, 18 Jul 2025 10:08:02 +0200
Message-ID: <877c05aplp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Andrew,

Thank you for the patch.

On Thu, Jul 17, 2025 at 09:43, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> strlen only reports length of string not including terminating 0 byte
> but this has to be included in length of receiving buffer on copy so
> adjust length check to be correct.
>
> This issue found by Smatch.

This issue was*

>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Good catch!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/fastboot/fb_command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 2cdbac50ac4..df6e2a81cd5 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -405,7 +405,7 @@ static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
>  		return;
>  	}
>  
> -	if (strlen(cmd_parameter) > sizeof(g_a_cmd_buff)) {
> +	if (strlen(cmd_parameter) >= sizeof(g_a_cmd_buff)) {
>  		pr_err("too long command\n");
>  		fastboot_fail("too long command", response);
>  		return;
>
> ---
> base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
> change-id: 20250717-fb_command-275ca03b1f03
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
