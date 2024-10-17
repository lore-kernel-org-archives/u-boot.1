Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8901D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80770891E5;
	Fri, 18 Oct 2024 01:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDQe9KjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DB4891C6; Fri, 18 Oct 2024 01:23:44 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA068911B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbf2fc28feso9423426d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207421; x=1729812221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cQLROhkeWamFdtVjGRfR29uSzYAK1hlwLSQtO95uwVA=;
 b=FDQe9KjNM9C34Kh/du11GGTMCWDq+3TK8drQpbYw53EC7LqMrvjpcKhMPu0NlZD7g9
 +HANawx1qzdnDAkZ+XuABbTZroLbP7kBvepgkA+y0rqei5T/Y5n5CjNfupDP8wZlXrsd
 C4fGAbE1lKMaznzpFd6Op0tr8QwJ1Qu68+YQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207421; x=1729812221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQLROhkeWamFdtVjGRfR29uSzYAK1hlwLSQtO95uwVA=;
 b=BEtYFQbv9HrlfDDAFlv2hCoOggRRmq2gy4HnoUfL0s39UMo8IXjE6MyAVFfPDGeYVW
 SPy+l02mBzxXsNXMRNWXglWZYrCvUFw/uVNO69+J6OD3xD5TsTndYoveEORlVSvX/85Y
 rZeYHFEnnEgMe/NekXWQCyi6zRMjrlnQxy1gJ8yZr6rteSPIofkgIyz+OMGCKnh7tbrg
 0iDNDrVdRSx/r7yscSqnf2prvtVrvOUf1TWa1Tth6KcJEGA2V2Q9aUMub2ywUlzLPV4t
 BB1givX5qPQ28bHj7QxuVUOzV8r78znsD2Kgd6YqM9s8KMyxJrpCCNQO3JMG0bdheX8u
 BE2w==
X-Gm-Message-State: AOJu0YxBiBsRuW6KbnIQVv5TwdnoivUHNOIiOnITcq5iSfs/0kBExdr1
 sF8ZT0i/CPi+FPWxur+EzoswNlRFQ8WBH17KxUo6uaH1XKsLNQ/F+QeU0ftAwf2zzc6+7C0We2G
 9Zp4k+RNLpYVlwYenh1wYSXPYDqCiDHi3l65CR65GD9oPGGs=
X-Google-Smtp-Source: AGHT+IHKex7E9cIuHfcshzJvSb8DAXvPxCv2Lz+JfONmAzF3krzBeh9W3BkiU52O+ZQe9IkjxYRZVZ495AfsYnX67rM=
X-Received: by 2002:a05:6214:4411:b0:6cc:1de6:1287 with SMTP id
 6a1803df08f44-6cde114741dmr9586286d6.0.1729207421661; Thu, 17 Oct 2024
 16:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-2-ravi@prevas.dk>
 <CAFLszTi37m5b1T03NnB21OTBgqd1dre+o-6AjjsQvUmY4vnN0g@mail.gmail.com>
 <87a5fd5yj7.fsf@prevas.dk>
In-Reply-To: <87a5fd5yj7.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:31 -0600
Message-ID: <CAFLszTjD5icXDS1G_ng7mjwZmcuddjiutr2x83H3GpT9akLyZg@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: fix circular rx buffer edge case
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Rasmus,

On Wed, 9 Oct 2024 at 05:03, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Simon Glass <sjg@chromium.org> writes:
>
> > On Thu, 3 Oct 2024 at 08:10, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >>  drivers/serial/serial-uclass.c | 10 ++++++----
> >>  include/serial.h               |  4 ++--
> >>  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Perhaps we should use membuff, like in other cases, since it has some tests?
>
> I didn't know about that till just now. But no, it seems to suffer from
> the same basic defect of losing one slot, and while it may handle it
> correctly, I don't like to introduce more uses of that model, and
> open-coding the single putc/getc that we need here is really not that
> hard.

I will send a series which adds the 'full' flag in as an option. When
I originally sent membuff I didn't include it.

>
> Also, which tests? I don't see membuff mentioned anywhere under test/,
> but perhaps it's implicitly through the console recording testing?

Ooop, no tests. Will include with the series.

>
> I just had a quick peek in the implementation, and membuff_makecontig()
> seems to be buggy: the second memcpy() must also be a memmove() (suppose
> size==32, head==30, tail==10; then the memcpy() does a 10-byte
> overlap...). It has no users and never has had, so it doesn't matter
> too much.

Nor does it have any tests, even with my series, unfortunately. Let's
see if anyone finds a use for it. Or if you are keen you could add
some.

Anyway:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon
