Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50165606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B7Q2RmKL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MTPIzk/T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2851140B63;
	Sat, 31 Oct 2026 09:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2NBK1HiwC3O; Sat, 31 Oct 2026 09:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 680A640B3C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439375;
	b=joE/PFXjjmpFFo2FF0RfAEJwR6QVKuHj94fDdEpPVWpUmNoJGddCqC4oesSdlWHNT8qZ
	 bCDABsEeydjcleUjDF9RpQagdMhK3hKuj1M0YPnumSHspSiR8h+ALerqA5qbI4ivb52Ai
	 sipnaF/fPZnAk+Rd9/hvUCb7jcrziKC1EoFx6EBEHSc9rPNrrWj+TmakXVeRoo8Ox9ShH
	 lR1ajZdoYv2Vt/1fMCe/VvSXaF6ugnE6lnIIPugiOghfvVphiclWWsmZxqtQYPsVnnEap
	 Qk9MoOAw8mB7y7T+rGX2nvihA6rNehNBDkbqkjZ3VGHfDhhCZwxw5uEmaA95lDSYMhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
	b=ljK8w4cl+Z+PZVLNawGfCvX/gj7xwYzUcFNx+5TjfLPh7kOfvAbZ0FXwwfwlLuLiX1xL
	 XeWdeROx1drQAhh/HBosyH9I2F+EakQSm47C4Mg9olltUT+ENZJhGqaKq0x/Qy8qr42ni
	 BtuHJqCpBc4pB9QH+CwvlJrU1lhLJIJuVAE4rsZp233j/ADRyMmRiO5SiyXZma+Hm/S4S
	 T4o4JsvqjMJVgjXhe4IA4ElU/rJkYeXrzIykSa4iQCQ3aGZYuq72Y3ci91iwl4mP5/Fer
	 LR38OQUZv4QzsZ5wto2DfarYP2L3AJ4KzZByyd5N0sC3C3j0lHGCj4YP6Q+RxehTuEQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="MTPIzk/T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439375;
	bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7Q2RmKLVN1I7vHEQQCgZzUxKAPCKJ/X5pH7jtXxMxEtxQtZ7s8j+vw6WeziknmwC
	 kONMVSKV1QJ5EbpWCkrmFwdv65WGz86z7wfy0Fl6EJ4XlzUv39xMJbKwaG+1N/FQ99
	 0xF01c+yrdECysJPrpT+2BFKXF0INXK+Hm6dBsYftiHb7T2jEwOVIx6m+8KazPG0KM
	 +QwW+yw5bteE/j17wcpiF+jkVNX6+Eush3AG1a+p8gcwqiKUm1xtodpA78jSoNCVZx
	 x2rfO9tmfM2hpDiTBpzsVZNj4YSAvojUfwgfK56DgqLDvbUzg3w8j2ZlKPoiFbtr5E
	 dW73KmugxkKCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 680A640B3C;
	Sat, 31 Oct 2026 09:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 323A4362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2390340B5F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMF8J-jvGXTV for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B66E40B3C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439360;
 b=Qq4ELTqLNPLITc4eTHNTe3eCJiUKdE2vMvaFFHrtd3xMI91sH2SQYwFZ4jAF59tzeZZm
 z2hZgsD9NvpFMwxaFnRpTUbvtP8Lpw/CjdC+uf39N2qH/7+hyFiEXOpyPziQEGigbiRPu
 2ejH2Oq/1vAWl2TVK9QnSg4/12rv2GTPzPZw5cL3jaO2ZOXMiE7LSFSn4oCU0UVk+M42f
 NfNTnNdNHR7AGzTAE0swQdEYTaPo9Fq65/DNHyIj1WUJQhwuAsN9RgQRHiqTbmggeySsD
 y490+Ds7IK7VHGItpLhGvKiri64lCv5NEkEstnCLlHxKtXiuc6gxCjK5Yq6sAjL0LnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439360;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
 b=MA7XeBX9hvPY2hzkHSA82z1VnrnWPIJFcm+047QD61eyo2eoymqvZOJB3XQceSNYzsyi
 qeLWdBrQaCXPFt7qzSjSJP4XHw949PYs+ko1HS4iFxf+BNeSIh5Gvy1XBNRdtwRCsk7VW
 Adr2motiwXnqhFoS5ZRk5Az/JOvbQ0kOThWspe7B24jEg/XQXadB8sKMehNmFHxFZQMLx
 eQwdWSRzPDvSNsJ49wPVgBbdtKE9dSxPFGYf8ADH+1cY8+iH7WsuWzHJYfL6EVj4V+9Nc
 bdel+gMS0WQ9fwnzRz+l0Gn4bWDh7o0GYs52q6I1m+O8ETI9M5HofuOItYGQ5VcmKdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="MTPIzk/T"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MTPIzk/T
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B66E40B3C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:59 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2240419a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439358; cv=none;
 d=google.com; s=arc-20260327;
 b=JLVQqjxzFZMu0hE9Wc2CCP91gOhsweZqt6qI1z7E9X/jbp8O5lOraFCTiaUScyt0Pl
 72ws7vBpStCBvGG02NUpB1WF3xsi1StjM60WcWCjtx8MxgIEZ8FU5CZJruIO00+V38Oh
 BKmKrC5auNTxkmga9Bq7BpcrQ3iS7ZSTvHB+redHIX/1e5zkTd/Lf8rGvyw1K5X9s9k4
 QrJ7h/gkZ8MA/CmWa8zZmBIr1LRDDkYf3v53LHXNaRiBBwNn1Z1MEOp3gNgom4Pr+NV5
 /XUpAsL9pCsBQC7DmaHkzz2VLOTUKJauAzYkBWjp7DrSbfygZgoeJYw+O1o+LITlOFMH
 Vi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
 fh=kBIKNWay4c+7lC4sdjgkQvnX8Gc+SFOliBwS+H6PU8c=;
 b=dLHo0f0HNBvX18QpUt7rh1wTRZ5KnPP5O3eb6Bejgc73sdaXZX08bBd1/BM8VY/MQE
 IfK6No9nMFCeqranXybqte/NoKBlVPu85qXCBeh6ZWsIjNW+zSOfxvP79CbDP/GAN7ud
 K9HnIL9q2ciNMXRilSRogdnA1mnHaPPutE0pOsbxXWRQPy4AnUpR7D/bcpxmo4HCY3TN
 BYhnH5bHgtpv4xYILsq+E9v0HhFto8zxaCSPOOSsapgztRfSvThB0bFhxsg9oRpUI9WT
 FG1N9QARBwjUgwhUHReXVHnbl3a7VDpJqL2foagrKpmj/D009+8JtyTigGUHtTcHYlry
 MjKw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439358; x=1794044158;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
 b=MTPIzk/TbWIoIpdyvxqRTGD7+DNwg2PU7mGAYOL0iDH2ULijPitFI0mAwGpRVCh4np
 VH7kqrz09wG+YASp8c9pjOqESMdZ2Xx92zYonxLZ25sd0+binAC1kpJYdsoMSXu5c9F2
 fyxJc3KoUERsbLMu/j1z6fDh7HYzPDTFjI68g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439358; x=1794044158;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2tPK0cPALM3yoJGZpNk6IL3hjblLnhQG2g00EYjZVjY=;
 b=nSjjzR2LqS6qS2QFxuLJeCleYDjrxFX2h0Fho3AHZngYSaCEt1/aSfrA11pL34eVWy
 WDJUx971cLd3avXd2Ukau+SkIxk5oON0c9uYNoqIZQaW0DUEtoCwaQi2oXeAEYtemwBF
 9ELvuWbSB+ib5EN8/C2LVOnRZVI5o7J+EZ5G20XHT7IQjOIguS4crHdhO2m6lnTM8ovg
 nhjJgl3OtEkY+E6p6l4cyCv9TeEBKXtuUafQCNHGC10RCl5xqu8m4Xw+p/cRpfeABLMj
 t3F8TAzNst0No+OjzxlyBIzARG4W/dsF9PApf1uKJwLaQJUnygZ6mJriEiOp2/avKUp6
 6Cig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq164hBeOcXV32xSzluEE4mnYdFObwvwkE0j4CnzRR4JRPOuB8TNlJY/9vAaBMnl12YzJRwps=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIonwMoGq8q9UihO6i7E2AoHNOIujMdT68eTejoEEHmLMuMb96P
 XDDd8G2ahIIn5AM4RGWGc17oB+ZvF8pXqd+sz0KXOI/g5wS6oV0wgvimrGtvQKUuB+fPuFJpKgc
 2vjYLWQ1SjD+gEmoZqtStBmJ1Zp/3y3CZsignRS1NkRAFMLxBrowXwQ==
X-Gm-Gg: AYBFou2f3Ua4wNmLYmaqJlwIYJemVZEaVzxLdocpb28f786729BDah/14o16TePNamr
 kgQrcPuL8uCpuzFcYAYFOue822v8dTgC+2nb/VrpAn5WH96v6AkBWxs+GnTdajcUJXxfxGIeCc/
 na2lcJ2u0ABexR0Z6VxGVt1dlWaF5PHtq9+2XeIP14KlGf1r4X0dNDEfFCKbefglkP3cD76ETAY
 WP+PaYWi7hWiZuvIw6qdOn7soTEOe01/CwVFdvfdDDgGqPz3v91NmPNz5zwBe8GVKuTIzpI1//o
 /Rs2stV5gEKHjnVpGCs512GKV5y3IGec/SfsFAf8rmkhaTjpzJkl1BjV5rTvlSEg8hplDp/tSmB
 kCGmhUbN4uZy+m54JFr60yfuognixi/EpSDIYgyDmeGKNj/4LkHMTl5GzD6wR0ALq5Uo9sgg=
X-Received: by 2002:a17:907:80b:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c4ca7a072dcmr417147266b.13.1793439358088; Sat, 31 Oct 2026
 02:35:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:55 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:23 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-27-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-27-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:55 -0700
X-Gm-Features: AclHuK8BLHgpyoCG2UdwLfih8ok_88L1B0cxdEY5V3ODE6M59RzevCfuj_St8IE
Message-ID: <CAFLszTgy6xHfFRADtN0h3k8okmWyuT5w+zxS7cCQq9+yyd+m2g@mail.gmail.com>
Subject: Re: [PATCH v2 26/37] clk: rockchip: rk3576: Use correct PLL rate for
 UART divisor
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
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

Hi Jonas,

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Use correct PLL rate for UART divisor
>
> Calculate the UART divisor from the CPLL rate instead of the GPLL rate
> when CPLL is selected as parent clock.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> @@ -1843,7 +1843,7 @@ static ulong rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
> -		div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +		div = DIV_ROUND_UP(priv->cpll_hz, rate);

BTW rk3576_uart_get_rate() a little higher up has a similar bug. For
UART1 it uses the shift as the mask:

    src = (con & CLK_UART1_SRC_SEL_SHIFT) >> CLK_UART1_SRC_SEL_SHIFT;

so src is always 0 (GPLL) and SCLK_UART1 reports the wrong rate
whenever another parent is selected. It should use
CLK_UART1_SRC_SEL_MASK instead. That could go in a separate patch in
this series, or in a follow-up.

Reviewed-by: Simon Glass <sjg@chromium.org>
