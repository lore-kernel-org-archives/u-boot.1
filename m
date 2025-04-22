Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35FBC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 07:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD8481026;
	Tue, 22 Apr 2025 09:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OcVKD8l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2964A810E8; Tue, 22 Apr 2025 09:09:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041E280F6B
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 09:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7E2C95C5830;
 Tue, 22 Apr 2025 07:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F9EC4CEE9;
 Tue, 22 Apr 2025 07:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745305775;
 bh=ms7zPntcpMSn0UifP3PuDiLIwpo3MemIduqMw/nZJ4w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OcVKD8l06W49WIS4GlpHqv0PPcNq5at0k3bmAAExyqRPpsJEk9u762BF3Ineja6J6
 AV/Z35h25ebcLpvP3tELHVtUxF7oHlb9WHQRvDeXSGVspGMFCai335bDks7SZksIZl
 hRdFcr98Cz9CXYX9duD5lzIhQwtvx+rgS05k5F8Qd4jcxr1f1cuSUt9MmalDtbFp8w
 PSrudp3sZBo/KrvBV3bzAPtXZ+GJeHmMVEEzW/uUSpl6AlgrfEfAzwy/oQyeeRxKEP
 9ZDj4y44wDlkIbwphjROADfskrCLLCmmCoyR53+G4ITnyaeQzEYbZdqj1IDSJftjKY
 yZOvsG7WrWdnw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 sjg@chromium.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org,
 michal.simek@amd.com, ibai.erkiaga-elorza@amd.com
Subject: Re: [PATCH] cmd: Kconfig: Fix typos
In-Reply-To: <20250420081210.292644-1-aristo.chen@canonical.com>
References: <20250420081210.292644-1-aristo.chen@canonical.com>
Date: Tue, 22 Apr 2025 09:09:31 +0200
Message-ID: <87fri0hduc.fsf@kernel.org>
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

Hi Aristo,

Thank you for the patch.

On dim., avril 20, 2025 at 16:12, Aristo Chen <jj251510319013@gmail.com> wrote:

> fix the following typos
> - from "categorys" to "categories"
> - from "indivdually" to "individually"
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c2ce519d1e3..6e722279205 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -5,7 +5,7 @@ menuconfig CMDLINE
>  	  Enable U-Boot's command-line functions. This provides a means
>  	  to enter commands into U-Boot for a wide variety of purposes. It
>  	  also allows scripts (containing commands) to be executed.
> -	  Various commands and command categorys can be indivdually enabled.
> +	  Various commands and command categories can be individually enabled.
>  	  Depending on the number of commands enabled, this can add
>  	  substantially to the size of U-Boot.
>  
> -- 
> 2.34.1
