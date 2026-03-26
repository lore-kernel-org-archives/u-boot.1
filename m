Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA87106F304
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A203481E18;
	Thu, 26 Mar 2026 09:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aU+YBnBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEF8838BB; Thu, 26 Mar 2026 09:56:52 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B5080517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CBCD660053;
 Thu, 26 Mar 2026 08:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1612BC116C6;
 Thu, 26 Mar 2026 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774515407;
 bh=i5tkQ60CrpVI+5rE1NcoxdArEtClMQMkcw+835tf3iU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aU+YBnBpFtpGj7sS8sHkRFSSG4X/rFvNubc3q00LyyiX3T1ZvirVdmtA+qp1TesGg
 zlelMqY1G7ZTEyfFHSkXe5CsKhFmbC9thrm9jCha3TEnCkXyISNE/QKBXh25g5I2mM
 ZWQeUGOuUTTlDFeyLPPwzKyudhZUO3XWt/DUhYR0rGzmnYQ5Tpr5fHExlDRXgOCEFL
 0LWZcxSo2/i8bAjZpuQ89t5jhQ0Zz6/YCI5g76G/f6vXe2U3Arzzyx0qR1gaDLxY6k
 sewu5EuOWS1DDHPlR4td5sbERAsHVt61PORpWat1yfwK+9b5uaWwUznBcqHNrCo5S3
 w9slwzz9rLS8g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] dfu: Correct dependencies for DFU_TFTP
In-Reply-To: <20260317012435.4162538-1-trini@konsulko.com>
References: <20260317012435.4162538-1-trini@konsulko.com>
Date: Thu, 26 Mar 2026 09:56:44 +0100
Message-ID: <87wlyzge9f.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Mon, Mar 16, 2026 at 19:24, Tom Rini <trini@konsulko.com> wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for DFU_TFTP. This really depends on the legacy networking stack being
> enabled, not just lwIP not being enabled (as it will fail in the NO_NET
> case).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  drivers/dfu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 962bda40ad2d..1d5d8caa7daa 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -20,7 +20,7 @@ if DFU
>  config DFU_TFTP
>  	bool "DFU via TFTP"
>  	depends on NETDEVICES
> -	depends on !NET_LWIP
> +	depends on NET # Legacy stack only
>  	select UPDATE_COMMON
>  	select DFU_OVER_TFTP
>  	help
> -- 
> 2.43.0
