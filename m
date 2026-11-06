Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66586606A339
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hc/51F9t;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tr3Yudt8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DC544095F;
	Fri,  6 Nov 2026 11:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIgrKMnRHHxy; Fri,  6 Nov 2026 11:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38D6240978
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793965831;
	b=lScSFG3bJLCqLRBCZVvon6rtrG90yRRenrECOaWt5kVgCO4CyTtvPTN+eO/aAA43MyZs
	 /RkrmTP0LXK0P3Vdv/jLV/einKKEb//DLCF4GdfiOiLPnvtxCUwFXmIYg4LbwIRcESVPM
	 gUDI7M8vyZAzkRPfjfu3xC8Py/UEWxq5+3UPceFtpCpnDIDITtBCoXvY5go42XrY6r1ar
	 7fQqnDxBaz6pKxgAY4QelPirzb93nnRvRv7JoyEOWd1r1TDwJdBIrKIF5xFBdgHiBSBgd
	 aZyqUiKTrCLQRWCoC7n140R3xpdWmQU6xk6oditNl48thmel2PURJ2mj06ZaLZ8BJWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793965831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9u+YNOXPA/6mLdCm8593UtIo6/4MUJtS/LAPZZX2Els=;
	b=QtmU4tWIqZNlNHA5b/LI/Yi8Z4HWWRGV8ZgwTEb8XxLgUckUY5P4u+B0fBcp2MHs9yIp
	 V0Y6Y8Lx61m10PZ12nrKRKt4MWSvqEa2kVFZf1lgMHUyg8cpxpUOWOE9Q3EOHsg1QyeQL
	 TcdOtqhVQpAtB5B85E4+3aGYa+vSgr55p/oQ5Gl85y/0gwssiDAiONZ0xWxwkwEbHky7m
	 D/KpnRphmZWHV8ayXSNYKBkj+1kLC4GLYPz5obRk/o7qHdanvACbEo2kYTCbG2t3hkKfo
	 5PWoAe86opQTL8Apt7gwGcvztYJtDNKk7b4gp/BE98QwgSDJjcRQxIKBTZOgskVFjJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793965831;
	bh=9u+YNOXPA/6mLdCm8593UtIo6/4MUJtS/LAPZZX2Els=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hc/51F9tRwFCVXZK7UJ9BsIoEHz7m/rW510hVcPenJ3J8aB77j/CRXm4iKixmyhHj
	 oFbP24NykTL+QwNziyMxfgXWwTBkPiAJ4F2S/nT+EGTjTJcFnwfaU/p3Tb0h6QnKqF
	 /eilyZFbUNfpSKhMrsTWyZLC5bpgIHoo0Ug/HuEJ3BWHM6i5xK9xQrYOSSm9gNJ0/E
	 /JGlttkrQsM88ENM78qgPraklB6R4ZZNdfmrHMnmK4cnkz16FQ+/0WUbATvG29csgS
	 lpOT65nQXRmXBv5fI/8kJxTsqoe5a/ZG9k8C0tbzKthZheMt5HFpWXf9xZLT6WY8nr
	 QGvpIoxRP5yXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38D6240978;
	Fri,  6 Nov 2026 11:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B452AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 143EA81214
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9ffUYST2qZN for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCC2B81209
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tr3Yudt8
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCC2B81209
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:50:27 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b312be5de8so4547827b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793965826; x=1794570626;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9u+YNOXPA/6mLdCm8593UtIo6/4MUJtS/LAPZZX2Els=;
 b=tr3Yudt8Pi0mkFZ1AcO3POoRXrrELLxEktfHDUe0kIf7KuSloLTn8qiv/RLYZM5gBS
 AYOKmfrct4YlOZzEzda2Uyvb1MkgI5GbqS5umNOwkBGVt9i79VCQ8p6f3feWPJ7vhA8E
 CZytAxa48Gz2XwR/jvjU9qrB5BoKBfwR0kAxgLQ2UvdVMb1Oi08byU+cKO5axSPe+XDw
 /OqIeBkaQj6CEidHas/HVTq6GKcw1GIpq3w1LpcsF9l8EAil60JtgsPy5zu9snNAGyea
 vlBQUF2k10QflnjIzqDi0DKBs5uM9Ysok42/xUyh5kx6Tiw89iStsQ2yDU30UBm6qfuP
 1Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793965826; x=1794570626;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9u+YNOXPA/6mLdCm8593UtIo6/4MUJtS/LAPZZX2Els=;
 b=Xf8P6hyDAtSeBRNzyWgQpikxHMyGW0DkiZpuLGbJLDr1J+ndkfn5ILJmcVg9DgHeuc
 qQCD8TDjKvF1lgGe8BZrtGReaD+cRRL+j8YbbnSoA9CmdotVvomK7M2L/fY+53jz7JUJ
 W0mkEZnjBvid52tm8R4KTxEB6Qd0bWwgW462HwXVOz1Dw7h9mnIKi7FVwoOV2hgYcoEL
 kralkDUOnG2o84ZD8rAgj8eNiYZnKxWhBZfrtZvNUJ5khNCfsaigXKM3vC3I7f+eN+2+
 VVioGiyUcUkV7glRM9sYrXrBiJwMaQZZ05/toy6WG+xMT2GnpIWPwwly1yNkHKZrqnuA
 BHgw==
X-Gm-Message-State: APuU4Z8TGhcayBZ89Y5wSIh5qh5Jh7euHL0b/4HK/n1brXfbL0/spKcZ
 CuZFd6xsGtT7Q5go7kr8vqNEMCOBgnPaAnuKpxUGYkPnEli2Pon5xewb7kgPOJJiquz5eG7pC54
 IwnQU/oEQvW3llI0DPZu1lsqNVlpY+WVQ5vx/W8WnNjAvXTqjXwfZhTs=
X-Gm-Gg: AYBFou3m12Z3yoNsh1fe3MgqBPl9l5urIALfo6ZQn5xSkUHPKtuYLf7ZEQ1cSKcumap
 +ymBI/GSGvyiCTo5VcfgRu6grPuh/nQV664pCAtQ4S3eIprrhv+rRwap3KY9XZKz/znOPN0dr4z
 1UDSFosbTTA/diN3glRDoEtsOvWVls5w/223V9nZSH1XcU41we+xroQh/TO+aoOharozmLY22ox
 1HAlugAQFQWpcUe0s1vjAmkhMQvpkE5RVkW9kCAwstwh6pKIrhiT9bnlHbdJxiTiJUAr4qYKaQD
 N34jnNmZ6PXEwX+tHWHkv3DWRaTB2MV6fSu5h1j0pRg3qWrpIfZbeMAN+9VrwjYjRzZaYt5qUsM
 Bq/3TEnoR8W95/+YGZjnW7zB5y4RWVYJ60YaRPMqxsnWUaW6nZHmzacb94o9hFBxYEIqKm6GpIz
 putMl2QhuWoxZCpf4HhEY2ZGSK1IsdrQzFOyA+VUAnEfwq3DID7c7bNuqpnnBSDMH+ZvqnCsY/a
 /rpPigJH+yM+byfQy2CO8YtY4DVZdrwip2wD6GP0haO49OSh6VXGzYBoyruQCtq8y/K9G+ZP2tC
 Y279CkQv4RYh3IPB0/Xp0cgzlOunEqbvzA2LzD2DdSCt7PnxdPoUEl6BdKYFTKPSSTaAi75p4TN
 t22yhqX2B7gVv8GL8Vo4aTDG2uvoLluhTDvTnCpxRXVn3jz9OIlxRpxJ9sYxp1txb9r22RCpgsl
 FTL3N2Xj4HTb4W37W0eRuu9oTh+B5zPQz258k=
X-Received: by 2002:a05:690c:940a:10b0:8b3:1324:a74c with SMTP id
 00721157ae682-8b341954fdamr8201247b3.53.1793965825897; Fri, 06 Nov 2026
 03:50:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
 <ef52b7da-2f83-4663-8633-9f97929fe9f4@gmail.com>
In-Reply-To: <ef52b7da-2f83-4663-8633-9f97929fe9f4@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 13:49:49 +0200
X-Gm-Features: AclHuK-oZ6Ay4Vjj3hMy7sjmBowpy118fimCrtWH0gtFk_Q1ichVNi3dPu20PmE
Message-ID: <CAC_iWj+zKC7O2U_okFwSanZYoafvsr+2_3MHsWvwu90bt9HQjQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] efi_loader: do not start an image that cannot be
 measured
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

Applying this seems to fail. Can you rebase and respin the series?

Thanks
/Ilias

On Tue, 3 Nov 2026 at 18:13, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> With TCG2 measured boot, efi_load_pe() measures each image into PCR 4
> or 2. When the measurement finds no TPM, it marks the image as not
> authenticated, so that it cannot be started. Any other error is ignored,
> so an image whose hash cannot be computed, because efi_image_parse()
> rejects it, or whose PCR could not be extended is loaded and can be
> started without being measured. With the range checks added to
> efi_image_parse() earlier in this series, more malformed images take
> this path. Such an image runs with boot services and can start the
> expected boot loader itself, which is measured as usual, so the PCRs
> end up as for a good boot.
>
> Handle every failed measurement like the missing TPM: mark the image as
> not authenticated, so that LoadImage() returns EFI_SECURITY_VIOLATION
> and StartImage() refuses to start it. A full event log is no error, as
> in EDK2's DxeTpm2MeasureBootLib: the PCR has been extended all the same.
>
> Fixes: 163a0d7e2cbd ("efi_loader: add PE/COFF image measurement")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
> This applies on top of Heinrich's "efi_loader: handling of missing
> TPM in efi_load_pe()": https://patchwork.ozlabs.org/patch/2335140/
>
>  lib/efi_loader/efi_image_loader.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index a0879f18621..ef6ff055c63 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1163,6 +1163,14 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                  */
>                 log_err("PE image measurement failed, no tpm device found\n");
>                 handle->auth_status = EFI_IMAGE_AUTH_FAILED;
> +       } else if (ret != EFI_SUCCESS && ret != EFI_VOLUME_FULL) {
> +               /*
> +                * The image cannot be hashed or the PCR cannot be extended.
> +                * Do not start an image that has not been measured. A full
> +                * event log is no error: the PCR has been extended all the same.
> +                */
> +               log_err("PE image measurement failed\n");
> +               handle->auth_status = EFI_IMAGE_AUTH_FAILED;
>         }
>  #endif
>
