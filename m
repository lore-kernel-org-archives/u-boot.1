Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA055C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4052588266;
	Tue, 16 Apr 2024 11:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OYPmTupy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E4187F1E; Tue, 16 Apr 2024 11:06:54 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CEB88266
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so4763920e87.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713258406; x=1713863206;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4+OzgpJEWhBg8LkVvRG5SQlSQRxMYPhTnr+pLNYBfnQ=;
 b=OYPmTupy0PiIblzCvjY6AlELxO9E+OPF2YvISTQMFaN47tzYcKt2BASNHZ4YJHscL6
 bx7ILymH40UeDW+5p3UrvSMcbnQizyl79nffWoW7I5QrIUmOv7BER9+UHCyv5+ws+mpq
 Cg/CwW9cU4e7b/97wF5g/PXAOECVSFpz6EG7LRc1nWyfKs2FY+cXAo0ivsFAax9UseNW
 GrOI9qWhChZKXEsRWSXFgaCGpW7dFVDGc8JYu6EkxFRgKMrNLpqbjarvIVwcwSQMIBD5
 B4vUb8bsr665u0mWtlPpI6/4LbZ0BRHT5ybRQZfYX93zL8foA+YGq0rHa0YA9RA4LLeo
 Z6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713258406; x=1713863206;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+OzgpJEWhBg8LkVvRG5SQlSQRxMYPhTnr+pLNYBfnQ=;
 b=mcF6LzcOF+kvbeYzV2Yfbn/YIHL6AUT9Wb5qRV4b0Rp+JT6aNVKigJ+DqaYDRlsIwY
 Vyn8oCNHpkDG+enuCvs3FZ5y73W01jyOqvF1wP7RIA83o3qv9G72B7OMrEdEGImU6DZL
 M0Cb+hF/mridoBjtFBlCoKXUHDPwE0gWF4e0PwrrXdW0oQVyNgwUZwa7c2dpYWZPAuej
 pCtRouClz8EE3AYUWx+9AQQ9NZrfK5buw2uk3uHzkL+43QzH56MSt7Fs154Hjmtv0QQy
 NGjvoOROiNCpKSZfNP3VOgZQJsrM2oBY3wj1HMB+/uoKQfS8Cm/4FSawBnSbXil2Ybc4
 pUng==
X-Gm-Message-State: AOJu0YyQZXlq3dQiSePdklAnu+arhdqnKA2Fv7MUrPQ22y4LgimdheiH
 MZWKy5j0+dIe37pkz8/7zAJBD6KIAaCZF4+IjWn6LZs5jRsVWoc37AdJsq/Bhwo=
X-Google-Smtp-Source: AGHT+IGQEA0piHDatdnrTRfoEVbEaIvB10zJ4eBU6fxTT61iBc2vM4dkYYf4343vDV6N100fk++QPA==
X-Received: by 2002:ac2:5049:0:b0:518:9b42:b846 with SMTP id
 a9-20020ac25049000000b005189b42b846mr6726262lfm.21.1713258406388; 
 Tue, 16 Apr 2024 02:06:46 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 b4-20020a5d4b84000000b0033e786abf84sm14207264wrt.54.2024.04.16.02.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 02:06:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Ian Roberts <ian.roberts@timesys.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, Teik Heng
 Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
In-Reply-To: <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
 <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
Date: Tue, 16 Apr 2024 11:06:43 +0200
Message-ID: <87r0f54qxo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Greg,

Thank you for the contribution.

On mar., mars 26, 2024 at 11:36, Greg Malysa <greg.malysa@timesys.com> wrot=
e:

Please avoid top-posting when replying, it makes following the
discussion more difficult:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-=
trimmed-interleaved-replies-in-email-discussions

> I'd be happy with that change. Does anyone have access to the
> associated designware databook (I do not)? We could also check to see
> if those four bits are all always allocated to the 2/3/4/x version
> number. I can submit v2 with that change instead once we know.

I don't have access to the databooks either. I usually refer to the
linux kernel code since it's a more up to date version of this driver.

Looking at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D65dc2e725286106f99c6f6b78e3d9c52c15f3a9c

we can see that the following is added:
#define DWC2_CORE_REV_MASK	0x0000ffff

This makes me believe that the versioning follows a well known pattern.

>
> On Tue, Mar 26, 2024 at 7:50=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/26/24 3:32 AM, Greg Malysa wrote:
>> > From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>> >
>> > This adds the Synopsys device id for version 4xx of the designware
>> > IP block and extends the version check to include it to permit
>> > new hardware to run. It does not add any 4xx-specific features.
>> >
>> > Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
>> > Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
>> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>> >
>> > ---
>> >
>> >
>> > ---
>> >   drivers/usb/host/dwc2.c | 3 ++-
>> >   drivers/usb/host/dwc2.h | 1 +
>> >   2 files changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
>> > index 637eb2dd06..6fdde6a9a7 100644
>> > --- a/drivers/usb/host/dwc2.c
>> > +++ b/drivers/usb/host/dwc2.c
>> > @@ -1180,7 +1180,8 @@ static int dwc2_init_common(struct udevice *dev,=
 struct dwc2_priv *priv)
>> >                snpsid >> 12 & 0xf, snpsid & 0xfff);
>> >
>> >       if ((snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER=
_2xx &&
>> > -         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER=
_3xx) {
>> > +         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER=
_3xx &&
>> > +         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER=
_4xx) {

Note that this change is also part of:
https://lore.kernel.org/all/20240328131811.94559-1-seashell11234455@gmail.c=
om/

>> >               dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08=
x\n",
>> >                        snpsid);
>> >               return -ENODEV;
>> > diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
>> > index 6f022e33a1..f202d55eb2 100644
>> > --- a/drivers/usb/host/dwc2.h
>> > +++ b/drivers/usb/host/dwc2.h
>> > @@ -739,6 +739,7 @@ struct dwc2_core_regs {
>> >   #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET                      7
>> >   #define DWC2_SNPSID_DEVID_VER_2xx                   (0x4f542 << 12)
>> >   #define DWC2_SNPSID_DEVID_VER_3xx                   (0x4f543 << 12)
>> > +#define DWC2_SNPSID_DEVID_VER_4xx                    (0x4f544 << 12)
>> >   #define DWC2_SNPSID_DEVID_MASK                              (0xfffff=
 << 12)
>> >   #define DWC2_SNPSID_DEVID_OFFSET                    12
>>
>> Maybe it would be better/easier/futureproof to simply check if (snpsid &
>> 0xffff0 =3D=3D 0x4f540) ?
>
>
>
> --=20
> Greg Malysa
> Timesys Corporation
