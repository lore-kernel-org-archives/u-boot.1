Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB6ACF6493
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 07:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BEC88FC7;
	Tue,  1 Oct 2024 09:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="aFynSlGl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="MUA/qMhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E2C89003; Tue,  1 Oct 2024 09:22:52 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF32588F77
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 09:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 38a34106;
 Tue, 1 Oct 2024 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=uJ
 MNaXM1tAu3KFQAXXLmzdspAyQ=; b=aFynSlGlx7h4EWoXbVWrAiDAeHS8h+iskD
 tI3KLSlm2elBYzU5AfVfdiTR9a+OpZQPtDp9ru7I37FTsY54GBDMoWxYyakwO1Uh
 uIim1yjV2CDgVE+Ajg2rEkunmxcrRX6fDi7iFFXYAXkmYivA1VX+HZ6MmIXUuLK1
 JgOviAR64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 PZCHFk8bQCkh5ZHgKaTSEeONL2uODbf/M30QMTxQFM5U8Bpbompq6FMiX7/rmZfy
 K3Tkz23tvt1VWA63fwCUBsqT6VkJIMHI4u8v8b33JsR0v4uy0nXzpPMU/Sh/SHxq
 g8JJfdynh7fQkWISwCnkClkHPiGzuo7x63GxSkuzBl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1727766951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28WDqrAHcRNz/kIlKUHf+2B99VvtF4ab4Rkf2+Fu5js=;
 b=MUA/qMhWAk8GE8hkD2Y3VCuzLvrKovywvHoDpS2EO1WAsdmwVtdTaLYDiVee/a0nho9SQC
 aVfYPrPykDE/jVUWFwiC/ec0woMUR1+mJYkgMcEyLLgDFpQr49MharAbAYmNmzEiZY4Orj
 C/eG2lvlNBr4tuK196pODeBJ0lFgtEY=
Received: from [192.168.0.2] (host-79-54-25-3.retail.telecomitalia.it
 [79.54.25.3])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 5c8ea777
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 1 Oct 2024 07:15:51 +0000 (UTC)
Message-ID: <1dd21156-f976-4d0e-8251-c44ab144342c@kernel-space.org>
Date: Tue, 1 Oct 2024 09:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Acked
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@sysam.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-16-sjg@chromium.org>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240926204455.963584-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

Thanks !

On 26/09/24 10:44 PM, Simon Glass wrote:
> This header file is not used, so drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   arch/m68k/lib/bootm.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
> index 3dcff8076e3..1fa112f8dbf 100644
> --- a/arch/m68k/lib/bootm.c
> +++ b/arch/m68k/lib/bootm.c
> @@ -15,9 +15,6 @@
>   #include <bzlib.h>
>   #include <watchdog.h>
>   #include <asm/byteorder.h>
> -#ifdef CONFIG_SHOW_BOOT_PROGRESS
> -# include <status_led.h>
> -#endif
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
