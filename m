Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD81CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 23:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10ECF60761;
	Mon,  5 Oct 2026 23:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_GcilZUDDOr; Mon,  5 Oct 2026 23:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 52E2A60642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791242081;
	b=nTg6r4hTkv9suI6EbjvvatM0asjs+Qfg+RROLXOQeFaiRi7Si1uCugcypd8Bxwo51nhg
	 A5CbpGtjQQ/+8ibxHnNrEDH/oyZ1HZNYtIoWxIXmzgYDrlgeC5vQBhxoSr5RdYGV1s6/L
	 Nu9FontdhGhSEdK6ginHS+pwvbUUX+r6WyOEPQy3cX5e8As7MIB+fwnix8tYPguWsbP1b
	 JteCViY+NUgR3WlCFSDI+6Dm3Zi3Hl4gJ8GtavbJlTda7OVTYr7u4QbpfCqwnW5CyMs4r
	 2uDE6l6MU1krPk/kX9veluJp4MOVihz6T98lIedL0DtNijqUCRVFRWmTTmCYSXgnHkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791242081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZB6vsz9TalEJvn+ExtkzPKTwFT/ea6lZFotDmusZ2xU=;
	b=Enx/t4cjsIHIWoOxnl5vNRRa2mucZrzNVD4jjR/6rzRbtDfH+vNtrwECJ8vGuRy2N9Xg
	 1LPkxRmGVgAi0wv/cZbmUVNXAebiLmnzI0cXKBMe6CO0ticEjSCFI/dRdd1Ns0sI+5KSF
	 VLCP0CkhpT9tL0SvEXEDXKOOyJ63vz4YRjf+p2dLT5WzMI1BGVybVIoYa79dM6wretLDB
	 bblLp2PFbNLaBNyQeYNbQiAYfm6nZqAHKfLM2DsNOtwJOGV/HkiuFAcFyLO03Mq3Ioc/t
	 Jcyf6D5u6sOEpm7ENZ2ZuXiOLKTGMiJOFePOyXAzXGxij3PmsSkwONzqQWBRfLSw6Hg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791242081;
	bh=ZB6vsz9TalEJvn+ExtkzPKTwFT/ea6lZFotDmusZ2xU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJIflJ6mMmNbZaOYwIjuj3r5AYzoJLwL/5Gn3oZLbc0sMH+KoIvgwWGnuNASbjapg
	 7s5q5bnJmQid+ySZUvsx6oiCcrzThAzOSmXItDJZXO8M6+unDFm084rqWw1bJBw11s
	 fkos7YTD8pZMNZczhwfr7KiAepJ9TNuWUYFyhz9Bfp6ZAaVNWvSCghadmmhbPfW0zw
	 rkl5l2askQIIQd/QOFZ2cFJPjjJ++/qdWkX3O8pwxxi5NhXzxiMVsm9k4i9EjcEhDX
	 q5CSOMF7uyczMciv+m5CjkqyVZ5syumukwLVsEQAtf7vM9duDTyt4+JX+pM0C+9kpu
	 /4DTefkMS6HJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52E2A60642;
	Mon,  5 Oct 2026 23:14:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 837FC1D2
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 23:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75B00400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 23:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4fUv4U3xzJ9 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 23:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CDDDA40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791241559;
 b=ed/dIVwwFkAT/thWNYLES8qGOn+yKy/jXK6i10WrO4cqr7ap2FBclmDLmdurOHdY+mJC
 0iRExYKbEMaAJyJLEP1M1vbK44rSpF0p32UfmDCOfaTlI1MCVD0vjKGCiYsM4o4UjkUUS
 oJoxjpN/lAzZmDjdFnDa2s6zyttUqHugRZf8kSdiS5NKrIljgJnRMO39Hegs3kwA2uNxs
 F/jaLjMuiDe2qHIPCt0pOouflN7ukfF0IVLNC3csZOW2eM1la6Dh2QYG0Zjepu4zLLbro
 CTx0J4tsupFLDjdUO0bhPFmx7rt9AUAcpeg+0n0P1Bea5EcGD/+yEU1esDBiPZrOsbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791241559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ZB6vsz9TalEJvn+ExtkzPKTwFT/ea6lZFotDmusZ2xU=;
 b=K+/IBwnxkKAlumcqTO59UpCc6hkyn8/qehnPAjciF5p57wFfXecjjCZOJ8Kn3z32JhP0
 CTylnU87z3d1WBpYSu/lGMvlZ+ckBQUhBVQvQ3qobcMlhFYdl+7nP5BmE7iO+LWpA+q55
 oyfxXE2HfriWIaH4aQfK8V3t7PPIng/s7Yv990RFYO0Sa9mmlOdyRKKmdC2/a4BHzKTCf
 0DlLldhpdqptvj8JED6qVda85loPlWSb7Ap2PMGODOg5x3fZLBvw8KSZW1RbpdxYMaM2H
 mwY5mKvbuNl2jw478fpuv3EXAWYQ6V37ig5pz93VCDCmK/uOVkvQcnK7yInzhcTX2ww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lkQNuM0x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lkQNuM0x
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDDDA40042
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 23:05:58 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a29bf27so958666b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791241557; x=1791846357;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZB6vsz9TalEJvn+ExtkzPKTwFT/ea6lZFotDmusZ2xU=;
 b=lkQNuM0xVthtIuJJ5Xo4ayN1JQU+0r7hoMWy+0SRf9TEPo4YGvIBHpyBU8pP13RauN
 GlZ/7IJULRk5tA8Hh8ySOiGV8W18ptWy4dZIJ2j6KEcazyoM8YgOft512ZO8Wwigi7hz
 8N3H56s24shixdI/Dwf+zB4d+TU9okS0KesyHfbb/OBxLn0q5WPKVp1mMa525eVUbrAB
 jhdO5o+qC03cYOnuYD1KY4SNTjPniPdgwVGf0mP64kL45/FxHdPCUT1vQnhh6/ZD/YX5
 NRcblcyGbU93a0lwIF//jU61lg1n2S+Jdc+iOhJEvWZub8KBXVclPIMuexw+n3HCQJRj
 KtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791241557; x=1791846357;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZB6vsz9TalEJvn+ExtkzPKTwFT/ea6lZFotDmusZ2xU=;
 b=fPBgHw7f4AWht+wvzS5nQmpgYaKOSQ6QyXAjW/KvznZ7QKmHMB2NCBNR8fxskG5vq5
 /KVY9tEHTDKR30C+v7M1bBSHUJ+PPYL9H0vxqD2Bj0uxSRPas3+U4QSXs/5Lo8LhjCun
 GM4Prkx3W21R4NZkamEMoQmSBLYjZSVxRYwNeuj2LL8XWScmvsowacUR6QplNDqjDjBq
 gWQfUIQ/whOv6BBE/IjRem4OsVDDgdCOVHZwqps8niZZZjR6KuSdbJdPbiN9gcDduYq8
 7Ey7gs9+9OtJIjK0mwyUzbIDkY/s7ykvMEDYv4cAJCUX93fepgBr7UvdxLeagH0AqATU
 WACQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByK2SPmKQ2vaMEmBl7NdIrKbAmSyvPSR8ogM6jT1gGA6xXqavcNNVyGvP1x9A753XzHSjj5XpE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nN5AVL37vMlF/gJyHYbwdv/UkMzH8iaCXxxZR1jafmxleQ8kpH
 gqQU4JMqWE+o3MGGT0nL8jVpW2SHpNMrEV57kQKFES4yt2bbJDKZo+C1nRn0v9Xtwgg=
X-Gm-Gg: AYBFou0hyseOxYR/Zv1762moK17itcRMShkcXxsmkYT+K1MxXJo+NuFickJx065R4y+
 sFn2GyseWWNudX3wmfD4dwRE1tzdVVsObBMEHIOrEIT9FjSwT254zxWAyAmNMSHBQNYMSlIQJWo
 vAGBkIlqR/5GeJwmDT0kfAurV4ZcSgFV8lbqnTf2aCkW95rjXHsR+UNs0oeQq6q8qCHhK8HLq4T
 wAO3EuDpd37yemTZVnbK/Sf50ZpU0EyV0gVcLznfOw7av4KUSbKcQcXIFXrNsYadsA2JoX1Osrk
 RXtEXENti6ZI6Y5lEmzQJrM6LJ/6jXiSp6KmmARcMHr0zxH8XCcjX301Is7JCEF1EOr4hun+k3R
 UkNRwWpKDLN1QuhuVpbSyRaKIfODmR1XeRawpZz8XkwyXtqFq8fUHjcsD90ePMG4kpDtvHitj84
 ONL2zhr2z6LGNb8Gj5lbm3jbBHY+ifas4KDepS0WHKReYVh5ApS+/eiGAuqj01uAJHxhQble48n
 uZFC3ooor7bmnJgpDXxRvao9w3Nlp98WM7BYfFCp+3kafDM
X-Received: by 2002:a05:6808:4f1f:b0:4fa:8d48:3a6a with SMTP id
 5614622812f47-4fa8d483eb0mr1739340b6e.18.1791241557088; 
 Mon, 05 Oct 2026 16:05:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:33e3:ea0f:8b95:f69b?
 ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16f853cfsm11194598fac.17.2026.10.05.16.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:05:56 -0700 (PDT)
Message-ID: <b8e3b2c2-6eb0-4d16-821d-9e39492ad2ef@baylibre.com>
Date: Mon, 5 Oct 2026 18:05:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm: mediatek: enable SPL fastboot DAs on Genio
 510 and 700
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
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
 <20260930-ccaione-upstream-mt8390-da-v3-2-ae6091c7eda0@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-2-ae6091c7eda0@baylibre.com>
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

On 9/30/26 7:51 AM, Carlo Caione wrote:
> From: Julien Masson <jmasson@baylibre.com>
> 
> Genio 510 and 700 need a way to provision blank eMMC and recover from
> unusable boot firmware without relying on the installed bootloader. Add
> a BootROM-loaded fastboot agent that also prepares the eMMC boot
> settings so newly flashed firmware can boot.
> 

...

> diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..fb6fadb492f
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +&binman {
> +	da: da {
> +		filename = "da.bin";
> +		pad-byte = <0>;
> +
> +/* DA authentication is handled by the BootROM download tooling. */
> +#define MTK_GENIO_SPL_NO_FIT_KEYS
> +#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
> +	};
> +};

Since the download agent and MTK_GENIO_BOOT_IMAGES are mutually exclusive,
could the loader dtsi just check !defined(CONFIG_MTK_BROM_DOWNLOAD_AGENT)
instead of a private MTK_GENIO_SPL_NO_FIT_KEYS define?


> diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
> new file mode 100644
> index 00000000000..e73b6a6b161
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/download_agent.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Masson <jmasson@baylibre.com>
> + */
> +
> +#include <dm/uclass.h>
> +#include <fastboot.h>
> +#include <mmc.h>
> +#include <stdio.h>
> +#include <linux/errno.h>

Also spl.h for spl_board_init() and init.h for board_late_init().

