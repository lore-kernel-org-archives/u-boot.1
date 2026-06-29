Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F592C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E4684A5D;
	Mon, 29 Jun 2026 20:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="aom/cdry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AE084A93; Mon, 29 Jun 2026 20:44:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CCD8F849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2D3271B;
 Mon, 29 Jun 2026 11:44:13 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE513F905;
 Mon, 29 Jun 2026 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782758658; bh=RZ6RvtNGdO/KbawcMlBNs9/AavDLgeXJ+F/DbeES/Zo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aom/cdryaDp2SqXeGt1Md3O4OfpFzuH12UQ5VN+ib8EnrUKnOQlQDkb96wHwRUcHw
 xxoDXf625Qd/RN/9BSl4V8/xlN/7A3LbF5Ryu1bdrk3AXaQD9/bsRYIz5z3uxrOynW
 x2Sx4AtbxyXbb9nP/5ChJxMhMIVwDgqRIdYsaHI4=
Date: Mon, 29 Jun 2026 19:44:07 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 06/10] corstone1000: enable bootefi selftest
Message-ID: <akK8957d7vF5tNp_@e130802.arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-7-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627144421.2067410-7-harsimransingh.tungal@arm.com>
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

Hi Harsimran,

On Sat, Jun 27, 2026 at 03:44:17PM +0100, Harsimran Singh Tungal wrote:
> Enable `CMD_BOOTEFI_SELFTEST` in `corstone1000_defconfig` so the later
> runtime-variable selftest patch in this series can be exercised on
> Corstone-1000.
> 
> Keep `CMD_BOOTEFI_HELLO` and `CMD_POWEROFF` explicitly disabled.
> Enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
> `CMD_BOOTEFI_HELLO` default to `y` and pull in `CMD_POWEROFF` on this
> PSCI-based defconfig. The intent here is to enable the selftest command
> without broadening the rest of the board command set.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  configs/corstone1000_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> index 876b915b6a4..e16b13043ac 100644
> --- a/configs/corstone1000_defconfig
> +++ b/configs/corstone1000_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
>  # CONFIG_CMD_CONSOLE is not set
>  CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_BOOTZ=y
> +# CONFIG_CMD_BOOTEFI_HELLO is not set
> +CONFIG_CMD_BOOTEFI_SELFTEST=y
>  # CONFIG_CMD_XIMG is not set
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_LOADM=y
> @@ -62,6 +64,7 @@ CONFIG_SYSRESET=y
>  CONFIG_SYSRESET_PSCI=y
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
> +# CONFIG_CMD_POWEROFF is not set
>  CONFIG_USB=y
>  CONFIG_USB_ISP1760=y
>  # CONFIG_RANDOM_UUID is not set
> -- 
> 2.34.1
> 

Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Kind regards
