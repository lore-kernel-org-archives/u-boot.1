Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC8D10F2B
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 19:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587BE893A1;
	Sun, 17 Nov 2024 20:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOzBYPOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BC3893A1; Sun, 17 Nov 2024 20:45:27 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F896893BD
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 20:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so3484615a12.2
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731872725; x=1732477525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kAL9zyHxl3oiRLCkXlQVyBeilk0FNEdmLEMOuIOHC60=;
 b=oOzBYPODMtWwlE8ku8+zHE2/YT8SYbyBQZtudBgFrerEGE5ZyyVaAgHztVLqUmf14t
 xuVTc7QCkdB+MVCYuqmee5LuHuDpKv4xOSW5JL++NGPPnTt112jt5gwm7gXIIdup0FDJ
 JKzsgBbIbgIl3weKHPkfZ1TnVYstqDzDz0KcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731872725; x=1732477525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAL9zyHxl3oiRLCkXlQVyBeilk0FNEdmLEMOuIOHC60=;
 b=hDur6Q5gGZtG7021wDcFN31kdPIeDN98nqEyFcxqMUp4B9y7Q9/WSwI6Qd5piHl9cw
 mSMj5Ouj/NkrOMwsYXZgeEYzJDHM0t6j/GK8r+TdTDRHqe6hSLwumejdbzz6zpSzBSgb
 H7se5jSuaB+hZmatUZFvy0JV2JDha2KrmwxKcLbSKlwzs9GNRFVM3xEI0BUiKC433LS8
 Fbhyiv40wJ1mhUNoIUdKxBFKnzUWGuKnutsruLyMpSS/Zf0dPuTGabxpVQhiXfM5zJA0
 UGvHDNQAEYjikAm1zYkerY320leG9KKg0EEbC87a7YgRqdGnevS0YhtUpMZnPKfst1U8
 thvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwrLKnx93JD45rMUoTXQTcDx3q6FtKQ8yQqy7IJQpYnFWi3LsR1Knj536ym2uytMZkElu69TM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2RcEwLCoap4kXQ3uqEkGqlpDY2XBTVHzEDW+01yF7DpL/b2pQ
 ZtU0YETtYBPSXY+2ewlc2MvWSFsVwftIfz1lwoHMoZ3bFgG3duKUGCWFlsz3G1nTnI91CbVVqbC
 AYUQovIcarlxKLKvxD/pqVMVe0l5rchp5x49G
X-Google-Smtp-Source: AGHT+IHACkz4pnQOsjw3W8TioKZiTYvshxvWKViTPNKFSRHqQpZtpW1uVB7pNuXFpy2B2i1Q62wSg57c0BEjBEKh6S8=
X-Received: by 2002:a17:907:7f88:b0:a9e:ec6c:9c4f with SMTP id
 a640c23a62f3a-aa483412827mr943138566b.21.1731872724729; Sun, 17 Nov 2024
 11:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
 <20241116003153.GC3600562@bill-the-cat>
 <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
 <20241116162929.GD3600562@bill-the-cat>
In-Reply-To: <20241116162929.GD3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 Nov 2024 12:45:12 -0700
Message-ID: <CAFLszTh+nm8scykJfRfpiXeeZDWtVBGf60KoFxX2_eRdoXQfcQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Sat, 16 Nov 2024 at 09:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 16, 2024 at 05:49:06PM +0300, Mikhail Kshevetskiy wrote:
> >
> > On 16.11.2024 03:31, Tom Rini wrote:
> > > On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:
> > >
> > >> Legacy TCP stack is bad. Here are some of the known issues:
> > >>  * tcp packet from other connection can break a current one
> > >>  * tcp send sequence always starts from zero
> > >>  * bad tcp options processing
> > >>  * strange assumptions on packet size for selective acknowledge
> > >>  * tcp interface assumes one of the two scenarios:
> > >>      - data downloading from remote host to a board
> > >>      - request-response exchange with a small packets
> > >>    so it's not possible to upload large amount of data from the
> > >>    board to remote host.
> > >>  * wget test generate bad tcp stream, test should fail but it passes instead
> > >>
> > >> This series of patches fixes all of the above issues.
> > > Can you please work with CI to get everything there to pass? Thanks. See
> > > https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
> > > help on starting that.
> > >
> > Hello Tom,
> > Could you look to https://github.com/u-boot/u-boot/pull/692 ?
> > It fails 2 times on ut_lib_test_udelay, but this seems unrelated to my
> > changes.
>
> Yes, unfortunately Simon's recent moving of the tests caused that one to
> fail more frequently now. I've hit re-run, if that's not something
> available to you, just now.

Perhaps we should skip that test (return -EAGAIN) for sandbox?

Regards,
Simon
