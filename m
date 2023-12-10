Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6032C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 19:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DDE876F7;
	Sun, 10 Dec 2023 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="jz3/jDD0";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="FL4gMCnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33CB86FCE; Sun, 10 Dec 2023 20:37:55 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD2484694
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 20:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id f30149b4;
 Sun, 10 Dec 2023 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=dJ
 Etook4LwpOWwQIDFegi9v8UPA=; b=jz3/jDD0t5JEyhg/cwwRbAYzO0m0m2K7Fx
 z0aJ+gT013GOq9F1E6BecIPcXRwrPR22GpTXMf5FHSVFxwhahylqPq8Os5CA4qgd
 2TtDewZTPpfNPgTKRcn7oBOwPQVPt87LsV7lIm1FLLPIeJLResBaecitdS4KD4lb
 IMI2YTy7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 nRJhR+vt6tjk5TcL9P32SmYRqhJ8X3zwb68qkd0iXjZwwgty/FqwLIfhP1fmPjAE
 6/KK+sJpSNbAxSfIBVnWIpIHzCOpqgc3glRSXKaAZGvmybdD0qbAey7h2tOy5T8u
 Rb33UVTnc1sVYl1sIn9Lg4/HLxZa0whJceoZtmalmkg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1702237003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULpO7Dl0U8tr9/5PA8vLIToungT+u0DFHdA6XzCX9cQ=;
 b=FL4gMCnA6ShYoAYa4ksCdq0N5D1KAEEJXMZazL1tGP2fBR5sWjl0yVr8p/KwEq7C8jb+Nt
 3U8MwINweUkbytZsVZdTufZI0i4gSX/IIIDWQKnwUgZNdkICl5evzBu1EZcEVCOg51Liye
 oL4DPeDddzw31JPfr2O+0xuZVMUhlYM=
Received: from [192.168.0.2] (host-80-182-197-185.retail.telecomitalia.it
 [80.182.197.185])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id e97b46fe
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 10 Dec 2023 19:36:43 +0000 (UTC)
Message-ID: <06d0c62d-15a6-d227-ae3b-4c80bb9fe692@kernel-space.org>
Date: Sun, 10 Dec 2023 20:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 08/18] m68k: Add a reset_cpu() function
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@sysam.it>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231203172622.8.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
From: Angelo Dureghello <angelo@kernel-space.org>
Content-Language: en-US, it
In-Reply-To: <20231203172622.8.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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

Hi Simon,


Acked-by: Angelo Dureghello <angelo@kernel-spcece.org>


On 04/12/23 1:26 AM, Simon Glass wrote:
> The current do_reset() is called from a command context. Add a function
> which can be used from anywhere, as is done on ARM.
> 
> Since there are lots of reset functions, this one actually just calls
> do_reset(). Future refactoring could correct this.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/m68k/lib/traps.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
> index c283351181d8..ae8ae6ccf592 100644
> --- a/arch/m68k/lib/traps.c
> +++ b/arch/m68k/lib/traps.c
> @@ -7,6 +7,7 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> +#include <cpu_func.h>
>   #include <init.h>
>   #include <watchdog.h>
>   #include <command.h>
> @@ -65,3 +66,9 @@ int arch_initr_trap(void)
>   
>   	return 0;
>   }
> +
> +void reset_cpu(void)
> +{
> +	/* TODO: Refactor all the do_reset calls to be reset_cpu() instead */
> +	do_reset(NULL, 0, 0, NULL);
> +}
