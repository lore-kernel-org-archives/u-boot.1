Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001A3FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18F18448F;
	Sat, 25 Apr 2026 22:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXHo9N5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C008448C; Sat, 25 Apr 2026 20:31:48 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BB084445
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-94ac8cbf3feso5475512241.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777141905; cv=none;
 d=google.com; s=arc-20240605;
 b=h9jKrnQBgwayi1g+upOvnMBhKFLpdXACEZf0sM49cDSOsZRCAgBozXTT23pLqPexNI
 NLYfedvtJ8l4XD+Bys0kcOPhV2ra0FswXelWd1oRdw8P/LajJVskONqfuRao6iIMvNj7
 J7mGoSc9q4CgPIv36ZvujiSWGZ/nDwo4mLt+86WhiNEXn+AiaIRpkViBLhScE6DDhwB+
 gGJgmqQoEMA/jrvX0IJB/5wxVEYij0lRFvKTz2b/qtuMmWskVDw38ooIAgYHX1rzaREQ
 14QR3k4oeotKGZ6AbYUfZtOPXpCIiLIUIjiUlPCy7qJz4YI/sQQR46sqLzFQK+jbcc5F
 EazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=24wF2YsjSK8kuvrAvaUbUEpXv1CKLMy4ghGqNRldZoE=;
 fh=eLSUhR2Ax61GIWWx5e4U87paq733OmTwSj8TwAl7YI8=;
 b=OiWVSQYU79AbDkpFP8lBxKap9HBWvEBWBTSITiXuJyz7KbCPKNOtWZekoYQgoiM7Ji
 nRUtlpOQhKO349BC8tKN9eA4mbj99R73TO7+aEfgUENnypC3o8UiEwvYxqBfh3kclRbH
 nN9P5Yhw2MNrhMo4SrtOIMLglRl72cNW/hMmoOBxzJoqOG/zbwBiNXIpiKd8xbiwRska
 HTSjUhP9+KpiXo4plvMevlL74fYP3mBNpek5JnfzI8W3U0CfVDi0pKn2oYSp3D396v34
 IDIxrl+QPhnhf0RfiCa8U0LJZWiqbxQIem5LjZc2rYREfJoHjqT/gF3lYrS1gwncY2pB
 38qg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777141905; x=1777746705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24wF2YsjSK8kuvrAvaUbUEpXv1CKLMy4ghGqNRldZoE=;
 b=WXHo9N5+0lL/nM55neHOg2eRKSCztY0ChiuH0NhDa6niL9OEq1UaqsXshKHvwuBNY9
 qxVIaNlH+fYcS4hEMuhl2fgfML91+FLtflHugk9g+ofVfIUdLm7hgAyoU7EQLZYK0VK0
 +duZ07M1iRJgkeWLwXDSnEvO8Ycxb0MuNTd+lygl4d74x4OZT3UoLJws4HvPbdPl6nhd
 5kP8SqTd8sKlW8gJ2w7dLIxcnS3l4Nu48WKEf99/0nx7fEPR0U2gJvTl5eTs5EHBAHFB
 u/tOeRb3JxA0scmTeOtyI8I6JV7gNRZfaooYimsGTbmQtuzYxm8bYc3a5RuIS8L56OOj
 x8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141905; x=1777746705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24wF2YsjSK8kuvrAvaUbUEpXv1CKLMy4ghGqNRldZoE=;
 b=Z2519DPvaLX5vzlskHuorWnTNdTLtGn2bTpWQTgSi9yzqRWf9Qt1dRHLXblNedthJr
 RhMlzaPFaSqzWSGL3qIsYMtsx5hf5KV9UrMFx6ewJcIwz0QE50udnXfL3IE0Cz1yJgQM
 CMljLrtWR0nj+cjlj99N5dlB417/1ksGjUri2Ye+Qk5/3ia7VZHj1W3+AI4VXFuXc8SA
 iwjNp0m8W44+Na+CrXoPWPFrZAHRizOCPsadUSrblIB0nzpTcK8nZtfXjKcmI+X+ssyX
 7Ozuam7lspmz0bkVjYrVVJPoN+qLkHAHFoRbaxoE9dhlHkO3k2/H7P01XHdPYB/BH4j6
 58QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O+yen+3gXKPpSb2rpFmORu/2FMckZkGj1jhwz4yfuCIfwSnWWqY60wBBFLPSzijr3HUdfL9s=@lists.denx.de
X-Gm-Message-State: AOJu0YyG0v06PNblQC0SPZJg5Kax+/fo8ph7CCxEqO1pP7q9jzWgQhnP
 CFQGYReU7Iy6QSk19nC9YNfL15qSJbMwKf+flMm2chkhXL3Lut4aO4m/ljvBtNHRZIF1xPXvETT
 O1X9UWS3BcYjiFj5U25yc8+LyfCYRck+/xw==
X-Gm-Gg: AeBDiettgxFiOsQaf+WL+NopfE9mlc1U63pehQzyfpF3k+uuOg1MdyoikXtLvqlnSgw
 M/l7Kj0X+wwq3fz2NN2UPryATpiHS8T6AUwR1xwopSb1/elfiIyomvWXfUyjsLo/Q3LFOV1vDUA
 KDQjTTjjTc8kCDzVdu/MIq7akfp3uHxAGbMaznWR/YihSCoxqPNaPkI5gkO4lK3i/qFYBcxhdxn
 ZaKL3cVFcp9+FstAASRkH6CqLYGJQQeG2UmBeLV7K1MiVAiVfFgHViibNOR9mYp3N1VYQsDv9T1
 qk/3Rsg1GyZPfxZgb9I=
X-Received: by 2002:a05:6820:1793:b0:694:926b:551 with SMTP id
 006d021491bc7-694926b0c46mr7898499eaf.55.1776932108419; Thu, 23 Apr 2026
 01:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260422165938.35925-1-micbis.openwrt@gmail.com>
 <20260422165938.35925-3-micbis.openwrt@gmail.com>
 <4961ac43-a879-411d-a32e-7fe8d1c879e5@mailbox.org>
In-Reply-To: <4961ac43-a879-411d-a32e-7fe8d1c879e5@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Thu, 23 Apr 2026 10:14:56 +0200
X-Gm-Features: AQROBzB5LE-xVsQVjdTKqCLFkMpJI4whv53EuK1rRFir-cLprJlWBB48wJsT4tU
Message-ID: <CAP8xZ6kHDj8Osjmxtv++aVSXCg1iMs7QNAZf7UpRcG27ZeRatQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] usb: gadget: rcar: Add support for reset controller
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

On Thu, 23 Apr 2026 at 05:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/22/26 6:59 PM, Michele Bisogno wrote:
>
> [...]
>
> > -static int usbhs_probe(struct usbhs_priv *priv)
> > +static int usbhs_probe(struct usbhs_priv *priv, struct udevice *dev)
> >   {
> >       int ret;
> >
> > @@ -396,21 +400,28 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
> >   {
> >       struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
>
> [...]
>
> > -     ret = usbhs_probe(&priv->usbhs_priv);
> > +     ret = usbhs_probe(&priv->usbhs_priv, dev);
>
> It would be sufficient to pass dev to usbhs_probe().
>
> usbhs_probe() can extract the struct usbhs_priv *priv from it:
>
> "
> struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> struct usbhs_priv *priv = &priv->usbhs_priv;
> "

OK, actually I thought about that but I was unsure which one was best.

> >       if (ret < 0)
> >               goto err_phy;
> >
> > @@ -440,7 +451,7 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
> >   err_phy:
> >       generic_shutdown_phy(&priv->phy);
> >   err_clk:
> > -     clk_disable_bulk(&clk_bulk);
> > +     clk_disable_bulk(&priv->clk_bulk);
>
> Reset likely needs to be handled in this fail path too ?

OK.

Thanks for your review and suggestions!
