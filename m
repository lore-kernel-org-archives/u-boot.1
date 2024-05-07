Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FED6C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41738872D;
	Tue,  7 May 2024 09:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="1AwbR/Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBE388730; Tue,  7 May 2024 09:33:43 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C2F882C0
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61e0c2b5cd2so35478537b3.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715067219; x=1715672019;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=heM+oNbTqnXr2ePB0FUyXtKSVJAwJrTQdE0o+rt67xU=;
 b=1AwbR/DyWlPSv92GvyjSP8/Ii1Aq5oDur2CAQp+hT2Bw0lFRUc75pbiEqOeNlBeK12
 E+mFVfFPJJLJrLYkVq52HgUfqqtE9xz/e3fZs6AS4YD53FIodIUVeeDk7mhUqQPHgTY3
 21BtYMLvjRH8CLmf26amyPERN3zMUUbOUEg2Hp5LZ7Y9Darn4iu649a1oLelnPm+wRiT
 Jy7UMI/soYDH+y7f4soKBKJ1hl9ZmIX1riC0Ft2lzrR7EMY2h3GidS5VxxgUSXuue6g2
 kulR+50bse4n49PI2tqzeZX1HylvmzcQ5/wc7nEIMI7CelSAhLapiSDSHSwHYqHrM7zU
 UaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067219; x=1715672019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heM+oNbTqnXr2ePB0FUyXtKSVJAwJrTQdE0o+rt67xU=;
 b=ZMkP1SCo6f+rf287kjIqiBGAFIEWcTi/LJpDMczTQVdeVGbHyNCMhIrlh8WX67Oc7V
 HQtVhBAaOvQtFPr25oLf3/Ni9WBs57d72ksyV5hEAbx35CwOvJ/byT76BMlp1TnPAxnL
 Il6atNVUrWzA9Al0z2y2gqvCXMhPCV6eCay9Z87PDBy5Mm//dRZdv0WzObnYiswfbI3Q
 9ANZZxm+Jkc7/iaJwRqNx/vclkjEceTXyPoXTN3hwtAP1nD4/YQEw4VIkVwMe91/jE5o
 sST+Man0jVpgxu1rs/9nMlhfcZk2f1UA0q0GBt33b7JwFCo2MrNEsY8FZS2Osj5MyusR
 GE/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxWvs7milyycpQNxnAwpENYJrzj3tXlvqtFqVBYDXrN2+bU1KE1922h1NLD7xVEaPd098/bdh89GmZjaIsi0wuZ0neHw==
X-Gm-Message-State: AOJu0Yyt7swoUuO0wEd5DPUKeVVDjahae7JEFEWyRzZiUIp9JnYQLBwz
 aa+SwL9skvJl3+ARNwq2GvcSfzrGFJXjTSepX9NwElx4okkI0d32jBQ6d3xSzpXPJ0iPzF4Gis9
 OXBYQhDS4q4wnC50zDbuuw39XSvOfovcIFqlm
X-Google-Smtp-Source: AGHT+IE52QRl8BBOBg4MNypa2uEethI0FqdQNrEJoJLokiTS+FJumPK4TXx9TcUTff6AKEQbzB6uvy3Ktjo6HVDiMRo=
X-Received: by 2002:a0d:ea14:0:b0:614:74f6:df18 with SMTP id
 t20-20020a0dea14000000b0061474f6df18mr1074722ywe.26.1715067218102; Tue, 07
 May 2024 00:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
 <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
 <87r0f54qxo.fsf@baylibre.com>
 <CAAjXUaqYv1zTATXhU5GeOMpSCK-HMxvMW5_edbotZ8TUczcVMA@mail.gmail.com>
 <874jbs7dyn.fsf@baylibre.com> <c481eb6b-2e1a-4a98-a590-e51081e183ce@denx.de>
In-Reply-To: <c481eb6b-2e1a-4a98-a590-e51081e183ce@denx.de>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Tue, 7 May 2024 03:32:58 -0400
Message-ID: <CAAjXUap6BKwP4WfArPt7PgBoq-=5e751UpUYTtYybtD82DsmvA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
To: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 u-boot@lists.denx.de, Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>, 
 Tom Rini <trini@konsulko.com>
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

> >
> > If you have access to the hardware that has a 4.20a dwc2 controller,
> > maybe you can help testing the patch above patch as well?

My hardware unfortunately only has a 4.00a controller so I cannot test
the 4.20a reset functionality. However, Kongyang Liu's patch works for
me as a replacement for our submission and functions correctly
otherwise on our hardware, so I am fine with moving forward on his
patch. If that's meaningful enough I can add a tested by tag to the
other patch from me.

>
> +CC Liu on this thread, maybe it is best if the two of you figure out
> the best common approach that works for you both ?

I am also open to collaborating on any other changes as needed.
