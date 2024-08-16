Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC84C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD1188AA9;
	Fri, 16 Aug 2024 19:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z5ggxGj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F4A88881; Fri, 16 Aug 2024 19:10:22 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A6F88B94
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so2922035a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723828211; x=1724433011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsinVPuvFwALDtDx94iJ9QrzeZeqqKW7hanGnKzcSqQ=;
 b=z5ggxGj1cK5GtiZh/o5/NpmN7TY9uEocSeV9mF+prtgwGtCR2frNKZMetA7bzlixAb
 27FMkbG2BUqPA5XOyuxp+gnqV80264ICPJpK484LkOHGLtJFwOqndvTzhBrLoYI/dbnw
 zcDyPpOd4iMZXcy6gAc5rLsTkOA4CC9BKp0k4QuSjYdLQOP7aB84kXakH3ak31TGX0dQ
 EHyW9ZP3KORDNi3oqlvmW3Bhv6LcNq2FNxPnRivrp5bG9F3udDd1MB/2DU4gep3vteNy
 LSi3pcuseBhU/vWl28HPYYSMSx+VawvpChbaR88D0KBuiDAmKVLCHnHgO0SN/h20LCps
 CYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828211; x=1724433011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsinVPuvFwALDtDx94iJ9QrzeZeqqKW7hanGnKzcSqQ=;
 b=Mfr1h+L0xMI7XD+l2CzJy1yLDtKJmh22ogTu2cvrPJVU1dAwU1UD8Y43Ri64+PUUvl
 VInCnqDTcgdrfp6DDqQgbeZQce1BWean/hiAi9y8yz8aZz4lFR5bOKVTqFBWDOcipYKR
 0OAaatMYeaPGh5rrm/r3850UMqD9D5vS+8BEWIHre7WOglOd1BZ07iqTHDxheJ78HYTL
 fBFVNs80OawQTaHwenoI6bfF858kGzaqW9oBw1jwhY4uQ0tLElCVaHIOhZKMNLwCS0H5
 LegYgPV1euV6t0j8HNZqFDHPrv8IYsj2eCoVPW0XYisinAyi69cu4yXnukfmZpT3+ZpQ
 1uAQ==
X-Gm-Message-State: AOJu0YwC8C/4iYNSgdEAoXlqVNzlBLkuejdUqjaDFO6dUsjog0WMXKAz
 d/kRtqR4NnniiHU0zvNwYteKYFPEm15ppGkxUHfURqdU6HCk2N+mD/sbA1zT0YCQ4F6NIDFSfZN
 FXYFb5/msoQIlN2GI71Lcf4/tunBrDgOvqQ6DDg==
X-Google-Smtp-Source: AGHT+IH+9Uux6vyaUaZ2tTQnqo6YHyVZQ6nTnlXjMsyrSHnQxl5saupubvEmjYVMBk7IsSwMTYTZMyVFz83H4ceF7Z0=
X-Received: by 2002:a05:6402:84b:b0:5a2:447b:2143 with SMTP id
 4fb4d7f45d1cf-5bedb6e359cmr186481a12.10.1723828211117; Fri, 16 Aug 2024
 10:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
 <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
In-Reply-To: <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 22:39:59 +0530
Message-ID: <CADg8p96ogU8isBs6rs+s5-U4XJOXryPDb-MzHTuxwT8L07HQ3A@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 16 Aug 2024 at 20:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 16 Aug 2024 at 04:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > reading the file into memory. With the LMB map now being persistent
> > > > and global, the address used for reading the file might be already
> > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > address from LMB and then read the file to that address.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Don't use the API version with flags parameter.
> > > >
> > > >  test/boot/cedit.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > >
> > > No, this address needs to work fine without using lmb. Same with any
> > > other tests. Tests make use of the sandbox memory space memory
> > > addresses and it makes things easier to code and debug.
> >
> > Like I had explained earlier [1], not using the LMB API for allocating
> > the address results in issues, since the load command internally
> > checks if the address can be used for reading the dtb. Without this
> > patch, the cmd_ut test fails. I am not sure why you do not like this
> > solution. But in any case, can you propose some other solution? I
> > believe I can tweak the address to some other value, but that would
> > not be a proper solution, but simply kicking the can down the road.
> > Thanks.
>
> But this is why I suggested having lmb_push() and lmb_pop(), so you
> should be able to use those in the few tests which have this problem.

Ah yes, I forgot about that change. Let me try running the test again
and see what I get. Thanks.

-sughosh

>
> If it becomes more widespread and affects a lot of tests, we could do
> thing automatically in the test framework, but for now, that doesn't
> seem necessary.
>
> >
> > -sughosh
> >
> > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html
>
> Regards,
> Simon
