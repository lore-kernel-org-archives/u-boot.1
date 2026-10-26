Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13270606A324
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JJP8XE47;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FpzDmVP7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5CA440556;
	Mon, 26 Oct 2026 09:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kl7XQuVK096V; Mon, 26 Oct 2026 09:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33A354058C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007239;
	b=SELEPjt30lvmY0mWDfF3R0cToBb2HVk/jZswK9YWlIWq26kkNPjGQH7wS+1CmMocK/6h
	 1TiriYHHIjnta1+6bso9V/kwdbRilP2BnsyPmc8gIBCGyGuUCFmr8vlKtSsycNDeGU8EK
	 1Rn9Y2jC8dTNuXmK/FWarKQBFkgZwZR1I8/8+4usER3W6IIeTruaqoo8YHDSjYZi9BIWu
	 yAt9qJ3x63kUkkOmGbFnhWPFlD2bFKqaZ+spaZVU1oRCS7gD7Vr/SqyOKiaoEjoIm89oy
	 M8nMKx5ZA+VElGS/W5sH3na7S4y/5kOxyEDfrQ+C/hViHIXjyaqDgt+Bve5eBjmzkFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m9stch2s/m7v0skH4SMx49aS3rRan3Xf52tWriXiU44=;
	b=PmaSr8mUmx0SxdJGDYtM2pdLiSuwk9pfCumDV0BfbuoIB9EbZXBTjZ43Vv1gmsFj0F4C
	 5IkspTT+vFGjd3OLvLoPWE3V7yxwQ7GsjNSH3ceN0jgg4129NGQ9gr/1bCHe46g8PLbGJ
	 iNibgqIkeGZWg52SLZBcNteGvfRIozLV2LqPCHl2l4qND1h79n7pelM4CsBawbuqIvVLr
	 Z4DgR+tySwRn54ga9+hCKG566k8+wSQx9vL95KalsqYLC8xDg1DGnqVCu1NCJShCu83Jd
	 I5xDbmgflsm6NzWiTOmMyy4WHYQ3UdXwBdAlsLvWAusP4GYNMrysvuR+NGFF0IynfeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007239;
	bh=m9stch2s/m7v0skH4SMx49aS3rRan3Xf52tWriXiU44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JJP8XE47vJJLZR5+1lEtYq2Ky67rM8WFvfHgzUEgM8RHR0akEqwowLlm4yid7XUnc
	 9m2TXDmdP0zu7hX+Bpwq2aMp0Fh5a45r7LooEmWwl04EpOsWx3/uWqgU5QB6/+lheT
	 TtRDX9GmoIQv2sPEWlz0GhGIaT7JyaIBFYqmK7A/6cWWl+tmDN9LRjbnjc1bPnDyVc
	 c79I84/qKT5X94yLBQYsl/icuAVF/KRr+msc7Sgzmi6vQfoEekNin8EZdAgczeB4NF
	 4twAefYUWk3njS0x1j6AE+XXiQN0mo5ClPiqbmbjvajFwgr4Uz+Uo3jZt48FZdFJCB
	 h9iXEHsCDKwDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33A354058C;
	Mon, 26 Oct 2026 09:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1B3D356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9323060645
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6clF7cyXGiUF for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1403F60619
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007236;
 b=e0R7n0WiLQliOE5Srb4B7PKg0jYqrQFkDML78YSPmxl30KkDWXg3Gq0y7Y7VnS22qrVb
 3LkxfjVzrQuyvf885+Bj9UVVm+9hnYZ6KyXWsh5MHYyBDStAP/zxxyupOQerVExMdKIBn
 rNEXPYBpQ+j0HfrscOstYZpyE0RP0nDHJZj6EHrKfjYAYUfR6M9m4hnLHcc8FrSRL19QA
 vZUNFBmu2IVB3pytpBOjpi1pvejQWOuwgFhI6GbiH2y7t6uWZgc3LyZu0pzwDHDFyRnkg
 +PyACXc7QzQBmg6fdKHoLeY4wO4B4EEvM6Aw0ECtga9B/ORKkKc1Hf4APsm8D5YqllA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=m9stch2s/m7v0skH4SMx49aS3rRan3Xf52tWriXiU44=;
 b=T180gxp32VLwO/HSkBGuXFSMhRZ3p5ooR5V3j/ek8YHkQwaRPUwQ3TH1dXxykVpEN2Dx
 aOQEkTAlz1jz5W1imNG0K0rAHFl2WaMpN9Nr2jGNErWRQGyOnuhOoPf+aETlTSMxuA4Oa
 732nYN1/OZW1MYvJI+mz55IOIEKBi0YC+yRQwQK2ak3AYT5QQCaLwaSVfbAGpIcRx/XyP
 adByHoGRTrZf1AG5Krbu70vFvv+RPDWQ9UmZ6qlaSw6MQblRhwvX8QzGp8TvQlR4b4VuP
 /SkzZKuWFbccxReSA1lPWq0ncpmmCb6bIxdrSri2cjmzOE5FMxShUXxMmYabjCYi3Yw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FpzDmVP7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FpzDmVP7
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1403F60619
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:55 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so17471815e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007233; x=1793612033;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m9stch2s/m7v0skH4SMx49aS3rRan3Xf52tWriXiU44=;
 b=FpzDmVP7PNBxGse8sJYZCwBVKEAmBwGKTB8Wu+0/sZ+l8Jxbkk4hYOivXuD7e+OTtZ
 YXkmoTkQGtT2xtBqdQEgxU7ElIH7uD3RHYjBxEhDHtC068Tn8/LLl12yjfTp3qd4OzPi
 mBb4+OQPFDyq8OX/7BQJTwwnIhO9oqldVtZoh/KEIEbck3DbCj4HSUgXxQvW5sOluEYR
 6zJmKwKKDZyfWERwtXhEXTViDjtODOBkD8O+Yse0493JTMnF6vqorhqli5UkNj/keUd1
 eaECWIOIlmqqhoQ+0CqwFwuHyjq8bctUjJ4HxrofIf0V3Go0Sj8vgDxT1YugcBbPaR3h
 OzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007233; x=1793612033;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9stch2s/m7v0skH4SMx49aS3rRan3Xf52tWriXiU44=;
 b=mENC7Aspht05k9RXD8g3B7ofndYgvILZkKoUEbIvMOJgQXcaFNuM1hGD1Q3c2w8XBR
 NrQPGGRb2DZcF+UQPI/7WafQ2R+C3IEdjvezzoiNtaJlZM3MQOZqmpMBlNp/uUaC8CaF
 ZWljGQjfNPvUiacaAy2dS5i/G9lRP7bCmzrdxIATYV2/3ixQtrcMyRUVDmS/4B3qXWfx
 D4ry2Uvm5MX7u4RreTcNaxI7H5gSisc3v+vJIgEofz1ofgLND/8Dt7D4TEH566vxufbb
 y33HK+IpG06gt/VPIxcus57Ht8iT2PhqeKaFv+i49BazN1441EaUDqqr/wqABq0cF4LM
 lY4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwciSB+rAgfSkYw21RNrRJfmVQEqNt0zU8Ov7y8/xVcetiamL0BS6pT7XkSRS22sbroA8eDuzI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdg1LckvopIP+bdoDcGVnZ8/Hw5TX7w7bHBxl6HJr7oRnD6PG8
 /MpND+ohNM1Ml50A5NnnSNcxBktHQaimkRNAZJwzzHVvale0dqRAlFjMlLCc0xfpHmI=
X-Gm-Gg: AYBFou2njNh+6IEjgV2s6CndS2kzd1dfA5RCSe+511swzNMOvImTKUFrdkxy+G3LF2H
 ZWxUXZQY5qyjrQoY1fdf4Ks6twatudifQqo6M9oe8Nz4dkzj4z6UGUr98MDjhAWOhgS7Xpdxs8+
 HNCRRNXNjRoRmNF3F+ZBqyA2OLM8ofEawGSeZz7QlKv+DtErlf1W4PttlhVbGGyqXSVag8SEUrv
 LVHxia3yTiE1AWNrlDv9B51uADfEw/B33hdr2f1QCb5r9Zr3q+c7Afc273B6fvjcCeEGaBfo6rK
 Ofk+kI4BeW8zoEBtMmy+ozV649X/4Ow6DTR/5dPqV+Ge+2JyqiBkpED39aYFNo/SB+v5Hi2i0l/
 w+/tP3FzlWWOYL+gBEg3X9nDR1Lca+enDnTm7V6IAqNfFWFzuDF4UQ0S/cZEhKPvJaq1YAQzYnW
 lpVItpLbanGc+3/saHwSZFK8vWIYImgerBBfq+kAuCmGg4qqBa27Pc+AqiopsqlwAcC+CEeO2aG
 lGmxZlxAtkve5st2JNFfTYJSGE5ro2dW/Y23eG0YoQk7tFoqnhAIIUAw2ZZtcMZQ5JnqnDkHE3C
 /NI2/3w5Hh4Luz/t7FgJcM3N/Taj0GLElE9Ypd+NTDxoimbiURiqgbNlIKQnOgGyYcs8GKz+
X-Received: by 2002:a05:600c:4e87:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-4a35acbea9amr120310925e9.28.1793007233544; 
 Mon, 26 Oct 2026 02:33:53 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5698f1sm183061645e9.8.2026.10.26.02.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:33:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:33:52 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/7] arm: mediatek: mt8189: fix the reset_cpu() prototype
Message-ID: <at8eanzK14fYHz_0@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-1-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-1-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:07 +0100, David Lechner wrote:
> Make reset_cpu() take no argument, to match its declaration in
> cpu_func.h, and include that header.
> 
> Fixes: a7c682565b4b ("arm: mediatek: add support of MT8189 SoC family")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  arch/arm/mach-mediatek/mt8189/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
> index 4435c75a656..c0b7050c6a3 100644
> --- a/arch/arm/mach-mediatek/mt8189/init.c
> +++ b/arch/arm/mach-mediatek/mt8189/init.c
> @@ -4,6 +4,7 @@
>   * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>   */
>  
> +#include <cpu_func.h>
>  #include <fdtdec.h>
>  #include <stdio.h>
>  #include <asm/global_data.h>
> @@ -29,7 +30,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  	return min(gd->ram_top, SZ_4G);
>  }
>  
> -void reset_cpu(ulong addr)
> +void reset_cpu(void)
>  {
>  	if (!CONFIG_IS_ENABLED(SYSRESET))
>  		psci_system_reset();
> 
> -- 
> 2.53.0
> 
