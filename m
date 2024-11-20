Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD189D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F82188FAA;
	Wed, 20 Nov 2024 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l1JBf0IX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CAD892DE; Wed, 20 Nov 2024 16:34:21 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5735D87042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso1787317a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116857; x=1732721657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SyFzsT47oyJCIOSuIPJhpXuPLvHCPMwMApOGmqCwZgw=;
 b=l1JBf0IXB6k/gkmRUxqlsO0XXrRFp6rI6Jkci2hvY2rfib8811J5fw1MQclUM2Vj75
 GoNS3wiJLiQFh8k6revNJhd5xwqLjP3WAsq5IqVKnczdtrLPlBGSIOUdj4iBSeo9OsbO
 TXp1opCJ1nicJikNIdu9yvID84o8VgqI5ojxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116857; x=1732721657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SyFzsT47oyJCIOSuIPJhpXuPLvHCPMwMApOGmqCwZgw=;
 b=GUvbxCNSGnnVJbgSg2h4pP53yePMvNHdPw51Ykw2Kzzrl2AOV3c51xJgEYsx5eDala
 63YyQfHtFhs6fvVktEUdlP8ke/XM0qrQSfTEVirknLfIfqNbpRQi79U0xb8SkgOnCc+3
 Q5RZfOfqHLKwK66bFMzO+Vv/3JvDmuGAqd/5dElieqqLV1u940XFJqIswp56oWd4Qtnc
 7Z5p2NJQ43kteqEuk21OpmZ+Awjncp04vb3CIHoJPEtBtFXXZF/b4J9c6CtGT5XHHbfB
 OWg1t8LUhfcoCcvXti8ZGIR+W/TxvvIeyvzB8fIg0rgtv7tuog9Te5YgDh2b1niLt878
 huYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpOcFc+IWTFxBpf2aN/h0Tz+bdH5TcJWgBETHEQXkLTEzbqrpdnLImrGK/e8M/WfAlVKMGJU=@lists.denx.de
X-Gm-Message-State: AOJu0YyhRf04VtSr8V7jCHyyaXa/eEU7amfm9LqyST10tpHq1CZOhkj6
 2+2BecMyhmR22TOQqrM4jwkwz/XCjQwr/2n8YFTCNSu+EFeXsjEsElHGtMv1o3zCwMnv2IzqTz8
 PlKFJjQCx/m+6CCDdBqsIrSLFNvVWiLr0afyr
X-Google-Smtp-Source: AGHT+IFRxHD7VbgUKZlgYEGba8LVyEQJUd/XrtwWNoMZ4HpIeEQgb+/eUUT599EYWN9rxMihcgxRi6ZfncX6s0r8zOs=
X-Received: by 2002:a05:6a21:33a2:b0:1d9:61:e783 with SMTP id
 adf61e73a8af0-1ddafd579f8mr4649081637.36.1732116856865; Wed, 20 Nov 2024
 07:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
 <20241116003153.GC3600562@bill-the-cat>
 <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
 <20241116162929.GD3600562@bill-the-cat>
 <CAFLszTh+nm8scykJfRfpiXeeZDWtVBGf60KoFxX2_eRdoXQfcQ@mail.gmail.com>
 <20241117195234.GL3600562@bill-the-cat>
In-Reply-To: <20241117195234.GL3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:38 -0700
Message-ID: <CAFLszTjiAs1AHZaD2i_iy3i4kstOCnM__idxRS2oqnHey95KXw@mail.gmail.com>
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

On Sun, 17 Nov 2024 at 12:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 17, 2024 at 12:45:12PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 16 Nov 2024 at 09:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Nov 16, 2024 at 05:49:06PM +0300, Mikhail Kshevetskiy wrote:
> > > >
> > > > On 16.11.2024 03:31, Tom Rini wrote:
> > > > > On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:
> > > > >
> > > > >> Legacy TCP stack is bad. Here are some of the known issues:
> > > > >>  * tcp packet from other connection can break a current one
> > > > >>  * tcp send sequence always starts from zero
> > > > >>  * bad tcp options processing
> > > > >>  * strange assumptions on packet size for selective acknowledge
> > > > >>  * tcp interface assumes one of the two scenarios:
> > > > >>      - data downloading from remote host to a board
> > > > >>      - request-response exchange with a small packets
> > > > >>    so it's not possible to upload large amount of data from the
> > > > >>    board to remote host.
> > > > >>  * wget test generate bad tcp stream, test should fail but it passes instead
> > > > >>
> > > > >> This series of patches fixes all of the above issues.
> > > > > Can you please work with CI to get everything there to pass? Thanks. See
> > > > > https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
> > > > > help on starting that.
> > > > >
> > > > Hello Tom,
> > > > Could you look to https://github.com/u-boot/u-boot/pull/692 ?
> > > > It fails 2 times on ut_lib_test_udelay, but this seems unrelated to my
> > > > changes.
> > >
> > > Yes, unfortunately Simon's recent moving of the tests caused that one to
> > > fail more frequently now. I've hit re-run, if that's not something
> > > available to you, just now.
> >
> > Perhaps we should skip that test (return -EAGAIN) for sandbox?
>
> It would be good to understand why:
> -       if (abs(error) > 100)
> -               return -EINVAL;
> +       ut_assert(abs(error) <= 100);
>
> is not actually functionally equivalent, seemingly.

-EINVAL is consider an error

-EAGAIN is considered a request to skip the test

Regards,
Simon
