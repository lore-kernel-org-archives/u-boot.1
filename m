Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A32D43341
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 19:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E808367F;
	Thu, 11 Dec 2025 20:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+qUQD0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4DC836D1; Thu, 11 Dec 2025 20:51:18 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CCE83655
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 20:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c78d30649aso337691a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765482675; x=1766087475; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=srrWYZL5xeniRJLQok80J4BjJa0Oup0wmzL2I4pFqJk=;
 b=W+qUQD0ht38DVfbUuP3Y1U5pk39ZHnE96mr2Vsa7bV75ShbnxtXqRQdEtDJav3RXqO
 JCPGbINmhJPpGMLg9HiTwuooVAw5SNjb1Fd8MgymbddeUYbPuKcuXBbvTzBfTiagRaD9
 AprmOS1on12edof/M4aiVUuSOtURm7Z7lj3IFSN9NtJeffM4qfW0b+1VsqKy3jKnPu5v
 O6G3GdnU0/NSd5JXk5pgyMr7TE/7htIZIxzQaSoHSOeQy3GE5JYkzd488QpMU4cOcSlr
 0a4hhVtiFlOsCoU81yQKn8eeLFWdT5kZyBwZAjz7nQXHeUCA9k+x43ZuxsHGgdIC3keo
 SCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765482675; x=1766087475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srrWYZL5xeniRJLQok80J4BjJa0Oup0wmzL2I4pFqJk=;
 b=RuqA2ftGQg5alUwFZnm5jPdTxHW+GUjLB+7qDKNg61cW8aT/1hIASyBSc/3OdGAVW2
 mBV5kI6AyV2IAJH92fqrSx5chzXH1+ScUlBghGhciEt6UXNWBHs6x5nw5rQJHC0mAr41
 A+91J+JZYi+hArnqUHJl0Ulxrm5tlHnktoDy/6WjiH0S1odzG4c8q0DWePXZDUlqnxj0
 8ZPpjCozF+WJcBzfs/WaSVUlRW+LPvwpmabKNAhu9lyiW6+dCd08m9Zh1hfa64xv23E0
 tQR0R1mPnuotq0kboK/3dLWjJpjt+5mTwQZ+sj6Whf/I+uPUpMKt8GAEnDpgAjfrhMHh
 R4/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdUuB7HqhvrbW+pz7tyFD4BRlClXgCYTO273CnsKsJIn6cqY05j9HUMLSJifQFgH/Jn/wY+V4=@lists.denx.de
X-Gm-Message-State: AOJu0YziI2kJfKkmTT6ffYvSwKPky/uQBksLk8GNQZN07kArl2fLFP0Z
 jDyVyo+jCpaPNFRW+ZBFPBNuJMCMb0PxsfHh11kUNdHptUnb1nhPxxieoINAUWT1lZ0idnZPDBV
 XUSRlKFmqHUiTt/WCABEXmUi/FFcErGo=
X-Gm-Gg: AY/fxX6hK3nxqjd9w7efRdHd+FF0lNOe3s9ltS0LldDFrLGaoAWkaPcR7N11YnMeh6w
 jCg7iJpnv729kphf4jpMfIAbD0Hxa5tpvqdtlr9h5lGifx2CRmxCiqOa7JhHcfp9l9Liu7pi5B1
 p6JMWWfo/GrkKb+YrkOyummRz2zgRfbJJZY1GMEu4366R76QpxH2aKmT3yC0kp9MJC1C4G+PKUN
 5kJ5fsFmagW6zYGkx3qgwIwLUZetVnewNfQc0fKWdDZE5WGcFMpT9pRla3ndM3vtGBlFkg=
X-Google-Smtp-Source: AGHT+IGu0ekX4a4zBQV8o+UX1XTVuiTdDfiCQ62l302FljWOQtixzSOB9Xa0C3aan4UvpdvKBRCVdA4Nz79Ni3zmMAE=
X-Received: by 2002:a05:6830:2646:b0:7b4:f1e6:4957 with SMTP id
 46e09a7af769-7cacec2d7d0mr4190124a34.20.1765482675103; Thu, 11 Dec 2025
 11:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
 <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
 <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
 <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
In-Reply-To: <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 12 Dec 2025 03:51:03 +0800
X-Gm-Features: AQt7F2p4ce7vqu9WLEeij1bpHru5fYYdIg2lro3POL8n4LTLTTSKvsqu3EbTLaI
Message-ID: <CAN7C2SDj5yL4=tpEiG2ftjFQvrWvHSavXkz2JMJQGEgN_i4Dtw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
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

> > Issue 1:
> > sequencer.c if turned on debug by including this at the very top.
> > "#define LOG_DEBUG" and "#define DLEVEL 1 or 2"
> > If will stall somehow on any brand of board my side current had.
>
> I also encountered this, but it was solved by disable the watchdog, by
> toggling L4WD0 reset. After doing this, there is no problem with using
> DLEVEL 2. I even took it a step further and logged every single write
> to the DDR control registers.

Hi Ralph,

Thanks again. Quick test on your proposed method.

diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..904f9bc6d03 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -589,6 +589,9 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
        }
        reset_deassert_bulk(&resets);

+       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+
        if (sdram_mmr_init_full(sdr_ctrl, 0xffffffff) != 0) {
                puts("SDRAM init failed.\n");
                goto failed;

Works and all debug_log and max level=2.

However the same behavior can be repeated when CYCLIC / WDT off.
It will fail and once CYCLIC is turned on it will pass again.

If HW level does not support the 533.333M timing from the beginning
it is a 100% fail and no possible turning back to work.
AKA you won't be able to do any timing shift to make it work.
The DDR3 chip dies are unchanged and twin dies can always run 533.333
and never stall on the calibration phase w/ CYCLIC.

So simply speaking the sequence.c somehow is so touchy on timing.
I do test the most common timing bin of the DDR3 die.
I guess there is no easy fix on this issue unless Altera do change a bit the
sequence.c syntax.

Brian
