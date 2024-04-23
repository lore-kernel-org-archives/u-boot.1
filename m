Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 06:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB23889B5;
	Tue, 23 Apr 2024 08:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O1/LzwKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDF388599; Tue, 23 Apr 2024 08:20:38 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC9B88511
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 08:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so207872366b.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713853236; x=1714458036; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HY88JnWeHVtk9KHKXkOPCOA5aKsEUrjVHftZPVc61A=;
 b=O1/LzwKDMuTfNmkW7MJWR6dcJmJmX6op6ZNSp+k9GUYqWaVJ245A367vuIEOzEOiGn
 08ew+auzFNeHwaZ96mJpuv+dsshd5TUWjhdhzwiUWb2Pe0xtJ5hxnJJ97yPlpZXpjgBT
 /+pSqjcah9nWvrfgWoyeYssoN8vffdJ1WV0DPNcVusiJ7ZRUQISrOJoJYFXrsMfHcCJu
 KWZy4phfJaro35o3yIYaurQlAGipSwgjPka1FVsPjDPOVCA30pAa7qaudi8pw6NWknjJ
 PzkyI4JQ6iN+bWRCbo5U8yyLAAEV3/i7OIiyVfv1xhTCi4hFwhHMN+A3hO0JgagBDmnI
 Aifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713853236; x=1714458036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HY88JnWeHVtk9KHKXkOPCOA5aKsEUrjVHftZPVc61A=;
 b=iBOX05R2BSLWGjDloL60LRNZzTQhRoCYDI+UAbRUe/3/B30pILpb1n/ln7i02Lnz9V
 PamoHwzdzUviY2BJd05mmyARrkfF1ntSwRLt9C9OMpmMlZcC0uPOlumTxdW0hKrFhsvQ
 2yLoKMWxAhIgzLMXn+uRIJU5LU5r/dsAzfrEVjA2V2pa0hnAjaRAsk/7a9nf5X2O3geR
 UNxX9tNmNRISLCZbBnmJjJkyVfKzp72n1K/DJiQZc8tfrDrFn/9Z0jaas+u3RhEaPP3s
 hYL+DnCSqnyCd0kusB1Bw89Mi2O+21jblaLKs7onExM0LDWip6ME2X0TceAUQMmQiFOb
 Z9wQ==
X-Gm-Message-State: AOJu0Yz8tx+6MikbuGSaitlMSuFyD2EhZ0D6zCTouCsAObnWprWaeKOn
 xyUl+BYGwbyLzHzx6U8OLZr3nQGhb9BbHsAhe6smUVuFztx9eM9sUopL2ARKlqBJNZOfElR3NjD
 Gvr81bC/3hCZwAXZRK0PkZ47H9KoM4PvRucp3bg==
X-Google-Smtp-Source: AGHT+IEYrN0AdbPhZeLNPZOnV3MjvetA6IfJkriXVz3jLfrS1pGkaXWczqEiWwQ81aTsfzxByZpSSpKJko8S8at4mQc=
X-Received: by 2002:a17:907:971e:b0:a58:838f:e2a4 with SMTP id
 jg30-20020a170907971e00b00a58838fe2a4mr77016ejc.22.1713853235874; Mon, 22 Apr
 2024 23:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240422214837.GY1054907@bill-the-cat>
In-Reply-To: <20240422214837.GY1054907@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Apr 2024 09:19:59 +0300
Message-ID: <CAC_iWjK-P66DYd_yLQMtHa=eKQ=jf66HySraahG3uduaitRGrQ@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Charles Hardin <ckhardin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

Thanks! Already sent a fix for UEFI

On Tue, 23 Apr 2024 at 00:48, Tom Rini <trini@konsulko.com> wrote:
>
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 22, 2024 at 3:23=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 7 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 2 of 2 defect(s)
>
>
> ** CID 492766:  Control flow issues  (DEADCODE)
> /lib/efi_loader/efi_var_mem.c: 236 in efi_var_mem_init()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 492766:  Control flow issues  (DEADCODE)
> /lib/efi_loader/efi_var_mem.c: 236 in efi_var_mem_init()
> 230             memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
> 231             efi_var_buf->magic =3D EFI_VAR_FILE_MAGIC;
> 232             efi_var_buf->length =3D (uintptr_t)efi_var_buf->var -
> 233                                   (uintptr_t)efi_var_buf;
> 234
> 235             if (ret !=3D EFI_SUCCESS)
> >>>     CID 492766:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "return ret;".
> 236                     return ret;
> 237             ret =3D
> efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
> 238
> efi_var_mem_notify_virtual_address_map, NULL,
> 239                                    NULL, &event);
> 240             if (ret !=3D EFI_SUCCESS)
> 241                     return ret;
>
> ** CID 492765:  Uninitialized variables  (UNINIT)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 492765:  Uninitialized variables  (UNINIT)
> /net/bootp.c: 888 in dhcp_process_options()
> 882                             net_root_path[size] =3D 0;
> 883                             break;
> 884                     case 28:        /* Ignore Broadcast Address Optio=
n */
> 885                             break;
> 886                     case 40:        /* NIS Domain name */
> 887                             if (net_nis_domain[0] =3D=3D 0) {
> >>>     CID 492765:  Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "size" when calling "truncate_sz".
> 888                                     size =3D truncate_sz("NIS Domain =
Name",
> 889                                             sizeof(net_nis_domain), s=
ize);
> 890                                     memcpy(&net_nis_domain, popt + 2,=
 size);
> 891                                     net_nis_domain[size] =3D 0;
> 892                             }
> 893                             break;
>
>
> --
> Tom
