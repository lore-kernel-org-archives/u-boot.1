Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB9FC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 09:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F427806D8;
	Fri,  9 May 2025 11:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hXWTNNtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582508210D; Fri,  9 May 2025 11:17:38 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579E98059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 11:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so304801666b.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746782256; x=1747387056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bbJrlLUQ6svsRNkgzM2jlafvPx8bClSRlXDsPrwb1Nc=;
 b=hXWTNNtbPkIED/E/yqYqc5Hp3vyrFGR69V6m3+KDQlKwvSJsWgzlDthSnjkU9Cfhbi
 JpxVpkVMsm6WUQrFFzZnC/OJIZlCbDNuDATYZEmyN4wxvIdRp9lglq67Xi4hcIGExI3v
 7B77WBQnlz2GVpIUtBhkaEBaOTeNMztpquXyRaZ+bPGgHPRQ1KGNDkAEzYTaYMNCd4zP
 BJ/HGTEsRbXc9zquBxZTHOrqL9eII7jQI9etW356187NG1gwf+MTVLVyd4FnPQHyFspf
 2YVPQYdDkkvJH38izQ537nQcYDaOYPnkBpQDtTbXPzenX61aJBS8Hmk7jwJHHKSxB4Op
 FCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746782256; x=1747387056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bbJrlLUQ6svsRNkgzM2jlafvPx8bClSRlXDsPrwb1Nc=;
 b=Oncn9QEIjAzIoK9SbwFawjzK17V5eLa9IKEhNnUNYIbWfroMDdZBqeNDy6OuVG8APT
 /0ur3rZymeDsmYKv1cuYZ3G1NtQXRQWWqCXkuLkvGuE7KNwEBhPCXFvspA7QSPwOzrD1
 e+BquQTyw1jERR9s3ZAtdVbfi3J6JzKkJOWAxyBBBu2I69Kp2Of/AzLg/IwqzP0iUzfr
 mSqhgWZ+fOxes8qmmelY+dVn6QzZhGCSs3NMrd9Ifzz405EHz3MB6eAJgS51Z+amG9b8
 0eu28gV75KnDTIdwdWvTeJ8Y7aJEjFUbZrn9EJM04J3y6mz0kKbiQGCROirLQsh1GoK9
 9Bnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSWwmtp8m8NwjbgBTFJ4RH5n3+sFWv1AhRq1ey5UFyvUSlOxduNOqkty7ausbtJGE0R0kVBoI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbk80pmKHDgRDMIpuX/Wjd0n0YjIBpB7Gk+LQ57bkDMObfi+i3
 g+Dw4U6KmtVksrhv14qjyzJCcisD9RUMA1ar1rzm5nQpiQNEefoZf75JGJrXkDooyUFgyDBSbAC
 AXg6KFp3fgBn/gd0FCnTZ+q50eMXE0KP1
X-Gm-Gg: ASbGncu8/AqwPOxvQCvVY/EKrR5pksxqPNrg8rcW615DaKgfL53WN4GxdXe62+9/PWS
 BGibjGDTDKXECGBnmZwfU8ZQC8tVAOLXpgMn1okrzQUW6/jLd0+SkumGLlzciPKxhdlYAzsZcK1
 vVwX0M8ihyyHi0bWmkgr4q6fEopN+nDA==
X-Google-Smtp-Source: AGHT+IHQuh99vrJvhJTLwK2LgGgSrub0rDyzUox5KYbb8cMg9mFjSDWKKRgmG3CSQjsc00YfVbmD94fQvzasWEmlOS4=
X-Received: by 2002:a17:907:3cd4:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ad218fa9075mr245025266b.33.1746782255461; Fri, 09 May 2025
 02:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
In-Reply-To: <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 14:47:18 +0530
X-Gm-Features: AX0GCFuDywG-8PbQ9fOy7CRtFOe40AueNo0ZsI_QbLQRlPPSaESCJ6UrsuUEgS8
Message-ID: <CANAwSgTOTCwUKcodWixXKQg4u3nvABrSidSb8iREsqVSaaVg3w@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>, 
 Wayne Schroeder <raz@chewies.net>
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

Hi Neil,

On Fri, 9 May 2025 at 13:27, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 09/05/2025 09:02, Anand Moon wrote:
> > Add conditional compilation for the usb5744_i2c_init() function based
> > on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >
> >    CC      net/net-common.o
> >    AR      net/built-in.o
> >    LDS     u-boot.lds
> >    LD      u-boot
> > aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function `usb5744_i2c_init':
> > /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined reference to `i2c_get_chip'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): undefined reference to `dm_i2c_write'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): undefined reference to `dm_i2c_write'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): undefined reference to `dm_i2c_write'
> > Segmentation fault (core dumped)
> > make: *** [Makefile:1824: u-boot] Error 139
> > make: *** Deleting file 'u-boot'
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   common/usb_onboard_hub.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > index 1242513c631..92e3f3a92c9 100644
> > --- a/common/usb_onboard_hub.c
> > +++ b/common/usb_onboard_hub.c
> > @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >       int (*init)(struct udevice *dev);
> >   };
> >
> > +#if CONFIG_IS_ENABLED(DM_I2C)
> >   static int usb5744_i2c_init(struct udevice *dev)
> >   {
> >       /*
> > @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >
> >       return 0;
> >   }
> > +#endif
> >
> >   int usb_onboard_hub_reset(struct udevice *dev)
> >   {
> > @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >   };
> >
> >   static const struct onboard_hub_data usb5744_data = {
> > +#if CONFIG_IS_ENABLED(DM_I2C)
> >       .init = usb5744_i2c_init,
> > +#endif
> >       .power_on_delay_us = 1000,
> >       .reset_us = 5,
> >   };
>
> I think you should completely disable usb5744_data in this case
>
Let me check this. I will update it in the next version.
> Neil

Thanks
-Anand
