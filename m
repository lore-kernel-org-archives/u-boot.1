Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D5606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TGQdwPm+;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Vj4uSfAd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAEF460DEC;
	Thu, 19 Nov 2026 19:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQwXnzHGLmHY; Thu, 19 Nov 2026 19:03:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CBD160DD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795115013;
	b=M1ZWDy1UrFXQkVml0OPbG0snNFlIzoZrlxXOiG2UmDrQ1Jy3ST/0XqOcCjuVnYXEHHIV
	 c/qnov+s9R3HW0F/zPyOrlhxwiK4ouy7HwUDnSSWhn7XXn1RMrxApfBqoR6DilbWM0lo6
	 MYGEntgzrQUFaEHzNGq4LF0C6d+oSpqoMSrnYnurxJJVL5hi/fOkCz/AoqzsrLLzqwxWG
	 BeWaJYcJz3FGnCnk/WX74RsxVMBBYAZrvD4AqgmNWZLUhLAlNDaUqnEGxx+ObzYuDJdHa
	 zDSlPUu5q3wztqQJoFks+iAG2S0261NxpB2L+eniukBKo8u94NFSPv3JZzqW7G+Ferg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795115013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rkslDLSZx1sX4xw+07e1hmIDNrBG5bD4ilLjt+clDwo=;
	b=evmPne3jrIXGsOlULvFHrn/HFyeNrBVkPdmy3oLFN++3PKA+LxAHz6x27nWYxR8fm8gu
	 X5ZNgiJML/8PPXTDkc9/o4f213YGyPDl0mlI0kZ7s1KyVaq8pY4QVeA32EVMMLroWHFVq
	 edJYcI1muRqk0TxJ+8qSUYlQODiVl9O37WTwqzIPwwXK3bqU4g+I/IfPMpEAuo274/6I7
	 yL7z4tgKYXnLko9XXJqYT+QEUmkuorg/Leu+miQecHEoRgUzijCRxUCk+5DVtB51ac8KT
	 dK33vUdrRymVeNZUirKa9qnu+z4yiIwo6CvHBEYBs/h9F0xUgZTc0uu40cso+bjab0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795115013;
	bh=rkslDLSZx1sX4xw+07e1hmIDNrBG5bD4ilLjt+clDwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TGQdwPm++JKy8+isOpxIFi6/PuLzOYZixCoSz+wlDtfMhqBcTJ9Ciu6y2cUPCv2rT
	 kjt4fRtVehI022CBOMtdXN3+uQ/O8ovyGJuuy9jjDK6C7Kqel6GCpDb6KTDEZbjVDe
	 bE9b42KWAyrHGV00CRLwj8chyyFbYmRk7OwFxKzDoCBPK9NvD44lnoSRuBZrPMkM/s
	 Rzo4SnROsAlP41zsb2mT8JfUGg2LvJYUPyG7Y93SXdOO3qV6nr08WiiP8Mm18H1OQY
	 8uQIwsuXBwQyIydt9wzBruGHjVfeVMmIIvSsTK8PVk3/Z1uG34oXcwwPRT1SwNOrdO
	 Ix3q7L6z9I5Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CBD160DD2;
	Thu, 19 Nov 2026 19:03:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 615AE2F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5387581375
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7NGdzPoZkJL for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 19:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71B2E8133F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vj4uSfAd
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71B2E8133F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:03:30 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so104795e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795115009; x=1795719809;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rkslDLSZx1sX4xw+07e1hmIDNrBG5bD4ilLjt+clDwo=;
 b=Vj4uSfAdRQUxQKTjstUiZdY5VudilNfAdkEVmL3mNWOJo+GPRldrzkdzH4HqTPMYRn
 7THndVIUh60HAZ8zKyL/q4ebNY2Objd5yFrOLbVEd+5EmonvaqilVRNJL4bZe9SubkiD
 gCd5MEV99fVa2jvLI/cAJyBH6t8R2QaGWDnDjdk5iZUXntW7OPKi/Iq1Gte7hNaGHeqX
 AzDWGzG3upp82vjdWiB7hocgbNMkD2v7+WoVSBvhDFRU7Ls9jg7twWFm2Cb9g0nwvRtp
 Mqkv4VXxqHRUWzncY9MLZA/R7m+Okkon3HLUwKqNpy9YbcPJfaJ4dnp1uCRWOozBliGB
 aISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795115009; x=1795719809;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rkslDLSZx1sX4xw+07e1hmIDNrBG5bD4ilLjt+clDwo=;
 b=GryS5uyTGFxA968zh1DSKOhd40xz7JCJBoYw+TpyFabgm42mG+cMGEYNK5gpyOo9lj
 VstH5kZ6Ah+EPxaW5p03+sbF1rkI2B5pA4EkI+9eBc8tdjEvb7oWJsOBtJqXVboMOyml
 q4JP7s0xdmYH4KcEaf/g+zRy4xena7QsNJWDZzoNNlTrTeQ/vfyptK1A+AqsfrSHMAFk
 lU5Fe1OjlIhwab8lrQl8UdvYErFeu9NGLreyec1cVYREGcRs01OiXIfR+Qhm/PhixE5Q
 uYu1TvhKtfiRzrbD8W2UD77yRA2tezGeHQBbX9oB4RvdWeIn+CqEJTixxaeUnEwSm2z2
 lY+g==
X-Forwarded-Encrypted: i=1;
 AL+hErEjZ0OfPetvxrCAILPOY4diPCgcpsEWxWJ3W+qPY0I8MxqERIk9LtCxjNBUiukOA7dP43mx+Pc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+X8NFExmm7h12owX/1/4IQdkGRhEKbOPSSdJ30GJOTsdyBrUjn
 eDOF76rNR1j2TUUPmG0KwpfYnZicgbOFTDMRLwQ/SmMZOtKsLgatvE0snPUEqofDTQA=
X-Gm-Gg: AYBFou3tN0DKg8W43KSeVWf0RbloJuF6QthLuaI4igwslUxt+z9nBI9TnoFKQFEdBsf
 7dfZDUy/R3SHUPFlv4fw+3vPIO2Jsphqf5sdBOpGRvXs5l4rI9ArQHQz1+d1MOg7vDdL9cE8LoC
 6jGxkOp++MJ4mrtKjCqQFlOIF1TMxkQ+dp1KNoa2YggYb/EKQdoBwWnw9duZZCP4CehnsmNiO3z
 bWp8HJFCAfvZJUd0D0rWZ46yuBgREXdsEFej83vshksnO4bVrwKUCKI88Gfco2K2NwbIEsM/ubj
 dR9KRkgjL+yZf6XuRTQ/qiBduNUmRNrxo5cP/uTh/IdgOy12ycJFgjyrvZkufmETNgsKdP/WDAR
 7vWaxa4E2Sv/Po+uIogBGhRx+Y99+pXXKEASds9G7WCA0j8XoWWbfbb2QvfL07poAjTGvlQmy++
 bTPEJE1xFOjQkxTgntG5swTeZwp/OGUq7IYI9YcQhHKZ0yf5FVIwOQ1I6mKnKPUAFdMn+FjUJNj
 6PNild9iW/QkZfKIFORBsQxsUkg08CfgfSL+WaP4HErXigR1Rd/rUsnVAoN+SMf8vcBIWvTX+p1
 /Nyzy9YQqSG/pvGpiMhMZBAnFwu8LqMfw/jebo4HZMp1NnvpUTm8G5ikSz4ywqK9lf1rxOTbkcR
 7zwBiXQ5vBqlJuKwD9A4XNnquLq4lM/GYqoXiprVxeHni3g==
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb8880ad68mr10875305e9.5.1795115008688; 
 Thu, 19 Nov 2026 11:03:28 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm1255837f8f.44.2026.11.19.11.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 11:03:27 -0800 (PST)
Date: Thu, 19 Nov 2026 20:03:24 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Steffen Dirkwinkel <lists@steffen.cc>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
Message-ID: <av9GMP6Bhx50_hsK@macbook.homenet.telecomitalia.it>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
 <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
 <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
 <c84de235-1480-4747-9509-65af404cc9d4@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84de235-1480-4747-9509-65af404cc9d4@baylibre.com>
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

On Thu, Nov 19, 2026 at 10:07:53 +0100, David Lechner wrote:

[...] 

> Carlo, For Genio 720, I was not able to make a U-Boot proper download agent
> that fit so I'm wondering if we just just drop it on 700 so that there is
> just SPL download agent on all targets to keep things simple and consistent.

Can we just drop it if/when that becomes a real burden? I'm not entirely
happy to just drop it for the sake of cleaning up things around.

[...]

> > 3. Going back to v1 (fixed address used): This has the smallest image and no
> > allocations but we'd have to avoid reusing the address range for something else
> > in early boot
> 
> I would be OK with this option too. I think Carlo's objection was more about
> hard-coding the address than the concept in general, is that right?

That is right. I'm fine making that a config option.

Cheers,

--
Carlo Caione
