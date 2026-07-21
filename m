Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB78C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 13:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 064ED40762;
	Tue, 21 Jul 2026 13:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRCYfp5r1t1D; Tue, 21 Jul 2026 13:35:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9017C4092A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784640911;
	bh=bp4h0VbafLu2QEFIwUJp1CjaACn/pdEZPiP5V8C6BUw=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ROjk9PzlePFMziP0CAWREtSvn8kcJYsOvN93xjuxfwHFOQWAENvn0RkNEvthd4PHP
	 xw5qvVDYfUyEyx6ey5//8ZrnwHyW02HyLkCkjZa4rdOZHf4SqUGmXp4utTphXv8k77
	 ciVS6vAKS/QjdUMUvNs8NnIlwy5sdsIllvxFrpkCAOVTzd0cvCcA5pGkSR9MYNnqY+
	 5Jtzg4zLYK6U4Syfq2onf/xC4NYrZoFvfr9u8hd4PkktbxdveZunSH/3+r+0Y3JSzg
	 sUXzqd00UW6OMwLGffgQNZw9y8W5QfAvJ74SDwEA6lcQ1OQIKz88hU/mShuABBl0n8
	 So87OW6ejiaHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9017C4092A;
	Tue, 21 Jul 2026 13:35:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81AB196C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 678AC4012E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0wjXIGjzJT_1 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 13:35:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0ED8540275
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0ED8540275
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0ED8540275
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:35:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C8084659; Tue, 21 Jul 2026 15:35:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D067803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 15:35:04 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15ba5b151dso1107961966b.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 06:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784640904; cv=none;
 d=google.com; s=arc-20260327;
 b=WXH2QYyvuXVI4SGjSFbHZcPTzZ4trEIOKq4kITZFszB5hr6Ys5FR7ZJBX9Zy6uuCVc
 SmLw9gI5aBz/H5/JboqZle9R3TRU3HCdVu0BUf8IZvIYFRKlG4Jn25tNiptotev95w2T
 8QW8X8GCN0A+XWqjXEsbfADB+zdJ02zaiuMAdCgJB0jaRlfJ3LNUDXOlVMWjB/AfDe+0
 U1u//eDGHWgBXeqzsuuGCiFRLfXzhHxFOP2nWhA/BABLIC2BUKu95pjZtSI99qrvMuSW
 adBGZ3xIthZ480ssWb5dQOCG+auW8PeR26QZdEVkzOCQ+KCulxpd+jtBxPIQZxRSRI20
 xH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bp4h0VbafLu2QEFIwUJp1CjaACn/pdEZPiP5V8C6BUw=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=a+YnDROYGZsWeF1eHJlXywfuL2yBvOxT5vOSuu0bW5hsiIwzCEEURUE8H0ifqgEI1x
 nAX0Yi9DitQ5f2kzs+ivr7jeHYV7ZTnFvlqyYQypKwUrRmONUJIP2vW2dsS2FLP/vWB7
 iJoPjHv9cgyrVvHcJkYL9auK4HVghzzEhnR5mBvXT+mF7Cd44VDgnoNH1DGpjdnPolGo
 ApGs/3mUYPHjAXaY6DNfvVe0lbT8+CfKjlyhXJYdvVpJ+XrfkkE9wLf35wotr1IIzApR
 pCZcn3PR+zwy8hLSYlbSFmozwG2ptUWA1+KavQ/FC1JOJG8lTKIzlTl0026JIKhA+fAQ
 KU5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784640904; x=1785245704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bp4h0VbafLu2QEFIwUJp1CjaACn/pdEZPiP5V8C6BUw=;
 b=WoqTRlzxwL5bNRzl3upZWG+hNt+zDimDYqjJMO/o8Y6WCjGxnGEXe46zYGmzYZchcs
 HfTmLz501+jKtxW788jid0bTofRPZfv56SCM5YXeKiZmUqbt5dqSmi2DKLAKbioTAuas
 avtc/7J1tr+8JERGp4+XVcClaruNSwkcTB8fCTSiriPktJ61ruN0o6gA5kHAhbQ5f5JH
 zCIe0it1ZHavLtNwJWfTU1vhRdsFHeNkfdarVsdDDGSeLHrbpvZvWAJPy7xA6Es9nAFv
 5POFsuMU+t5C+y/DDMJmtmp/6/E+ZBhP35InBksWPWKMWPRvqpzMeyHzG3vS12blYW5a
 gcFA==
X-Gm-Message-State: AOJu0YzvMOrGpCcJJXqluCAnXtY2p2vos4mofJaJNo4ORC2G0/K5OBD4
 HkZ04Gg2GlrgUSACSlnZtHDWo8HqInzMBcZwtzsNmyD5NjL/08jGoqjrn/y0fiYGlIw9p8Y6m/o
 UVIXwOUR4ToQVmoZOowkQKxKz/y1zO5VoRv6MGpZcEA==
X-Gm-Gg: AR+sD10waB+RWTpL8Ux61xpShv1aSzMvd5OYVdgRAxOyYZEZ4hFUP8wRJubVAVWY3Tv
 PKrsOwBLi9Hap4gNpIeEyZw00EyQEBbC3zbXIIXRsDqwuY4Gy4fIZX8WRxZCpLQ5LDNa7Y+PWcb
 m8+wGO6b5g4GQu3R73LU/hw2OuLYJ6Klmr4NAx7dpoEUEOhImMfTgcnNLovGEffllBl20ZyGiKI
 TjJh+IdesprHVHqveRR7VtaUGkROnGx2OPp5i0sK+lOLBzfKtolbyYvHfqAvu11Ce17nYkxNM8E
 VHBV2XmCOsdr22ZV3A==
X-Received: by 2002:a17:907:ea7:b0:c15:b9c3:a888 with SMTP id
 a640c23a62f3a-c16b47c7fd6mr806703866b.42.1784640903923; Tue, 21 Jul 2026
 06:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
 <c6beb0ac-0155-4437-a398-0e01241f0e47@cherry.de>
In-Reply-To: <c6beb0ac-0155-4437-a398-0e01241f0e47@cherry.de>
Date: Tue, 21 Jul 2026 17:34:50 +0400
X-Gm-Features: AUfX_mw8UDKvKoY-CqxaLLp6xR6OU-0iKtAnRsBzGpui9qTlPV9xMBkBT0XireY
Message-ID: <CAKTNdwGusMZxvAwrCtmnYDEAn1+dSBfEY4+MSgZx-UJiBKfaPA@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784640904; x=1785245704; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bp4h0VbafLu2QEFIwUJp1CjaACn/pdEZPiP5V8C6BUw=;
 b=NYH4cnvrDCLiLiIVNTBUPCclcqOSwdYrKo3ry5/j6Z6L3mQ/LJmVeQhoQd6pjkoaUq
 l98T0w5PQivZpVSONTjL6eTIdQKagSZM/UfpFn7EivCfspCYe2/A27uX5hCMpKJkyv3s
 aqT599rlGW47CeZRr2lR4m+it1Qo2NIlMSVkthPZqywE3u0JXRbd7F1xT0YNDTQcxvDV
 Y4/cUBuSHvdETBR2gwbHZFMNKX3rGPABD9WIN/hluDrOE/hPQjxti1U10acNzSkImQ93
 0ilGBK92tbUjH/N0OuN+giwWi/t/0szMAJGexvAu2sM39bSf3Z9yX/UdKqxX4PjXircP
 cSJg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=NYH4cnvr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="NYH4cnvr"; 
 dkim-atps=neutral
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
From: Alexey Charkov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Alexey Charkov <alchark@flipper.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Tue, Jul 21, 2026 at 4:56=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> > Current code calculates the fractional component in 32 bits before
> > assigning it to a 64-bit holding variable, causing overflow for real-wo=
rld
> > values of k, given that OSC_HZ is 24000000U. It also does bitwise manua=
l
> > massaging of an unsigned representation of what is actually a two's
> > complement signed value, which is confusing and makes the code harder t=
o
> > read.
> >
> > Read k into a properly signed type and promote operands to avoid overfl=
ow,
>
> I'm not sure this is correct? Converting an unsigned integer (readl
> returns an u32 and con is a u32) to signed (k is s16) is
> implementation-defined as far as I understood (c.f.
> https://en.cppreference.com/c/language/conversion). I'm sure I
> misunderstood the spec but considering signed integer overflow is
> undefined (and I guess one could understand casting a u32 storing a
> number bigger than S16_MAX into an s16 to be some kind of overflow), I'm
> a bit concerned here. I probably forgot important stuff I learned a
> decade ago :) Can you point me where/what I misunderstood?

It is indeed implementation defined in the C standard, but given that
U-Boot enforces the gnu11 convention, it's defined to be reduction
modulo 2^16 [1] along with two's complement representation, which is
exactly what we need here.

[1] https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html

Best regards,
Alexey
