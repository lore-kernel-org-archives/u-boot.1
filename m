Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD91C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 15:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CBB80C7E;
	Fri, 14 Feb 2025 16:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QyoLiE5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAD6801CF; Fri, 14 Feb 2025 16:21:17 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A6F801CF
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 16:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 543898bf-eae7-11ef-abec-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 543898bf-eae7-11ef-abec-005056992ed3;
 Fri, 14 Feb 2025 16:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=Q7Ad09XtWwn0YQuHTtVdDYIRLkgvHtcAigWRBIg4/nY=;
 b=QyoLiE5iQR/NJseTSTqmDqnIUcVwszIQb+8L5mWhmBwE7ErjqS5wq8rieorzxzEXoDujH08C8DeWK
 IPT+3vuNgOs9uPFjYm8f4XIia7vV2Fym3zn2FLScJmLPhGLqAKckHnqaJYQ7shLSWOsPbMIJ+JEWWZ
 W/59cCCVYV9geDbxmhBKVyN4TRMyx3C2Mp3nBHOoBniFLrm4hCGtgJ2NzXuTYeSH2Hw8U+rEyJFSMJ
 I8cuDNPLWAjxlv5FQBn4p/IbnNdYOaHhIXNiODVxaZy0JLLsWmYsghwZm+Vm2HIRosa4q3s+M7s0w+
 PCQh7MuBr8WByVj0h+aHLL33gpzlmCw==
X-KPN-MID: 33|/1rmOQHqM878iBOuFGr8y7VwVfpGwM4fvPlEkNMU17me56420pJkhNtwF65MpTP
 +KUeMwVWRUFV7Lqmk//+SPWzWrduGsQPqev/S6PoajTo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|T0+ryEkmAZ97SS1VsdjMsOWOW5dCs3iVRNp7E1RRA3e5SRZRylvKBSzN67GqT6W
 eJU63tXAe/pz8MN9o0zF2xA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 544ffe85-eae7-11ef-81c7-00505699d6e5;
 Fri, 14 Feb 2025 16:21:15 +0100 (CET)
Date: Fri, 14 Feb 2025 16:21:14 +0100
Message-Id: <87ldu8sgb9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <20250214134646.173034-1-ilias.apalodimas@linaro.org> (message
 from Ilias Apalodimas on Fri, 14 Feb 2025 15:46:45 +0200)
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
References: <20250214134646.173034-1-ilias.apalodimas@linaro.org>
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
> Date: Fri, 14 Feb 2025 15:46:45 +0200
> 
> For EFI runtime services, we manage to preserve string literals
> by placing the .efi_runtime section just before .data and preserving
> it when marking the runtime memory by marking surrounding boottime
> code as runtime. This is ok for now but will break if we update any
> linker scripts and decouple .text and .runtime sections.
> 
> So let's define the strings we used to compare in the appropriate
> section for runtime services
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_var_mem.c      | 3 ++-
>  lib/efi_loader/efi_variable_tee.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Yes, that looks much better.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index b265d95dd6ba..31180df9e3a0 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -19,6 +19,7 @@
>   */
>  static struct efi_var_file __efi_runtime_data *efi_var_buf;
>  static struct efi_var_entry __efi_runtime_data *efi_current_var;
> +static const u16 __efi_runtime_rodata vtf[] = u"VarToFile";
>  
>  /**
>   * efi_var_mem_compare() - compare GUID and name with a variable
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
> index 0d090d051dd4..6a1fa39bb6f3 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -41,6 +41,7 @@ static u16 mm_sp_id;
>  extern struct efi_var_file __efi_runtime_data *efi_var_buf;
>  static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
>  static efi_uintn_t max_payload_size;	/* func + data */
> +static const u16 __efi_runtime_rodata pk[] = u"PK";
>  
>  struct mm_connection {
>  	struct udevice *tee;
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
> 2.47.2
> 
> 
