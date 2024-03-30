Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65FC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 01:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F448807F;
	Sat, 30 Mar 2024 02:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Bd4Uiohr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326FA88258; Sat, 30 Mar 2024 02:51:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8759687D57
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 02:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711763465; x=1712368265; i=xypron.glpk@gmx.de;
 bh=QoOEqkZ34mDEjbpwdSjcBzhKD2mzpFSfd/Xt60YQyC0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Bd4UiohrL62z2kVzWM8ho6kq0NbutAhVeM/UW0pWkjyh9I+2nDWItJwLh9Ges71W
 m+sHNXPBCr4vg6hYaTzIpu9649+4MeSD/SUanGbE96AlAicoJc221mS8gLUTmaOnv
 1QTg134n+IH/EHvGgqsYpdWbq1RzFZKlsDt7SEAu2Kqgur+VQdx77nrJn1ShjU7WP
 xUdb4tF8G7/9xx2S1L5GrGa1JEY0Q0B5EMvkm9xqb3qDf05f/YNdJwGfbZV7s6+CA
 mH4FXYy8CwXXQdroRQv70i0KXixwcfJX6DTB6WSGs4l27hn4QH44ZaeSY6SjyF8rH
 lGrCcQSFOWmJXagPGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1s8klg0PC1-00LHwW; Sat, 30
 Mar 2024 02:51:05 +0100
Message-ID: <f832d60c-81fb-4ccd-87cd-aa9fd56ad93b@gmx.de>
Date: Sat, 30 Mar 2024 02:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: Fix fdt_pack_reg() on 64-bit platforms
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: David Virag <virag.david003@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20240330005553.30869-1-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240330005553.30869-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kpe0wvLo1+kRSVU9qg5N/EpmTdprzMxE299jYvOMZJUr8nm38fr
 3iXfdL/3+udHM63EJN1lA1KJ2GrYDgvSQMRp+c+9yp9CqX5ll2AfnsFmJEBZ3VDYLEu/f2L
 Rfyi+XhRNBbIU0CHxWFhrd2pEeVwQp5anhbI0KJKzDSmd4m3AWnCjmw34rFVbPlm0ZGh2yf
 NWG5FeDvYUp29h/dbSzYA==
UI-OutboundReport: notjunk:1;M01:P0:r2EAKLaeQZ0=;q1iuQ3xx1x7/B3dS/YgHNGYXz6B
 xzh625V3P8S9+UgqqEGiqe8gXNI0lbmDmtNRQ4R26BlUb9rFa/XJyCIdvjBG6mTgdEuUFyw+B
 Isck1zDh27lzykqHvdNRaojrxCY5R9EF95lRvZAg01G0nudNToVJmtq08u8GOE/OnuLK9fBmN
 wF1YDPtCDv31nxGhP64Z77yJzcOOnon9Fsr4lOblMJ/y17YslMScZDgBGmwgMF7nZbHbWqe5r
 erLlhWkCyRa2jXCEnzZn0oOHbYpjHuPpDPuDsMAPtKe3k6WkThFGBHIIqf/03RS5Mf2DHEkK3
 SDn4222OkfzseSZkX5/AudDPu+BGbRKiGoGYtPwZsQO3380emaZ21w+T3C/1byXdaWeeAHleR
 YYtNPUq17N6JFUEyfMbOgNbhbk7xdy3hwVuxevsRib6WmqXW0KuhH4kwxwxJpm0pcKMK3l4L7
 tEhzslN5auG8upsqHX2pu0icVw/kDWv+RiT6XXGYkoAgaGLu/iPTUQivAiOla0KdUvnXOKjPn
 vJcj19PXKCcRJn8Dvik9icWs0PFG9/iQOM2jt4SOsrxVI4AGq+Len7CP3nAGo/9n0oYLUlk7g
 DQnL4Afo/Fx2MpeYhn7ruu0J+x4GhwsLLYs37pg2yg5x6go3VkmOgqTWDfzRQ9KGPh98QOyit
 WxB2K+cctEzjY0S9VUfoRmVF3JXKP0hQFuOCRZN75X+xWMnUGlVsoBjbaynauN8HJXm0IjCrc
 MUMM8NYNZmLZh/SIaZJHZ7RWmj/aM9aF5knaflI7D8Wt76rwG8+PO5ORa7KJNguJx4OA+c2Gf
 xWVNnnudEl4iMfDIOF04kYs1XAtLY/xQUYmjglRs8621o=
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

On 3/30/24 01:55, Sam Protsenko wrote:
> When "memory" node is being processed in fdt_pack_reg() on ARM64
> platforms, an unaligned bus access might happen, which leads to
> "synchronous abort" CPU exception. Consider next dts example:
>
>      / {
>          #address-cells =3D <2>;
>          #size-cells =3D <1>;
>
>          memory@80000000 {
>              device_type =3D "memory";
>              reg =3D <0x0 0x80000000 0x3ab00000>,
>                    <0x0 0xc0000000 0x40000000>,
>                    <0x8 0x80000000 0x80000000>;
>          };
>      };
>
> After fdt_pack_reg() reads the first addr/size entry from such memory
> node, the "p" pointer becomes 12 bytes shifted from its original value
> (8 bytes for two address cells + 4 bytes for one size cell). So now it's
> not 64-bit aligned, and an attempt to do 64-bit bus access to that
> address will cause an abort like this:
>
>      "Synchronous Abort" handler, esr 0x96000021, far 0xba235efc
>
> This issue was originally reported by David Virag [1] who observed it
> happening on Samsung Exynos7885 SoC (ARM64), and later the same issue
> was observed on Samsung Exynos850 (ARM64).
>
> Fix the issue by using put_unaligned_be64() helper, which takes care of
> possible unaligned 64-bit accesses. That solution was proposed by Simon
> Glass in the original thread [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2023-July/522074.html
>
> Fixes: 739a01ed8e02 ("fdt_support: fix an endian bug of fdt_fixup_memory=
_banks")
> Suggested-by: Simon Glass <sjg@google.com>
> Reported-by: David Virag <virag.david003@gmail.com>
> Closes: https://lists.denx.de/pipermail/u-boot/2023-July/522074.html
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   boot/fdt_support.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 090d82ee80a5..9844c70be806 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -17,6 +17,7 @@
>   #include <linux/ctype.h>
>   #include <linux/types.h>
>   #include <asm/global_data.h>
> +#include <asm/unaligned.h>
>   #include <linux/libfdt.h>
>   #include <fdt_support.h>
>   #include <exports.h>
> @@ -421,13 +422,13 @@ static int fdt_pack_reg(const void *fdt, void *buf=
, u64 *address, u64 *size,
>
>   	for (i =3D 0; i < n; i++) {
>   		if (address_cells =3D=3D 2)
> -			*(fdt64_t *)p =3D cpu_to_fdt64(address[i]);
> +			put_unaligned_be64(address[i], p);
>   		else
>   			*(fdt32_t *)p =3D cpu_to_fdt32(address[i]);
>   		p +=3D 4 * address_cells;
>
>   		if (size_cells =3D=3D 2)
> -			*(fdt64_t *)p =3D cpu_to_fdt64(size[i]);
> +			put_unaligned_be64(size[i], p);
>   		else
>   			*(fdt32_t *)p =3D cpu_to_fdt32(size[i]);
>   		p +=3D 4 * size_cells;

