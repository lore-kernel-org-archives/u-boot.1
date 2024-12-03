Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A93AE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFF4896C8;
	Tue,  3 Dec 2024 20:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvEvySPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8EB89185; Tue,  3 Dec 2024 20:47:28 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554F8896A4
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so3535357a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255245; x=1733860045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O71dWMBv+NcYcpxAhySs3vYAilxOeQei+Yl1enNcsIQ=;
 b=OvEvySPyD7CUkT/8gCMQe8ttygU66g0TtBSOwNIVvuVuy7yFzBh2A1Tts0EzBuRpVe
 jYkNf+V3zkIzwTNUK/eO5WUEUTF6kBLSi1+aUp9dgV1s0Ysi77iH3risRC/PZrd3vZGi
 k4MyODQr3pPoncaXvPQzkXX+k80gFbb01XKGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255245; x=1733860045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O71dWMBv+NcYcpxAhySs3vYAilxOeQei+Yl1enNcsIQ=;
 b=xBYhqIpxyVuTPPQZCBJYNjIEkXrTPmGBcKZRVvltqsVntL0f/JnbifHv2+jPgVhW2d
 wnTro68EcGHN6t3NCU5nxqQxCpkarAaAME9xtV666S4OiJLUPxVpVg0nyfRhOUSg6Uzb
 hwpkIAFEIkjdJYR3/eS/RnVhVPD+GH1qM6d7rbWnZ6wRPdkV218Io5Wn5TPUZa6raXsZ
 RAK1oPNR3c2JNfltOrQZn297QB7nY26v+f3PGWmdqeC6S0I9WaGYUs0sYhaBt6S9MglY
 udRAIHaB6r2/J/NmSLtuCz6N26hSwYAPsYxsMn1UzBYMGQ8kQi8pwvRPDxIQ2gETqpoD
 4Scg==
X-Gm-Message-State: AOJu0YyDjgDzYPShZZO7+6L0teRp9YYXK1LRRVyFJdAsZvQuhGjHKs+Q
 nyW6EU/CWEJfeJ+7Iou0Was4VIkO1rTyXnaTWNW1Vyxl7dupD8TqFDLmjzLCnzq6fFp9dmTX39r
 NjuFtLTjv4q5R9Ayl2FWoMFXc2wvpC24JOqybQnJzrJ2+A+A=
X-Gm-Gg: ASbGncvtFHwxa5/GbsHXR5UzGrQTJr6YJMx8SKHMemER25pp7BgoejskXrN7ONdfBJU
 idKb2VhgbYIcj7bF9SoZBapIPVs5Z44SD
X-Google-Smtp-Source: AGHT+IFz1qfgZPsZJAcavjkBnR/lV6cg9z02dm/e+uKpdIoSd5YkDxnJQwoM4nkJeQgaymWVZwNd91+yESRWo5HL9kE=
X-Received: by 2002:a17:90b:3ecb:b0:2ea:5054:6c49 with SMTP id
 98e67ed59e1d1-2ef00c29199mr5618121a91.0.1733255244949; Tue, 03 Dec 2024
 11:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-5-sjg@chromium.org>
 <CALeDE9O9sxCwf_scpbLQEtSxovN64jMWkfEVpUZviJFrXPbHTQ@mail.gmail.com>
In-Reply-To: <CALeDE9O9sxCwf_scpbLQEtSxovN64jMWkfEVpUZviJFrXPbHTQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:46:49 -0700
Message-ID: <CAFLszTgRgHaT_rp8oJDnZrrOnYUNqHsXjtSYBSMoZ8Hr6SYGSw@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Samuel Holland <samuel@sholland.org>
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

On Tue, 5 Nov 2024 at 07:13, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Sun, 3 Nov 2024 at 00:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
> > this is the new way to access the LED functionality.
>
> This still doesn't work!
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Combine removal and enable patches
> >
> > Changes in v2:
> > - Add a patch to enable LED and LED_BOOT for these boards
> >
> >  configs/pinephone_defconfig | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> > index 9d39204a439..272fce1c1a4 100644
> > --- a/configs/pinephone_defconfig
> > +++ b/configs/pinephone_defconfig
> > @@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> >  CONFIG_PINEPHONE_DT_SELECTION=y
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> > -CONFIG_LED_STATUS=y
> > -CONFIG_LED_STATUS_GPIO=y
> > -CONFIG_LED_STATUS0=y
> > -CONFIG_LED_STATUS_BIT=114
> > -CONFIG_LED_STATUS_STATE=2
> > +CONFIG_LED=y
> > +CONFIG_LED_BOOT=y
> > --
> > 2.43.0
> >

Applied to ci/master, thanks!
