Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A549D1266B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC1083F37;
	Tue,  2 Dec 2025 21:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J4zOfyVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A314E83F39; Tue,  2 Dec 2025 21:07:43 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2484E83F32
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so882000466b.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764706059; x=1765310859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gZWZrnx5z4zrRzA0KfHQ/g/g45O16FtyvaUF9PVBi4g=;
 b=J4zOfyVSHLv9K24A7UdZC7zqxn1XDG1OR67u13BlhQ4MBmRKwqT1b3h/FWH+JYu6cQ
 X47SZ/lW9d1/xu2hor7wh/sJMFZJKtbwvlpD8uiEXqUe1RDBthGh9wM5jHAoQRiNae68
 FwFnuwK9bXm28Le8urN6MpEB2gTfBVSV/xFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764706059; x=1765310859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZWZrnx5z4zrRzA0KfHQ/g/g45O16FtyvaUF9PVBi4g=;
 b=uCXNwrOklDxXJKn3bHUAcbePnLss1M3q5jNbB2rS7R2nhAaMvdMqaDq0pBZa9WETJv
 1LAx9nqKYKmkTRMxoxSo1ZEGaV7OUH9jRonH4fKq6A+p+IjI5o6yYWVpUEFeOU0fn0L6
 MT2c/Qz7gMHXA9ShOiHhfclnBPBPnIQ5Ud9edNUFxFyhw1bBzQemCzYaUC/G+qo+4t2c
 GJDwtOSlgjnM1/kLUS01Njw/pDAZRpLByxRRtBy7HD8iPitAPyhO43Rx2re09tN0J3RU
 8NmwMCE0wtORUldH/xDvoTmFrK21txoTtsbnGqEd1IF0fGjr+zcM67ozfQ3WKznRqCzS
 Bi4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1uivNzJiJTUgSRIGjgFRsYJVK2sw4jSuy1AOmewONkBD/O1Ua3NrqHm7fJrUo15UjO32Agw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTwaRrxDPK+SxscS252XppA8m7VKv+uieS0GEJl/hUYdpMJM5C
 F2lxxXZOqrdDXxelBBXvKwPHwXlJnNJiOKIUO9K0ovILiyi0XB0aORJZ3FJf564AYVdavFYzgaJ
 rtLl2xaBQwue8RApJFe7BOsUVDZ+xJ4QhoAcdLTTL
X-Gm-Gg: ASbGnct5TDJcmhOCduyuNXcq22HG2ccESccmdKkCqwnEoGeCB3CCohjNBct30tC69tz
 j2lz9NehRW4WzMfQ3FQHROgedSDsHL7bT/lrFWPQBCW7Xh3MumCdwaEfDAsjUnvQkTtna7ykIIH
 da2F5IiIDv09j+w7y0FCEjquGIQnLYrVWQeodo8v96iAi3z7HzRet3iH1MnAjviFoPUTiyemh/i
 XVXdnNZkdQtEWJ/5GjJK12sbKA6jRGCAukkCEiKlfQBmu8IX3J1DjvHMt6ms0SzoI3PeUXH4Ten
 bQdl/60x
X-Google-Smtp-Source: AGHT+IF8lVexIvUJzNm/ju/rs5/gSAgpI4ofysu9HKwIOP7MSRlXYHK1aMrBijP3LH9T9IzShx0KSinDGXJWAl1dDeI=
X-Received: by 2002:a17:907:fd15:b0:b73:5cbd:f1d3 with SMTP id
 a640c23a62f3a-b7671747740mr5089686366b.42.1764706059570; Tue, 02 Dec 2025
 12:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
In-Reply-To: <20251202185222.GG303283@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Dec 2025 20:07:28 +0000
X-Gm-Features: AWmQ_blzQ-gPdlXVZu2E5Wbgx0hFwAFh0XUaMCP7Vpw5rlzbu1ZIY3gT7BUzlTI
Message-ID: <CAFLszTg+Q3=6fChTzxWz+wOxOUV-et2qL0phrf-JvQkcP57-4g@mail.gmail.com>
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

On Tue, 2 Dec 2025 at 18:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> > > From: Tom Rini <trini@konsulko.com>
> >
> > Hi Tom,
> >
> > > Hey all,
> > >
> > > I am wondering if at this point in time, anyone still builds our host
> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > > Windows, natively.
> > >
> > > I ask for two reasons. The first of which is that a reason we still have
> > > to support Azure (despite its slowness) for CI is it's where we have
> > > macOS and Windows hosts. But at this point in time there's so many ways
> > > to have Linux userspace running on Windows or macOS that I don't know
> > > that there's any value to these builds.
> > >
> > > The second reason is more macOS specific and is that with:
> > >
> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > Date:   Thu Nov 13 12:54:51 2025 +0100
> > >
> > >     boot: Assure FDT is always at 8-byte aligned address
> > >
> > >     The fitImage may contain FDT at 4-byte aligned address, because alignment
> > >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> > >     8-byte aligned address. Make sure that the DTs embedded in fitImages are
> > >     always used from 8-byte aligned addresses. In case the DT is decompressed,
> > >     make sure the target buffer is 8-byte aligned. In case the DT is only
> > >     loaded, make sure the target buffer is 8-byte aligned too.
> > >
> > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >
> > > Which does things we must do, we now don't build on macOS. Why? As best
> > > I can tell (and for a general purpose OS, is a good call), memalign(..)
> > > doesn't exist and you need to use posix_memalign, a not drop-in
> > > replacement. We could spend some time reworking the code here for that,
> > > but for now I've instead gone with this workaround so that CI can
> > > continue:
> > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/
> >
> > Are you sure about this?
> >
> > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> > tools.  As such it should be irrelevant whether the host OS provides
> > memalign() or not; U-Boot provides its own implementation.
>
> We use parts of this code as-is (and some other less obvious files) when
> building host tools.
>
> > OpenBSD doesn't have memalign() either.  But I can still build the
> > targets I care about on OpenBSD.
> >
> > Or is this about sandbox?  Did sandbox ever work on macOS?
>
> It's about "tools-only" build target, but also I suspect that if you try
> the next branch right now it'll also fail and we'll need to figure
> something out.

If you are interested I would be happy to come up with an alternative.

Regards,
Simon
