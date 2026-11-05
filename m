Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506F606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ytHLi0Q0;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=dID4NPBV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26CC640718;
	Thu,  5 Nov 2026 13:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id guLDYXb7Ij11; Thu,  5 Nov 2026 13:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4270C406C9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793886477;
	b=bwDrApcq9BkLFfG0VBHrjk4rfqy2lcJ6oinSY1JkwnCt4uOhz46yESfa2kPn7yCCTe6T
	 6i30/tQKQwjpT0cLtTdRlzHFsaQflKB/xk9FokYjEEIVkGOAsmzO2oJxJfvHffRFoQIZt
	 dGedUbVPFwWNwdUIlhfCLSDs8w+bZUNd8MGn/dLBM9Lc8HvBMejxJJSjayTZQnLJh/qN+
	 /ae13VH8Kfs7vrUEaozlRuVIpz+kxE4cP3LGh8Lpx4c7byv8rNcgk4iiKJxuNGpJf/ngR
	 r7tW1fldaoPvTQlzGVNMXGH1PFuzizdyt6z0VXiNNrj1MtGmNN/OGN65YIWgytltj3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N1GCFBtcs7w6Hjr5ZX1dz8Ok3qGy5LOaSvc8a6qMank=;
	b=oUk0aBv2M2GVRg3LJHkHyvErkUzhohRuPLruMDIy/0plvrr4xgo75r7JoUu9uLDE4jya
	 V/kwLIyuj1oY0gg5ioEEZDB2QAJQOJNS8UWXT/ygD0NFIf8lBKxtxXLK4CEjF7yveZ+4l
	 zzvXdpt7I+kMhYuniYbj3QU+EbTYY1U0yqbDm9bTXd1+dw/ftgD7AI1xpewytHWDKHF/m
	 9WVNPnmvcGHzhS1KxxylTAWKXmFNpaAthQUbdl5V1jO/vt/1pWnALTcfzCKp0PsWlVIjE
	 Z41pQG602KCU5YXTUMYXEjyGHfoZdBzWW9mtP0N+Qbmc3a2VFr9k4ktdrNvwuoAL9EA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793886477;
	bh=N1GCFBtcs7w6Hjr5ZX1dz8Ok3qGy5LOaSvc8a6qMank=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ytHLi0Q0pvVP/h34oeThr01FqhX+2/UYJmCUy0xqs/FuG0tJTnffD04RwIlt8qSxd
	 ZRbGPFxyxmlM9SorZdd2UOvOr+ZweZxqRBvILW21nUzDfPvKzoQdOtpAZMiLPoXrhG
	 aoIkzS+NS4p6CG80meTMntT5ADeHcRDZ/0swBTgdZEyxyegOGU6huoAooesm8Egxs5
	 xRRjUW0KeDuKB5FjZuj9i3QFypP9JAQKEY7acCt930qdVh4TpS+efM5Jfo/6M4Hgjo
	 F5IVyeq1aMq8AN4Aaq1sC30x7zrPN2G1V5VkCpv2e6Z+eLTenZdYrVS4aKsPrkxu/r
	 HHvUz0V/6CUxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4270C406C9;
	Thu,  5 Nov 2026 13:47:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1336BD3A
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC3E86080C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T29ov1o3qqA5 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:14:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88EC2605B5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=sigma-star.at
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=dID4NPBV
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88EC2605B5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8128482A; Thu,  5 Nov 2026 11:14:39 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B720484820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 11:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so11827145e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Nov 2026 02:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1793873672; x=1794478472; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N1GCFBtcs7w6Hjr5ZX1dz8Ok3qGy5LOaSvc8a6qMank=;
 b=dID4NPBV9RgYJzuW1/hAXcm26Cid0c5X/Hf2ys0GZHTDRthAME+/O8jN7oxvoGQD+k
 jLtVez/BY5SPOw1fyFhnDnPW/pCosMD1KoLIcgktdPSeya3vR+rigJuOmTpb3igJLupP
 iNzc8ARIJVPoXGl9nQD66cg68Ruo23RDatCCPljF399y6mIPiJ09pXIMnN1fvo1dElve
 RvxDbSKilcZbmpzhOr20MlVvAwGULvqtMguHp6bM04IwoMM/N8WvRXp8I4O3Pdh3+j03
 thi2SfxjmN0L65jz29MHuHTUnShuRhM+Fg5DnrRSUHmIRXOSGDIOwAsGm1sRLxge5jYp
 Pvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873672; x=1794478472;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N1GCFBtcs7w6Hjr5ZX1dz8Ok3qGy5LOaSvc8a6qMank=;
 b=KKnXC0SewI2oHaRZA9xjMjUIesn6N/3snWw7r+Kta+ZXp7cou5g/z6tRlt358H2aqn
 HZpcgneWvgaCJfZHdjYOfhGPU2dl/5LAslvP3QDzFnscbDwNDvAUObGvUD1OJjfOtZEH
 YVGIn0GWxMwakzmcpZlyMAuSz0kTIxcnSL6Jplbc8+vWT1b5x3WNEdvX8fw7wSCeJIaw
 y3UdbbaoH0zbhyCEeE0WL5vhMDIdDDpao3o+uZmLswZ+1W7AIZ7AJ5cDuV1kIPrYQf76
 BLutkwJ2sHvVsNs6BuATF/4RNJd2zH6ZjmwZCfPRAhpzxQ4fOPuWgMVbEpud1OIZu5Kp
 KDBQ==
X-Gm-Message-State: APuU4Z96qviqqjQaBgtZkcu4xw+7dkGS7IWiX35YUaSY85WLQL6cyCJN
 CX9BpiIKjitlSckKNX43Q2QLGbppW4OlpPCQXqZcd9z80F1aJ5cO6JNSnCSaQ7ncgDU=
X-Gm-Gg: AYBFou3DyN4CRXNeQFEbY2EDSqBoa8t55onLuA6P6xiG94Uc6EOkVCJzsb7k5njjwM4
 EUgf8h0jCen43EBXsT9zV7SSO2ICnUgCV44KrOY2CBDYinDqeym4TOkK99ZEOaTo/fwhspLThCN
 YNfy+U1C+ESadxLmgkyFaIihpnZYbtDDpoMjFLzsS5FJAUr4GSrsm05FWQ+jKh0V5rXYH7p7JyS
 fPB9fUym/Q386QFnbqiWnEbx2sQwHLHyO6LSCvQ/Nt9IulQCq7krjwhzt4JoeH/j0vBiweCjAjN
 Q5173WlGlcQlU95d4puRqb0RaaK2h3lrspgzOK2W+V4YO44hbzQkQMiUprwahlwZQhSwMoAISaM
 xZFxarL9ga6Al8qkRqces0scV2dwX8iKUUCuoPmet6fTCPIlH2SVMHJWIkSYq79Tb80G1iECX2k
 JZv/GaiI/3bpPv92joPwLPajeIWSeEzBr8b4bp9SjIQ4s7ACf4cL7J81kOfkMTEXLaRUtL8zXGB
 DIABrNaGv0NJwLSDXcM0wo+C1L6BaYSH3ew4i4ScUn3rsjTXMVHppIncZJZGewt/2aoVbcSkWqA
 ZHI2tNb0FiNcNOaibBYICK8eWdkZea9d9A==
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ac1228978cmr384433055e9.0.1793873671941; 
 Thu, 05 Nov 2026 02:14:31 -0800 (PST)
Received: from [192.168.178.47] ([41.66.122.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46538sm51309735e9.5.2026.11.05.02.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:14:31 -0800 (PST)
Message-ID: <d469a383-2188-4b0b-a550-29e5d62267b1@sigma-star.at>
Date: Thu, 5 Nov 2026 11:14:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spl: fit: add software rollback protection for
 verified FIT configurations
To: eli <xjmps7114@qq.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20261104141117.12284-1-xjmps7114@qq.com>
 <tencent_6C5B293C811C2C4B1C6DC17B52A6E3C87E08@qq.com>
Content-Language: en-US
From: Lorenz Kofler <lorenz@sigma-star.at>
Autocrypt: addr=lorenz@sigma-star.at; keydata=
 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
 5OAWJ7yLRAI7WigUCHhbizN5NSso5ztVJWx89g==
In-Reply-To: <tencent_6C5B293C811C2C4B1C6DC17B52A6E3C87E08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:47:53 +0000
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 3:11 PM, eli wrote:
> A verified FIT is authentic but not necessarily current: replacing the
> next-stage image with an older, still correctly signed image reintroduces
> vulnerabilities fixed in newer firmware.
> 
> After signature verification succeeds, compare the configuration's
> 'version' property (covered by the signature; missing counts as 0) against
> CONFIG_SPL_MINIMUM_FIT_VERSION and refuse to boot if it is lower. 0
> disables the check.
> 
> Validated on real StarFive VisionFive2 (JH7110) hardware: signed
> version=2 FITs pass, a correctly signed version=1 image is rejected
> independently of hash verification.
> 
> Signed-off-by: eli <xjmps7114@qq.com>
> ---
>   boot/Kconfig         | 11 +++++++++++
>   common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index ae6f09a6..7ec0bde1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -224,6 +224,17 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
>   	  device memory. Assure this size does not extend past expected storage
>   	  space.
>   
> +config SPL_MINIMUM_FIT_VERSION
> +	int "Minimum acceptable version for FIT configurations verified by SPL"
> +	depends on SPL_FIT_SIGNATURE
> +	default 0
> +	help
> +	  Software rollback protection: when verifying a signed FIT, the SPL
> +	  compares the selected configuration's "version" property against
> +	  this value and refuses to boot if it is lower (a missing property
> +	  counts as version 0). This rejects older but still correctly signed
> +	  images. Set to 0 to disable the check. See doc/develop/spl.rst.
> +
>   config SPL_LOAD_FIT
>   	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
>   	depends on SPL
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 46ebcabe..9dcc58a0 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -781,6 +781,30 @@ static int spl_simple_fit_parse(struct spl_fit_info *ctx)
>   		if (fit_config_verify(ctx->fit, ctx->conf_node))
>   			return -EPERM;
>   		puts("OK\n");
> +
> +		/*
> +		 * Anti-rollback: a correctly signed but older FIT must be
> +		 * rejected too. The configuration's "version" property is
> +		 * covered by its signature; a missing property counts as
> +		 * version 0. CONFIG_SPL_MINIMUM_FIT_VERSION == 0 disables
> +		 * the check.
> +		 */
> +		if (CONFIG_SPL_MINIMUM_FIT_VERSION > 0) {
> +			u32 version = 0;
> +			const fdt32_t *verp;
> +
> +			verp = fdt_getprop(ctx->fit, ctx->conf_node,
> +					   "version", NULL);
> +			if (verp)
> +				version = fdt32_to_cpu(*verp);
> +			printf("## Checking rollback version: FIT %u, minimum %u ... ",
> +			       version, (u32)CONFIG_SPL_MINIMUM_FIT_VERSION);
> +			if (version < CONFIG_SPL_MINIMUM_FIT_VERSION) {
> +				puts("REJECTED\n");
> +				return -EPERM;
> +			}
> +			puts("OK\n");
> +		}


Hi eli!

On i.MX with HAB (CONFIG_IMX_HAB), SPL_FIT_SIGNATURE is usually not set, since
HAB already authenticated the whole FIT. Therefore with HAB the minimum version
check never runs, because it is inside the

	if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {..}

block.

I think it should be moved out of this block.

BR,
Lorenz

>   	}
>   
>   	/* find the node holding the images information */

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, Austria
UID/VAT Nr: ATU 66964118 | FN: 374287y

