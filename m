Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A38C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367C1800B3;
	Tue, 11 Feb 2025 11:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QZHFyWH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02968043C; Tue, 11 Feb 2025 11:17:27 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD84080079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: c2cb176a-e861-11ef-9401-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id c2cb176a-e861-11ef-9401-005056994fde;
 Tue, 11 Feb 2025 11:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=7RzxtjFqJqVxUW1SMHeJWVGXjY/S+OSI58gdZSu5X2s=;
 b=QZHFyWH8mjmJYCy+FVcv0BO9iEcY7Jz5omJMLQB5qByRgSvhSpoeESKa72IuaHD4g98srssLTDs9o
 jVMm68Ad+68+5vc9ml1WAl8ejLgTWfFeZCxJLDQd0xdo+l5ZmropigeubVLdIwD0ZITecHEdv6DBjU
 oEztlmdGqeBKUbca1X0W0snY9CN5Jc6/TUixYk57owSzTB3Yv+hJDeOGMCuTv0YNYaCkqaKt5M6Tcr
 5fcx4TA0D4A6ghWdYRP/R3rVJ51GsPTDXCpjJ9Sb0IXISeT5sVZue7eOg9fM6GpDY0UHmOt+Ju825t
 fjcM0JTrsUyD+CSvLDfMT5Ywk8T0CkQ==
X-KPN-MID: 33|QzTE3KoIuWlc0hGlphcZJfn+R2fQKpT6+Gr3SuH+QmtuVTk9yrsx5KC4OrWKut8
 FU/ttqFuRTpVrU9lJY4HM3gIdqf67unstMVp1ScjROcI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fXiSdXxjJevunq2Rjsg/3r259T+n6IleUo2J8+A9XkbMLDMSMKIpI+zuWbM7zMQ
 /sffRqihZdRdLzbQGsd80DA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 62e26f50-e861-11ef-97ad-005056998788;
 Tue, 11 Feb 2025 11:17:24 +0100 (CET)
Date: Tue, 11 Feb 2025 11:17:24 +0100
Message-Id: <87tt90ss3v.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: heinrich.schuchardt@canonical.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <20250211094942.36162-1-ilias.apalodimas@linaro.org> (message
 from Ilias Apalodimas on Tue, 11 Feb 2025 11:49:39 +0200)
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
References: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
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
> 
> On EFI runtime services, we manage to preserve string literals
> by placing the .efi_runtime section just before .data and preserving
> it when fixing up the runtime memory by marking surrounding boottime
> code as runtime. This is ok for now but will break if we update any
> linker scripts and decouple .text and .runtime sections.
> 
> So let's define the strings we used to compare in the stack for
> runtime services

I don't see how this helps you.  Those string literals still need to
be copied into the stack variable from somewhere and I don't think
that with this changes where that source string literal lives...

I think you need toput the string in a global variable with an
appropriate __attribute__ that puts it into .runtime.

> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_var_mem.c      | 3 ++-
>  lib/efi_loader/efi_variable_tee.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index b265d95dd6ba..985e0baa128d 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>  {
>  	efi_uintn_t old_size;
>  	struct efi_var_entry *var;
> +	u16 vtf[] = u"VarToFile";
>  	u16 *pdata;
>  
>  	if (!variable_name || !vendor || !data_size)
> @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>  	if (timep)
>  		*timep = var->time;
>  
> -	if (!u16_strcmp(variable_name, u"VarToFile"))
> +	if (!u16_strcmp(variable_name, vtf))
>  		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>  
>  	old_size = *data_size;
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index 0d090d051dd4..8d173e58d2f7 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>  	efi_uintn_t payload_size;
>  	efi_uintn_t name_size;
>  	u8 *comm_buf = NULL;
> +	u16 pk[] = u"PK";
>  	bool ro;
>  
>  	if (!variable_name || variable_name[0] == 0 || !vendor) {
> @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>  	if (alt_ret != EFI_SUCCESS)
>  		goto out;
>  
> -	if (!u16_strcmp(variable_name, u"PK"))
> +	if (!u16_strcmp(variable_name, pk))
>  		alt_ret = efi_init_secure_state();
>  out:
>  	free(comm_buf);
> -- 
> 2.43.0
> 
> 
