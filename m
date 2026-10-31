Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99423606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zj0Up42O;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JvhOLKTy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7461860639;
	Sat, 31 Oct 2026 09:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49UrBr2dHnzB; Sat, 31 Oct 2026 09:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6FAF606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439259;
	b=eAGVhdCshSSe66R9qGjhIBtrSMfYAejm3l65sZ6nWajbNc8nXuSFqzPe5xFgYokTMKWj
	 TXtd7v0/n2DIK3QIchToCb+ePyiPKFMkrNdkAzUEVuQKQMd8dBzq2e+EU+g6BbGI6AuYw
	 Xa2ybRWaduWFvBL+WAPfBCgocRkko7e1Lwr5lFfSQKUjlizEe8pKW1Qyype/6ICZ01ZLP
	 MvfzEQFph5TUNr1WMimtu4YxZIL0cLTqgUHYKkExpFIRmcueNaTUemPiEA3WOwrxNO8NI
	 zjXRMSm/8sghxniIUOkF6Ne6tl8ob0jQTBSHuRnpVj93h3Xp1X/Kx5pzN5o+7mzEe0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
	b=Y9lhdJxoZ1imz1ClzpAIusDsFWL6zHyy0gpr3tzDcTvFBf+IFov8aSvogUxIHtx6wUhb
	 p6xAaI8s0xG8+8XmKy0oGI0G8q1HtUnyFX5ZJwLcs0uGRHunOvfgA2YM5dtOovVpQd8RH
	 7ZU+8ExQUh6NcOdNbRzdz1g/9zu+9e14zIhCeAnXudkpDDudmFlXSmBVKolVVwAzgdylQ
	 TXuQMYFqHHvb55HoR4T6aPViQShJ2GydNSTHD0pfl2TMjdqN9e9YU/FdOM2Gvclyb7a2B
	 dQEManmaOJkDlnFEHMl1KYTWw0sW54SPkWFrBlfUZYboGljPHsstJaYFZ26nt8CsBtQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439258;
	bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zj0Up42Ozu4E/BD3eMAOZK4wWlBhSnhgEf392A98LNsqNBKixAHbVaDK/ALeu5oxm
	 nDJcSny/D5prYdR4lw+OBuLQtqOG0D0Twsi5vMnoTJSo3J4osPlOdZ2LJ7MfMmgJ6u
	 bx6z5nOSUOfu6mZXcpTopU/cl+RK1JCVSIVrdxSjncraKnsJJTw9ZTuLRp+VmUHoJ1
	 c+Z+VvcI7mk9JtB2EtD2BrPFadq+q8DLnxdgrA+t6IOyNfre8r3fQQtoJ48C2s9DgY
	 zsKt4iwGjHU2WBfI56dth6mKRGn8EAUVcZ7Bch8VWJQ+9gKGjrG98OBAGKfJOtrtKc
	 qdNhP1MOhagLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6FAF606A9;
	Sat, 31 Oct 2026 09:34:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1DF0362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7060400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OC6LjcfF2PYp for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 43B0740057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439246;
 b=jwiduwXJ/Weu8aMM625BRO4L7erCIcINV6HD0zR1jfu7zUQs86U+Oa9+yF0AgTQ7g8Vy
 q8/1N87Trm8O8NSBs7nr3aitH+zAhGevwuzA3oBEkybgP+MWkmlzoa884GtW95XJn7twK
 II8S3u6q4tkqJMmkv8Op8ssSiU8yypiT79OaGGQ1ylrh1nsxDQdPhLjKJGPBqP0re6GBk
 8Im5zS+YWLI8kzAPgL83XqJfCKeSGgOX306TnUbImtmrBRpUjMVfaY9OUnHhDaXGQoX8E
 RIPUMQx8lClTOf6n8MHEL+bEKIHfqhL1JCIDiewzPPf/92tOGehK3FImvUF+zZ+9bEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439246;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
 b=DeT4rG/b6sAZlYmOnMbLpcBoGnqdxOUhTljFa8n9LpiRoRL6K+20DX1lNYPi/PQFQHDN
 Oif38DfNG1PO5wdwGvLes+KX110oCcKqp2nHFCXbCBt9kvxc/ys86e76C8yKw86KVVGxl
 Na7a+xSwxn8sEfR8sE2lQA7bP3vIEWmlqqdpSt940FbSompnPkr1MdRGWSjy/bPTmn5NN
 0Bg130ZrcPzlVTAxRAkQpZqaRuaRIbuaUysAZ5el5mNGGe35UQjYFuVef2TJxFpQeFMru
 ycKrpQkwhT+jVPMycLonjsMyXhqVA7UaE4KR2sQRrmVudUQ7jlkQmrBSokC/USrJ4PA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JvhOLKTy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JvhOLKTy
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43B0740057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:05 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so723146a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439245; cv=none;
 d=google.com; s=arc-20260327;
 b=F1bHVQvP+hzgR5TjOa70x1chp/LJ2kn+zjo5ofidqy6JjbASjRazrfgPDQdaEIT9KS
 9s+Tty8rA4PG083GsbgWmqV/N4KZgltzNL24einhSrJjwDH15oFZOBah3he67kgd/pB6
 pSupZc7VmjX02dK0i4k7hPDuSvbLltgx9mW7F6UxEaVmtcPEDK8146e/q9yUZvqqRDHA
 o8psMR0bzjwe6oFpd2jJ+3bjse5H1ZKQmiOKe978dpYN6sED1w/5Oh7xMCqqsxa/XeV6
 Cf7rZ7M2xxGTZsOgitL8VtQCuy+VyVwkfqpSxMYXRYhKLnwOZefCRvIkUSPB9x5HNR/Z
 54qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
 fh=xd8VHX5v/6VKjZVU/iyFXDoccf1r8OX2ffTWZq+Dh5Q=;
 b=L3049bX0k0n7WKEiD3Wn6ggnTvfDVNG6gvBLfsRSyl0cpvzL+Ad2HN2BdiXInBjvMM
 nZK+83i5eQIcSuEl5qQuc6rflc+A8HYYUbHFPE4wGlPiA4JjuGDluzye98/GzDu+R1mb
 sTK7Fzwh70+mGWvkVRMP3wVP8T+l4CQxoBp8JtV3s1dh2UZatE5mhs/1SrEkQ1dZg9AC
 LMVe01zYEfZSkk8jTDxi+l8CEd90xYrG69aXQFFgPAKtRN2WOJjEkRYyZuDBNwFOMdm2
 EvgnHjxI211Tdh4Z4ftnL80lJ1USU0vahGjQXbb/bKvFUo0pKLLgcdxgTpWkJOUwfd17
 Sz8Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439245; x=1794044045;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
 b=JvhOLKTyu/eG/ogWRwvbV5UzDd9XJE+Ew1qBGHJ9c2faphs0vkRYLDT+waMtfi8ruw
 FdhTM3NReTy2sprHud/Wtw/8IsVMhCnm7HoS6GHCWOHuqeyOKg8iQMLD/7P5jMH6Hn/M
 H2+VvEW6KGs5Zpr+wUhFzSV0bpqmY8YEmg2w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439245; x=1794044045;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vaMyLyPhHRxkg4/xcuOzEkMfNlIR8X67e/S4ZyB3Frk=;
 b=pyMZzfDd59cJHeSkVOO1yV3K90bM/h9BFtYUC1EqfTAAC9Zxy8yAPuWg7PSjhixsdc
 BJsV2qdLK+OkzYuufGASqs++eE/vkZAMTF8Qd/xrwROjExgoUAlo37W/RVwOoG168In+
 x9IgAAHN29Otb9t+72SOVV39BJr+OMSoyxnIpR9luTVNCvXdHFd6o55Xd1VfgOid9lKT
 YeNx31KBaZ0eROfFbmpjbM/W0SpYmlDfHphMUj+gQMDkP4ic9cpvZlpAbqL5XoX5JnMZ
 ncCbZDScC9NjAWMmuPum5FPPIauwYtNyeYmU+nnSAksv42RuJTgvrHdRwZeNP9Yuqetx
 O9iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxA2751SsQOc0AWq4A6uDmGDyU/IwbbjBkZPS0w3O/FoP7umtdcQfqQ0T30L0kunYy9MmGfQrI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLOrH+xVEgATEKUIL+7DEFIVrILFGy8fX8EMk6CHyVXLrjRyO+a
 WFcEgw5EhdTKJeR6rf2p0yWgoNwoUgLlMweRqCzE5B1yILxRz/rrJF80AX7BqPdGWeo0jzHHqnY
 /DQLOI3Chb0QICjoGDW0aS/Lv8DcRaZ0PaZe4P08d
X-Gm-Gg: AYBFou3nmeS5E3eIZ9dHl4rQI/mWxY+e0Gia117h2tcTys6B5tbUSFFgnU0vhBL/QLw
 An9iOWwy9cG2OqZdp4WyS6WBIc97GBSGspmoMdae3zn6F5JM0SXCQTlNUTSsMOMSkDuD8uDl7El
 x2at2Z9OASNhy/AzYLSAOlPg8gExhJcuCjdSR4hYT0Z0N2LsIZkZDg5jdPyJXco9OCGA79osY4R
 eHm2WAZUPHbK5QtnoygpBZP7cy47Q+PJShk+wYoXTT5yfz/V6PxL4BHNljTIfEJdkehh9x2+kOZ
 d0g+1JAx4Ogjo5BEoMCe+fPGLasfUfn2ADhIF+ddY5bO/Mg0k2Y5WqXz8IxjJNahzEj7pe9VF5l
 NSEXyc8J28BEW1nQ6OHoVxRUfEvsdBw4QoaUhBmuWF3utejMeq81Xd09wVrFq9YmBwHX88YHvcD
 M0uGRC5TXWeXp6+/Vkew==
X-Received: by 2002:a17:90a:d603:b0:3ad:53a7:62d5 with SMTP id
 98e67ed59e1d1-3ae89773480mr3717211a91.12.1793439245161; Sat, 31 Oct 2026
 02:34:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:59 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:06 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-10-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-10-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:59 -0700
X-Gm-Features: AclHuK_jbdV9xZyDbIhxpSUx4FvEiv_Jd179Rj5oUDhGANaquNBLB2brzh-huZM
Message-ID: <CAFLszThHXBxCPT0Wx3DzQCJ-zq=r5E3iW7GH1pXbMpHV8dEAdg@mail.gmail.com>
Subject: Re: [PATCH v2 09/37] clk: rockchip: rk3568: Use PWM0 divider shift
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3568: Use PWM0 divider shift
>
> Use CLK_PWM0_DIV_SHIFT rather than CLK_PWM0_SEL_SHIFT when writing
> the PWM0 divider and the oscillator was selected as parent.
>
> This has no behavior change, shifting zero by either constant still
> result in same zero value.
>
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3568.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
