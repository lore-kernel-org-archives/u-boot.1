Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58933E92713
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 15:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE41583C9F;
	Sat, 27 Dec 2025 16:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2jv0iDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5EC83B99; Sat, 27 Dec 2025 15:06:11 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA32883B8A
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c3cb504efso9111413a91.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766844367; x=1767449167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S7GgWy2LaTN9yLDxfJLyhpBtWvLf5voGYH0RwnDNfEs=;
 b=G2jv0iDMHKL24LAug+3rAXtsV+HSvgiEdJhKU4J02v0hd3fbtkQZciYg0jXCVfK4MR
 GIIxaqx8ZI07viVAvouuB8SlHJH7q5AdgX6MspNyURyPVOIucpAJPN2wEMwENrOhYQdT
 CfISUauhL5wQ7FAPod2ZN1msRkduNQYEk6Ey2tNan0sBKo4dzSRAhJNMMsBZES75kIcW
 apBpEkZQ2SBD96/h+iJHfEbwPfKLLSeAcM1mSEk4kfskYfhvxPf+uzLPqENp3gvoQsVr
 iwiv018ESQ4bbnLfn2Hi+fBHvg67CvxUpdR7R5e9x1I+NqZJVlm5OSdf3YNP6h3jIr4B
 o3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766844367; x=1767449167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7GgWy2LaTN9yLDxfJLyhpBtWvLf5voGYH0RwnDNfEs=;
 b=UnjgodC2so1r8aQP0mehteD1EIMKKKjsUstVcpIScgW7hqpVFwU4TzQW13JbWj/eEp
 ik0XEoPWFYwAYb0GL0WuYEjY2QBLuOSWD21ojf6EXC76lPWWn/g+Fgr1rrgowbb5G2aP
 TRFXHIYt5Eig1iCoo8kfYUc1ZEbOw3u4Z2muQTe2f4PijK6ThT9OrEWOG87eR1w7zVuV
 9WDZDVOkZckPZibxDJO+HLIhNqCZO3DPJdctrcqzFLDZxobUl1pvNCuHFUkodp+60Lr7
 K0Qja3CoWjqZiDNPzM7RfoXIhNnwCknqH1FP+HGwQqciFZR8eTOEmW2MADRSVzn1uBWh
 tvQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyrTVkLV8xwcXwnxAZR577S3VT80AO/KWARlLv564GiyRun2WuX0U1F3xugQ1QMYqbDUoqTyY=@lists.denx.de
X-Gm-Message-State: AOJu0YxWVCY9VBcIc5bAFxkVM09wPq76RwzZWoy+Ddkvw8Ira+wb19Id
 EeQ3RejCDX08gvFAkEQZdBZMADbaM62ZENOCg9Gi0OYfU1/KiaKuBQD/s9TkUQ==
X-Gm-Gg: AY/fxX5/RLRYMUC3o40A4fGelVdp2hWewn/brMCiLbCideruFuokz4udulMgYnQLnhL
 Niho6qbLr1oJuy7wqd9ZzTk28ettS/IDoEMm39crTAdeM1UnbDDf1n9qu2yQfN9q6AtWu7R0XyZ
 qRHOePesNBR1GEKwT9MJvxa1yj85BkXDWpTNKzcPCrR9NdsWB9oH8t6kefCCkmhucBVyErYqLDr
 oS88ltb0Z5Iecx0qk/9DMIxaCXRXtx78wLaP9z4FQHGagrz3yJn9RRaVXOSXuvDfsjwJp9I2HrV
 xf9ctJ8YNU0UuYalUoNSOBmylWXCgyu4peQFyiaZLum5DC46nMEKbrSrpNERSb36CcttNxbUKa7
 Mbk5ukbqeeve22qcesZ6HpLr05oVQRt2b6K3FE1PgBx2uaUvSAmpcYIefgJ6OForEliTTiitC65
 Y+8Jyu8U6lEWoQ+D7hWo4ShhtyIHSTSQaWY/6Tjtjq4uHRzsDVXXwsUPbyWg==
X-Google-Smtp-Source: AGHT+IHsKt+68gOadWpGq1iZNNZtUtodV1g4HJZaU5qnD1nC4ZI2YHsSRgvW36WhnzzMzmH5UR3D+A==
X-Received: by 2002:a17:90a:cf91:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-34e921cd531mr16274118a91.25.1766844367111; 
 Sat, 27 Dec 2025 06:06:07 -0800 (PST)
Received: from google.com (61-230-61-154.dynamic-ip.hinet.net. [61.230.61.154])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e9223ae34sm23033144a91.15.2025.12.27.06.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 06:06:06 -0800 (PST)
Date: Sat, 27 Dec 2025 22:06:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yao Zi <me@ziyao.cc>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] serial: Add Goldfish TTY driver
Message-ID: <aU_nyvqng83HLpWX@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-2-visitorckw@gmail.com>
 <aU8_VIK_oTHY2RTF@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU8_VIK_oTHY2RTF@pie>
X-Mailman-Approved-At: Sat, 27 Dec 2025 16:08:40 +0100
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

On Sat, Dec 27, 2025 at 02:07:47AM +0000, Yao Zi wrote:
> On Fri, Dec 26, 2025 at 05:53:57PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the Google Goldfish TTY serial device. This virtual
> > device is commonly used in QEMU virtual machines (such as the m68k
> > virt machine) and Android emulators.
> > 
> > The driver implements basic console output and input polling using the
> > Goldfish MMIO interface.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v2:
> > - Update SPDX license identifier to GPL-2.0-or-later.
> > - Sort header inclusions alphabetically.
> > - Move RX buffer into goldfish_tty_priv instead of using a static buffer.
> > - Make sure getc only read a single byte at a time.
> > 
> >  MAINTAINERS                      |   6 ++
> >  drivers/serial/Kconfig           |   8 +++
> >  drivers/serial/Makefile          |   1 +
> >  drivers/serial/serial_goldfish.c | 104 +++++++++++++++++++++++++++++++
> >  include/goldfish_tty.h           |  18 ++++++
> >  5 files changed, 137 insertions(+)
> >  create mode 100644 drivers/serial/serial_goldfish.c
> >  create mode 100644 include/goldfish_tty.h
> 
> ...
> 
> > diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> > new file mode 100644
> > index 00000000000..ce5bff6bf4c
> > --- /dev/null
> > +++ b/drivers/serial/serial_goldfish.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + * Goldfish TTY driver for U-Boot
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <dm.h>
> > +#include <goldfish_tty.h>
> > +#include <linux/types.h>
> > +#include <serial.h>
> > +
> > +/* Goldfish TTY Register Offsets */
> > +#define GOLDFISH_TTY_PUT_CHAR       0x00
> > +#define GOLDFISH_TTY_BYTES_READY    0x04
> > +#define GOLDFISH_TTY_CMD            0x08
> > +#define GOLDFISH_TTY_DATA_PTR       0x10
> > +#define GOLDFISH_TTY_DATA_LEN       0x14
> > +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
> > +#define GOLDFISH_TTY_VERSION        0x20
> > +
> > +/* Commands */
> > +#define CMD_WRITE_BUFFER   2
> > +#define CMD_READ_BUFFER    3
> > +
> > +struct goldfish_tty_priv {
> > +	void __iomem *base;
> > +	u8 rx_buf;
> > +};
> > +
> > +static int goldfish_serial_getc(struct udevice *dev)
> > +{
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +	unsigned long base = (unsigned long)priv->base;
> > +	unsigned long paddr;
> > +	u32 count;
> > +
> > +	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
> 
> I think it's okay to do pointer arithmetic directly against priv->base
> in GNU C, right? In which case void * is treated like char *.
> 
> If I'm correct, variable base could be dropped, and we could avoid some
> casts here and below.

Agreed.

While standard C doesn't allow it, GNU C does support arithmetic on
void *. Doing this directly makes the code look much cleaner.
Thanks for the feedback, I will update this in v3.

Regards,
Kuan-Wei

> 
> > +	if (count == 0)
> > +		return -EAGAIN;
> > +
> > +	paddr = virt_to_phys((void *)&priv->rx_buf);
> > +
> > +	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
> > +	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
> > +	__raw_writel(1, (void *)(base + GOLDFISH_TTY_DATA_LEN));
> > +
> > +	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
> > +
> > +	return priv->rx_buf;
> > +}
> 
> Regards,
> Yao Zi
