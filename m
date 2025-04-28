Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517E9C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 07:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B6380AE1;
	Mon, 28 Apr 2025 09:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CctRHt00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D8780BAD; Mon, 28 Apr 2025 09:53:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC058056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 238825C5F90;
 Mon, 28 Apr 2025 07:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E3C4CEE4;
 Mon, 28 Apr 2025 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745826807;
 bh=dONou1UHW+5wUIeF6MD7sqdnTPwCR1aEH9eu24Fkqkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CctRHt00bZrYrI+Bl/Sh54JpyzEkMoxTZgXzFDZUHkxZR+clMM6pBgQKscUNEQD7A
 Q/snXiOU795LtqYTuBaalJCBLt3CSiBDi5GfAjS+j4H2tUjBMxUSffLBCCll60rnoI
 6tYS+7NwW5rdQEAU/VB+t9gVKvzQD5dEDCz/M5hN02f2eMJu0uATesJI4DWCXTURsm
 RM1BAIfFeBvXO3oPMeTQyhxObf6RL3B0VHlm3buT+p3K32hjlP71bsZ1G/zwzdDhIg
 nEEE3rFPq7NtRt/SwfMDmyu87QbRfZfqpeEC8OS4fjvNrV0ev58Reb96QA19V8YN/a
 Y9A99MonXG92g==
Date: Mon, 28 Apr 2025 13:23:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Sam Day <me@samcday.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] board: dragonboard410c: More fixes for U-Boot v2025.07
Message-ID: <aA8z8iBYOsKy-clk@sumit-X1>
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
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

On Thu, Apr 17, 2025 at 03:49:10PM +0200, Stephan Gerhold wrote:
> Fix some more issues in the U-Boot configuration for the DragonBoard 410c
> that I noticed when testing the current master branch after the recent
> changes were merged. Ideally these should go as fixes into v2025.07.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (3):
>       board: dragonboard410c: Fix button cmd name
>       board: dragonboard410c: Drop custom reduced malloc size
>       board: dragonboard410c: Enable support for KASLR in Linux
>

Nicely done, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>  board/qualcomm/dragonboard410c/dragonboard410c.env | 2 +-
>  configs/dragonboard410c_defconfig                  | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> ---
> base-commit: 5b4ae0f3f040908602c80908c3023b5454883d4a
> change-id: 20250416-db410c-fixes2-7db207c10724
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 
