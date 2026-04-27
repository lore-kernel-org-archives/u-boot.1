Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406E5FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB608407D;
	Mon, 27 Apr 2026 17:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sL9YbJWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD998407D; Mon, 27 Apr 2026 17:49:01 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5128416F
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65492d097acso3612791d50.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777304938; cv=none;
 d=google.com; s=arc-20240605;
 b=M7BBfQkGIQayrvaetfDs0kQHQDR0WxkEWblkFE5QwUX/0heWqYsMwaFyde+TAhFYlt
 kEpumw0XAu1svc4auCbm76zk59DiwxCnuPVO6u67NwOd+GYUQDK83KDPIlUJMaZa/M6k
 IjLablr9lAiweb561D9c/C4nW28KkQS6o2GwOAc6UlCVdHy6W5QAq/N9TK9L8eMi2J0b
 3Q+wLvyJdjQBvErehrLC6B/A6UkD9zYkcB5kWiEY+oFxu/6nAECCf3KjVfrwISsHCHdo
 kvb9FRXadGaXotTxpLAphuv0YR//DAlDL1+/cdVFAhWQ7lC1+OuOZl4HhOQiJbPIGUXW
 gyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=axr+qxZ6OGN1GxL+Aw54sNEXqwqHf189XhcXyaQGp0U=;
 fh=gRqF68w5xlhHI5vFNNkFEhHzKZRRR85TsS5nflw4rJI=;
 b=WOBK46MCpprxMkEqZwYlQv+e/H15W9zNXZbVdhvSBIezlfOyNncJmz/zb2+cn5I9aP
 mwYOE2zzZcWaEZJKbbxQGgoc9HDGgNSUEkBtQRzVRfVviRLLVJtTgZPNIrhFaTrVZMX9
 4NQ6dWI0p6xcb241govBYzVy2o8IDH/8DBOzxFQaPrF8yPNLWEJ5PR2w5floU+RhGxlZ
 D4Cr3i0oh2fxbz7kZCX48uW2+OwcSjaNqMOO+fU11LEu2trBxoci20X2jLcd9PYVOBwg
 5DUWPSKhTdsDBMYQzD53xf5elWhzL0JoKbreXysIdvf7p0fGbAgHqkG0ETyoUfxCtk+P
 SyQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777304938; x=1777909738; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axr+qxZ6OGN1GxL+Aw54sNEXqwqHf189XhcXyaQGp0U=;
 b=sL9YbJWZCSMgNShsBTUMVc+be2Gx7UC0RhGI7bJ6VKEu+KM/+ZIjGF53lM1spdesg7
 r58aZqLRvlpklP3A5AfYAxIaQ3sjwzdQ74ThooI4q9R51vtRQZp33kcIR0b1OsIeaH+z
 WGyHv3q8hNDDUqdfUNbh1lV+eIK/scwAb41UOZf2zUafYoSC0z+t2GPYI8xGTo0coM48
 Msc+/+VJhZhRmcXjkcDmIyhmXtaWauJBf8zmryslgp94qyFGfYXilpvQBb42rKunDAOY
 78Hlqxrrzz/hgYbZlirt2t+djiz8rxpEHEftC1mVBg4OsZVs+z+nL+oPmwyQls1bkuRj
 UnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304938; x=1777909738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axr+qxZ6OGN1GxL+Aw54sNEXqwqHf189XhcXyaQGp0U=;
 b=VCf9x76HnW6YmK4UWb0sVUNFdLXnPQJCzW3sx4/vH/AwOC2SG0iu/0F5rhdOXWOdLP
 mu8KHpUeC2gJohPjWDnK/54uCs6zGEZy3VsULKDv7bbEY+yuhNnjFfpqdjfgWf7lXG0d
 IXzL4yiMww7bifGQe49RcF48l8b95oIbJLB7lpjrHiDxx2cDJnFZ3pSrymXMplOTjbd5
 UPIjSRrotWDD9muRSF9rF5qji4tOpnCW4IpTNMxVDrNW0NYbE6v0YqQH5VyuuWk0KtN3
 4wnSJr0i8MBAbWnSxD/ct67Aosj/qmzGEdGKO6CucGXFU75Fr6X20g7qJFgwV7zGquYp
 QdWQ==
X-Gm-Message-State: AOJu0Ywm8tjDvd/oepTRW1U8H+L6pIuregHC01QAGipoQ2vwlPu7CIWh
 L61RGtCddhBY/xihziagrclbjpOft4d4KvUUQdzwQ1Hh4c8SKT2UZeUuTASF76a/p7va3bVaeMz
 SFOTJ5If4Qtscoit32VHL5sSgH8E1WpGCT75GWpZI0wVUiaKj9MJO7rc=
X-Gm-Gg: AeBDievfSlAlu/BflHr/lM0/IUalxVeR1JIB7j1kmliIakuDnG/I+KKlJZJBZKpMQ+E
 mS9n+1mpTARDI6o/+M55bBA7n4pwCa24J4Dx3XZPQGsBmfOBtyPoZ4Tkyjk4kPo1wqlclWD6jUa
 p/V+x1KHrQ9+pFFurLQd6ylEFE3m3FBEC1vuW4LLsm7RtaHSqrF6XFohyp0VrO2PVJLy4LvTJWC
 TK6YOkKT58Py5v3Ou9VT1WgvJvfE4OQtbvvHKLDIQLr3KF/O/86SSrep4/2+qEDjJiK96QerR+w
 V/Z0fPHdPb/vc77hvrW9K1h6cY8hIJIjAtHhbtiRjzKuWpYKP+WkLrRNTKDFykhb+LUKGaBpPa/
 jBcJFiLg6RQVeQi4uBNEO8IdmC8rwiRhCvXF4QktAbKaNetMvtShmmrjegQHWD36VCS4PtpSDem
 8sEDXoZpyq/957CRcyfd5zeQJ1QCTEBqETGM2r2ZdR7kHYKXAY9bIf+9H6PPhCLKtlKt5YdNckS
 w18ha1bID8BZ9XPxYeZ1Fvg5q8fUwN+3ABJ3pNDEn9Li/8hsdh/TYe7ei7FYew6AAK04YFVT2OE
 5U07Y1OuwVih2wRph4sgD19Di5G1bLoqzPgEUYMHeVUbHV1vgBShmdX8hsF6BK4I9/ftFVLgtYZ
 +ux/LWmAQpqpusTO8IvA0q3n7WVw=
X-Received: by 2002:a05:690e:1b60:b0:651:b1ad:49f6 with SMTP id
 956f58d0204a3-65310a13c2bmr29522128d50.40.1777304937679; Mon, 27 Apr 2026
 08:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
In-Reply-To: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 18:48:21 +0300
X-Gm-Features: AVHnY4L-ndMHIlPGDhUZaHkaZCyswnqQeG1lQVBDwrhs8QLG9ae_cPDX0benUXs
Message-ID: <CAC_iWj+iD0m9JL+A++W85+sYQGYSqVHP287ga7g13dkVevy9AA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix AllocatePages overlap status
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

Hi Harsiman,

On Mon, 27 Apr 2026 at 18:05, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS overlap
>
> When efi_allocate_pages() is called with EFI_ALLOCATE_ADDRESS, UEFI
> expects EFI_NOT_FOUND if the requested address range is already
> allocated or unavailable.
>  U-Boot currently returns
> EFI_OUT_OF_RESOURCES when efi_update_memory_map() detects an overlap
> after a successful lmb_alloc_mem(), which does not match
> EFI_ALLOCATE_ADDRESS semantics.
>
> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS requests that fail due
> to an overlapping EFI memory descriptor, while keeping
> EFI_OUT_OF_RESOURCES for other allocation types.
>
> The UEFI specification [1] specifies that
> EFI_BOOT_SERVICES.AllocatePages must return EFI_NOT_FOUND when the
> requested address range is unavailable or already allocated;
> EFI_OUT_OF_RESOURCES applies to non=E2=80=91address=E2=80=91specific allo=
cation
> failures.

Where does the EFI spec say that? EDKII indeed returns EFI_NOT_FOUND
for AllocateAddress but looking at the function description, I can't
find anything specific.

Thanks
/Ilias

>
> [1] https://uefi.org/specs/UEFI/2.10_A/07_Services_Boot_Services.html
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  lib/efi_loader/efi_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc..63cf1a7277f 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -510,7 +510,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,
>                 /* Map would overlap, bail out */
>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
> -               return  EFI_OUT_OF_RESOURCES;
> +               if (type =3D=3D EFI_ALLOCATE_ADDRESS)
> +                       return EFI_NOT_FOUND;
> +               return EFI_OUT_OF_RESOURCES;
>         }
>
>         *memory =3D efi_addr;
> --
> 2.34.1
>
