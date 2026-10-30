Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF0606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yvWpQJNy;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=blJTcDll
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1DEB40E41;
	Fri, 30 Oct 2026 14:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9axMUe116SCe; Fri, 30 Oct 2026 14:21:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ECAF940E37
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370099;
	b=TyjY0qUjp5CEsonfs5jT0WxhxqLkLJtpNy+GrcGBVCd6TkJwiIdGe0tkvlbZ1kkdFDgW
	 OcOYl8pA7NKYneggVyqx0ygdJtvG9j7sbjbd7fRMEv+I+2+xjSICrzgQoBYwtLDEZfgzO
	 OwvB1nfdj7nIllQorTehdyfclIDCYaWDVsgTpghZkTxr1Sz7Xx3E9131Gxmtwzru4ZVDw
	 aZcXBWswW8iwLybzCed82i42Kj79K0GneoGmyHNm3tDySM+GwZbxc3WGFS+9sxnE4QlwV
	 9ZeXDh8+PCUP6xNX/4t07QXebJnafpW0DkFeOd+a+TMzwzWD8Bt5g/uE6DAKsMbQOKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jzel2pxN62QMgmxWwruC6eA7trCmWOej/jPQ6D2sGRU=;
	b=NwQqw2PO2kz5cRUme3neeKb6ZocOr+ibbSn++kMpEitWUtkAZo/SWzk5RPWje6ZKXjz8
	 QGP2jxwhfKdBs4CvnmJheAHPPHTpGBfzgtnXoOvE4fh/FYXK5K8esf3Nl/ym5/kNbG7TS
	 4Gtl80rQmJY91T2TueXifTCRpPyC9Lg88KUouaWvFcvK9p2nlgQ2YVUv7u3X+/7whOilO
	 kEJxImOJtGE+DVfR8GLPCwi37kK5rE04cABNn6ZWB46S7RCa6mngUnSkyrRYfNCABT9rK
	 20CGBJK0t9HuUcOnAJGghhYVanOls70DVx10I/2uGOlpa4IBzIcwQKs7SL4hIgBBa1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370099;
	bh=Jzel2pxN62QMgmxWwruC6eA7trCmWOej/jPQ6D2sGRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvWpQJNyATQNUCMfdyHBXFjSkux0RClGAMC9wML9sPHOiigXMpHKaCszhbumHQDzX
	 zoJU/yn6rGUvNNpTpTDCMARfZCJPwdYHkjTNrr+71t62JbZv90ANqK4LP71+p/FtKd
	 wVM2Xt/szJTPZf67GCj8UqyomkJguPkramxL34exirf+ACErq8aufjWiCqJ9D9E7xc
	 DwNGoeB1uWlMr0UjLSyr26eYYYlCIo/Vb4+VC+Rqsf3GiTlHlFzJQWMmCU8GDHtCEl
	 jLAMwYeNJSoT75Ak9QXrSLtxYa1JL+YNoynzpxqttv9uupWI/3RtNCHZlAtqt2h0qk
	 u591923D7vG1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECAF940E37;
	Fri, 30 Oct 2026 14:21:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B94B9362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAD1140530
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdHaD7cTOaxm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 38E044052F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370097;
 b=IHefCf6gUUrM4L73fW7DD9s274cdC8Nlgp8610JqZxS+f6IzF2Bn1plCL8PgntaNn0B5
 KMznY6u2Y0aiXtN+qBZAPpiFtkdsgPJ6h0rjUlWPrPjUTlGoS/bOvbGQxp5g4Hh+Wl+1s
 BMYNTtXgJXDpQXyqYKAOyr7ercH5tOWmcpIrbq/w7jHHklgRmIYaSgg5KuHNY3PXeym+B
 PREKfIGKamCaaIHrr8qO3PTR7C8OYBkHTwW74JSbkV9UoyeF9qH9geHk4z7lzVEE34/H8
 l2RQ0gVxK5+Z6ByHRFkCKDPPzij9oFO9zra/ULKCv6/ob104Cx6kZeJr6WZ6V4Xu/8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370097;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Jzel2pxN62QMgmxWwruC6eA7trCmWOej/jPQ6D2sGRU=;
 b=iPaQXtxoEAP7T5RWgC07dA7XCqPyevuJ8Tl3qaxz9JzI/Y0TPWg9zStIu51Hqi53RN9K
 F14yfiHlgDvDOjtBzrBYkjOZHULPIYGqo6E43VRnI6znuHg5nl7RT6AuF4WfPhrZI4fdA
 KjgvbR1WfcCpqzv/A2WjzPmFwESrFSWzbAj2IwntwB4oOI2UnH4AQ83M9yjbvJASkdr6Y
 YV6Dmp3CPiwfGR2MTtt5eNCvZ56sBlX0fzP/yQ7RHb+58Bf0A3OAcBmggpXyGdmDa/pzt
 a1H7vi2hNqaKyml2T0i+UP200aFw7TFqB3M7e3cVV7S3pO/d+8v75sWhG+26NUaqRKA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=blJTcDll; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=blJTcDll
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38E044052F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:21:35 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so4653365e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793370093; x=1793974893;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jzel2pxN62QMgmxWwruC6eA7trCmWOej/jPQ6D2sGRU=;
 b=blJTcDllA7Rcz3/BP4+4+KhOz1DvTuYs+40lqUDGEOrnxN+KI+/girokRGT6JYmuia
 oDagdpcnPJM2AM/Czdvlj6F12i+KbgcHcSAWhegl44BLmRpLR0KMqkQuM+bSWwKgvRaT
 nCot+z7I+NcIjFnshWZmbGq+5sGkMsWkyJSDbL4kx3/uB6k9sON5CSV7ikdU+42SVR3J
 mCGcHYt/uC4Wy2xmDvK7n2XVKBkdRBQszfvI5a8MFF8LIMU71W6mtVwhHv1yrmbFViaS
 MrxwCKa/FfIxOC6nYbW48BqJ/FESFW+67dmUgNynI9WRCfE6F4L2/UvWaG3uVfKR40sk
 HpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370093; x=1793974893;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jzel2pxN62QMgmxWwruC6eA7trCmWOej/jPQ6D2sGRU=;
 b=m9GpNFTWkfP+kOJzDRmHEzofuSvxQPQTVag3u10ohmtSEeLzzOo35htoU4pZamlMtC
 4vstjxjm0oaw1pgKVLsK0q0iaaFUiRDzdh2NajnZhlFEYwvFXPNLQmOC0rWseLOCAIcU
 UkEiludMomOtsrJSyzwHFUOt9P1MnvV1d9ZuM1w2ecE6wsUB5+llXfge/wYmNsJhjAP7
 QPkn620KAWSV51jb2hnoxh+Q+54W6S1JziJ9GUCg2DeslM2eQ2sb0FBCfCnhpGQ0p09c
 8ZqTYiLj3jV2o0yrw2PDCslncSBJmEIOoQkKjKG0+/YA55XvE+xJdlXxDZvkqK4OGsMI
 QbBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByat+pRPPEJ4q2NNX3J+kkwWp5jQLGzEQqyCI4Rgmv9YP1eA66bhbv1VuFl2/gqDQihdN/zD/A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLaa4IcVdBfLrl6TrANbK0gTLAYJRCwKeg9BdDix+5PxZd7wsPy
 HW9ULi3g1zipWhfX3BWArgc1TbK6wHsocWU7/LsYumOgsanEbrXJUFeUrG0ZVUEvI1g=
X-Gm-Gg: AYBFou37uH7ju0VU9QXGAg1KWH13xM335mJDImbB66QQjhnfhs762m5txUOBm0cCa7D
 taVOCvolE0F9wm4LUfNVv7EXUMeQCstDSuDexNlkUi8s0BUcVd2mrHQDMq+o4jw1r3AVTS37dJV
 uRrvmpYlpXigp0jc/MkhuCZ5IlhrJu+D4r9Y+MFEflYd3+tmgFYvJ3I3rj6hVE/SfHpa4HjLXUF
 cPhUW0h9rYD0MZ+3s0Z1YC8eImE5dieOKAXGQ6hv5t2LOk+3TO0eFerF13znp8VvVFEDr/hsh9e
 QFevt/ALsGp9TUla01KtPul+WNaJC6BsaFGyIjFCoxtowTThZ/+gV0lQQ1HLP9PpO5sq1z4jrR1
 AAbbhXe9GPC2PLDzWExvndwfkbX7VWlcuTAGhTBBjPR8MS7oItIIBtz5l/+R6w9Tmwk1UotrFtO
 yZSHkETs9WY8FqwNHt7qKa4UAC4AZV0DDsUBTvV5mqDGuegVatqds3r8IcIqE0Tw5tIw1/fR7Gy
 aeOsTH+jxVwXuyuQPsAC1rCXmOQFYAfcYrDMo3WmcUddPtu+GvRNhPT1hmLrw1DNAIEPiR4/k0r
 Qzu7wogtCJm+8kCaI3L9R++vms/5D2ta0IKpcK+0r6NrkzGvoZXip/r/8/9tesv3GNCdBPat8ri
 OFs7+8B1mVx0HmTrcTn4ssjrZroc0EfU/03tnTWOCTISlr2E=
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4ac185bccfbmr55794285e9.13.1793370093270; 
 Fri, 30 Oct 2026 07:21:33 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm142066715e9.4.2026.10.30.07.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:21:32 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:21:30 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
Message-ID: <auSlW_sslFXp8aVs@macbook.homenet.telecomitalia.it>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 09:57:41 +0100, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
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

Could we use an explicitly allocated/aligned buffer for the early tables
instead of 0x4e000000? That address works with the current layout, but
nothing reserves it against other image loads.

> +
> +/* Initialize the MMU and activate the data cache in SPL */
> +void mtk_spl_enable_caches(void)
> +{
> +	gd->arch.tlb_addr = MT8188_EARLY_TLB_ADDR;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	dcache_enable();
> +}
> +#endif

With CONFIG_CMO_BY_VA_ONLY=y, the baseline reaches the console, but
this patch stops before BL31. SPL leaves gd->ram_base/ram_size unset, so
VA-based cache flushing skips RAM. Could we handle this mode, or leave
early caching disabled for it?

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
> +
>  void board_init_f(ulong dummy)
>  {
>  	int ret;
>  
> +	/* enable caches early */
> +	mtk_spl_enable_caches();
> +

The BL31 path already disables D-cache/MMU, but jump_to_image() does
not, so this patch is in general fine if we are jumping to BL31 but it
is not if we directly jump to BL33 for example.

I tried a direct jump to a proper U-Boot from SPL and indeed both remain
enabled with this patch, whereas the baseline hands over with both
disabled. Could we cover the direct handoff too?

>  	ret = spl_early_init();
>  	if (ret)
>  		hang();
> 
> -- 
> 2.56.0
> 
