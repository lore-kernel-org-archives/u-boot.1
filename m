Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3CFC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECEC87823;
	Wed, 27 Dec 2023 15:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CZ/PDo8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D0787866; Wed, 27 Dec 2023 15:06:55 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63012877AF
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55361b7f38eso6077025a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703686013; x=1704290813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=53hU5OW7S2+7LvrRycK9coVQfxgd0K6B/yDPvuojceQ=;
 b=CZ/PDo8VwQqW58sHuVHYhl4Te2gJ6EmBVORK7+MPTY4tcV4vl6WFqyxwfmcWZ/bG9J
 KENVCMvKHahxtX2LHDMdLIo0MF4uZRqVCxO9oY5dGlLGt8mMmUqJZwKWHIrIJNh6llKK
 G6djJ1yzrsYs8dhtnn+Ta5xYfrGmBS5DCqUY837U+KUz31LC/o+2vVZD9NPYDdgVFTvF
 zjpNiouXZ2UQrZc6U6KJggauaL9M7uLvwz0/sSmKKwkd7ZOmhVXwNO3aZge8jtKAD/FH
 /NQFRaacuRe2XJSTvHkgQZQWqWILoqQGVKjIih6+sq8yxPblr0wm0aZxNWqKxYRY9jb1
 NidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703686013; x=1704290813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53hU5OW7S2+7LvrRycK9coVQfxgd0K6B/yDPvuojceQ=;
 b=HjcFQywB1Ub6ssH8XsqibQyZJ5ScyyVCxK6fjaCDWBGDC+jNgX0KrXOeij2feI/+Xe
 Rzasgfs2wbaXl1xKM5twZC16Tsq/gFjVddIdLt8S9lOOTXlLDLPFJJXYboPyYhMvxs95
 h6mQ9KpUJlKVsfzhKZatEmjFrG+NJDJA9E0jDV55Aj6Yu0a0Os9mhLdm8lrtZP1UW4UT
 /i84zwrs7er8S7sA48ON6VXMBUGapOlls5EcSIu28qsdopYalGmRwSjP7MRDQJt5FaRF
 PebC8PWkl6ot6bafH2STL5p1qbnBQk/eXhNHmIBQPZ+x5ADh/6eOG+UzLu0UdiHKeUKV
 ROVA==
X-Gm-Message-State: AOJu0YzcguDWVb4GRhs/Gve63IKuGwBG/isiwg2ujj81MCIyu/FxPIWy
 Lq/55WLDdM/rumrmOdcLoqx3M7RR32CwJg==
X-Google-Smtp-Source: AGHT+IG8dMV6B+0gi0vpPzoBZldjhRNLrqf8wq+vKGeFs4ySqaufx9gswm3scb4WVbCYCpKfJFmUyg==
X-Received: by 2002:a17:906:220b:b0:a23:5f0c:864a with SMTP id
 s11-20020a170906220b00b00a235f0c864amr2732191ejs.97.1703686012763; 
 Wed, 27 Dec 2023 06:06:52 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 wh13-20020a170906fd0d00b00a2684d2e684sm6601415ejb.92.2023.12.27.06.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 06:06:52 -0800 (PST)
Date: Wed, 27 Dec 2023 16:06:49 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com, nd@arm.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <ZYwvefJyuMdKXGio@hera>
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
 <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
 <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
 <CABEcMwVvu7e9sr8oZKJN+s3DH4wz_+LFx9cADAFZQj4eG+7skw@mail.gmail.com>
 <CAC_iWjJOi3DmxVYx2X2aXtsFpvHDFOqskCYZu3s1U04ak5u7XQ@mail.gmail.com>
 <CABEcMwU==WKegXX0kKiVecAEmQQ=752Qiw8kFyF9oUC4w7_GEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEcMwU==WKegXX0kKiVecAEmQQ=752Qiw8kFyF9oUC4w7_GEw@mail.gmail.com>
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


[...]

> > > > > > I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> > > > > > set EFI variables and the installer just failed. Might be fixed now,
> > > > > > though.
> > > > >
> > > > > It's not. The error message is less scary in distros nowadays, but
> > > > > setting the variable for Boot0000 is still not working. That being
> > > > > said I have a plan to fix it for variables stored in a file, that's
> > > > > why we standardized the efi variable format in EBBR.
> > >
> > > Does this mean supporting SetVariableRT for files ?
> > > If yes, would it work without the driver model in runtime?
> >
> > Yes.
> >
> > The reasoning here is pretty simple. You can't keep alive drivers etc
> > for devices that the *kernel* eventually owns. The proposal is to
> > ignore the EFI spec and teach the kernel to write those directly. We
> > already do that when the variables are stored in an RPMB, we need to
> > figure out a decent scalable architecture for the rest.
> >
> Thanks for explaining this.
> It would be a good idea to provide EFI var storage info like location,
> offset, maxsize to linux
> and linux can modify vars as required.
>
> Eg.
>
> location=espfile://u-boot-efi.vars offset=0 maxsize=-1
> or
> location=spi://0 offset=0x3D0000 maxsize=0xFFFF
>

Yes, you need the flash, offset and size, but I as trying to figure out if
we hand over those as an EFI config table. I haven't managed to do any
coding though yet.

/Ilias
> Then the linux kernel is able to modify vars correctly.
> I think SPI might be simpler to implement vs file as there can be.
> many different
> ESP partitions on multiple drives or no ESP partition at all.
>
> Kind regards,
> Shantur
>
> > /Ilias
> > >
> > > Kind regards,
> > > Shantur
