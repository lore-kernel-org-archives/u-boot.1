Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B1CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C04280F80;
	Mon, 19 Oct 2026 13:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOtN6PKq-kBS; Mon, 19 Oct 2026 13:15:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D7EA80F91
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415742;
	b=BmCCzMv81ESR2SS9HfdxYboGpg45P4p+Wyibe8RPQdpaMCtqomr106PvcuoGoW4b52to
	 vtk4qd4LVBvgLpHAyv0Y1MNugZ7nY3J/E5c0brOcWqTD/VU6xBNelE8aVqwVux2TULTqK
	 7fF4D208Hv1mcd3UEHhCDdrUbtWekXABON9SFj3m8qqSRLrpwFVlrf2xWWqQSnnJkV71y
	 SaWqtMDmQd5sy30ltfYbdO1zdSLcBaklldmKo655ZxgnHz0BnNVBgwRFCt3lejMXkuVhC
	 eYiMNiUpUuY4cBAWUpalThG1UrCIWGb+ssr4UflGMy31gc3Yhzj6rL8ft2cJkjcEyYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
	b=Ikaa8JhLbHYZqxcZ6H+jT+nif1O9yOwF3TH3Q7z2UZx8dByTyGPfnc7iey1UATKUMfIi
	 pG6w5q1eewvncbPoEx5/ecN4y/mtsuNI4BAa4M33oEiYPlvGqgLiG7gOEq6EfklrpmnMH
	 Kmq2BlCgiyJ6JR3BJptbtZluBj6lQ5NKRV8+JqEh4HQZEQXsoXz4NBulWUkTKU5nsvNay
	 J6pDCkAZqtv53oZcdH4EQ0WQ5Y/+pJgLuUVisR01hhv8/cQVGFn1O0QZI2w+VppJWXGaA
	 3wC8daj/Nnuu3h/tNu2qjP9ME3HBIF2R8G8KAA7x1EtT0I1hJqK+GLwoFf5M95xaZog==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415742;
	bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S6Luqu3KPrvqgs0Ll8xn6+hb03CuOTIcKb280ITb2RWTDrmvIjEn0kcb0ol+9awi+
	 fLBMSBVsSEUEOhyjejlFoNsHSTCCyR6b34KI4gHfP2omjuP8oecSDzn8FTkfshi4/J
	 rlzdPFMd2EFvjHLyLon0b6CxAd7Rl94CLI2v9+43Ge+SBxRzqfxZdq7a25/9b4laAw
	 LPU85aXeZMRtp2hyWMcumDjSDv77F/RsU7zh6RyoLCg4zs5Gq4mvc6jjeekJdPRsuV
	 dJacftqydIAxB5NL4fR1lvbcRc8rSJPut/Ert+8+jusQSO5l8/X3KfaRqq0yAhgRiw
	 b4kYqWEV+LBKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D7EA80F91;
	Mon, 19 Oct 2026 13:15:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 833631AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C9D64010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vJzV2C58bIn for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5941340049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415714;
 b=EgRKAtR3UERyRdu7NSEMkwYsLwEolK3rZK1nS+A2Fz2NKPd5DxN31ikYhIALwqv/XoCN
 dAPrtoAUXHzt/G3z+6W5p2fkoHc/zUoPG7zETHzUxO/KDvcyNWGTbTjDcv0zhTISDEhKN
 xQFrLYpLNv55LWqCTAunU7IE7kNwOSxXAuMICKGNMB9UVdlhRHKE6ykgnZj4P8d/DuqLX
 0A6UtusVlJreBAcNFGzuE6HLSCfM+gzyYHraz2w3bIVZQ4/+aS2PmofijwvVWc6CpLdZa
 aH7AJCKN/m39OV+OIJo9t16NEEMuNYxRTyfgVwMsHZEXE79lUmaGiCw+G22ggmdEJnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415714;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
 b=Cugen25EDs1cfQkQ50ui1wUz2teB81pkvpvUX1yLqkXHt5Ljsvxh9DcwQgvDJBqYN+H/
 dlNseapOmPhuvKZHyVKsGXOxDNpuqOGjAQ6HtAYoC65ZNbWZi/EBPR4NTCZM4h42yy9SY
 CMR29ag3MB0JdXdWA98scXACDKBiuZliVAnONKF0kmRZibS9mN66GfDnSDjwnGlbAb8PY
 WqBOpsuO0KcO5dIgA7pQUWLYwINrIYq8YKln7t59A2M7UZz1tPfboOK34oZ1NG8+frUnI
 KaVaRS1zGEooSjTwAmcd+5SoDG5JVfStR1QTullZK84sLM7OqReS7vlua+5fWS67Uiw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oe9PJNH6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oe9PJNH6
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5941340049
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:13 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso3316727a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415711; cv=none;
 d=google.com; s=arc-20260327;
 b=qHZ8nxEU6Ha3cRdEynN0UdIsFg3O4wNyZyfpvlvSQ4k0ulrteqXy25IxzeoQYXsQFI
 kxYOPsbX6bYyaxr0fo8TN+Pfepa9EeReQCnnutQqshdGptPVAR5Fk8sQbOBMI3nM0ujJ
 EOjgByT7F5TYyuvL15Af2INAty8Jlj8rn7eMpw66CQXb6yPb/C5H8pLuvQFgyyCiiQmq
 HU6HYItmsvhqOX//E2X2LhdaXSaOBIscAOOJ0afC15/czMsKupxFkQ2OEi7/kwQcuGlN
 JNdDYDZ53lDhz7bh4hwrEktt62WTdRum1a20ucOaqy9LK1BBhqYpP4AtKUVLCtkUc7S3
 yj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
 fh=uyuXfHCttpL7hwxGVRfOqmZkW+wJuxzsdMvyMyxSrYs=;
 b=szakWrc3lIr+A5hbedy9hkLmKx+oTNNl/NX6v0SOxPb+++XuZaSuVilfOna607copm
 1fZW6mFndVnoiPSxH7MxlDB2cvOdKv98LenIWp4lxZJj+nq40SshcCG9P5abvkphGI0V
 00B4Za1qm0rvXvdhYvH3AvLHptD3jnM/CgOwVZVjLhHFkGWu8jOGbtXrKOP4zQLHUqm2
 K/CdsdSTG98Hope1qw0XOXdW8ea2YtRASX+9Avluwo+rhLJ0/ADza+hFJ7S3R6G9dg3l
 jCWnAFDI2YMXGIhNh31if9TrQHkgSQrLH/xuARTjV13+zMtKLi8QcQGA99HIDzzr6Tbw
 DA1w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415711; x=1793020511;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
 b=oe9PJNH6vH9wTTvK+W8gjbGENaYUEnWtoJALcuBLP1Aj0ehPggaNyNkgdym9JfujFY
 WxIc+911LNN5IYauwUaAG6G0As1LN2XxYXJuoAtqeJp5HPaXjaMGNjz8eOju+WPSUOd4
 XO1s35BPxd9+hpLZ5w9oX79wlbYlRrl1x08YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415711; x=1793020511;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aXM1lP7sEfgd+FMQ3lRSL998oAJOq8xlTB1FOGYC9Kk=;
 b=ij4aMpavJJbtVlFE77SK3kSB9eRqsrfswGTJ2rGck1QyJuzYTksR/wWnQCiTKhp14J
 M7FASEpF/tMV8OVmsBolSkl2Vh2szqVa5ROM3tPLvib7HKP0AolPSBmV0vwguF6tSpl8
 SMIInzdapeEVJ4jc4Z176uuDgJus4ercC+4QDeef7jI57X/fPGbxAV+qsp2H2c4BQcjc
 MOgg/DMadlTBo/wIG4N/eB+GLcIcdAF1iYzgymn2pHFCPjHL/0ZTvwj28S9L4hOS6yFw
 6FfPyz15TrIcivPgH4ZXeORIbUuZfpGhc6LaaUiWcBmxsza48lkxCbKfbw2PexK24F5P
 m1hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuUSChSStEyF3xTq2Rafk4W0FRbwsGhaC9aN+zKPf/s92LvwFoNvhvE2FIm7IJVYgrf0KlKxk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJUVrm3Lotg8YbbUlvoHNw29qwt0Cyryp79MRBnTeKqVQ2/56e/
 gtCgGa0/5l5D2IeT0CyLA6OrFPrXXZ4imqcu5fXrljAR8gyZfpad171s9358h+OHH8LFX33LKPQ
 fn9WBAEoMXkgNo4kRrRRpIV0/EObv9PKXOyMQufuBoVAMraZ6wkQ1oA==
X-Gm-Gg: AYBFou0Llw7EXV98XoVkB/7l0mIxHb93JcqS5gamHxJnw8UxckEPFYNNg06YQh1P9ee
 PxPLQf7nq8ZOeWwQT8haPcwkWgAVn1jOeUc7p9/QIgq2sToEbscPrziXkiKLafrwQaLd9sgUbtt
 VvGKcHFyVVvQRM2fbvtNUE/wxvp0vbSopfISPLcqMm2lO1W6fEYMY5P4Wi6hNS9wXGYe1XHSEk4
 P5xKFQSLM66RWWkTk4LEGSi3ZdB65saZg+YkRgVayJ0Xm8oOuixP1BMeXvslTWhfL56uD8Opg41
 DNVF0H082nhkOax0/1pqpBtqWpjCCRtJ3zRqLPldwdmZ8fVdrxHBaA==
X-Received: by 2002:a05:6402:a582:20b0:6b3:886f:1f0c with SMTP id
 4fb4d7f45d1cf-6b3886f2034mr5617887a12.20.1792415711186; Mon, 19 Oct 2026
 06:15:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:15:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:54:43 +0200
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-13-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-13-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:15:09 -0700
X-Gm-Features: AclHuK-10ksyThlh1Qf_BHwyZNBZIIICgTT3jJK__awuT4fD_PhK22jlmTibVbM
Message-ID: <CAFLszTjcb9hUG_T5eu7oh_GMOqnWA9pFWfrjkfH7+8rZrvRW6w@mail.gmail.com>
Subject: Re: [PATCH v5 12/20] board_f: Add LoongArch path of mon_len
 calculation
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> board_f: Add LoongArch path of mon_len calculation
>
> gd->mon_len is calculated in the same way as SH and RISC-V.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
