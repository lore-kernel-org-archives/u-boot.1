Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A265606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WCUjbBNr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n1X2CYb5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C6854071D;
	Mon,  9 Nov 2026 21:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVAoSrEi9O-v; Mon,  9 Nov 2026 21:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B59FC406EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260818;
	b=Whh6ChokaMttgfDjEZOBmjBEdVPy1adNAoh5tnWg+t0KZXjBkh9kMLmvxhNLvVE8xtro
	 UDzUxXHQYnI8R1EP+GoG4YORe714mUzcA54jz/ZuXwcV4MgT7XWUXyUiAQkA0O8PxbELa
	 Rv8PhZKuSQ7STzfwVUlVwJ9z8tNBHSdSqZAs/zixGoc42JUuPfVvD5PEekX+SU7Ax19BJ
	 jb9hFWZG/tGBi0n3olYGN95HFSxftJLt1IpQVsptg77BhR17ni6conShfi5IfScLEc4A+
	 9vhjSOF53uLoOnGto1ZTgJxvzGK1p8ojUjFnRUKvcs9Crn6cm4qPKKXjymm6rY8XyoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LPC9imLlSeC/mMxhf1n7WfVxr/ND0h7uAHAGOE6rgAI=;
	b=q12/HdwvBDhglc3SMSsAbRBUfu2f088mKypRiGd4mTAdmyeurvwuc8DHJds2GwQc8VCD
	 A7p/aSuolAZ1eVkoe8guKCo3O+izB1rPQ4asMDFNEEEXU7k7cM5bqn/xNG8VVcM4mpRzB
	 hH3G5TV9EqlfwvjjqmDWmia21RJ/BJhqqDcmYl33MpeoFRFaMRU0lAR7yREVu7pQlJ0/S
	 jWx+ly9708IrC8Vx+CyDe92QU+Ep9ygrB9ipBQfVGmNCFC2rbM/ogry5NzobvhQ54RhFp
	 pr5zy7zQ8xw0hFhFMPmS7Et2Ht/2LhufObamWFr5zUjb5W7IScHGSoBny+7j3Mgks7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n1X2CYb5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260818;
	bh=LPC9imLlSeC/mMxhf1n7WfVxr/ND0h7uAHAGOE6rgAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCUjbBNrYEKwEoXstLUykTxa/sFFfER02lXWQFn4hr2jBtTYuDR6dcTzeP7KaQsL6
	 rU1l2Rnqd/4+65Kvb5GGXQ6potRuQYaHsXROvJ2kpaZvS/O+5fRvvBBoj6OMAgM5OC
	 Lf0Uq8K2DLpuHmle6dihWzzx4rquPw27KoZehTEHPz1zue6bki4rc22K8caHoKa7FH
	 K8FLZX0ZhRVFodkfDNkS32CE/qwO4WEu/Y7RYU40jHeEIaLI6+CJcgXEtSk54r+sQk
	 OOLFD/ggsdLl0X7qM/jdZptujXgdOkdNT5N0/XBj7+PrWQIWlUIn41e41N7VVxLkWW
	 idU/o0NKvg16A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B59FC406EB;
	Mon,  9 Nov 2026 21:46:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A40FC28C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86990406EB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suSRiztIg3jV for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0CF440612
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=n1X2CYb5
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0CF440612
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:46:55 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6deb848ddd7so832447eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260814; x=1794865614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LPC9imLlSeC/mMxhf1n7WfVxr/ND0h7uAHAGOE6rgAI=;
 b=n1X2CYb582chqz72pPoWh4rMt2EkbSIWbeShP70wLTO5fPuBW2NwO62VRVrS+vOKIw
 yzw+0BiiQNwGSzguDcwDz0U6ARThEyjlEP6ZNNMFJe/z3QI3/swxDYNaR1CbnCQ66COn
 REmjxA5rrt0LiZpkxItvXsSHifUqJ0EIdFEmOONBmMiAP+l1Ou8Rud1xdk5X8adyArfh
 h4hMn55LKo66hp0sMKASh0/YntfRukg8C0fsHfYZASsAIxQMuT+tJsRyRNcUXF+vPkW+
 o5qiDPv2EnwAA9vvf6FvyAjWj598DKnJXLqrKT9H6F+ScXoLt3gTPFFukahXiCSMdNJb
 Mw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260814; x=1794865614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPC9imLlSeC/mMxhf1n7WfVxr/ND0h7uAHAGOE6rgAI=;
 b=CjKq6rvPH9iuPsldsoIVjKTqtXY/f3f57udY3AfwCd9Kcf7GIoUeWiZVzeBANGPDG/
 69UAxz6qGkPvZdZFoaE/TsZ34GVY39VP1G0nHqICDfw9SetzmRtBWffrFSqGkGFssU9s
 tfaby44BPzHjY+B+rQfXy9zNdF7wNez/LSv1k707q371nheeYNPnMflteXPdjgZlIYvu
 nu/H90S9mBh9Jd8C8EJKkua9ArUMPb0mXn9REhLzH9vr/gUePdPPq9AvsWoQujhG0uSL
 DKdLEn34HwcttP4GCE74VQUCkgCD9EFFiR6qxf0zyeg+13PtOWaMTohLG6jZQGIySS0g
 60hQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3afF4l0sYg1IADEkjencuiVYdlVrLmO/j0web0ngF4iwNRo9al4sBNLKN6ARO8LlIvf4bzVQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9utqsgvo9dmzIH0aqmgRVFNBwpFgx7cEgVd6Ud9XzTilSNaekd
 mA0FA4XT+FrmTPwKu6VsQz8Oo+fzYtQm42Ta+sBK1/pqzgW6QAdcOW9qkb61s/98Ozs=
X-Gm-Gg: AYBFou0kXyDE2dUa1iGmQV7Wf/JJ6UYQxkMUx0a2+dNDzPoTD9tXAm/2f9DdtOGlMAa
 E/ouD2R0UE57DWMJdIg5kmkA8GxVKqeT7V7TqcXgiiA7lyxaKvYqJXU/KiIcnKg+O4OeftP254b
 P3mx8n+oUDCdoVa+IaZAqATF6ASEFcerJR7OQzOU+0zFj7HdqJOSqN3b6bqVC1uz6CpBy3WMWiq
 1qOtkSCH8JJ3H0BNo8KUiUofz4OrAXgA6Xv3qkTN39GZ6xziQ0QVLbkvjeeBJngREeXdrX6twIX
 yEopXkkUXclfFN0kbHCcpNdcwr8YvOhMprP4Vf78jx1c8YpDMLDLJ401p/Lrc9dFa5R1Pv8q8kb
 Rfy1ljLQEVasgVk8s8fUs0zPTFgjtVAfwBiWVjkKXah2Zl0YJVSNj+UyZGrf0ENCC8wB0PDKrvX
 5VkeLjCRTGjN/zhhvxWSm1qvJPzyNOIXSTnGxLvO/YFJzGyumrRtZyzJvZhhDlD0N92j/ffCjxb
 zsTY7Pyxjcrb/SxC6Oq5as8uJgmOuELwhmJCB26wvwsWH3IW9ccAbyvqSLkQZ3HIUeq2kMRBzqY
 CebVvVIjp4qwjI5VQ0VlcY4IrBbDqc/PHKbshWXr19E8frudH6ks04kGC7DPKdz2eUHaw2aUCJp
 2S8nrazxL9jwsPk2Cae+dOmM=
X-Received: by 2002:a05:6820:3515:10b0:713:9556:572 with SMTP id
 006d021491bc7-718a6252940mr186036eaf.40.1794260814068; 
 Mon, 09 Nov 2026 13:46:54 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a9458d1dsm272022eaf.7.2026.11.09.13.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:46:53 -0800 (PST)
Message-ID: <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
Date: Mon, 9 Nov 2026 15:46:51 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
To: Steffen Dirkwinkel <lists@steffen.cc>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>, Chris Chen <chris-qj.chen@mediatek.com>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 9:13 AM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Running through spl without the dcache is very slow, especially when
> hashing or checking signatures.
> 
> Time from the SPL banner to entering BL31 on an MT8370 module loading a
> 2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:
> 
>   FIT                    caches off            caches on
>   unsigned               848.3 / 848.6 ms      95.7 / 118.8 ms
>   RSA-3072 signature     1903.6 / 1903.0 ms    128.3 / 143.3 ms
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  arch/arm/include/asm/arch-mediatek/misc.h |  2 ++
>  arch/arm/mach-mediatek/Makefile           |  3 +++
>  arch/arm/mach-mediatek/early_caches.c     | 23 +++++++++++++++++++++++
>  arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
> index 2530e78a5f11..dd248d222b97 100644
> --- a/arch/arm/include/asm/arch-mediatek/misc.h
> +++ b/arch/arm/include/asm/arch-mediatek/misc.h
> @@ -14,4 +14,6 @@
>  #define APHW_VER		0x08
>  #define APSW_VER		0x0c
>  
> +void mtk_early_enable_caches(void);
> +
>  #endif /* __MEDIATEK_MISC_H_ */
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 661fc0b88d90..67b55745a917 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -5,6 +5,9 @@ obj-y	+= cpu.o
>  obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
>  obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
> +ifndef CONFIG_$(PHASE_)SYS_DCACHE_OFF
> +obj-$(CONFIG_ARM64) += early_caches.o
> +endif
>  
>  obj-$(CONFIG_TARGET_MT7622) += mt7622/
>  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
> new file mode 100644
> index 000000000000..1b1e4855d9b5
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/early_caches.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0

nit: this form is deprecated. use GPL-2.0-only or GPL-2.0-or-later

> +/*
> + * MMU and caches before U-Boot sets up its final page tables
> + */
> +
> +#include <cpu_func.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <asm/arch/misc.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define EARLY_TLB_SIZE	SZ_32K

Can we get a comment that explains why this size was chosen?

> +
> +static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_4K);
> +
> +void mtk_early_enable_caches(void)
> +{
> +	gd->arch.tlb_addr = (unsigned long)&early_tlb;
> +	gd->arch.tlb_size = EARLY_TLB_SIZE;
> +	dcache_enable();
> +}
> diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> index 125ebcd784fe..b3bd92955d92 100644
> --- a/arch/arm/mach-mediatek/spl.c
> +++ b/arch/arm/mach-mediatek/spl.c
> @@ -5,9 +5,11 @@
>   */
>  
>  #include <clk.h>
> +#include <cpu_func.h>
>  #include <hang.h>
>  #include <init.h>
>  #include <spl.h>
> +#include <asm/arch/misc.h>
>  
>  __weak int mtk_soc_early_init(void)
>  {
> @@ -18,6 +20,12 @@ void board_init_f(ulong dummy)
>  {
>  	int ret;
>  
> +	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +		/* SPL skips arch_cpu_init(), which enables the I-cache */

Should we check CONFIG_IS_ENABLED(SYS_ICACHE_OFF) here?

> +		icache_enable();
> +		mtk_early_enable_caches();
> +	}
> +
>  	ret = spl_early_init();
>  	if (ret)
>  		hang();
> @@ -31,6 +39,12 @@ void board_init_f(ulong dummy)
>  		hang();
>  }
>  
> +void spl_board_prepare_for_boot(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +		cleanup_before_linux();

I guess calling cleanup_before_linux() is a bit unbalanced if we want to
allow SYS_ICACHE_OFF and SYS_DCACHE_OFF independently.

> +}
> +
>  u32 spl_boot_device(void)
>  {
>  	if (CONFIG_IS_ENABLED(SPI))
> 

