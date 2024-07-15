Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E69788806;
	Mon, 15 Jul 2024 13:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZhOYef7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBA488820; Mon, 15 Jul 2024 13:39:47 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799578881F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b73dc6e7aaso27190766d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043584; x=1721648384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5wzbhyO66BWO2cq+LloMbCcw/zg/x2mzKX7+Dzn77lw=;
 b=ZhOYef7WBXdPKNNVAAphAok3G3ZOYnYetfUjmR2rZEFwkXlCOAyEDQYSOS4hxTL6ZL
 6NzhskdlUQ+MJDFM26hj8xMCoXCuSOB3KCCjb2uYc+Xspb/sejZVRRrlM2+Yv2eiRny0
 nW/Ax2bOGHpQUBEml0u6snZo97a+RjNmZn4bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043584; x=1721648384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wzbhyO66BWO2cq+LloMbCcw/zg/x2mzKX7+Dzn77lw=;
 b=i01Dy5GJcYFyGmUrVMLvYrqjqxpDAsCp35591a+t43emY0xXuDJSuhMq3DawGM6v1Q
 ncHB7XveEZAao/+SKAJ3+KL+0jw+xkvuql1RfQ/VzKfjyGjKcVUhbus+vJy4himG8OPZ
 gG9y++OmvASYtkhq0AnUzGdZCxP7NJbRbAJzTQbabls6G8HqcQ7zq8n5YvapL+MKxTEb
 b39WvTSA3DKY6fARNHKYCm2cxQLR8BLFDf699xTca+lOILUaVqkHFjvN6L5CMmuAhMKF
 xr10aI6sMwbVbJzPuX/kwFy9ji3U5JubmmUEL7JKeLdlWnNIx2s308JOjdEOBNFVziCE
 +uBA==
X-Gm-Message-State: AOJu0Yy2/sXfW2iP7+hXih0rRpJtD10PAO2lZxy1PgD4s43Hs4D1dKXx
 8HxvxtesnkDXBJkuqJrST19M8R+KZF9Tz/1/Afr1r1gtlvIUnA4z38Xuh1g0JycN/nret+j5BXk
 MvuL+hPSGUgAmD8iOBumBC93O/DW5SizkotI9
X-Google-Smtp-Source: AGHT+IHz8nAq16sfvUpPGwc0ZG2AqhP5j2TVwgbK6TtepoycSRTNohGl9oe1IYdp2GiijcUocs9Nzp/ZdQ4vKT3GnHc=
X-Received: by 2002:ad4:574f:0:b0:6b5:dfe2:9a5c with SMTP id
 6a1803df08f44-6b61c1e333emr235804786d6.55.1721043584430; Mon, 15 Jul 2024
 04:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-47-sughosh.ganu@linaro.org>
 <CAFLszThvVSuUMOavz=MqpE5GSm5Yr2CBBUvMkvV7RbNGQEPDVg@mail.gmail.com>
 <CADg8p96xj1MCKnrhKL5JoyrJfbr3xYqmQ00JJtMLAT_hyNKqQA@mail.gmail.com>
In-Reply-To: <CADg8p96xj1MCKnrhKL5JoyrJfbr3xYqmQ00JJtMLAT_hyNKqQA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:33 +0100
Message-ID: <CAFLszTis9gZDgpnc-oH5WH7ktt5XHOXfqvYvVEMMAVTv5NoL0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 46/48] lmb: mark the EFI runtime memory regions as
 reserved
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Mon, 15 Jul 2024 at 10:42, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Mark the EFI runtime memory region as reserved memory during board
> > > init so that it does not get allocated by the LMB module on subsequent
> > > memory requests.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1: New patch
> > >
> > >  lib/lmb.c | 41 ++++++++++++++++++++---------------------
> > >  1 file changed, 20 insertions(+), 21 deletions(-)
> >
> > I see again that this is getting circular. Can you look at what is
> > actually allocated by EFI on init (i.e. before anything is booted)?
>
> This code is simply ensuring that the EFI runtime regions are marked
> as reserved by the LMB module to prevent that region from being
> allocated. Do you have any other way by which this can be communicated
> to the LMB module ?

But this region is within the U-Boot code area, so it should be
covered by the normal exclusion of that area?

Regards,
Simon
