Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE0606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yUZxWvm5;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IdClvZGQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37F00607A0;
	Sat, 31 Oct 2026 09:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHHNsGUF-QR8; Sat, 31 Oct 2026 09:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7336760A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439406;
	b=EsaFYEmb1MBLHc4w+fJuJ3zW7O3XNxQVtFOeL/1F9DrYQGOnTgIO3qcHUJH6swTYa/kx
	 6kjBSzA0qWTmEgDswKhaZpJnrtxrTnQpc4wy3NHppE8c4k4ogvfevHLqdnBJHqW3rwFt4
	 x99ZCgb9TQZBY83G74s8+W6Zd7LLytmmHZzI8ZHYBq11MfYyo+JWQ+RrvTGrnRxJK//gL
	 eVp6TZVXdtoitag7knumobJrZttihpY/nM9gNebZ1Ab6FgWfcHV4ftINSoKnBbPz8A2Cz
	 539BHcCR/4ElVd8HcI6f6g007bK1W6oscWLp3KAIxQUaW09iW6Q9shCCdU5kIHfgv3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
	b=icW/ei/fj+0ulmsmzW+ckG4htYtwB87350FM5bqTYnXMgcMqMHrcipp+PtrXIDQ3979m
	 VIkGH0KKfUoOcc8atd/p9q49rFo6c7OYrq34HPkAaTVNsMwww5OGLwQuim0R4c9w+tnyK
	 8FBLOkyjirm6XRaEWs1BxzeNLfzRlkfzV7X/KuqQO5ZsupgZcTt9racnpFiBE+6Z4brKF
	 M1iyaslYQ3cd6Zfbd/075Eb91x3yj0lC+hik5KnK9BVo4NiIE01Agxl8tgx3AgdSQg1Wy
	 Bpp//JgxBbR9lw9UubSmh5GKZIEWjPYTuoBIVeogk7nA2inc4myfK3Z/yOBVsBoeTnQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439406;
	bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUZxWvm5W3fNxcJL2fP2gu8XS8zgGPGLhFqHqJFD1T7U+V0QI21RigK81gYaZAH7y
	 wnzSoHX2hEKe1XDAn8GsMqtKJVW62XD11pZLI/EREwAhkqOKvDDjjqJOjUv1WPMDtL
	 GwvwlVi5bykyvUteOW7fuNNoQOa2GEaXgxHSUyVonqs3vash73OuTKxW8nQQHRfCvy
	 +foQ/bFWDrO3gpaqMpzTeecO306EQxhDLvrLE7mWxzI4bCkpMB/qSfaz5sWbZVbCUK
	 paV9ZU2ojGImxDM+CbCdCwXhHrU1bYiykU+XCB4d6EIQT98VZunaChtOJjU3GKP0Lt
	 1wl1bDF0MAVeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7336760A88;
	Sat, 31 Oct 2026 09:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6B4932A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98E1C81166
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPU1Pzlh5KHh for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2F6A811A4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439375;
 b=Ox24vCpkSQCstySE3Xl21SVvsjaAFpTnjXN2vifA0i7hB2q4Mm2bE8BNLCiP7/sLCx8/
 j2e/luFn2hLKrpw5X8PJIkJHe+028hAJN8vx4Hnvs95vWp3+CbuVC4nuhdR121L5BE46S
 uZ6zIe3mB92UNg/hvIepatUm6GOdEprHc0jYombZW/RicbxVuav24FoBXM6vt7g3/7k17
 3oAbIHYxIl8Kpsx7Ia12xR6po1/5g3zz85F/tGikNE28RWqYLKzmXm8ubfrE6hU7XMfBr
 XaLy3y3/rhb/Rvu14Uf5+5iG9w8zSfiweYuJT2SjFLHZPra635U+ShNdQFD2NBghc/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
 b=RmAyitzA9jb/CKd9SteaMZD2Ilq+vBa2Vu1/+DfXolieesq4Cayd1B4+3X0k3OS4bFKZ
 HLN+DvQ8eGu+/d4K8d2l0eqO9rPDICXONRCoj+aYZEchlb8KcqfxcSWROXGZ9JDZ1Yc4z
 43IrgNAQ7IwRpz6HBOdlx/jVLk8qOfgWozzgH1VBBFLkAgCWohsNbgUnmDP1hr+Gl92EZ
 yDqMzO1Z5zyoEM6kAyHvcSAkggg/Xi3kbaNx+7rGS2oznSaVePBQ1u/RAKjQX+XaJXCwX
 FpWkzZZJbTG1Pkb7ltP3aS0EJi9a7nqBsfBi3N36vqnVToNFpEKEDFX8b2/1YvzTPmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IdClvZGQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IdClvZGQ
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2F6A811A4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:14 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2877641a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439372; cv=none;
 d=google.com; s=arc-20260327;
 b=pTFg+cjuQinVEhAirOXFuEX7QxBJwWIaom15MCsXYnPXK29DR1rwogVm2AkoeOtBlS
 FfnAhXot7cZFdHLOfiB5sjB00oZ92hbZjKpz0KwJA3Ti2OljAamQsjf7Q40hdXeW1mZf
 CpQJWGeqwWSLJpcXaHEgUm4o5aSm8XwWrk63ztNx0IKVHAaFREH9KXEGgomNNT8GGBCy
 UiP7Yg4QItHlvwpAOqwU/W0YwD6SNQ8iIFRvhTAyy+puQhmUN2kv7D7ZnSXWJwoqZNpA
 D8BsJqKvPq/k6/7GqCD6hxb6Kd1OJsvZh7JqMibxS9rLINU3mzwrnDi8a0Qr1A8meTnu
 fxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
 fh=sc+Wg1K8oe9TZfctlH+2TEGLUF+B9MU5G8+eRbmB+Uw=;
 b=mhi8kw231kPtKTQrFMBIlDqLR9Dhh92f9oWhI7RchqPR6x0ma/Zml01sk3SBYLxS+U
 8YZryQ670KVKLunRiSwRliifSLE08DU/Zfo6a2Xhtlrq0BV1GwptYhciO5UqNtZ8Qvd3
 GkZ6r1Zvbind9bayfNLSXQ7hM9n6n45+QA9Sgmq3enCloTSD6EesrB9xx5CP8W74ZTlQ
 9huuSQxTFr6kjj2rPpC85XBpXfET3C+9Yopr3PZBlNmEuh9LU7ySmBrwTInEdsnML2nN
 pnItWxAW32Lk1uAXFZ4jKs6rVLQQtP9TbivvPSXvZyDO4Hn9yafgrZxBc1mHVl5NVzf7
 lFow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439372; x=1794044172;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
 b=IdClvZGQGyrbnXUP8hS6XVHELHZ/cFcAOonk15UTg0VGeafRNSNPMpOJO8VuDiNYHP
 z+zjvkbbFBAVFe50gLrlcn+vMjYc8fYEae84GQtsFwX8QnCo48KWOWGH+hYYhbhIQqqt
 xkbZueMOWl050v/LBKA/4n1D4epzXeXxYRnqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439372; x=1794044172;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dhjvouMOSDrL7JHBYIHQBBvDopdgHXTLJuRYi2M/tws=;
 b=diZ3czClto7mQog5inV2ofZNBIVGCGhxmZJ+OWypQJy0HQhtL9U2weZOSzV3RJLDhm
 VeTlqGqxjFXvj7/jjZ/v7jZnLz28Qo54K3ZqnL91KMKsMjbU3Ruj+sr2kR9fV8DKawfH
 3mEyZuRzBoCDnrGq5+Zt1INoUjE5Yeod1Q+tYUKMjEcR7PrRzpeyC+Nl6CAHEzP4KbMw
 yez0xuZoWFDAuqAlsUveyPzGZEN+pUMIVNyvxy6ONXm1R3syGc/Tbl1uzMQj3TdXp2V6
 UApNah187kBfuWjb8+OFPlzxPsKgCwrEz8ysh8L0CujumbEk0aNhThoK1Y9mYwddA6RS
 8sPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpj9zjKa2TwZixZTqMsVuF7WKVBdf2OIWAGBtjsVcfwXystGgBHvu7kmz9ln/b1nAv2aL8e6w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL4Bt7xTPqkvCmTy37QNEmvcgVrKsh2TRpINsRuhU7YfjXkQS45
 GvlgCchsnuDTX0SeXHVfDM8b4nRdDVH8Xx1H9azHyMt3jq3jr1wqHLQ7GxfQg3qvub/7U+7BUn3
 jMPCm6snxcma+da0lqFHSzvtCiAqYWVBHOfwv2Rqr
X-Gm-Gg: AYBFou26Z1frhmwBue1KHmf0mXxRJu8dNyWE0XL6PAWe/2TJj2nDFCZCOEI4p7wWEGn
 2TwjVnMwlsp7YXgNy5VtXhKS7wiUMcEKEhl8MNvY4pbyO4WvGGk1nRJTdDctnHKa07WrxgwDC32
 t363feVpBApFYbq5snGxyeHpZ8exDzdcvKf3/7IzCCYE/AcRL2CO6KM8wtJ9B7bXjHFu2GMUw5R
 +Sgr8llrfyd53pnjzrdb9Mc+121p4pk3MCWB4NQw0zwdpJxJZS2yfMihsLWTO6P0wHoz9UbbDPy
 WwVrhlkr0+R9z8heu9M9zzo0UQpjt6DEJ8IuVHZ5RctlptHY3fhrWInzj8ckbsqjE6TxdCmDpvk
 28/FhYq7fimCX1nGqvSPHmxUQW4FgxPZ/JhcEuP9QqNHuEcW8NxEr2SSndMv+/7veZDywqQ5Xxq
 4lzJ5rEjTqbCYf97v2
X-Received: by 2002:aa7:df90:0:b0:6b4:30ef:f349 with SMTP id
 4fb4d7f45d1cf-6b4d4c710f6mr2576379a12.32.1793439372581; Sat, 31 Oct 2026
 02:36:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:36:10 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-32-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-32-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:36:10 -0400
X-Gm-Features: AclHuK9pb9KQ7L4_YKgVNChZwBZM_IUTUyUWOO-_dvdwU_4NdqhuTYn7Ri4B3cA
Message-ID: <CAFLszTgrsrzQ1q+FA5aXKht8_-j5KJLWcYqh+62Th9xh9bvMtA@mail.gmail.com>
Subject: Re: [PATCH v2 31/37] clk: rockchip: rk3528: Return correct rate for
 CLK_PWMx
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>,
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3528: Return correct rate for CLK_PWMx
>
> The PWM clock getter overwrites the 100 MHz rate with the oscillator
> rate because the 50 MHz parent test starts a separate if-else statement.
>
> Change to use else-if so the getter returns 100 MHz when the 100 MHz
> parent is selected.
>
> Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3528.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
