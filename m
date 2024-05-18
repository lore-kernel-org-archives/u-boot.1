Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06196C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 20:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71379884A3;
	Sat, 18 May 2024 22:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="g/c1swuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E7F3884CD; Sat, 18 May 2024 22:15:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BBC882B8
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 22:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716063352; x=1716668152; i=xypron.glpk@gmx.de;
 bh=KcrRHRyGcqsuk6PHaLF4Rp8p+w0/2KK5HUuubUgwfuA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g/c1swuXgc8fNWq8/jY39iIbn/Tk6JSSGGWa0H+ypzZFan9/VuPE6GyB2VAKfUz3
 9QrpfpdocfKlXa7JvNKWftJ74YLEmNwxcBOInBlJ2SNvs3WyR7Dw4+y1Hb5nrJxNL
 Kw1wyV1gnq80V3c2rYb7wBAJXJTorgNZ4BbSpmEfGx6sIYjCyenfIhry+bLEw0gby
 5WT4gtLX1AaE22FWalvLhgCI4oApA0sJprdVdIFM2hv1/rDGDRCjbXfnxlWbz73Ww
 RcWy15SWdHT6HitDhCnl8riieX4oMUlhGHc9ZngrK7LOZNPMICgOr17NsPMGP+3ml
 jfRr79NpNjiQNvgtcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1sc5xN10Gb-017o68; Sat, 18
 May 2024 22:15:52 +0200
Message-ID: <b57f12c5-77fd-4020-b88f-8a1c0464bc93@gmx.de>
Date: Sat, 18 May 2024 22:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] EFI: Make EFI loader depend sandbox HOST_ARCH
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
 <20240517-sandbox-hostarch-kconfig-v1-2-716c146635c9@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240517-sandbox-hostarch-kconfig-v1-2-716c146635c9@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgLN4/sobAs4q43Ha1wDXOTBY3Ib8ZS/L2vrD5LOBVagTaEUwaA
 Km/JpbFZzpnVQW0gJjK/4My+GwLHqipw+q6EfABjnGjWK19ArU5OSg9x3/gtADWGnB19ODx
 tqO0ucfXKLBwZmyr1xkN0dfuZ5M7DpvThl1B6OTvUlwY4j6QY6xkDxOVn9rMZIU4u9vhNTn
 CUmTvArgN6h1NYHEbHUeA==
UI-OutboundReport: notjunk:1;M01:P0:UuQ5WYZPqHw=;fKTYYtfO+BpvuIxaon/q143keFA
 Lwfb6grCZmTzPuf/DihzGeJY2giv0Q+TaB0h1yL32+1V3A3lNUSZNx7rQAbVNWx0x2RYnJECn
 pEuUz5iWyhJTsh4WgSDv2vUAHmEzNejxgNxCgFgWQka+FRsI22nUT852fDVzTSHGuIrw6ufDV
 fECaWXs48tFms8/+iMbH8MXaXxXPO+MbrFPUd4pgMV9MNz+D7ry0S3p0R1cHBWl0mLOSnLkpu
 Z9wRZWaXcemoZsyTNd2lhm7LggVaxU2fubQ1pREs6WKjUCYSDMKD/kz/yWwpkwJhIjAIWLTEF
 eHL6JihYBI60LIzANarWjDK5Gsox4vn6UjvL2Er6+jeFYjTaC+dILAIDAneTB3C7D77Xg4yS3
 A+iHRgJ4dqjOeNd1lb100Yqo9ada7QyGh09KOwjmN7k8mqjUJbC8unYJeX7UFNMRWxeHh11T2
 26gUlI7uLfGTxO/PdNqDU9/yAp9lUGPurOluQK5yO04zVBgxMt40l1rdrb3pQ3xdJkW1dmi38
 memFcU6M++DW0+LUi6oJBeX4Zp6kb16LZY8g01TwVq+rDr0dxmnEbaWfREzHGrvGE7bTcnsH5
 i+VLi4JGIJz2ExEDdVRlZybf/LXeXqdsq8c2n78dvYTM2JJxJ67LdmP3DTkbeVmcuKZxQufwJ
 XUCKDeY0wrSNSc0nYFPEKlZ19aIiZqRHdUsLhhpGsiWfEE8xeZlIvIUDvGANYVXxnmrIqckfk
 BlwjuGUXK5QyO+CTiLoa6m78IVWGjfbiKq92n2GkF56lxX2cV0auS5MGV+lMLva88A+UNRSng
 HQpFwiQ8wgTAfj04mJ2XVEibBu0/qOj1fcGbS53Dx0ycg=
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

On 5/18/24 00:09, Jiaxun Yang wrote:
> Since EFI loader on sandbox requires some architecture
> code, make it depend on HOST_ARCH to ensure it's only
> compiled on desired host.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   lib/efi_loader/Kconfig | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 430bb7f0f7dc..54d180fe31c1 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -1,11 +1,14 @@
>   config EFI_LOADER
>   	bool "Support running UEFI applications"
> -	depends on OF_LIBFDT && ( \
> +	depends on OF_LIBFDT && (( \
>   		ARM && (SYS_CPU =3D arm1136 || \
>   			SYS_CPU =3D arm1176 || \
>   			SYS_CPU =3D armv7   || \
>   			SYS_CPU =3D armv8)  || \
> -		X86 || RISCV || SANDBOX)
> +		X86 || RISCV) || \

The newly parentheses are not needed.

> +		(SANDBOX && (HOST_ARCH_X86 || HOST_ARCH_X86_64 || \
> +			     HOST_ARCH_ARM || HOST_ARCH_AARCH64 || \
> +			     HOST_ARCH_RISCV32 || HOST_ARCH_RISCV64)))
>   	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
>   	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
>   	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>

