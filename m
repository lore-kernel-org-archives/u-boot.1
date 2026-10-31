Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA2606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LMuBPpK2;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IV+V5b3V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9723481137;
	Sat, 31 Oct 2026 09:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_-CpXWkQa7u; Sat, 31 Oct 2026 09:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD8788111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439211;
	b=AICpHwJNqCwUgHJ0PKjBHOMHUshSKLFGURfHnzFB71SpD25RAoNZn3neGgeg/Y99rP0m
	 TOXtsgq/oUxuazhvtxhF6UZSmGiKfR18mNxwuRQwEYuIooi51VIaNrVP3sj10PNd7aTKY
	 /q9HSkMrixA/R3Nc9aqWW9e3HeZCvlMGlaNq9GB3Vmhz0ZgCubB0xbRommHAgP/gZhvDQ
	 NhB8K8hPlzIwJLJZl9LD/lnq/cs9DSCjRZjKRmV9jb+6WTZmOyYUA/45jM4xxCQ6sILCT
	 n+Q/xrAU8KYWn0d+l/VPO9lXEweSbf/BCJ/bI/WCwwJ8ugMyBLjXrDulw7AGGJRfGBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
	b=Daxhh0GKYBLAwlCHPLFTWRQW0P02C2ps/XLEtu1Oe4xC6OrDXZf3yrW6YK8Gndxi3Bhh
	 o+sRw5Q0yBuKr15b6TH19+WZVR68Rkm52qomDuNRGi7KXg8uu3uSvkAYBvx86j99UqxV8
	 j7uuhfsOacJ7ifBUh8A9uNNVOxeS3MozzfFDmxk462hk4UJXKv1v+CijaNx26kxYXyHYY
	 vgNCoLX+H0J+J6RLq5X5J8ujjnb60iJqiWEBLhYwhneNh9a1YLPM59Up0BWE8PQ7gqYkR
	 ObCF1Q9pR2z017RXdSKNfe8o359kBLXh/0pVWjcFtJkeeoBZZneK1qgwE6Z+6VdMIlg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IV+V5b3V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439211;
	bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LMuBPpK2ifN8/KscpONgYcT2UZQrfs6QQvvqSxs02C/4JJgQ2zwi1jQXfsQRXzear
	 0ZYhvdyJl8rJ/DlJPpE+olVutO6G0r6d43cg7s/gQcsbvu9xsyWRFPDj3FlW+hjZ4S
	 5moXdQvL8iyKXAOSIznaxj0StTzNllJrnRoHKgYAw17wBc767QBFOFEPBMVRURmZ+K
	 rGqSHfdCGL7FwPzutVJB05uwT4Bs9wWCZ1dB08Fpjb/2ne6hYqv7DTunX/F2+LJ3bt
	 tDvJtE5baPQkqq3yGeLN6XCPUcRA4DfAfPOpyv+Rs1qX2uxDZHLrOpRbXogevkQgHQ
	 paQ2w6dSC7EGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD8788111D;
	Sat, 31 Oct 2026 09:33:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C37D0362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E6FE8111D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrIGuGxUEBr7 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5663081116
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439202;
 b=qIONR5q1KS10JfH1xPghSEs16jDx2na6KCBkA9dAqxhRrFpWke03CWTalwvCPKfOyY5i
 VeIoHzA5AzlNJNKxgiN/iPl4lZ4R5n0x1Ar/D1MTsWuD5ApRXWON568Xp4A+ZvSKR4VLO
 ObYRap1NLGDTJNjn9z54Wtmrbq61HqOIy7Nqy0s/lSTHW4ISTdvYr9/DdJ9yesi89YZOe
 NG7ivtQx2qfVPS9eEgJxdE2rQB6lGouiiYCiEYBGB1FDEkjRyHwjYMSsXTpE8n6w3jqQd
 COOsgf6DhtkDeDacZu6QLRfs28x/W2SHCWo00PdbW95flVrc8viZ8JwForjh7RoIiaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439202;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
 b=qdqXGOW4brcWuWqKmmlOQb6c6Cd2VZBNSnv5HfcMsLm+aF4ezjetcKI92L3hFpFDJxzU
 vjLfIK6GyRAc/4ekb3VqwjzMoRSpz3srXs8BaXXd1by4EhlfPIoKMKA23+XLWi3ZqwKwC
 lTRoX1DzoKY6w9qbg2jsELEkOL2spFjOXzOUAgzo1/klknK7ojwyWfqCor/47ICI+56Yd
 5+qpxTl0GlV9iKcMc97DUmbGlt23s15bQ2T+CvGGn+BAik+fCHPKB4/DgV1E+bQhRKxlr
 DK0vfPc6yFsww09tvDcsV/Ycg1YbwZOAsEP5eiIk9486PqR2H3aY/pl8quEmRoza7BA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IV+V5b3V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IV+V5b3V
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5663081116
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:21 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso648687a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439201; cv=none;
 d=google.com; s=arc-20260327;
 b=ULgkhAM0SaSUoFPiNvcG4Wd8kO8xpNpSYWgWOoILTtQEaMUY+4oaiV/sFd5RAyPnVo
 3vNGO2BRBpA4fsrnDzpSvjTcK377WnGivV9EH6Pv1OHowlX9cnf5Ak9LVIm4LySSHAqr
 qoAauYH1GoscMsCbmLH+/yjRHBOnQaZI6kvCVK+JfZlUFUZtmeLxlR0BA0gGc1xdopeM
 +KnZG2fWJotpPTMtKY5EJHH0CSjsuhFs6cUCOLbfqUj9ysGQcQ+5q2A6x76eItC2AC7w
 z1eXnafKFjo3nUkwZf71ENPut9yGl42CjScMLejbJdGG4SdKXV/+RrGhopnipGIbYG6d
 5QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
 fh=pNmUmqYQaJMY+b4UFzYXjlxv6YVAoupLakgCYkxx7pU=;
 b=UE4oZsjHgFW4s3HFmdSufl/BqdR+mlPLpvGWdT8q5K/JQSJvcZFPxo+xssPL/yaZVy
 EQJmqu8WLcC2gSiPvnSfkZ2MfGvmCNK8tOPODsJojGLV/8CepM55UkNTM1Fy/wpFoa81
 8QEveYg9SNpQ4b9VY+7rNH/67qUGMklOgxvcm2nAs5QH5IfAskkZdsP+oQxPaGs+vl7d
 +XtTU0vSqLzNCAWTKxS1Jr5JuyEeZf56lUs5XoMpjxL4OL4VGTlE2pN8h+P1rkibPGBt
 Zo2j1hTW1qhkRkJdGLOtLv3n8N02oDye4m3tr9y4CxLRzN46ayTQWhYuPS7KzwmXqW5w
 0INg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439201; x=1794044001;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
 b=IV+V5b3VJ4kNoIZ/lfvqG1TRy4ex5eGxTuRUSMHfVENPhzsKvqdi4JK8Tar+nBtNVQ
 HIJbyOw+Agfmyg+5o1fhqKYHEC1JZOFQTLjlweZnfMMCHKB7TUSIjBsDOQUBp7eK4UlC
 /9HpSlLI0Th0MWoQhgEPOogSC9QA7uKPLZpwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439201; x=1794044001;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=162V/tlIJjmlpIUdsjAkHFfqA0SbICjJRkpkCfdMFTQ=;
 b=rFvD6VIdYD+HkUy6I4tPV0XMZMNnICsz4XECRk88o/0A3y4zf5rMYGBTskZbCB/1Jr
 gik8Jjvno2FUm8EnWECjse5QO+04H3lP6GSzBz+xDzJJ1UWkM+iIHz0wyovd7a7oZpWS
 ZGEGfMaduEsLSM9o88+YuqF0R4wvLdpJNaSrtDBgOn84nppgSjj9hfUyR71S14t7uD1v
 pEJfnk1rL/3BZJu5roW5TdCxiTVtE9fPihR4PcS+WFYNX8Samlid26LIB4dYJ7YcxDYy
 9LLgWjZUK0qHuhv2bNHUempoGiHm1FIM6k6Sb6A5T1AaPmjgKGKWHuAzbshkCoJQD1DY
 UTUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgFvGhLMUoMgTy2UXFQBlgdGOlGfw884E/oZF8WPgw3IuP/CD0gtUoQvPVBN1q0rj8bXbNckc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIg6wd8VByQ+mRFxQ5p0XfGpSJeI57qv2hoVd5JCnW47BQwpWHZ
 He2GQvGLO5IFETcroQoRGluaXtWfrMk8qGKYWPn4gxlfcf1K+NLt8LpyzH9C3qRD81ogb4UMhPg
 s5oVz12vwIFqrgyHsSoUwNCTtSwAaTTArAwgUZeHi
X-Gm-Gg: AYBFou1HUYqTppoR3K5T0w5QeTqteDALirEFPy2vRLlohqsZPc4a3spMdUqJRvDsCUN
 yCdut+pbUn43Sqg5UQC+ehTemD65oKNaEehccMJClmDXJbMWJ48cxlI+rN6Rei7lKGDRUQ28Tx6
 YiraRloiXHhH0QojTZ+gF0KezXmavtjaqQMa+TU/ZVxyTvliO0/f7z+KDleZ0llh7LyDLKKwd9g
 XO3k40GTiaiKQCAzL7h942Ytr1oIKuHfvsHxqzchdHEUUH3RKKjlg53qWC79Da+HSCHlaYSfsD/
 yy6zPErk/xeK9rYidPhFkrIkJ0xYQl+P2aKICNgah8Jw9nJVgmxapzAYbL5Q0wTPgOMPvN8m8Yy
 sIWb1jgyskvN685qTq00Vu1z9O4QlL8tDaFZDvBwr0KPitQEy4r7318GSL063LytpCE2NSJM=
X-Received: by 2002:a17:90b:3807:b0:3ad:a232:403f with SMTP id
 98e67ed59e1d1-3ae897aa79emr4180462a91.56.1793439201423; Sat, 31 Oct 2026
 02:33:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:16 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:08:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-3-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:16 -0700
X-Gm-Features: AclHuK9tIE8L9V6Gxvnu7eI4VMejfurwbLN43KKIr-JNzRoNi96bO-ykRpkgsH8
Message-ID: <CAFLszTgv2FirmTZ6RQQRNbRGm6MqB4koCjGhCYcZYV7HaVNe_g@mail.gmail.com>
Subject: Re: [PATCH v2 02/37] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
>
> Use 64-bit arithmetic for f_frac << 24 to prevent truncation before
> division when automatically configuring fractional PLLs.
>
> This closely matches the vendor kernel implementation.
>
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_pll.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
