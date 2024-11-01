Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150BE6B243
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043C788F92;
	Fri,  1 Nov 2024 12:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IR5ftM0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE81689021; Fri,  1 Nov 2024 12:46:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A11E88E94
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730461609; x=1731066409; i=xypron.glpk@gmx.de;
 bh=ON4Rw2gCV07/6ssI9+54GMzY/JwO/p7Fr5dR6rWpU20=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IR5ftM0i9HeVu8iwAAZ3BGCkhgW+X/cSPx8stHPtecbcuhvv35MWjTCKi8JYZEZM
 B9tUU34L+478k5olSkEWaX1KXA8/Wtgl38c74JfCVQTUTOInjmTjdBTMFLnfKSRuk
 zJAt1lohN4XIYs9MNuQg+kizak/c/cjgCl8bXApZJTN/GON1Zt4DnvGSrTWm1EMbn
 6uvo4Ze14FZem/Cpw7qyimYBU53wP0XR1uIq5twSB68ifPC2aHpK9vte6BDhcGKIy
 lV3P2AYfAVIPHIedI7VT30+14ZKpjDk6qV88oiq1Lq94UucN8K43h3B3YFB7mnsXr
 2jUhTLnCRG64zrAoEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1tKbVK3oBO-00UPXo; Fri, 01
 Nov 2024 12:46:49 +0100
Message-ID: <91b284bc-b3ca-4475-8e27-01ece4ef10e4@gmx.de>
Date: Fri, 1 Nov 2024 12:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: cpu: Implement allow_unaligned()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241031220605.31684-1-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241031220605.31684-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wtyhtHLh/dVo91N0c8vAS456pS9xhZJEv/fqNnnpqvxFrKxyIb
 11bRhtGx5RDq/Bccywon/tvnyK012Z2jWhEnPGsEUYX406hcFZMzHYQQgPUz3VXPdHoAA0D
 fHLfqhFeLi1oGeBz4LvIMhMpelePgmp4w65QeLrZwgh+l7B+GP7t6Z52ZmE1disC84qDjlj
 zw+S1+CHbDgFl/prkx2SQ==
UI-OutboundReport: notjunk:1;M01:P0:PX20jfGKLQo=;YTn1aOZgjZ8NU9r1Y+gtlZnEUDo
 45uuyaL6xAjXurGnpfi2q8/ljkxl2Vx1IRdHQxUigbZaqZFFLZc4nFkQhq9IFK6C4SsNZytCq
 PJd9SX7LQ0tLnLQaS3eR/Ixv6C8t+g++IFCi77/kBGMHNc/g5ca0VN58Aife4710TUJFTXZTE
 0JXJKXkSoIipg4DTqyziw9z9197oE4PU2epW1jd7cbRxQZrssDJ09qDxwLxB1pRXw8GmwFBeT
 GF8ieFQeTfK9YCiyRGvVMM8H8kHzymUHD4MVm8EKdranGHMIdWjYXCMJyerZtai6wjTLx3X4b
 TyThbd0GoB1tIDqacFA+IKv4nc/nbWeDaoTm5lkrtW45sNWPMzvjm5CGvOTiweUbRGLaw5TFM
 Rsu1xIUChMMtXG/sU21yvKvswGFp8F0nYo/Sgx+jOE/8Jj+doPDgfMp5ENf8E3BTsGy2lpWDQ
 4jqygJ+idGkZYJ4HSUx66kiiJ1AMeZ/b/2v1opnvY+ZFRYWxyZeL1xAcZp5WxLCgDKLx3T7z7
 z9ZNLHFkt5A6mkgPckFZrIdc/Tx8gwxKOBo6XG1hwQbDp0C3TtfKv+JQsYeO+75GXP6kqNOY5
 epFPR0Xr/LdZFt+eFiL63sZrF/shxsKKjFtUIIUAMiFUYcUKMWSssGT1/YmoX656XI6hXYRA0
 mFTR3ACgMT63enURmh8uupKdzcc2d+HF6AkrgfiYYtBOW2HT8C+E+WWzUgk2HvGI/6EFOonyp
 q+DffdBrzK8Ocx5/RMkvLl7FqIU63HVuZ9S2J/3x8F2rNRvm3krIIPCasflOqNHtVJcFAC588
 2+ST7e9ak6/vunorCKT1EBWQ==
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

On 10/31/24 23:06, Sam Protsenko wrote:
> Usually ARMv8 platforms allow unaligned access for Normal memory. But
> some chips might not allow it by default, having SCTLR.A bit set to 1
> before U-Boot execution. One such example is Exynos850 SoC. As
> allow_unaligned() is not implemented for ARMv8 at the moment, its __weak
> implementation is used, which does nothing. That might lead to unaligned
> access abort, for example when running EFI selftest. Fix that by
> implementing allow_unaligned() for ARMv8.
>
> The issue was found when running EFI selftest on E850-96 board
> (Exynos850 based):
>
>      =3D> bootefi selftest $fdtcontroladdr
>
>      ...
>      Executing 'HII database protocols'
>      "Synchronous Abort" handler, esr 0x96000021, far 0xbaac0991
>      ...
>      resetting ...
>
> Unaligned abort happens in u16_strnlen(), which is called from
> efi_hii_sibt_string_ucs2_block_next():
>
>      u16_strlen(blk->string_text)
>
> where 'blk' type is struct efi_hii_sibt_string_ucs2_block. Because this
> struct is packed, doing "->string_text" makes 'blk' address incremented
> by 1 byte, which makes it unaligned. Although allow_unaligned() was
> called in efi_init_early() before EFI selftest execution, it wasn't
> implemented for ARMv8 CPUs, so data abort happened.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   arch/arm/cpu/armv8/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
> index d568efa427ab..82ecf02f4b03 100644
> --- a/arch/arm/cpu/armv8/cpu.c
> +++ b/arch/arm/cpu/armv8/cpu.c
> @@ -94,3 +94,8 @@ void armv8_setup_psci(void)
>   	secure_ram_addr(psci_arch_init)();
>   }
>   #endif
> +
> +void allow_unaligned(void)
> +{
> +	set_sctlr(get_sctlr() & ~CR_A);

Looking at the ARM documentation SCTLR_EL2 is a 64bit register.

https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/=
SCTLR-EL2--System-Control-Register--EL2-?lang=3Den

But get_sctlr() is defined as

arch/arm/include/asm/system.h:174:
static inline unsigned int get_sctlr(void)

Your code might not work as expected. Should we adjust the definition of
get_sctlr() to return a long value?

Best regards

Heinrich

> +}

