Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00EC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1F438133D;
	Fri,  7 Aug 2026 15:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-d-ERX69oYh; Fri,  7 Aug 2026 15:12:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFEFC81335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786115549;
	bh=Jouaq0XPbwcwF57Hp9C85c5o1iBCgOuZu9DLB/yDlVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfALb1RALAbHZ5w9kCJ+DQ5lRbhlNlzcVG9zJWeyXp/2LV+O7Ym6byFFN9JzObI0J
	 QXtaCD7Er/oAQfZ934ElfkAmzAW44r3yQGea4nf6OU4HRl5UgIROf5SdWD+YrDEwDd
	 DN9+reDg9+OxOzbZSFMhyeIoxnK5Mmi0vUbvmpgAaY9OpdGI9CfoeP8fX0oZHDa4Ho
	 vOSvZMZg4BVQeNLkNddcRVdaPTEbcjnNuD3SqOg8xwiCegZ+uijrS3PnuU/p2kMqEQ
	 /ZVWAPEK8EwKgyJV9keLTloI2hEkhVCOSXs11yDXT4Ps4DT91MPKwkl5n/ThXbh1oF
	 5YIrfadiAXiYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFEFC81335;
	Fri,  7 Aug 2026 15:12:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6559D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCE4F605CF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIXqqV9q783W for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:12:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CF6ED60A7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF6ED60A7D
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF6ED60A7D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:26 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so3844194a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115545; cv=none;
 d=google.com; s=arc-20260327;
 b=i7y8BPFt/KMmGTWHMfte7P43gbWDmNLYqbSY4pbEixcj9Hv6o0dkk0I7BsuiBxKDV8
 WeU4UkqtJp1oQ7Nna8DzSWlhZtgz9c4jp6fq+D2btMP1fCQ0RAbbAb7U27V4bpmb774p
 BFGRS83sn+xfPbpLiVGIgpFGs5iKfnhY+EZyTeoQNqn3yPzFI+bBZbXFUgp8l0n2WTrG
 G9zjMY0DDnCgcWZwwanM9+G/y0KsJSlp1sM6jp5SzjtuR8THzZCxuX/hVDpWSVUm4ile
 /Ddwnzyh/IJ0Lgwm68pZM/6LRVdC/1jPgPYPafNRJHsjZK3Mgb9TMVVaYZqgg8w+CCu0
 rYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jouaq0XPbwcwF57Hp9C85c5o1iBCgOuZu9DLB/yDlVk=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=n1OoxnNgVhTaYV54aosZFubL6lg6/Y/UgUmO/rQEKV1LC67+I6+UksEeE7a+4ia05N
 WmmV+KRJytqAfrJWdxnjgeAKIcDch1xgnXH+xnVuAPSBmimE6o6OitI56WU9JoR8gizd
 0EVLZfJ5cOmqXqS19hBkhikf2YVdSF9pFoUs0lGAg/6NglBAwjLKcKuIap2R5kkVHoif
 GQv1w6JgQ9havwKaZHEHYua49+PExHKbao7D5hLbfJocVEDKfS0eWvknsXbt0GB5HqSZ
 5BHx+YflY2fInGqIvcolEQVltpGJOOWQCVpBus6FH/dGkzJHQJTD4usNLjr0cpr9brHA
 SpMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115545; x=1786720345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jouaq0XPbwcwF57Hp9C85c5o1iBCgOuZu9DLB/yDlVk=;
 b=CWwFaUQZedahnZtrwy2CsMQbdcu05nokCxj7mmFP5O0jkAb2q+oNCc44EJI7hH1Pg/
 I/gUs/VvLmBxnSW5aq/zEyGO9ziu48QqruRO3L10r1D8O4VqA3SD8rVuCZ3/M0rQfW2l
 TnmDNscwFVgHrMsugpK3ZBr274QKbhL1w2G1xaWFT9oKHBPn/WbOdOqPKrXTLyEVaiOR
 2Tsw31Z4FocRGyY5CgrOdy/Y18J+S0Vt4mjI1KxILLrfDWl1OYLETbGJJJIMQvT+mrYS
 8zL0cIoYrKV6n5bTB6cc6aXcayFsYUGivTFuISFk8Vj81calkllnAMQ1eAhLK6aSKOGY
 QlOQ==
X-Gm-Message-State: AOJu0Yw61wZRxQ102boo7jK8EsMxzClxuVnIjanD+KENvjc9CqbS+c+F
 1KixuqaOaDG4CbaANaNNgcGKBdplhp5VaNLOfa0HX/onSOSIxOWvPBVWPHCHlVwjkljDOiZx2HN
 xVzrBnha4t61ryrnj+7TcztWGUA4Meak300Skwwuju9P0C0fo6Ok=
X-Gm-Gg: AR+sD135dbL7BYsTs7gndoVQw6JWQ+AEwZNV1ISZnRnAVwh59DX2c82VU4sgb5QOY80
 WPJVuu/NF1jP5Stp+jp0b37LQdr+dm13JXNMXZWfbemuVlEZildr/hxMdC6az4zKFwsCehOLul5
 fJdmSbCMIiAYdFEQUj2dg0kiG0amncwXc5gZnFSzOrNVWIiXbyXoY0tHfHcMaX0aNHSQ/a2GG3O
 6uMeDUgYkGst+cr7fyEBqhVCaV9HelaN7WUDl3APebwlEvbEF6YxwhkogFfJfbDEcC0fTtG17ub
 t+UHbYcSBRpyrrhW//whdbd4f2z8KsTbKcv0OtJ3leY=
X-Received: by 2002:a05:6402:24c3:b0:69c:73ed:fe9b with SMTP id
 4fb4d7f45d1cf-6a1f2581318mr320041a12.1.1786115544756; Fri, 07 Aug 2026
 08:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
 <20260730094817.1937340-4-pranav.sanwal@amd.com>
In-Reply-To: <20260730094817.1937340-4-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 09:12:11 -0600
X-Gm-Features: AUfX_mzsNT0fQ_ZvmiihYu-sDThq9JA8kgAnPljjYBigT5BAZdw5qJI7taxndrA
Message-ID: <CAFLszTjx7F3jAmMYrTaJWTJDPb4rQV3Uc3Xz8hbMer-QoeqmCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] test: dm: add sandbox coverage for gpio-delay
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786115545; x=1786720345;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jouaq0XPbwcwF57Hp9C85c5o1iBCgOuZu9DLB/yDlVk=;
 b=IfkRojRGz3Fk6l/hiZoay4tCOPKKPzvI0ohNhp2wF8CnICtYXRPo1YGmAsLLWB9Dl7
 +Dnc2PH+TWCSkf+/zqVQVp7MtKuQJMRgTTttEj+wHeXLMX4eWo45QiNgidUEWDtnPGw2
 5YLvZ7/aAFSEkh7ct0LfpFkI6nSJ9kzOpIFmU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IfkRojRG
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

On 2026-07-30T09:48:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> test: dm: add sandbox coverage for gpio-delay
>
> gpio-delay had no sandbox coverage, which is how two bugs in it went
> unnoticed: gpio_delay_xlate() never propagated the requested index
> into the descriptor offset, so every consumer past the first silently
> collided with the first consumer's already-claimed offset 0; and the
> claimed/name tracking arrays were sized and bounds-checked against a
> hardcoded 32 instead of the driver's actual GPIO count. Both are fixed
> by a companion series that is a dependency of this patch: applied
> without it, this test fails outright, since it directly exercises
> both fixes.
>
> Add a test requesting both consumers wired up by gpio-delay-test in
> test.dts (gpio_a 9 and 18): a third consumer colliding with an
> already-claimed offset must fail with -EBUSY, each consumer's write
> must land on its own wrapped GPIO line, and a request past the
> wrapped GPIO count must fail with -EINVAL rather than succeed against
> a hardcoded bound of 32.
>
> Gated on CONFIG_GPIO_DELAY, since not every sandbox variant that
> builds test/dm/gpio.c enables it (sandbox_vpl, sandbox_spl,
> sandbox_noinst, sandbox_flattree).
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> test/dm/gpio.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
