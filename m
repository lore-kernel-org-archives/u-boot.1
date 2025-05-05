Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81127C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 10:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B2F81F7B;
	Mon,  5 May 2025 12:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tBrYspco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7137A81F7E; Mon,  5 May 2025 12:04:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F2280F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 12:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BC21F5C572A;
 Mon,  5 May 2025 10:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FF4C4CEE4;
 Mon,  5 May 2025 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746439480;
 bh=PvihBiVjIqvj+K+oCl8M4WdgAeHeCoMQEyZcTQAchRQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tBrYspcoVaYzDrZYlhenomUxnF8U6ncPk66jJtCYKK+8483alxYh+WDahc9dmV4PD
 SgeZq0HmDVaQHj46sl9542Dlpi1W40EUnAiDT0TCp5QKO9Ad5Sod0EUMsLE0F4H9aq
 MpyvSWqQE9xdpYSyAwwX7zkSuP2szOWBZ1XgeD1Fr5Os/onU5Xn5DgGy/c32+pvQy2
 A0KN1q8Lzf3DQ+R1zrnYVJr4qiulv6Q7vhdVXR4eyyXikvuK5cPV5AYPAAyLyT1mUo
 9RUVxXeGcSk4RPtdRMb2eHJprdGFvUeRbmKHwYm1UxdhDDOCfcjZXkvYanFvexcbRV
 glZgpmUVz21cQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] doc: describe u-boot-test-release
In-Reply-To: <20250503101424.48236-1-heinrich.schuchardt@canonical.com>
References: <20250503101424.48236-1-heinrich.schuchardt@canonical.com>
Date: Mon, 05 May 2025 12:04:38 +0200
Message-ID: <871pt374qx.fsf@kernel.org>
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

Hi Heinrich,

Thank you for the patch.

On sam., mai 03, 2025 at 12:14, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> The scripts u-boot-test-release is called at the end of testing.
> Describe it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/develop/py_testing.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> index 217ae447035..824e3c0d9a7 100644
> --- a/doc/develop/py_testing.rst
> +++ b/doc/develop/py_testing.rst
> @@ -388,6 +388,13 @@ to download the U-Boot binary directly into RAM and execute it. This would
>  avoid the need for `u-boot-test-flash` to actually write U-Boot to flash, thus
>  saving wear on the flash chip(s).
>  
> +u-boot-test-release
> +'''''''''''''''''''
> +
> +When all tests for the board have been executed, this script is called.
> +
> +The board can be switched off now.
> +
>  Examples
>  ''''''''
>  
> -- 
> 2.48.1
