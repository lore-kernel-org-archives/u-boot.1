Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11856D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 09:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1B483A3B;
	Tue, 20 Jan 2026 10:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="m9LHr7FV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE2A83A6A; Tue, 20 Jan 2026 10:33:49 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166E083A2D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 10:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3e894255-f5e3-11f0-be9a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3e894255-f5e3-11f0-be9a-005056992ed3;
 Tue, 20 Jan 2026 10:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=jEGl2QDGpEBP60mDxZI5CoJV5VH2/AUYIVqZ+JuR4Is=;
 b=m9LHr7FVF1/u4V1n9Uho2VSXdfk1IINr2x4pOnO+ekjWBwLOo1yhbsaw3mB8Q2JrOQ6QVtOFX1TEO
 rZ5US12hwPkNBVK9dlMbuy6t4ytl9dzQ4ZvE4LsLCWs4+P4J028cn1sIFJvhBRqQN9t7QKlgcQu1l5
 S0l9Ykze6+2oku9x9nrr5Q/aYlCbF3lwUfk9UKDr/5+H7v/Jxbd1JCgqZ+/+7kyQMrE46QxYC1qFuw
 SafPEPEFy21RUX02s2PQQrfi2ZZrJRN7Jw8j34C5H3FqynGp7irL7Inr8eDyR+UX1JUKbi8bkSCTcO
 wHvlXL+UrVGG6rlbwKJVpymr6OidVhA==
X-KPN-MID: 33|6ABXAW2sIXcnpRorFfiO9U22g0wFIqtdWm5mzAcAkp9IL/DGra+Fr39wn2Tq7Ml
 wFlQd7FAWpvNYHmniDwhkMPRFojWTPSzMfx036qm3g3U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Dl96axYXKifnHt8qcshjPdYpcAYJQVUz9OX7oDyQQUThhsFRQM+HadsKd07UeLO
 qBeAhlcseiypBHxt5G9CXow==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1dead03e-f5e3-11f0-bff7-00505699772e;
 Tue, 20 Jan 2026 10:33:46 +0100 (CET)
Date: Tue, 20 Jan 2026 10:33:45 +0100
Message-Id: <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: paul.liu@linaro.org, adrianox@gmail.com,
 casey.connolly@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 mkorpershoek@kernel.org, ravi@prevas.dk, trini@konsulko.com,
 me@ziyao.cc, u-boot@lists.denx.de
In-Reply-To: <20260119210925.29185-3-casey.connolly@linaro.org> (message from
 Casey Connolly on Mon, 19 Jan 2026 22:09:25 +0100)
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
References: <20260119210925.29185-3-casey.connolly@linaro.org>
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

> From: Casey Connolly <casey.connolly@linaro.org>
> Date: Mon, 19 Jan 2026 22:09:25 +0100
> 
> Hardware watchdogs don't currently get stopped as part of
> ExitBootServices, this can result in resets during boot if the OS
> doesn't have a driver for the watchdog, or if the driver isn't loaded
> in time.
> 
> As with the EFI watchdog, stop any hardware watchdogs as well.

This has been discussed before and rejected on the grounds that this
defeats the purpose of the watchdog.  I think there was some consensus
that an OS that doesn't have a driver for the watchdog or doesn't load
it in time is broken.  Some folks also pointed out that on some
platforms it isn't possible to disable the watchdog.

Ultimately, I think EFI needs an API to control the hardware watchdog,
such that an OS doesn't need a driver.

> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes in v2:
> * Fix compilation when CONFIG_WATCHDOG is disabled.
> 
> ---
>  lib/efi_loader/efi_boottime.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ddc935d22409..c34616db578a 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -21,8 +21,9 @@
>  #include <time.h>
>  #include <u-boot/crc.h>
>  #include <usb.h>
>  #include <watchdog.h>
> +#include <wdt.h>
>  #include <asm/global_data.h>
>  #include <linux/libfdt_env.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>  	efi_update_table_header_crc32(&systab.hdr);
>  
>  	/* Give the payload some time to boot */
>  	efi_set_watchdog(0);
> +	if (CONFIG_IS_ENABLED(WDT))
> +		wdt_stop_all();
>  	schedule();
>  out:
>  	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>  		if (ret != EFI_SUCCESS)
> -- 
> 2.52.0
> 
> 
