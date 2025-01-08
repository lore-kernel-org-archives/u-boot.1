Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E774E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 11:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8DE8006D;
	Wed,  8 Jan 2025 12:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="me+RJcQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54B2800DF; Wed,  8 Jan 2025 12:21:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D209F80040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 12:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736335284; x=1736940084; i=xypron.glpk@gmx.de;
 bh=ATtsuVDTlXyGiAyxNZVBqnzSXIp0UG+exP5Jyn782KY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=me+RJcQeOvDNaqNVoqzhCVDqCwQksYaw9OsSGutXHRhmVTW4OVJNA8YTovObB/4P
 3SjwkHMkjqhVTNgOAL+gIzH7XKO66qy0VSaOmDloKyrZn3HbK8XsdFmTZIzhlaVl6
 htp/E7S14ExvRcA2hEbFlxZi9OzVsww1ucE+Yjm32/bZhCpowbpdmEBUV75JQlZqg
 vp06YtII5Na3rA1kZMnkOxKHQ4aRhJ1qPKoAKZeDp9grC9TL8wf7xIYXqRsmmiPPI
 jBRHA0bvgmZ+UdfC00Cq8h/HzLNHCzd3oIXhPACckxip2jwMV1jAOpAh3vAgwa9XF
 Nls8t1jUaiPBHTtYAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1t4DpO45h7-00JVCX; Wed, 08
 Jan 2025 12:21:24 +0100
Date: Wed, 08 Jan 2025 12:21:18 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Yixun Lan <dlan@gentoo.org>, Huan Zhou <me@per1cycle.org>
CC: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
User-Agent: Thunderbird for Android
In-Reply-To: <20250108111105-GYA3276837@gentoo>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
Message-ID: <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1kW3VxqSqPYXVRG1oxRUqTy9MEUaZS6mE7H9syOJD4mZ5WovWTj
 IJecsakAHbMyWE9jfsx3+lfEZM7JeYQGEIeQhEgin+ZBykGmazyPFeKCLYtUMQioImQBY3p
 oGXJyat4Xdpv6ghAw3mDpErZocskgODcoeIx0MZ8hjxmtiRibA7AUEG4GrCvisramr0k4ki
 Ot+YIBqi7pOC+YOQ3yDkQ==
UI-OutboundReport: notjunk:1;M01:P0:n6GgdZaTUZk=;ZffvfDzb2LHll+GjZAgbAKlDhjS
 sicHTww96zDyas9rVAMRc+5L/Plg+Ttl9sZgctAA+hXsYb5D6YdlKpyj1FiJg41jnbyi+PYRV
 pQ+niYfKL41eFAeVzkXIHXJuWb7xaFZBA8MXZIpjkbR4MQi0+Ges+x1rmuk4hJvfRo9rl8s3O
 0ngMjOjVGstou5LeARcgHXLZs3a7yQ82E1qX1/oZXQCjRTRDgwpp1qcHl3o2jigE6xkGfk57U
 2Q+nQCJRBT0jXSMreBCvfHQtmqhBPtTf/O75j6jkk290r+D0k07dT9adCypLkMmWDYUki8Bta
 MqlRWkxUVmlDZPMigUIMVd+6D+RgQh8iyg1Uv44cK6OGqTbCB3HxmCKZq2T5qpllTtR0mOmBZ
 48Rtp4cOpm6SjLc/9UcsJsZOVyqnKVkGFDi5ZOeQjcs8eAEF0EsTTaSZlWKFFOaM7aekgSZ6d
 aNaVbkbLyQTdG6nIzJOaO6N3eNG2QwO47Fw57fOsuM6p/Q2IG/CYbzKO1ZaZrqtzEL0RVhvUf
 BdmpVnYbjiUGQyPQHBLb2CXUgaDHqby0lKzUbCe2IfVNMLZ7auxml00u1+6sK0rtlpquZHx+o
 wV0aRZro8cMVyLhqQrv1RFPiejXaprvS7a2e7Hra5PnTWAsIHiQJtNVyQwxsfFwZ48tEDyPtN
 N54j9lH32ZzEctXwDTNEZUbQ+y9j8B3095sLz1NlXClDE4UBVRnPBDkjPeXsQL8KOOwO78Who
 devM1ybWRAn2KUWtUx2ommDA71hvQCVv2w06s1vgk5JKPMZJges0JviTXJIc6VP+qtz4jyiW5
 5UE1DCakmXfvCQq8CPJxqbP9Fok4OOZkVL+u41eqZEh5jhT+3lL8rCcwfH8oV06kfBe13SkVg
 XYRdayahzOKVHDfs1OB6e2bA5DAngvJCQVkE1YHlGl+m7t4M78IZy+Nr6mW/5bm0GNCHXp6ge
 UmZx0UuhrJ4CfxzGGDP305Spz4z9zk4FNv+87bk/yLybh11zAha1vFy1SGKkQXScP5Bj3VPwE
 7ebjgMz0GxvXcYOqkKxsxG1ORLiHerRNOrt7hvOEptsiHh6GputPSX5jgNAK9d875GzUX6x+b
 CAOKxe5frsyL1FnGlvXDN8RpZl8jXU
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

Am 8=2E Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo=2Eorg>:
>Hi Huan:
>
>On 16:49 Wed 08 Jan     , Huan Zhou wrote:
>>=20
>>=20
>=2E=2E
>> ---
>remove above "---"? otherwise following commit message will be
>dropped during patch application=2E=2E
>
>> This patch introduce improvement for get dram size on bananapi BPI-F3,
>> retrieving the dram size dynamically=2E
>> Have tested on bananapi BPIF3 4G and jupiter 8G=2E
>>=20
>> Signed-off-by: Huan Zhou <me@per1cycle=2Eorg>
>> ---
>>  arch/riscv/cpu/k1/dram=2Ec | 40 ++++++++++++++++++++++++++++++++++++++=
--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/riscv/cpu/k1/dram=2Ec b/arch/riscv/cpu/k1/dram=2Ec
>> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7=2E=2E095217f2a4c053f7477=
d62c0776bcb51e623db47 100644
>> --- a/arch/riscv/cpu/k1/dram=2Ec
>> +++ b/arch/riscv/cpu/k1/dram=2Ec
>> @@ -4,17 +4,53 @@
>>   */
>> =20
>>  #include <asm/global_data=2Eh>
>> +#include <asm/io=2Eh>
>>  #include <config=2Eh>
>> +#include <bitfield=2Eh>
>>  #include <fdt_support=2Eh>
>>  #include <linux/sizes=2Eh>
>> =20
>> +#define DDR_BASE 0xC0000000
>>  DECLARE_GLOBAL_DATA_PTR;
>> =20
>> +static inline u32 map_format_size(u32 val)
>> +{
>> +	u32 tmp;
>> +
>> +	if (val & 0x1 =3D=3D 0)
>please add brackets explicitly, something like
>	if ((val & 0x1) =3D=3D 0)

We tend to avoid =3D=3D 0 in U-Boot

if (val & BIT(0))

>
>> +		return 0;
>> +
>> +	tmp =3D bitfield_extract(val, 16, 5);
>> +	switch (tmp) {
>> +	case 0xd:
>> +		return 512;
>> +	case 0xe:
>> +		return 1024;
>> +	case 0xf:
>> +		return 2048;
>> +	case 0x10:
>> +		return 4096;
>> +	case 0x11:
>> +		return 8192;
>> +	default:
>> +		pr_info("Invalid DRAM density %x\n", val);
>> +		return 0;
>> +	}
>> +}
>> +
>> +u32 ddr_get_density(void)
>> +{
>> +	u32 cs0_size =3D map_format_size(readl((void *)DDR_BASE + 0x200));
>> +	u32 cs1_size =3D map_format_size(readl((void *)DDR_BASE + 0x208));
>> +	u32 ddr_size =3D cs0_size + cs1_size;
>> +
>> +	return ddr_size;
>> +}
>> +
>>  int dram_init(void)
>>  {
>>  	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
>> -	/* TODO get ram size from ddr controller */
>> -	gd->ram_size =3D SZ_4G;
>> +	gd->ram_size =3D (u64)ddr_get_density() * SZ_1M;

This is C and not C++=2E We don't need a cast to assign here=2E

Best regards

Heinrich

>while using cast, why not define ddr_get_density() return as same type?
>also it's more reasonable to use phys_size_t as I checked gd_t
>
>>  	return 0;
>>  }
>> =20
>>=20
>> ---
>> base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
>> change-id: 20250108-get-dram-size-65cf59a15201
>>=20
>> Best regards,
>> --=20
>> Huan Zhou <me@per1cycle=2Eorg>
>>=20
>

