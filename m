Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EE0CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EA584D5B;
	Fri,  8 May 2026 18:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AdpHx928";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD4E84D89; Fri,  8 May 2026 18:38:22 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0229A84D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso3489916a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258300; cv=none;
 d=google.com; s=arc-20240605;
 b=PaKKKZh1cna/64IrPO9cL780rtj9Nw7S/npVHGOtRlK4XZ728fLU0E/Mx75KbT3r/+
 6piM0fuuf8zdn3wKUQ3ZZKZBBrwD1TgFouw/0sCjTNfN2K/TifOqiGGIDPr7uGTpkjIQ
 hPBqjB8r4GvB4AmiB95B5yBGI+YUpw0aj3Vbc/JfF2qj5c5u3PdEl73f0DPiHfze+xsa
 CXVajpMlReYqG2yY5DyxByLtSBhtZNcPEP6sAKlCDRcvhbswz8h6D+EHyzN3bzlBCwDP
 kdLebH3QoXyNfZwjkHVX4L4YKW8wO5gE+5MC965gtpqsubPEiouB/2/lPif5wvDEodrX
 2+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8z9EJRafP4t66Q/ywydcefng9yQQ+YmxdIuTXtkn09g=;
 fh=B6gKULCG4oXB9QXINeasv5/ztXHLMDU33WZMDyglNfg=;
 b=XDWPFGO3vcIzglO6RB1h+W9RiK0DleLmgSW5gxrfow4mba1xxShSDA+/Juiqy8ZThe
 ui3mV1s3E7j3fBY0AUS7reBJk7HjMIawspE1mzU2eeFNULRaBm1bumePQ3Kh7TWHb1dk
 wmBMkeI/wiWe8v/GwHpRZqmxShtYufb8DFI3p3JO+Ew8nskV6pKaGhNGAGR8XJgcbIDX
 sOmMiwrI5+moUAunQpqhe2XMyBwvSR12dfxRE17Ky+onnXTf+CN+I44GLhHX29WgU2+k
 Qvg4L2XlwJEnEaS9gd+NaS+Gz1jxQ8g8UtcXVYvOe1mIqtKThvk1O9BrHIINJrproqsL
 w8VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258300; x=1778863100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8z9EJRafP4t66Q/ywydcefng9yQQ+YmxdIuTXtkn09g=;
 b=AdpHx928rMpX2nPhSsU+z38tbjqVjMZZaZBZaoWm2PIhHiTjsIS7CKtar0G31oG8ct
 cfRSbiktVBh328jrVic12z/DqGiF2Tu59xGSoFApFqhL9CWvRr5gle7bDIlCNKDb6ALK
 XXWsYs8KxcHxT3G2NPagE8Fl0asfG3h7ohnhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258300; x=1778863100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8z9EJRafP4t66Q/ywydcefng9yQQ+YmxdIuTXtkn09g=;
 b=P7i8kiBttVBCeAHQfPnLfIKfWuW2g11EFpcSJj5/cv/Q2kV954CfH9WT9rwvw8oVTU
 LAR8fv1BjaryMfZ8WNpOYHcAN65BwbSt9ePGqueRqrWer2wIdlUwN3S2fam4qZlU+EHk
 hLDvtZ1yJveutVeovtHB3RqamOe0fKPegZ3m4RmfQJSm4GugOvBw+yhBozzWq5DmrJJR
 xi9Yo+7DGp5eguvDTno7U11fn83BzwS95NG1yKbrmEe5TP2u5M8bClk97oXDC+JeZNyz
 xDV2qj/VvWlyXnu0Yb6dAuD6YsQRrnvG4kvAianMBqjnSmkoZ2wT6eZ3xlIgpULs6YXJ
 krnQ==
X-Gm-Message-State: AOJu0Yyw9l4h5jiAxpBCrQ071LOX7qpHIQxxmK05hnBuTq5IRoPVygnI
 v7E0TqZJ6KXXkTUclvFP+6CqfP8eTjEy2+Q0+HaJ1v0M4ChzGGMV40oUxUmA5qe0DQ9tW16IlhW
 2mwvN26A+xya2KZ7lDy3q/rS/RSv+7tyfLIX9bU1i
X-Gm-Gg: AeBDiesMDefus5Jd1An4aC8k1XxDvkRsAJ8nSrQXrXF3wfLDNbX2+AwRpsbxNdRDBkI
 GelwvwPcNgk2npFJExaBTaUctlySn8p3lJHH8br6MUA1t+uclaIkFCQzNNBVnKFWcXNszlGPpLT
 uX2Vhj2fgh9RrQau5AA6hRddwQYDq+X+KJcz4KiL5jVOdf2MvWnOyrzSkdHkdai2ekneBN+dSiO
 jkxKHLa01n5ldrDyWOES1oqnCDKmqShHwOAObDFk2t5ApFEbvUPhuBNdbzQXRf8/J6D/0m5Ankp
 22BMUw==
X-Received: by 2002:a17:907:9304:b0:bc5:111d:3c96 with SMTP id
 a640c23a62f3a-bc56b41dd69mr716171866b.10.1778258300315; Fri, 08 May 2026
 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:38:04 -0600
X-Gm-Features: AVHnY4IH9CWzWCf3LUHE_xY0YbnE1IUpnBAtt10Yd_Wg88LLXmuaoC6iusp1QBI
Message-ID: <CAFLszTjqa0TSb-ifB6Oj+NOOHg6LE0hwTsiU4tV=Bjg5vyVE0A@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi: bootstd: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>
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

On 2026-05-07T22:08:10, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> mtd: spi: bootstd: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/mtd/spi/sf_bootdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
