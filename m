Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2099FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E5883AA9;
	Mon, 27 Apr 2026 14:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YaF3P0Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41B483BC4; Mon, 27 Apr 2026 14:32:13 +0200 (CEST)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD2783693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so15579776eec.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293129; cv=none;
 d=google.com; s=arc-20240605;
 b=TKlxZ38NA5n421E3kYVYdQnx8Ln+DXk24xrBSBtgm1FPLbciKfbNxo0BqjyRPeCMrQ
 m0iWr6P2Li9YGTgAqWZ+U5x3diTJnmD2eMCnS6magrGZmvnwXZY6FYIWRqRZtVS+FX/g
 TlQSEJzlj0UlbZLFmhLe+xiuaxUrORO1m1iV5wyKj8Xern9F2Znlh1m2pR8YuPZDmrxf
 TBSRfs6ClofRbZOS6okXpLEZXwQD/f8cET9dy+M8ZMkM1olYe2A1Bt6CDcVY0ayvXa3v
 ORhtmC3mSIHzIJtzB1pibHjeHy6hgDBI5B2ZGX+r3ZWMB231n3S5YBDYbMKzWSsaN31t
 7fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O3mD00ste+9cbKSr/gN87aZ5vgPckKLwTQRZov/c9TE=;
 fh=SdPXFo4tABH1pJEbjSKcMTIfHR/GEadu5Aa4PAyc7kc=;
 b=Dx6bF3LRIf30fRRNv00KVBrTzYfO+HW0CMQvPB23+FAQZDmZPzuJ4SCc5P0cQUmjrv
 MlLIjLZTeG4H7RRYc6aQ/HpIsPnmczGPnXu3cH2ZRXEnQ89FJKS0r4WUfeavNWSM0QKX
 8FaAaJLwUkNkTQLqGkIacdE0+NYVggviqZ8THSqfffYWHCDy260J5FnKFGTGtXOl2z6W
 fDvuvQ9rCD6V+Gieo8UvF+pBcg302D09MwQ3DdxsGnZ4e+OXr5jFcZbweUG+cWceCW3L
 oh5Q/h/8j9mb6UpfH/I9BEKJf88OSDTdiRBltEiMx3Joc5beZZaXO7iTtcvdlpJx+LuO
 tdVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777293129; x=1777897929;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3mD00ste+9cbKSr/gN87aZ5vgPckKLwTQRZov/c9TE=;
 b=YaF3P0Eq0Y5vj2zgf1NepCV7iXlc2FO/3GjzTVmJ1YefI60s/fYXgGVdh6lY3SpoIL
 qV86EPWRM796/lZSt+p5AJuZt9hRURN4RwtV+aqNO+gFtkAH97hrN9T1KL9+Re3aNS4t
 5WfljHOLBrIPb4u6Y6xx3o0j7cl44zaSMIijI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777293129; x=1777897929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3mD00ste+9cbKSr/gN87aZ5vgPckKLwTQRZov/c9TE=;
 b=jH0azEoYTSsoDCBix8GFVuo/vxDuR9Myz7WPSxeJkP99KhAQDjjbJ245kh3r+sHkFJ
 7/zVoJjcMZ/AUA9gYFs/8cgxNSxUQ0Ka2GjGtBGU4vzda3w2v87KSJLVel0jA4IZ3vK1
 pS0/EO5HRtNepsmzc+TQzH0rM59aNi5N+CnzZwxHCv1oHTQlShnloaDYzrPGuDh2nf7Y
 yw/G89YBpdgi5ddKjWJ32bS0rcpKBhsVtSs/o7RJxJY2G/uAAfhPr9jDs3Qh+bZwiLJD
 bHqdbGZi+Q5sbC3nkUMnt9Cip9RTip9oGdKkxwjH7RUiDPFCQrWd9yDw9Ep3mJUMstI0
 S6qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sF0rVVVFTRtUTOa9sPRp6VL+EZUvcTnUXTyl2LHnP8cnCu8l3P9xMsmOB9QDULnhunNowuRs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2pn9TQrKnkYElRkEbLen3gXdTbH5oPF+cILFovmdLAOpJCl26
 dB29jv7YIOzkWM0Ily8NX60D2tU6bLwRa7wXPDGGMEgQBOi0ZRtW3HKJPiEs93krpdr+5D+5y3j
 oXYfdt1GRt6VfmBGzxYWZkQZFPmnY4Q9Uzt0ITKNE4w==
X-Gm-Gg: AeBDiesh91xQkioZEOQwYWmAqBhCSxFJrBFcI40mSAzZlht7ATyAZi1mgoGEoVtKwPp
 AfAkkvJup1TxfCMxr4HNhxbU6ChTKOIciBJrZGvT+Rfm+mh/+ac9WYKdiN/CjOyKjM0HWTgJeqr
 qBHlkIbEseCa2iM79dastTxrwWwu5EO+Dj1H883nAeqcGlO7h5aLm9YuyRYE6yhX9kAN3h5wWf8
 xg+TMmOuTuvvspGAaLvuTCSTUD7QpdDw4W9P2N8mQKyOZWBdJ2myS1NlV79jhFp1toH35lPYVAU
 OO/vO6LjBl1llD74pWyKXGcnX3/ImnkqKWE2wSPXD31+wO2//Tt7O3g172FI
X-Received: by 2002:a05:7300:d70c:b0:2c5:ed1b:ca9 with SMTP id
 5a478bee46e88-2e464ea8c15mr25742096eec.1.1777293129411; Mon, 27 Apr 2026
 05:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <fb530fbd-6dac-4f37-8447-dc15e9b0b0fd@arm.com>
In-Reply-To: <fb530fbd-6dac-4f37-8447-dc15e9b0b0fd@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 27 Apr 2026 14:31:56 +0200
X-Gm-Features: AVHnY4IGvkmRCFcpfRAbI0rtjxSxPsnhxADQXzr_JRZ5ynsY-P1uM1qU-VDRvjU
Message-ID: <CAOf5uwkUXrsX6w_1LYiLK+f5HFsefx3t6Qp5urxEu_N-15KZ7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mtd: rawnand: sunxi: Fix user data length for H6
To: Andre Przywara <andre.przywara@arm.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Andre

On Mon, Apr 27, 2026 at 2:28=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com>
wrote:

> Dario, Michael,
>
> are you going to take those patches eventually, or are they supposed to
> go through the sunxi tree? Somehow patchwork put this on my plate, but
> MAINTAINERS says it's yours.
>
> I will have a final look at those patches, but I think they are fine
> since their counterparts passed the kernel reviews ;-)
>
>
Company projects are stressing me out. I will check today with Dario

Michael

Cheers,
> Andre
>
> On 3/27/26 15:05, Richard Genoud wrote:
> > This series introduces the correct usage of user data length for
> > H6/H616.
> > If the older SoCs must use a fixed value of 4 user data bytes for each
> > ECC step, the H6 can have a different value for each step.
> >
> > In the first round, the behavior was kept as the one used by A10.
> > But we have multiple choices:
> > - do like A10 like before (and not use all OOB)
> > - do like the vendor kernel (different from A10, but not using all OOB)
> > - use the whole OOB for user data bytes
> >
> > In this second round, the third approach is implemented.
> >
> > All patches but the 4th are code cleaning.
> > The 4th patch enables using a variable user data length for H6/H616
> > along with maximizing it.
> >
> > A similar series has been accepted for Linux:
> >
> https://lore.kernel.org/lkml/20260317142437.580204-1-richard.genoud@bootl=
in.com/
> >
> > Changes from v1:
> > - gather reviewed-by
> > - clean sunxi_nand_chip_init()
> > - use all possible remaining OOB space for user data bytes
> >
> > Richard Genoud (5):
> >    mtd: rawnand: sunxi: Replace hard coded value by a define
> >    mtd: rawnand: sunxi: make the code mode self-explanatory
> >    mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
> >    mtd: rawnand: sunxi: introduce variable user data length
> >    mtd: nand: raw: sunxi_spl: remove user data length reset
> >
> >   drivers/mtd/nand/raw/sunxi_nand.c     | 292 +++++++++++++++++++------=
-
> >   drivers/mtd/nand/raw/sunxi_nand.h     |   3 +
> >   drivers/mtd/nand/raw/sunxi_nand_spl.c | 129 +++++++++---
> >   3 files changed, 324 insertions(+), 100 deletions(-)
> >
> >
> > base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
