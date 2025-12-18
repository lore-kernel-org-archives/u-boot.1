Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABEED6D220
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 13:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EBC83D8A;
	Thu, 18 Dec 2025 14:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qGBOPqOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9C283DBD; Thu, 18 Dec 2025 14:44:45 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C68083D07
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C82C943255;
 Thu, 18 Dec 2025 13:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EAFC4CEFB;
 Thu, 18 Dec 2025 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766065481;
 bh=4cmp3Ud/gOp5GLafInAlnYYbAleYTMPQGV9ejJIIn9w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qGBOPqOUVQGB3zWWmXLJBP2TbK0FjUkFkONg/DRvlVESmVYhG7Wba2w45voSRuM7f
 yyaqoiMQ4yRtrvmRY5rHPB8GWT/Zt+CmvdBEtkeN+PXGxewIX/+oPOK6cRp6C9KPhD
 OjT7ph0ZHyu+kmKu7f7lntMrj2yVUCC3AQke6NbqiagA5SB2QmJ4Pye2+oBZNvWtMw
 AlwmFP3ADoJS5N3d3YwwJ+zWfBVf9Dl/NQZBIOTWfBWTmIOsmi74oD9gRohiIp1Gx1
 7WheMhSAF0kEQqYuJ1v2k5egY/HpkzvvHW6VhcAmnCPr5H/bbOV9aT1e3kw3dXa+Lt
 Uviplljd3jUjg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>, Julien Masson
 <jmasson@baylibre.com>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Casey Connolly <casey.connolly@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] boot: fix missing dependency for BOOTMETH_ANDROID
In-Reply-To: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
References: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
Date: Thu, 18 Dec 2025 14:44:38 +0100
Message-ID: <875xa3dhvd.fsf@kernel.org>
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

Hi Quentin,

Thank you for the patch.

On Thu, Dec 18, 2025 at 13:19, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The code depends on set_avendor_bootimg_addr and set_abootimg_addr
> functions which are only defined in cmd/abootimg.c, only built when
> CMD_ABOOTIMG=y so let's add a dependency.
>
> It should be "depends on" to be properly implemented, but we get a
> circular dependency otherwise:
> boot/Kconfig:566:error: recursive dependency detected!
> boot/Kconfig:566:	symbol BOOTMETH_ANDROID depends on CMD_ABOOTIMG
> cmd/Kconfig:504:	symbol CMD_ABOOTIMG depends on ANDROID_BOOT_IMAGE
> boot/Kconfig:7:	symbol ANDROID_BOOT_IMAGE is selected by BOOTMETH_ANDROID
>
> so instead we do a select. It is safe because CMD_ABOOTIMG depends on
> ANDROID_BOOT_IMAGE which we select here as well.
>
> Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 245e120c70b..aa135a4e1a5 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -568,6 +568,7 @@ config BOOTMETH_ANDROID
>  	depends on X86 || ARM || SANDBOX
>  	depends on CMDLINE
>  	select ANDROID_BOOT_IMAGE
> +	select CMD_ABOOTIMG
>  	select CMD_BCB
>  	imply CMD_FASTBOOT
>  	imply FASTBOOT if !NET_LWIP
>
> ---
> base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
> change-id: 20251218-bootmeth_android-deps-a16555d168e5
>
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
