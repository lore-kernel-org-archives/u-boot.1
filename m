Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3162606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lTiPyqsI;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jKtO4JR3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A4B280D91;
	Mon, 26 Oct 2026 10:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fPVrh_WkZlF; Mon, 26 Oct 2026 10:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C456580D58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793009707;
	b=UeJoTuXb+SFxph9ozswgpDnSLGjRjdneT4IoLD5LRcsUlhbDBp/c/mFXpB5AMAR4e8mh
	 ogEsxfQcW2csuR+VcON+P7zUNuwvn42mKWWq22CTSBURt1KcHED1vXHpy62QhcIdjvnTi
	 shkOHga4rkUtkLmqGwNCFxWKE76Jo9/fGewAtS2V5OdkeFfUNjwu3X6PAJNRIhxqaGsWb
	 tuv0rY71fw35JUyRs0R9iWAIa3CgJ9uvxhynrnWNj4zAIpLwinIzdl9QT4IzWGSx4IzVj
	 cPD+ohwXLSfbpBQYpBeQRVtL2oeEvYtOxkbPIUOAEAa/QIVc5iJe/tEkIHxxV/QQ0rw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793009707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
	b=LdZ9E0BYlxbSyNXUCQUIxjKB5DGoafY1gfClhMXUO5RWYvr6s0QqiUDOAmzj2sdEo8ec
	 ev3PKu5aLioSzlQ3WOy917RLOsob9PSQvf5YkGXyXmSqxvtc0H6vI6dHtRNKA7y7kyclE
	 RLuYtP8gC3Piq0uoNwCI69GU5PrcqsgyNkK01wzIgmx8HxwxikqDFPawSkS913yBYmYu7
	 5jA8tklTJJtX0586xMSMYaqeQrkgQIlbviNQi9YN57uvN0lFlAQmf2/GEzn9zYPt9OwPg
	 JdQzX9iD52eL63UyVHjYaw8vK9U/RQBP/tUksumKB3MqPV9kikiZscIrBF1ibeTcKkA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793009707;
	bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lTiPyqsIcasobdez8svG42I9cHT+G5/BjqhICUiBzWESTZjC7RzOCwlQh8B0e9qd9
	 lz1rOK8RFTnhXKx1GDqYdSHGa3w3AYlzG6Zgb/jaDufQQaLm1o2J49F/qjjUv+5gM8
	 ZN97Mdu3XzO5CyUqS9TPARfzxfg2qr0H7eAntnDkco4eSBqCyAwoANKk7oiDvN+JqM
	 D46L0EVNR8pFAB01mF5WJ2wQImqOzEJ6rt0EuVZZLUZZeSQxLtUJTP3WalpSOsPK8R
	 glyod0bAjT6zyzbxnoWjli1hYPpx/KU0oeGef1N1CePH+oflrpjU/7xO4MZHkYYDOX
	 ynxeTjsRBs+DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C456580D58;
	Mon, 26 Oct 2026 10:15:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 377D6356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 295BD405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id weh2b7PNuDpa for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 10:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73C1C405DC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793009705;
 b=eVllgdH+4+eRPNqiZXFYMulZdPF6BdjwvV9kC8tm9fw+jAmVZtMDPuZ44F/fz8ikLBnJ
 bY+WPK5fc4CS4SM8Tk1KMKG8XOudXMOP7xIoDWpqTOdXC2Ljn/nafIGxGbNixiwc3YiBy
 m0plCFi8alo6x6tlBfpexAQ+Z6CL0Xb29bRHFokJOv5JA2cVMV1gIauChCHp3fOrQJdby
 TWaQ3dGJW3LvBAhloSjAXExvCXDdcvX6UeV74fv+RRr+NuuEVuRU6Csb+U05AdlVhpUX0
 uJ5gugJLiMAwcYOfgFaU5QTxOwfr9/1N4HvqhEojgS2UUcXZCKmoF9w1hBDM0W1YEDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793009705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
 b=WatKf8WrVIXu2HYWZADKTf6DYwZL5CVj6A314FS8jzUt3I93u0BlemETYv/rIf9qXAtR
 +XEiNLoI+KGTNkPEu0eLpwHMiNVVQbjAVi8MrgjFJBu9uEA63aNoz67j33Q9GPua0KkBy
 MqWvjBxFZe+rua+cCV25+ZT7gxHybfPlBtcCoRYTgYDPIQcyMO8hmPgCli3FoNNbtJpQM
 2mPHViurhjskO9OsXrOgeUSA1hqEWObBS2J80e4aTBASGZ1wLY4sAZ6TgtbXw410cw3k4
 KCubUXg15cz2isxNDGIOcV8JgSkUWSloCKKmd5tuRnbxKAu+ELRfBlZvpHnQevZGt5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jKtO4JR3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jKtO4JR3
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73C1C405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:15:02 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1783156a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 03:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009702; cv=none;
 d=google.com; s=arc-20260327;
 b=GN+YJJrnOOGGgILhH8Y134EcRZCSStfGfv7r7Mt1xYix+RyGru9Shwt+6HMfETiWFJ
 ucX7M+Po5Kw66doiIHbJPnmZadbkC3/yNudFH/LXfpCuzDH0hmTusykHV5QNX921QUDO
 INgEBiwkmEncH4EtiJOlejq9Nl+GAy2Ld3oQ0tR0cuJaEvNBcBcoinDouLYwUjNnnSKk
 ueIYvAHnHJx1jrxmxgsZ3/ui08cfAxUS8vZ7BkvI54avMQxIfl0/2aRcNRtKgWvNarTb
 s+P7zjLXAquKuH+5/PoIhGjNUuVgPiazZTNsctoyufVH8pYzLX3qRdkH3WY092Co77WH
 oOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
 fh=ViQs8JYPWYHyXTSNNlvEJj2cJ2sA5GqrDps+78bAVXs=;
 b=BDfRcfaj2se5Azs6Y2MPS2D6zdvV8nlbeMWXnFlMxcE/7BBSu+fRlTW40wVvstvDmk
 Q8Cx+YGbe2mFOR3n/KH1z6hKui3MNuqDXO3ceD3I5Qut2pk+AzmyUbtSC25d4PRfgVXw
 ndcZpA/AnQe+Kz8IZDr48husNGMv1irSuFP35uGypoUY3y4ONynODGmckSSq/fstpcpu
 eb0R3tT2BxNZdUlYVbdPWO++t61CPtnzv42OeBRCjEwauYwTOhSGa2EOBS3Y+voMVapf
 w5hZeF7zha+6066hll4I4TvghxJas5V3XxzrArBgLocCC+yLSv+7ZmnMMFZdQRXvxEKA
 O5VA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793009702; x=1793614502;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
 b=jKtO4JR3UN/qgyl5WYI+UL93W0x3+QI/DM1lceYc5oqYB5YQTDY6CTnoqnS+WhwBPJ
 uIgMcE/dbZAOuFXvuR94wCVUubcEs3VwQ4LPgRQ9mf/fn898cY/w58XzvUaAPMYjX3g1
 3CyCyeC6P9CAvHYfLpZ2Cngc/cO3Xd8FrX/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009702; x=1793614502;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WJHr+CkhRXdG/mIoVzckFPaugWleqL0ccr55qCvwEO0=;
 b=MqVpDDVPFEl1V31h2MTCvWyVmBR1LkXuEgSLVpGkkAqkncpnPknxLAnuGm2Cayp0C9
 9Cz0aLoS96lkoMcjT9PXfldA/8oWdDSExpNI8oE9gDwORRbFi3j/LSGCrWN5Zuz9/BVO
 OGyObwjwRaVyuw42j4ghBmFRJ/WO7IlFvDGcY9VSVOyK1u/u27ZEVS+YZh+aARWiKsgC
 LPz/Ed//wmqG0CUh8AgSIQbh6MIi/q8gWTyR5fn1vkaK/Rubem7/dnKnR3DRLRMZhyhK
 pSD5F7SzzeGEtfJ/g+f0QfMDVx7PqGH4UZW64F72kXyzaWlANZl5itgcHek8KwHlCZd+
 I+2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzft4Bi4DK6VrnStmYJFQs0xjil2iTuHqi+ZCEbWd4fiJGyXIj89FcJSUR5aNL6+fDtSijl2hU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJztPeZA2oZdWI1YQiGGScWv+zASs+j+CIyVggPRs5y49LVKI40
 rhDDnYl2PKZ1XqqwSGRzE+4J4GZqtwEThgJt0JAxoBHeZvSDdGFJRxDKigDWXRCBoVHXHgoSp1i
 RaXWvTN4hLMKEw8UbyroXXcnJwP+O93EGyQEjr0EU
X-Gm-Gg: AYBFou1DT+O9dM6t4FcyirOBRQ2WVLFj1a1aDMFnZi23ZXCXzrpXoHjEJVm4R3ppgWI
 q+5pUOMibne6pptvsq5VMCff4qA7k6OMd8UBHCi70nyI6qHsQOEDC44rvFFK0KSFjiMT9DbIM8d
 HdEOyuEnMBT1QP8mF1A2jOg3eeLvpsSpPWFLmJ1qMn94qyzJxguNJi7cuZamilH/c61nPPHBykj
 jXgleneLf/nwCJsknrBCfgUMt7bTFwVhVGggvxEHOtTs/QlWRl3Fj0sp0xAh1z5ZOt2IlQHP+IC
 XznCwuZSsinVXoDU1G9FzvAGu2Q3nmLidmJftphYo7IDCo2VmyivFrtfycMk58GmQOM/jlpbLY9
 NpRUqlL0jHIuRatWuM7cNXwlXjuGSMyU/450=
X-Received: by 2002:a17:90b:4a4f:b0:3ac:bc3d:6fe8 with SMTP id
 98e67ed59e1d1-3adeabe537cmr5001826a91.34.1793009701844; Mon, 26 Oct 2026
 03:15:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021-rtc_dual-v1-1-8cf78da56d8d@flipper.net>
In-Reply-To: <20261021-rtc_dual-v1-1-8cf78da56d8d@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 10:14:43 +0000
X-Gm-Features: AclHuK_faLopZybPc2Jtx9exF2QEZ1NKeXrdevEPBHMawQBuZPjecC84HjWHOUk
Message-ID: <CAFLszTghyUUgf7TitTJeGd9VZOc+puLo+yP455JHgbfK6Sc5uw@mail.gmail.com>
Subject: Re: [PATCH] test: dm: rtc: stop both RTCs before comparing them
To: alchark@flipper.net
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T11:30:09, Alexey Charkov <alchark@flipper.net> wrote:
> test: dm: rtc: stop both RTCs before comparing them
>
> Each sandbox I2C RTC emulator takes its base time from the OS when it is
> bound, and rtc_dual reads the first RTC on the live system time, then
> expects the second one, stopped on its base time one second ahead, to
> differ from that reading. When a second ticks over between binding and
> the first reading, the two match and the test fails, which happens about
> once in a thousand runs.
>
> Stop both RTCs on the same base time and offset before reading them, so
> that the second one is exactly one second ahead regardless of when the
> test runs.
>
> Fixes: 4772511475ce ("dm: rtc: Add tests for real-time clocks")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  test/dm/rtc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks - I did a similar fix in my own tree but never sent the patch.
