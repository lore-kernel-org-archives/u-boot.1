Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A32CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7A2844D2;
	Thu,  9 Oct 2025 13:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GUatAmRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2706844DE; Thu,  9 Oct 2025 13:27:11 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EAA844A9
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 339716229E;
 Thu,  9 Oct 2025 11:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2BEC4CEF5;
 Thu,  9 Oct 2025 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760009227;
 bh=lh5bJo9gAdOvCgCnOsM/PWYFQDJeDFfVVriZp0wHlK8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GUatAmROw4yibxShrEakz/sqfn9TpMFGKa9HzJAez610Whw/JnI5r2DspTbybfZ9w
 xJR25ZNLBxehW8HeyaHXBRXT73iJLsYbdtUcEungdzn/UekeM8X45XBW2KpXRo7I5E
 l5cepUQPf+qEVVikoFKrVTFzZthTIkX5/NIjHtSHZMgHuUqZRzOsmy5JaAAoeFQztD
 /jExS4ngubTED/Ziu+R6cBLiRskMV8w70brz94wXRt3wLCBslk6oWJa7Qp+5+ylPvj
 JpohWNaYxfHJvNfq9HqhHjBOwpZbMNfiDvgvLQKVosls1xO3l0Kn8pSRO6FUCqAyyL
 OVEu4doGq1lkA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
In-Reply-To: <20251003222714.4921-1-semen.protsenko@linaro.org>
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
Date: Thu, 09 Oct 2025 13:27:05 +0200
Message-ID: <87cy6wwc1i.fsf@kernel.org>
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

Hi Sam,

Thank you for the patch.

On Fri, Oct 03, 2025 at 17:27, Sam Protsenko <semen.protsenko@linaro.org> wrote:

> A "Synchronous Abort" CPU exception happens on an attempt to run the
> "bootflow info" command for a global boot method (e.g. efi_mgr):
>
>     => bootflow select 0
>     => bootflow info
>
>     "Synchronous Abort" handler, esr 0x96000006, far 0x8
>
> It happens because do_bootflow_info() tries to dereference bflow->dev,
> which is NULL in case of efi_mgr. Add the corresponding check to prevent
> this NULL pointer dereference and make "bootflow info" command work
> properly for global boot methods.
>
> Fixes: 2d653f686b6d ("bootstd: Add a bootflow command")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  cmd/bootflow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 551dffbb8b89..081f64e12ce9 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -404,7 +404,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
>  	}
>  
>  	printf("Name:      %s\n", bflow->name);
> -	printf("Device:    %s\n", bflow->dev->name);
> +	printf("Device:    %s\n", bflow->dev ? bflow->dev->name : "(none)");
>  	printf("Block dev: %s\n", bflow->blk ? bflow->blk->name : "(none)");
>  	printf("Method:    %s\n", bflow->method->name);
>  	printf("State:     %s\n", bootflow_state_get_name(bflow->state));
>
> base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
> -- 
> 2.39.5
