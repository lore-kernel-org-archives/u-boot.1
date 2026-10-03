Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54E2CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D40AA6062C;
	Sat,  3 Oct 2026 05:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1aVQBt3GPAvs; Sat,  3 Oct 2026 05:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 03FD760624
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006099;
	b=owJbDyTnui+asDzmBZcSK7SibApe3qjSbGqtnWYoVohCPQO0dS3v8FRnnPaJz3K83n6J
	 XtkBF3gfTy/Sg7n2T24NuZcivoTJPb/4iPanNZrQDLcNloZP6x11sSaPd1fOW/WndYtFr
	 aH8RvEv6ikG7eRr7Roczqq5r21vDJ3iERwa8QxOKdBR65KaCoguZL0Bhp6wsIL8Ql7zhJ
	 BNzxvsm0X/L0ZalRUsubJS9/ghRyDCmFA1d8RJkOtWljaK2jYvnvo6zWOlr0hiitC8BDg
	 HnPsLKhrXOKXCUVR7WoM8gzT9gcKbDg+WjjkVamuL7kKH9RRrFnKeYGvRw1KnL73xhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791006099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
	b=PPBQBIoYbD64l8YuQYrXHffiaCpY3ppzCje/D3hSEBmkzEDnhIsdtir7U9kBErxD3O37
	 F+meLcvs4dXnheijk7cS66n+/zEGzU/rv8MbU8aUciVZwmaX4jDopw2KsW7M2TA53j/+I
	 WyRfzz5/+ltdP/+mC+dulX9HDdUAMbm48cfBxnfjQCFzWoO9mB75KgrbtKL5MJdHHr1ZU
	 /AARdnOHoWKpEQCHZmC0fuvOW7Kqr1Ce4kMQcDEMPYMjI3oTMPBJ9f3n81yEgizxQX3eA
	 7hq+kuRS4Ny7wVytL6tqg+nDs0SC/zhHoSTh1DF/wbcGaxrQY5jMKRsHgKX1Og8GoKw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791006099;
	bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N5j8jkFIP3Q3dbxCZyiZsoWzklledbtKSimh+jh+0MCfiyXy4CRSMYChOqgbnMDo9
	 CQibK828ejjjpbhus9w2x6GHHW3XaDyEWGvXVJxsnc8cw0aPKTqqi2LgITih/+R1je
	 g2X52YI6Cj7B24pliVnNgQY/O68eUAvzsYnGp3F3C04YHyKm7AghgZiCT76Gkl3gjW
	 7A1ZwyRRLS6aooa+5ZFAoNd8TiCjoWnQWRa3IcrSsWCr6qqqp4smktjxzxccP0Kx5W
	 0Ogryw30vwau+R0k1FQP4PSjH2I+R4kya+ym1LqO7JZmdyf6ZcjhM3MpIhN4nbnOAA
	 G232oGb1LIGpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03FD760624;
	Sat,  3 Oct 2026 05:41:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A41B34D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BD1E810D1
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:41:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZftCDETL37Z for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:41:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D54EF8108D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006097;
 b=LQYMAOGDgwQmypEz88kjrkVwm4cu+d7IVRI1xfhNQogTVyAP19rb+TGokSqKpTWd6oyD
 46lhi1o0QtMKUyO3GOu7mdNMn1mKaxBQT6kiy+Do9G031VpQFuV97CXtX5oLYhfIoNmWw
 /ORtVcTtx4uJBhSmUnPZxlByUup7rUVt5QyM6gyp7OToLX07bItvCaWzMaZfJpMAZpiA9
 QsCyyUosUxVo9Z9y4Yy96VF6Ey3xdIW1oXCNOqjCnOZiQwB1mRz1/Y+Ug7W0LL9zUPGEN
 FSsybS6WKXMLbPUCuKBStBUil1huZmlqS0MMkg2V4ceofsF6KjH1NI9tP9vUN4tUrfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791006097;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
 b=Hv+My4lQgTi5njojK7r7y5lXLgL/13PwGvmg2m0Tna6gMfG0PKg9ZGGYB3EhlG+6eWqD
 rRJ/sxYxhOMH6uO1VgyJcmgnaKZ79pwt61+QJoLw1mmlci77vCqo+EsFiB8olxaPrZ4Pu
 YXHKyWytzei7IsrfHyucv/H4WtI6HfRmLZaIFAGlcnayE7ao7NU8WszfVP9LWNj9B6DVA
 aZc7CnIAuMg/v1qehpSfIQulKA8wUPtUcMnOHNA16GaoHb5LjwlEUQuxgNHf4FN50185G
 tcfSMeDjqgqUKEMPeLK5ua1/7hcjpRoZlr9wf55RQDg2RVN2AInv0NuvlcDY4DNlhRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bx0ueXse; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bx0ueXse
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D54EF8108D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:41:36 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so141272a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791006094; cv=none;
 d=google.com; s=arc-20260327;
 b=YRZr+7zm4BE/Eg5pogYMqQm4D3TNmc3/NJOhL5G3W1k3TqJpXX5XWYyrcKKFhDzmCU
 DxwURzMe2tBkz/WBZBQSRwum4QRPmYz8vJbT2ymgOZuu7CEy4/u61ib+QCZWmSs7BSia
 RSVL8hbn/Iae6MZCX7CiCLcV7LZ1Xmzp4ybwP8jmiD1Bi+CNDsaB7YJBRQDusjhxfDnF
 Wq/VjvdgsrqSgQPLz4Y/9aox2CrrEXGz1gvUGim6O31npBfNTKEdUlpgLeAIgnjnDoOc
 kJq9LQBLBpPZSyEV3V8U4HseduI/R3lVD5siruujEkvZMrH8Ok63/IFhLQAcn6gISULx
 dywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
 fh=MMnq/q7Q3U/JfAJBP5tYhbid7xWowJ+SKkAyHO6PXQM=;
 b=U6o9PbQiU69zH8aaiF9f3HFNLwJCw+jT3QjCHpw27c6olZVoWEsDHIHOm40ik30KA/
 wTZROM7nTnJ4w5l2i7dQgyj8mRIC7VGGzXDYjHHl4jdj6q5Ez4jQCmJrvvuxm4yzdUYT
 QjpD7sksollhnQM5xLJl0hcTliJyhsFYIoLhu/NKU1HVlyC3n4fnLohZ5qVl9jZUmwSC
 D6dOkhIrb9r3BOIGhX7sxN0vmxd5+ofV8/VjPvnXGO/fmUZj8ZD2wkKb6YmK5VXTgFy9
 CJFO+0caZ925yBIwRPqIYuczrtzFBbJyCg5DcoMgCEZSSUAHFMu4PbggrFQ+kWwgK+FG
 //1g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791006094; x=1791610894;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
 b=bx0ueXseMRjrUJoqwvQSSLr7XCXZCyZ681aYx5stZfhqWSTBr8LyTrJdss1611LP6r
 5XecO+THtjbbsZtaf6fRtSAs46jZMb/vw++l3ZbqwbCTWrtR/SajcXcUaJRtE3XfiAlg
 T76IpgC8mwOIfEwP/Leo6h0U0PZEUA8ZPEAX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791006094; x=1791610894;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d8nsUuvz08piWHhyQhLeKDt4tA3rV/uZEVDwCDY+mfg=;
 b=OqlXTDqxhrSE+bAm9JF0BvtfbH8Y9CwB32vQOv0rkfyZrTwY3bX0YuNS5N0lDohslx
 s19DiMvjAasvFM/ftQWY2KXl6bEqpPe7czY8twHo8MW6XG9ExxQ57JdnD3DRNufEvKb3
 D6l7Fcbjr6kJUaHfeiJiDkb2VqTOKf9nLbIYf6ZT/aUus5rT5pLaifzMR6yW/gIZh54I
 ooX3XHbNrb4xuKkmtUG/Z18oV1OPMbkvIHmmztpt47aWZ8xBu3WW0mBdumF7hOMqVha6
 jJLATxCtp6jt7UaKF3Vmx2OlO21J+SFK/kqsTJU7hR8fWR3QGjB/GKwZr2Po2ZRMBX8k
 vaYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqc3rW3InO9u6llpvqZDjf7vPWExW65zPgYnKVMMImOzWChRwghiRLO+e/Q42jSS+sb0goq9Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIJ1ZnVLc+D69jtqHFwlB0IB3qlUMhfBGDagskzxzCX4Ifu/niK
 KS5Dt+jeecV1gJaIqohgsDxeVDxRNNDUJDBSflqADbvjFFcQIWd4p8g9fmrJyF3mwJbs2StFz3e
 ziuw8AyKtAFaIudyiNWevsju5J2OexnBgYxZNqOr5XPJH9zPFhQlA7w==
X-Gm-Gg: AYBFou1vE09Ahaa59AYqr1TQfs1KGLiQFBH3E4Pwp0Tobb0pjNqict1TrCYc0Wu/cxA
 nBCIqKwuJoKDHlLHexBDBwqwJpaa0tYbnaUGTzc9FTT/O/vXQjwfmmePqo9oR1bvZMCptJhxh41
 aZACrb8CNC/ZQ0+IcNBFVfZVl0jNQ2mXK/GFFFHRIdUhoS3kN3uaRtbHZelhMW0ZyRxPYqdHnLH
 pleFFXwyigFEFKh76b1EPoBk5jegC4A8IdCSMenlKYI1JE04oDBluc5m+zwoO5bBUMLrteEDD39
 IsVB22EUG57WT4hLXRus1dTEGqqNebGcwwEwmy3xd1ZGcgFqxMSnAO+p
X-Received: by 2002:a05:6402:1e90:b0:6ac:ae1b:404c with SMTP id
 4fb4d7f45d1cf-6af9e2db6fdmr3628082a12.12.1791006094398; Fri, 02 Oct 2026
 22:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv>
In-Reply-To: <20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 06:41:21 +0100
X-Gm-Features: AclHuK-lKJRIBFHh1KYYjJPkDmMUyxGberr3g2QDV6HRnucDGE8vnP_WwGt5wW8
Message-ID: <CAFLszTj_fXh+4c2Ldq4cw8n973=R-1z38SrE1cp6-Z0hy4+USg@mail.gmail.com>
Subject: Re: [PATCH] spi: Probe a device tree device at the requested speed
To: iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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

Hi Igor,

On 2026-09-30T18:33:24, Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:
> spi: Probe a device tree device at the requested speed
>
> `sf probe <bus>:<cs> <speed>` ignores the speed for a flash that has a
> device tree node. _spi_get_bus_and_cs() probes the device, and with it
> the flash reads its JEDEC ID, at spi-max-frequency from the device tree.
> The requested speed is set only after the probe, and the slave keeps
> max_hz from the device tree, so the next claim of the bus goes back to
> that frequency.
>
> A device bound without a device tree node already gets the requested
> speed and mode before the probe. Do the same for a device from the
> device tree, for the duration of the probe.
>
> On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
> the flash does not answer at the resulting clock, at any requested
> speed:
>
>   => sf probe 1:0 1000000
>   jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
>
> [...]
>
> drivers/spi/spi-uclass.c |  9 +++++++++
>  test/dm/spi.c            | 20 ++++++++++++++++++++
>  2 files changed, 29 insertions(+)

> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> @@ -533,8 +533,17 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
> +             /* Probe at the caller's speed and mode: a flash reads its ID here */
> +             if (speed && !created) {
> +                     plat->max_hz = speed;
> +                     plat->mode = mode;
> +             }
>               ret = device_probe(dev);
> +             plat->max_hz = dt_max_hz;
> +             plat->mode = dt_mode;

The commit message only talks about speed, but this also replaces the
mode... spi_child_pre_probe() copies plat->mode into slave->mode, so
restoring plat->mode afterwards does not undo it: slave->mode keeps
the caller's value while the device stays probed. With 'sf probe 1:0
1000000' the mode is CONFIG_SF_DEFAULT_MODE (normally 0), so the
device-tree bits are lost: SPI_RX_QUAD / SPI_TX_QUAD from
spi-rx/tx-bus-width, SPI_NO_TX / SPI_NO_RX, SPI_CS_HIGH and so on.
spi_nor_scan() checks spi->mode & SPI_RX_QUAD when picking the read
op, so a quad flash would quietly drop to 1-1-1. Before this patch,
slave->mode kept the DT value and only the controller was switched,
via spi_set_speed_mode() further down.

Please can you override just max_hz here? If the mode really must be
honoured, perhaps merge only the SPI_CPHA | SPI_CPOL bits into the DT
value. What do you think?

> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> @@ -533,8 +533,17 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
> +             if (speed && !created) {
> +                     plat->max_hz = speed;

This affects every spi_flash_probe() caller with a DT node, not just
sf probe. Several boards and drivers pass CONFIG_SF_DEFAULT_SPEED
(default 1MHz) and CONFIG_SF_DEFAULT_MODE, e.g. drivers/net/fm/fm.c,
drivers/net/phy/cortina.c, board/gardena/... and cmd/mvebu/bubt.c.
Their flashes are now probed at that speed and stay there, since
slave->max_hz keeps it, rather than running at spi-max-frequency as
they do today. I suspect this is intended, since the caller asked for
that speed, but please can you say so in the commit message so board
maintainers are not surprised by a slower flash.

Also, plat->max_hz now holds the DT value while slave->max_hz holds
the requested one. Just to check: should a requested speed above
spi-max-frequency be honoured here, rather than capped at it?

> diff --git a/test/dm/spi.c b/test/dm/spi.c
> @@ -91,6 +91,26 @@ static int dm_test_spi_find(struct unit_test_state *uts)
> +     ut_assertok(_spi_get_bus_and_cs(busnum, cs, speed, mode, NULL, NULL,
> +                                     &bus, &slave));
> +     ut_asserteq(speed, slave->max_hz);

Please can you also check that the device-tree state survives, e.g.
that plat->max_hz is still 40000000 after the call and slave->mode
keeps its DT bits? That would have caught the mode problem above.

Regards,
Simon
