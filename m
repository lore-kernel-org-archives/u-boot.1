Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67938CEF16B
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 12:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49F888C3D;
	Tue,  8 Oct 2024 14:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2HeDg5GH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2E988413; Tue,  8 Oct 2024 14:58:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DBF88C60
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 14:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so52313575e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728392322; x=1728997122;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=INVOyxuIjhUwsmO2R43X5p+2WKi13itdvbVplw4vil4=;
 b=2HeDg5GHHZ/F99P7KErrWrRbIkw5WeY36Juv2vAOTrkB/Do4CKSorfuqF1vVpvAyLI
 754oLwOexA3uyFkxcIOAa+OmgSVXp4dF43oFOoVYAYtZZE5yxqxvmDjXAM/U3EnaJKD6
 XOVlZAjw0EfNJSCSsRJYxC5WDXcHmh8zC/eeq7pDd2gchT2hqh+2XDYgVOuklO+Pyme4
 w1BDCujYByF+8rKvyHQUhIpxzkhPFQse5qib70TBtIIGdHcxcmOh8EFZTrDi8NDhvgDb
 OD23fwB4KUdFGiosWDsc4Ji0jPPtfmTO8lI2ij02vg4/4/XGL067JQkxGNfnU75qBT1q
 mUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728392322; x=1728997122;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INVOyxuIjhUwsmO2R43X5p+2WKi13itdvbVplw4vil4=;
 b=IFbLa3Sd2lw6u0M1wL1gvqCbSU/6Ynu9OSDp4SVJRWlTRVCF/fyTN4d2GQkuVRErbA
 TUuN1n4XqFh5Ugq8HzorH0kNk6oygnCcXimEjeNlcwVhJpaK8niAkYErwBjJs6ws8ZZ/
 gXM0i0nygVKQT1TqrqDz9bTiH3k4vnhSyMZhKQgJkbTx2abKIm1rNrvjacIVPfwzBhT8
 dW12nddmNg0lErrn1jdY0JP+/aAR30j5gmvofMEicy9zpypjrVX5QAr3Y+qw3Sux2EJX
 J/3zWXfYCw/p+jLCFvgYmSs0voWVjZdh+Ltogb0xn0H7bNhfhgkoSNWR16MWXLLWqnLY
 PP/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdNrFs4lpq5r4XrMp0AK+FjtaEZpQoBdHZCRT5RA9BtrB8eWJReeKfpYbXvfL6uBWCRqpTpII=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1Kx6lDqpSEnome+zscV57edx19YkvGVFgqJB0nGJSnDY/sgQ1
 KmjahkAphVt2ee08xqnJJKBzAgu7/QXnR9XkzSnrxEWzVBPZtn6RCFRe50bdxYo=
X-Google-Smtp-Source: AGHT+IHmjIv6g2tVnQk/gyt2XAMGhXUbvhAvRKBy2/qavJtAbnMV+eYqsKX0mgVSZLMzBjp2lvj65g==
X-Received: by 2002:a05:6000:10a:b0:37c:c4f8:5e06 with SMTP id
 ffacd0b85a97d-37d0e6f26ffmr9579571f8f.20.1728392322170; 
 Tue, 08 Oct 2024 05:58:42 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d169733c5sm8058908f8f.110.2024.10.08.05.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 05:58:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: bigunclemax@gmail.com
Cc: bigunclemax@gmail.com, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] eth: asix88179: drop ADVERTISE_LPACK and
 ADVERTISE_NPAGE advertise flags
In-Reply-To: <20240919135851.153120-1-bigunclemax@gmail.com>
References: <20240919135851.153120-1-bigunclemax@gmail.com>
Date: Tue, 08 Oct 2024 14:58:38 +0200
Message-ID: <87iku2g39d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Maksim,

Thank you for the patch and sorry for the review delay.

On jeu., sept. 19, 2024 at 16:58, bigunclemax@gmail.com wrote:

> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> Some USB-ETH adapters based on the AX88179 (ex. D-link DUB-2312)
> has link issue if ADVERTISE_NPAGE flag is set.

Do you see the issue only if ADVERTISE_NPAGE is set? What about
ADVERTISE_LPACK ?

Could you detail a bit what you mean by link issue?

>
> Also Linux drivers for ASIX chips doesn't use these flags.

I've double checked this looking on master,
commit 87d6aab2389e ("Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")

I inspected asix_devices.c and ax88179_178a.c and I could indeed not
find anything related to ADVERTISE_LPACK and ADVERTISE_NPAGE.

I'm not super knowledgeable on network so I'd like someone else to test
this as well, if possible.

>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/usb/eth/asix88179.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 4bd3b9d10d..1f469a1a7d 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -345,8 +345,8 @@ static int asix_basic_reset(struct ueth_data *dev,
>  	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
>  
>  	u16 adv = 0;
> -	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_LPACK |
> -	      ADVERTISE_NPAGE | ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP;
> +	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_PAUSE_ASYM |
> +	      ADVERTISE_PAUSE_CAP;
>  	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_ADVERTISE, 2, &adv);
>  
>  	adv = ADVERTISE_1000FULL;
> -- 
> 2.45.2
