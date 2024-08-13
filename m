Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1EAC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC1788747;
	Tue, 13 Aug 2024 14:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DMkisyDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E97888747; Tue, 13 Aug 2024 14:17:09 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7896388842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b7acf213a3so28965626d6.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551425; x=1724156225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6+g7Q0fkcd9lJlW3+fZAgovN2D6Os81F9DMEq3JUiaM=;
 b=DMkisyDnSBiZn2yy0jkHPu8d4svvj7Rj7G3K4xdgue/EToC14ClE+nlK6NsTRygO+Q
 bWMQ4zUQqphsPkqdaGRYVcL6ST5FdQiQLyLxpVZi0GpZXAq7VVp6HgkhCfoH6FsguLgr
 SljGwQZjcmiyaqkpCyE8coWmuV8UmrIr/KLcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551425; x=1724156225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6+g7Q0fkcd9lJlW3+fZAgovN2D6Os81F9DMEq3JUiaM=;
 b=gps8f2ZhCCFKp1bxujkX2R9/n+nDIbSR4Fcjk/fAsuW9lndGDjxTgBvQUd0nKSYU99
 ztsI3z/w1MQPJl8oHJRySH3ySYjvj/OIHhvngzoXBfB52Gc6bEPhrv17rE1nNBfjSGWH
 kDJ3WcPBupXDNy6fwYVTUUe280ea2ocWia1GX0M1UaQbqZItjoOhx8UalVfn0DC4tQlg
 THnafe5hyL1Agpt/l4s4X44ACDBpLoaEAyCJMG1FSdTBaSE9FWwc1eHgq0utnyvglpux
 CWbMfd6B3UWmM+YcDduQJJurHWRkPEuUhOaTIxeis+IPilQqcUie4c3WU7qFwEtNAc5j
 G3eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaBH+nx82VFDkNsHTmZ0xqzZLJD0iGTP4fRK2vgolYqUXcZPWwFsFiKIlabRnkUXjoWyz1gfCrPpq8DbG8yJ2Rpl2GrA==
X-Gm-Message-State: AOJu0YwXRo4lvJGDT/eKA9xzzQUIPkNRe8nI5UrwmSJmTrxklY3x8Zra
 2UHE9IND8VbE/p/1CZyJO+yxfqgGXzZjyA2Chi54G/I9iQmmzq3vzyevcIQBAvV8quaLqw+ReaM
 y4lDE0pqTGw+SlSAH1l0EW2g3Cm2oqhguq3Tm
X-Google-Smtp-Source: AGHT+IHUCCIj4iK154FXL1IhXY7wdZY0zU7yNUU6WTYiX73L7Dz1xM4wvpyeKZivZA43KFnftXAQsH8MeQ1wW7lctnU=
X-Received: by 2002:a05:6214:5d92:b0:6b5:8e2c:e715 with SMTP id
 6a1803df08f44-6bf4f7fbdacmr29671436d6.20.1723551425251; Tue, 13 Aug 2024
 05:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
 <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
 <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
 <20240812184615.GI1626301@bill-the-cat>
In-Reply-To: <20240812184615.GI1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:16:54 -0600
Message-ID: <CAFLszThEbk2Jr8OZ6Hj21wPSnJjgJhaDe037RqwHvwt1KjB3_A@mail.gmail.com>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
To: Tom Rini <trini@konsulko.com>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

Hi Tom,

On Mon, 12 Aug 2024 at 12:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Aug 11, 2024 at 08:50:18AM -0600, Simon Glass wrote:
> > +Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> >
> > Hi Yasuharu,
> >
> > On Sat, 10 Aug 2024 at 20:48, Yasuharu Shibata
> > <yasuharu.shibata@gmail.com> wrote:
> > >
> > > Dear Simon,
> > >
> > > Could you inform me how the wget test was broken?
> > > As I explained in the commit log, I fixed the bug in specific conditions.
> > > Without the details of how the break happened,
> > > it is difficult to find a proper patch.
> > >
> > > Best regards,
> > > Yasuharu Shibata
> >
> > Yes, I should have mentioned that. It is test/cmd/wget.c - see also [1].
> >
> > This is a good run:
> > Test: net_test_wget: wget.c
> > HTTP/1.1 200 OK
> > Packets received 5, Transfer Successful
> > Bytes transferred = 32 (20 hex)
> > md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57
> > Failures: 0
> >
> > With your patch it hangs:
> >
> > Test: net_test_wget: wget.c
> > HTTP/1.1 200 OKT
>
> Can you please figure out what's going on with the sandbox test then?
> The change in question fixes wget support on real hardware, and also the
> other wget tests (as part of the lwIP series) work fine as well. This
> seems like something specific to that test.

The sandbox test is pretty simple, but it seems that something is very
odd in the wget code. I'm really not sure what it is supposed to be
doing.

Here is a good run, with both of these reverts:
(1) 1fd9476ec7d Revert "net: wget: Support retransmission a dropped packet"
(2) 3ebd131f7af Revert "net: wget: fix TCP sequence number wrap around issue"


Test: net_test_wget: wget.c
wget: Transfer HTTP Server 1.1.2.2; our IP 192.0.2.1
URL '/index.html'

wget:Load address: 0x20000
Loading: wget: send SYN
wget: Connecting In len=0, Seq=0, Ack=1
wget: Cting, send, len=0
wget: Connected seq=1, len=47
wget: Connected HTTP Header 0000560ee4323456
HTTP/1.1 200 OKwget: Connctd pkt 0000560ee4323456  hlen 27
wget: Connected Len 0
wget: offset 0
wget: Connected Pkt 0000560ee4323456 hlen 27
wget: Transferring, seq=1, ack=2, init_seq=28, len=47
wget: Transferring, seq=48, ack=3, init_seq=28, len=0
wget: offset 20

Packets received 5, Transfer Successful
Bytes transferred = 32 (20 hex)
md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57
Failures: 0

Here is a bad run, with only (1) reverted:

Test: net_test_wget: wget.c
wget: Transfer HTTP Server 1.1.2.2; our IP 192.0.2.1
URL '/index.html'

wget:Load address: 0x20000
Loading: wget: send SYN
wget: Connecting In len=0, Seq=0, Ack=1
wget: Cting, send, len=0
wget: Connected seq=1, len=47
wget: Connected HTTP Header 000055d24b26e456
HTTP/1.1 200 OKwget: Connctd pkt 000055d24b26e456  hlen 27
wget: Connected Len 0
wget: offset 0
wget: Connected Pkt 000055d24b26e456 hlen 27
wget: Transferring, seq=1, ack=2, init_seq=28, len=47
wget: offset ffffffd9

wget error: trying to overwrite reserved memory...
wget: Transfer Fail - wget: store error

wget: Transferring, seq=48, ack=3, init_seq=28, len=0
wget: offset 20

Packets received 5, Transfer Successful
T T

You can see that seq is lower than init_seq so it tries to write to
memory before the buffer. I suppose in real hardware this would
normally be OK, but it isn't in sandbox.

With just (2) reverted I see this:

Test: net_test_wget: wget.c
wget: Transfer HTTP Server 1.1.2.2; our IP 192.0.2.1
URL '/index.html'

wget:Load address: 0x20000
Loading: wget: send SYN
wget: Connecting In len=0, Seq=0, Ack=1
wget: Cting, send, len=0
wget: Connected seq=1, len=47
wget: Connected HTTP Header 000055a5e9a25456
HTTP/1.1 200 OKwget: Connctd pkt 000055a5e9a25456  hlen 27
wget: Connected Len 0
wget: offset 0
wget: Connected Pkt 000055a5e9a25456 hlen 27
wget: Transferring, seq=1, ack=2, init_seq=28, len=47
wget: seq=48 packet was lost
wget: Transferring, seq=48, ack=3, init_seq=28, len=0
wget: offset 20
T T

At least in this case it doesn't write to bad memory, but it still doesn't work.

Regards,
Simon
