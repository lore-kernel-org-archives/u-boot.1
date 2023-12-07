Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4360CC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 16:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47738722C;
	Thu,  7 Dec 2023 17:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="DhqwAeQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F76387250; Thu,  7 Dec 2023 17:54:09 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA1487207
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 17:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3906eb07-9521-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3906eb07-9521-11ee-b94e-005056992ed3;
 Thu, 07 Dec 2023 17:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=JiKnOIntVDM9nOkOt8hmMcK/qqMziCVQF21Z0YJW9ik=;
 b=DhqwAeQu8Zakcbi6nVyw/Sx3uxe2L6aNg5jsZNDdS1ovH5vjIgksa12FETdUnF+Mq8VsvBRMrJ+C2
 CH67aVnaPOlbWbLaZ1AnLT3dHlXWDcDOTACN67pNVyXPIHkyaVotliFy9pIC3wvxCZXMo7OEaYyfgc
 EkIXTkQ1kcLOTnzk9WRqZQzJ8WDMhjWoAQm5zzIk3DXWLu+zAOKaZ/oTvRhgTsD/TWOOrHjJRqexLf
 j0+xocMPfaQ28/GI6SMdt5hBQrH629HAnHJ/aZk6syyRMbIRxmLAZbB8X3vLbEE2D3SmIXNM+NO6IP
 cbl7AmqenpduMaYuTNfMguBzjZ14cWA==
X-KPN-MID: 33|7RGbxEgWckfrOZRHukT4kK5RiIVFcwELQEvP11uYVUr73+RRo6cB/yPyG402ieQ
 Ge1hbaJ9AcqzeBEHM2yv9sa84Y13p/mlEE3f8x1DNfes=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xyyGkctMCxzK69Ri3EbOoo/OZ86vQ0ImVp+ercIp0aQVlo34tg/WBbCllD+7FIW
 PYm80+obHivE3iA1Ssmg3Sg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3b90b6f4-9521-11ee-acaa-00505699d6e5;
 Thu, 07 Dec 2023 17:54:06 +0100 (CET)
Date: Thu, 07 Dec 2023 17:54:06 +0100
Message-Id: <871qby7y35.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sjg@chromium.org, heinrich.schuchardt@canonical.com,
 ilias.apalodimas@linaro.org, kettenis@openbsd.org, u-boot@lists.denx.de
In-Reply-To: <20231207123636.26264-1-ilias.apalodimas@linaro.org> (message
 from Ilias Apalodimas on Thu, 7 Dec 2023 14:36:36 +0200)
Subject: Re: [PATCH v2] bootstd: Fix a memory leak in the efi manager bootflow
References: <20231207123636.26264-1-ilias.apalodimas@linaro.org>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Thu,  7 Dec 2023 14:36:36 +0200
> 
> efi_get_var() allocates memory which has to be freed after the value of
> the variable is consumed. Free the memory properly
> 
> Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Apologies for the quick resend but the previous patches wasn't compiling due to
> the missing #include <malloc.h>
> 
> Changes since v1
> - Add #include <malloc.h> since it's needed for free()
> 
>  boot/bootmeth_efi_mgr.c | 2 ++
>  1 file changed, 2 insertions(+)

Oops!

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index e6c42d41fb80..6428c096d7f8 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -16,6 +16,7 @@
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> +#include <malloc.h>
> 
>  /**
>   * struct efi_mgr_priv - private info for the efi-mgr driver
> @@ -65,6 +66,7 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
>  				&size);
>  	if (bootorder) {
> +		free(bootorder);
>  		bflow->state = BOOTFLOWST_READY;
>  		return 0;
>  	}
> --
> 2.40.1
> 
> 
