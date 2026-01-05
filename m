Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A31C2A062
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 00:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678F283990;
	Mon,  5 Jan 2026 01:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="BSv0tOBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687B583A26; Mon,  5 Jan 2026 01:31:32 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451268398C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 01:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1767573089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZt/68blACYrx68Dtn/O6vMgKIkzprrxcLf1UuM6jcg=;
 b=BSv0tOBqDwJNghaKzksrS9f5/slybl3CPV9NwMmSlFrz/Y/Ma55SIwtcqGWByod3StvQvK
 wZOm3c0eSTuZbSxZ7pS1gDFnvuGz/F8JMh1IT4Fswv/qRVw3HjNpXtV7CP1DXEIG2vp4yD
 oTTATBs99C3zQaYpG+X9A7DPMgJajSc=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 883d3614
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 5 Jan 2026 00:31:29 +0000 (UTC)
Message-ID: <54c0852c-ebaf-42b1-8bfb-b09eacefc1ba@kernel-space.org>
Date: Mon, 5 Jan 2026 01:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/25] m68k: Drop unused status_led.h header file
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@sysam.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021113839.318572-17-sjg@chromium.org>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20241021113839.318572-17-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Angelo Dureghello <angelo@kernel-space.org>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 10/21/24 13:38, Simon Glass wrote:
> This header file is not used, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/m68k/lib/bootm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
> index 3dcff8076e3..1fa112f8dbf 100644
> --- a/arch/m68k/lib/bootm.c
> +++ b/arch/m68k/lib/bootm.c
> @@ -15,9 +15,6 @@
>  #include <bzlib.h>
>  #include <watchdog.h>
>  #include <asm/byteorder.h>
> -#ifdef CONFIG_SHOW_BOOT_PROGRESS
> -# include <status_led.h>
> -#endif
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  

-- Angelo

