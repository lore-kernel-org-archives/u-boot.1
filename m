Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA2CC55822
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 07:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9875540748;
	Wed,  5 Aug 2026 07:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYqZQp87aRID; Wed,  5 Aug 2026 07:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3225F4069B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785914524;
	bh=4Qa/KytJ+qkNEYaS8/SceLxrvxxWQXY75dReIimSqEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vWhVD9qZjS3H7t8xqWAZsKXIsNaeJFs9zzz9436h9cwRSXknuwa2b8WwURNZbc2GJ
	 SOuUqMV8zvOF5VNsO3RSSUBkQmzg1NbIdu+JNsySsvxGlQ1RNoEa18j3oZ6E6NQfHX
	 7+U8KDytAmQBcoQwXf2tD2xQwHJiA2/IUS0xk/K2WJgRmEO2s2AqQu81feZ98TELPZ
	 a4fHCfwv20ry+MhfT8xHSLFc/eATZrRsBFqj3nX0V/G7P5ZG90BDrGF40fYWMyWiel
	 VY0PX59r1p2LTBcRhtNUgun8inIQvuZ53ovovKrcFtyOx1Z5zRPzwROYB2mQUkQvqM
	 mb9Q3Wmq+boFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3225F4069B;
	Wed,  5 Aug 2026 07:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15B18270
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 076B64009E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqqcsR575ENt for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 07:22:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 04E3C40067
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04E3C40067
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04E3C40067
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:22:00 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so72030366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 00:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785914519; cv=none;
 d=google.com; s=arc-20260327;
 b=nWTp9wvx3Q6dvUjP8Zb94ZksdaOhazlB56zgz6e3OBhjaUmbLD6/bg16Bghj0k7+ZH
 sAgS7QX86GhEcFp4/dBmj8/Na69gKLjcdJJT8MPFd6oRaY8sZOIiv/aISLuC7DsEI/hU
 nar0gX0ahuGTx5xkoDSNkl/x8aNW/3Onp38GMAgI9iCuZ1DmlNsoJh/IfM5YXutBvorO
 /PZp6/G2Np/QcLarDjBPEzok8RMa7O6rCSAdZCpJIlI4qiMUf0rvRdKOTYbiQ/ABSjwS
 wPjSiBMzimTWgpsB0IMN6bGx4/q5h4rnaHo8t+TpTHkavwbexMWvoPU2wb3eVuc++XRB
 rK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Qa/KytJ+qkNEYaS8/SceLxrvxxWQXY75dReIimSqEU=;
 fh=RdHN9Sk+oak4QzS8Ua6OA7f6ahec/Nk6r//CNAYeWGE=;
 b=UwoPndDsGCOAAgP25DNeplnPYKsNWuWAmuYMhPp4cXPDHscJkTpqaymuEJf+it+HBu
 EsvZBzXwFaWV2Wys6Iq+jVNyk+zNE4C0SsmjkDHl3rd6O8Iq2CrcTsIFyuqk2+cAXoLZ
 Yfm19rthhS5SQm2UDQZ7YJZI8Jj5/yoJqT19K5NU97u/LjeleUGG07dGFXLppHIXvVez
 5bvkBfEC+iZLCPEWBPgS49lJA6HsMJncfGMrrudhsIUxVRs7Z/wdRf/czwY24OgpgCP6
 qlPqszVPP1WNM9IaiaIdrKKCuROPrBtxYtQ5YwK9z9aki6PLVOo0x6RM78VkMhaTFVwf
 mxbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785914519; x=1786519319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Qa/KytJ+qkNEYaS8/SceLxrvxxWQXY75dReIimSqEU=;
 b=WtupfqY2vWWKGPL6w7Kcbq2y9fW3wJT9VyDNXs7Hy9fTpwCnwzVrHwt27bARxiTs51
 FKjT8m5doVncSlaHlwlr8iGBihUL7m5DDVT6T09F6vn+hloy/ezCs6R0KCvqdSICXR2h
 76fLP1rh5c9b3GJwj/vRbcWkuCRFjgMOUJm3LNds0Wyk1AORisxzAY8l2oPkjgwDDfFd
 oUlpL0a16W5dJM6zzw6mDoQSbJsQtWgCdEqlC6H0EpyP3qnp70HVPJ/ti3ZCpXxqVrfk
 GkdH1RZc/PVvO6kP7BTWXQEePfe/lUruUWWkBTq6iiVX7KHSVOGWu/n5YjFUBOAucyB2
 oICg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9ZxoojJgwpR4MxnWIRTK7n0sX8feCQEtAXUwEpFlFQeKEtOxsW2O874uWS078cwxR0b9JSEE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyIoGcELfQ6c6JZ5wKkiQtyHrCC/YXk9pWn11odGHJSgvciXpLS
 Kv6l5DHtRhLo1uMvyxCDQF8yvDCXrgR4dQRyOm00SDZoY0v/mXBGXJteY54MI0IfSPCEj5TLA6A
 2bAxzSAeCEUfZJ4U/LkJi64rgS822FMVtB67CrXoFW43xqpVbajaqS4A=
X-Gm-Gg: AR+sD100NNUPH6gBffGl9QMqKmpfOFGrLvIzr2CM6+zF89WGMtsyde0yvzilFgKUZCK
 E3Dv+4Y4KTJC5R6janJTpAOmi+FiOyIImu0ryXgG41paMCXX1ynaqWTtkKfIlR4Vxs7k9rLJhns
 J3Dkcp3BZnRsMP7q1FEHl1jqdZdQjgENUVFTaMeTb7GzJD+AEstZ5jKgRgEM6ZIakKBf/bQPLN6
 0yIgtWXYaWYARnDoUNaFh052pkUdRXTWOP21ZKzEI+pe7pG7krtjlh8CFNOWoIipFnR4lR6fK/V
 qo0cSRpPl3Vfhrq8ZN358S1zGbWYNtU1uO+G8fEZ7anOLmMj/WuNDJNBmFQcmrKbf4hPwaKgMJR
 d
X-Received: by 2002:a17:907:a4b:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c2039b073ebmr165888066b.10.1785914518737; Wed, 05 Aug 2026
 00:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-4-jonas@kwiboo.se>
In-Reply-To: <20260804002643.2308515-4-jonas@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 5 Aug 2026 11:21:49 +0400
X-Gm-Features: AUfX_myYtbJVU0widJ9_kBj5bT3bOAY_FnNuvO7Q41u2fKiG1Yt3ugXmIWsh0qo
Message-ID: <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785914519; x=1786519319;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Qa/KytJ+qkNEYaS8/SceLxrvxxWQXY75dReIimSqEU=;
 b=xzTlfL7EwOhPJqyl4gPtjBGud3jigkASCHMZixyx31NQp3FXAy94cClxCXg0jvUSNJ
 x5wcsBxFjNkDqcBprqwKk/rEArzrhAjZoAYIp1e7GEy5fURv8nVq/1pfaOpwns5h739O
 gWgg+ZUUrRrF7RUV0fm91YeEnwhvi2uXiQb/9ZfpulGn98JrCBoI5i0/38B44DxOIXDM
 rfMQ3JFs8qA2inKHI1RYCd6gn5x/pXTiubCscR/HgTFuiQB6q94oKPd29iWOkKgbWvhE
 Ak6h7JJTQKHTKSgH7kqkrIQPWi6m6NjlBkXmC99fZEVH7ae0OrBYSMVmgKQO6dc18e0Y
 WXWQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xzTlfL7E
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

Thanks a lot for your work on this!

On Tue, Aug 4, 2026 at 4:26=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> The ore PLLs are only initialized in SPL on RK3576.

/s/ore/core/ ?

> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3576.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested it with my 41MB Falcon Linux payload on a Flipper One (RK3576),
and it gives a very noticeable improvement in loading speed: time from
start of BL33 to initramfs goes down from ~20s to ~3s, which is quite
welcome :)

Tested-by: Alexey Charkov <alchark@flipper.net>

Best regards,
Alexey
