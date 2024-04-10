Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D9CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6FD877AF;
	Wed, 10 Apr 2024 14:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RbZ6F3O6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB8B881A7; Wed, 10 Apr 2024 14:24:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F7987527
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712751879; x=1713356679; i=xypron.glpk@gmx.de;
 bh=AWZITCpxCWkOezPWQU0QCBXG8YjuYJz42wsWiZ708HI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RbZ6F3O6H+g2lUn+VO9aZxssi2xaWLlxPUr39JhTg23Blar3/sk1+3VDZkmV9wkM
 w0sQexXRW1GUJY2Bq17Y2l3tLvT6jzuYf7lBcgfHVp/j/n2tjNH9sV1TXTOZNVKuf
 MYuweBTZ6grHd5+W1YTztPV4/ytGebKuaMbx2cmDIjK1ib5wyrM39u5ObIkXxJyFp
 V1NHc8UIU7rXThNsphZyqJjEscsF58mumZ472s2K4LYK3OTnrvrp24fkq+MCyou89
 3zB+tPgtnfhAepmRLmRr/qZV0EoR1wzODtJiGNuVJIA0WLENE26m+oj/ik9u/895v
 khCs4ILdmI8aEuic8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1sT2o8462E-00ZxZH; Wed, 10
 Apr 2024 14:24:39 +0200
Message-ID: <400d93c5-d49e-48a3-b677-b61182ad6fcd@gmx.de>
Date: Wed, 10 Apr 2024 14:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: using EFI_UNSUPPORTED for private
 authenticated variables
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240410121933.152265-1-o451686892@gmail.com>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240410121933.152265-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jpst74rOLZ+N1JriYwZOcVpBI/oyslw04amHLw6/mzD5fT8IdbW
 PtdcV1S36ZRoO/+4kCom2XlciGL41JZdlb92PTqSKQmVcm1R/5lOX/HZE2kEKbc0Ab/30FB
 5wEAf7MAyvPmKuWOBIKrHwXusqE9v3t2hQi0XURhdg/ZtYTfaLoM3MROsuROQca+i5kD+Fm
 XKvgdW9FE4jLwezpNodtg==
UI-OutboundReport: notjunk:1;M01:P0:hTr9il5hYSY=;r247hv/SyylVOzvdAPX8WjDClpW
 Ekk/qEB/BU1GH5Ees6kzq2X9Zer5yrdi3Z8/bQIe6rkCzb6V2AhCpLUDHKddPYSTNmdWDFsR7
 LmZSMkOgiMeEZyd8u+lMHihHmNsiH/VwQBxep3OJUD7qEjuwXSiU9yWO62t/SLGbtl9+fIlkc
 6NKRfkAyxsHfSnXXJMPIAZekrQEU3wG39FM51VTIawgvl0mrN/jpUDX74f40Um7JjfJ9siInn
 XTuxcuhPARPZnh0/EZdi95QjfmhA7z821Ax2Kg+r3NkCnmDPJjuKgMo66AAXvGD6KvUKGUgqF
 YqCodZbbB/60UPX0wdPMOgUhZELTh0rOgvjFn99hTSJqXKZlggLCDUefPk2HolJBPUYRQBAuZ
 bTe+0EnH/2m4yQAYv+53lKZcvLpTj3m03P0ZXRYHfQnXd50jt8rsPfvZOfmPpqjU2Ob8IBvUH
 KA8AET03875bVf8LSUF7p4MNJenWYmDL73z0HInk1/Wff39ZP4AYAZ701jIXJkdwaoJ8YPiyQ
 KckhiU2GKEif7RA7ujpGF1bXzDVns2EtVbK6UUSb2YncDxDZw8Ofr/gfmV2EwGFJCBkEbeTus
 SsJeKwzj7pwpgEGEN/DQf2C2TWL6SlQ6qawwBlunS12KYg0WP2OsoFk82uWYMbRhLLWv6j4EO
 nhclBB3Yi4fykb0wG6WCODpF3X0kqwe1fIu95s16UenrYv/zTikuF2iMSiRKHCnDHgCmjdGAO
 cuDpWRp6iwyzl2ymha7hR089m5CioCr99aDmsEdx9AWfGIZ0nW5/hxFJS4xT5sl6oXza4dVlb
 yATn3nc/OCvd6H9/fsB+pPLySSDGRyOsyvRHCdqwfKjkI=
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

On 10.04.24 14:19, Weizhao Ouyang wrote:
> Improve error message for UEFI SCT tests.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   lib/efi_loader/efi_variable.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 2951dc78c7..e6c1219a11 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -163,6 +163,7 @@ static efi_status_t efi_variable_authenticate(const =
u16 *variable,
>   		break;
>   	default:
>   		/* TODO: support private authenticated variables */
> +		ret =3D EFI_UNSUPPORTED;

This looks more adequate than EFI_SECURITY_VIOLATION. Thanks.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   		goto err;
>   	}
>

