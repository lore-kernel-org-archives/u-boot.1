Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E4606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uYC4Dxo2;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UbgFIoBL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A869E407C4;
	Tue, 20 Oct 2026 21:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NF-hs6Ksn3Ut; Tue, 20 Oct 2026 21:37:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC888407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792532223;
	b=EgyFkU9ccK2CyWP4m/TMc/SxI2T6zo3f8ZpTyVk7sy5wNkRIFH6io2gtVWOCJq8X7rXp
	 GLeEx7W7Rm3k5Sg8N8bgHgV9no7ZvM7yoW4oTk+IMW9RD3QSuPA5SUBIzD0QzPv0YUx+K
	 2O7dTvNP14UtxQCkKXQArb3FgBcma5io1n0KIUdlYtj+tmTEdzJigITWygUhxEf6kvl2C
	 jgG/FxaBaUnhBOlbrBFvy/9IPxp4ctzV4cVnSWta7jlsxkczn05WJkQ/1iJdvTzFG3XkV
	 OfYCVkDN7fWOedsq7uLLNzy/U1h7iq6WaPVxdE3ol0zdqO/ulmpKX/GOcDRbjXcqbmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792532223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u5JrO8FMFmt6f4VpcjuOf4C9/srKfL2RPwCcVsG6Aps=;
	b=lzo91RYNPL2zy7PuvgF9er3oTtsdGEEkvNVwozDCpOpMFrw7WJbX+HxKTY/tLFLWn0zk
	 lotVsUIx1qp7KRK6Yp5X7boMucy8UEGwbyu7SYUp7LaA8cSkVL3aYqjbmTzne1spiOBL1
	 bMh75xxBhKjM+1AdVey7lT0siAwLoNF5LrZZfik9Uno+XP5/6W8YoYs5qkMTfnqMS66ik
	 /PU9dXrwfq3l0jVZfa+Hzsgizdekgcxc4phDDYhSL7xJGxqTLaSyhqGwcnEuifdGGM3F1
	 rOSrfZYZO0u2UQG3idlUev6zjGw3MdG6iWuMG8i7HWMpdadFYeK09xxodlnLPHorEwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792532223;
	bh=u5JrO8FMFmt6f4VpcjuOf4C9/srKfL2RPwCcVsG6Aps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYC4Dxo2X+pkacr5+in7nUWb7cXhGlwg4ECK7vvEZByE0rVh1EMbWIOBAHYTsFFB3
	 RCqVvTzpvRf+6kcenK2DP2dxvk7MvUWP0FDu0esxScm9wuzuNFl2XQ1MOCvA00+HUB
	 ls0t0ITpooIvqVVQfuwxSPX6r+SaRMtXmQRdlBEfSMAHaxnKX9x7qn11/rtnxc4yZM
	 bLtUVUjvrtzdqoDhE5YczC9rLZh9csn19du9hy3eABVXHpcvZ+aoJv3WEQkn6I6Ns9
	 SGOT27ih8sANDIocsxIM7ai2/Rs5VFOAKxq9ELIpquorTDsPU57IPiUXz7Y5k80/jc
	 mPYbpMa5wN2ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC888407A3;
	Tue, 20 Oct 2026 21:37:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88A223A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85B5A605FD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxO6nFrfQX7U for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 21:37:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A511C60719
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792532221;
 b=l6K8hSonoRul79K3wBsOANIBRzK+eNnFzzy9/E3YWoWirRGY4qu1K/EH7eQkAzBHJP7p
 xjn+ZNQyjrGzL9Y4LzL2dXgSqpT+ECUrlTCxi5A3u6Wi19TpugsRB1ftYNi177xctFQmB
 fMw6wLHHNLLw/9t3FRW/5lq4PgIE8iSn00biUJniZFPBmT4fd48IqI1E996P3EXnleUEq
 TSgQIGlzoZrtL9CwCZm8HK0y0GYtPZYcHcB/SoGZp3F6/FktbpgAaEzrT24d4Qe600IWm
 DFzlZ52tbaSno/wyFoWSrmD+ng6lUMLx2LT5Akc6hnP0uQRZ04TZjLkF3HKz6taKaZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792532221;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=u5JrO8FMFmt6f4VpcjuOf4C9/srKfL2RPwCcVsG6Aps=;
 b=BeZ5yOWCSf8+eLg26E288RSEASU3EsUJr5QBwuOHStsXkNI6uuTyqEVMvR4nHC6YoaQk
 fz8R2A8mZh2pReJrHhvjCedL1X0CAujX3yiBu4gPjv4LK4u5ja5lU/fINS6aVSb8NppJx
 6d8Kv0YRgTFYXt/GZvyKEBXV6uYcse/nmTnRsQDCpivhK91JCZ9TNbPyRDOFm86Y0wTQp
 ynk5FDufjXM+YWyZRXOA9JlVYobUWkFPV1RY/QSKE1kGS2R/9Rp6vsO0UWBBjFgY4M/Ad
 OIq4m/mtcfuasOd+9xpNnzf8rKdGQkiXv7p1477VPCMpvWnqVEOw1dwXCkUP6Mi0Mhw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UbgFIoBL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UbgFIoBL
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A511C60719
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:37:01 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-53ec9237600so45177b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792532220; x=1793137020;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u5JrO8FMFmt6f4VpcjuOf4C9/srKfL2RPwCcVsG6Aps=;
 b=UbgFIoBLKTQY4DFfDb8aevHo2MSt2wkfkUxJYpCBIHYgPgz0m+VS1vAYcF9hVNiOQF
 Fo9zkGk5QfozgMKJq0NB1eghLdcGshORTXHTPTS5yT048oy4HgMjuaRiybRtaJgwcvkz
 9uRngch0B3Dy621fqpFklnrPMqkrFJn+MmypugI5PncdAhzQqoWaqX21vFvRczGru0Rw
 IHq8f+L62wIijSOzTaFZlSKqhMevUdk2kBxaKVC+yjlke9KaLp/z1jt6N3QhjX2HyCW+
 4jC4qKBfIJbf1DxNoG1b+8T0pT9ODk1rXuA3F+5fcV0UamxF7M2864lA3Ql3rCa9uQwi
 lAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792532220; x=1793137020;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5JrO8FMFmt6f4VpcjuOf4C9/srKfL2RPwCcVsG6Aps=;
 b=anIzqTejBaJDNxJ0hipZb+0woAIIveOyTCbZkCWe43z7oqiaYuo1BJQMQ/yCEx6AZL
 409KeBf0g3gZ61EX5K3OkkZV18CxNroy7oXZf63KiLsfzECpckKV/xnqNLOyngYf1gkP
 ZHqoj66ZlnFPafSu+qXl+U729OebNFQprENSysk3BuGvX7ph8m3j+oRwimHdTG0PnJVo
 DZM9wp75eGasf6XCvuaAyc8bhSRZB7zdzDQFU9B0VvP0C6dSEZuTcFn6jWIvKMkOJl2+
 L5e/t4yteieLQUYYERs6p92R5VI1lMDny/mpeoB81905X8LOacz3bPKCks/B0bCb/uYq
 1zdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOk9cAFRiubaBmwIqEPVX7okbsC6GZtOvF2c2jWNEaM1PN3o1OlAFvO1er63MEuR1wtlpPZ4Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8gW4w6Lxb7VqaTjedgMvMaevmkIgArAEhPC55Qu5P8toSvJVF
 ejUHV9a6T7Qjmb5G4UIvH82umozl5eEHCFue6nUOQZjmhc3EqEEycWARcsGIZqx9ylc=
X-Gm-Gg: AYBFou1gsKkhEBzJjqsnsB0AWg5jdx/HhTchMuGBNYtdn5OPItIMCUlr4zE3rnQK4rq
 6c9eP5GFEtZCCvu53LwvT3ZrjPzgcgQF4ll4kUmU7Ml6XIEXxeakKSam4kL1HKkg/raH8kFfyuq
 njwwdwFdtHtRJIfPj7x3tfDLI2xsNU/PkzE/g0Gmh3m758ClTctw6ejfyKzpTKa7Kh6oLQ/jpho
 wfqB32UE3puQbCz4Z7512mRdqS+cvfC3lsfZHjKD1u8HRBYjLCwPZU01dYH31gToHv6tXNoGaPk
 x4Nx1tiUrEsDXaYtC6Pd4giAqH3/K9G1P3oeI8k39oR1KN00hYVlhWy2MrA446WCfXUmzDO6Imo
 yxvf+MkLP20Fi6c7v773VRcoFPYpLNbx2b7sPb/27qw2N6H77KiMXjFKneCSOBypQeAmoKpqlxe
 AltD+mivcF3q/Pf1OvqMW+L+2WrYa6gk5cha4tbtauH71O9fQrPxsS5lcMCJiFOqg8AtbP5mTp9
 ilYNOiLbAzMSV5dZnRW8X+LOccD7r74U1ByOjKx+RcWZMbDW/HXEvT+OMSrxJXFFbjsRifmSPGr
 jfsdPCW66KvmduNpGYIEcSX0zgpW2A==
X-Received: by 2002:a05:6808:f07:b0:4dc:1374:99ae with SMTP id
 5614622812f47-55360657a3cmr72928b6e.56.1792532220197; 
 Tue, 20 Oct 2026 14:37:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b7454fe5sm433406b6e.13.2026.10.20.14.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 14:36:58 -0700 (PDT)
Message-ID: <e11f4fbc-6cf4-476e-903c-c22ab6c10d36@baylibre.com>
Date: Tue, 20 Oct 2026 16:36:56 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] arm: mediatek: enable caches in the SPL download
 agent
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
 <20261006-ccaione-upstream-mt8390-da-v4-5-63d7d124780f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-5-63d7d124780f@baylibre.com>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/6/26 10:01 AM, Carlo Caione wrote:
> Genio SPL runs fastboot with the MMU and CPU caches disabled, making
> image downloads about twice as slow as with the U-Boot-proper agent.
> Enable caching to remove this provisioning bottleneck.
> 
> Keep the page tables clear of images loaded after fastboot continue,
> and disable D-cache and the MMU before handing off to the next stage.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/mach-mediatek/download_agent.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
> index 193817cce98..4da2b1a283a 100644
> --- a/arch/arm/mach-mediatek/download_agent.c
> +++ b/arch/arm/mach-mediatek/download_agent.c
> @@ -4,13 +4,20 @@
>   * Author: Julien Masson <jmasson@baylibre.com>
>   */
>  
> +#include <cpu_func.h>
>  #include <dm/uclass.h>
>  #include <fastboot.h>
>  #include <init.h>
> +#include <malloc.h>
>  #include <mmc.h>
>  #include <spl.h>
>  #include <stdio.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
>  #include <linux/errno.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
>  
>  static int mtk_mmc_boot_prepare(void)
>  {
> @@ -61,6 +68,19 @@ void spl_board_init(void)
>  {
>  	int ret;
>  
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +		/* The heap stays clear of the images loaded after fastboot. */
> +		gd->arch.tlb_size = PGTABLE_SIZE;
> +		gd->arch.tlb_addr = (ulong)memalign(SZ_64K, gd->arch.tlb_size);
> +		if (gd->arch.tlb_addr) {
> +			/* SPL skips arch_cpu_init(), which enables tcleanup_before_linuxhe I-cache. */
> +			icache_enable();
> +			dcache_enable();
> +		} else {
> +			puts("Cannot allocate page tables; running uncached\n");
> +		}
> +	}
> +
>  	ret = mtk_mmc_boot_prepare();
>  	if (ret)
>  		printf("MMC boot preparation failed: %d\n", ret);
> @@ -70,6 +90,12 @@ void spl_board_init(void)
>  	if (ret)
>  		printf("Fastboot failed: %d\n", ret);
>  }
> +
> +void spl_board_prepare_for_boot(void)
> +{
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +		dcache_disable();

We enabled icache too, so this needs to disable/invalidate it before handing
off. We could probably just call cleanup_before_linux() here (Here "linux"
really just means whatever we jump to next).

> +}
>  #else
>  int board_late_init(void)
>  {
> 

