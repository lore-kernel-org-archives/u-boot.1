Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CF8C83F05
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4769086479;
	Sat, 26 Aug 2023 01:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="5e/tZNGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6B38647A; Sat, 26 Aug 2023 01:45:19 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5C08643B
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so1961058a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693007115; x=1693611915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJyJwv80CG530+eo6Bhjt8wOY21FggYD2uSEJ7rQNGo=;
 b=5e/tZNGg7B1M+dXjqPxi26gg0HH+Z4p7K2P9wbrfnHOLlDNqkG5TjsKol96Se4cuP2
 8V0w3jTI9IGyQSztcOxEQEcM7iUEP6+l7oNOKmAcPZn/2sH7OOM9tWasTfyJjfczgjkV
 x/rLRLB0by980dgTlzhZfzNeNlg+5QY9ExgVAKVwU4D71rDENCl/sohIWKFbzNXKYx7m
 fQLTgtoEgd9T6vRQDQ2oKnjmBg36DWOs+EwDTMLuLLV2DXu99zW5VSYFiTJ27dGu411P
 WkaHrJBOpMrzPdn2pwS8FVfp0lonnNfZ5loElfYb6augD45+3+/ORgmOPly0BXwe8uCD
 hjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007115; x=1693611915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJyJwv80CG530+eo6Bhjt8wOY21FggYD2uSEJ7rQNGo=;
 b=cPmQQquMxH2OOZEn71Vc+ZYSlFba2Mf1f+wfvUVoFkRJxpP5MTqF67O+pv6K6LvxdN
 vrhh9u1QkF3XhAKKTy01W6whzIZvdGmZ+AuQ7AA2IeyZQZiJ4YKgOoUVh1oqD4NXvU2e
 WP4aW+hVRQjZHaWsKySyyldMQ/SjQ28OGwcx4pzxXoY9KFocUp83UO1r0/qv197e/mcE
 7aZwf6IRxynmkK8RtJtbUQGybxb4h5ocfvglhq1E/GHhnOoyN19nEVjKSquqvbzR2sIe
 0QlPB9HBDJlZkONAIhD2W0QYbPuSLrjN3PlwT2slVev4Tvb+volpC4pNTBRmcmqtKQS5
 nTww==
X-Gm-Message-State: AOJu0YzwWqwpEz+twQVsm4+1m0ytzQKnaniORTdXDMmtdh4N1kTZJWt5
 vmlrSTOBzMQA3D/JnpvIKqiKnwrhha2ix0kG7egfww==
X-Google-Smtp-Source: AGHT+IHfKxr3Rd4mZEpiVjjNXOKRbKp1gRfEq447jLVmWeM5cENg2SsWJgDiskkrtTn91R5c4F83d46Lh76Dp2sHd9A=
X-Received: by 2002:aa7:cb42:0:b0:51f:f1a4:edc6 with SMTP id
 w2-20020aa7cb42000000b0051ff1a4edc6mr15059111edt.37.1693007115439; Fri, 25
 Aug 2023 16:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
 <20230825012224.ydk4332yb4qodrdb@unfazed>
 <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
 <20230825015931.fkx7jx4sqxdr7cqe@directly>
In-Reply-To: <20230825015931.fkx7jx4sqxdr7cqe@directly>
From: Simon Glass <sjg@google.com>
Date: Fri, 25 Aug 2023 17:45:03 -0600
Message-ID: <CAPnjgZ1uzjhTPNhfE1NR2Boq-M_kABTrA=19xy0s9nSsXWWU0A@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Nishanth,

On Thu, 24 Aug 2023 at 19:59, Nishanth Menon <nm@ti.com> wrote:
>
> On 19:31-20230824, Simon Glass wrote:
> > > >
> > > > Also I tried the mmc instructions and managed to brick the board. Is
> > > Hmm.. This is just documenting what Robert has in his scripts[1]
> > >
> > > > there a recovery procedure?
> > >
> > > Oopsie.. Sorry you had to hit that..
> > >
> > > >
> > > > I suppose I should have tries it on an SD card first. I thought that
> > > > was what I was doing, but I didn't know about the internal mmc...
> > >
> > > Recovery currently involves booting off sd and flashing the emmc up :(
> > > unfortunately.. USB DFU etc are still work in progress.
> >
> > Hmm so does that mean I need an ARM machine do to the SD
> > boot-partition magic, or can I use a USB reader on an x86 box
>
> I just have x86box with SDcard reader - and I use Balena etcher app
> image to keep my head straight.
>
> >
> > >
> > > A ready to go image such as [2] emmc flasher image might help speed
> > > things up.
> > >
> > > [1] https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-u-boot-beagleplay-mainline/suite/bookworm/debian/install-emmc.sh
> > > [2] https://rcn-ee.net/rootfs/debian-arm64-12-bookworm-xfce-v5.10-ti/2023-08-24/
>
> I realized I just pointed you to Robert's in-work space.. rather not do
> that. Sorry.
>
> > > emmc flasher image
> >
> > OK thanks. I am not sure how to use those yet, but will make a note.
>
> Just https://etcher.balena.io/ and flash an SD card with the official
> image here: https://www.beagleboard.org/distros/beagleplay-debian-11-flasher
>
> https://files.beagle.cc/file/beagleboard-public-2021/images/am625x-emmc-flasher-debian-11.6-xfce-arm64-2023-02-04-10gb.img.xz

OK I tried that on an SD card, but it is still bricked.

Regards,
Simon
