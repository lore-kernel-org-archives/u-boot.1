Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82485C0219B
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 14:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C82889CD;
	Sat, 14 Sep 2024 16:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="srW7cKDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8F888549; Sat, 14 Sep 2024 16:31:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B9988A24
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 16:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726324287; x=1726929087; i=xypron.glpk@gmx.de;
 bh=YPRU1tYZqOxFY0O0RRwzp/WhBPjkHX13WM4er3zlo1g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=srW7cKDKIaYa0LxWFIkHpwyGVmF3Yctr7QCyIjGHWMRlLJxcp3Gg2Gt31M4fCXvr
 dLwR7pcNpOD1A3d999ekwHap8J0aVN4AfzUwTCGforTQ+RLEvXpQlIJzXz1ipoMkk
 QucSER2DK6ReyZOav4FhhgD06xLXFIwFDEIm7MB48Vk81QOWPlaeByVTA+dLS3DE8
 G8RuNbKFx3CrO9ZIzRGGTapA6qbb6OLiv48QZJx+wGx2txHAaBvmXpq1uOFWSjxSH
 dJHG4HQwztB7y42uO3ySz5HtazhrKBprMI+W0h5/1XdbcVR5OxG6z+lAt8Mv7S1fq
 T6RbTQWBGa7+l9W/ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1rzQcE1zWX-010rgt; Sat, 14
 Sep 2024 16:31:27 +0200
Message-ID: <6dec397c-f7b2-4bb0-9e52-c13b97dd5025@gmx.de>
Date: Sat, 14 Sep 2024 16:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] lmb: add versions of the lmb API with flags
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtzxyS/JAtG4/SaTlPxdEsPOcPozmnYycyJCFhT6hZ/A7NgPyUa
 HuPS5K8DTzYfaXpdivYtTUDttYwTfmE8cKjv456DX8DayZo7E0Nl5vpKDKwE7acl3bQAG1l
 DnBMxTUDgmKN0yaBTlo497jZ0BXAA2sMi/fH42hJ0xcy8MUk1I0LZXIvwkcHPNZYeVozLLt
 Vf/FM78mudjD4/DoW4/7Q==
UI-OutboundReport: notjunk:1;M01:P0:SvAXOD4lDNw=;rKzE8gp6HtHP6OW8esPHajQVhxc
 5dBxh1OoCTxl9AtfZrYSIZ4Eial+MiIXBSYdpHUFERq36dzgrN+NzShOmk0vj5Qo1hwMwHCz/
 1ez2/wVgtz+cgiI7pomk4001ePKK4zEqiWd8c7VKP29B/hD+UlPVQFrKJO/2P2O+SkRfaHk28
 79ix/cJy5BpmQFbry34L+VkWbYGy4hz2NabI9NbABS8Cob830m9xeBE/adIMsLZh1ax0e1gj7
 6hjfPu6HBUjG4X+wek4LW2bAiuswi2W+kTproWxrI95tJaVNjK1z0Um+0dFxZqZWdZulC56sd
 9O1jcinZPXAc0Venny/u4ut1F7Giq/zjwQyv7zNtmKsxSksJyAnjgW+KmBUNFbkhOxr7T01sU
 McTr71AORUfv+8vMrnTRoEDSzT960U0iLmM+9PmY8734dp0jEGd9j0ZIx3Y+/qJMPWR/LHkZ7
 QJyG2bNdwnACvV4iZoFAvFu7Pa/bfGS/fuENOpuMnIq/r/QPcGH7NO7dqFP0cjqUqJXr6Lrjk
 /4D7A2DCV+568f1Qd5TpWFCFG10SPZlYSSBGfwYDGGm2tRUEQJKvMXmpQzCfjOuJMgVBa1vYs
 xnZtR+b2GTZV5W8zw7mCk63Jli41oC/TnLPVld56UUxunaPugm+YgSu1jd4CePtv1Hat7jHEV
 f2HbLMC4kgMo4wA0ZjzA5nACsPz9zT1rOW+1VAY+bCJM92DiSi1W+TqGECi5FmsjQdRVv5Vo6
 si+fU5HA9hdfRkYxl0TGjWU4xBclCa8+iN4Dievfug2BmN8DDSPk9xr3G4BsHSqe/Q0/+ASiY
 M2Rvuoz9wXdGRbrX+uTd4SYA==
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

On 9/5/24 10:27, Sughosh Ganu wrote:
> The LMB module is to be used as a backend for allocating and freeing
> up memory requested from other modules like EFI. These memory requests
> are different from the typical LMB reservations in that memory
> required by the EFI module cannot be overwritten, or re-requested. Add
> versions of the LMB API functions with flags for allocating and
> freeing up memory. The caller can then use these API's for specifying
> the type of memory that is required. For now, these functions will be
> used by the EFI memory module.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/lmb.h |  6 ++++++
>   lib/lmb.c     | 39 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index fc2daaa7bf..45a06c3b99 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -86,8 +86,13 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
>   long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
>   		       enum lmb_flags flags);
>   phys_addr_t lmb_alloc(phys_size_t size, ulong align);
> +phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);

Please, provide Sphinx style function descriptions for the functions
that you are adding or changing.

Cf.
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-=
documentation

Best regards

Heinrich

>   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t =
max_addr);
> +phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> +				 phys_addr_t max_addr, uint flags);
>   phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
> +phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> +				 uint flags);
>   phys_size_t lmb_get_free_size(phys_addr_t addr);
>
>   /**
> @@ -103,6 +108,7 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
>   int lmb_is_reserved_flags(phys_addr_t addr, int flags);
>
>   long lmb_free(phys_addr_t base, phys_size_t size);
> +long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
>
>   void lmb_dump_all(void);
>   void lmb_dump_all_force(void);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 3ed570fb29..da6a1595cc 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -479,7 +479,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>   	return lmb_add_region(lmb_rgn_lst, base, size);
>   }
>
> -long lmb_free(phys_addr_t base, phys_size_t size)
> +static long __lmb_free(phys_addr_t base, phys_size_t size)
>   {
>   	struct lmb_region *rgn;
>   	struct alist *lmb_rgn_lst =3D &lmb.used_mem;
> @@ -530,6 +530,17 @@ long lmb_free(phys_addr_t base, phys_size_t size)
>   				    rgn[i].flags);
>   }
>
> +long lmb_free(phys_addr_t base, phys_size_t size)
> +{
> +	return __lmb_free(base, size);
> +}
> +
> +long lmb_free_flags(phys_addr_t base, phys_size_t size,
> +		    __always_unused uint flags)
> +{
> +	return __lmb_free(base, size);
> +}
> +
>   long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_fl=
ags flags)
>   {
>   	struct alist *lmb_rgn_lst =3D &lmb.used_mem;
> @@ -613,6 +624,12 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align=
)
>   	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
>   }
>
> +phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
> +{
> +	return __lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
> +				flags);
> +}
> +
>   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t =
max_addr)
>   {
>   	phys_addr_t alloc;
> @@ -626,6 +643,20 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong =
align, phys_addr_t max_addr)
>   	return alloc;
>   }
>
> +phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> +				 phys_addr_t max_addr, uint flags)
> +{
> +	phys_addr_t alloc;
> +
> +	alloc =3D __lmb_alloc_base(size, align, max_addr, flags);
> +
> +	if (alloc =3D=3D 0)
> +		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> +		       (ulong)size, (ulong)max_addr);
> +
> +	return alloc;
> +}
> +
>   static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size=
,
>   				    enum lmb_flags flags)
>   {
> @@ -660,6 +691,12 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_s=
ize_t size)
>   	return __lmb_alloc_addr(base, size, LMB_NONE);
>   }
>
> +phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> +				 uint flags)
> +{
> +	return __lmb_alloc_addr(base, size, flags);
> +}
> +
>   /* Return number of bytes from a given address that are free */
>   phys_size_t lmb_get_free_size(phys_addr_t addr)
>   {

