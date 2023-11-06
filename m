Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876A9C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 19:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04D686F9F;
	Mon,  6 Nov 2023 20:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ezzdpvr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F235868AE; Mon,  6 Nov 2023 20:59:02 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E22A86F9F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 20:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507975d34e8so7048821e87.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699300738; x=1699905538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ksSf4lc9rpLIWqRdRV0s1hr3ciZ/SnhFu1C0d4FIVl8=;
 b=Ezzdpvr76P7Qj+/TpD5mdX5w0hQT3/y+90t6eMmzGJ6mGHBmf4s3NXYjaM0hwIGpJx
 qiGymdQDL4nAYKxK5fxEIwuAnPu2LgbFWt168pW7pGVeAWvB+5WSYjnPw3nOB4qcs4I/
 218AX92uPD5y/j64C5hoNAbykoD5/e8p4GGuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699300738; x=1699905538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ksSf4lc9rpLIWqRdRV0s1hr3ciZ/SnhFu1C0d4FIVl8=;
 b=aglC74FH0XgYUaXwjoqaYnFJN2u/lzacvWpAl2krcsd8tvYBOgn9GinMbRmmHKfTGt
 ll4wc3svXrh8X9XWx053CHUTWUZjudZEfFr939BL+94yqGxc546bB6W7HPtS55JmIrMz
 3lx8W0g9nAEXMk0BAtHKXryrmB/FuWwg8BI/Re9JodMl3rX5fsQ2a9v4pffZ4aGybX5O
 EPCRKGnEoZuzRRKastG7Iq43TOYABU1b0y0/2z4vPLwBx5rmSieZZDJJ2V+yZON2JQQz
 KVUCF8HuTfS0lnkMb3LIAcmxO7ENMa91QEDbss7Cs53y4c15qkRuafL7xrRiUQ2FGABF
 ecgA==
X-Gm-Message-State: AOJu0YxtAlFlimuwNKt/DQ6jXlnZJ5kSzrQI8bWiWWtpbTYI6/MbjTnB
 fvpqSUnPKkX5ofika/v0zwmU0w6S6/bZYpnQloyxCQ==
X-Google-Smtp-Source: AGHT+IEPhG9hXqfAN7urI2meEtJH1AaJLlUtCi7w2jTK3G/T7UbGHqP28nUPnw7K8BK1dQ5lir2PDii+yP/zBHZewPY=
X-Received: by 2002:a05:6512:1307:b0:509:4025:1ac6 with SMTP id
 x7-20020a056512130700b0050940251ac6mr16883800lfu.54.1699300738229; Mon, 06
 Nov 2023 11:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231105211910.GE496310@bill-the-cat>
 <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
 <20231106183020.GB496310@bill-the-cat>
In-Reply-To: <20231106183020.GB496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 12:58:46 -0700
Message-ID: <CAPnjgZ20ZY3SO3sXWjNk6uAvgBKcNK+XRRs+k0MmrTcj6A1zjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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


On Mon, 6 Nov 2023 at 11:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 06, 2023 at 10:25:00AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 5 Nov 2023 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:
> > >
> > > > This image type is supposed to ignore the load address. But at present
> > > > it fails if the load address is missing. If it is zero, the image is
> > > > loaded at address 0, which may not work on all boards.
> > > >
> > > > Make use of the kernel_addr_r environment variable, instead, since this
> > > > seems to be a more reliable final address for the kernel.
> > > >
> > > > Another option would be to create a new Kconfig for this, or to use a
> > > > region of memory known to be free, e.g. calculated from the DRAM banks.
> > > > But in any case we should try to avoid conflicting with the
> > > > kernel_addr_r variable. So the approach in this patch seems reasonable
> > > > to me.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > How are you creating the image in question here? A noload FIT is
> > > supposed to just supposed to go from where it is. Where do things fall
> > > down later?
> >
> > The image is Image.gz built by Linux, for example. So compression =
> > "gzip" which means that it has to be decompressed.
> >
> > Things fall down as soon as U-Boot looks at the image, since it
> > doesn't have the ARM64 magic.
>
> Can you provide logs and env? "booti" is supposed to handle this case
> already, and if it's not we should figure out when / why it broke.

Do you mean booti handles compression? Yes, I can see that in the code.

But in my case I am using bootm, since it is a FIT.

Regards,
Simon
