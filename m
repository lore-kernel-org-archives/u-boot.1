Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43306CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EFA78146C;
	Fri,  9 Oct 2026 07:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fj56816aHa1w; Fri,  9 Oct 2026 07:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35A3A813B0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530785;
	b=Um9htsmBEAt50rqyPaSIaYgfzQuxk1XBtZBjPJ8NUVJbRq53OfR80Qe1j+IaM5gx+uvN
	 1a/pWi4QkPagf3yoBTqshDIyY33/gAgjfltty/9E+RD8tWHiWC4D7GCuZFYabhL/HsTYp
	 wgL4AyZNFwbVw996QXxWRLys600O0+KmfYxYKCre+oHTT12/4qj+miaiULwkDh3QBOOAn
	 JH4AlpQIdQNg/OSwd+l4BNo6q24QtCSY6tckTx1/7GEomCgmsAYCsgHKZZlYzWwJNLJv/
	 MEmEWVP/g6C+3gR2we6EvlFWqxqN3kzkUsQoBTmcWVE/Psv9e7QhbCbVk/EoIKq/LwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
	b=FZh6H8qbcYMIGmoOGduJMLqq5aCKFCxmKeENxhPKSf13rLFdMYfQtAsaYAUW+VLW2Ao3
	 raWmJRwcQ1OrbY0y9UvnttykRNZR9wIRk29jaeJSYNlPJL8ATvsaPTrQEkUB6QbW+QkZ3
	 3yB26XdbOVSVGypaGYSMk5iuhfYFu1e96hmSeynKJwP6/1i81iVPAlQt7AMzSKlWV9INd
	 kLBBM4YI5k+9f8+cReAUE8oUaxkvw53Y6auEy65rCNJJmnNA7tHebK3UcpNPrq9IhtzNs
	 JUUw6AjACGZtMzIhVU030SMDrEusJDuP5Grj+0a2mgdDQ6FosU0UXdOK4HXLkCwpmgQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530785;
	bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8j3exw9qROfrWZrX6u7GiLvJ5zUwyuowt0cSAjbg38nBqK8vSUESW5qJDQPENVkm
	 iIFmALCMJ6VVW/AjXNnAKvn7OEkhfOq/HNN3Q7k2z3PPrCK8LPsHmd8PVGMR33jfuP
	 I0ywWFWlRUu6tJX0KgfWJvaoY3RAc1LDgVoaU4tvp9D9qm8v6Jz8drUDrjO9VuSl6e
	 pQL5mtvAlYmPcPBSyGeXeyWVPnQ03YqkTnFNfwf6L79mYb4vhut9Ii3EPGNuaDaOf7
	 BEPj5aocZQqxdwjc3PS7Qs4INd5eIDtN3/47veMSyuum50ed1YvhwrYIJBE9E2BUv+
	 M3sIqPd7XWnBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35A3A813B0;
	Fri,  9 Oct 2026 07:26:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F0D8422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B2B3400B0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jkt8XVq_MIIc for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D52F40080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530783;
 b=MWXCsbrizwdpj8MVke5nOewGS/iOL3vIELw+XQBbDDie+yhmw3o2b6f0E0w6Bsnm5m0f
 seg9pBMZi/oH5cafvQ7fR0zIw/ms6tcY2o66vvEn+WH2SRCcV5z+4FKQzJxz4Pt1Gbs0Y
 olGC9e3DOXclQGkHlfm/27mpBhgHtf+UHRgT4kQ5LvGAsf76QWS997y57S33327LMcy8A
 U/R7D7SOwBSTxcYvVoT5mlLEeZya2taqzCt97I+7eGxpU3UJBaJ8P0ewM6Cr+UgkKpOwT
 szVLnUJHLl19FBjZ5vDCBHftczBzODECpytpxTfKIjDhEOOhfNRyNmndo9es7+xDwsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
 b=spcCU0HazGznhEYBzwPw0j9nG/jJ+qXSENOIlBJPpLO6/lWVSH1xMjDEcXgwL8bOalD1
 Dx2U4pXkuMwM4xl9QUTP7eNJ5hXzYM9MZ3r95UjLZCCbEzad1GhKbY4r5/Kl5+IIlEo9t
 8A0vU00VA5aOagR8VE9whL1a7OaSrGx2yauvkzprPdG1QG+I5yVn+KwoWHWOR1WY2aTgl
 +/ApPTi/q3YiQ43O7wnhfALHMW6492lLL3ZprNM6luZzhjqavVomgUO6i0UvWgOebop/3
 yoY2xYh6Sh9FMV7S/kkL8kfutUZh5Fmtvr1JW6ohaP9P6kFyeBYITbcy+kpCL5yVVbA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PGRwlbtB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PGRwlbtB
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D52F40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:22 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c3156e7705cso736863366b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791530780; cv=none;
 d=google.com; s=arc-20260327;
 b=NrTvL77RCT1xEm0WH+1Z+MbiAA7n+PH2paUBDXBSHnPZAbw2Ln9Po9JR6r1IN+L8X9
 geVcGo/052dsoyyGp0+Zrmmcj3oNzY4tv7blsT3h6Hx+T1IsQdzgG1QAMRTign6p2PeG
 ccaiGPzCU8C3nLfv+SY8FkhHepA+rJXBA2uMqzTCuvUfKYcjqUArl0pXt5tRgTyh/bwe
 kL+Sg1d+1owqe2LeuzSEVTsXInZ2up9eL+9xx0gMjZ5zNCchWgZX0/HEbl2iDZmzORva
 vtG+vbuydgiFrqfTJMRt/gvZSGzbURVIBO6twQJpf28glrsDsaKOa+owenucJrkuZYuW
 DTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
 fh=K99q2tw0pcx/Kwd0DiQaAfzLKZVbYirVn9Zs7Q3AtGA=;
 b=NCZFNAJ8erGXcMz2RBynkDjYZHRbV9Z1TjobRdgy5j9C93Q4h7sPviNJDWDAr4vKyg
 mAYpmL9DDYiu4g44pzvV2Y8+3i3rTNl9bP2n0vI0MhnNREm2s9EDjq5U0A6dx2KPw4c3
 PMiFqpZTGx/mP6USzY3+q3S9201m44uKw7xaJ1o+E9d/D+5qtMReLPlwYI+Bf4SseePc
 2V5rKBqAtv40E09dqN5XgQAtE4SFKwcPXI5DRwMqQx4/SUE8PuU8W6C4w1sOdfn/7pXK
 pnVdEbcScMYwA5IpNf6DCS3+kcRKfRLXGhthV7EU71DEreKUj726mhEn8GTghi2cuN/a
 JepQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791530780; x=1792135580;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
 b=PGRwlbtBac2BR9PIjaUQzMUBvsvs98FdkxHsuH/08k27x/VGiopl1C9rhdyTs/wuUl
 8v/oe+Bpqz/JJmxiByMHk47YkUKNcfgfzx01EdOf/zghtG6HgXoIYxH0aYMlfkilEpCZ
 4dijDQYCuZsBuIPnEbFKXO5NrfXdkT63dPn/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791530780; x=1792135580;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5Fr7Yzse1r/bbjdeNCB3tcS7X5Yx5jL5wSzF4vrO/S0=;
 b=mQLdOTJnarrSh37LiSnvcHPqcypJB6Iii7Soaz4B06lcUQB8iFaG+2UdYGOeLQkzoG
 Ab6wuWMEFOUa0baNsXsQl+jMnNKm9rSmQeavHLkvNLWGsFsNoPtBrEcpIj54jTpL7wpp
 rzR6HO5MBEh32PF/BhASb0/2GPGxsqEXpXGAyd6QWkeMUQsKg6XzDGPAMQA38adwYvEr
 dQbBliNRjQkMcLFEKs7AxO1cqeyeNeS6992sv0R94C7ydi6Quh2Q4TAct99vShtr5WnL
 ldbk4QyVqsqKu9t4Grp//m0J+h1ZMfVFHl+zaMV5ZhDEyLnmjdOPftLyFsXK438TyOhd
 Md7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByyO+Lm/vfYIV8ewAsFRRKiQhUvadrKc4bNBiCUgDRoXiTRmniv8UyzLniE4wXtKgUSAbQc3FQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIQ1dLRge9p3cgsy+zk+BgYhzD1fCkmEIgJYPL693jU7G+H4i8j
 QNAbQmfxXSZaQRF+o0/tIn54LfaN999TzFy14+YwLVSxPWAF1jPW4WNxAV9iqTWgb0JnuR7JS+z
 Sc7GK8PaSVmOMgXCJrUp9qBiU4J+7RNKB2R10wjJK
X-Gm-Gg: AYBFou2Fs6EH9QRwOMV/JFjNHhLYQp+ml3MsXTHmEatMtBay9KldchuyZouwtsctW9F
 GX6b2k6gPVdewYiAglhdb9SW9J7KKxbGkIB3kE17T4BrzmZloQhM9Ui/fcjnEKx6QIbMCfBHxPg
 S/EvPB2Pe10kTV/5ITe20ZGFewm8dlBhhSyFk2YtlJStFwqfS6wly39wqpPoIT7/Z3ZZIBp8h6M
 cb5fLG5CVfySbu08V2wAcPw0RLz8+k5z0FEhRreLvV/vBuarEO5t5YdWPVtlruZqSNbHOMrr2BQ
 xNFRTPiJa4toh7BbEoJ58RWgJFxwiSlhZAyDMDrMqr9iIQoXvy84bP0=
X-Received: by 2002:a17:907:9801:b0:c2e:4292:d268 with SMTP id
 a640c23a62f3a-c31a9fc181amr107238066b.16.1791530780372; Fri, 09 Oct 2026
 00:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:26:08 +0100
X-Gm-Features: AclHuK8HES25r5mG9lxwUldtLjLVPihL-zY5bPQUf-nWiJm7Af4BcXHekqUj6mY
Message-ID: <CAFLszTgA9u0EYDMqKR0C49jY8e2RcL4BKOg+dqh=V_Dp3LAnDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: heinrich.schuchardt@canonical.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-10-07T19:09:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> Currently we only support reset but not poweroff on x86 QEMU.

I agree with where you and Bin ended up: keep the existing x86_reset
driver so efi_reset_system() keeps working. But I think we can go
further and avoid a new driver entirely. The existing driver already
handles SYSRESET_POWER_OFF: pch_sysreset_power_off() asks the PCH for
its PM-block layout with PCH_REQ_PMBASE_INFO and writes SLP_TYP_S5 /
SLP_EN itself. The QEMU devicetrees already have PCH nodes
('intel,pch7' on i440fx, 'intel,pch9' on q35), but neither pch7.c nor
pch9.c implements that ioctl, so the request fails today. If those
drivers (or QEMU-specific variants) returned the PM base and offsets,
poweroff would work through the existing path. That needs no new
driver, compatible strings, undocumented 'intel,*' properties, DT
nodes or 'imply SYSRESET_X86 if !QEMU' change, and the EFI reset path
stays as it is.

What do you think?

Since this is a user-visible feature, please can you also update
doc/board/emulation/qemu-x86.rst to say that poweroff is supported?
Please also add a test if possible, e.g. a pytest that runs poweroff
on qemu-x86 in CI.

Regards,
Simon
