Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B25D7831F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902D3890BC;
	Mon,  2 Dec 2024 14:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nctWMIKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595FE890BC; Mon,  2 Dec 2024 14:32:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4BE88FD2
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733146329; x=1733751129; i=xypron.glpk@gmx.de;
 bh=OCANU1gIakfCcFeiH2WkF4RDUEDpMOAgspsRR40MIwM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nctWMIKVlnnrl2Re+VkgLe8UJFcPNnkihJYEoJ0O23sCzcXQdDUs900brGYvLsHc
 CJGCb6aU9zcoxJqYG9FlwcraVnoWqaEMQEv8YZMNIc+HQUTVCdWUn5oELWySNk4zf
 aILmTPgN1Ht0o1ZRgfr6kdcWKrEP4Z8ujj0HzDf3m+vrZ1shEObs3B/CDM9bTbMy1
 Zev2Tnkq1RyjkZSbFhxfaJ37tZxXv6U8iJk/KS9gW8H9G3364tIFySnzST999oB6S
 sWYYc6TFz8lKSDwN/zaR4giKqxEPNXlYtqWvlAMHC7jxZXaWRmnhu9k8aW/tLR0Mo
 lZeUzM1GEufxeTDVQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1t1O3Y1pVN-00Ukdc; Mon, 02
 Dec 2024 14:32:09 +0100
Message-ID: <58f70517-8ed4-40df-ab36-7f5595ff1e71@gmx.de>
Date: Mon, 2 Dec 2024 14:31:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Fix the allocation of overlapping memory areas with
 !LMB_NONE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20241128114926.458728-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128114926.458728-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hl/rZMBc+CggFdKJxk7WgE8YiipRMq+hGaEBnFjQ9DmXfvHwt/C
 /mchbWQCJMc3oQOBRtPIjDmCQGtAog4/ePMit59sxhRkUmyoED6UrreDKUL5OlUcHFu6b0F
 +0I5if1zs4rWq7tpBCspM63XikFGWJo9Tmw6VUsmMJGUxFjRIQwhTyBtaa+TYacwOuivph3
 bcfQCsVn4SBI+L1o42/kw==
UI-OutboundReport: notjunk:1;M01:P0:ypMOr6QkQkQ=;ijeWvkekCEXsg8yk6DqAvwX9gig
 QlP5vDXv3mNS1RF/RqOV4+yoj7bFcf0oUZpabi+7/Et4x+uy9j7cQdqVjLTl4uKwyaP/P27T3
 6yT/yWyBjlLKVM3LnH2PxafaoaBzeJIhc2YoHydrviSFwXH+HoTuO1hun1UbFtOgJAQfDwEUP
 Yn+L4HBMVmcBik/tavKajHCxIN2CFnH/92NB1ElyDmxhTN9Bgp6mIUb6GJLctTZy405IlJK6A
 OTBpIdMeePs1wiFEhDgh1mGybxykpgQPgsm7Ah5FCzVeFKUz9CO0T0uOlrnb+ICbrgsmOGt8V
 JN1sUTaKCU9+3k7xzvY4yy0/sviHmsjoTg4ozPTSahmLKSVT/zoqhkcoqM712u9w4vafnbc8Y
 SQ84hHI8+IW7ogYzDQkQGHJpDnwMhlCEDLqIxtaMbXA2dqOjVntYOelm3NXYSa6R5jkRJrFRy
 F6yGyTd5eMaQphzV12VDGsoPHNS/OQoB55c4BM26dsDSH5eeTKZxKEqiYn5JGDv/UWdyVoRAv
 uCaXSjMkGTaJtkCr10v5qazYkwewDPhxH6Fx92Q7Ajc6MiuPdGEyShkdsxiFImwcxL8CDL+j/
 OzJBHYXWFH6Ndr+ZOxuGvYrH50F6mcmtDiNeA6WMzaaEiF1wPG5NFKQe4SBg+Vk8SuLj4siwW
 AFZYWD4DaldO4ulvPlxquR8Hf+z2IvV5DJvj3HDr1q5u3lW1B1r+q7SqWmvv/Pan+ELnO7enY
 mtNBCF5Y3M9rI6wSkR7EJA1bRDDgZ5rJhRoZW/QlHh3zJhk2/xarD55iE4PcmMA1XCuxQQgrB
 Fq5VJV+xFbTamMeYXuay8J8E68kdEalF5z0Vt0rA14cBBXqKzw7M3HfuFOE9rPvHakE1b7tpQ
 5P1UbkWMNAjK8x6ThJ0VNqidof5V6O0Yz+T5HVdSuQvksrVq5W8v3BuBBfzfCQUDiD1h8Zivg
 elDcUHD23wb0vjdNTvj8o+nFZQXYo0N/X5cx/bHFJrMEFbyGTHJSBvCHEKJEP80ZrCRmYSiqX
 JRkAvNCmq+wqDmnInzpRCNx5Pjx4o3UnEkoWZ6xfePGSmjlTC4qg+Hyuhf+bud9ZgzBAYPDFD
 8lFWgVIz3/sqN8Mi7QTHGapQfgntAJ
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

On 28.11.24 12:49, Ilias Apalodimas wrote:
> At the moment the LMB allocator will return 'success' immediately on two
> consecutive allocations if the second one is smaller and the flags match
> without resizing the reserved area.
>
> This is problematic for two reasons, first of all the new updated
> allocation won't update the size and we end up holding more memory than
> needed, but most importantly it breaks the EFI SCT tests since EFI
> now allocates via LMB.
>
> More specifically when EFI requests a specific address twice with the
> EFI_ALLOCATE_ADDRESS flag set, the first allocation will succeed and
> update the EFI memory map. Due to the LMB behavior the second allocation
> will also succeed but the address ranges are already in the EFI memory
> map due the first allocation. EFI will then fail to update the memory ma=
p,
> returning EFI_OUT_OF_RESOURCES instead of EFI_NOT_FOUND which break EFI
> conformance.
>
> So let's remove the fast check with is problematic anyway and leave LMB
> resize and calculate address properly. LMB will now
> - try to resize the reservations for LMB_NONE
> - return -1 if the memory is not LMB_NONE and already reserved
>
> The LMB code needs some cleanup in that part, but since we are close to
> 2025.01 do the easy fix and plan to refactor it later.
> Also update the dm tests with the new behavior.
>
> Fixes: commit 22f2c9ed9f53 ("efi: memory: use the LMB API's for allocati=
ng and freeing memory")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/lmb.c      |  9 ---------
>   test/lib/lmb.c | 22 +++++++++++++++++++++-
>   2 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 14b9b8466ff2..3a765c11bee6 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -201,15 +201,6 @@ static long lmb_add_region_flags(struct alist *lmb_=
rgn_lst, phys_addr_t base,
>   		phys_addr_t rgnbase =3D rgn[i].base;
>   		phys_size_t rgnsize =3D rgn[i].size;
>   		phys_size_t rgnflags =3D rgn[i].flags;
> -		phys_addr_t end =3D base + size - 1;
> -		phys_addr_t rgnend =3D rgnbase + rgnsize - 1;
> -		if (rgnbase <=3D base && end <=3D rgnend) {
> -			if (flags =3D=3D rgnflags)
> -				/* Already have this region, so we're done */
> -				return 0;
> -			else
> -				return -1; /* regions with new flags */
> -		}
>
>   		ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>   		if (ret > 0) {
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index c917115b7b66..bc44dd21192f 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -529,6 +529,26 @@ static int test_alloc_addr(struct unit_test_state *=
uts, const phys_addr_t ram)
>   	ret =3D lmb_add(ram, ram_size);
>   	ut_asserteq(ret, 0);
>
> +	/* Try to allocate a page twice */
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> +	ut_asserteq(b, alloc_addr_a);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(b, 0);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> +	ut_asserteq(b, alloc_addr_a);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x2000, LMB_NONE);
> +	ut_asserteq(b, alloc_addr_a);
> +	ret =3D lmb_free(alloc_addr_a, 0x2000);
> +	ut_asserteq(ret, 0);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(b, alloc_addr_a);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> +	ut_asserteq(b, 0);
> +	b =3D lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(b, 0);
> +	ret =3D lmb_free(alloc_addr_a, 0x1000);
> +	ut_asserteq(ret, 0);
> +
>   	/*  reserve 3 blocks */
>   	ret =3D lmb_reserve(alloc_addr_a, 0x10000);
>   	ut_asserteq(ret, 0);
> @@ -734,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state=
 *uts)
>
>   	/* reserve again, same flag */
>   	ret =3D lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> -	ut_asserteq(ret, 0);
> +	ut_asserteq(ret, 0xffffffff);

lmb_reserve_flags() should return a long value < 0 on failure. Why do
you expect 0xffffffff?

Best regards

Heinrich

>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>   		   0, 0, 0, 0);
>

