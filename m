Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D383CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 18:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25BA809A5;
	Sun, 14 Sep 2025 20:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrAZr1Nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CDF80B9B; Sun, 14 Sep 2025 20:36:07 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544C980422
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 20:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=osama.abdelkader@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so625815f8f.0
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757874965; x=1758479765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UqWyNCs7pn9hZ0yGDjfvirlEsje128ttX2EdqVTkGhI=;
 b=LrAZr1Nj+YVIx2fnEar2A/eG+hcWhq5KNeyV9H2u2uui+nBpw0lZN+fc4IzO+A0Mu+
 PPoadBYYKA3EZ24BB+ruF1/IFYOMJsSXrsuaevq51rNt8Lq7lrWRyx1XVnUq8B6Di9Do
 ATE+bQo27TXyO9ZCGPs2OXjOV2xWBAnFs7w0CQKQzUBPG2K7vB4nRUfmp4yxne9ojrcc
 rBwDP7MmjUV0gFQWnZ3Sh3LOT12Ura8l4WhJ666tI1bkvbMj2cJubc/MUirSsQinx8Ql
 vYY1a9jujk360g6L7JKueFzezSGkb0aJ+XmENfPHOswhzubtJpJ2Kdx8hrfETiH7Wb2V
 e6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757874965; x=1758479765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqWyNCs7pn9hZ0yGDjfvirlEsje128ttX2EdqVTkGhI=;
 b=Sr0iqumnRd2vko0ttyu+Avhmhy/smtmH6Zn+VciYoCaXgEFm/NwAa1EoDKy7+I6zgI
 NpDnIi0K5A5fvoxg5sTAfMjyL12AQF9v+oMlR9YtN7eJAmFeL7K1sLcna5MmUtirt/8P
 XSl4lfzCqWUKgFZ3YNCLmvRkMhQWNAsm/7IcRCR1MBUN6PrluAJGxsgc2oYiKh/Ss2kv
 4lu49DbQqGqseLzS7BUguBoU5+1CBlFBRVJM+zsAOAzfajPp3jNbMTwjmFQ3qfRi+fmk
 9sSTgJXc9GZAGko9Qf1SqlBSbiAP5tDsSRfLgo5h781QhwCn8CSJacfYKKH2dKSmuOSe
 OSOA==
X-Gm-Message-State: AOJu0YxqSqphqSrGOpWRfbb7GNKC7gY0nCnGhGjp0zNb734WHjHosClg
 NgeFpTm3TpyohqDKUn7xYMzVIfugNG1RsgLWybJrxBRzkS0ET62s2Bmf
X-Gm-Gg: ASbGncsiSCTz3fG7qmND5ag63f4ybxnwXP4BF9nDgQJgDms29BIP63gb6YAaLz2T+Yo
 SBJQWevpJa1NW/VZaUHocxsTeg8UFMUU+PlmpJFTImZKJ+rTQKZlSDIgYOQPWbD8u0sCYAoQKZS
 qWZFeWuqJmZsdurwXRKdhjRLDHd6mBkmEa8rqta0SdL7KZD54mr+JgF1Dg3PkblB8TyjHUIg486
 n2kOoazkLc9d2P9LhZgbrSzZc1B/eLk5gvM4f5GJoD0J3GFmhivL5IIWI7MUU2amq98W9KdvVZz
 yK5aCM9ex1lbnY45drv6W0+lvKD7LWz3NoPgFTqCNTq/0kyXKnREkemMD7xY5299HHBqA6OJwcg
 dc8DvlKRcPeriCnTy00Nijw2NVpTFmLlJ7VYY+Vii+iLPY0sxdUjDUnMedBqoTy3LAOIAfkMfZU
 7cLQzD51mB22w=
X-Google-Smtp-Source: AGHT+IEdXH+RQtEbMm4h/pED3SwxF5g0AvxIOLfTgjj1iFKdgZ7m7QeW+W8cNgECvSQcB3dnLJW9xQ==
X-Received: by 2002:a5d:5f94:0:b0:3d8:7c6e:8ad4 with SMTP id
 ffacd0b85a97d-3e765781242mr9784198f8f.10.1757874964607; 
 Sun, 14 Sep 2025 11:36:04 -0700 (PDT)
Received: from osama ([156.223.20.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b4222sm147095805e9.20.2025.09.14.11.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 11:36:03 -0700 (PDT)
Date: Sun, 14 Sep 2025 20:36:00 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Revert "sandbox: replace deprecated getenv() with
 env_get()"
Message-ID: <aMcLEA_nXv6Vj2yr@osama>
References: <20250912225820.4144317-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912225820.4144317-1-trini@konsulko.com>
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

On Fri, Sep 12, 2025 at 04:58:20PM -0600, Tom Rini wrote:
> While testing changes, I missed that Gitlab had failed CI with pytest
> failures due to this change.
> 
> This reverts commit 4c822970d366415e717730606734e815993a70bb.
> 
> Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/sandbox/cpu/os.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index adb6b5869469..f5c9a8aecf2e 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -35,7 +35,6 @@
>  #include <asm/state.h>
>  #include <os.h>
>  #include <rtc_def.h>
> -#include <env.h>
>  
>  /* Environment variable for time offset */
>  #define ENV_TIME_OFFSET "UBOOT_SB_TIME_OFFSET"
> @@ -284,7 +283,7 @@ int os_unmap(void *buf, int size)
>  
>  int os_persistent_file(char *buf, int maxsize, const char *fname)
>  {
> -	const char *dirname = env_get("U_BOOT_PERSISTENT_DATA_DIR");
> +	const char *dirname = getenv("U_BOOT_PERSISTENT_DATA_DIR");
>  	char *ptr;
>  	int len;
>  
> @@ -1015,7 +1014,7 @@ long os_get_time_offset(void)
>  {
>  	const char *offset;
>  
> -	offset = env_get(ENV_TIME_OFFSET);
> +	offset = getenv(ENV_TIME_OFFSET);
>  	if (offset)
>  		return strtol(offset, NULL, 0);
>  	return 0;
> @@ -1133,7 +1132,7 @@ static void *fuzzer_thread(void * ptr)
>  	const char *fuzz_test;
>  
>  	/* Find which test to run from an environment variable. */
> -	fuzz_test = env_get("UBOOT_SB_FUZZ_TEST");
> +	fuzz_test = getenv("UBOOT_SB_FUZZ_TEST");
>  	if (!fuzz_test)
>  		os_abort();
>  
> -- 
> 2.43.0
> 
Thanks Tom for testing, that's actually because U_BOOT_PERSISTENT_DATA_DIR
is intended to be set/get from host env not u-boot env, I removed them and
sent a new patch for ENV_TIME_OFFSET only.

Thanks,
Osama

