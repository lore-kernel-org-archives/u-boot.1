Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81626C02190
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 05:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97BF807B3;
	Fri, 31 Jan 2025 06:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738300859;
	bh=5kLYN0JWcg0WtK0ijHKGMJe5Lq9uOFz3rIfIarrl5P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=w3yrnhuGYwLiwF+z0E4BmE6XT3HQQblJqT+RohoAu3Hcw7GVF4s6YCHfMpA2o0Vfn
	 DTZDo+9/BEYYGEVEX7cj9WVEj/l5GyOiaVllM9WPglMKNrDi0A3ARUHrZivNBGr/v3
	 l1HCAQaN2FEIOPgEC450CQkEcYiQP87VQ5ERldiLKoO//YhrXXGeEOr0jNX4GikLcK
	 fhh19s/DBwTcN3f/3CPzwDhjZgW2g09duzBRP8O6UcRZhvpv1maHRySmEmqeV7tLZv
	 PT0J+MZpQPEsKLp0+Imo7zUXzps35nG95NWW3+DHT2BKQGgYCaXYpEppeknDLniGLv
	 lA8cMJUo0Dxdg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2450580805; Fri, 31 Jan 2025 06:20:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101F3805DA
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 06:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="c5OPjPQn"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8B7CB10382D08; Fri, 31 Jan 2025 06:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738300854; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kLYN0JWcg0WtK0ijHKGMJe5Lq9uOFz3rIfIarrl5P4=;
 b=c5OPjPQny8exlvZtj0daAXHfnntgxOAnXjc/ZGqT35fXklUZn5WpTpiVJpoJ8evn4uFbbB
 2B4yH5WneSg8dhK0GIhcuaWfeFgHLq1ZMNbP5onwAy/7o/cdlEg0UJ7jB6iwg7BG60KWEW
 drHUs9ykPs7Fg2za0IDM5CrnLI0U9tqNS1qvXQWqVn93u/jNBctD1ufR3DTcWCHjqSGxUW
 fwhsJpz0RKqFciv4+zQewcKczbMplZ1Hbb74iN2dCG98JkgXiKnXcVKWFAJ1Lt+MyEL7qp
 y77DfhNYhOnt+9R0BT/rq0vuFHWoDpIWko5/msKn+vag808tDn1UslBF/99z/Q==
Message-ID: <d24ef4ad-d124-0ec6-d8ca-07e2d4dc1cd9@denx.de>
Date: Fri, 31 Jan 2025 06:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] siemens: common: Make DDR_SI_TEST depend on
 TARGET_CAPRICORN
Content-Language: en-US
To: 1425075683@qq.com
Cc: Enrico Leto <enrico.leto@siemens.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Liya,

On 31.01.25 01:52, 1425075683@qq.com wrote:
> From: Liya Huang <1425075683@qq.com>
> 
> The DDR_SI_TEST config option is only relevant to the i.MX8 Capricorn
> board.
> Make DDR_SI_TEST depend on DDR_SI_TEST so that it does not show up
> on other targets.
> 
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
> 
> Changes in v2:
> - Replace depends on ARCH_IMX8 with depends on TARGET_CAPRICORN as suggested
> - Modify commit log
> 
>   board/siemens/common/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
