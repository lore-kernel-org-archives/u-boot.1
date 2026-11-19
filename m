Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EA606A337
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ps2ZP+5y;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VctDj4s6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 797BF60E22;
	Thu, 19 Nov 2026 21:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pAKXMuhGYMd; Thu, 19 Nov 2026 21:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C23916072A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795124350;
	b=c/i13tUvj6AF1PwsIS0dNZ8m64oJh84+ydFtzVeWzGuiyUTx8CyhuMGuZ5zMI6hFFPgy
	 NFO1qWafF/bYu+F2fKeZuonGOloiO0QKZWpg0W30bK6QptOinFcGl4QPFwU4AUQ2flcR9
	 PIcPdeV1d/Z9cfObtUWZi/A6JEgwhhUjb3yhQy62qXTejvan1BdESpcY3CqTHXPGD3sR1
	 /hXk04LBP8wrgXZ9+6OHXc+6EvIY1sUEkjfiXS0dtdIabF/8EJAgD7QQLt7zqzgoeuinA
	 W+yk4knqAKtrzIlQex0I9kwY8bFKJF38uv135F+zMovW4akfdpOGOHSNIKi/YZSfxPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3FWCvYOpC2oA57xsW9ggcFUvMhgJUQan595B3uUrTrA=;
	b=Yat11poPjtrp38eLEQSDCka0c/JGF8CNRe38ZrR8OtOXR3A9jicussgCbs8meCwfUmp5
	 GZPjs9gCNPY737nazZwN0OSBfmCDdRox5sNwW+pUYrg0OHtAM4GFcu3GrDW4FUh7r9z1z
	 gWvcRpGHLfkvXQJDWqtd1DBCeEkFjGWdpj3VUSmC8UDHvu6DQqeI1j0zNcMx00f3whPHm
	 Vg06NRXLQyJ6inqGPxSpWuN2emqv4sz2ITYDSOzE41ghcwCOSZITGhycUWWWDF7tHkjKx
	 Dy/iHT5kmKNizgAvka0MM6rjNwHgYcYi8pIzPPEwR/qe5+Q8Ib3b9hLLgV++M/+XA0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795124349;
	bh=3FWCvYOpC2oA57xsW9ggcFUvMhgJUQan595B3uUrTrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ps2ZP+5ybpaIYer/7a8wN/RpWBHv1186yk5GeOmZ/fMQ03kLYJv2OiUlOa74waXpm
	 b7mUKm6AX4SqQKC/kcdSmeT3JNRCo7Z/2c6U8CkH524FoLSatRVKpbLZ5KwutJe9ky
	 p9MypjlkHDvse2xldNLjKtikwvVXqRSz3S81ocA4nEeegycpDn29RibTDtcU/l/v1Q
	 zEYhIYC7HxzAgHc4Op2Iwf7Th5CFvIB8G/tCW7AwQvdSkwQdO2RPLAiUqyAN+1YKf0
	 73jjVz/2lfu61A4A7C2QtodmUIC5SEDjUPl9hbd6VVc1B5IKCKz97AbgnQyW2q3yCS
	 NbtxcqoE2kbpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C23916072A;
	Thu, 19 Nov 2026 21:39:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 218B079D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F4C681107
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STL4szKy-8Qb for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D557810F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VctDj4s6
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D557810F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:07 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-57309bd40b1so189820b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795124346; x=1795729146;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3FWCvYOpC2oA57xsW9ggcFUvMhgJUQan595B3uUrTrA=;
 b=VctDj4s6m85n/NsZKbTaE/HCMU5AsY75jLkTtdA4rbSOBgV83zP6ZrIij3Mxt78Zma
 gvA8VAd7kf0D/1Hzwazr39av9qCwVnEx0FfygiHhi8NQ6hgbdvRzxHrPdAu8FQG8k1b7
 wM6e38UQM0HfRuK4VWOkp/viXMP9tMcNdifG5R4MVDGC0/P2OyJRzStZaHaiUoisus/C
 sMLr4I2EkTK91U56fTk6obBuGf/HUBQk8HSdyk4mdGEJWFVtpydtHsP7hJs9qN9UoWyl
 i03S/9T5O/yy0O9IEo/lQgkFoUuq33Pir6fMua4OQ4A4wFGXLq39+dHX5Y0ZfoImyYQA
 RCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124346; x=1795729146;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FWCvYOpC2oA57xsW9ggcFUvMhgJUQan595B3uUrTrA=;
 b=XhRGGq0DYqNj1c6R02jUOIedsAKrMd23IyA3jX3twsfPCuozTSwsglBEVYMJ/V0qJH
 /3n2DfU+U3pWBDCioiAYwObuQsvkNuTcM6/lzR0TQoUMb5SGgpaFkpBlp/v5gBjWn4ze
 MbsgzzmF3OgREpz8tLap5ijzE0wYk9Qr8Owdmfkiz24wooAC0638BZB1RrkAE7FSDoOT
 xz2LcpWDwOgBB4/Kv6vj/9gqUFBaljdU+4HP8td+250D0qxPPoX2bYQPX5lZLqVSWHEh
 +Hp6KKdPYyJzJ2zGP/o+IrAd5q5uX3yOdqlZBiZXHrG2HCEfyO3IB7DYHYZAPJ8myUuK
 DbMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHckPvVfIFOa6oVGfseJYmqCZ4MVLQ7zuKE/L0R9PW8oB5NUINE9RcYGgW9xudvTioHf4dVdDQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/OKB97lbStLsFx1HPDSZzcEhXz+ps3AJbaycEdCpR/VxBY8DbD
 LnfP2PmXs0TsGJGE2XWVwGStmvV4YEEeRco/enascjGiElZn231g6Nw4UO+YOBV7Bsc=
X-Gm-Gg: AYBFou2macBFOlg90fVky0el+DomU4oF6QAjhH4aYt6hl5yhc8o28pcc4aKZ2LpYd0e
 W8Llo/q+49DnqtZRTAVaBrHkln9QQFcRutwvgpkgN7wj8lE2g59FTCeQsO/mN3MLJR42d9BPugl
 zOKj/RHwbByDa7kB9dweieP0hKXnj0gd4vloiZokWyeuOGG6kYF1IsKrIXfgMwFfsQJ0r0OgeBE
 6EuFp3YsU6jcIBUCm07+0e8fU53zuKu72HjZfNCuHNHhdxtlxohT7B8Pyi0766BAGdaF034Hqjl
 zLEmR9aexpvaxHirnS4hKqphrm8TQE7ix+Hlp8ihJ/wSKq2yRZncZr9xpsov8ZPGOPRZT41sAtp
 LyozpJy8TKmiy/1lpfPb+lU5WKlrNhfe3/a58LeMpsPbX9J/QqmYKcJKZrqvuBiWUUgf+n9alod
 NquALIU/k1hV3N163z9S6HK07VORmryIhaRlJtW/ly9IlnYHXi/33B0wsyE8Jxq18244cWY1Ova
 AtmVon19xCXp4D/nto4Kd5GVAofPhRu3oscDCFN3HwcWbjuRXbZD84n8h7blZasogz+PxVvdpVa
 9pnDhK5cypiJib81r44nm0sTE8TELNmDJ0Mr7Uw+cleiVkntb7Z4AfB9TeIczUQKvIJ0o2oBm+q
 VyOI=
X-Received: by 2002:a05:6808:150e:b0:573:b76a:32c8 with SMTP id
 5614622812f47-57a0bc9fcc5mr1672706b6e.42.1795124346223; 
 Thu, 19 Nov 2026 13:39:06 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm585053b6e.3.2026.11.19.13.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:39:04 -0800 (PST)
Message-ID: <0b0913d7-1b98-4595-bdc7-6a1972264e5b@baylibre.com>
Date: Thu, 19 Nov 2026 15:39:03 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] i2c: mediatek: skip DMA for address-only probes
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-3-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-3-916dd6cc8d1a@baylibre.com>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> An address-only probe has no payload. Starting DMA anyway leaves it
> active on the Genio 720, so the probe succeeds but the next read times
> out. Run the probe with DMA disabled.

Since we only added support for Genio 720 in the previous patch, is this
really a fix? Fixes should come before new features in the series if it
really is a fix.

> 
> Fixes: 9ad71f63401b ("i2c: add support for MediaTek I2C interface")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
