Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D4CD6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 22:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0466988F3C;
	Tue, 19 Nov 2024 23:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMGG0Upo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE2988FDE; Tue, 19 Nov 2024 23:29:57 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA05D88BFC
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e382661fb79so1275198276.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055394; x=1732660194; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wxv2N9EII7ddmkWuSU1XG6l+bs/lFEDhELsNC4L6yLU=;
 b=NMGG0UpoC+vvhxQcV1qYFIwY6bX31R0BwZmM/Q2BwocVTNq1h4XhbCh1B0mu6f+jkC
 9RR1aA+G8pwZ/QuzuI2D0r3t/QaBBk5gBHPWoYQ5qFHKbJszT6REsSbBlRyTsiD09MTW
 wE+YE4eqG3XF4wMypUFF+trRXETVRTMVWeiYzEB1NBuYZ5QGTPJc//LtjY/AHtiwh35k
 TPeP1BVYZFo+rAIUp23P9so4eMf1yGU0orOFpXx6iqTaE2oFPXsevyBMHMBSwWLBy4+/
 +RO009bbCFd4yydJHzU79tC1mVhXnfsQei+RyD++Z+IemF+ATMbWi7unnHKDxgUsuBtT
 PaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055394; x=1732660194;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxv2N9EII7ddmkWuSU1XG6l+bs/lFEDhELsNC4L6yLU=;
 b=gxeGpH14vj2gCa4Qbu0FuaEp0BI6lh5NfSu9zE1OOlazWB1DOQnOF6GBDUGX5bWUPP
 L6blLQBy7SWv6zMFQkpTdKraNuvet0YFTkOOohXMkxM2FRy2u6NGAGU7ZslTLNy2xK0/
 jmZcGg2dtQ6CNSppqUhblqnNGslC8ouJK9//bbEFKOck9FtBvGTGV27ZkdxiPVia6i8x
 C5DI3PAbl13dD/tvMIOAbIGNgOJ0uX8wk/cbL6cUHEStZCN/1N6O1X3NfrYFXGImiPkj
 FNb2QqTOzQNrcFVvS+Zz2R25LAcCkLNZY5464dDJHrnYB7b3jz9Gib2mxQFROJDhbKuj
 Jlog==
X-Gm-Message-State: AOJu0YxfRVHyAkpfHNihOs/9i0zi3wikryQldEFgJr/K0WneI7RYJGZV
 4kVLFJLxHy4ypbC3Xcwf8R2yJ3kfsX5jpMx5g2b+up1tjZq0VmVWccBs9Ke083iQ1EOir+v8uh5
 FCAEroIoBxDeazpsvscwMByNHHkKb/gjdu3A=
X-Google-Smtp-Source: AGHT+IFRnu1pn4McaNDkH9+swnoMWJ/smTGMxXTeWu0hkiHIjE0EQ3HIx8h+WvrZX2ok/tYHUizGEMzAVqWq5coVI6E=
X-Received: by 2002:a05:6902:154b:b0:e38:7bc6:6d28 with SMTP id
 3f1490d57ef6-e38cb5f77d7mr459778276.42.1732055394567; Tue, 19 Nov 2024
 14:29:54 -0800 (PST)
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Wed, 20 Nov 2024 11:29:43 +1300
Message-ID: <CAFOYHZCwXSChH_rH251cUp-bgwai+e8xrOuqxepX9Dur2wGTJg@mail.gmail.com>
Subject: Odd error with cn9130, asix88179 and xhci
To: u-boot <u-boot@lists.denx.de>
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

Hi U-Boot,

We've hit a weird problem at $dayjob with a board using the Marvell
CN9130 SoC and using the asix88179 USB-Eth adapter.

The problem is after enabling and unrelated feature in u-boot the
asix88179 fails to receive data (I can confirm that the link partner
does see packets in the transmit direction)

=> version
U-Boot 2022.01 (Nov 08 2024 - 09:45:44 +0000)
=> usb start
starting USB...
Bus usb3@500000: Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb3@500000 for devices... 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
=> ping ${serverip}
Waiting for Ethernet connection... unable to connect.
Reset Ethernet Device
Waiting for Ethernet connection... done.
Using ax88179_eth device
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5
Rx: failed to receive: -5

Abort
ping failed; host 10.37.233.65 is not alive
=> <INTERRUPT>

Debugging a little we can see that the -EIO is actually because
xhci_bulk_tx() hits a timeout from xhci_wait_for_event().

We think this is triggered by the u-boot image size crossing some
boundary (the problem seems to start when .bss_end crosses
0x00000000000f0000) although I've so far been unable to find
specifically why that might be. As far as I can tell u-boot is being
built relocatably and nothing is overlapping. I also considered that
ATF might be preventing access to something but so far I see no
evidence of this.

If I turn off some features to reduce the build size the problem goes
away. That is actually how we've avoided the immediate issue, although
that means the problem will likely come back and an inopportune time.

Does anyone have any ideas as to what the true root cause might be?
I'm a bit stumped.

Thanks,
Chris
