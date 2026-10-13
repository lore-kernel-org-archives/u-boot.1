Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADDBCA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ACB080C6F;
	Tue, 13 Oct 2026 08:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTjQEcfwmoXE; Tue, 13 Oct 2026 08:44:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1A1B80C93
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881094;
	b=EZ9Td57vBeNiFvEnGwkhRW1BXXN1tvEpM85p3c73oRwGhXgDJo3G2pTK8xORtFOcz+Tw
	 upL1hfyJdU5ZUp49yFP1fNDiiXH5d4FfS48XeHiBG3bs9rhwcYMd0fbOxpZve2AjPXVcE
	 7nY2df9tMFKtSySsEDpeAbsWQS0YvzQg9oLH6vtDo80xtg/8koUzlyKldto8dqwIA07TA
	 C0eUMlOcmcs/E2urkiGIzFEPW/9GPPHrKxPakLlnAKRX60U+mCRzk4P6pv1dkHKx77cjt
	 hSeWQYToNTyLxh5bqTiBlqw/x7BicojC1O+MqXFKUvBORNpaAOFmy5wlGM2tZqGYFQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WjagRRrQDAtWmeMglkTB3x768hHAb+bHF2sKcvxT2Gg=;
	b=h5XPw1EJcsXk5geH0+S5t7usA/G+cfWHOPFyUpG7pAMRL2kZLhZWQNerXIgstO2gJID5
	 Per4hx+uQVziiZUiz3ktaxITX96CtF/s96QjtoB9BXPuayla0Z6mqBXOQLCngmJxSGJXJ
	 9q4mQwEZ9Pws2Wt9DaFRJtZdbKnfHL+7I9eNasoTLKj1YfZ9hghTFhMDi4MH+MvSxvvJs
	 V0jrXCDPpiPtaQYFojnljCNefsZsu7lrBtTJd7JW0tT4VPgZ6StCeopsgD/lIJjGiBPvX
	 AbyZkyY1S8IXt+JUbb+4Pb29Gs3H2TMczNlMtA8kxqF5T+NPUkhLtaQAogzumaSBMgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881094;
	bh=WjagRRrQDAtWmeMglkTB3x768hHAb+bHF2sKcvxT2Gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/BaRUEejLj6UodofvBB8u7Qgg44wXWwYBIpFHJ2uXkKj4xDRFuEIP0sMvGWDL89h
	 DvXxVWu94NqrLJGhovowOjlWvuKE9vbsRVozZuB/GEYdsQEMoZ8K9g6VndbM3Zmn57
	 IzMu8Ich+a/O+V9v5OYY4yPI8wnaY9bdwSQAKezZEmREvNKwiI9Tynxpe0LgTlnZAZ
	 E0mtaTIytYP3x4FCk+7NxzJWit0WZfOe3rmWgOLZa3YzUkSexmwD9AO5M38fJFP/mu
	 yf4R6gwIZkEiOdQqdrgEUR/9BC1TjWLPLWBlU2WFdDCh9wYJUXjhHR3ZR963AIB5PG
	 Gn4Xr3Hzk2mDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1A1B80C93;
	Tue, 13 Oct 2026 08:44:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5ED6129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5D3F406A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3PETFNaB85e for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0BDA406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881092;
 b=pNe1oRh3H02J+HFUjowUI46p/QGbrdxVVHWna/Xd0M1UuylirjbctMYk1e0Fjc6tCtDH
 MXuDzoHl3HyUCMyV3Kw/Dlf81uPS/ua3daaLgEwvA78C+HhjVwXtOLYtXc0YNbexoAk7z
 /O9tpJI6KilPWyAntMJZG1pFr2EULc1Xa5l4mZfGsh2m8XitUCdMym42rdZjKzwGflfWg
 Prxf0rfmIA0LxWCTGGH9VyAeoITpnZhKQecN9ms+ywc0dYi3rCt5i7C8dDBV/Q9HryKAH
 zrK2KqlZKmBWY0XHv3TQ0nXFcG1ctmz+bJipFef430xOW6zFChqPhXAFeHuu3PFcoNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881092;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=WjagRRrQDAtWmeMglkTB3x768hHAb+bHF2sKcvxT2Gg=;
 b=DIilR7XqSRGmd/1tcwEFDT8Iu1Q9hlw+4G5s3mVGmbUaPEcyK1uuJAZ2YcNvjmgAR/JY
 lQ+GOviCQ8N4AwrL0Fr/a7MNjURkQksP4cZO0S5tcH0ztgi9T69Mug8wMQLfp4nV+YKct
 agnY+6eRhNtx0eeDbZlfiGhhr64H0OeizqXsdQmkczDRy3csmuRJXzRmC6gtUZC/fq7eA
 W2QoofEQHTeRhhfi3ECudYk8HTgY9MXyydkiAiCaIquQULD4CKVWq1riG8cm9LcoE6xel
 q4LFXR10p2sU8qdIXkLiYtQhU+Mur+DFamsbNYtm+D+oZ6SCl2ubsSrpPQ/bX9lwxHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=obd7FkaI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=obd7FkaI
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0BDA406AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:51 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so16368305e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791881089; x=1792485889;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WjagRRrQDAtWmeMglkTB3x768hHAb+bHF2sKcvxT2Gg=;
 b=obd7FkaIMwc/nfBRdH1tXD4rngtXOUxjWtcwSlcIAtnuindc8qBvMqGslopR0JEQbo
 WmmsTwWBZepRfhclm5nJegPgIAnXldbQI0dRbJdd0tF79001QoxGaDAs7okybZ25FR6x
 Pn7LYAVRkK8wmn9LW/hWUtnoA59eKJCjuYfhRz95eeJSmkxSKd2dtJAQT1fSPnhqACW2
 UOS5C2mv6KmuAFRHj/dFSnsqzRGuDOIQM2izAwVVPQltMIGVdjjw4YcKfLZRyDrB+nTa
 yA0c40O5yIVWT1FtWnqx6WpAm3MTezZDnUWEBNW1PDe76ZTK6/z99NDj4pLk5NBxBTAc
 MoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881089; x=1792485889;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WjagRRrQDAtWmeMglkTB3x768hHAb+bHF2sKcvxT2Gg=;
 b=dLeNSZftr+C7BRQ/y43oWc4u1Q0J6b7HLi6R3lTQWUYZmoUl0Ru3HFSKtuGTbicwV6
 HYbHo9+LwNGC15iKzK7FJpq/v+dpXV9Eqd4usltXqrQXCE1WQDvVPKU4jptZmrENUndJ
 s7F9/NwA1Yi/rNTlvLKIdyEqWZTzmlu5cugpTY2I5r8l8ztovvCS2azAh99VP1AsagQp
 lLnWrN3zVMCm5vIca9ufoJeBEKo+nGDoFckrnEs0rOUpSQPDibhxvXNQ1waCxoFEDhgY
 Mt6cv5KivexlnmTitMiGEnbbzAj6IYh0XHNimzcGKQZYCHeBH4LCdzBrb45EVMGijaeC
 GODg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjP9asvGSF4bD5IHNc1K3bVJI2oKhYQWLBwd/s1X0lpy7/0vB72qKQgcfiZIxeVFTHmID4iwI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLx1yrc8NyQ3k1aOBc7MLql8rjEWqimmkS4nnqYIINnfN17jjBC
 M+0iGDamNw7PqF9vS7yz9SIG2o3L4LX+fL2QZgCG1KeGxCusiJmHUCu3
X-Gm-Gg: AYBFou2DnVBK2+o20Z7rtxmXTUOVPn0XWmHEm4mFagMUrduXKJlCrQrKDbTYKU3mwwI
 hCEjq3ljmzzl9Ks8hAfavsQDT5iJYGYpbPIUXDs9C1KNP5ElZWYDIc6wHJC2wz80VPgial+kAJP
 6RU9bys6WBvo7o6q2tbIBNNIVdDPudaqnap7c52GK/fOfSsb7Uz39jPifztX7oel+osCWmI8QlH
 dFHF9t+azjF0gzwFb3IJ7O8HKE7B2kUFCEnD5cQZZClQXgKlwRnGDloVrA8d0tu71n/f3sNt7b5
 jKYL8uNA0DcqhLLZeV+hypmgMMxg7YHNnfgLWgG+3HumOMp6ckAY598a/JIo15tdQ9z5enlbqmE
 Exkabjt6o7yddtM4DJTrW+gqDp7RglV/4lpep1BsShUd3v7xjqHuAbI2mFzNwJwBDY+ZL+T3V66
 BsAUR31F3UAzjqSDx3AdqAK7g2HPrlr1AWjnqrYVkKIp/O4rBsZoX++Qht4DldRYKNl1gK+xaci
 L1ImfSFpUM0wrOO74pyfqOAxk5PDYrDrtpaB5ve0L3oDVm93fA+VP2NQw==
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id
 5b1f17b1804b1-4a18e49c331mr232261785e9.14.1791881088782; 
 Tue, 13 Oct 2026 01:44:48 -0700 (PDT)
Received: from [192.168.1.3] (host-80-180-152-220.retail.telecomitalia.it.
 [80.180.152.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm352928215e9.4.2026.10.13.01.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 01:44:47 -0700 (PDT)
Message-ID: <6b222f11-e8f8-4df6-9caa-8e894d8fcc3c@gmail.com>
Date: Tue, 13 Oct 2026 10:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] toradex: {aquila, smarc, verdin}-imx95: Enable caches
 in SPL
To: ye.li@oss.nxp.com, festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20261010075951.3939861-1-ye.li@oss.nxp.com>
 <20261010075951.3939861-2-ye.li@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261010075951.3939861-2-ye.li@oss.nxp.com>
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



On 10/10/26 09:59, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> To enable icache and dcache in SPL, add the definition of secure DDR
> space which could be accessed by SPL and move arch_cpu_init before
> spl_early_init.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>  board/toradex/aquila-imx95/spl.c      | 4 ++--
>  board/toradex/smarc-imx95/spl.c       | 4 ++--
>  board/toradex/verdin-imx95/spl.c      | 4 ++--
>  include/configs/aquila-imx95.h        | 2 +-
>  include/configs/toradex-smarc-imx95.h | 3 +++
>  include/configs/verdin-imx95.h        | 3 +++
>  6 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/board/toradex/aquila-imx95/spl.c b/board/toradex/aquila-imx95/spl.c
> [...]
Hello Ye,

Nit: spaces instead of tabs after the added #defines in
toradex-smarc-imx95.h and verdin-imx95.h.

Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
