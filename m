Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294A606B0D0
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wO3D7gtV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hDMD3r4m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFEB781107;
	Mon,  2 Nov 2026 16:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5uXxTLsGwDs; Mon,  2 Nov 2026 16:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AF988110A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793637082;
	b=fC5cKJ4l11oX4QF8vbDKoPmGXbC1veL1WUoRwGjWXQZDPJtdNIOTr9JEl610K0u0yYNd
	 u/kCjCygqrzVgVHEaDo8VdX9ajzcRow6SIQX3iP5+sjzvx8tejgGvl9T5LYUDwJhmjEC3
	 1sRJvoWGvorLycOgW+9RbmrZKm56UTRFdnByVM/VXT/UYGh12qhdsXvcx/ibP8lHoeJBN
	 gTuDxEZdnd9tckreAayBNDs+TKRbGvFe2E+bD5qObFTN/ezJ/Xoo5u/ZTEKFufSOn1uWn
	 j88m7BwnEigVckYdoP5Vcraf3HZq3Q2R5aVGFi3yQPW0rAwA4aAibfcSqnLC/Zr7H4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793637082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oYjwbE4N0icwWzBqnXfQN+be2PVCppTcryYd3fwdVoY=;
	b=FS1LjzIP4KfytoNeKY8uoZfuWevIgOBhBL8H4kKcX6FapxouCykFtbHdhFDIwPUu2MQa
	 JiGEs7adP4o/S3264/gUoNhW3T6aLe34jpo7eAKAajxlz4Hz9E1Rlaa7zDG83jQiPOuOM
	 IlbOBoQ0/XPdjtbpv+S2bAHU27djNqVHkuFqFBwrAneqHvIyR1RmEIcbtYxQhTcPI3fqa
	 tKCdEDgS3jumoE9R2/Lfx24Pc0Eo5x46acZS/oy4WpPh+fvxPEaohgmX7xoQ+HdATF370
	 xfwjp6EZ6r0+3HxVncTLU/rcff+DpvwjhZixK+tSh/sDVjFGXpDIpR24iB4SNHOy6KQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793637082;
	bh=oYjwbE4N0icwWzBqnXfQN+be2PVCppTcryYd3fwdVoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wO3D7gtVlEhnPq8YzoRPv0h4THGOu0DyaUWQyOJ3ZMXmbJEMdePWL8bX1szdJL5M+
	 iLlVGQGZ1cgTHM+4qthM4OXCSGOuaIsXNxmNb721CvbULrOpWxj4HRc6ziOdwTfzfx
	 tNqRUcIQhy8vx5ynPtNvcb+ANi5u8/oZAKh11RQy4ojOsEqW1Zb/nc5i5xnASK0dyy
	 C8BibPRDs7p6EwSHeojuEPBzF1SsEILhdnoZ8bd7JaJ5IOs9Xhx4oNg7WBpveC2BBH
	 VHve+UTYoPps3451oWVQAPf0hNNbX7ZH2UtNQpAlcl+Ge5DChCUi0y1ZVveU7sTXUe
	 UCdC5V+ZxgWGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AF988110A;
	Mon,  2 Nov 2026 16:31:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 053D5235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB390400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1O1sWoIvpGvh for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE1254009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793637080;
 b=ZuVc5Dx8K/2QQlne1WRxQHU3evTyijtVr2B8QY3yMEJg26X1D3MFW4Sb/4ATd6OLtGP6
 LP2t5ZXoB52oR4fJxvpj+HIlQthKfkaHN/slkd/6Ov9iiTDPEBjA9x+1wOmV1dBFlKgpl
 RMT7+JBEoCcSKh2LiWVADOgjr9vUYjMePEQru7ECH3sRYzD0hj5grKg/5FHs4ulOsQV5j
 UOvRAlYnstOENrwRS6tDJfLiHFxTQlRuA6zIq400zEDAyoyu/xL7L7iou+fjqoEHmWg4P
 CImMt9kFi0pmBoAnXZg60/fwhXDx0X32jcCA9P38tv4lGsCG4sYYR4Qhis+Vvh20U9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793637080;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=oYjwbE4N0icwWzBqnXfQN+be2PVCppTcryYd3fwdVoY=;
 b=MKL5gT0GymkXmoGJ2ggA8h9f2IIWEg2NFKZ2ZpadORVrOvBQ733gviX8xUYyeud51RU0
 SSm4YLcA3akHBlUiYAuL3D0itKbJ/JJFsl68lcSF3ARcrcqnL1PLC9DyfnPLUHVt+Xxpv
 Jadmv9sPQYXxpZtA4AnD9j4o1na8pXlkkBQsmrFLt//i0BXmiIxd56KM7eQOB0OJXzoFj
 laln0yQSno9TWMWcBLxJuMweZfDuypLARpXnWgI/GImzBlO2uMIVERl+x/Gyk01jgvTss
 GdknDqmwCvgAIWXx4uXwXbE6FfxLS5lHLiNb+bkU52zlZf8PAjXRuQhJXZ4bf5mFNBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hDMD3r4m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hDMD3r4m
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE1254009E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:31:17 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-85ac281604dso1906896a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793637077; x=1794241877;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oYjwbE4N0icwWzBqnXfQN+be2PVCppTcryYd3fwdVoY=;
 b=hDMD3r4mnaHzU/5L38MXAGgKgx3YbbPSl0z+wCPWr+wWEBqKhAYVnimkSeEVlvByo+
 +HDBDj5GJLYcUWz7sa1iwAYWIKidMY6TR1m4129g0Kd2aLWtjdIPMWcLTPYEQzn4bHYJ
 LSTbsaxF7gu7EvutrddcyJaNIWfwFu+spAet72CHims09GS6R8qny2nGVso20/+P8fsW
 gL3+XuRgYgGW0C5Yd9XDClXHuy2MrzAZjvhezqscoZyY3KTPDCXQyGG/ENy7FeogC7NR
 +MpPmPhVDqhGztyWUQ1YVXVX8VTIlzu9fD3epbxJFYLRzLnJUT2cr7ZiHIxTBG3/PlV5
 W8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637077; x=1794241877;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oYjwbE4N0icwWzBqnXfQN+be2PVCppTcryYd3fwdVoY=;
 b=23cK2vQesfAkjAny3INNJ8eWmFkvYKybxiii/DBBWKpEftIWfxEhKl8uAsIS7nCVzT
 0iQHjLUQWKtziTDhtumYCNF9FWIRKcXB1hjbpEuA8if7P0VYAdmjMkC5mwNhtG5wczTE
 681fPs9APkxN6ioIjwgzPVgXdNKUtPLiu1KANXufRVNhWfaPJtv+u3CnmnuG5BvwBJkq
 cMqbMftNjG8V67fsOmmEJUvLe+yQOvF+mpchDi6E6H2t7dtY1U0PQ6ttSv0zb156fSCy
 D7cWTSS/nIzb3Mek2MiZ8Ph6vdI6lQEHxdKPeLZIutnMOgYwFzPott9p7ODrHHzPvdVP
 hMog==
X-Forwarded-Encrypted: i=1;
 AKwUvByyQ+4tHXGJltnlhNPzfvAGahOhJAf8Tv3QTNOJp6rv0fJIfTSfiiOxTjrAlkNr3QJZGF34CtQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCq0eYKIu70VbnBsZtqIZQKfzDeQJfgsuQc9McfHdmCF36eceM
 gCybixbnVxU6wd/gFLOhnlfcwwZToCz3CCnbllKVlNLJ+rwB44w58Xg+DVZ1wA2/6pM=
X-Gm-Gg: AYBFou1AptQ9XID207MgjKtS71ntWSY8mGTrNa06Qo/9bbDZ2x0LZRF0H4Y0jm+iXM5
 Tx04krShb0tgaPjHSphltZ9fNeGARBHDlJNKqwMx9tr4i0eJy6qtsmaXghF0K7RpwROoBKlpY8+
 OBSBdT83t/YBLaWOS0T3LajKMNXyiT7031xzVuRvVt90MsjNO9X4egI6s/I6kwUTV1SawWobYE/
 9XOn54XqjcPoDLPVx4aTJiqc6kwIL61Fnz2S3Az+sRkNQdFj4g14ZpUODxLj5uOQKrMF3b4DlG9
 AxJ/LoJ8uHKZkI3dTg+Oh6A1dexPUaAoLHegyhGlVRTIixLUNWveZCjfrDdGdMLUNcnBPO9Dc3w
 jy8U0lK6n+j8rqN7JOdN4QVeJ1BNFkIqTyKAK/izsIsdzDKLmy/5TJDVZYasMOxPbvmPHy+z9ae
 WKWJZq+2AAYdIjg4vctVrm4fxc1pfLVBFQICMne4t2n8a5muqX2XdO5eTzj/JK7NL2K7vpgEy62
 sxKNKoFjrfp7Q2x99dlSC7HWnjk6get0hCz5hchOsPmyzPh4Aj1uz24GC2sVIN6duVBv9rTSFbo
 24WlqheiBALiDT2PU4fSaY+7CidxUVq529xvEa+GMBEGRr2LSz/XiSsyThVZoqXbAg89wjdZ6op
 3GA==
X-Received: by 2002:a05:6830:270b:b0:815:cdb4:4a7 with SMTP id
 46e09a7af769-85d361178bamr8821291a34.3.1793637076943; 
 Mon, 02 Nov 2026 08:31:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f?
 ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354cd9bbsm8975544a34.16.2026.11.02.08.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:31:15 -0800 (PST)
Message-ID: <a208fe67-c8f8-4a82-9636-553477307f6b@baylibre.com>
Date: Mon, 2 Nov 2026 10:31:14 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
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
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
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

On 10/30/26 3:57 AM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

A couple things in addition to Carlo's comments...

> 
> Running through spl without the dcache is very slow, especially when
> hashing or checking signatures.
> 
> Time from the SPL banner to entering BL31 on an MT8370 module loading a
> 2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:
> 
>   FIT                    caches off            caches on
>   unsigned               864.0 / 864.3 ms      95.8 / 95.8 ms
>   RSA-3072 signature     1903.3 / 1903.8 ms    142.0 / 142.0 ms
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  arch/arm/mach-mediatek/mt8188/init.c | 14 ++++++++++++++
>  arch/arm/mach-mediatek/spl.c         |  7 +++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
> index b2cdec8c2189..2e6aa041c38f 100644
> --- a/arch/arm/mach-mediatek/mt8188/init.c
> +++ b/arch/arm/mach-mediatek/mt8188/init.c
> @@ -6,6 +6,7 @@
>   *         Chris-QJ Chen <chris-qj.chen@mediatek.com>
>   */
>  
> +#include <cpu_func.h>
>  #include <asm/global_data.h>
>  #include <asm/system.h>
>  #include <dm/uclass.h>
> @@ -47,3 +48,16 @@ int print_cpuinfo(void)
>  	printf("CPU:   MediaTek MT8188\n");
>  	return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> +/* Early page tables, in DRAM unused by SPL and by U-Boot before relocation */
> +#define MT8188_EARLY_TLB_ADDR	0x4e000000
> +
> +/* Initialize the MMU and activate the data cache in SPL */
> +void mtk_spl_enable_caches(void)
> +{
> +	gd->arch.tlb_addr = MT8188_EARLY_TLB_ADDR;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	dcache_enable();

Why not also icache?

> +}
> +#endif
> diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> index 125ebcd784fe..8073101e3ef6 100644
> --- a/arch/arm/mach-mediatek/spl.c
> +++ b/arch/arm/mach-mediatek/spl.c
> @@ -14,10 +14,17 @@ __weak int mtk_soc_early_init(void)
>  	return 0;
>  }
>  
> +__weak void mtk_spl_enable_caches(void)
> +{
> +}

Can we make this a config option instead of a weak function so that we don't
have to implement the same function on every board?

> +
>  void board_init_f(ulong dummy)
>  {
>  	int ret;
>  
> +	/* enable caches early */
> +	mtk_spl_enable_caches();
> +
>  	ret = spl_early_init();
>  	if (ret)
>  		hang();
> 

