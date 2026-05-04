Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE318FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334328464D;
	Mon,  4 May 2026 14:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="UCJtx8Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D0384653; Mon,  4 May 2026 14:54:37 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CC48460E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B19041142BB; Mon,  4 May 2026 14:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777899275;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ac7jvPFycxObyH/JyHcyF8g52N+dK8EnpuVAIDNIJvk=;
 b=UCJtx8SuUJ/GmeC/x7h54lSQUmZB2nr1QgfW3rMhgWluIYiuExLv9OOptfR2kC7d6IniJf
 l4YKzy2Bna24cFQk+8Nc48sKhLPHIIs64mlpWOFl93uHp0yNqD182png5N2mk6L2A99Zn2
 /M1rMlpfdOlzZBAsPyLAHRR1/P82KGW+9jZTUdYBUKhqcyt0Qcp9YiG7y28WYOmMyPEJ9i
 zHQXI8s7Y+C5azgKa67ZjTjco55VwAnlYuZZIMnt3OcZOeVOk35ZAlJk5yjE4JUfQG0uZc
 Xt/vSr+hC8Hr4ym1hqdMLH9Gt+JCYqWkwP51gBzRXEMFnIKFaHzLKGUvMMo0pg==
Message-ID: <62eb3b81-d0ba-fb59-6953-01320e3fc7de@nabladev.com>
Date: Mon, 4 May 2026 14:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/6] aristainetos2: Quote rescue_reason in rescueboot test
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <20260503204936.3151124-1-sjg@chromium.org>
 <20260503204936.3151124-7-sjg@chromium.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260503204936.3151124-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 03.05.26 22:49, Simon Glass wrote:
> The rescueboot script optionally runs a per-board rescue_reason hook
> with:
> 
>      if test -n ${rescue_reason}; then run rescue_reason; fi;
> 
> The default state is "no rescue reason script", i.e. rescue_reason
> unset.  The expression then expands to 'test -n' with no operand and
> relies on a U-Boot 'test' quirk that treats a missing operand as
> false to skip the run.
> 
> Quote the variable so an unset rescue_reason expands to 'test -n ""'
> and the emptiness check is explicit.
> 
> Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/configs/aristainetos2.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
