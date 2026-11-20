Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FF606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m+edYJMc;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kxVIcc9h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6914B81375;
	Fri, 20 Nov 2026 12:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmrcsm7oqW2F; Fri, 20 Nov 2026 12:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8DD481397
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795178964;
	b=mYM0Uuis0SAkIqnnFJBxb7wCXHDVjdMiut8IPpMdVZgFrKHhMcd78Sq964/2UPAvmMmb
	 9rSCvqHarsQ/0arfs/NUQpwTqRUvYSUoQidkySKU6W9/TxpbiSBIZgxGWamzlnLq2jj3O
	 Yw8TFAmrAGPplmSnUJHFLYODAdoeGWG4JCUdWcao4+NBVkGEoRzzXebkmvBihGumF6dFR
	 CVohJ5VyQBHj/NXF8y80ChWLW0/jJl/bWwGj8sI7cFLdEIrlC84CY5ewLT/Eh+mwJsG8E
	 c9TFOdLPE+GFVQtQwnvJbBt3+r79MrdAAc3WmRXxCzLWPCB1ZwKNtF2vU0nGZi0LAbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795178964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jYE4JvNMVq/bTd8S43Y/Id2EJZwgx3s8+84hbuHo16M=;
	b=MU6xmVzxmokipLO9Fhp2th7kUjMpekFAKJ3cL01BAGPVESsA3DQpFCT+8RvYO+BWCkFz
	 G4lXIxk6oCPLs4xLeFe/1gWgMuQQIUx2YO7o8bllI9yb56sBAzI/Bt31BoF0JVWw6E4TB
	 Su0R2C7HewPd5KPKXW/VkOFaztL15yrTWdzHYVQJu01cvctbcSHHv6ZrwDavYW80swwTm
	 YQrgnM4FZpLGYPtibyy/6qz3Ne9gYHDizN9GbxGqy5SMdgGLBZ8Yy5mW6vpiyiiiOJivT
	 Bsn9PizG3MLT9n5u6KgovrZmw0XDfw6+Ui1QZkOE3+uDFxqEWXnjT1IeN3ddz6XE/QQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795178964;
	bh=jYE4JvNMVq/bTd8S43Y/Id2EJZwgx3s8+84hbuHo16M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+edYJMcNmUx/X+TZ6Ev2m3y4CmPYgegR1Vonwv86V00HjYFrgMjBKmdT58hVhsdn
	 2Fntm80mjobYyKH4kmTrWuJlwPghBEqytzp6ALpCZ4ncealKKK8XiI6ms4Lx0/lt42
	 ZtFn/izcdTpCzVPkov45N8W1s20l/GoPj85oywsxpzrV0FkkgfhsyP2xD27pG5AIRN
	 zGIoGBHo1GLXIC3f9e2KB6hfvRO3cFw3SE2YpBoYkvEk0JxB7JXwKUQtZK0JwsqYad
	 sw0bv7awZCKeId+ZzIyB7ci4r538pNiMNY1ZTdhw5RvMHuzg6kI2S4V6SfLwqHoRIp
	 rB7AoFwumdCJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8DD481397;
	Fri, 20 Nov 2026 12:49:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEE0D465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 12:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94EA4606F3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 12:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id blyfvPh42sP1 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 12:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB103606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kxVIcc9h
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB103606F2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 12:49:21 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67db23d8892so1013091d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 04:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795178960; x=1795783760;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jYE4JvNMVq/bTd8S43Y/Id2EJZwgx3s8+84hbuHo16M=;
 b=kxVIcc9hR/Xc3d/1ExLUUXxynitzBslgS7Neeaxhb2uKgo65R8ZoAv3V/Nz43dfERH
 s+oWuJQloFjhg5YM67mw0Q+LpgeLs4BvYT+dwFTRXLSNfi6/NLz/0xlS4AuIA/VXCl4G
 Ci95sNRTOzchNQFS9pRccedcvwVZ4FfAe5275apZokQAAqqkbAH7K6/FZAPu9TeC5HEc
 CQoqf+3QCfQyb81/ftfPkRiIHs56aawywhrX+iOcCUHmRyHCxLTgPbOXJnC47AicC466
 fXR5sbLgueFPBUcQVpnXTFv5m3Q7cGKDveKAL+Hli0io0AyQKIdGXN4U54CFVYbCl0Tn
 M9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178960; x=1795783760;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jYE4JvNMVq/bTd8S43Y/Id2EJZwgx3s8+84hbuHo16M=;
 b=yjL+VaPK8XPdL0F4qbYr93a/5/ro/MoDLtVMfzhnj693Im+UfGfSALVhi+sDPPDqjd
 NaBiv4HrqDel8EyclkrGgkwDwZQbNnKAxFnNz8JbI2lnJbNnfUOMKIjFETx1qU12diZy
 K/Out+c0wxb7L4/9l1tsI+aI2/CPnvlk6HBXXsz9G/Pb8JXAZ+Z6C0wVynjzeaziJLS/
 3I+fdI/jzVW+7cydI8RXSilyexPCtBoG5P/t38oo+uAmHH+SxZ4PL0gORvShdN/30+ej
 m8Jj9tWVNxEUg1ibhIUhpd7HOuYxc6FUiGXh+Hvq7HLIESx+zmyKLwIJovtuCtAa6wzR
 6iyA==
X-Forwarded-Encrypted: i=1;
 AL+hErHbr8Pei0jjrPL+Dfz49UrcBSp5PuXbnvFDLoXRupSQFDWEw0ySGb44OsBlJhzkjQwiT0ZEhGw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+nTlUfDzvFMXzM2hSoJIwik7vsove7Vxc7KBmfGhVqbVC18Ezq
 ghffD/n4SkxAC+iMyaMCESsFb7eFJn9bKuvbT8/h0I4ZFtoAad0f3wiRBKoj+ReZHvsQFnZaYzL
 9DKBLcxRx9PpiQMtyqmyuFSX1pm8YWg60uEN16GYscg==
X-Gm-Gg: AZFdTZcQFiE50xKcSKMSngrdYUElSl0Gt8mUuW6LfpsM2VmBEX85wfq3TFeDgSS2Ox2
 WzLxZNMM+USWv0ECkNoyx94+QKQONVakfgd7HXYg2AX6+cub1NLpvBOk2pX+84Y/hrHW1ZxZi8+
 raFPCmg9y7m5DFk533kHuStAa5UbYTREDlPU6bosTrKnA1gtVCSKFwqzLnsPcy6xi94MvL/QIBU
 T6FeQpd6t7KwE15McaHuN4/6lNjeC92ATm7D4g2ZEDAkQAN/Ntdjx1kTeZnAf9l5rroEUvYhOSn
 Wl1sfj1gnWEfjMiQ0QgZhWAgsGKzb0pVBJQOV1h7NULIQXCqjJF+lr/qY4krD1cprk1Ll1F5rMv
 Q45S2PiIzCe8S4ZpPF1fxuVl+mvbf9MQ368zkRhLKLnA5EBC0FB86jzwnWbH61Z/wOrF9bOFrwV
 h3We/gt+aYXAowaNhpcbPqsdbKR7ZOrV4Xzs2FbA/3bYwnjTIqmsiJI3IFuMtobDaO3t40KW6oK
 Jb4KdUt+VgEoapgsiwLg0URK26QDg4nrMk8/tG6cDqwf819SBnJjFMDnhk5n1NeOYSAb0YlLTRm
 GmgO4dZquPkL4KnG7H3R7nHRxBKcw03kLdETGUw2FkA812Ews9/zoLDaRtUIZr2N79a/eY3Uccz
 9DjUya2QtDdd5WKJHJoE1UNps+2NHMDL1XPDaL4AqY9TVkfKuGZmFRoF+NIEzIL56RBZsdKR1Fo
 qREg7qWl/kuqZxsZasmc5YVvDnlrGQ5GCjFFOW4t1XnSZNO1xpnVXrExy7BcLvNSilfSmX
X-Received: by 2002:a05:690e:440d:b0:67a:4c43:3bab with SMTP id
 956f58d0204a3-67df4446bf1mr1034360d50.60.1795178959833; Fri, 20 Nov 2026
 04:49:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120075756.2548804-1-pbrobinson@gmail.com>
In-Reply-To: <20261120075756.2548804-1-pbrobinson@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Nov 2026 14:48:43 +0200
X-Gm-Features: AclHuK84k1CNatPLApGQ0GMiftrrYbZMmIrO_zGPbQV9tcFTNw0NFZlBjr0QHTU
Message-ID: <CAC_iWjLpwoeRJnfJ=M1UBmHJEHb0snj3+rpsQgSXBbVOa5hJyw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: efi_fdt: fix use-after-free in
 efi_load_distro_fdt()
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
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

Thanks Peter

On Fri, 20 Nov 2026 at 09:57, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The device path of the loaded device-tree is printed after it has been
> freed with efi_free_pool(). Print it before freeing it.
>
> Fixes: 5c1b5e6bc59a ("efi_loader: find distro device-path for media devices")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_fdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index bfaa9cfc207..5aeff62e76a 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -119,10 +119,10 @@ void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size)
>                 if (!file)
>                         break;
>                 ret = efi_load_image_from_path(true, file, fdt, fdt_size);
> -               efi_free_pool(file);
> -               if (ret == EFI_SUCCESS) {
> +               if (ret == EFI_SUCCESS)
>                         log_debug("Fdt %pD loaded\n", file);
> +               efi_free_pool(file);
> +               if (ret == EFI_SUCCESS)
>                         break;
> -               }
>         }
>  }
> --
> 2.56.1
>
