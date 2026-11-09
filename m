Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69C606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m5VjCzxe;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PrqDyuS7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B02A280DD1;
	Mon,  9 Nov 2026 20:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnr-wcwtIS6P; Mon,  9 Nov 2026 20:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BAA680DCC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794256130;
	b=axR8Vx32F10jXMW69OiBVsyQkT2VE4vltmXsqbejXUro33iK72DfnAKR3FZtXjpHY2Px
	 LCulb+zQ2ccKzKt+R9nZ/P73hlkoPlUdXcu3/KvWQAzScfCUTAVV32qisS9FchuzQgveX
	 sPf/ici6RXldwy0BMI9JJoxP8O8WnppwxuTtltdRUEogx4fKhWsbnQj7lzFUCoY0D2nNc
	 jq89AiwNsYszEfYYUGXqqA7pA+7pw3Y4MYaX+XW3gw4CeQcJ4bKfcgoiSI+FCLv9Kcp22
	 kix4AMf4x85jra7Yr5YwM8WUAz94bjhpd5xgudbTmnFBlo+x4slO3yLCo+Qx+oXhD1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794256130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dd4zVhkOLDjzbLIJoVjos4aD2QYiZ9/ZuTxNpW2PMZg=;
	b=d3lu88m098lT5eDEIFJrOpA4oi8RlamZCHgWnRNZhgku/St8O1v4FMp60PtAsmldBYMM
	 VuulpQ/KAhaewj4JfzYT9r29M6Xex5RJx163Pw07I5taZqYObYc0wONDQxf/yT7zt81kY
	 MFJmgnJBdvjyuhd/BgUjztDNY7N5ofxeBQZnzM4DJQPuO05wGr5UkP5zwhCuAfLcVNPMO
	 eNAbNjFHHVPXPLYumUvYy7v9ZUmjQwS/g82hVw3p1iCAklTNnI7REpjmcXS58Hgk71ZCV
	 XUoQtUbygt1mqOEqzErKFs4zRRcD37YjJEm+nBwZN8BLlsKiffeX0VZBLGk45Vtbv7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PrqDyuS7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794256130;
	bh=Dd4zVhkOLDjzbLIJoVjos4aD2QYiZ9/ZuTxNpW2PMZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m5VjCzxeTao8draHunW+Xx+zAE2NNoYsY4GVZu7KSHPG/38TfgHchFY2AEAyFA2Db
	 CBXx2pM3WbMsHKk7ZszP7ZoP2BMGJ/03aSMfk4UEx3CedDL/DSPW4GxF+jThyAbkfn
	 z29LHETSRTBW8R3rBDAxiXlgjtQkzPEOZbyHxsTf8oXTidsimtKAKldxUW1R6dhjFd
	 OtHnu0kIIZi+ui5HOQldeOmur+DF7vMPnIYi/WaPl5eNMiglK9/MzwZX1cDjgkqHOW
	 W55KZm8UxpFJHrzdw1DR5L3yEGy35Ar/zkLzf8+q1NjpNuJjSDvuQU2t7nfqVNWDhG
	 +L8SdNZV7bUJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BAA680DCC;
	Mon,  9 Nov 2026 20:28:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C27851C9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A829E80DCC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GP1VtPmXmfYn for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 20:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB86780DB1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PrqDyuS7
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB86780DB1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:28:47 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so15978795e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794256125; x=1794860925;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dd4zVhkOLDjzbLIJoVjos4aD2QYiZ9/ZuTxNpW2PMZg=;
 b=PrqDyuS7Nlp52hqKxraNoZUvu2NhngZ3o93ye8aFZOjylsbpdvKcDs7sQYzePi8RdD
 0f1TuSHkKHaf+YczMV6kPa6t+fLDpefyvMkLhAl9V37ZfvsSdTKybXyM1+JRkwHvv+E+
 qBFh1xcv334t7IXJOYXue4DyNkxCbggeDVI5nbKe5q0UKCMOvXlY47O34+4ow5twPnuQ
 fYKK5oonj4WdXvH+xFqwfrjq8lMfIrCQzOaI5w14aIMhQwAG2nUCoSKKhQUiIBm6IWJY
 mo7qv+KAt93D6jR36pNyi1gVLyOnrGTFOzgQbPm6TQ3rXzfUjz8t9tLZmUQ+OLdfMMOg
 ttXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256125; x=1794860925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dd4zVhkOLDjzbLIJoVjos4aD2QYiZ9/ZuTxNpW2PMZg=;
 b=TzuHLoxoOfB3grrieGu4iH1lH3WQUIIYITQd3U+BocnfdpHvRUpwvAkf6nZBFeuCqY
 nzJFS78wkfma6tSHLGQz4r+g447qrVSq9UQ9/Iq9iJuLoUCptF6QYPEFz5URYCfoJ70x
 P7LylVUts0sILPfpa76zFx8bamJjQn8EzCMvOv5022FTx+XLBFCASikx1KTCFJnSNpDb
 Gtfq1/W1MQpXJuTQdNTgSd5hbRSSzmn61NKii2vEcNGMdGoqMtKwKc2V64oq576r4I4g
 eEFeb8uscW6aSMGpHcRHxnDiDG2SANYhYcwUon/b9hM2zZSljHAgiiSXrqD2Zx8rMUHX
 CAHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH4x/rQY4PFJInzj3TM26FtMseLWmQNMgp45Y71Zfalb/YN7k4Gxtm3F/nWNYDauRucQpAqyrE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nQQ2FscGtyZNCQBEhh+EmPMLIcHX3b5Ks+AKSbQNsTfEc6XFJ
 p72dAnWAH4+zR/j0M/JW22N7fnBHnFfttO6EWVLgy6I4BNS8/ip654NSu7bxV0Y97t8=
X-Gm-Gg: AYBFou2ehg61Kv+Ks2rnX8kr8auI/OJ1SIKAbSmcrQauv+2gJai/h9aU/ao6rh4336a
 yWNCc+RK2SBcNDXKt1IulTpp3iwqJEcvpku4u7qwUJsF1LB9kufKpX6bhf6flCeWSqB3IISWAKp
 CGC44WHaUy+8WEE4HsthqvzuKuHjevtC+3+F6M1Xt9jxncBUiNq1VOJtpHhoVyJ0FGJ76NFQBwo
 iqEZKG7QBiQ/9yzTjH4I6H2007qyANAx9l4IdzGzfm4076U3QJUoTYlxQmryPaJ99uqYCzBkWyz
 PgDCFIFVLljL37mDhzqt0LfBUlV5pMMBBANAVlwHuUgAlVIbk01EXPQY5IS+6dDMIy9to7dxURk
 dDMFK6RV48wZH0nkfiUXWy20B+4usjrjRcw4f1YXq/diKzRbeWLeKAAop3GvfbK1RZvdFCMZP1n
 ZW+lE1Ief1WoQyPyHKsrg8Eo86FQFwbzSPuvHeBYTdrJRk/muFNzm2nFYH+Jb0CR/SSOdGLmEUz
 mWkIZcBf3nwrtJNs/ev95wz5D3RaE+8WFfHha8WOYHx4DbnK6VXG6wsPhDBjeW0l7oPvbqrMCW6
 bycl2XZUCnJb+W0CC7B7UHcqE34O4zl5N8g99f2nqV9ArGRW7GhthYLdk6PCT2PPGUtJqhuxMNN
 mAKmKpeECvsWczxXAJOqDYlfDwwXxYIqnNjHQ2Usss0m8
X-Received: by 2002:a05:600c:540f:b0:4a1:d766:758 with SMTP id
 5b1f17b1804b1-4ba01dbe8e8mr11260665e9.16.1794256125156; 
 Mon, 09 Nov 2026 12:28:45 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm816478f8f.34.2026.11.09.12.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:28:44 -0800 (PST)
Date: Mon, 9 Nov 2026 21:28:39 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH v2 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Message-ID: <avIsvIJ2CV9kd5o9@macbook.homenet.telecomitalia.it>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <avH_uOLH5Op_WH5j@macbook.homenet.telecomitalia.it>
 <f0f4c3f24d0a9b5afcd72f9fb7ec1d282863d24d.camel@dirkwinkel.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f4c3f24d0a9b5afcd72f9fb7ec1d282863d24d.camel@dirkwinkel.cc>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 18:35:02 +0100, Steffen Dirkwinkel wrote:

> yes, I'd do it with default enabled for SPL, since MT8188 is the only spl
> platform so far:
> 
>   +config MTK_EARLY_CACHES
>   +       bool "Enable caches before relocation"
>   +       depends on ARM64 && !SYS_DCACHE_OFF
>   +       default y if TARGET_MT8188
>   +       help
>   +         Enable the MMU and caches before relocation, using temporary
>   +         page tables.
>   +
>   +config SPL_MTK_EARLY_CACHES
>   +       bool "Enable caches in SPL"
>   +       depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
>   +       default y
>   +       help
>   +         Enable the MMU and caches in SPL and disable them before
>   +         jumping to the next stage.
> 
> 
> 
> Or would you prefer the "if TARGET_MT8188" for SPL_MTK_EARLY_CACHES too?

Yes, please, it makes no difference for existing configurations, but
keeps future ARM64 SPL targets opt-in until validated.

Ciao,

--
Carlo Caione
