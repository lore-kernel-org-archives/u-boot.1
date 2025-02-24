Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99AAC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 08:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E65D80079;
	Mon, 24 Feb 2025 09:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="csiHsnNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60414805C4; Mon, 24 Feb 2025 09:59:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D8E80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740387584; x=1740992384; i=xypron.glpk@gmx.de;
 bh=0IzGb5Zh17nZI+D0qSUSF63/M3js62vF2r1caKCLKeo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=csiHsnNb770N8Mg2sSySuDJGcFrtiwAuVpIijkWcpPgLldqPBGavgo0vLzfiEAFX
 9sDmzAgbbvsIqDTEHs8K47aD2UMruW5A1RPFDZZqbmK5zmimJG+YdX6GwoiZ/XnBg
 aFa5vO9+fWZb6VE0lppipnSN+HnWmzzBxFKU6gcSnsfmbkFRXtBgT6XTt8SLWScln
 RUEmeQWRgmbtYtRuCwYnSBVBnmk80zR7NKyfCuIoPXBPUB6saYCNT/6Y/fJnnfFIc
 vA5aOc3lzx0dmAP2AjzqfeO/BQyvh/WYUqWy14lvlinUySYzdrzdKwWpwoV01AU3u
 tumwmmHHRjHPBLm6qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1trSMX3lS6-00IMJn; Mon, 24
 Feb 2025 09:59:44 +0100
Message-ID: <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
Date: Mon, 24 Feb 2025 09:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] spl: Align FDT load address
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-11-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-11-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ToslBfWVTddAo2t6tZjEAhyq5f7FdV+6lLt2SI2OcNnj/I2G7Rg
 shTdGGD5P5yrE7N92eYChs0zRUVpdPgKFwWILa3ItJsLgUPItGuAhdF+i5rCpkdZcKk95LK
 747dlaM6BfbySGRotm182pcQ2nZ/om2lULLimbMXfewqJiHksTG3IemeITbJkVNnvrYSIGM
 ObGl8VDQqvUi6WFJ15PbQ==
UI-OutboundReport: notjunk:1;M01:P0:lc4tt3st8fs=;/8wk4luKxVla3/HJjkkrYcVx2lY
 ZQlmkRiPhJdc13TprN4qGfvPSGXRHTte1PKVQT1vdM/c6IG5ZUe0oirPoaZ2vGjRRTJWFG7LR
 foLnIVJK9fRrOBG7SwEnXHp35TDrMVvlBgAM4UFCrsB5M+9o2ax9XAjvRUvZRQG5Iapkmicue
 KLojs1BxD0x/BtOoBsHzry1+GZuQ8gjnMhlNjoDcN+1z40igHwLatkzpp10WpJxuYL7IF2kim
 Y7qoK07Dj+X8m87EhMquz8O4sFsp4x6Y2O9P1snwGlb2HkPreS26GLBTG6gDgcRzXQ6VokBGf
 II36/EiFDbEqigi0ldHIJbzXdtOZjLtj5sPJ20vIIFdROnP7J+0Dr7DBcIkc0BuU/QWdYrtvA
 BX2zSMwCC1VaM1L98fBI0yc8w6v7557L/YRZSgOk8M5I7fF/C1MFgi3axMviuFqjo0C+tOCHt
 hJYEGTHR8UvRIrUserVgkOOynhbUpKuXpzygnGI2A/0hQd6YUoJyWb87wov15Et4YjAZ9Aj8g
 v5Dt+wt0ADbW/4SIv0TsBJxt89I81amrqgxVGhNRFvPSmpVPVJOoUtuGWSguBMgxKd93bXFc/
 5fgk3EfZLD6HbA6lPOfiSwDhgL1IIy0G9ZjGUPEyV4TStG4AL9w5re49Wg7Bzmsc631GMDTG3
 clVzOcSz3V8I7tXeq/mN/kSmlZNeTkeC9yRYap1x/hJm8Rj5b+xQFIL5WUEjLIUxLlRtFnFRk
 +UFqFgS5RsKSRCUH4ON5CtlABijKsBGjh94C/Thf3bMMoMgan4vRprXT7cln+Rl6mhfhvS2CV
 hDIJvHL6fqwQTAKsZ3sFdB+GZw14TTD8UKuyZYHVg/T/wXusd/jO+vwvH9BpdZyre1MnmdPqN
 fl/cUjkOi137R+P60KfqlHUNdULL8GH6DnXeSC/lgt8GegAmn7Rfe3rpz2itndTc4o2DA/Ytx
 htkE4TXKZNBJDpBMNynrDR/uYMYWNIlGJyD963wi9S/PfNMU+6YSO9MXxn3OKqloE4g4HxJw6
 p+FajNmn6ph4xj46rg1fEoS4LtsJHJ6Po0EZfsZ3m2LGGcnCbW4nOd5ulw+777NEpyIFx3Fnh
 R0Bpmr9ELuXF2yBK9Rr4giAkSyFCp8CJx+JqGf7KS0wBXght9DNH6GvcehPM1PNozFRI9pQ53
 nAYRgyc27x3bADA0itb1/ZEwYlh6W9+JTPeavljl1EpeNoypZV7yATum4xDiHkgHdax2+w8rU
 bLPxRe7MIw/SqDvY1C7eDMIaIMekBjtXM8UJ+883fBDFv5d19YjitiBiAP5ry63zofv4VmD3o
 +FNWmKYCsWdvY/1vQESJ9TjqO11Qzih9/7KXRSGX7h7IbaNVIrBhwhVxnrZiapyF6WS0GXStb
 qrpA1k5j59LwJg/sKjmbQuz6s3nLYBoFdxK/VUO0nYMUFPbVOaNMOLUvbo
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

On 2/24/25 06:55, Sam Edwards wrote:
> While the image size is generally a multiple of 8 bytes, this is not
> actually guaranteed; some linkers (like LLD) may shave a few bytes off
> of the end of output sections if there are no content bytes there. Since
> libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
> explicit about the alignment when loading the FDT.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   common/spl/spl_fit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 49b4df60560..86506d6905c 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_info =
*spl_image,
>   	 * Use the address following the image as target address for the
>   	 * device tree.
>   	 */
> -	image_info.load_addr =3D spl_image->load_addr + spl_image->size;
> +	image_info.load_addr =3D ALIGN(spl_image->load_addr + spl_image->size,=
 8);

We want to keep the SPL code size as small as possible as on many
platforms it is restricted to the cache size.

Can't we fix this linker issue in the linker script by properly aligning
the SPL image end address?

Best regards

Heinrich

>
>   	/* Figure out which device tree the board wants to use */
>   	node =3D spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);

