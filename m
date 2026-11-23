Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D00606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Khr6i6/b;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ETpReyqP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED28280D2B;
	Mon, 23 Nov 2026 08:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2AfpKUtuwyg8; Mon, 23 Nov 2026 08:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15B9680D7F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795422092;
	b=Mguc7eqTEilpz+EmcxhHtwML7KsOqVlBOgo5Cqar2QssnNEtPla7h08sRxJUcmO2aWth
	 iYSG2/r9bNyjo9EYTrpxhr1vcnDYSp+ZKEC7ECmKxAEtTnmIFWD5fv3+j67j+o9oQjsB3
	 PAUG/cthC9K3OdPN3re2+VOfgP2zoXJ2HWf1y8OSFizUWRjKIIsqOQcZ/eGFVrOmTqon/
	 4Joh/APrOFYoy+eVskX6KDeEvjmgxE7KZYo32kqevV9so/ozv8upgdNJfQJSTM0UbYKsW
	 HZBGxzNa/4zp4IexswVr8PN4f+trpz8IJ4IS7LCH9OxqDEPatrO1rrRVWyGcKADCjQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795422092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8q/Xg6yJidRvDa+6TDjNCFkZ6XhcXMd0nxqntF7+3W8=;
	b=Ki+cWge07njMfiVRyR8fUjXi0c6T34CfBub/jljTA6TkpvBzBLyBIZGOhKKN3apsAgJ3
	 khlRXvDqihvoLJL4ocX1I1awsYn/2mBEOVGHGBkIJpek76y9reMtkiO1N/zVXV2Ci9RuC
	 BpnZLs9etOlZnJVZAsGVnlb9zhN2c8cOJUJZYmjxlN7FYXCLuzjbvda6MlYhSCkYyxP64
	 UCGqGMsqlBCfYrjDBBJCdkOnlMv91zaTYRbMfv6exG9VQzHgOBMwUlIdck0M0jB/mznWx
	 e0fjkh8NH7tioQ9ZSoMaq4C9cFaJjz85dXxuR9qhbM9fhdsriqeD+KDt6AsuctroKWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795422092;
	bh=8q/Xg6yJidRvDa+6TDjNCFkZ6XhcXMd0nxqntF7+3W8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Khr6i6/bd4IR902uCyuGl2WFZ1lofEceYuk4tNFD5yzjRlNLP4ZPXhAxbCepVFWuj
	 RTGe2dBCBhOSNY0pZ81YXfBF40GlTV/FnoiA00JIhF/4hfO7ULNhgp3GQqLL00lgy8
	 3YS2eUdje/d4X2DUI5E1BIBVy7EO/pbsyOQlnNCOQ4w2dTZuxNWHQvfyHLHFh0jVeh
	 AKXGzsGfBoRL96H5kU5WDD4gKviZaZgwFHsLzc1Nx5c+O0QI/BGjRMZIDsJbRY457u
	 YLXarboPm87ND3ZLkKRijCc6ZVQGOh4W2mxZeN+erTWiNZ+eLBuZaLMF/Ae3saAHHa
	 b/PnQY64tUeKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15B9680D7F;
	Mon, 23 Nov 2026 08:21:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4FBD22B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B662840063
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCf_cYz5CD1N for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5B70D4005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ETpReyqP
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B70D4005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:21:28 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67db0791748so3145555d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795422088; x=1796026888;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8q/Xg6yJidRvDa+6TDjNCFkZ6XhcXMd0nxqntF7+3W8=;
 b=ETpReyqPBWD721Qk9Py59n6WHVbVFETu1UmT+sGA3SDEHM3NZUP9W4vWt6Hf3KeDCE
 axtGP92e1wwO4z72VZ/iPB41pVPqjMcRRV+kT7SuxZnEnRtkbngRGM8mpGjw84VLGWEo
 33p5COmkxuMEtA3K9QQmDNHQVPT9OLmxDtsrScu0XVMkdv+6FeJWFtn4OoHMZC5bawIN
 0je8wCGyl2mmGW1Pn+W/JkirFa0jkDJ49VtBP3+15VNsnS8huoTCNb4UnMBqTElpFb+G
 xZOaJnCEHdesMXXBtfxwJVzBcKuyFnFYWAsDZDWUpUEJKbhaNF1mBv4ubWVr8pfzT7fL
 mcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422088; x=1796026888;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8q/Xg6yJidRvDa+6TDjNCFkZ6XhcXMd0nxqntF7+3W8=;
 b=JbhErLcK9wFgQHAN2l3LN+IPiuH8L4N1CXi9XzrqQeKBzr8NUH+i5bla7PRsPwGjBF
 1AooH+VZ86SO92VM4ZSxpdsVOjSVxV74Sq4NJ3zqSzz0zUxA5mLKyy4NS4b7Rf9bXJi6
 J26C96+mBhFQc+VI1zBXwf5KhuLcerJo4BjDZ1bGORazFPbixiz8kOvUaqhYqfM6moMo
 g43H9FxJB5H26iMSPepvJrmgCcGTSqDO69f0/88UqoVsSNxRf/srTTUDbu9I1d1pv1rE
 k9qc4hSlDKIILDD/zd+984mMbL84wbsR/C7fxUw5UQmfHLfEJh3u2ES7oh8QcqfHSqk7
 TH2A==
X-Forwarded-Encrypted: i=1;
 AL+hErH8xRpmb1ZiDi41Epl2LfwhEdOIgIkxklVg7gkqAKBP23rjOElvTPRb6dfb5dDgclVP7Cnz2Ac=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+CJC+SWFeHiU54CxOGTEa0HRjVT4B1JyMGDBBl9dGCZABAXdpb
 OVXH6uhw7PuV6leonSuGZ2FpWUZovbnY0w0esREydwoy0jL2OfZfJeMje8UayOmPFnoJkGniy2Z
 nqCEvBeszIpOFSBLY+WtItGK2ncWpfe/zoDGQqgYryw==
X-Gm-Gg: AZFdTZcZL7ku1mizVE5JQk9+owXaVdF1nhtS8OxfZJdkWgnh9t/yxVk/UaNeQY/ZDwX
 msIWEguGL910/pK3h+FCkyDtVNdTWpDtKIJOEXvK9snd4LjkmOYmKk7+oXmLQTn7naTenhWvy3y
 U0FBMoARKw+dM4IcA7njd60O4PMqIVcZcYTou8tVjRzM+Xmu6OnIBPRrK4BkeY7w22QwTxD9bcd
 lHwi6ODtlgHYI5q6Z6Z0e97cyrEj5QmgLuB41OXbo7cdws113URGz2o+mZzcCDzaChFXPQ4vG0T
 rl401vIuNoq4zQ2BVFwCKhZnlpDBJnuwrbH7m0WEIsZXN2WbB5+zdPnLN9XTOmDkfm1YxsBrjJb
 lapT36HYvx9k8ABAlplTH4Bpw8XsgjIlaLUTQFFLmQLE482Nr9Ofd+XvLUZnWFu9PrOFeR1g/R1
 OXDCNxOYDMTPNY10akInNxmo9+dkKRMyaupg+3zcjRKnK+OlcBPlh0jcS0rxHY5C2lxzSb94TEY
 4KPdSmTZrjIM721O06FQH4FAcZsIbyydXN4RhchHHm5BPFe+fo2HqZLu9Z3i8pmoRU2w+Q7hJK6
 w8tSV5qATX8zzcbmM+14VpcDKyVxKZDMqWD6TlcSWOGIfyYuU3YMwxDFqyDN4D0y25UJUmL1sNu
 fKokzKDr+v5vxbPqoNxnG+eBugFpXFYXA3YHHUspyYoTIavnnvILNqWbeGP+R7BTbR4MDT+VQru
 W2PnX1DOksPUSQwMS5J2Dq1QkmHSsXgx3hYJTlHby2ynW+CTlJH495Oz7xttMBBdcVXGOijH4=
X-Received: by 2002:a05:690e:400b:b0:67d:e499:b287 with SMTP id
 956f58d0204a3-67df43ce1e3mr5059395d50.22.1795422087452; Mon, 23 Nov 2026
 00:21:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122134147.237839-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261122134147.237839-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Nov 2026 10:20:51 +0200
X-Gm-Features: Aa3M54pT7mmSK1TfFwjVtevJqN79v-EOjNI-q8GKFCdK3nOazZMufxnZ2AyTC00
Message-ID: <CAC_iWjJ_RC6dmAWMY0wqUB=gFE8f0soxQ8DGUx71SEHT-S1cVw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: use EFI_PRINT() in efi_image_loader.c
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 at 15:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The functions in efi_image_loader.c run inside the UEFI boot service
> LoadImage() and in other API calls like SetVariable() and
> UpdateCapsule(). Writing errors with log_err() there can mess up the
> console output of the running UEFI application.
>
> Use EFI_PRINT() instead. It writes an indented message with the EFI
> prefix and is only active if DEBUG is defined.
>
> Do not print __func__ in the messages. Depending on CONFIG_LOGF_FUNC the
> log system already adds the function name.
>
> The messages are no longer shown in a default build. The status codes
> returned by the services already tell the caller what went wrong.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_image_loader.c | 54 +++++++++++++++----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index a03866c2907..cb5af68e49f 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -220,14 +220,14 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                         case IMAGE_REL_BASED_RISCV_LOW12S:
>                                 /* We know that we're 4k aligned */
>                                 if (delta & 0xfff) {
> -                                       log_err("Unsupported reloc offset\n");
> +                                       EFI_PRINT("Unsupported reloc offset\n");
>                                         return EFI_LOAD_ERROR;
>                                 }
>                                 break;
>  #endif
>                         default:
> -                               log_err("Unknown Relocation off %lx type %x\n",
> -                                       offset, type);
> +                               EFI_PRINT("Unknown Relocation off %lx type %x\n",
> +                                         offset, type);
>                                 return EFI_LOAD_ERROR;
>                         }
>                         relocs++;
> @@ -264,7 +264,7 @@ static void efi_set_code_and_data_type(
>                 loaded_image_info->image_data_type = EFI_RUNTIME_SERVICES_DATA;
>                 break;
>         default:
> -               log_err("invalid image type: %u\n", image_type);
> +               EFI_PRINT("invalid image type: %u\n", image_type);
>                 /* Let's assume it is an application */
>                 loaded_image_info->image_code_type = EFI_LOADER_CODE;
>                 loaded_image_info->image_data_type = EFI_LOADER_DATA;
> @@ -297,7 +297,7 @@ efi_status_t efi_image_region_add(struct efi_image_regions *regs,
>         int i, j;
>
>         if (regs->num >= regs->max) {
> -               log_err("%s: no more room for regions\n", __func__);
> +               EFI_PRINT("no more room for regions\n");
>                 return EFI_OUT_OF_RESOURCES;
>         }
>
> @@ -322,7 +322,7 @@ efi_status_t efi_image_region_add(struct efi_image_regions *regs,
>                 }
>
>                 /* new data overlapping registered region */
> -               log_err("%s: new region already part of another\n", __func__);
> +               EFI_PRINT("new region already part of another\n");
>                 return EFI_INVALID_PARAMETER;
>         }
>
> @@ -493,8 +493,8 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>                 bytes_hashed = opt->SizeOfHeaders;
>                 align = opt->FileAlignment;
>         } else {
> -               log_err("%s: Invalid optional header magic %x\n", __func__,
> -                       nt->OptionalHeader.Magic);
> +               EFI_PRINT("Invalid optional header magic %x\n",
> +                         nt->OptionalHeader.Magic);
>                 goto err;
>         }
>
> @@ -504,7 +504,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>                             nt->FileHeader.SizeOfOptionalHeader);
>         sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
>         if (!sorted) {
> -               log_err("%s: Out of memory\n", __func__);
> +               EFI_PRINT("Out of memory\n");
>                 goto err;
>         }
>
> @@ -546,13 +546,13 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>         /* Return Certificates Table */
>         if (authsz) {
>                 if (len < authoff + authsz) {
> -                       log_err("%s: Size for auth too large: %u >= %zu\n",
> -                               __func__, authsz, len - authoff);
> +                       EFI_PRINT("Size for auth too large: %u >= %zu\n",
> +                                 authsz, len - authoff);
>                         goto err;
>                 }
>                 if (authsz < sizeof(*auth)) {
> -                       log_err("%s: Size for auth too small: %u < %zu\n",
> -                               __func__, authsz, sizeof(*auth));
> +                       EFI_PRINT("Size for auth too small: %u < %zu\n",
> +                                 authsz, sizeof(*auth));
>                         goto err;
>                 }
>                 *auth = efi + authoff;
> @@ -665,7 +665,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
>
>         if (!efi_image_parse(new_efi, new_efi_size, &regs, &wincerts,
>                              &wincerts_len)) {
> -               log_err("Parsing PE executable image failed\n");
> +               EFI_PRINT("Parsing PE executable image failed\n");
>                 goto out;
>         }
>
> @@ -674,13 +674,13 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
>          */
>         db = efi_sigstore_parse_sigdb(u"db");
>         if (!db) {
> -               log_err("Getting signature database(db) failed\n");
> +               EFI_PRINT("Getting signature database(db) failed\n");
>                 goto out;
>         }
>
>         dbx = efi_sigstore_parse_sigdb(u"dbx");
>         if (!dbx) {
> -               log_err("Getting signature database(dbx) failed\n");
> +               EFI_PRINT("Getting signature database(dbx) failed\n");
>                 goto out;
>         }
>
> @@ -744,7 +744,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
>
>                 msg = pkcs7_parse_message(auth, auth_size);
>                 if (IS_ERR(msg)) {
> -                       log_err("Parsing image's signature failed\n");
> +                       EFI_PRINT("Parsing image's signature failed\n");
>                         msg = NULL;
>                         continue;
>                 }
> @@ -912,7 +912,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>
>         ret = efi_check_pe(efi, efi_size, (void **)&nt);
>         if (ret != EFI_SUCCESS) {
> -               log_err("Not a PE-COFF file\n");
> +               EFI_PRINT("Not a PE-COFF file\n");
>                 return EFI_LOAD_ERROR;
>         }
>
> @@ -923,8 +923,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                 }
>
>         if (!supported) {
> -               log_err("Machine type 0x%04x is not supported\n",
> -                       nt->FileHeader.Machine);
> +               EFI_PRINT("Machine type 0x%04x is not supported\n",
> +                         nt->FileHeader.Machine);
>                 return EFI_LOAD_ERROR;
>         }
>
> @@ -934,7 +934,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>
>         if (efi_size < ((void *)sections + sizeof(sections[0]) * num_sections
>                         - efi)) {
> -               log_err("Invalid number of sections: %d\n", num_sections);
> +               EFI_PRINT("Invalid number of sections: %d\n", num_sections);
>                 return EFI_LOAD_ERROR;
>         }
>
> @@ -943,7 +943,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                 handle->auth_status = EFI_IMAGE_AUTH_PASSED;
>         } else {
>                 handle->auth_status = EFI_IMAGE_AUTH_FAILED;
> -               log_err("Image not authenticated\n");
> +               EFI_PRINT("Image not authenticated\n");
>         }
>
>         /* Calculate upper virtual address boundary */
> @@ -965,7 +965,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                                                     loaded_image_info->image_code_type,
>                                                     opt->SectionAlignment);
>                 if (!efi_reloc) {
> -                       log_err("Out of memory\n");
> +                       EFI_PRINT("Out of memory\n");
>                         ret = EFI_OUT_OF_RESOURCES;
>                         goto err;
>                 }
> @@ -981,7 +981,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                                                     loaded_image_info->image_code_type,
>                                                     opt->SectionAlignment);
>                 if (!efi_reloc) {
> -                       log_err("Out of memory\n");
> +                       EFI_PRINT("Out of memory\n");
>                         ret = EFI_OUT_OF_RESOURCES;
>                         goto err;
>                 }
> @@ -989,8 +989,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                 rel_size = opt->DataDirectory[rel_idx].Size;
>                 rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
>         } else {
> -               log_err("Invalid optional header magic %x\n",
> -                       nt->OptionalHeader.Magic);
> +               EFI_PRINT("Invalid optional header magic %x\n",
> +                         nt->OptionalHeader.Magic);
>                 ret = EFI_LOAD_ERROR;
>                 goto err;
>         }
> @@ -1003,7 +1003,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                  * TCG2 Protocol is installed but no TPM device found,
>                  * this is not expected.
>                  */
> -               log_err("PE image measurement failed, no tpm device found\n");
> +               EFI_PRINT("PE image measurement failed, no tpm device found\n");
>                 handle->auth_status = EFI_IMAGE_AUTH_FAILED;
>         }
>  #endif
> --
> 2.53.0
>
