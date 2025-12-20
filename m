Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3125CE668BB
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 23:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CEF83759;
	Sun, 21 Dec 2025 00:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0u5EuYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFD3803F5; Sat, 20 Dec 2025 17:28:57 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403C880050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 17:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a102494058so18761395ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766248134; x=1766852934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DcQ/6QHBOtrisBGk0Q/rRhbC6oTTm01GnLnEFnDucLE=;
 b=Y0u5EuYpz3CRfnIWYZp5kHQBPpKEOlFn8b78uzcPla0Cn3LSECYUWToGyV8mCll5+e
 CRuwU4oNZS51yA+KmQ514Mw7UXhNsTZYACdHNrEDcwqRNvgMWQ5DCPpg+IFjkchmLLvw
 EbtWed0NEVba7pSoIuymSNy5yu1WebzS75rppKEHfhfsdm0O/je6NiuBq+vN775KvYrT
 LPdtO8XotGvg/u4APLuwV8zeOjC5Mr2+HDYZIsQW1Db/A45tir2FXwhKdL0iIsrfG5KJ
 AnMKzs61ySRBcQp/35iSnq+3r6poMLYt9BmAh7uycZsCEDKPJMMKb8Tars3c/AB8VWkM
 qp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766248134; x=1766852934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcQ/6QHBOtrisBGk0Q/rRhbC6oTTm01GnLnEFnDucLE=;
 b=Xl2oFRcFHSCiXWgATQCbS1Pam0p3g3tqNaqe6ezTE+JbUb2z96EbEH4h3xsbFS2YHf
 dKiAkQzMKpq5Hz5M2QtXrk1Un/tXbIZ8pGcBvyYs93eyZTXeHMzKU1fRxAFw04F9h7nZ
 rnfNWbvGAXFa1D2ONmQl8XWm9iVXaKgm+1yle+q4fV/48dycKV46SFBKRnkzcIM9NEfU
 KYc+NK+E+oyvFV0NlE57O/lMQs0ZlS7WjhRvg6DtAyIKI1g3ELn6cXGzZ34JD9Y7bpoa
 y6HMPpyhRt3RvQP9a5w6rMb0IIVoaf2ULqiGcsA3wBMlZj8PvzPs5zvFd693U2sPthBa
 WnMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdECL5/9lif+82UhOhE5A8gUPSMOVYpFhMA/r7YabhX8OlQBG1gzuwqA8NgjOcTG0uRt079Nw=@lists.denx.de
X-Gm-Message-State: AOJu0YywytDs4N+/f5sIjYjY6CnplgZ1Rs8P78N8kJgmAZmz3zLqV2aV
 sUvE8OczVvT/byCsdNA9biGHcKYBZT2Xx7yItDcKSWvUTvXo+azhxhjOTVmpsg==
X-Gm-Gg: AY/fxX67KpFUfH1qC3DrCV3EmNeIHj55huK4DivxouPuUP9LvxdcTE+/nMNRKhXl3iw
 Of+QtYpI4pdpNy+BwiE6FfOcGv7+BC2v8yFhbWwrgCbeLDwC9hx7Ht9O0jukiIQ/wtTr9ctot1l
 axshxBy6RZ831CvZ25UxBCgZ6kIz1WuBSSr8hzAud4mQzqeqKNaE2FI8bu63tqtFEK4IiofDaHI
 Iq6QY23OcAfmgofgYn0yfLXc8KNwe1QTlafKiYGNqEboxdFCM9XEJnG6S9ONlSdYaEZ8yi0hxsK
 30js/WNu2fPtJzKpnS+S/3xMZQyqv4ONVlVtQVBd1aDAWe7+hSLGRRDuLvELDfzou2+79mnidoC
 FZtGwlAF9aPLP9F4ou/3wjnIs4SUVLDBgwAVKluOAfv3C2jlyQsAbfVzBzDhxIzYLnchCPok5Cf
 wL8/OzXc5Oc/UpNq9egM81V1g=
X-Google-Smtp-Source: AGHT+IFMLKssopIab48NP8X3mia2dosNskA6Ga0svzN0nfAE3l74XzwXsLcSeFet3pA2ldX1kgLKMw==
X-Received: by 2002:a17:902:d2d0:b0:24b:1585:6350 with SMTP id
 d9443c01a7336-2a2f0cd2058mr72335395ad.11.1766248133540; 
 Sat, 20 Dec 2025 08:28:53 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:15e:4c73:9b28:3ab7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm54141645ad.67.2025.12.20.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 08:28:53 -0800 (PST)
Date: Sun, 21 Dec 2025 00:28:49 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yao Zi <me@ziyao.cc>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] serial: Add Goldfish TTY driver
Message-ID: <aUbOwayeH6nAYmMi@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-2-visitorckw@gmail.com>
 <aUTC-8hYsPDVFOly@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUTC-8hYsPDVFOly@pie>
X-Mailman-Approved-At: Sun, 21 Dec 2025 00:43:30 +0100
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

Hi Yao,

On Fri, Dec 19, 2025 at 03:14:03AM +0000, Yao Zi wrote:
> On Thu, Dec 18, 2025 at 06:52:50PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the Google Goldfish TTY serial device. This virtual
> > device is commonly used in QEMU virtual machines (such as the m68k
> > virt machine) and Android emulators.
> > 
> > The driver implements basic console output and input polling using the
> > Goldfish MMIO interface.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  MAINTAINERS                      |   6 ++
> >  drivers/serial/Kconfig           |   8 +++
> >  drivers/serial/Makefile          |   1 +
> >  drivers/serial/serial_goldfish.c | 112 +++++++++++++++++++++++++++++++
> >  include/goldfish_tty.h           |  18 +++++
> >  5 files changed, 145 insertions(+)
> >  create mode 100644 drivers/serial/serial_goldfish.c
> >  create mode 100644 include/goldfish_tty.h
> 
> ...
> 
> > diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> > new file mode 100644
> > index 00000000000..85d2a93b6ff
> > --- /dev/null
> > +++ b/drivers/serial/serial_goldfish.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> GPL-2.0+ has been deprecated as a SPDX license identifier.
> GPL-2.0-or-later should probably be used instead[1].

Thanks for the pointer. I wasn't aware of that.
I will update it in all the other files as well in v2.

> 
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + * Goldfish TTY driver for U-Boot
> > + */
> > +
> > +#include <dm.h>
> > +#include <serial.h>
> > +#include <goldfish_tty.h>
> > +#include <asm/io.h>
> > +#include <linux/types.h>
> 
> It looks better if you sort the headers :)

Sure. Will do. :)

> 
> ...
> 
> > +static int goldfish_serial_getc(struct udevice *dev)
> > +{
> > +	static u8 rx_buf[4];
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +	unsigned long base = (unsigned long)priv->base;
> > +	unsigned long paddr;
> > +	u32 count;
> > +
> > +	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
> > +	if (count == 0)
> > +		return -EAGAIN;
> > +
> > +	if (count > sizeof(rx_buf))
> > +		count = sizeof(rx_buf);
> > +
> > +	paddr = virt_to_phys((void *)rx_buf);
> > +
> > +	rx_buf[0] = 0xAA;
> > +
> > +	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
> > +	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
> > +	__raw_writel(count, (void *)(base + GOLDFISH_TTY_DATA_LEN));
> 
> You send a command that reads count bytes, where count represents the
> maximum of bytes available in the buffer and sizeof(rx_buf), so it's
> possible to read more than one character...
> 
> > +	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
> > +
> > +	if (rx_buf[0] == 0xAA)
> > +		return -EAGAIN;
> > +
> > +	return rx_buf[0];
> 
> But only the first character in the buffer is finally returned. Isn't
> the following characters (if present) are incorrectly discarded?

You're right. Requesting multiple bytes causes the hardware to drop
subsequent characters since getc only consumes one.

I will set the read length to 1 in v2.

> 
> rx_buf is declared as static in this case. Are you originally intended
> to do some type of buffering here?

Originally, I used static to avoid performing DMA on the stack.
However, I realize that this introduces re-entrancy issues, which
prevents supporting multiple device instances properly.

In v2, I will move the buffer into struct goldfish_tty_priv.

> 
> Additionally, I don't get the point of setting rx_buf[0] to 0xaa then
> checks whether it changes after sending CMD_READ_BUFFER. Is there a case
> that CMD_READ_BUFFER would fail even when reading TTY_BYTES_READY
> returns non-zero? I had a brief look at qemu's goldfish tty
> implementation, but didn't find such situation.

TBH, this is debug code used during development that I should have
removed before submitting. I will remove it in v2.

For reference, here is the planned update for v2:

struct goldfish_tty_priv {
	void __iomem *base;
	u8 rx_buf;
};

static int goldfish_serial_getc(struct udevice *dev)
{
	struct goldfish_tty_priv *priv = dev_get_priv(dev);
	unsigned long base = (unsigned long)priv->base;
	unsigned long paddr;
	u32 count;

	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
	if (count == 0)
		return -EAGAIN;

	paddr = virt_to_phys((void *)&priv->rx_buf);

	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
	__raw_writel(1, (void *)(base + GOLDFISH_TTY_DATA_LEN));

	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));

	return priv->rx_buf;
}

Regards,
Kuan-Wei

> 
> > +}
> 
> Best regards,
> Yao Zi
> 
> [1]: https://lore.kernel.org/u-boot/20251212142859.GQ303283@bill-the-cat
