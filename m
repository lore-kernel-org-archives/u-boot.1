Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46460606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UtHPz4RG;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RHQ9xgEV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 718148117F;
	Fri, 30 Oct 2026 21:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uauvvCZMO7c; Fri, 30 Oct 2026 21:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77D5281184
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395149;
	b=eUCOgwvBj7slSX0UdKfZimGZngXnWcknTFra0Bk1zNF2Yj1JDlzlQPnh6ZPH2KuGNnUg
	 u67nyWiDMH/V1DGDzXFVCeDg61qqQKW0qIMF+gfYKb1bb8/HCci+JBVviDoya9YDtpVuW
	 44we1R4UM2BmmOarRWtlB4HMJsH2ZepdJQeO1M54o5oIUxp8xzz3/rVP3XQw7n2uJXYTS
	 DC/R3cfG+LJN1IgQSKeAfxZsaXAYzwPqfgSZUHq8fYfO24Y7m4f4e3MtbFbJlmLyiSOhm
	 WZ03ZCpNHLFKvn5bY+WRF/LmmlN+437odaBcLqm3zSvW2YX0ghNKC4KiDRiV28+fcqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bgXEYdgCsfdA4DGX+INumbvKqOIWf7vPlvQZTG89rYo=;
	b=TGi3lAmPxq0GStMG6twK9NwUjE5m3pW9qH9AtKK0XkXCvIpwHaBAKTwhOIF8P7aywxib
	 168OIG7E3GTM0yq+w+LRgs8ajBm4Hu1Fy/7h0BGolVxdcFag3WshaUvQM7Km+haTSlheO
	 tiRtmeabnekZgZHh9dxtOC3PYgf9IbB8faVJMg9tisuFalOtyzFSzx9d9Muc7BJvvQQza
	 By6Hzv32Abpg2r8w02rlQmIS8tZJzdLmF0HQ5nTjlF8azznElH6elyEF6IWLqG4x8BhTF
	 QJVZC9d95Ag0qU964YLIGPPxkh1xBEV4Qj8rhDsi2/vLOeujgjdA6eiF70+8TaS+JdQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395149;
	bh=bgXEYdgCsfdA4DGX+INumbvKqOIWf7vPlvQZTG89rYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtHPz4RGItH0WHUp46reNQ0pn23GcGfpEM6GHiE9kLSwRC7RjOf0TA1tneAFeNzB5
	 iRDlz8+R+tNVi/QfE8V4W2l+WWH+0ywcG3eRRO23CLVrOWfa2DHhRNdRj7S5N9k6o6
	 rnhtqk4OBPb1wS90DqY4ynRcoCobcPOvHiBKlKYDlorx3d0HoyGEstEgeZ3I4Eub7W
	 6cobzkj6cScvwv096BFNIPmn2IU3AhbE6mXy1HAg37d/JJcoKPxhTBxXmuKPysfRnR
	 8vaYiGYRSQ2xSAz6r5mgNoYrB3yefoA6VJISKQRFuuxtvCysMmyN41e/rJEpKmumAn
	 dG9dEek2tPvfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77D5281184;
	Fri, 30 Oct 2026 21:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3790529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A55F260A7E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUuFt35J1yUI for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F125360AAC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793395144;
 b=iByu1pGPQWNkCyJpwqwyM90UOlR8cZYdB4FoFa4H+kUZ/40dt3r2ySPvfbFFoU9HHY3W
 vzTRtDYlAine/19IcjPwWc/i515wGbzlfrZ98GldUiIbOJ9i34voF0JSDtExAq0gB5ST3
 Aj6mAD6SGEHNbXwOHxszM8JXjD4o0Z8c63wfjsdRs0oRVOsfoecNqrsxEe4ssz/u9eacY
 m42+F1rRGqwepZVzMa26pe3GI0CRe9W7yNX2c94uSxvL1xjYuGQ5jPYTEtybYM+3uQ9ay
 a9RQ03YhE6OPfDqc2IgeKJsvSH5HHhYaBFLpJWbFyAziCGC0FOoe2H+wrzwb1Xwx/OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793395144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=bgXEYdgCsfdA4DGX+INumbvKqOIWf7vPlvQZTG89rYo=;
 b=GhYvREDd1jaFCoX5sEVGHlC+/nT6P7uoOpI75bqjOrluuAdzCWlmef7nddwLtE24X7UT
 8rRTD50MP099CJLrj3GEBK0FkzUvC3TlT7jKtKMM9FFNsDa9GWf/HYqhM5Ye7TzDoAkd0
 5TXVLNLkYQSMsa/bikP1wSHjjac3+KQ1DehGO9CJ1M9nAhOeQUT6v/cE9lhOFnEZUwhKj
 IzCbvLf5IsMXfbFVc3wrQVn1syGevpGd4hjMFYCXgf6q+gqGeP2aFlFdxCdueB+Esr++A
 XZ0iPrza3yDj1R6RJOe8KLW4yTKN6Yb+jzwQkM9YqcfEoxn6xvWICSoXTeU8l7Z6C+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RHQ9xgEV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RHQ9xgEV
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F125360AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-85a5455bd3cso705644a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793395142; x=1793999942;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgXEYdgCsfdA4DGX+INumbvKqOIWf7vPlvQZTG89rYo=;
 b=RHQ9xgEVvMiBVTnZjnvNQU+y53ts/jvDH5jUyKO1ijCmXdGjrgRAiqdQD0rp6NJd/7
 +6DMgOdHXJZl2sWnTXe80CkuRmeQ4G0wu5ePsiMGZttRUDKA9/NRas1h9Amq45TIKC7o
 Oo1J2opB1PuRYRc83x+oX22sCA/ler7ukso9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395142; x=1793999942;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bgXEYdgCsfdA4DGX+INumbvKqOIWf7vPlvQZTG89rYo=;
 b=omKHgkTl7xlzbM1NfU/b1uw2ulPwcdBE1oDNkIRksC2MB5HX5ndp/ak5x4EZ0/CuML
 C19dlda0r57e8j2uiAC9cGuDCR3gC9eHkqUbcEmYF/R7w1te9hCgf952GnFUN4lbhw2f
 woiX6I/scxjvLfh3hWhEl5uIr/XO74pmuZj+V1btAlfpOo6LP9YDHrbQ/Egbm9R2OrD0
 SG83mE+SRRdqZ5lOEReuSbOrrLW04OcSaEUpPdx8M+nnTrk1xKIII8onP8F4gjY5pLzi
 yfDhCoTx0ISEgr5bvyWmlNCzWuQsaI6B+UyBF/juWAooOs4UnYfMhiCKKolbe0xHhr4s
 ypSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/M17PSC/KzNwLVuR5iLraszNKYlEystKVkvkNCl2L77gXsDAVd5yErAlaXwPQHm6TLtVdnFA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFEsFnBQwSHmc/VYuyf9dF46wrkzD3VnRZvYw+asDsEz3PMg83
 3gqNyecgSCerFcbSx7A8L+tCskFaMFafgEjnrD7uGONRb5kP51kFcbb9mHtq2Psjfvk=
X-Gm-Gg: AYBFou2iLe3KNDzW01fDs3whLwCwPGoVxcK9LHZzPc8lyzd7LpjwVEaKKox+ItynkZU
 WTD0+2RXsMdW+P9skI8upIVeolRgazLJmMa9QHNEdguChqozxaD8pUPNw8aNINdeH6BdobQj82N
 S8eQs2hsiK6OfN7EyJbOFVmLmInCrv4jhyx30an9ZvJbJMdIx2AYuiFJ84bx9YWf5xwv6soXudC
 1cYxfALk46ZAbR0o4OTuZi7Eqj6cMvNOxQ9DEPf2ix5O+cxTmQN+RSw+i1Rvla7j2ZYpFRD81lt
 SEwBsu8NHvzAyOLgPZ72ch5dfAKPeTje/8zCOO9+lRKLCKZ+L8HmMPR0qoO9v6CTkt6fMOPHkHx
 KMANLX7Nij6KA+MP/QJQl2VBTx61jBdlPLmd/Hrra8QxAlsU9TLzrvRdk68fBi3NjGqoL+8GGG2
 SiGJv2Fg/HYkvbsBuAr6pUIsip2FQzDsWNfVplujU9FKa6lnLf5mofEsy5Rwsnk513/da/osGC2
 0TR073TWjn9UWZ1JHXGVWeFyO9ylTpXBcUP9ORnCERozyMOr/6K9BoNptMnICfB1yK6e+nh5SjU
 bGZNtVMo62mJ1I4Pt35qNp+CvlwVec2l1f+KhAvC1a1kp74ln53SRwndpEUPQy3efUuMq1A/cPI
 SmDJbE1us7sqKtu/yZPbChOH6ndhOiALrgMElMt2WDYu9JH2U5I/WJuKMDOcYptTUZJXlNYC0Hz
 T0UcK7vluBN9cdAFkDUdRtx4Un7+VmRtm2VdgUOkS3xpP4145A8k4=
X-Received: by 2002:a05:6830:2695:b0:805:2785:fad5 with SMTP id
 46e09a7af769-85d36536870mr2451413a34.27.1793395142549; 
 Fri, 30 Oct 2026 14:19:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm2829799a34.22.2026.10.30.14.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 u-boot@lists.u-boot-project.org, Cooper Huang <cooper_huang@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
In-Reply-To: <20261016-ast2700-fdtspiaddr-v1-1-2b376be8a6ef@aspeedtech.com>
References: <20261016-ast2700-fdtspiaddr-v1-1-2b376be8a6ef@aspeedtech.com>
Subject: Re: [PATCH] configs: evb_ast2700: set default SPI FIT address
Message-Id: <179339514175.3804820.8784257860642105901.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 15:19:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:10:25 +0800, Cooper Huang wrote:

> The AST2700 EVB bootspi command reads the FIT image from ${fdtspiaddr},
> but the default environment does not define fdtspiaddr. Set it to the
> SPI-mapped FIT image address used by the OpenBMC image layout: flash
> offset 0x420000, right after the environment, in the FMC AHB window at
> 0x100000000.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] configs: evb_ast2700: set default SPI FIT address
      commit: 5ccb662220096fe2378acd4314f7e29f512340e4
-- 
Tom


