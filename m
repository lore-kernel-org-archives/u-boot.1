Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80840C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D443F60817;
	Tue, 22 Sep 2026 20:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3IXNw8ZDh7s; Tue, 22 Sep 2026 20:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D069460810
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790110105;
	b=onpnG/OyfFtMACKL++rmYXENyqqqhumGkBYmpKppAWCe/Kz57osBUsISxATfNNECEPBO
	 SLE44g6vT/89pQy3aApf5ap7/CrvmTEYUtRfH2hqsVjDQx3WAqQgAxzFiqh0tmN4UJZZ7
	 bte53YIIRJobxw4x3yMd1EVpcRuBDYZvPXnyvtmj6BfDbUCqIHC9j2samramLuXXXrSd9
	 mttMu+il9N3FgZE1DrpPMJPFul2EXZANHJeqBngf4yl702/dXUOEqxpMZkfnTywlaSfyp
	 nwqHEtoY46vi1/BhtqFPjN0YUPUGzqRhFvo3kE4vlS0UIQ2c7xRUqGTCqetbXzGkNQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790110105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ElkJGDvkwPhyXdjxPLOmyJ7YktVQfA73aSfKM25Xfxg=;
	b=kFaQJpO9MTw3w57smQ50VkexgPSKIby/GZhqPj1Ymsk35iymBk3YOGlL1KGibWkqD1Xk
	 SOBs6m6m2HdqvkWcMVS9E7EVnNy+cRCUtyrZRIvYe84obfceMBs+AhA9xGextqsICFY70
	 8Ck+oEa2Aol3wl+xVmk+IRFYIXVRvH4etjehO0oEY03PI0OM4z7Jt6jeEOaTJo+olQbUK
	 DX5LEVnUJczeJzPR1wFN/5X0uqARitiAl0poxQprwQCoKg1+D/7eMVacKdqS0Cls2Ntvd
	 TyMs8vBpQTK8sPy4Y6WWCtC77Mbq7+0VVjB16jA3GWXj9ZsB5l1IR3aOQiGvlF+8jiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790110104;
	bh=ElkJGDvkwPhyXdjxPLOmyJ7YktVQfA73aSfKM25Xfxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SamMOklXt5ODgBFpcA2txZ1wXq3ZvCxOWzgsiOAaNdtFoo3VjDb8vwqp2qneK8gNr
	 q9yCBPsPrDnAIaZTlc8clNc/Gnd2CXjMLO6WB6aQdyu4TwWVprjXoek9k1HwBF40xx
	 PaQ235jI6d8TMs0uFJhDnUK0/Z9VIHBoHkRelcQsarSi7k0wyh5p7hQ7l/TqD9Abir
	 q1sdinKwYGqi0iZbxB2/S7RD57y5HiC9amrUwbeQVQKvUc/g1xw9bAMA4kbd1yC0/T
	 o2JpvXf8itDfJGi9KLpLhAuXXYENEcH28fDGIq0zqJhlOcWyajhYgiVmhRgII1T5yd
	 U3nXDxTQ26BXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D069460810;
	Tue, 22 Sep 2026 20:48:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB77E9CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD1F440735
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HuMEK8t9qvhg for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 20:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C512C40720
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790110103;
 b=salfD+lTHgyWcGOF6DRBooTpW7UBer1pApF971mxkFLnarlPC3TOm+YxWWvln1NYKvGn
 OcQS1Fga7aX79BWhn+wLqzSF1zNkqANAlBcilpWXO6T+mnMXEEsTvpxBVG5lK+LYbvRfM
 Xj72+drWVqx/peFlkDlJRM3z/c280duDqhIXrSxQe6cPf8dp3ytrBw8qkp7sHauPkucGO
 /4DkvpeKJsC3N9+MhkPAuxMTpLbaky2mBA/AhXjX8xxUWORCg9GLwEwd5p7mIh6NF+Kmj
 Zp81x61508n+UaORG6655Mm3Grz9PV4xzvfI3hUpsYLPu/M9SEnkV2eyAXBDjFKygrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790110103;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ElkJGDvkwPhyXdjxPLOmyJ7YktVQfA73aSfKM25Xfxg=;
 b=SUYshX9N+B0qtFsY+dX2zo1m/UwdnNTVZuzkVLi3vQibNqra0HyoWoJnJsESc5q+QqcS
 zbaHqv8ERfu9GvrcCRMwYgcBe3w4DXPF14OTr5N1X1K7rlL9dPP3ypBT4Q9W82em0R9Ti
 bzCjsRiB4CO/fkLjmLwa3Rf1CTjnuFecokCvWbEKx50ne3Zi6O5+hl/dld2FyKfuD4Lpy
 VSNMS5w6yJPCZICvNuCGq+n0o0WLV5ZDfz9E9+1oo13tO18ok+ITmNN3cwoy7L8mhVUuC
 dHpZihIuyXPtZpZTn45U7J1DSUiqbl6h6Fv60LjxGstjZprAUpLsMLgSmQqxa8N3p7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OqzYm9KA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OqzYm9KA
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C512C40720
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:48:20 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a30eac5so235120b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790110099; x=1790714899;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ElkJGDvkwPhyXdjxPLOmyJ7YktVQfA73aSfKM25Xfxg=;
 b=OqzYm9KAN51Ou9Xj+/AO+8AZm8LagllwQ/DmpBBb+AVeVXrl2BsUrjGvFvEkTyv0wH
 D0eG9F2jF3kbldQ8oD8+8JzOBJ6kz9LFKxM5XB/qaHBYa/YVDCEjGJGycyBBUhCYHRkg
 ZAxHf6xwcB/Fac5eWUC7M4ECqSMZuvwnMhEWtO4lDaH34qjZ/lmVP65lcZDrqOUIdOdb
 0n4guJ6dokXqNGmDP5VbLcMzDiHN/nM8d2LkCO68lqmMdpHr/p6NJVXKnTGyr+L1Yy7Z
 s927z9L3gaR2RKUw8dKSgUXW0hh6x/+zc57vo58z98eF1uc0qPYphmK1pjmDeG6++l4o
 //fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790110099; x=1790714899;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ElkJGDvkwPhyXdjxPLOmyJ7YktVQfA73aSfKM25Xfxg=;
 b=2x+LLyLprXYiVg6LAWtHlk2GvMlGzz3QOS1CmhZdLIJtxe/Z5lEuLd3xZysyEOpfWr
 5NC8pchn90R6tO4dhQ4DqZrlpnY5XwuiutAi4J0eNCBWtIB9sRJEpKexQvgUCWRLuIhK
 gmVCF7ZPYveQxBIPUgFhJaRR6lm9BJlfRiOceUPaODLChj/AcTbe6XlKfQ1BJ6SwQlyk
 DmbaNk/P7SMqQARafVk55hrXirSNat/ijounezQ4ViKbWJJ6RiTddBsu91xADwY19gzZ
 XKysTOUvzWuLLdiQVK9VREsmEL+4lefYh+1C6PSUCK1ZqXxp8tG9F8vYKN6MwCYDUwk0
 J5Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTfO7AXYcE8uT6K7POzwujxJqcbL8iqSTvunSKkyUVGQMxmTh5TLZu98+CixM9zQGYogBvmUQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mDa85bNILUxVeQQHt6oWor1XtyokcfdBIfI+ITyxCqf297+rwH
 6Jt8JqhkiBfLm/zJRjfbfdb54ZlYhOpHVA4tpvNISL6GjhZeMJcI2MPG3grNcmWEYkA=
X-Gm-Gg: AYBFou0xgHoUlTrgHa9pec7ia33ka0gm4XUPxpWTsl+ZNleB3GZcOWlnEb4HrblxNjE
 GuwhmoSOPZwEIKEVLmHZXa+0Vra86yuWmpl1MTfrD7Iwj6GcJ/ffclDgGtommk52w+xliBQepyQ
 KrkNi5PGmuBXjQRynRfOik2ZieSTfQmQTNx5zWZQWUS7bujCOFZc8XTpLcR5MTWyDFdHUm+J3DE
 jIGNqbKX0SgkXQ72hngeKaRuMkUz6wVrGSRAPxZlJjXq3tzB9tuLtwhXmdzfpHaUrnA7yekdJQz
 8ZYJdX3Ait5TpejNA4E8OkPEOMDSGqo3/7I+r8cra5ZZpAurxGn/d5q1ORwRThrlWQud0Cz1ZJL
 mvQcEB9H+8ZJpXnfjIoWBmFPI9AnmRuML1va0yguwigYMrlDQFXQCoblMR+jD1KKvJ0Yg71fnxu
 Rf6g6KBAG7Afv34J5GhNnB/oka2uQGnXZgOKawAJyn5WjfzlNGHT3nqcWx1TjCT6OCRlgV1AVrD
 biidgnRMdzv0AqJpBjEFwvvdayKPXMhkl87qTsW3wWnD0aO
X-Received: by 2002:a05:6820:180b:b0:6cd:3fdc:6004 with SMTP id
 006d021491bc7-6d2d301611cmr476030eaf.85.1790110099544; 
 Tue, 22 Sep 2026 13:48:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e?
 ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81603ad2b19sm781063a34.4.2026.09.22.13.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 13:48:18 -0700 (PDT)
Message-ID: <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
Date: Tue, 22 Sep 2026 15:48:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
To: Aleksei Sviridkin <f@lex.la>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260922193031.785941-1-f@lex.la>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260922193031.785941-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/22/26 2:30 PM, Aleksei Sviridkin wrote:

...

> The obvious shape, a prompt on the generic symbols across the arch, was
> v1's 1/2. Tom Rini declined it:
> 
>   "This isn't a prompted option as boards that need it are expected to
>   select it and provide the correct value."
>   https://lore.kernel.org/u-boot/20260921155055.GZ858934@bill-the-cat/
> 
> After I described the board, he replied:
> 
>   "Then yes, a v2 where you just enable this for the platform that needs
>   it should be fine, and please make sure to CC all of the mediatek
>   maintainers, thanks."
>   https://lore.kernel.org/u-boot/20260922151920.GH858934@bill-the-cat/
> 
> No MediaTek board in the tree uses the header, so there is nothing here to
> just enable it for: the one that does is out of tree, and MediaTek has no
> board Kconfig a select could live in. What this v2 adds instead is a
> prompted bool inside mach-mediatek, with the offset base prompt only
> visible while that bool is on. Tom, is a prompted bool local to MediaTek
> acceptable for this, or would you rather it did not go in?

We don't want to add an option that is only used by downstream (code
janitors tend to like to remove things that aren't being used). But I think
what Tom meant is that you should add a defconfig for this board so that it
isn't downstream anymore. :-)

> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index e572cfe857..e48fe88529 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -173,6 +173,23 @@ config MTK_MEM_MAP_MMIO_SIZE
>  	help
>  	  Target-specific MMIO region size in mem_map.
>  
> +config MTK_KERNEL_IMAGE_HEADER
> +	bool "Prepend an arm64 Linux kernel image header"
> +	select LINUX_KERNEL_IMAGE_HEADER
> +	help
> +	  Build U-Boot with the arm64 Linux kernel image header in front of
> +	  it, so that a vendor bootloader that only starts a Linux kernel
> +	  image starts U-Boot as its payload.
> +
> +config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> +	hex "Address the image header's text offset is measured from"
> +	depends on MTK_KERNEL_IMAGE_HEADER
> +	default TEXT_BASE
> +	help
> +	  The header's text_offset field is CONFIG_TEXT_BASE minus this value.
> +	  Set it so that the difference is the text offset the vendor
> +	  bootloader expects; the default gives a zero offset.
> +
>  endif
>  
Then we could do something more like board/armltd/vexpress64/Kconfig where
we just select LINUX_KERNEL_IMAGE_HEADER on a symbol that only applies to
that board (so no MTK_KERNEL_IMAGE_HEADER and no config prompts needed).
