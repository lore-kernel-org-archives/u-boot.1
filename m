Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720AD70DEA
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9996089891;
	Thu, 28 Nov 2024 18:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k7UOnxGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E4889D20; Thu, 28 Nov 2024 18:38:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AB9893A7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 18:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732815532; x=1733420332; i=xypron.glpk@gmx.de;
 bh=z1YZNm3rxSE5LdS9dCzxF9LDR/2KdJ7QylI7KlKgnD8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k7UOnxGPMxR8ZMLVBh7qEvZXMXGpU4hha072tNo1RC7pzV7p0PdLBNCWUoJx964k
 nuSKHVeOIewxoOmGdtwr0G6P8306w2vmg3MXmSUpFbLb78gg3wsuHXHX8LRNxqhSJ
 SGjvdfe4+35ETkV8EUmJLRBqaFynP6nz67P0Fqr2+Bh7hvGHZ/PLH4lxsRr4pHg/t
 HmbRD+AGL8Uul00zIryuW9QhZc4hnZmCaLYtREGU/gIetu3dgklpQaOqsLOPtigSD
 kSEvepTrTdkoRB4UXBK0LtgzErzUravE3BokF+iVBOP2K1qWFjUEMJxwCUlLh4eBM
 HUqLr9wkEGY6uERyOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1t8EAM47tJ-00Lbpl; Thu, 28
 Nov 2024 18:38:52 +0100
Message-ID: <c158c1e4-95f6-422e-8bb5-c86dcf418d11@gmx.de>
Date: Thu, 28 Nov 2024 18:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/28] efi_loader: Don't try to add sandbox runtime code
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-28-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-28-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RWASFvL1iGmQFUjtV0+eGUpj8+SP4guv50/vxr3KG2suGWnnvpw
 aCIFcXDWUWYZJrW0vZmPENAJGb/Ew/9KR9XZuAzalvTH2btNR/ANQGHsRgKWHpIpCB8vjq8
 InZ5pLyQRFp8gaJPW2ciyGXugZu4/VrkUL/D2kkRrzqxMGSubfGt0BU/Zn/QOzq/JWH2le4
 ktXOiekOvYsjcnwTU9n9w==
UI-OutboundReport: notjunk:1;M01:P0:Piww2aaRohc=;Njh65MdrGpEKEUVsqdamyWvNw9T
 dXS2Jkb6Ne94NUrWfMF7a2kz7Ut7SAd97Mx5FitFbzB6Oc8dYJuUB9jlGnCghULiVrMV7YAeH
 VJ6jEoqgAa9mstYQapof2lW6MedGYURG6luFeR0XrPYJv1HtZw8IrWnOAO4aeVdM7fq4yVKUU
 BRte4uTT88o15pqGftXnZ/sDUxRI3s2+0wBTgGwmC7hlTLZYmc/haeZRWMpnLOPn2G8lDEaPD
 YFKGXfNPWnoe2hNeJRtiRLpwuTKfnQxdqv+mWKZDJoi8d9jNq/wpjO/S/VSbVSt08KlJPNM/m
 rQ7uNPSWFbyg1HF8Jg1V6GGVQzu5pzeDBMjb3mE8Uzp4o0XMRVV0L5thlC/DXJS+8e9drHLlk
 Km+KOZGcXx+BNJYCFBKxFcl4LEPp/RLNBIon7jmFB/Q9yA4+iIYvSZ3blgoC38/JRsPoScQdF
 fXCTY2iYfPNH6E6KLYEryhZ8AycJ8rdF83iDObD6GEhKkLYawcpeh3NcevZtfXwAs5AbMmbcy
 S6sEJNbE0FU9Q7WCv1AenF69sEJGbMzdZ8xtX5HMHHtSpf2ClTLAbTqNngBVyc4U8VtYtLP87
 TFtB9tQuGy+HZAmS5sDwjnu5rFtlHleX/+3bPV7rXPJBcVlkzNDHqzpsmrOSThESgVd04AYxp
 9pXnyFvEUn8Z0YnAFY/o6QUBox+0+komVX7ghktpallv5+Mknr8eXTYuEQWmMhxxUMyBoSHlF
 AVWAxh/O28do0yGvxni9Bs1VtZ32J2tZbuawT96DwuMuz+rFxXadnvAw3xMMHpU6OzwlQKwFk
 iyI02DyLjVlBL7Lzw/x2m4ssy+05o7P1WhtiMxU8i8ATCq08y3md1T2UmnaDzw1TmMkEE/x7S
 4vWjGxZul6bnVZe7axvPHSDsK+nThzW3cYkcQ2LRo672pQLUkgYtZnphRh+FuBQK9cSUTW6Qh
 6mj35xg1CjGEx6YrNB0Up3XL/ELfd1L0wPXPovVKJyuw18SrkI6ktaQvnHIZ8DJPsReaFDThi
 5V8AbQOEqMsqyS90egALruuZVdsp8DtWSwrdzcTLiBxhsL5469uvActKWdCYh3LRxN/Ya9dJX
 3WOn6dKbw=
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

On 28.11.24 16:47, Simon Glass wrote:
> This cannot work since the code is not present in the emulated memory.
> In any case, sandbox cannot make use of the runtime code.

For sure an EFI application running on the sandbox can run
ExitBootServices() and then call the ResetSystem() runtime system service.

Have a look at

arch/sandbox/cpu/start.c:472:
void __efi_runtime EFIAPI efi_reset_system().

__efi_runtime implements ResetSystem() after ExitBootServices().

>
> For now, just drop it from sandbox. We can always adjust things to copy
> it into memory, if needed.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index a33c025fa20..796fa99f4fb 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -755,16 +755,22 @@ static void add_u_boot_and_runtime(void)
>   	runtime_mask =3D SZ_64K - 1;
>   #endif
>
> -	/*
> -	 * Add Runtime Services. We mark surrounding boottime code as runtime =
as
> -	 * well to fulfill the runtime alignment constraints but avoid padding=
.
> -	 */
> -	runtime_start =3D (uintptr_t)__efi_runtime_start & ~runtime_mask;
> -	runtime_end =3D (uintptr_t)__efi_runtime_stop;
> -	runtime_end =3D (runtime_end + runtime_mask) & ~runtime_mask;
> -	runtime_pages =3D (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> -	efi_add_memory_map_pg(runtime_start, runtime_pages,
> -			      EFI_RUNTIME_SERVICES_CODE, false);
> +	if (!IS_ENABLED(CONFIG_SANDBOX)) {
> +		/*
> +		 * Add Runtime Services. We mark surrounding boottime code as
> +		 * runtime as well to fulfill the runtime alignment constraints
> +		 * but avoid padding.
> +		 *
> +		 * This is not enabled for sandbox, since we cannot map the
> +		 * sandbox code into emulated SDRAM

The memory map is consumed by an EFI application like shim, GRUB, or the
kernel stub.

The memory map entries must take address values which can be used a
void* without conversion. This is true both on real systems and on the
sandbox.

Isn't __efi_runtime_start a pointer to the start of the efi_runtime code
section on the sandbox?

Best regards

Heinrich
> +		 */
> +		runtime_start =3D (uintptr_t)__efi_runtime_start & ~runtime_mask;
> +		runtime_end =3D (uintptr_t)__efi_runtime_stop;
> +		runtime_end =3D (runtime_end + runtime_mask) & ~runtime_mask;
> +		runtime_pages =3D (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> +		efi_add_memory_map_pg(runtime_start, runtime_pages,
> +				      EFI_RUNTIME_SERVICES_CODE, false);
> +	}
>   }
>
>   int efi_memory_init(void)

