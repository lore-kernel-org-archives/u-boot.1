Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC91EED606
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 14:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B641988ECB;
	Thu, 12 Sep 2024 16:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rDPYNTqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C1788EEC; Thu, 12 Sep 2024 16:03:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B92188E79
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 16:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726149789; x=1726754589; i=xypron.glpk@gmx.de;
 bh=6XQ5xcUP6hngm5YL+plovBHgT8aRP2ZxpbCyB0hQdRY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rDPYNTqP7NE+EIqjMbANWg6CrOlO1jML1YNdo2vqa+vDb3vBuDG9SqZcn7NEDFNm
 cInBZQBOZ1tIKjOvxuUiBFscHiWfmIDrMoFVTfnI+pyqHpmvovGbVFLAdnbw56MPk
 pMfpuTxcWZ/8SE/QaL+4CtEKSjGIpjphSVekPwYOOVTSmIvPyrNFlCXz2CcbeRrJX
 bTZ5tALItvIrIMOCh2ibwP1o6X18ZZHbrioaOgVAQlrIlIH2e1Vlo0K0TCbNyYZ92
 O8VMq+VzxJS9n4h/plAdsTrcK5S9PKn26snK1Hj1DO5s3qkJ85CnqwUIggBZNHEAO
 WFcBxbNMiFrCKMJq9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1skIRB2xxA-0070hS; Thu, 12
 Sep 2024 16:03:09 +0200
Message-ID: <ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de>
Date: Thu, 12 Sep 2024 16:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] efi: Use the same filename for all sandbox builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRM3aNinNlE9F281Df8qlw1Zvx3mRMNOeEL7+2v8B2jTMxwO/uF
 aWr5maic3ZP4Ae0A91Yy1gWhg2suIMgOUoBPyzggO40wtCTOyKM67cEm7GVE6Rt0M/fmeXZ
 IBKcJX06O7UwqdYstWEofnN6ncRBq3SkoBGbtzOlKwjm3ok3lTW6v4yTpJxOVeo9vZrs9G0
 AA6VfuwqTw5gHy6QboRgA==
UI-OutboundReport: notjunk:1;M01:P0:OCjFcbq8NtU=;MXqg+LBolBZ4hRtS1DIc62WMv7O
 wiP+SH/Bs7eq89X4juV+rOxVM2exsySrnM4aT0ynxekrhxWNlueFio8IwsSlCAereXcfFZZ3e
 VRShsTvyWHfIAFoUMur6Z1HRk4n5sBYbYImCRoBFGGm+Gv08BoT1nLP2J3m6gW4UDmXaxJhB3
 aSudAckQMBusoveKwpJFhDw2A/kAbNOzv7vDItVjVI5FAyDajeLNKIk+CaOX13Lnqm58awmEl
 TG6CDscB1f8nd8QVnp2mmc08AbzMOaAZDukVl49wa3jQqDutKbN/azbjovOH4II4rRWZOAkVB
 h+qdN7AslMeNksSKvYja2XAc4f89Lwgqqae8tZquP0lM2/G4iXb6p2cpM0SaG4Ho9plil5xTi
 IyICRjidrFpuNjvTbQRSBthNOAmLxP7PNFwlciHE4OMSRn3QDG1OdhVuoPFFT+6GAndSrLbwT
 hpmeTissKLC4gI2tCqIdeqrJ7F/r3YPJFVu7oY0dVl6IdMAxemst1V6Fwp3dC21ve5z2mgEUe
 M49i1pv99uCGEgRWv5FoNyI1JAkqOJK+FSY/VnFHl+AtkqJzdkQXPgty1hzw+28ndAzOoMjt+
 O0oIBa8AJFzip3xv+PqeCZ1pvudKBXPbS5uPoVXHIs2vjcOvd/uDZGUGy0v+XCgPtrNTaad8C
 UDW+3peWrDpWl9NKEGDllF2HMGqCtpDMicqCpsLqfMBKpN36wyeK1HO+f19eXMBw5Uge4PHM1
 2N9rFjuvv3zcI4vk117lucXZUbTJ/FQlMuOdI4O+ipvdhiuHnGAkhwUtnNgiSTw0o8NyVaN4K
 5IlUP9vTrXCGjjB1LpwSkJww==
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

On 02.09.24 03:18, Simon Glass wrote:
> Sandbox is not a real architecture, but within U-Boot it is real enough.
> We should not need to pretend it is x86 or ARM anywhere in the code.
>
> Also we want to be able to locate the sandbox app using a single
> filename, 'bootsbox.efi', to avoid needing tests to produce different
> files on each host architecture.

The changed include is not meant to set anything for the sandbox app
which you run on top of an UEFI firmware. The sandbox app probably
should be called depending on the architecture sandboxaa64.efi,
sandobxriscv64.efi, etc.

This include is defining which file the EFI boot manager loads by
default. This value must conform to the EFI specification. When I have
built the sandbox on riscv64 I expect that it will load bootriscv64.efi
from a distro installer image.

Best regards

Heinrich

>
> Drop the confusing use of host architecture and just let sandbox be
> sandbox.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> Changes in v5:
> - Drop the Fixes tag
>
> Changes in v3:
> - Put back the Linaro copyright accidentally removed
>
>   include/efi_default_filename.h | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/include/efi_default_filename.h b/include/efi_default_filena=
me.h
> index 77932984b55..06ca8735002 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -16,26 +16,8 @@
>   #undef BOOTEFI_NAME
>
>   #ifdef CONFIG_SANDBOX
> -
> -#if HOST_ARCH =3D=3D HOST_ARCH_X86_64
> -#define BOOTEFI_NAME "BOOTX64.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_X86
> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_ARM
> -#define BOOTEFI_NAME "BOOTARM.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> -#else
> -#error Unsupported UEFI architecture
> -#endif
> -
> -#else
> -
> -#if defined(CONFIG_ARM64)
> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> +#elif defined(CONFIG_ARM64)
>   #define BOOTEFI_NAME "BOOTAA64.EFI"
>   #elif defined(CONFIG_ARM)
>   #define BOOTEFI_NAME "BOOTARM.EFI"
> @@ -52,5 +34,3 @@
>   #endif
>
>   #endif
> -
> -#endif

