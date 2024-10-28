Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FD7D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD3E7890D1;
	Mon, 28 Oct 2024 18:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C7XeH5KY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B154F890F6; Mon, 28 Oct 2024 18:01:24 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89234890D1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so680844766b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134882; x=1730739682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1nSVtiJ4Yd3cnnfJT6orSkFvGhVHZmgUpztV/6wOHk4=;
 b=C7XeH5KYID/ANDlUHq3FomtEQornaV2LSxsPs8HY+IZrRFSZf/+tg+yLryOTQ8eJrH
 eOFsLOWR40b1wsaTDJbVos2+4ymjKMcc0bFF/sYfS7B7gSlB9cmyo55QuxlaFlf8xdch
 4byyjaj0ul5Y+JXpTfIcH7oQK+xiDvlUeWj70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134882; x=1730739682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1nSVtiJ4Yd3cnnfJT6orSkFvGhVHZmgUpztV/6wOHk4=;
 b=vGG80asU6gQKjqYO+2qfMtGy7Fn/BVvmkNLZcgu1KJNHIttaeLXk1FpT7c830teO8w
 gO+vIMmEr+MemagB/Gy2PXP81ye0VecZtUgbY3rl3gaeHfYcgx+O5Gq7qzltLEYqS7lx
 3KFjuWhHjrqh1nntez6VqfB5AIJonU9DtZNjGWzlq4uilZghFhKHnnB+O1d8OYoVup+o
 e/m/DNlyAbd7bJ4LRbLvw7pI8pcY+KaEPYP6qAi8ZjNmo6XTBdEoevSC7KI/NW8bZGAF
 vEQM+EaEVi2Iuw9s5AfLZDKKWBCj2ngbqJ/qJAHU26cUcbuBn189HCGU4BMh6PpNp+Hy
 EqWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqa/7yS7LbiWkmRCuer35hvnxJiPeHtE309UuIcJqyvqRd3iMJPkBOpCtjFUkQvW2jOdSE5xY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg2knOwuguwxUfJYDX/aRc5m+umFqVBE0sCgzaQfIrwOjw1jAW
 ejl4ihLDQgLrmJuCt1pTgPPXuqQhzPUKI99W3CFKif3z03LfW50ckAvbnELwUQy8tqUUVITufwB
 PM0Bb6AEtgUi0r5Fv3w2MApX34mnwULWRKwf5
X-Google-Smtp-Source: AGHT+IEmYg2D1mGglnnr4UaHOn3pErc5LL7QVoCoCwlkzczAzZlnHCaLZdy3EYlAA9aTgYuQgonmPM2jeZYBw8rfQVw=
X-Received: by 2002:a17:906:6a02:b0:a9a:c691:dcb7 with SMTP id
 a640c23a62f3a-a9de5d784c2mr825774566b.30.1730134881983; Mon, 28 Oct 2024
 10:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
 <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
 <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
 <d00691ed-815e-4db9-b5d7-b09c32ead593@mailbox.org>
 <6db33dd28da63dabc198788f28bfa00425d7f62e.camel@mediatek.com>
In-Reply-To: <6db33dd28da63dabc198788f28bfa00425d7f62e.camel@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:01:06 +0100
Message-ID: <CAFLszTgb2KZfX1GnbMee9fVani9aOt8ex_AqoszHTjiq_96Yvw@mail.gmail.com>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Weijie,

On Mon, 28 Oct 2024 at 03:58, Weijie Gao <weijie.gao@mediatek.com> wrote:
>
> On Mon, 2024-10-28 at 03:33 +0100, Marek Vasut wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > On 10/28/24 1:25 AM, Weijie Gao wrote:
> > > Hi Daniel,
> > >
> > > On Sat, 2024-10-26 at 20:23 +0100, Daniel Golle wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >
> > > >
> > > > Hi!
> > > >
> > > > On Mon, Oct 21, 2024 at 08:56:42AM +0800, Weijie Gao wrote:
> > > > > It's observed that the bootmenu on a serial console sometimes
> > > > > incorrectly quitted with superfluous characters filled to
> > > > > command
> > > > > line input:
> > > > >
> > > > > >   *** U-Boot Boot Menu ***
> > > > > >
> > > > > >       1. Startup system (Default)
> > > > > >       2. Upgrade firmware
> > > > > >       3. Upgrade ATF BL2
> > > > > >       4. Upgrade ATF FIP
> > > > > >       5. Load image
> > > > > >       0. U-Boot console
> > > > > >
> > > > > >
> > > > > >   Press UP/DOWN to move, ENTER to select, ESC to quit
> > > > > > MT7988> [B
> > > > >
> > > > > Analysis shows it was caused by the wrong logic of
> > > > > bootmenu_loop:
> > > > >
> > > > > At first the bootmenu_loop received the first ESC char
> > > > > correctly.
> > > > >
> > > > > However, during the second call to bootmenu_loop, there's no
> > > > > data
> > > > > in the UART Rx FIFO. Due to the low baudrate, the second char
> > > > > of
> > > > > the down array key sequence hasn't be fully received.
> > > > >
> > > > > But bootmenu_loop just did a mdelay(10), and then treated it as
> > > > > a
> > > > > single ESC key press event. It didn't even try tstc() again
> > > > > after
> > > > > the 10ms timeout.
> > > > >
> > > > > This patch fixes this issue by letting bootmenu_loop check
> > > > > tstc()
> > > > > twice.
> > > >
> > > > The patch helps to fix the problem when dealing with single key
> > > > presses. However, apparently this is not enough to fix the issue
> > > > in
> > > > all situations. I still manage to drop into U-Boot console with
> > > > an
> > > > extra '[A' when simply holding down the arrow-up key for a while.
> > > >
> > >
> > > Holding down the arrow-up key for a while can cause the PC to send
> > > large amounts of data to the UART Rx FIFO. Since filogic UARTs
> > > usually
> > > have only 32 bytes FIFO, it's very easy to cause Rx FIFO overflow,
> > > and then you'll still be dropped into U-Boot console due to data
> > > loss.
> > > I've already confirmed this during solving this issue and this can
> > > only
> > > be solved by increasing the baudrate.
> >
> > Does CONFIG_SERIAL_RX_BUFFER help with those overflows ?
>
> CONFIG_SERIAL_RX_BUFFER can't fully elimate the overflow. I can still
> reproduce this issue by holding down the arrow-up key for more than
> 15 seconds.

Is this due to serial, or the delays caused by drawing to the display?

If the serial buffer is always full, one option might be to detect this
(tstc() returning non-zero 10 times in a row) and discard all output until
a key is not pressed for 200ms or so.

Regards,
Simon
