Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D667EC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEC7817C4;
	Mon, 21 Apr 2025 12:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OD0DEmC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D9B8192A; Mon, 21 Apr 2025 12:15:50 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA24810F4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5f62ef3c383so4292879a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745230548; x=1745835348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NoKSxagCXaKL27gQsiHXe2LvPUy1lxiT3mVNrYnkc2Y=;
 b=OD0DEmC+tBKnERwsjR4PzW/oGHMOrREOcntsAww3yWAW6U0Q0ReSa120QXWkDXXC2J
 x27e0txazGidegAPwfUo+KX/vE4Igxulk6tREXJDtcCGfmSbXyR89St1yWAn/OZsB98+
 vH7uviolYWao9aUTFCwBrnunQlCBahY9aXy7f6CYv8rQVk0imXnZosqQ7cZHdpxm6SHK
 bh8xD67OoQHO4dh6xaCGSxqoqEbj3+JwHFpvJc7JMkiPlGBQxJihfCgbBXpNZWU6rsog
 gRAzV6nxQ8lNpP7x5B950Tb4TpRcKxxLQLn0Wv31w/8AjkVos1hd2a9OO8TaKGIh/p7T
 XoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230548; x=1745835348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NoKSxagCXaKL27gQsiHXe2LvPUy1lxiT3mVNrYnkc2Y=;
 b=YcPOWblE8v7pfs06blEBF+YUt65YlLiZ5TVwKvux6pZ1Rbnn6pvdEIn5a2wAMsocH3
 XogzcPoaRstifpg8Y40ZweVP+XRIZEhtYi8Vi30kIbn5/rzxRyB+srg9n6x4aYi5+oKw
 fxEPpqm91y9bbi0qqTJWqJNBJ1X3xuKybkEol1y8ObCUwbRNklnHi4IqKrnsBn8pU/b7
 bodfvd96FEEoDW+iS3BdQvxB+I+Y+u2dcWQ9S6h8kp/0SGg95eX9FgEz+5xFAoqi0QGU
 e2MRLE7AZth7n/BF182vOtcGsjHsuu5wbivw/nT9ErSnqK+g1otziB9vtWbcmaGSEYYx
 qF5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoysKWQzxyZh/ABbad8Z/Q2W6+yAChP2iVDffRlHBwq1MMMWVeg0o2iUYChD2pCLu+3XxtqHA=@lists.denx.de
X-Gm-Message-State: AOJu0YyVxn8egddGVc/Ijh2cLdKhk/emwylXt57jAGGfp58+AJ4FGgPX
 V2lWhih/WtnvIse4aRPkqd7PC/JWCIlrI0xS1dfG4VgPEReq7DvtuLmFYUMaUrPsrSaXbksnkly
 1vi6QF5zDJEN+Yl2RaphL+RdhX1c=
X-Gm-Gg: ASbGncucPWW0BhCGOc6lERkaCYqkxY2Px8I34dBaiP2DLEfkgMJ2TME7HuzO6tbx4wM
 fqnWRW3jte2GBj5Qszef6UbSHCxpOWKZNlE2AQUvtIUfiMT4DOK5rNSNlyivYbj7r9fMxt7F9OX
 UkBw0uYQfrz2TcDu0yHZPA82S458vS6c5+c7WGjEQ2NhmtvkI8Cg==
X-Google-Smtp-Source: AGHT+IGBKJUbsmvepLyUZqjpcknzNn7OMiYJY3oo+vy06itinW8iPpt+MynC89h1ctmreNgxjvM+hFvVUrZxJTVpoNU=
X-Received: by 2002:a05:6402:d0d:b0:5e7:b02b:5ae with SMTP id
 4fb4d7f45d1cf-5f62862889amr8349239a12.31.1745230547521; Mon, 21 Apr 2025
 03:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <3097333.a1USZiQ7eK@anvil>
 <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
In-Reply-To: <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:15:35 +0100
X-Gm-Features: ATxdqUGBlaSuGTGAlalfNVyaPnuUM995K5MI7ykhB52MAgV2lG7P1KqHTCv0SaQ
Message-ID: <CALeDE9OdFxZe+r29=KHaaE_wT3KOp9AAQy0WbgrNpEb0JYBtLw@mail.gmail.com>
Subject: Re: Unexpected RPi5 Behavior with Saved U-Boot Environment
To: Mauro Salvini <m.salvini@koansoftware.com>
Cc: Richard Weinberger <richard@sigma-star.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 upstream+uboot@sigma-star.at, Simon Graber <simon.graber@sigma-star.at>, 
 mbrugger@suse.com
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

Hi Mauro,

> > We recently started using U-Boot on various Raspberry Pi 5 boards
> > with different hardware configurations.
> >
> > While testing, Simon noticed unusual boot failures, such as the kernel
> > failing to boot with no output or U-Boot reporting:
> > "ERROR: Did not find a cmdline Flattened Device Tree."
> >
> > Today, I spent time investigating these issues. It appears that U-Boot
> > retrieves several variables from the Raspberry Pi firmware, with fdt_addr
> > being particularly important.
> > If the environment is saved, fdt_addr gets stored and takes precedence
> > over what the firmware provides to U-Boot.
> >
> > Interestingly, the RPi firmware seems to modify fdt_addr based on connected
> > hardware.  Our experiments showed that even attaching an RPi camera module
> > changes the computed fdt_addr and U-Boot reads from the wrong memory location.
> >
> > As a result, saving the environment, whether via the saveenv command in U-Boot
> > or fw_setenv in Linux, can lead to boot failures if the hardware configuration changes.
> >
> > Do you have any suggestions for mitigating this issue?
> > In my opinion, U-Boot should not override such critical variables.
> >
> > Thanks,
> > //richard
> >
>
> Hi Richard,
>
> could be related tho this [1]?
>
> I sent this patch some years ago but was never accepted in u-boot tree.
> But meta-rpi uses it in u-boot recipe [2].

After digging into this and a discussion with Tom we decided this is
the correct fix so I've pulled that patch in for 2025.07.

Thanks,
Peter

> Regards
>
> [1] https://lists.denx.de/pipermail/u-boot/2021-May/449609.html
> [2]
> https://github.com/agherzan/meta-raspberrypi/blob/master/recipes-bsp/u-boot/files/0001-rpi-always-set-fdt_addr-with-firmware-provided-FDT-address.patch
>
> --
> Mauro
