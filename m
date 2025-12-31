Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E778EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C5E8415E;
	Wed, 31 Dec 2025 18:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ok8YhShr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3FC840C1; Wed, 31 Dec 2025 17:15:50 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2819683F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso148962285ad.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767197746; x=1767802546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pJIH7Ogz4buQQ/SCo5CKYJfL7nG8gIfKAYuIleQ8IlI=;
 b=Ok8YhShr5F2AwXlrQLIV8ptnc/OWMps+QvSsuZQ06mfH9hii9w/x7xQmUIzFINfRii
 aCCsl637xiPJcX/MPC3TiEXMsAjv0O1XL4l4ujfwuGQONeM3zwfOtk+mLk6VEzq+1MG9
 6z3BW0HvGspb5IyMKeQRWY177nF23w6AyOnf01ozzqs3zFnVRjA3lk7Xh/Xybodo7mP1
 tfLxG6Ik0+LgPirMsr1OAd7OM32drxuxH1fjg6zlDL+T1DuWFvbOpATqYB2XArG2H9Sy
 C26czX+CSCXf+//MasEcYh/RI3BxDdub3tdtCHH5+GdFwgLfOWdbGNk0zZ3qtV+Ra5ou
 fuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767197746; x=1767802546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJIH7Ogz4buQQ/SCo5CKYJfL7nG8gIfKAYuIleQ8IlI=;
 b=PBW9B6unJHeSUqHERdMRoTh08c+ea4He+ZscVvKq0FcJeepetHoBlu3tnWWPgIp+Gd
 F1j9DiALR+dhKwUrxKyaRgkbVdn/nxSi5r1eluJWObOzl0emH8mPMGzZfQq+TudBTRhP
 GUBLLmRNOhFzOHefm0ENDidRi9L7wZ88TewfKK0hTVVKlE7YN3GZafX0R+IVzH1VFCwt
 J1CNTFUjLchsqc3ND4Vt4VTb9JWK+MkukTC2lbY/MQOjdoJU1nY+uL22hds0h0WL/KBh
 lFlowoR/krpiUp2fgfpXsfY4ANr0JUfdJlt1efWA/StfL34ux5UqNnCjmuxK7+SOdIEa
 iHnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ODi0xWqIN+DUeHwgPSGNmA53LUCHt3O6xEAVoPRDQcVTGyOFJlqUDxMnqJBU/y+dJh5D40Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwcVrZv5K7GxESenLv0YzMUy8oPjcH1120kXd12l5xF2+QObTu1
 +Dp7p0gitR5nW5fIHP0jQ8etLHJ1q0QB1CL+7e15x9PMcVOVvsgF1Df/
X-Gm-Gg: AY/fxX5bIqHOOvHappayWKyO7se8b7RUqIxhC8/WDrTcYV6whu5eJppZUOzqUu190cp
 l4C0nO3nC+A/De+3tvcMqkBMBhCp6uHyynrAssPbSOFVCPJuWtot1EPHQgmiXXUkDgOsyuk3EIz
 /ixEzHZnDDrEd5arW1bjbime7rY0NGRGfy4CiLo1eUztxV77eX93Dejq93pBzxPoGfU6y6MjzJM
 Ry/4VDxfoUZKyX7WaTJLlzsXagdlycdT2EpbWgc0YNJmF1ibxS331Slg7NRAxrWXGqKsUKlP9vm
 l6BGtqhpwfE1nAcT8GSCaoDhbO9Hg2SZqewNwnGH4tWQSy7XgYo4//Lctgp0zP148zhMpaOVQUV
 iKc711N2LwKmq5vWD2hKyoVELauP25I4KlnmULgWZVLYXED4O1W4rHkYO9UXPvlip1ZLxgthZjD
 oPJkL+TwT3zYD+yqCJpOCAqv3q
X-Google-Smtp-Source: AGHT+IHPUjRc6DpWbIjx7MBVEU8WT58Bhnvuyk3CJ+V2rqcgQabKsItTaLfU5t6cgPKDIhnL8F74qQ==
X-Received: by 2002:a17:902:e806:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-2a2f242a26amr318071755ad.27.1767197746417; 
 Wed, 31 Dec 2025 08:15:46 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:671b:a2e7:4f81:f445])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82bc9sm333035705ad.36.2025.12.31.08.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:15:46 -0800 (PST)
Date: Thu, 1 Jan 2026 00:15:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yao Zi <me@ziyao.cc>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/6] timer: Add Goldfish timer driver
Message-ID: <aVVMLtqON6maL21n@google.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-3-visitorckw@gmail.com>
 <aVTCZUacn68Nbg10@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVTCZUacn68Nbg10@pie>
X-Mailman-Approved-At: Wed, 31 Dec 2025 18:47:14 +0100
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

On Wed, Dec 31, 2025 at 06:27:49AM +0000, Yao Zi wrote:
> On Tue, Dec 30, 2025 at 04:01:08PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the Goldfish timer driver. This driver utilizes the
> > Goldfish RTC hardware to provide a nanosecond-resolution timer. This
> > virtual device is commonly found in QEMU virtual machines (such as the
> > m68k virt machine) and Android emulators.
> > 
> > The driver implements the standard U-Boot timer UCLASS interface,
> > exposing a 64-bit monotonically increasing counter with a 1GHz clock
> > rate derived from the RTC registers.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v3:
> > - New patch.
> > 
> > The link provided by Daniel [1] returned a 404 error.
> > Since the implementation is straightforward, I wrote this driver from
> > scratch.
> > 
> > [1]: https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c
> 
> ...
> 
> > diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
> > new file mode 100644
> > index 00000000000..8205ac77853
> > --- /dev/null
> > +++ b/drivers/timer/goldfish_timer.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + *
> > + * Goldfish Timer driver
> > + */
> > +
> > +#include <dm.h>
> > +#include <timer.h>
> > +#include <asm/io.h>
> > +#include <linux/errno.h>
> > +#include <goldfish_timer.h>
> 
> Sort the headers?

My apologies, I should have remembered that.
I will sort the headers in the next version.

> 
> > +/* Goldfish RTC registers used as Timer */
> > +#define TIMER_TIME_LOW	0x00
> > +#define TIMER_TIME_HIGH	0x04
> > +
> > +static u64 goldfish_timer_get_count(struct udevice *dev)
> > +{
> > +	struct goldfish_timer_plat *plat = dev_get_plat(dev);
> > +	u32 low, high;
> > +	u64 time;
> > +
> > +	/*
> > +	 * Goldfish RTC provides time in nanoseconds.
> > +	 * We read the high 32-bits and low 32-bits to construct the 64-bit value.
> > +	 */
> > +	low = readl(plat->base + TIMER_TIME_LOW);
> > +	high = readl(plat->base + TIMER_TIME_HIGH);
> 
> It may be worth a comment to point out that the value of TIMER_TIME_HIGH
> only updates when TIMER_TIME_LOW is read, so it's impossible to read out
> teared values (higher half has been updated after lower half is read).

Agreed.
I will add a comment explaining this.

> 
> > +	time = ((u64)high << 32) | low;
> > +
> > +	return time;
> > +}
> 
> With the header sorted,
> 
> Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks for the review!

Regards,
Kuan-Wei
