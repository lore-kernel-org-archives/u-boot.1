Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F082ACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE6AC4060C;
	Mon,  5 Oct 2026 05:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkgmgsQFK1G6; Mon,  5 Oct 2026 05:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F55A40684
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177199;
	b=Gc4fncyRxH7ZPOlQs70XyhamKzO3kImLfru55kw8QwtJQoyd99kbc0fik6NBCbhHQnug
	 ed7QYC+zNYuINlz7iQ3RcZaVvK7lPogz5BldX9wbYrQ546g/uDuEc3BOwRkmPPBI2uXpV
	 qcv2I67dSaSKJcqmcIXLirSF4mpnFZ8At9Lprhd3mkj7y4+8mGvY23fm7trFu62x6NU6X
	 YAJRjTts4lXrgLbscBtPTtwSdQJdY5DyXwKhKT4Ty0LY6ywg732hoqkZVzyLgYIRAXsKL
	 3ht1o1qXV+BYuF8u5xV6rk/WGwnXTHcFSbFS/zaHOWmhIQ4482IXDSXTvVGLIAwQrLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
	b=EwyU2v7UryivHVzkH0ZfovvYIrknX6KhgspgCBVGp7pvJrTZAwO8De/AggHhNwLa3btF
	 tyJPZa4a044UTxDDzW5JD010mlCujEinezL6jP24bihNUWGESXNmzv9PnnTtMuZH1mcjC
	 RfB/Q1N2+DKcDRTCzHfJBMbWPJv7MYLvXhINV0SI1EgYwS5xmY2QRa5PleHQvykK3s3E3
	 DVhTit5B18xaZrE5F4KOpkgNkGmlS7xz3pSvkxzYGg7C1Pr6DAZGUut9V7qtiqk9aZCVn
	 1X8ENyKNUiJYfzhSq0Z3Ph83Q7PUIvl5KrKVsvRK+gT0BP9OFB/8Qya5cQ6Tzi8THxg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177199;
	bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMKbN64znz0xmQ5RGTNOeHXp4ESXUkpyUkcVvQ8iZPDGvlbblX74SF0M/sXkVrore
	 Gc4e4TN9NOsKfIVBNVWpInfOxDmvW6EYoElZcN11ryl/G4e5q60+7yJxlrq61PmFIP
	 suGnmeNt/LRsV7ZKpJLH+sXodJqnxsVjPi3CtG+wz6b7dMf9POlDSnm7pCYpDhhG4J
	 fk+47RGqbYY2MyNEdDRnxmSstnvafkb0jw7MIzXs6znIwPNsB/AdagpRxeh0F6KFkF
	 bgynMBxvPnnAZEAI5Eb2F9xxBCu7cjybTHWBKwt4QD34QP8EKJ40OHsWYa7fzuNj0o
	 SUypi6ioO+FOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F55A40684;
	Mon,  5 Oct 2026 05:13:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B221732F
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9773D80CF2
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sMuzg-CeufH for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 23:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 431E380CF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791157309;
 b=Ll5FA79Z/MgXBQ5+vpIOBrE+Lnij5SzmzeQcckYH9nqAn8+eoTWqr1MKnGHsl8V9O46f
 Len5dyi0JnTLr6cH8aGC5c/Wc1z5mmi0v//ZpT1T7KUtheR21hjRq973UIUifwCDgByuZ
 ULxij12TYIg2TySzJ60RvKl11kPm07yiqkLEemY1emmOhvrssdKrwpLU/QmXwugfOF9Qw
 dUSKcLImoizIulk+ddsYa2mOrn2XvYCxyz+aSWm7JyFLQK0an8JUWKIGCNJLvYQxx2jcK
 R/k3/uNfhqMrrQBOlANUTePBL+idoDDx+OErZpeprttx8c8XwadepvDbyDe5DJKfDPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791157309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
 b=VqmflK9O29FhREhn1EBQ0GK8WcvDUeiyf3Ip4/78/VvoNgGXImtY/s3eEEZym+ZYUBkG
 N/PldzPI7dQ/oQCVfdWxHwZWDO7HXTq0BCWiHoNqRPMsV116MuYv850l54xSDY1fN7s3n
 PBgumaMfxLizasN1sct/lWOg/IxbwWRhjkLe/vLj0tspRDbt0lfLcuspSTxQ77stXXWZe
 QaNxD2GvHk8tfpP7CBalIp2oYEVi75nkw5qq3vyM+foGgy5ecMqOcFymg4X9grCTfRQXC
 V+7F3nWAnuwJ7HOqz9t/oA/sycVFvcVGK05H1AWZIu/UtibJHtUKwAz553U5gNsgNnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=auYYRZJ2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=m.legenovic@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=auYYRZJ2
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 431E380CF1
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:41:48 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab41af29caso6371917b3.3
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 16:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791157307; cv=none;
 d=google.com; s=arc-20260327;
 b=GyfBTbY8+00q0/0TtL9zs/4wHGNnQgBybrHkwOOHUrFyWqgNDY+FnVZN5xWC9mBidr
 C8euvN0gmH37MlFdMqwQcWQzbbFOOt9Xue2nJlsdj2CEIENtoX0jYtURO6FLcUX0mSmF
 M8dbh3jdF+vRhEfQpYhskQ6lu67yUdxWr/Gq4sfyCBTZ5t8ckZsUZs4jipd+dSt9dYWl
 tgbin71Ks8Q6wgJM4wdZMK1ywkMKTWDcdNXd5XhWO0GxLsaLBp/ZFvK4ehq1pfepfDCi
 cGcuf6uSENKK2v6oMXUc6dLCvw3K0HTscfKHHxim7m39SuVeFkVCA6Phy3/zPMUcytJT
 dbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
 fh=v1QXy7JanD4jU5SDaOjE1ar8UOHRArsrshaSpE69PKY=;
 b=O38BJ++rmIZibZEBj+Ko3bkY1bubHTrszs38e7rMqpmdaoeK5VipgLqnNiAXL2ibdV
 2pI1uQowhe6IjUwbDHYJ0ivGfe+dr6feD0Ef/4RzFop5Ipmd4nI7r2yEbkcda68io6ws
 peHr62xGjfZXc4Xu+SGYHbDSSLVprhxZh0C3wAIarFTTz2TAOL2fpSmml3cWhIbdJJEl
 He3oAuxFCMSgRksLhIxAxTvz7OzVWZ6XlxgnZznCd3w9HhVid7UyN90hIkAeEXa/Fzhh
 MxjJ737O4b3BWXBzdrCyD1gi6Ldka+vgX+ysb/o7R6UJKnF41RRhFfinrlnpFJJViTkz
 vOpg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791157307; x=1791762107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
 b=auYYRZJ2XFa/UrSaANBT2CM3PBSM0wdbna05sA8hNOyFrs3nh4o60yiK9xdOfWi/S9
 voaG1bMvCKqjEf3WVEJpNJFFSgs2WR8KQbGh5Isyd+2xlcmw2PTWvE0OgF9gz0xTSWGQ
 q37SQ0S5OTDRU8UerzgB3tsvlOVxwlVsgh8aKyPY7iyzlt5wxwK82ApSL1Rbo8JaOU65
 Dh5vbnLB45q8/LGBp92pICkUXHP9SH4/1USObhl41HozmlYJMuOOf6JZg8g6LrqW2jO0
 ROx22g5+CgMGINcK0YikhnqkFzW1OFqRyb+XMHFJ9C2mhLEWAKWBf+xkd97/pPwz2bW1
 ZJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791157307; x=1791762107;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZ+U7xWsR3j81UQSuf5gOUKFsV1kmS36KkJeDlhOopY=;
 b=Dr6m9jDf6Atk2BVKdnFFl4TNsHEegUvcKg9ExFrgBNVT8EAYPFygoG1+lckVwRlolq
 6m+L4+E/xS6Qbcqm02KokdFgnpCyCO6b1sh03bquFAbQGVY51pPPUax2yD8SBgIAVXKo
 dV+havW2QU3xqK9lMBEBq3RmzkxXruT8yA4oOFA8HsytEJx4kn/UmcCXrqRH5pOj4qfj
 jN6rUUiMW7m6NKrJh8REQWV8vt0JXbjhc7A1OeoobtesUIaZPF3GSo6KhIwbv7nHsnHB
 zrit8nZ7loo5PUJFNoPqqQ8qbJ/g7hRfWqnmFaQ6rwODad6DRlSPMr0MtDRKGLU0WZqC
 qh1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr29ZnM6aSZG+GKo3ge5VZiZ/ixgIPqU93Y2UJEnIMd0Z5DwrAiDNZlKYUHhsaWNjH2jrK6Ew=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjt2GuNfMvD1CKDlfWJccP1re8+TwOI30ME5+wqLlFrkuKw0TH
 0v8SHkBIOMSg79fO3X2aO0skD0dGf+2WTtf0bzohA0RCLxKi0ShyuCQw4cSNb5XA2iZ4dIzubbT
 3zr6+SSTj7/phyPw28vQcg1/qwYL5W1c=
X-Gm-Gg: AYBFou1sgwpSDQw1vdsEd2P4KPshZ4e1K/6R4E6btlnih9XYzQDAtyX4IzeOrXSHp8S
 yfW4QTdHyyg0Yz8DFh0h4xkAzVFqIrEXx5ooZjkpe14WqXDOyr3twJWuL5SSBaqlOG7mwrRskAe
 eoWIwoCtJH0I4S6b57tX5TeJwqLBO0SpAYj7bdbpc6tYfrgBLgkFVh+/3SEeZdt8CRVB2ZGqjPf
 C6dvJg5mHWpK9hHp56GlFz3K17DnK9GQsJFtPQ/l2fu0b9fM0YzhqAF2zCezazdygU8yzfkUoBo
 sUcrHgJ1RQ3gP96vb3jJOONO1uE29F2MK/vFFiBbGjWoC87OdIUqSRM=
X-Received: by 2002:a05:690c:c16:b0:8ab:3918:33d9 with SMTP id
 00721157ae682-8ae3a1094f1mr45808467b3.61.1791157307279; Sun, 04 Oct 2026
 16:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
 <CAGuQyfVDA9cGRk-o9O2ha3GC5-U+7q3fwz3tJ08-DOxiQEMi=w@mail.gmail.com>
 <CAGuQyfXOPM1KVci6rD1x-uav+dGiH5z2HMz+_5zeXP0BBJhX9A@mail.gmail.com>
 <8baf5015-eefd-45c3-ab65-7e779407e620@kwiboo.se>
In-Reply-To: <8baf5015-eefd-45c3-ab65-7e779407e620@kwiboo.se>
From: Milivoje Legenovic <m.legenovic@gmail.com>
Date: Mon, 5 Oct 2026 01:41:35 +0200
X-Gm-Features: AclHuK9vuKBcycxyJtIjFLvp2t7n5-tnTB_S2XEH1ZlrzuUdUb9Qqt3jQegYXhE
Message-ID: <CAGuQyfX-A2n=Te3RdQ5n_zARKzJ66vaOC7DaH0XYEwMoqSuLTQ@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:17 +0000
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

Hi Jonas,

I've applied your patches, and can confirm it fixes the problem.
Therefore the mystery is solved.

Thanks to everyone involved.

Cheers,
Milivoje

On Fri, Oct 2, 2026 at 7:47=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Hi Milivoje,
>
> On 10/2/2026 2:55 AM, Milivoje Legenovic wrote:
> > Hi Quentin,
> >
> > You=E2=80=99re actually right; git bisect has shown that the problemati=
c
> > commit is the following one:
> >
> > commit c6bba31dbdd450081503dc0e20fcfb4328b347e4
> > Author: Jonas Karlman <jonas@kwiboo.se>
> > Date:   Sat Jul 12 21:12:29 2025 +0000
> >
> >     rockchip: spl-boot-order: Defer probe of boot device
> >
> >     Boot devices are being probed when SPL boot order is determined. Th=
is
> >     may delay boot slightly and can prevent booting from SPI Flash on b=
oards
> >     that use same pins for SPI Flash and eMMC due to pinctrl being appl=
ied
> >     prior to booting.
> >
> >     Instead defer probe of the boot device until SPL try to load image =
from
> >     the boot device by using uclass_find_device_by_of_offset() instead =
of
> >     the get variant.
>
> This patch changed so that devices is lazy probed in SPL, a side affect
> from this has likely been that the clock drivers are no longer always
> probed in SPL phase.
>
> Please see the test the series "rockchip: Always init clocks in SPL
> build for RK35xx" [1], it should help ensure that e.g. SPLL and CPU PLLs
> are configured in SPL, instead of possible having to wait until Linux
> configures CPU clocks.
>
> [1] https://lore.kernel.org/u-boot/20260804002643.2308515-1-jonas@kwiboo.=
se/
>
> Regards,
> Jonas
>
> >
> > Your question about used u-boot and kernel version: currently u-boot
> > version is v2025.10, and this version works. I tried switching to
> > v2026.01 a while ago, but because of this problem I=E2=80=99ve been wai=
ting
> > for a newer version to come out, in the hope that the problem will be
> > sorted out there. I=E2=80=99ve tried every new version, but the problem
> > persisted.. Kernel versiona are: 6.18 (so called "current" kernel in
> > Armbian) and 7.2 (so called "edge"). I have tested both versions, but
> > the behaviour is the same. For git bisect I have used "edge" kernel
> > (7.2.8).
> >
> > I=E2=80=99m absolutely on your side =E2=80=93 we should get to the root=
 of the problem
> > rather than just treating the symptoms.
> >
> > Cheers,
> > Milivoje
> >
> > On Thu, Oct 1, 2026 at 8:59=E2=80=AFPM Milivoje Legenovic <m.legenovic@=
gmail.com> wrote:
> >>
> >> Hi Simon,
> >>
> >> 'dmesg | grep -i dmi' shows this:
> >>
> >> [    1.107089] DMI not present or invalid.
> >>
> >> and /sys/firmware/dmi/tables is not populated:
> >>
> >> ls -l /sys/firmware/dmi/tables
> >> ls: cannot access '/sys/firmware/dmi/tables': No such file or director=
y
> >>
> >> Adding fdt_add_mem_rsv() does not change anything, it still hangs, and
> >> "DMI not present or invalid" message remains. This is how I did it:
> >>
> >> fdt_add_mem_rsv(fdt, smbiosaddr, 0x00001000);
> >>
> >> As I=E2=80=99m not familiar with the code, I didn=E2=80=99t know how t=
o calculate or
> >> determine the table size, so I simply used the SZ_4K constant (aligned
> >> to 4KB). Let me know if that is wrong, and what the correct value
> >> should be.
> >>
> >> Cheers,
> >> Milivoje
> >>
> >> On Thu, Oct 1, 2026 at 3:27=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> >>>
> >>> Hi Milivoje,
> >>>
> >>> On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.=
com> wrote:
> >>>>
> >>>> Hello everyone,
> >>>>
> >>>> Here are the details of my analysis:
> >>>> The commit that introduced the change in behavior in version 2026.01
> >>>> is this one:
> >>>>
> >>>> commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> >>>> Author: Adriana Nicolae <adriana@arista.com>
> >>>> Date:   Thu Nov 27 08:28:34 2025 -0800
> >>>>
> >>>>     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
> >>>>
> >>>>     The Linux kernel can discover SMBIOS tables through two primary =
methods:
> >>>>     1. Via EFI tables, when using EFI boot;
> >>>>     2. Via the 'smbios3-entrypoint' property in the /chosen node of =
the
> >>>>     device tree.
> >>>> ...
> >>>>
> >>>> I found this out by comparing the device tree from a working version=
,
> >>>> decompiled using
> >>>>
> >>>> sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
> >>>>
> >>>> and difference was in /chosen node:
> >>>>
> >>>> chosen {
> >>>>         u-boot,version =3D
> >>>> "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
> >>>>         linux,initrd-end =3D <0x00 0xecbffca5>;
> >>>>         bootargs =3D ...
> >>>>         smbios3-entrypoint =3D <0x00 0xedf47000>;
> >>>>         kaslr-seed =3D <0x00 0x00>;
> >>>>         linux,initrd-start =3D <0x00 0xeb519000>;
> >>>>         stdout-path =3D "serial2:1500000n8";
> >>>> };
> >>>>
> >>>> In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> >>>> searched for this term in git history and found the commit mentioned
> >>>> above.
> >>>> With git show I saw what activates this, and made a patch in armbian
> >>>> build system to disable it and confirm it fixes the problem. And it
> >>>> fixed it.
> >>>>
> >>>> Here is also where kernel hangs for 60 seconds (always at the same p=
lace):
> >>>>
> >>>> [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> >>>> [   78.137967] Freeing initrd memory: 23448K
> >>>> [   78.165027] probe of leds returned 0 after 63677665 usecs
> >>>> [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 aft=
er
> >>>> 63684076 usecs
> >>>>
> >>>> As you can see, I was only able to find the cause, but that=E2=80=99=
s the
> >>>> extent of my expertise.
> >>>>
> >>>> At first, I wanted to sort out the problem with a patch in the Armbi=
an
> >>>> build project, but then I thought: "Why not sort it out at source?"
> >>>
> >>> Good idea!
> >>>
> >>> Does 'dmesg | grep -i dmi' show a DMI line, and is
> >>> /sys/firmware/dmi/tables populated? That shows whether the kernel
> >>> reads the property.
> >>>
> >>> Does the hang go away if the property stays but the region is
> >>> reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE=
)
> >>> next to the setprop in fdt_chosen()
> >>>
> >>> If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.
> >>>
> >>> Regards,
> >>> Simon
> >>>
> >>>>
> >>>> Cheers,
> >>>> Milivoje
> >>>>
> >>>> On Mon, Sep 28, 2026 at 4:37=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> >>>>>
> >>>>> On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmai=
l.com> wrote:
> >>>>>>
> >>>>>> After upgrading u-boot in Armbian for the Odroid M2 board from
> >>>>>> version v2025.10 to a higher version (it doesn=E2=80=99t matter wh=
ich one),
> >>>>>> the board does boot, but the boot process halts for 60 seconds,
> >>>>>> and only continues once this time has elapsed. Debugging via a
> >>>>>> UART cable showed that u-boot hands control over to the kernel,
> >>>>>> and then freezes there. The only difference compared to v2025.10
> >>>>>> was the SMBIOS table. After disabling this configuration option
> >>>>>> everything worked perfectly.
> >>>>>>
> >>>>>> Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> >>>>>> ---
> >>>>>>  configs/odroid-m2-rk3588s_defconfig | 1 +
> >>>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>>
> >>>>> But I agree it would be useful to know why the kernel can hang in t=
his
> >>>>> way (I didn't even know it looked at SMBIOS tables!)
> >>>>>
> >>>>> - Simon
>
