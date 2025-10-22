Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F2CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273BC8357F;
	Wed, 22 Oct 2025 17:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FQPGoVR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2580422; Wed, 22 Oct 2025 17:22:47 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E498835FD
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6300E6050C;
 Wed, 22 Oct 2025 15:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7175C113D0;
 Wed, 22 Oct 2025 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761146564;
 bh=aNRDkWVnpDFtDo5lo77LLe4svF2A07Ns9I1Fkvbt6WY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FQPGoVR2BGJ01xUR0RCA71ZYVOsMbABpdMWvW1E8dte5xGbKmP916F51axk2N+mjU
 S/KbmwXb/H2qNzp9Z3PJKKGpFBVnw0xWuNTn1OQtR8AFfhnT8g2lzZ+nJHOJFiyH5X
 /OtiUPDOiES+5eEsXPt/++rfRBUez1jmuez5Z06MURHebFyxqhA0DnXgRwdOg6TB2S
 GCVeYOwFrIgCQQqAh5GmX4XkRC7CGThKdoxPaaJ74evVbbldf1ONs3Bx/zaJIzya9+
 y5FSBWdSlaRmh8RWc2aJZCyD1NOkJKNrhh4AgvkvyG+T0bgTibFSGfBAzwXK6fNJ1h
 WNEDuo0mutVaw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] doc: pytest: Complete dependencies list with missing
 packages
In-Reply-To: <20251022132055.816662-1-kory.maincent@bootlin.com>
References: <20251022132055.816662-1-kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:22:38 +0200
Message-ID: <87bjlzarlt.fsf@kernel.org>
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

Hi Kory,

Thank you for the patch.

On Wed, Oct 22, 2025 at 15:20, Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>
> Add missing dependencies to the pytest usage documentation and correct
> the device tree compiler package name from 'dtc' to 'device-tree-compiler'.
>
> This ensures users have the complete list of dependencies needed to run
> the pytest test suite without errors.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  doc/develop/pytest/usage.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index 779b2dbe24b..454877837ca 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -39,7 +39,7 @@ will be required. The following is an incomplete list:

If the list is now complete (as per your commit message), should we
update this sentence as well to remove "incomplete" ?

>  
>  * gdisk
>  * dfu-util
> -* dtc
> +* device-tree-compiler
>  * openssl
>  * e2fsprogs
>  * util-linux
> @@ -50,6 +50,11 @@ will be required. The following is an incomplete list:
>  * mtools
>  * sbsigntool
>  * udisks2
> +* swig
> +* cgpt
> +* libgnutls28-dev
> +* vboot-kernel-utils
> +* fdisk
>  
>  Please use the appropriate commands for your distribution to match these tools
>  up with the package that provides them.
> -- 
> 2.43.0
