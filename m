Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD57CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7AE380D5B;
	Mon, 19 Oct 2026 13:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOv9tXUextFq; Mon, 19 Oct 2026 13:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1BFF80D87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416363;
	b=tKnXOsfCqlGBld63wD2HLyDgK2ny+4aFPEq/o0UF4Djqvw2YRE+8oPafT1j1SODm10l4
	 ma7Gwf8B3ZqWEMBEnjy4o8Y51CutPGOkRdFFmY01hxXCnQL1wNb8tds1BhOQJVbO0wxP1
	 XxixNR84cXruiP3sS+B6H9Q/wp88St/u7Rrqmgwi6yFrljA7EsQbUCx9/TN7FOrsvSM0v
	 +Omkm1Jh8RMfey/eZFAknn/NY1yQTWwlBNn8HNtq4ZU/aRajiyHpSlARvJ93vp7TT5e1S
	 ZxwXFtRzo2HMnIPooCwPbnEOJyq2bbcYX1OZkgnB3D1taojHad8N4O9PyNozFQZSlVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416363;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
	b=GeSZlsfrbXEEtxsx78JuU7m+IauZxBGXqh4xKzKftbHWoP96wTYOqiitawX7FnjhqUcx
	 YOcoPRxS5YTonOiUzVmfUH7xm81HY2YBskNi3Nhr7P/AFuT0YoOPX3/QUw6E+D0d+VB6R
	 UDKc5hLXLA6ULhLVSwPCjiFEJ0sSb/WofvqGovZBNNI4LlUiSSd6G/gevvI2PfI2xz3ca
	 tmMcvm+zHTs45C0QIi/sFyc1JYffyxG42NIo9VsG//80+mJElfYNu7recZp+Da7ZM5/v0
	 K8A923TELE09XeP17K4SwqNqOfSedvDLmgXintZegcPWKZpfj2fK2THefGVO9Zu0hAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416363;
	bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pLqAyCuDdLnDBERIYhpq8Q5ESA3L/O+SHU1ZRRg4NulgQm5sVAHlIC0gpuvWTsjki
	 f3PgNxsPaLKEiJvvTdltOXtU+bIJMhhx3DHRRELKjK2GSyT7iAjOMDmUBoNfPWmyNB
	 ILbcremubhe7RHXJPtXCijotSDqX1UUEwYx3h226oe0XZI+jAA/lLR37AzOW8K6PTZ
	 UzQuBQNT1n3yxMABMxOlX+ML8MF3kpFjcQspxuxi8JBE7/tXhgdXLvrpvzZvuQiNkx
	 Xwsxb2JeHfs9MT4RkFM1vOziNZQ6pNggDzFAYp8TuOBa+DJFEPsS59YA80HtH0ILM6
	 M9X2+5PPIuc6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1BFF80D87;
	Mon, 19 Oct 2026 13:26:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A334923F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 951B84014E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9Mk_ERnF7ZT for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:26:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B9714010C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416361;
 b=USz/FM1cQdk8BOoQxv3fjn7oiHNRHWmoBjWUuU/1zXjaVCYOa+nt4FtdeSJAcLRzswzg
 da7bfd9MUdgmi0KKI9do183vPloswY0N1zQ0FejUTXY4eO0iAD8YpSs++1aKsW9rA2Z4K
 T+ooIkUJe+01at/VfD4dSZHljc8IXEVa7D5cdAP5R2UfGuvwk7lmqSGVZEiC9L8FeWABy
 WQ4viw5U9X8P8ZQcBZKLBzp/UFa2R+aMlLaYJVdbWqA0WxsTqV2sLwNUQHAYJLfM5UUo4
 OtiO601nDCzwbmv9JMm/fpRFfhZPLlucdFXdHbt4RtJjGvyBgueyn6hk8aFNTbWcRDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416361;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
 b=kQQtqDp5z2TJeVqRBUnRqS0NLPokd+K6rL4gZe/uS3HY47d+WtjpOBk4teFj1Gv9g+4i
 OvzhrXrn1Mf54VqKlLejYQ2F80JNi21qYBfxzCLG4PaSiQpP9SPQzgN4YEgTmN8qQI+3e
 8rHl9Sc857nhMpQNYPljZguybU2vosGGP+1228QlXDdeuIU5dUzbzAsAgOMXocr2ENgY2
 TJETWcIklqHFYSto0UG50ZoQizizFlQZxg13u23p1NQXS2Glgwf31xDVPSQHppG7zdEtP
 1qI/lG+kL/UlitWPjV7zkA0hm0mv7MGzvEOlguWhEgGRUYey8YPqWVhQJ0rnCDaztnQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iMqzXnFg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iMqzXnFg
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B9714010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:00 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so2445694a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416358; cv=none;
 d=google.com; s=arc-20260327;
 b=LPBuT9GeFoWgIjTxYgkjlEP5Cu6y12kv5iYBx5ecFNAM+h8017+kUTX6p3XJgo/Ugb
 8dAXPtwml62lhxHuMjcKOn0983BNirR4VHnFZY6w1NK3x16aL06Cne630RTbUkSvnWHM
 Kcw5Dfh8pGVWypUAsAeCk6QUXFSfvaYKbKJhUBZLFm4nEsYU3tmw11jjsp8+DusFmxUg
 4qOie7bC8ReiVCi5wnlmIJqiu8G4JYjBsKU+I29c3W8PZo5mG/HdvCYVbS/fWxJDkw4Y
 S3z/D4phQH0SKC84dST//w0z3WM6YooaFSbV+FwvUE/EbWAmMZ3MRXg3qhDtiyS+V2fC
 B9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
 fh=/DD+xZkoNTprFhrw2DcgvRFrzcYjpf6tnw1WZgtxNVA=;
 b=Xez/Mu97r3ZdP1vWT+9jEfWQH5HDITbMC9VLXd1SJ0iX/w/dydf7+J3eQi79hkbuts
 zNpd4CA+m9g1JBy8gzGBFSsqdSX1FAS2vvENyX2byTDUf9BOqwHX2XX5B5iDB6oe3uwS
 R+0mLSO9r/on3MtXZ4YtXKvge7J3eeBru9d2HE0XQGprWsBMQSjwmpyiswKOCO5DB6YA
 e/t13bMuTu2HGY/twX6AxxyYG251ioGaSYv5L8M+66cYhR+y6VWr2Eu97RnvRxcAES18
 Pz2Ajkv3UBdJ+ZdUO8hp4Ukgcm6hM3v01B0oPNE8jB+vJhM4LNXpZwSTA0Kmgyl91sjb
 dpJw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416358; x=1793021158;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
 b=iMqzXnFg1fapnoe1Q24ZkW3ir3yNjBsFbpMVAOgDFG+RNIQraMxKPOYvXGN9tMjpyl
 uVddrAtR8aDFbe3jnOE6Swq4IaF1VuOMCRhFcV1/JAR5oaDJ4t8YA7Ok5lsFyXheHCkh
 uLVPmvcrURp15Ti5imm2Msn3yYS0gyu8AHgbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416358; x=1793021158;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gcCm3bOQulQ6nsPP9ilEqQOqsQ6EHmh2Lx6vjV5nSEM=;
 b=wVnLtnxzYOqcZPEDW8gwUBKAuCsKSkzm+0eMdee9yD3Y8Ax4Ok7oSjYkjcGS5rEN0f
 UNLiucr4oj9AE8yr5PaLiGI7yBxWWaDxiQKNoJM++N13+wv1HRTQZyxhG/thdzJWFSCi
 BfUZomxNgekqRrm5cfRhvbWIX10huDH4kUd3ZA3InvurBUafmYI0ASAU2yE44FgdesWn
 1KJiJ+rd6e4b0uCFmcrmxqlMN+nVG3iQ42THEYbiWG79a1ijXKX0+LxIFESNGtMZpBdd
 v2tqTepe77vKARUKMSvT+h6ezK0ILrJTftxK01oyU8MkBc35Zzq+T51Ogo3BOPlTQPKY
 abBw==
X-Gm-Message-State: AFq9FYK1/lOpr7yfbEeUVD84qgpRkzgNaB5hpISP6lTAz2ozdHMFzxHn
 IBmlSKnM9apmGFAjYQD1vl6ZTcztRnFcThfXOKfMx/6p/Na2ZaBis9Hvn3KrQCRtitIPcN0QOyw
 w7j/qF1dutIL05mClwQPYJ2RjRwQJ12XiBLo2wD/F
X-Gm-Gg: AYBFou1KD4UJoMw1dP3EmaO7MR0lzyDFm8s/ndSF90Olav+24vP+mrYKFYlyTjsIohY
 9t8bbZeYLI9VuTL/HuP5l/5X9IHztB5f1LCVDa32MwspRIRdc+uvz0SKlubpz8OCTme/JMyzwS4
 sFAjTmDtNvbK941QM/i0SFT94s8q5pB4CsZRyjT7MGyMRCCWYtUek378aOZH+ycKVwwsXStm63g
 1Cfe+LyOtEKPQmj0HNzKndJOoB+1Obmrb9mxH5YxkUL13hui2hQ1pFJQA+L30wjChKXzQognN0+
 SBDyqSEuXnN3x3POiY03wMD4CfbvpHBcMEmt9Pq9arZmTTKGo4cCGg==
X-Received: by 2002:a05:6402:c20a:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b3a8153deamr3154537a12.10.1792416358274; Mon, 19 Oct 2026
 06:25:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:25:56 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:08:58 +0200
MIME-Version: 1.0
In-Reply-To: <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:25:56 -0700
X-Gm-Features: AclHuK8YoAuOmmBjvPRznjzxy1ILRza0G2AYNo2HHWvEQSOd7xtDm29SqUWr6Rg
Message-ID: <CAFLszTh=G4J=VnUxpg-xHXyPatmfQuCNktoQLC4aquYWTiF8Jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
To: alan.tseng.cs@gmail.com
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com, 
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
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

On 2026-10-17T18:46:22, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> virtio: rtc: Add virtio RTC driver
>
> Add a driver for the virtio RTC device (virtio device ID 17), which
> QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
>
> The device exposes its clocks through a request virtqueue. As the
> virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> which happens after probe(), the first read looks for the clock: it
> asks for the number of clocks with VIRTIO_RTC_REQ_CFG and queries the
> type of each with VIRTIO_RTC_REQ_CLOCK_CAP. Reading the time sends a
> VIRTIO_RTC_REQ_READ for the chosen clock and converts the nanoseconds
> since the epoch with rtc_to_tm(). Each request gives up with
> -ETIMEDOUT if the device does not answer within a second, as virtio_9p
> does. The clocks are read-only, so there is no set operation, and the
> optional alarm feature is not negotiated.
>
> Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock.
> Linux registers an RTC class device only for such a clock and skips
> VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
> step on leap seconds. QEMU, however, exposes a single clock of type
> VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot
> without an RTC there. If no clock smears leap seconds, the driver
> therefore falls back to the first UTC or maybe-smeared UTC clock. A
> leap second step matters little to U-Boot, which only reads the time.
>
> Like Linux, the driver stops looking for a clock as soon as a request
> fails. After a timeout the request is still on the virtqueue, so its
> late response could be taken for that of a later request.
>
> VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> VIRTIO_RNG does for DM_RNG.
>
> If none of the clocks is UTC, the driver remembers it and fails later
> reads with -ENODEV at once, as the set of clocks never changes.
>
> Tested with QEMU v11.1.2 on qemu-riscv64 over both PCI and MMIO.
> Sandbox tests, which emulate the device, follow later in this series.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>
>  drivers/virtio/Kconfig         |  11 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 249 +++++++++++++++++++++++++++++++++++++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 265 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
