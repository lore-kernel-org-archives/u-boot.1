Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3884CCDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D75F86F34;
	Sun, 15 Oct 2023 08:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bw5zcwxj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eT8wDxIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF54F8691E; Sun, 15 Oct 2023 08:31:52 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A1086F37
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7Db85LqTz9sdh;
 Sat, 14 Oct 2023 21:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UyjlHyrmaBfBXazfirkkRSqHcyQ20PeZSTLJZyaZI0=;
 b=Bw5zcwxjexjyUizjs+IMkS20xhjIWpXoXVBX0LSeL7Llv4EvJt9fITPz9l8RJlSfTbEkXU
 I6eCMqS6HWuo+lyA/cQJadOCFEvnKQSyctwpgKg6MKmks+i0Td6RhL1anFmjv8oNZt4gFE
 vbiyZ+849FL3sjnNbMnyjrqPqoX9uAEGM+XXc90bKpR8Nap4YG87U8bE+HwfqwU/gxIeUM
 jQM9W5BwCttMOY9/+tUT6dhkmU+hJaCGAco7CGel2W2izhIGE8eHjYjMP6dS++YlEGc7Fh
 5MA9IhmTWmGnmPvoG3yXUxdSkKv2wWmMtzVl8Y9nLJXS1MLF8bUo9usRX9Iw0g==
Message-ID: <4beeef07-6cdc-4f34-8ed1-5ba31c36f04c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UyjlHyrmaBfBXazfirkkRSqHcyQ20PeZSTLJZyaZI0=;
 b=eT8wDxIs6jdBj3hHP1HmCOI4JJJiegsVrvY5ZQExVMevceXLmUpEljfVviqzodcJWtJrot
 BelVKH7sYUSdQadq7c7S6cTCLZXXQvNVesH6P00tNo1hGXQXijn9Lv+0F+93yKwX7UCoHW
 jnr0p5JWKYsxCZo3dcHaObhAWCr9BywDzvJQd+frlD3Hb5Md4SUZpFO6xy40g0IYKghAs9
 sj1zlO+h06alrikFmhM8zixfZ13wZwe6c+smQfqidvTo5mksjpcUgCpIHyrK75xBuIkLpx
 AOGKI1oZ9MljXi6BwfSzReaWuhyrO0IQDcWtck3DUJLwRJaE2TmLMPX901QejA==
Date: Sat, 14 Oct 2023 21:53:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 12/19] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b5311f7d38eba4f3ef9
X-MBO-RS-META: wbmwxgxu9mwop5jw6fmsjikxp4okxgpi
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

On 10/9/23 18:46, Paul Barker wrote:
> Extend the existing driver to support the SCIF serial ports on the
> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
> relevant reset signal is de-asserted before we try to talk to the SCIF
> module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>    * Moved handle_error() changes out to a separate patch earlier in the
>      series.
>    * Unconditionally de-assert the module reset during probe.
> 
>   arch/arm/mach-rmobile/Kconfig |  1 +
>   drivers/serial/serial_sh.c    | 17 +++++++++++++++++
>   drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>   3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index c30ff2caad17..c421181c89cf 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -77,6 +77,7 @@ config RZG2L
>   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>   	imply PINCTRL_RZG2L
>   	imply RENESAS_SDHI
> +	imply SCIF_CONSOLE
>   	imply SYS_MALLOC_F
>   	help
>   	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index 2b650d458e71..6ea8da34d434 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -17,6 +17,8 @@
>   #include <linux/compiler.h>
>   #include <dm/platform_data/serial_sh.h>
>   #include <linux/delay.h>
> +#include <dm/device_compat.h>
> +#include <reset.h>

Please keep the list sorted.
