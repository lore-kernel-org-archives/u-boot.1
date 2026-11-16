Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67E606A886
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mW9khKRX;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oH91LDnk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65D4D607B5;
	Mon, 16 Nov 2026 13:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BafNPxYBS84K; Mon, 16 Nov 2026 13:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F67E60777
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794836915;
	b=gQ9FilkobMn1GiR+WoI/+Wnlm3HkHIIgaXdUeY9LkywgfOrlijleZ6xgVLeEHEQqVWGi
	 FbMUI1lXFBAim4LgEAvo2GyLmyW0X8itY0h2kooazy8lHMkfJKvzfZCS/LodoPfmN6GM9
	 hAEWmiQ9beV43xjwq+hc7fbZvfdE4q2Hty9nJiR0BRGJEsTXMjiOwXLDTRfQC+WzkpcKg
	 +/LAX4NSf+wSEbEQYpIQ/onl8AT5dv46qOz9wzi01br4Ehj6miigpAV5MrpXsEa/sJ9rD
	 8E0Nb9UGKcDmeGIwo0Fd2iAwNcNuJK7DXQ3QHrICSTy/+bQIfsEXQ7WHzouhuH6CNWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794836915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NMU8I1jIEJtqJGLWBrBsdBz/+pS6aPulegFZG0ywl5g=;
	b=HMGwDRewEoTNaY2bs/PfutFW7jZrscd2SV7eA2fBJqh1zUdeDZqJ+JeMITJZdZ9MlBXX
	 /cLZLlqKm9IeyER5x00aTYecWFP0kRfq0CA940FPkUS67NOEtAHzMxeNP8H3Xp8JSNRlR
	 IAvFw3ASp1rnDaR/W+jsrsQWzUuDam0mWQcOfgkaVzYE9zDdGOyNU+edg1NULkCY5d1cq
	 3RM6sfbatP3niZiU5KE780PWmuj720YoOljZJySJcfRVMvXSUFV8UwDuYdjjPkpE9dSWF
	 sQQ2R14sLD0Bf9WjBjJ2VrVVVmIGVoZ15qdNYzXLn35WiVvSMUCKUUieIPdPk/HzV4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oH91LDnk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794836915;
	bh=NMU8I1jIEJtqJGLWBrBsdBz/+pS6aPulegFZG0ywl5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mW9khKRXuwMzhw48rD7a4YaZMXpsMaugwNg5oVDYUkRfQWaJmPOE6u64J8R42j41e
	 lKO4TwzRxd+5yAa5Bg0ErMXTgD2mIhCMC8Bun4a/Tn9fuMeWPkDu3jlXsIH2+IFpDp
	 eqCHXVf/dGQJ7XgHQuEiHCiK8TuUkPLn2Ja5GTnoYv/2DlRfoxpvHo3v4nA1pWuRoF
	 7VwELDVbCSuwnE9y2cAoq8THI/gKTd17uOXNP7K3clq2NORZoiubCmPQEbFwj4HwhV
	 aQJ9Vl3lWwNM6MxAXr9/m9uifZktIwJija7YQrVHTNJVOXSmWjXotSCXmZCOhrbPu1
	 V3OGQ6SYD5EVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F67E60777;
	Mon, 16 Nov 2026 13:48:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C60C4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29E5060777
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:48:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0VRcQmnf9ZaT for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:48:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9115A60768
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oH91LDnk
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9115A60768
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:48:31 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3ab3b29a298so35840481fa.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794836909; x=1795441709;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NMU8I1jIEJtqJGLWBrBsdBz/+pS6aPulegFZG0ywl5g=;
 b=oH91LDnkK877nswkp3kE1Xqa6urVXzyyar3lmx/mnljVkCccNyofsEEUj0GhYqnzeh
 9BGAl6BjUk+DZBhJz6356bjek4d2nR/x++SPv4idN5oI/vkMD3PwiM69J5Y1MgvXKZ7d
 cAwmsA+Sfgn2P4Xm5vq6UNr8JP9o5OJfPeh+Rh2HvKvGb0/Fp3OdZRMYHng6WMZ0k46C
 LFekg90kQfU80bb6yj0JfFkKGoKf3n1Ah3gbmqhapYnPFmNYN9JNr9+zS+ZJBjN/5FSE
 GpVhrlxEmgkqxzNSsGvnnLbxR16d7rqy7/5EuJH7mMca5Ag+mnEt0B7RGd/FjgB14moF
 pOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794836909; x=1795441709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NMU8I1jIEJtqJGLWBrBsdBz/+pS6aPulegFZG0ywl5g=;
 b=pZ+7DfxYrUjwN+UU9VEZso7axzlltJfR7A6FR7O48bWn0Ls5/kpRDvPxgBNi3S6+4P
 k2vnIEsU4z9IvZpXx6o6pyoKhW1NLXXioER2k+CPqiC8btS/3k7W4/fr3LCDBFgMw7eE
 VFp6OCfZSec3aFgSKVelmxJKnm9zeMOw/CwzqElw/y3+mNBe5i5nuK3itvWXudnEBb1X
 IEOGkj9fDDxx5YmkiTfN92anMQ9yb8rOzTAEs7MfXLxKsP3ZyMJsGkO1zCxkjuc56Ru/
 7IrPY1dQDShzEZP30J/mfbNzalmBsCQRHqIUX8ctvnCgfCBgQbCkbjS8khFdboRyF/UQ
 0ghw==
X-Forwarded-Encrypted: i=1;
 AL+hErFVOprm1DEC2PhQpvpVcxGQLkbf4Z14QQ2gVr2/tdgCpy3rtMqGevZ8R0ihKtXajcbwp8hmez4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8fThVTxZAaxL0Rk0kpDcekQ2XHvdnFr1tLhv6FQ7CeIrDGcn9f
 P86pKtj0S0dwWPfMGwj4UzoavU9W3fP8rlWmfkxiT7MeFc6RsIECjvpWTdSfZFjDHVH965QQBCF
 NBOA9VjNR7IM5w+pEb8ypnxYoNV/w9+buClve6paWKQ==
X-Gm-Gg: AYBFou0mSEX75PKHdHob7duTVvdEiHcn4Q1i0QR5mvO+Z4apZTc7jaSbdBPSbXERBr5
 Q3v86toiNFrgvAkC5ADGtYZ9AHTP+mTQ1VDjYOUL3yuOnsfVIdxwAsbD6U2NKGfu9Kl6df9tij+
 TSNMIwkm3bJqGQFInXpeBhIR/Jh8xIwUeD/LYB9FhBet6qd3eRwf0YzUKkbV99pYty2K53s9M7g
 8AVres14d6amA4OzYB4zbh8LSpUN/Cg5k/BwU5JKj6WaWRp7tHM2xzlXgAF8f5CdffBQebch2tg
 26nNpZN1GdawdYBUMHTFg7W/XG6DNt7Hp1iorm0i2Y5VLeY6ic9XpLxXh+eAFH3fJzByaWicpoO
 lM4mj1WpcEAMSKtgg+iDMUaaNgyVGrfCKoKiLUBipIG0sIsEi2PyOI3c3tr+sMmljr8IhdjGBT1
 cX/jkpH+pPYKTyMjodfZCLm4pcFSN7q8AHcq5gTyqUGZEJPnA0+2riLJ1tc+rBFP+pJ48DvtqD1
 KHaGfzQyjtBxLo53L+CNWSQqgeKfiCz63nA5sliNdGMC+Urc3lemvgJ0YIgiIp0HUNEdwOvA78F
 NLBCVLcBT/RjohDxnr7/gawn48DonFCuNGQzsXnETiQIiV3uRca3e5PjdR9kjtyrXBdcw39dMF8
 c0ZV/eysQhtVwU/BBChJSkppEd0AEEYIcZg8Wlz0Z3qr6NCr0YLNQBFiyzwnSGdI/VQDxth9bva
 pPl5DH58epSCtx4AWqLyfAR8PaVI5w4hTAcj8zZE5KEdJ0kJd8rz4b/EZx5YoKts0Fqc7U
X-Received: by 2002:a05:651c:b0e:b0:3ac:f037:9dff with SMTP id
 38308e7fff4ca-3ae2b6b1f68mr30962281fa.26.1794836908703; Mon, 16 Nov 2026
 05:48:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAOTQ16Jz3KphYO54zYA6YG-b7s8AbrKXLHmZ86WuRv4DhqRvSA@mail.gmail.com>
In-Reply-To: <CAOTQ16Jz3KphYO54zYA6YG-b7s8AbrKXLHmZ86WuRv4DhqRvSA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Nov 2026 15:47:50 +0200
X-Gm-Features: AclHuK_0YTJG7Jre5zB0tMVNUNGT40anM0yWPLpjwXiV3KeUxgwJvneH0I-2Xig
Message-ID: <CAC_iWjKJ69tUxebXH0Vmz4fRHPLu0FqqREWV2aAOWYmFcBc4MQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: prevent PE header and section RVA overflows
To: George Kola <georgekola@google.com>
Cc: Alexander Graf <agraf@csgraf.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi George

This does bot apply and seems like a malformed patch. Can you resend it ?

Thanks
/Ilias

On Sun, 15 Nov 2026 at 19:12, George Kola <georgekola@google.com> wrote:
>
> In efi_load_pe(), sec->VirtualAddress + section_size(sec) is evaluated
> in 32-bit unsigned arithmetic before promotion to unsigned long,
> allowing a crafted PE-COFF section to wrap virt_size and write out of
> bounds. In addition, e_lfanew, SizeOfOptionalHeader, section alignment,
> AddressOfEntryPoint, and DataDirectory bounds are not validated before
> dereferencing headers or copying raw section data.
>
> Validate e_lfanew bounds and alignment in efi_check_pe(), and verify
> SizeOfOptionalHeader, section table alignment, and section count
> against efi_size before pointer arithmetic in efi_load_pe(). Compute
> section end offsets in 64-bit arithmetic, reject 32-bit RVA or unsigned
> long overflows, validate raw section offsets, skip zero-length raw
> section memcpy() calls, and verify optional header DataDirectory and
> entry point bounds before copying validated headers_size.
>
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
>  lib/efi_loader/efi_image_loader.c | 123 +++++++++++++++++++++++++-----
>  1 file changed, 103 insertions(+), 20 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c
> b/lib/efi_loader/efi_image_loader.c
> index f9a2d2df40..11798c6c71 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -849,7 +849,10 @@ efi_status_t efi_check_pe(void *buffer, size_t
> size, void **nt_header)
>          * least one section header follows we only need to check for the length
>          * of the 64bit header which is longer than the 32bit header.
>          */
> -       if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
> +       if (size < sizeof(IMAGE_NT_HEADERS32) ||
> +           dos->e_lfanew < sizeof(*dos) ||
> +           !IS_ALIGNED(dos->e_lfanew, sizeof(u32)) ||
> +           dos->e_lfanew > size - sizeof(IMAGE_NT_HEADERS32))
>                 return EFI_INVALID_PARAMETER;
>         nt = (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
>
> @@ -897,7 +900,7 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>                          struct efi_loaded_image *loaded_image_info)
>  {
>         IMAGE_NT_HEADERS32 *nt;
> -       IMAGE_DOS_HEADER *dos;
> +       IMAGE_DOS_HEADER *dos = efi;
>         IMAGE_SECTION_HEADER *sections;
>         int num_sections;
>         void *efi_reloc;
> @@ -906,6 +909,9 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>         unsigned long rel_size;
>         int rel_idx = IMAGE_DIRECTORY_ENTRY_BASERELOC;
>         uint64_t image_base;
> +       size_t opt_size;
> +       size_t headers_size;
> +       size_t sec_offset;
>         unsigned long virt_size = 0;
>         int supported = 0;
>         efi_status_t ret;
> @@ -929,14 +935,20 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>         }
>
>         num_sections = nt->FileHeader.NumberOfSections;
> -       sections = (void *)&nt->OptionalHeader +
> -                           nt->FileHeader.SizeOfOptionalHeader;
> -
> -       if (efi_size < ((void *)sections + sizeof(sections[0]) * num_sections
> -                       - efi)) {
> +       opt_size = nt->FileHeader.SizeOfOptionalHeader;
> +       sec_offset = (size_t)((u8 *)&nt->OptionalHeader - (u8 *)efi);
> +       if (opt_size > efi_size - sec_offset) {
> +               log_err("Optional header exceeds image size\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       sec_offset += opt_size;
> +       if (!IS_ALIGNED(sec_offset, sizeof(u32)) ||
> +           (size_t)num_sections > (efi_size - sec_offset) / sizeof(sections[0])) {
>                 log_err("Invalid number of sections: %d\n", num_sections);
>                 return EFI_LOAD_ERROR;
>         }
> +       sections = (void *)((u8 *)efi + sec_offset);
> +       headers_size = sec_offset + (size_t)num_sections * sizeof(sections[0]);
>
>         /* Authenticate an image */
>         if (efi_image_authenticate(efi, efi_size)) {
> @@ -946,18 +958,39 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>                 log_err("Image not authenticated\n");
>         }
>
> +       virt_size = headers_size;
> +
>         /* Calculate upper virtual address boundary */
>         for (i = num_sections - 1; i >= 0; i--) {
>                 IMAGE_SECTION_HEADER *sec = &sections[i];
> +               u32 copy_size = min(section_size(sec), sec->SizeOfRawData);
> +               u64 sec_end = (u64)sec->VirtualAddress + section_size(sec);
>
> +               if (sec_end > U32_MAX || sec_end > ULONG_MAX) {
> +                       log_err("Section %d virtual address overflow\n", i);
> +                       return EFI_LOAD_ERROR;
> +               }
> +               if (copy_size &&
> +                   ((u64)sec->PointerToRawData + copy_size > efi_size)) {
> +                       log_err("Section %d exceeds image size\n", i);
> +                       return EFI_LOAD_ERROR;
> +               }
>                 virt_size = max_t(unsigned long, virt_size,
> -                                 sec->VirtualAddress + section_size(sec));
> +                                 (unsigned long)sec_end);
>         }
>
>         /* Read 32/64bit specific header bits */
>         if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
>                 IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
>                 IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
> +
> +               if (!IS_ALIGNED(dos->e_lfanew, sizeof(u64)) ||
> +                   opt_size < offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory) ||
> +                   opt->AddressOfEntryPoint >= virt_size) {
> +                       log_err("Invalid 64-bit optional header\n");
> +                       ret = EFI_LOAD_ERROR;
> +                       goto err;
> +               }
>                 image_base = opt->ImageBase;
>                 efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
>                 handle->image_type = opt->Subsystem;
> @@ -970,10 +1003,40 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>                         goto err;
>                 }
>                 handle->entry = efi_reloc + opt->AddressOfEntryPoint;
> -               rel_size = opt->DataDirectory[rel_idx].Size;
> -               rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
> +               if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
> +                       if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER64,
> +                                               DataDirectory[rel_idx + 1])) {
> +                               efi_free_pages((uintptr_t)efi_reloc,
> +                                              (virt_size + EFI_PAGE_MASK) >>
> +                                              EFI_PAGE_SHIFT);
> +                               ret = EFI_LOAD_ERROR;
> +                               goto err;
> +                       }
> +                       rel_size = opt->DataDirectory[rel_idx].Size;
> +                       if (rel_size &&
> +                           ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
> +                            rel_size > virt_size)) {
> +                               efi_free_pages((uintptr_t)efi_reloc,
> +                                              (virt_size + EFI_PAGE_MASK) >>
> +                                              EFI_PAGE_SHIFT);
> +                               ret = EFI_LOAD_ERROR;
> +                               goto err;
> +                       }
> +                       rel = efi_reloc +
> +                             opt->DataDirectory[rel_idx].VirtualAddress;
> +               } else {
> +                       rel_size = 0;
> +                       rel = NULL;
> +               }
>         } else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
>                 IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
> +
> +               if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory) ||
> +                   opt->AddressOfEntryPoint >= virt_size) {
> +                       log_err("Invalid 32-bit optional header\n");
> +                       ret = EFI_LOAD_ERROR;
> +                       goto err;
> +               }
>                 image_base = opt->ImageBase;
>                 efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
>                 handle->image_type = opt->Subsystem;
> @@ -986,8 +1049,31 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>                         goto err;
>                 }
>                 handle->entry = efi_reloc + opt->AddressOfEntryPoint;
> -               rel_size = opt->DataDirectory[rel_idx].Size;
> -               rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
> +               if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
> +                       if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32,
> +                                               DataDirectory[rel_idx + 1])) {
> +                               efi_free_pages((uintptr_t)efi_reloc,
> +                                              (virt_size + EFI_PAGE_MASK) >>
> +                                              EFI_PAGE_SHIFT);
> +                               ret = EFI_LOAD_ERROR;
> +                               goto err;
> +                       }
> +                       rel_size = opt->DataDirectory[rel_idx].Size;
> +                       if (rel_size &&
> +                           ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
> +                            rel_size > virt_size)) {
> +                               efi_free_pages((uintptr_t)efi_reloc,
> +                                              (virt_size + EFI_PAGE_MASK) >>
> +                                              EFI_PAGE_SHIFT);
> +                               ret = EFI_LOAD_ERROR;
> +                               goto err;
> +                       }
> +                       rel = efi_reloc +
> +                             opt->DataDirectory[rel_idx].VirtualAddress;
> +               } else {
> +                       rel_size = 0;
> +                       rel = NULL;
> +               }
>         } else {
>                 log_err("Invalid optional header magic %x\n",
>                         nt->OptionalHeader.Magic);
> @@ -1010,11 +1096,7 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>  #endif
>
>         /* Copy PE headers */
> -       memcpy(efi_reloc, efi,
> -              sizeof(*dos)
> -                + sizeof(*nt)
> -                + nt->FileHeader.SizeOfOptionalHeader
> -                + num_sections * sizeof(IMAGE_SECTION_HEADER));
> +       memcpy(efi_reloc, efi, headers_size);
>
>         /* Load sections into RAM */
>         for (i = num_sections - 1; i >= 0; i--) {
> @@ -1026,9 +1108,10 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>                         memset(efi_reloc + sec->VirtualAddress, 0,
>                                sec->Misc.VirtualSize);
>                 }
> -               memcpy(efi_reloc + sec->VirtualAddress,
> -                      efi + sec->PointerToRawData,
> -                      copy_size);
> +               if (copy_size)
> +                       memcpy(efi_reloc + sec->VirtualAddress,
> +                              efi + sec->PointerToRawData,
> +                              copy_size);
>         }
>
>         /* Run through relocations */
> --
> 2.56.0.611.g1030f0b940-goog
