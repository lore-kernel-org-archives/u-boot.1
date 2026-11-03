Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3A606D816
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IRGFrRSl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ITdYgr2W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF3296077D;
	Tue,  3 Nov 2026 14:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RlMIY2CLzo-y; Tue,  3 Nov 2026 14:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9406606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793714776;
	b=LeFdhrHaIaJW39eSJW9YB8RjpivtqJl/6A9GB4Qw3Foa5EUuZR8KtzQ8cKaVnHqQDiF9
	 y7NkG9peU1AS0724JQAhxj6QAsHXLU8xcqnYVr+rV3lMDJ+JycC8SVqWoyU2enmmOJynF
	 dNySVQB4WcPxdCe0VqrBjv+IbdhnDJyg80Xupn3w6S1vyJKnMEEFAB3TFF+ubezYjz5jY
	 VKiX0nBDZ+7ws9+2LsiGJEjYrVv3eUcVeOlb66TtvQZg2SfXVqaQZjCzr47j+grlmqi/G
	 HEF9FUElOXWT3NCwbMeUxobT4/WPluEj6J47JvDHnvjqkUvDMzrFjRpo4kQCpPlz4pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uqniUnIUbndOBICF0KfXhdVDUb9/iHWWisCuAq2Dn1E=;
	b=R4I74/6oiuWMFS4CETquM5FlQvCsDfTnUAKk4SNfRNAlxtRqse07KoYacIHKEZiiu4js
	 /DV1xaT7snchewEzA/wyzeFWoFnG5b9vb9VkJIG3QGMajb9rtbcxiP+vyMapf+yR8UoLP
	 JjucTC6ZIlgKzkSk+J9f8S1+UQW/rVuBqJIwCwVMlYLVykRUlsnhc3JQ5/96QjiyazoRL
	 djm3yOiZao6F9178+DFru8+8puBWbdx7aCa7BAXNdIu03X9IsWS13DZoTK8TNdxuaa/P7
	 K7+XXlnc0Or0bTUcR5RECLvrPY3jdQ1ZzAcMD9tkT9kYQaJgkdnOqR+JAwa9MsStC9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793714776;
	bh=uqniUnIUbndOBICF0KfXhdVDUb9/iHWWisCuAq2Dn1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRGFrRSls4s6za8du/pv3QhjZRBWAGl7EB0+/d0SJKtIgOKZc4VMliZ/9dWO0w1X+
	 zIJYLVMcpaZ0dDK0gf2GYTdp0EBoT7XC5cESrAJGHLTL0aG24jL4VgKEIOpdfVIvRN
	 nMu3YZWXhm1f1lqi+3cpnMYS+UflqPBt2QNTExQUVcCM5qa0+1qxBIZh/9lFPC7EMi
	 1yQvpiTCgUsHrw25EkfwOcxqu1eVNf54UlSebDYcUimQca7+Ym+KI37rQ8KPuI4MDe
	 aXhWiwvQT5CgepFuIi9LzAr0dcTlXz7Z8a2mRfpkNI5oamgz4w/ZMmdBgxx7RsCXaD
	 qEVb8CTPJmDrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9406606DE;
	Tue,  3 Nov 2026 14:06:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8091DD3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7109C40070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-2D81N2I-ul for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 53B5840068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793714774;
 b=K1QgaLIb/blXZSdQPW9F+XMHShmucnNwfLO3Hntwoi7XiZRmP98d2wisbEFzfsTjoBUm
 fifLyBlKRryqYTuwesqI33srsee5CU0oFjHemVly/7vqQ6Y3Y55FKvY3LJxHQzJfuho0Z
 RjgsIezd5ii8Tmn7/1vM0au9KMo0PDaAQzB46YBM0U28bAVcexyRd+BQC78tURFYyvp1I
 fibwVnOvhd33+ftDl6N/u3QQr5PAe60wcqzEvkzmpjXnUAPs78lcnqGXRjYLqaCJTAqCj
 /yISSSTkQTYMVdjGWeeoPbBh8O/fWRWYtBrZUnu5/8/H0xfohyYJQAknp8QeAKh5FcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793714774;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=uqniUnIUbndOBICF0KfXhdVDUb9/iHWWisCuAq2Dn1E=;
 b=s3YEiYNuI/xhXBIrySiDu8vEVuaDNpCzsoZr5gx04HO3yZR80qrSs9TDhEBZjOaW2Vj/
 ltdZiOqiPeyKrCw0jc19TBXBEmM7TsLZ/dwX6fVNFTVeondOjPK8wvXW/Z/zAUw06xynp
 c7pCtiHTVLs1E+oFJaM8Lh/CgN9xeAC+SuHWvwXBuPmbIUw4EVPZM/IRbPXm4BFIh0Onz
 0pDoaoEE2rcAgf70Z8IbQn1WaujfAb4qBVqsDCDoDNA+pOxAkxHCB1YWmVEYnE3JWv1P5
 V6UrrnMl5gbSjJTSpZwz6eIR+K/yzIv3hutK0elqqwYc1Ed4RCuPi7/Q7BrzMqPIAig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ITdYgr2W; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=ITdYgr2W
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53B5840068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:06:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B91091595;
 Tue,  3 Nov 2026 06:06:07 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2488D3F628; Tue,  3 Nov 2026 06:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793714770; bh=Rf592qWGUsApGrwAJoLFrw2uir45bEWc/Owff29Quhg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ITdYgr2WhcK52qaqeEqqetq6sblbBkcMaqSx04LEl391B9U36LoFtmG51TIOYDU0f
 trjdoF7lW+nfMy4DJZYrOtZEGhAD3WyQT8UmoBUe4gd190f1msjDwRxV721qmeBgTH
 GybojNOGJ22poQYG6RR5iIdw4Ls3F5mGwidGY2gE=
Message-ID: <bae86d13-eaea-4dea-a67d-64b166fb3ddd@arm.com>
Date: Tue, 3 Nov 2026 15:06:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunxi: Limit the PIO power mode copy to SoCs with the H6
 layout
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261103112845.26721-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261103112845.26721-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vinicius,

On 11/3/26 12:28, Vinicius Pedrosa wrote:
> gpio_init() copies PIO+0x348 (POW_MOD_VAL) to PIO+0x340 (POW_MOD_SEL)
> on the H6 generation and, as intended by commit 4a9e89a3e390 ("sunxi:
> introduce NCAT2 generation model"), on NCAT2 SoCs. The NCAT2 half has
> never been active, because the guard checks CONFIG_SUN50I_GEN_NCAT2
> while the Kconfig symbol is CONFIG_SUNXI_GEN_NCAT2.
> 
> Fixing only the spelling would enable the copy on every NCAT2 SoC.
> That is right for the R528/T113: the T113-S3 user manual describes
> these registers at 0x340/0x348 like the H616 user manual, with each
> port's power value bit at the same position and polarity as its
> power mode select bit. It is wrong for the A523 family: its power mode
> registers are at 0x380/0x388, so the copy would write an interrupt
> configuration register at 0x340 instead.
> 
> Enable the copy for the R528 explicitly instead of for all NCAT2 SoCs,
> and leave the A523 alone until it gets its own handling.

I think you can do better: instead of this untested patch that fixes a 
non-issue, you should be able to do it right: In contrast to Linux, 
U-Boot binaries are per-SoC, at best, so we can have compile time values 
the differ between SoCs. So just adjusting SUN50I_H6_GPIO_POW_MOD_VAL 
and friends for the A523 should do the trick.
The only added complication is the difference between R_PIO and PIO, then.

Cheers,
Andre
> 
> Fixes: 4a9e89a3e390 ("sunxi: introduce NCAT2 generation model")
> Link: https://lore.kernel.org/u-boot/20260723105705.3338923-1-fugininsane@googlemail.com/
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> ---
> Sören Hantel found the misspelled guard and posted the patch linked
> above. This replaces it, at his request.
> 
> Build-tested only: I have no R528/T113 hardware. In reproducible
> builds on next ed869863, the SPL changes only for mangopi_mq_r (R528),
> which now has the copy. The SPLs for avaota-a1, orangepi_4a,
> radxa-cubie-a5e and x96q_pro_plus (A523), pine_h64 (H6),
> orangepi_zero2 (H616) and liontron-h-a133l (A133) are byte-identical.
> 
> A Tested-by from anyone with an R528 or T113 board would be welcome.
> 
>   arch/arm/mach-sunxi/board.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 432b1c10f9..75aede14b2 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -196,12 +196,13 @@ static int gpio_init(void)
>   
>   	/*
>   	 * Update PIO power bias configuration by copying the hardware
> -	 * detected value.
> +	 * detected value. This relies on the H6 layout (SEL at 0x340, VAL
> +	 * at 0x348, matching per-port bit meanings). Not all NCAT2 SoCs
> +	 * have it: the A523 needs different handling.
>   	 */
>   	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> -	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
> +	    IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
>   		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
> -		/* TODO: A523: keep only the lower two bits? */
>   		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
>   	}
>   	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {

