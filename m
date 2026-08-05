Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA4C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45997607FC;
	Wed,  5 Aug 2026 21:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtUQk-BBNtvU; Wed,  5 Aug 2026 21:59:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 717AF607F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967144;
	bh=SMAh5uiLxSLXayKJjRjXItA0HV220xIexnJg2oZnYr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gdpLmd2wB8ubSB/be4EqcVZnhRzpmngFkAfqVBnqCqL1X9FUb1IaY3iZzy2q0zgkY
	 YMEVV1rfJ4spgkSVekOR1oyn9jSHxDbQR2RgJ5sLi4z7z1M5vh/LHVlPZTqCmm+7BB
	 aZAnIElbrmMHSL/V6V405DPNDuGGJ/eHfOO0tOsmXF3RPgxsgZUQ+lY7EOjABk1KYk
	 jQ7UhVLQ2N2dYD04ZwLdBU2KYcaWVwePFJkVnXJPpVHn4qkHkGAWkNxz84Dpavs3lB
	 u6Ji0fovuXVhhf7woNv4xUwlkJ4mP33b3a4+Ax006gswPg0tWA89siXgdIFoXR/wmQ
	 HpHHbZJGUJNDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 717AF607F0;
	Wed,  5 Aug 2026 21:59:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60A4B2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4692480DB0
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id caGtB8vgegHo for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:59:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 40B1280CDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40B1280CDA
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B1280CDA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:02 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so275447466b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967140; cv=none;
 d=google.com; s=arc-20260327;
 b=aqI2bQKNm4VGgRjyqDEVLGxnuvWtfef9Rx60fnZHzuQU/rgrLhhUOTvJMvwhnorR3D
 ZqNA9ltZ5zT3TFswNVU4OFpl97uNmjWsmIfLKZSFP92HEARgY44o2V800LIhh5b8N+K2
 MwoJCFdekDzPKSPfs9Ihe4vHN9zFhxYVgYL5zlE8n6Yd0cDvAPNIoGL6gQu6UzIZmnNC
 Be3klPnEzjCSGvBfgVEPQXILvEJcUudSBtfS0ga61XSS2BJyKR/ztY+EGho7rWoUgHRM
 nkdhPbixqxc3ReoODWZ/NoSLCFLL/m8W9PBdkOMcyjwSeNkITRfoRGzUWekwy1d9A9jz
 TeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SMAh5uiLxSLXayKJjRjXItA0HV220xIexnJg2oZnYr4=;
 fh=LQ6cowotaEMO5/ViiZnX2KTGu3bKU5XXocuZzjTENVc=;
 b=E08mJrsd2eCh1g7Poc84s45juRxx58n/ugClOOw+20M2vhGpuDeB9qkbnRBZU69NpN
 yDuP4mfP/0OE3/ouMPv2yZ51lL7pMzLgf2sFhrKTHLchXs2f8HTOw+JeNJ2jjvH8dusc
 ScjRhoeQImzJ7SdW+4aR+KD4WWtALoKsJY2ms04RbJ6inEF5KCHkjLGYlEL2i25IWbsB
 I/jcPz/l7IzA34iXeFM9+HcF1E97ZMkXu8ISigSkS8qckj+TlAzYP5vhxbUJEBYYPHDc
 3garwCbVFviXqgaxGaXVwAn5mlWqRJ3FW28VXQhY6MBpju4XQCg8r6vwhtvitCMAs93M
 RuOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785967140; x=1786571940;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SMAh5uiLxSLXayKJjRjXItA0HV220xIexnJg2oZnYr4=;
 b=KFrRDIEVBG3s8zX2xS8BIWkbDJnY4m6RvKFPQbrLkAVq/lvI2jT5VznK2jnWbXFlZl
 W6nqyp0mq7+2DqUI9S1dEPueg1NVJsR+2Ygi3ga/u+Z30Tup7gnSUXcCe7/2F8kBhM7F
 Eft2A9o4VLMlAtrIOdYPTKsGiDHt2B5lAPZJkNf+/8JvZ5ZrAOlATeHHcW+lZPZZLomD
 5MQVF/yfnc8DBIYIoFcBW9VSjSYU86A0ypTCOaaUgwaiwiPyE8Mr8lfskpGwcfx5GZx7
 V/fry42QQEP6CPlHn9Onmj+HqSRwJwPpqMimTjkl3CwKtatPs6FH5md6K38DZ31fXGcS
 15IQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgLg0SG9ylnrKoPieV/qT4Ktndd9WItdBo2xET0eB9fywdrnKsMUyvFylGNb/SmnqxBNL/Rc8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw2TZcU0CZ69MIvBy2AeJc7n5sbz+UvjIM49wzB1tU7I106VgMz
 E5rjdyXT1formKrQYAdvpEecc200WtPj4D/i/XBZ6rmvi9r0+1XuAz9c4prRuLFJ5zmojiQmZLr
 RwS6OQp0aYOVsD+P3ZHgZ1sYDoqBlZbJqT+dYMc4H
X-Gm-Gg: AR+sD11qW0YhvD5+/hbhDv+LwEtaJoPle8uJdYfmsIM5OWj4BixKfJPMpsp4ipEF68k
 /Hwsiwp7bUauLpCp0y8SFbKyTsBmrJtiEL310W3GTr0b/0yopKymY74kTW8UFGmByHN8d95q9NU
 68Fcsr7NuF3Z3keD56ZoLUASpYDM4lFfgLfT88sW8d5r+EoSXMOmwCdpGJslyGquEJRYxuyNZwl
 x4iP73YVzvnEUXZB1Lf1FBv4UjlbA05omPPAhkw5JZLDU60qqv/bePBHxa+vh7nj5jCIH9bl+s5
 RKP8RnKYFDDgN/iXjcEjfFWHF79WpOIO8y7fJUcDre8=
X-Received: by 2002:a17:906:9f8e:b0:c1f:1520:56d4 with SMTP id
 a640c23a62f3a-c2039eef631mr459985766b.27.1785967140261; Wed, 05 Aug 2026
 14:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
 <20260730-math64-resync-v1-2-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-2-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:58:46 -0600
X-Gm-Features: AUfX_mwWUlWWivMrazywJngNV09cixLLfa0qtaVKzRdUyTLg9Bs6vPWOTPXTa-k
Message-ID: <CAFLszThbY6HiEoh-qgGFazxE9MAYHAAC+2xmqeXfi9n2t=uKyQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib: div64: use abs64() for the 64-bit operands of
 div64_s64()
To: alchark@flipper.net
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785967140; x=1786571940;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SMAh5uiLxSLXayKJjRjXItA0HV220xIexnJg2oZnYr4=;
 b=Qht4pJWy5ug6LnvnHGyjjJQwQwAp7P3ZOPCRnolp8parkpZMA39aTr/YHAuYntypKf
 NyEE/AKLyxH691d20XjqOyuPkvDwWGkCwd4TKBJIaVYVx4u9YcsCNfYRFxm5alA9v9rn
 an5zFnEkl0HcAVmp8mv3RF/f1WSniU2i3S1l4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Qht4pJWy
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

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:
> lib: div64: use abs64() for the 64-bit operands of div64_s64()
>
> Both operands of div64_s64() are s64, but U-Boot's abs() is not 64-bit
> safe. Unlike its Linux counterpart, which dispatches on the argument
> type down to long long, U-Boot's abs() evaluates its argument as int
> whenever sizeof(x) != sizeof(long) and yields a long.
>
> The header even says so: "abs() should not be used for 64-bit types
> (s64, u64, long long) - use abs64() for those."
>
> So on BITS_PER_LONG == 32 both operands are silently truncated to 32
> bits before the division. Simulating the macro with long narrowed to
> 32 bits shows what reaches div64_u64():
>
>   x=         -4294967296  abs()=          0  abs64()=         4294967296
>   x=         -5000000000  abs()=  705032704  abs64()=         5000000000
>   x=-9223372036854775807  abs()=          1  abs64()= 9223372036854775807
>
> A zero from the first case makes the subsequent division a divide by
> zero rather than merely imprecise.
>
> div64_s64() has no in-tree callers today, so this is a latent bug and
> not a regression. Note that the abs() in div_s64_rem() is correct as-is
> and deliberately left alone.
>
> Fixes: 0342e335ba88 ("lib: div64: sync with Linux")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> lib/div64.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
