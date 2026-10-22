Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DB606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LW1sCeI5;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=VZANIjnE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 725A781199;
	Thu, 22 Oct 2026 18:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgOQ81otxJjN; Thu, 22 Oct 2026 18:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95BC381175
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695135;
	b=h8mQsbp5XmpUwGZfDkzDqde9OPO2nUo9r0zG9rs0YChIb59Ug2vXzNudqtiJ3/Yj38IX
	 72Dt0aMMoItJvXXheSY4IIPGmVE0wSSdz20xPDBSNrcXLLsiOhHvHWFJe1zenm1lZwKt3
	 BOc1TjRIkwBNZXtbr1mcm32bXbBzfsxACEcuPIt+UuSQSVj3qmAMEQqW/Hke0Dl3YhksD
	 8MkPMOHUiPjhnZ+8w10mYO+w3xBKY7ukfuQowf8hreFLevXiwzlXUN4TdGEM5F3N4fYHk
	 Z0SrRRjDnNvCkwsMSdbcmk5K+u/C7Mc2yolNs6FVCo7avhSgF2tLm3eubEYrNIMdsYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J1XK8RYGRkS/TozIwIjeshjPHiBwW6ImYvU1LN0NQLg=;
	b=rYpLi81coZ21lVZ8JR44EjrO8xKaDrS3uMnotwQNyeUwKy6f7NkCvx/hLXAHvnWeLQW8
	 4XEbUfmDYvZksfekLUm1IdVFjCjGgu2cV6USVbTFgfUO6nQR0/jHztZBCWLdxJNELcYN3
	 e49Gpl5e2uys9SUUpMJxvq/XPc3m3FFUuYsq9HD7519uxbWioj5tW3rV4z0T8nKOo5MLw
	 l/sBsQXZ9nT+QR2JCnmKxauCKACHf+V0+SZvugFSURfuxUlsYITK0rZ1JZg/k9VZ0IInR
	 oTMn925T3hTjJW1MLAcjQlro5CCihy/IoIAtG0XC2koRNeNuDaPLZn7LIHs2dC/BTFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695135;
	bh=J1XK8RYGRkS/TozIwIjeshjPHiBwW6ImYvU1LN0NQLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LW1sCeI5QOg2xniNTIMpLmSxLttCZSTFo3SjElZCRyVTU4p+cuzp7v9aaVczLweNO
	 2ksQUd0ZI8Y1glorVK6J6q9GaytyHLHoNwOsiKkcqhECta3mwLIHeOISCcp+QEASn+
	 NZjQqKmWC9hvvunsYulGkQ4oFqvuE+vMaXKYIgAzZHy7qXtN131IJLcazkpTYezybP
	 UEBOsbwB7vEtFjzacXWSo5jPfW7rwVbpnf/MOAnW/txplTTe2wsGPgO5SeV2fM/Bdt
	 7F+BezQjCa6Nyp4Z+eBYywTv17iSxPOHKJMZ5cQ+WvgkJpa2brU5vZj56drQ7UEqHj
	 cE8VXp751K4lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95BC381175;
	Thu, 22 Oct 2026 18:52:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A69E3C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C2724097B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPZotorNUwXu for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46BD340979
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695134;
 b=ayK4iHfgXHNlNQ3GovmHxpsKFA/dLSg+ULAq/+SDoAfo4Do4v2KkashkzdYqnr0V0jVX
 bVZNOuPmNuc8ztEbE6u5ungr7hiUjzvw3D56jHdaArwQEEz2vFaV6IqmDq1hQ94sIxH7b
 zTVLdvx0VyIgPf6oUeaeu4XB2HUSY961Ujm01V/9d/ezld0NLDM2+xmkrD+x1wFPfdT+l
 airBcsKN0hHkN4E3htL+MDcJvMVKN0wr5EMXtcSuf4IBJrdVMams4GBsYPGinXXK016dm
 CHMrqADdBKvUQHuajv/mu0+OJfGrmYxpBy6Usk1kKjkVYOpnPoPrpOUwuQSlNxkf22w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695134;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=J1XK8RYGRkS/TozIwIjeshjPHiBwW6ImYvU1LN0NQLg=;
 b=Lenr152smBiS333wN8i3WTt9LCRzltMZTKSYsAQkPhqm1056DdUqIb0/eCMZTk7OXtlM
 cTB2mkfURHbMOCOiIitFRyUxEjgrkndM6Dwy18hvz4DiH1fmCseiXzuwpWMD5jXuu8T2q
 L2WcpdIQacW4AR+4RL5eCaxo8LqGB/zvc6tlKKyR0mYVrzNka8mVHN/qj5Toy1AAYPeee
 HVgnU9r9Cf/HEGXwQF0RIX28ihTCP2UFuMtNoGw1n33C2MGNPih7LKOLlMCutZp7NzCbp
 VFBtdU32q19SVcutnrqCG4RjUDbfCHYdOg+iBBEOPnqDCE3Zq2W0gs1QoNg5OhppWxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=VZANIjnE; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=107d=in=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=VZANIjnE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46BD340979
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792695131;
 bh=J1XK8RYGRkS/TozIwIjeshjPHiBwW6ImYvU1LN0NQLg=;
 b=VZANIjnEDotVdiQwXRP8UpA6GuVnW4CL4vAhxg4r4U6K4naxY0hbIkHrPbTONsQkUNOlWbhK3
 fhOQXKN0O93sN4S/BcMp5kmjnRGjuN4iQ1YBJNDYjIFUYGsb+Pjl4DSOEXECq4Z0SIfqMCzxxsd
 6r/HuEtueR5JIuCrF4CLf17ujsrSYnP+sqP6OXYX9AfewqPOR1OSAFb8IiUNNV2T4TfEefObbd1
 4T1f7qJ29mnEW6+D+IM3HhrKIalxX0Afa9bEeR/UONEwkmqKpnFBXWGKmo/xUFop4VooWSOq0W5
 eOep7HPC9Sz55Lci5Xx26UhnYpulAF4U34xT45HCk22g==
X-Forward-Email-ID: 6ada5b58f18cf83ae426d33f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7a9ef465-4cb3-4bf3-b0be-e5403165cc31@kwiboo.se>
Date: Thu, 22 Oct 2026 20:52:05 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ram: Fix LPDDR5X size decoding
To: 1579567540@qq.com
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.u-boot-project.org
References: <20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cunhao,

On 10/19/2026 9:31 AM, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
> bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
> 0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.
> 
> Define LPDDR5X as type 10 and DDR5 as type 11. Apply the existing
> LPDDR5 bank decoding to LPDDR5X so the same register values yield
> 4 GiB. The type values match include/soc/rockchip/rockchip_grf.h in
> the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
> This patch fixes LPDDR5X capacity decoding in Rockchip's shared SDRAM
> decoder.
> 
> The geometry registers captured on a Forlinx OK3572-C with 4 GiB of
> LPDDR5X are 0x100043c1 and 0x30001001. The current decoder labels type
> 10 as DDR5 and uses the generic bank calculation. With the bank bit
> set, it assumes four banks instead of 16 and reports only 1 GiB.
> 
> Define LPDDR5X as type 10 and DDR5 as type 11, following the Rockchip
> type definitions in Forlinx OK3572-C BSP Alpha1. Use the existing
> LPDDR5 bank calculation for LPDDR5X so the captured register values
> decode to the correct 4 GiB capacity.
> 
> The fix applies to mainline independently of the RK3572 SoC and board
> support.
> 
> Host-side validation of the decoder with the captured register values
> reproduced 1 GiB before the fix and returned 4 GiB after it. Regression
> checks for eight other memory type codes produced the same results
> before and after the fix, with no UBSan errors.
> ---
>  arch/arm/include/asm/arch-rockchip/sdram.h | 3 ++-
>  arch/arm/mach-rockchip/sdram.c             | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
> index 476fc1c4e..f5a213fde 100644
> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
> @@ -14,7 +14,8 @@ enum {
>  	LPDDR4 = 7,
>  	LPDDR4X = 8,
>  	LPDDR5 = 9,
> -	DDR5 = 10,
> +	LPDDR5X = 10,
> +	DDR5 = 11,

We should probably just drop the DDR5 symbol, and could possible also
add a DDR2 symbol. DRAM init blobs likely use something like following:

	switch (dram_type) {
	case 0:
		return "DDR4";
	case 2:
		return "DDR2";
	case 3:
		return "DDR3";
	case 5:
		return "LPDDR2";
	case 6:
		return "LPDDR3";
	case 7:
		return "LPDDR4";
	case 8:
		return "LPDDR4X";
	case 9:
		return "LPDDR5";
	case 10:
		return "LPDDR5X";
	default:
		return "Unknown Device";
	}

>  	UNUSED = 0xFF
>  };
>  
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 2e404df1b..b58919137 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -403,8 +403,8 @@ size_t rockchip_sdram_size(phys_addr_t reg)
>  		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
>  			  SYS_REG_COL_MASK);
>  		cs1_col = cs0_col;
> -		if (dram_type == LPDDR5)
> -			/* LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4) */
> +		if (dram_type == LPDDR5 || dram_type == LPDDR5X)
> +			/* LPDDR5/LPDDR5X: 0:8bank(bk=3), 1:16bank(bk=4) */

This seem to be correct and fixes size detection on my OK3572-C board
when the dram info from rk atags are ignored.

With the DDR5 symbol dropped this is,

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>  			bk = 3 + ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
>  			SYS_REG_BK_MASK);
>  		else
> 
> ---
> base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
> change-id: 20261019-lpddr5x-size-fix-fbe1c1a168de
> 
> Best regards,
> --  
> Cunhao Lu <1579567540@qq.com>

