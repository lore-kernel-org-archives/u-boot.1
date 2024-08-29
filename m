Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF905C761AE
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 06:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DE288AFF;
	Thu, 29 Aug 2024 08:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxqsrzzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B43888AFF; Thu, 29 Aug 2024 08:27:16 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9EF8870D
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7cd76b56e59so87790a12.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 23:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724912833; x=1725517633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgjlmIUpej7//gTaCOkmnAx+pNHDFFmUpL6iXvFOsnQ=;
 b=bxqsrzzJ760+d6FFotPFfTZr+sGPZazCr+7h884KEN8egjeK093CASUGpuRn248ogT
 TV3LVHEubTpM+WKs+Lk1n9dHHoJQsnav1SyAdJlJzQ+OxnpvIUY3YcyFd4Ud7keZduAk
 5IAOHl7o+xHhXMQJ1yNgNewiJOpfv0tQs3nOLhQtqpfapVJtXGlEpYYXf0uez7iRdsfE
 6IjaoVxOGldv0+2K45MwEONe+wPiwq8i8A3dhBcYgJp9AdMDY20aJIcgwAn8rOTY9/t5
 NHI7m8HIQQ/mZtiB/T25fpBz+IsKFdoxI3kpqlbtsg5TA4cW+fARrFzIYdx6XL6urtpp
 rMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724912833; x=1725517633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgjlmIUpej7//gTaCOkmnAx+pNHDFFmUpL6iXvFOsnQ=;
 b=PRS5FmnOs70QcAd4zQt1uwdDC1IBbtMdSBFTL3z7cxztbfa7M1ONciRsJQj3xMa13W
 l3XuS+cu4BL5MkFIBzzYdgMcsI5pZLnqfHZDQWAxNNrSzQbNpvtDPa5Y60TA0D4WlcZJ
 9rjnOnDfjQoV81R8tAymgCxi8WL4nmEsWqynQ56zZKzIkcNnZhucnPUVA7KA4ExJ13aW
 v6TARhDcvzNiyT7fxHTxOH+RmRtFIIuE6AhhmHJcC4GUyZfEvcmT4kVBHmSe16/PXW4B
 EnlnVZ59BjQr5XkXUqmzRXZvNjPdF2ddx2b9Pwio6WDUx97spzW26CrLsoRI56L+2X0O
 CPKA==
X-Gm-Message-State: AOJu0Yx4pA1dRnJu1nER0NIx5IIcrdXlgb8rWX9SphdK7kqkVJtXR7Kq
 FVsC+oqwmvoeFnrflGqet9oeiiMhIFoYJtZ8CCrsWj2yr6RDR60K26GaRm4+3eT1rof2ICbGVFU
 TYgXDPaUO5GetOksfuDxxqJqZlXY=
X-Google-Smtp-Source: AGHT+IHXEKwAUYDZM8yMfnf3m6uCmsyYabYx4/8MU21LtQG9UIA4CvZX2u8l2ZB06kQJlzftcy4jeTaN3C/zfJCbf+M=
X-Received: by 2002:a05:6a21:9688:b0:1be:c2f7:275 with SMTP id
 adf61e73a8af0-1cce10ef074mr1604038637.50.1724912832670; Wed, 28 Aug 2024
 23:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
 <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
 <CALeDE9NuRLfeDfPusTTxnWkz6HyRGUFOhuL710BRe6EybWHdfQ@mail.gmail.com>
In-Reply-To: <CALeDE9NuRLfeDfPusTTxnWkz6HyRGUFOhuL710BRe6EybWHdfQ@mail.gmail.com>
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Thu, 29 Aug 2024 08:27:01 +0200
Message-ID: <CAHseuWCP8jk=s7GH3w7KyzCrD=MbSqrgNFmKcb00-qRyvXv0rA@mail.gmail.com>
Subject: Re: How to retrieve cpu info from u-boot fucntion?
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
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

Hello Peter,

Thanks for the update. Looking at the board/raspberrypi/rpi/rpi.c I think
MAC address is only returned for models that have onboard ethernet. but for
models raspberry pi 0w / pi 02w it might not return any value.
Am I correct? (maybe I overlooked it?) Is there any other approach for this=
?

Thanks in advance

On Wed, Aug 28, 2024 at 5:31=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:

> Hi,
>
> I appear to have missed the first post.
>
> > Is there any update on the below request? Are there any functions simil=
ar
> > to eth_get_ethaddr() to retrieve device-specific info? I am working wit=
h
> > raspberry pi 0 and there is no network interface card.
> > So, eth_get_ethaddr() returns null
>
> So there's a bunch of drivers for OTP/eFuses in drivers/misc/* which
> provide access to those sort of unique options such as CPU serial
> numbers, and possibly stored MACs etc.
>
> I know the RPi has a OTP/eFUSE HW IP block, I don't believe U-Boot has
> a driver for that as yet.
> The main RPi firmware may have an mbox/API for querying those sorts of
> things, looking at board/raspberrypi/rpi/rpi.c there's a
> set_usbethaddr which calls a msg_get_mac_address to request a MAC from
> the RPi firmware, I suspect that may work for your needs.
>
> Peter
>
> > Thanks in advance
> >
> > On Wed, Jun 19, 2024 at 9:11=E2=80=AFAM Sourabh Hegde Ramu <
> hrsourabh1107@gmail.com>
> > wrote:
> >
> > > Hello,
> > >
> > > Currently, I am using the MAC address from eth_get_ethaddr() function
> to
> > > calculate a hash value. But, I would like to replace this with a more
> > > unique device info such as cpuid or other values. But I could not fin=
d
> any
> > > function that can retrieve cpu info.
> > >
> > > Can anyone please point me in the correct direction? Do we have any
> > > functions for this? Are these things part of the documentation?
> > >
> > > Thanks in advance.
> > >
> > > Kind regards,
> > > Sourabh
> > >
>
