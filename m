Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1F2CA0ED1
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 05:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D33786E13;
	Wed, 13 Sep 2023 07:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gRIg2Lse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2413286E16; Wed, 13 Sep 2023 07:05:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B71086C47
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 07:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694581510; x=1695186310; i=xypron.glpk@gmx.de;
 bh=sP5938in6mGxqWxXvYpdRHdyctvzG1S6buxp/LcuOwU=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=gRIg2LsePGxdFpAwqmsdoSeP1pOg4KQ1HUnfNDmmyYjkjuHthYuIx9nr6BvRugCUeMoSdaV
 jT3y0tnG2L8uGzDpKUiTBk0+Lwms2A0NOU77onlCO0WuZDztYs+13ZeCwebjrjFMVZBCVxd+Q
 egkiQyqK4Ret2o1IE9dSKA1oOxe6pvRNgul7I4AoRXoy8vmuEBwXCkwuGREExpd6/tXfBh0gB
 cE20XBU0rLUVdFvGVh7Fpsgkj7Yi/NHAdiW0txr2BriUfKWZdLB7KMsHqTDxTwF5t3Wp5rZhk
 sgf9CyBdVhU+/mIzZet6C7Kz743JAfWe617rvX+qaZl8q4elsaaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1rIwGY17pU-00clNv; Wed, 13
 Sep 2023 07:05:10 +0200
Date: Wed, 13 Sep 2023 07:05:07 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Wu, Fei" <fei2.wu@intel.com>, rick@andestech.com, ycliang@andestech.com, 
 bmeng.cn@gmail.com, sjg@chromium.org, pali@kernel.org, u-boot@lists.denx.de,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
Subject: Re: [PATCH] riscv: enable multi-range memory layout
User-Agent: K-9 Mail for Android
In-Reply-To: <92e300b3-d4d5-4965-4ed4-ae3974fba279@intel.com>
References: <20230905100935.428120-1-fei2.wu@intel.com>
 <92e300b3-d4d5-4965-4ed4-ae3974fba279@intel.com>
Message-ID: <149987B6-0711-43D4-9CA8-15408D770681@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKC8lz8745Fieb2FnV/0otP7nPV1PYrGXBwiM4OQhPVwtUmx2mr
 WlEUj5t+YDUIgQ+kHX7zsVfmQ9WnWDE9VZGL+k28gLplcwRPyMdj35AKpyoavg+FDMToXpp
 VN4Crz4H0NUNqJYG/BndNEkqSwrOeW5glu/8OLFScv3LFERVdcwLIK4BuVJxp0qSi2YmJ7A
 JOgMOTzePWXn9tsGn+KEA==
UI-OutboundReport: notjunk:1;M01:P0:P/vwlHak68o=;hjftpiw263fnnClTqDzl0DxlIkH
 ppMHuKwlOA009K5hkdxafIOIOUGQZxLDdCenMHL+mp+UQJaB8z2XB9rgnNwIdGIdc5EgAJa1g
 Kb8YSXI0l52sfmLJVGDS3ARPN/8RvabCPbBMj53rvADavSUXlQUMFcaxtkRVLmsSMtdcGra4L
 CL33BF8OetMv8OVTSe+2A9CwlOTi92gFq8CRfgbUguQXqXcAalozg9g4oQDvBxeBcGvXQpcw4
 5jGJHmeIgNP4r4CYGUhbcP4tQABIAy6hKHU80k40FmDahqC98HY3lISKfw3PyYhPqk9DTDwVF
 plpRMwphJ/uEHtgtccEUtXhDvMDVNFhFDEh6DEkeWp8qL2WU8p3h7hA8AVg3GBoydCUtpeZCX
 c+a/2WtCrZAmKN0SBU61auJERpVFk9eDXwX/RKp4qDHDfq4/unG9tizOth67WVoRAIJl/OUMz
 nCF4M6+GlW4nrkVFWnryeXuqgTE4MIEbR2w0DG5OqXsGhgVaSwB63igsz4u0lb/6orBI/xGq0
 aAXzfy/7uMjk16LGjYWI4NVfMB38UiHUvZ+koffE0WnMFp3eka7ZxqrZCcrTIhnAWlD76qqjk
 0gXyFWupq/w0HuUzMTnm+TODdcg6y+06H86fFAMFDzjC9JHD3H+th9UI4y1fwnq6uVdB262XE
 KWSfnJJwsbItmRaFxuAmWQenBZF8u1SgNa4amL+aWW39aTJG6vtjatDfhUmHCyi6gxjDsMKSW
 Qh4BfHRpixq9I3OSoU0xfy1mVIAM4COq6IXogwkO2WAz3f48WPJHz9O8IeqCANHRwhCFtXQHs
 1ZYbNwvmYsKkkLgnclkCNofeNkZ6nuZvh8gm5QN0/gwbJXAHaaWu+lQI9lkN6HitygQme03Y7
 L4psO1nH0FGC6C7IsT1cAilxScyB+LjXvpo+QESI09rhi8rT4TOSPrNJCt5xFYyQoS50t1ekI
 aWHbJSSdvf5FSGUNgCp4kKo3pGE=
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



Am 13=2E September 2023 04:23:14 MESZ schrieb "Wu, Fei" <fei2=2Ewu@intel=
=2Ecom>:
>On 9/5/2023 6:09 PM, Fei Wu wrote:
>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>> range between 3GB and 4GB is reserved=2E Therefore if guest has 4GB ram=
,
>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>> board_get_usable_ram_top(), but that address is not backed by ram=2E Th=
is
>> patch selects the lowest range instead=2E
>>=20
>I think multi-range memory layout is a common requirement, PCIe
>passthrough happens to be the first one to require it=2E Could anyone
>please take a look at this patch and give your comments?
>
>Thanks,
>Fei=2E
>
>> Signed-off-by: Fei Wu <fei2=2Ewu@intel=2Ecom>
>> ---
>>  arch/riscv/cpu/generic/dram=2Ec        | 2 +-
>>  configs/qemu-riscv64_smode_defconfig | 2 +-

We should consider all riscv64 defconfigs=2E

Best regards

Heinrich

>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/riscv/cpu/generic/dram=2Ec b/arch/riscv/cpu/generic/d=
ram=2Ec
>> index 44e11bd56c=2E=2Efb53a57b4e 100644
>> --- a/arch/riscv/cpu/generic/dram=2Ec
>> +++ b/arch/riscv/cpu/generic/dram=2Ec
>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>> =20
>>  int dram_init(void)
>>  {
>> -	return fdtdec_setup_mem_size_base();
>> +	return fdtdec_setup_mem_size_base_lowest();
>>  }
>> =20
>>  int dram_init_banksize(void)
>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv6=
4_smode_defconfig
>> index 1d0f021ade=2E=2Ede08a49dab 100644
>> --- a/configs/qemu-riscv64_smode_defconfig
>> +++ b/configs/qemu-riscv64_smode_defconfig
>> @@ -1,6 +1,6 @@
>>  CONFIG_RISCV=3Dy
>>  CONFIG_SYS_MALLOC_LEN=3D0x800000
>> -CONFIG_NR_DRAM_BANKS=3D1
>> +CONFIG_NR_DRAM_BANKS=3D2
>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>  CONFIG_ENV_SIZE=3D0x20000
>
