Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4CFC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F04BE606E2;
	Sat,  8 Aug 2026 17:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgrZPq-OBT9F; Sat,  8 Aug 2026 17:31:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1921605FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210267;
	bh=h1HXOwSVXGgPUuTtE89MMmQyAopMebtOpxQnnfZA+Sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C8r6E0N4nEg/SjPd2uir3iCbyKREGUVlYWmorroVYIKOKs/J/W1O/6LDYeETAWpMW
	 OI8VLN+YwK+vnFOAFt92kgbirDXxEMETCYxZhfNxosQQfCgjRsocMncWnn3wtWUI8l
	 hscheUm7wKq6VMinxF0udZWnadYxOO5dTB+PTGARHikqVsiBeIsdLJY8kydh4p7kzt
	 7INAKK+5mJRDBcMZex1tncIipKMWHdePos+0PKjYgfIT9i5d7fsb1Gqsq7yBxAasPH
	 ULb95Lv0r0EENAktdDh6CJ1JrpmfrShGiLGkhGoGv3zt2Q5QQqGZHAEezaTWSerP8M
	 sEK8KjZ2Za4XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1921605FD;
	Sat,  8 Aug 2026 17:31:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1F592F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3B2380E5D
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGuBkNwKtqIq for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 10DD180E5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10DD180E5B
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10DD180E5B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:31:04 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso644972a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210263; cv=none;
 d=google.com; s=arc-20260327;
 b=LTZ6av0eo6AAcGsoemL7uDCHWfcqlaNxtDiK5eAcfjcxoLjMEPKPJoHxu+OrHZIf+s
 c/Fd2BCP6VfdrDurlF0y0EwYhZC+qPOLO96CMZ+qxT20Crnpptq1m/8WXBMha4M9X9g4
 Qlc+vPbq9uyTwk5TtQsI1kf9aANo07WXiBEM4Kines+GfD8go5nWNsHpcuOZ78IMbyJX
 CoNwdLsIKk6VwDYM01LrS8GXtXAH6HU16iniaLPEmqG4KNv+dAdYCE1P8nEbqtgzGKQZ
 x2a0a2Ffy6CmKjqcstGUz8y++akcCwtsAfCbgzd5cy8Lzhpp+1Hs/Rs1u57agY+LBlUU
 c2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h1HXOwSVXGgPUuTtE89MMmQyAopMebtOpxQnnfZA+Sk=;
 fh=QgXxaQXkwLlzfaHTrBmJciG/XjkCLDadBy4GhhVYUO0=;
 b=RAhus/uhOynTB3qP/6VSGEh4sPdsC0xqI5uFkVTCuzSvSqUNvlPrEo71yzlkKon22l
 INW0t2WmHEkpZWC4I8xQATAcgGvHUGzd1Dsp2YoE5O0mWOhn9VBySB0OutrXokBodzLy
 wWScMCKwN1IZ3WsY9/5xT4MvU9ajO/kFpy4+vne/rVM2j7PqhtexZmJJrxip2BRxZkKh
 mhyH+efKuXUvfEKvgEnlmbt0U1xoCdycZV36iQXPiihoJnWkX0LMrvItPy5biLL2IMvX
 6QvqIrXhNnxqEAw9cj7enKjIDNnCOW8yczsShJUbQwoaClebK+yN2GynN5oiZAeA1bRW
 KGRQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210263; x=1786815063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h1HXOwSVXGgPUuTtE89MMmQyAopMebtOpxQnnfZA+Sk=;
 b=n21EWLCkWMr/tlqEsc9XLA96xsrh8gRN3Mk6bf5Nf4AUPiKleltpIZCLMq60Ip4TAW
 nP9w46oHyy5xzYmrwMabG9WTO5FcTmnFlmX+bg748lgcFCxbp0RcK2bzAPEllQ5iv857
 HgPwQCjEtSbHKg+RkJ343JlFhNl9acS4oKMnutmobNBYKYLyxQq0vItljp3dyGk8E3iB
 sFQB86r8W8qBYUnTT0OgF/0H7rEKdkmvX6exBYTz4/P4d1vjWkzvvqU+fu3OVfkS7Rc1
 7OJ3j8LRmcxP4cnvwQeGTIs908ce0v3AaUJMEdRXMTCWlvRV+btsA3htVgZ/QatTAapv
 kkNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuvV3P+va0zUToj4TKAT33Uz20XKxMhpS0iUgHpH58p2btv9VqSUQ8/dKu1Fyi0PjN4Hc9xxw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz/iemQJ+jpE6CCCCu6VpksWAUcX4SZzUdQVhDvfMPmE9G59WeM
 FqycReoIlJ8DhPwNfP7+X/p6EDtkoChZoLdZKIAa1TbBdoJZVxBWGt5T+k5sx1i5BHkhxtuOrdF
 yCEt22fpXgamIzKke2REUU1eEgi+mfZW5p4NDZmZU
X-Gm-Gg: AR+sD10Q5x8pzB60srwW8gajDc0XE0OB2oCn5DER5shWMpjUFUDqAbR24RVIR+/v5T2
 j0ylBa0ic8HKHVQmQvV1AJYrmepIaFu7v/1Xj68FceC4oR7ocWR7350FRpfgJQ9p65f/SZt40QN
 CSGQi86KctHNoIU3QhDz0/iI93ZJMA7M0u12Ss35U7bHkX78GxUAJJdbEOTG3iJKnAMIrX8LiMw
 r6GnB5SofwfLpDpaRA2tlRqe7Y+pm+LpBX0nWzWj1Wg7n7r6C1ArMBLvJSutjyXRf1TsVi+pZGQ
 9Slo+SP4lRoX9MD2MIBGSDA1mKz0KokFNbXcsQ7v4gDL1Ca6Wj6xxA==
X-Received: by 2002:a05:6402:24c1:b0:6a1:f092:3c1e with SMTP id
 4fb4d7f45d1cf-6a1f0923e14mr3429835a12.13.1786210263096; Sat, 08 Aug 2026
 10:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-2-jonas@kwiboo.se>
In-Reply-To: <20260804002643.2308515-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:30:51 -0600
X-Gm-Features: AUfX_myDTBnbUZjJURZD0q0fc2KN7dy2Pe6QzEloNjXy9LzQmJRXHmJdsY-W3Q8
Message-ID: <CAFLszTjXANOTC8r0FbXAL80Zs2m7EpbEPb5BnDF3kWf1QxHpiQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210263; x=1786815063;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h1HXOwSVXGgPUuTtE89MMmQyAopMebtOpxQnnfZA+Sk=;
 b=FFoDZfLaHHJO+rP+Y+X+ikV5QKIL0MbUsrn0Amcv3w1F0gQw3C+eQq21GGB4Ft+8ly
 nEHcbu2TduK++zHMs9ml+vglFXDhLZfOu53mYVSqwk5RbGY9ZC03piqQfZKdRU6Z8ZBR
 SrpWiqGVzaAgq0RnUlGoTwwTppZTTj4uPZko0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FFoDZfLa
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

On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3568: Always init clocks in SPL build
>
> The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.

>
> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3568.

Just to check: "is initialized to 150 MHz" reads as if this already
happens. My understanding is that probe() contains the ACLK_BUS setup,
but nothing forces the CRU to be probed in SPL, so it is silently
skipped. Please spell that out - something like "the clock driver is
currently only probed on demand, so the ACLK_BUS init in probe() is
skipped when no SPL consumer references it" - so the motivation
matches the speedup Alexey reported on the rk3576 patch.

>
> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3568.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2938,6 +2938,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>       struct udevice *sys_child;
>       struct sysreset_reg *priv;
>
> +     /* Ensure clocks are initialized after bind in SPL build */
> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +

Have you considered marking the CRU node bootph-all (or equivalent) in
the DT instead? That is the more usual DM way to force a device up
early, and it avoids sprinkling a phase check into every SoC driver.
If PROBE_AFTER_BIND is genuinely the right hammer here, please add a
note in the commit message explaining why.

Regards,
Simon
