Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873EDCCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 09:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 032DF409DA;
	Sat, 17 Oct 2026 09:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tm-GQFE5rDdI; Sat, 17 Oct 2026 09:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBCFC409C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792227780;
	b=KoJ+tcDfzHxh8ne5cMHVo+aeBPSztD18PKtIm6TZO2hiHn+VxQ2zkv5UAbd62x24Q3Kz
	 DjuaA82yVB5eAc6o7mt2ZUClStsAFlJSjp//vhxEzy8o23+bNRNXHawNMj7eU/c9QmnzC
	 Wx9hbrtJOfZfhfAlCiKotVXEDPHmbIYnM4TLRZ2I6EaLdDwbZIEb8Q7f0MLaDK8Fc/YxR
	 ie0c5J6TMrjpzJhM4DfY3YyKJmBeIGf5KYlD9IZ03le4Ecb49OtKptUOqAdQyIedxNJQm
	 uqerGUUeAVAuK+jTnx7pWAr1e1tiC8nUDbZnxQQteDWsRGrSTyM0OBRuGbpk+lZcM7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792227780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
	b=MxDn3tF18KSxtfjoPRdg5NHNyqKe37FuTGxZJERZWqwnxxPwCW6l0bFp2phivUlaihFS
	 TvMqpEN7hG3QCrBeE4gvfPVjdhWBWd/MJXWNZELICkTWCAwByvQMKHiSdpC9u74+LPdbf
	 qKRQdUgOYZXah3khXLAo2jLQUACmHWfwA+egAPHZ0vVcp+DLL0gQBQRARrg3mLKwxQ8JM
	 1eFlZuIxEFhoq8pkR0IUfHSO2ZmY3SUeeoJCGnqESbUNkyFu0C4PEkJF16jlueq/ihkLt
	 0ZI28oCCBL7vi5g0gEkQmQ89812+TftMws5dANUh9GV7oUtG/3E79eb2gEZj17+6s/A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792227780;
	bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iGLiq28caE+EJ8i/xCseel5beAAffBLSK9r4qSPYcdiMBDtO9kSEHq/M8OT6q1Qho
	 BKs4Ocs7RwIxJEIn0IySfgVc+QAbvJjd7MgvYkWpGGkZzQKz7gW4d8SiTKcWyICUUL
	 01sdqW9AU0nBSTxuPJ7/yR1sUE6ztP5LakHumV85akpYYKJo0JtWW2ubsgQAA3xnVO
	 YQLgkpJf4oIjbIg9BYTZP/eCnJXRRWUp1MeKUYmSPEswKbJoXnO5Ksvw8Gt4zbd5Vz
	 0ajUCzNN4WS1UJpPJWEDNnsIKGqStty7KiX0UURHlAZerdD3PQiXt3UX3kU8QOkrD1
	 JWMIPBe3UTgyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCFC409C7;
	Sat, 17 Oct 2026 09:02:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 077A17AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDE0581495
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Fa4pB8LF7bu for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AEDE8148C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792227777;
 b=dmJn9tn3K9WPhkrBUo4xGJELsGE/rnuwDhNua4APTPNCOGetZisOQ4RRfzNxtnacbL6U
 0kkj52GxaumANivM1dRrF/IvHfy/cqIyoDgDhkLDkAuXZBayxUw9ogvKi/2c6flwWNrz8
 PWIZcnzN3PNILAkPR8PXvEbyq3Xl51pjnVj9D/e1ifmUru6IYzDl2/GRzrW21Q1CsMMrK
 WF3fELWmuj065J1Z+taff2WXQt7NKD5TTztspEuEPyQ1/GCk6Pae4jDjAc947gWZ3CTmw
 tJNXkXLmD+gpjpby77bGWorL36iFEKSA4czVGSmxXD1tAW1De6UTTgctUKh3kLcyPfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792227777;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
 b=QQtmJwt6nKgNK4M8ILz8iRFI/g1KkkHtM/EMixkzJsifA+VXJCf+FOsPfLiKsox+VRnh
 CR18EtEVVKYI+ipCDhV3zQ2uT4HyUXmWyzYB1t3i22UOkdncvLXeCrjfSfKtN48N/kuC5
 VY9gxrNF4pGBWveMRdYlBJuqH49gzx/umUwu9R+g3aeWgyK0CqF5Qvuyf7vppqBCclmlU
 qfezgZvtnsY89/XiPFEpJ2FRKyHbVMGMTS3nzGet83yA+ll+oxnAgUYIU9BpkkuqIs/h7
 j4Oe4cdTd6J6AS8ji+DQkdTJSVwoKIQzWHrlFCZpuSmGMiUcjMKpRverX8FMw7832GQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ojpt0vWb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ojpt0vWb
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AEDE8148C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:02:56 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so93345666b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792227774; cv=none;
 d=google.com; s=arc-20260327;
 b=pEbUth4QyDVyq/DBHi0vX0VZ134hc053tASXTD9+gL8fs9MoToHEF1SVdAtwp9+qvX
 WkgIY811CJGoeYq9kWjNhx4ocJNxcPF4HkH0lBkNbrs0l6QIIgFQr1n6ujsFYtjibU0s
 TW/3eRCTIJDlI0V0pfD1NNSf73eo3GyGsyXvt92qQjlsloXJN/zP/AG8ARcAVVfr9h9U
 7IxmtYnYBwmqrNt70mVSNXj1QYNpB0gS8wzbizfXNTDbwqrBjVtNsCTuiPO/OyGj9wO/
 kNAeDFazZ7pvnyuuAKvs0wI/JTZDB+xnUfBbzugvTdKObqR1lzte8KhCnkP9Cgo0uV9p
 oBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
 fh=tS0tUY4y3AX91jmLBGDm1xdq5/LPz5pjQwFbY7ZIl7s=;
 b=TGPNcxTrnPG7Kys3PVJopNyQ1dxX/zfWLovYofSKn+5I7jL5JI08Zrfs24bB3vAVXZ
 x2L5h5NlHBr3LOsFka8uwtpOsnun/mwRTYGLMNf0j/YhC+CYNJCObL029iNBEn8imGzj
 nXD+Vc9+qaLstp2ZF4M84SPZN065oEz8O91bX0p8nc1k+UxSCN2hJ+T9c3qqawfrd4T0
 PdRs1QVOCnvu62pqM+h8wGANA+lnNy5CPt3qN4o5Wrun21aDrLihJbLT05xDWpL0aYNy
 /I9wNmubtJevxjQnHQSQ+R5u0HJHaVbNcYCEeWMHVoij4dmVMSW90UJ8NEFXinBl68N3
 GJTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792227774; x=1792832574;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
 b=ojpt0vWb3z2HtUNqdUhFMEMUrc21SfJvEd6voS0+f48C9QuVqqXzr5grWmqQydn99w
 HikHYRs+KnSzZtJp7HrHWhVcsN6q+kumP8lZZvG2vJg8cor0b0kYQT+ijuXbN9A78+mh
 132v9eyDw0FyWIbI8a8B4WYxLRndusZCnNjJgpuffZ3u4+hSaz6lBCBP4OK8jukeUZm6
 7GUasuUIyjtWeDaB6G9UEleKnZ0qyxRx9g3Z0Seg3wobTDM2rrxwmDBnB+RadBBl7yX7
 5fy6f9iFGmzI6HJuikb6hTyXCkLD3XOB5hZgQjNZ3YrfejqofPAGLPCs0tdbo5saoxsv
 Wy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792227774; x=1792832574;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fdIvjmHGlEta/sLLZOijiFhc3IS3GLnTmOfN2q3gEM8=;
 b=dqGX9IIz/nCAsJCXmpjXod/esDZ5208jn35Tpi3G58zBwThnG3ByUOb4c1gWa8dfnc
 CaJ5Ggq1GUdd+b9fR0K7sSaErjF/w8VZ7MSKzT6+WPd3w1kEtZIs6VavuM4DITLePSBl
 EciF/zeHI0gJkcvZ010cmnX4v7VdANrhIDWRtlO3bNmz1OUM+dRggOPTXOb9f6zeeWbj
 7GfGrHh1/AxZbmffPSWCgyRHVtTUp/tU4FtGO6yPFhKxEZvziyCq3CQQHnrZar/Qp3j5
 Lzn+dAk8Tv2DLielD0FNP+E86p7cUFZp1lEVutunZweULxxtGihVI97R7dOC/kNHhe6b
 JjPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqZnBKQnZf8HnlGLTOG4mVU0upu/tbHB6N+hhJyjs5jeGXvclZyIjVE5J/0i75Mw0hl4eLqQ0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJyoaPQsDiBZe0MoCebNI7GxcqYr4z29z4/Qt63oT+kiyZLOQoP
 2rXrK1LTFoGA+f5KwkZ3im7n/uSvBTaXO3/LbW0/2sOdBfUj7qOwKFIGNJCpANmM6BYkx9LvzQh
 vZ+azJKFE6MsvTFuXgb7eBsnGB8SwTuk=
X-Gm-Gg: AYBFou0Gq+TpuXWzNt3VnxQys6mf4josXFKrid+BsIQMDwva8MHWMgaYKIGcpjL6/R1
 bfOuxD95rU/w6ILUxA6qv5CQkAkwiyrPz1TAdopriAaRRUUqjg3Zt2S1MkYBMGUEArn10Q47pYx
 Kw3ooe9ciyUqJweeh0abRcON5NlopYLztLab2HBiBKxi6tYtCf+ZdYqFf1SRotUv9P8zj+KU316
 ULjy072tdHOl7sYbrtAG2qzHM/CQli+tESeV+45pO2vKDjlmLWCFf3Sto9IBTwNUKOpkal0cFt8
 2kMk3uFF9oP3Cui3mVcpfrcaTOJ95yorYM8EVjjoAiAFScWg34xweDU=
X-Received: by 2002:a17:907:b046:20b0:c42:102f:15d7 with SMTP id
 a640c23a62f3a-c42102f36d2mr40067066b.10.1792227773893; Sat, 17 Oct 2026
 02:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <888f4840-7c54-4b24-85a0-b3cb645a94bc@0leil.net>
 <CAC928HZwf5yv0MTp42sFtZoMyW+ug44PFyE6HWftHQJb+CXXPw@mail.gmail.com>
 <f98899ac-148b-4256-a7c7-5ff23f535dd9@cherry.de>
In-Reply-To: <f98899ac-148b-4256-a7c7-5ff23f535dd9@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 17 Oct 2026 11:02:42 +0200
X-Gm-Features: AclHuK_LTS6dX_s71gOeThSc8AcO6lp_D-AMG0VroUAI0kofD8aMke08ORHfKBk
Message-ID: <CAC928HZzCScUNwCng5bEv_=yepf5z5i=eS2+D7yn3FpqGDd6uw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>
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

Hi,

Il giorno ven 16 ott 2026 alle ore 10:00 Quentin Schulz
<quentin.schulz@cherry.de> ha scritto:
>
> Hi Massimo,
>
> On 10/14/26 8:22 PM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > Il giorno mer 14 ott 2026 alle ore 18:25 Quentin Schulz
> > <u-boot@0leil.net> ha scritto:
> >>
> >> Hi Massimo,
> >>
> >> On 10/2/26 6:36 PM, Massimo Pegorer wrote:
> >>> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> >>> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> >>> common/spl/Kconfig file where they are originally defined. Addition of
> >>> a second config statement without 'depends on' guard causes these two
> >>> options to be put in the configuration even when the guard is not
> >>> selected, which is unneeded and sounds wrong.
> >>>
> >>
> >> I'm sorry, I don't understand the issue. Can you clarify or provide a
> >> way to reproduce the issue? Multiple definitions of the same Kconfig
> >> symbol are "combined" as far as I know so this shouldn't be an issue.
> >
> > The reasoning is almost the same I've tried to explain in [1]. Sorry if it
> > sounds like ancillary changes. But in this way qconfig tool is more effective
> > and helpful.
> >
>
> OK, so I *really* do not want to start doing this, especially if we
> don't have anything to make sure we don't do the same "mistake" again in
> the future. I'm sure there are *tons* of other symbols with a similar
> issue. I was under the impression that Kconfig would simply merge
> symbols of the same name, but this behavior seems to indicate there's
> some additional gotchas (or bugs). It'd be nice to know if upstream
> Linux suffers from the same issue or not. If not, then it's likely
> because we are far behind Linux for the Kconfig we use. If it is, then
> maybe it's a bug the Linux kernel isn't aware of and we/they should fix,
> or the documentation isn't clear enough on how we can specify additional
> information by "redefining" the symbol.
>
> There could be some issue depending on the parsing order for the
> symbols, I think there's an importance for which symbol gets parsed
> first before it is "redefined".
>
> Can you try to reproduce with the Linux kernel? Does anyone have an idea
> on how to tackle this issue maybe?

My two cents: I think this is quite intrinsic to the flexibility of Kconfig
language: IMO, it is a powerful language, but not strict enough to avoid
headaches and not-so-expected results sometimes. As stated in [1]:

"A config option can be defined multiple times with the same name, but every
definition can have only a single input prompt and the type must not conflict."

Therefore, there is nothing special in the first definition, compared to the
next ones, except for the config option type initialization. With or without
an input prompt. On the other hand, regarding the if/endif sections, [2] states
that "the dependency expression of the if statement is appended to all enclosed
menu entries". In other words, it is exactly like having a "depends on TPL"
attribute under each of the config options in the if/endif TPL section.

Having a single definition of each config option can help, but with some
trade-offs, as you have already outlined. I remember an email from Tom about
this point but I can no longer find it. Moreover, each reverse dependency, e.g.
"select FOO" lines, can break the game [3]: "select should be used with care.
select will force a symbol to a value without visiting the dependencies. By
abusing select you are able to select a symbol FOO even if FOO depends on BAR
that is not set." And "imply FOO" lines, in some ways, too.

[1] https://docs.kernel.org/kbuild/kconfig-language.html#menu-entries
[2] https://docs.kernel.org/kbuild/kconfig-language.html#kconfig-syntax
[3] https://docs.kernel.org/kbuild/kconfig-language.html#menu-attributes

To make the game even more puzzling, note that there are several nuances of
dependency: we can build and run with TPL_LDSCRIPT and without TPL, therefore
someone may be wonder why TPL_LDSCRIPT should depend on TPL. There are build
time dependencies, run time ones, and logical ones (this is our case, here), and
just one way to convey all of them at configuration level.

If I am wrong, I would be happy to learn something new, of course.

That said, I do not understand what exactly it is that you *really* do not want
to start doing.

Regards,
Massimo

>
> Cheers,
> Quentin
