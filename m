Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B726CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A558833F9;
	Fri, 12 Sep 2025 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fvRn4L4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0440183403; Fri, 12 Sep 2025 14:28:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E928B830A0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757680101; x=1758284901; i=xypron.glpk@gmx.de;
 bh=HDu+P7RzJ+EbpM19gq4nWK0wa08pynRq+WLVzQJuVso=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fvRn4L4GYTgcwQaVMW5FZ0hFBWKRobmCFkHJQz5DsnXtCtHNsADoTkDEvqN9bZDe
 wxTpo/nD9Zb6wA7WDRzdRzNoDLemTrofwRQSky46ix/+ohJ/Yt9jGKETq6Hm9hA9q
 eLCrPUWOT8o6PS5U+sZbs6+qvWmPpnmjINMfqgvUwF//ahSsRi4+RkyqotKi+IEN1
 tuSTaSM8xbf2vfMjEn4VKjytDOEShV5XcF2ykWif4zBM9XPtngevOB10gqNxcKBDL
 umstKTPm1jGXtuDZAPFV3239p3p7/JoaV7cLMXTW4+7qqJI76vQ+x1T/IXlYlZio/
 57um+onDAwkUA3Glzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1uG78R3jwx-00sdQT; Fri, 12
 Sep 2025 14:28:21 +0200
Message-ID: <f7cf5404-610b-420a-ae5a-a1d4cdb7ed4b@gmx.de>
Date: Fri, 12 Sep 2025 14:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 04/10] arm: armv8: invalidate dcache entries on
 dcache_enable
To: Anshul Dalal <anshuld@ti.com>
Cc: d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, trini@konsulko.com,
 nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de,
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com,
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20250912121618.1074054-1-anshuld@ti.com>
 <20250912121618.1074054-5-anshuld@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250912121618.1074054-5-anshuld@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KEeRNwTOs+CLQrtZWgWJISiTi5bchTyCj8pvGcShHFsEqpTBPuF
 gm0sPPngJb5L83Gj3g3bDx8raar589bJMeTuPB3yrALPqnfi+1fMklCGrbAGYPouORqT4n0
 xY4h/HavcoMSKTSCdLgdxdFz6X81va/jrt5/q/SO0COuV2YayuV/KWWhLlwiNqOXiJWs+6b
 s/OeJ2bZ+KsBKa1fwC/cw==
UI-OutboundReport: notjunk:1;M01:P0:/8qX5CpHJFQ=;TdJTmPz1jaDPqRA/xoZeKxwR/N6
 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
 5Wun8J4PGUgUsTJr6dA
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

On 9/12/25 14:16, Anshul Dalal wrote:
> In dcache_enable, currently the dcache entries are only invalidated when
> the MMU is not enabled. This causes issues when dcache_enable is called
> with the MMU already configured, in such cases the existing dcache
> entries are not flushed which might result in un-expected behavior.
>=20
> This patch invalidates the cache entries on every call of dcache_enable
> before enabling dcache (by setting CR_C). This makes dcache_enable
> behave similar to icache_enable as well.
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   arch/arm/cpu/armv8/cache_v8.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
> index 1c1e33bec24..6e662395a83 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -830,16 +830,15 @@ void flush_dcache_range(unsigned long start, unsig=
ned long stop)
>   void dcache_enable(void)
>   {
>   	/* The data cache is not active unless the mmu is enabled */
> -	if (!(get_sctlr() & CR_M)) {
> -		invalidate_dcache_all();
> -		__asm_invalidate_tlb_all();
> +	if (!mmu_status())

You are changing the logic here without describing why in the commit=20
message:

mmu_status() returns zero if CONFIG_SYS_ICACHE_OFF=3Dy.
Only for CONFIG_SYS_ICACHE_OFF=3Dn it calls get_sctlr().

Please, check if the logic change is intended.
Please, update the commit message.

Best regards

Heinrich

>   		mmu_setup();
> -	}
>  =20
>   	/* Set up page tables only once (it is done also by mmu_setup()) */
>   	if (!gd->arch.tlb_fillptr)
>   		setup_all_pgtables();
>  =20
> +	invalidate_dcache_all();
> +	__asm_invalidate_tlb_all();
>   	set_sctlr(get_sctlr() | CR_C);
>   }
>  =20

