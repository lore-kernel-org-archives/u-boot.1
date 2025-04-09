Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22306C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 18:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E3C838CC;
	Wed,  9 Apr 2025 20:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nadda02R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E60838DD; Wed,  9 Apr 2025 20:27:34 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5597982A0D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 20:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aenbacka@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e8ec399427so57946406d6.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744223251; x=1744828051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rxS2mbBz7OKhDx9jT1+XTw1IfdNPBbrHav5yUCyDKZ8=;
 b=nadda02RFva+qwJz5mP3opPBLBDtrv6NmguMPp/2QBBXreaMYCc9PcN3Ux3y9gRlK8
 ZJcy/YbcE1SorER4cvHx1knk2IO15csMNnvljg6fI8zp1fHk2u7LKhBH3b4EXkhVWAER
 uObnyzSADx41c8i1aVj6b5YJjR40SMHPf8SfCvvlMLT3LSKiu32A0fegh5Xz/9RTj9CZ
 hD+obbuzZ9XZ+trBlsQ+0oFFjgbPMTByS1l5XvVZXtdvfd1KEnq8Nlfv2kG9kOwBIJOc
 RSw9i2mfOB8Y2ZtwUQJxp8CLfdsh2DbjHgSVmteUtF0VW2ILBxmgvMjYLPvVbqueVRLG
 im6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744223251; x=1744828051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxS2mbBz7OKhDx9jT1+XTw1IfdNPBbrHav5yUCyDKZ8=;
 b=BkbRO/ez/lHL14dxT07vELgS0o0Qa0JJ2rCd72d4p5vvT2S3l7eCAKBBPYnwKljT7P
 8+NaIMU3SGRZY96aUAEL7y3nypS5K7ThrV0ddi02nDNKkz4EBRmcv94G1a/fPWlyBt0m
 ig5mWtN25PsFlKTbP2NT8tb7vo0CqRnh4+RSrBXOiF8nSqT1JWhSAJOt827j7SmvAdRA
 4psCLr8XWEwi/FIMwn5LskzFL6NCZhL8hlvqhOHDxAz4/DVJgpEW+bS9oK8K0Z1a8cXx
 eCd0qY4e/E0vrm2WzDoX+Q0NGq6LdguoKF87hy4tW4FZ1IGGtjGqa6UleIO5gbenq8J5
 kRCw==
X-Gm-Message-State: AOJu0YxyNWGcEYKZGNsuax4o/isMtOdVOlT18BhbA1zM4QIdeZdOqdbm
 2JvWoRVd7Wh7SFW5xsBedbFwL/sZr80XSntvGcbhNuzGxvlZXw2YPuhKylG329f9UvBIFdI7LhH
 c6DhEWtfJgHQfA6/slfkj9uPgnnA=
X-Gm-Gg: ASbGncs0mJ7Mv8HlV41rdhUppqrROaBKeaINJz5kblHVbRjDFdu4yvohQYQkCJR65ur
 f6a60iKbHJ+AwRJsEwRfINqwWj3sxtqb156Ay1lRWJfLYJusvaRdAMBYPydzQUlzdd4Z6x5+MNv
 Jukc2yQpeFgrwmrEbxlm8y8Q==
X-Google-Smtp-Source: AGHT+IGjT82fBqhZiyLcRtnVSKGYU/po/LE3A+uNYi/yilHBV71NE+rIW9sboT8XgXo8S7font9j+kEBSTzzcSpu/Go=
X-Received: by 2002:ad4:596f:0:b0:6e8:ea17:8587 with SMTP id
 6a1803df08f44-6f0dbc9778cmr59130956d6.42.1744223251106; Wed, 09 Apr 2025
 11:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOeqweT0o1-bFHNaoDURGYKGvx4OvqsgRpXwdWArdeGmBrnJyg@mail.gmail.com>
 <CACr-zFBPZ6VZCQzHKW-AJDyUUpcLLJS=wSNVejnWTsT9tg9SNg@mail.gmail.com>
In-Reply-To: <CACr-zFBPZ6VZCQzHKW-AJDyUUpcLLJS=wSNVejnWTsT9tg9SNg@mail.gmail.com>
From: Andreas Enbacka <aenbacka@gmail.com>
Date: Wed, 9 Apr 2025 21:27:20 +0300
X-Gm-Features: ATxdqUHf-e1Jiag6T4ciKVVkld0ApO-BMRFqFnPsP7BnH8j7ZCW9cL5VY_LyMmw
Message-ID: <CAOeqweTLZ6Uvo4x++2v2f9DtvDjoZx9rhLKYck3E9+hJ06b13A@mail.gmail.com>
Subject: Re: Issue with booting FIT image using Yocto with raspberry pi cm4
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hello Christopher,

Thanks for your suggestion, I tried to apply the patches (last one I had
some issues with, as it did not apply directly on scarthgap branch). Still
has similar boot issues
with the fitImage (inflate error -3).

Some questions:
 - Is the default uboot load and entry address 0x00080000 reasonable (also
load/entry for the kernel), or might it need adjustment?
- Could it be that the CONFIG_SYS_BOOTM_LEN needs adjustment to handle the
decompress kernel size?

Many thanks,
Andreas Enbacka


On Wed, Apr 9, 2025 at 11:34=E2=80=AFAM Christopher Obbard <
christopher.obbard@linaro.org> wrote:

> Hi Andreas,
>
> Can you please try with this series from Simon?
> https://lore.kernel.org/u-boot/20241220003447.2913443-1-sjg@chromium.org/
> It solved booting mainline kernel on CM4 for me (albeit not with FIT
> images).
>
>
> Thanks,
>
> Chris
>
> On Tue, 8 Apr 2025 at 19:23, Andreas Enbacka <aenbacka@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > I am working on building a custom image targeting the raspberry pi cm4
> > using Yocto / meta-raspberrypi (scarthgap release) and u-boot.
> >
> > The kernel and rootfs booted without issues before switching to using f=
it
> > image. I build the yocto image with kernel type / class set to fitImage=
.
> > For building u-boot I have specified e.g., CONFIG_FIT=3Dy and similar
> > parameters.
> >
> > When booting the board, u-boot loads the fitImage (around 10MB in size)
> and
> > shows the kernel / device tree blob info (kernel is gzip compressed).
> > However, the process fails when u-boot executes "Uncompressing kernel..=
",
> > with Error: inflate() returned -3. This leads to a boot loop.
> >
> > I tried manually executing
> > 'load mmc 0:1 ${kernel_addr_r} fitImage; bootm
> > ${kernel_addr_r}#conf-bcm-2711-rpi-4-b.dtb', but it results in same
> error.
> >
> > The kernel_addr_r is set as 0x00080000.
> >
> > Any information about this would be greatly appreciated.
> >
> > Best regards,
> > Andreas Enbacka
>
