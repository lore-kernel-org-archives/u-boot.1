Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D154DC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 13:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6128843A;
	Tue, 20 Aug 2024 15:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DIQqRQm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE1B885FA; Tue, 20 Aug 2024 15:01:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F64883C3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 15:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sahaj.sarup@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428243f928cso43987585e9.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724158876; x=1724763676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mQUsGX+I7WyMFzwPWcbLTOywd6S9tIYfMSIh+4/TwLA=;
 b=DIQqRQm5FYmjevOVOJSMee9yTph359cW/dUWck6hSnarDUm7l7Cx0wxQMqLAGrMRP5
 9WwAmfHvOxTZ4clDClLTE3SwfJXTOfZIE36jBbeMg5fOJU2z1SA6tsu4fQdtYhnes8Ft
 UN2/gmdgllowKAVAIL+3rWKWxGBHcxlVhpxIlufmY1SM3JAdzx0RPdjhYlb7NGWklan5
 zUb7cgOYnO7F05nUb87b47HHYXDU1NHrfQwyjIvRPgzbfLE2iryCgzDae/k1ItNQ0tUu
 GETYczPwKg6xx1is0IqnVYbfest1kuITbhxBwxGK1s1cZkp+ru97OqrSl9VO1zsA/PhW
 4dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724158876; x=1724763676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQUsGX+I7WyMFzwPWcbLTOywd6S9tIYfMSIh+4/TwLA=;
 b=YkJR//AhHyAvNSmHFoTbFe15BtaqyLdb/LSaFLB2Qvj9kakrm3NORa70iYwqg/ZJVf
 Zi0IuSxCC64bViQ+z+8Rt1kxr6/7mXE4efQEswm0CzUZLCdY54UNQeeJHnpC+4w1j1gl
 TpQlzwCTWqpynMQ4rA2sRqYqvx4xRSeyOfcxWkaDdPAgrwg1AUOWgp7LsjRo7aFxt6VU
 D8aaIhIzHXwx7BiLPHL/N5FXQTGf/MLRkuC12idz/XEM6r4CU4bFaWr06zpPhCaSD541
 Kdb5GBUsDwKG8axie75BC88aVOgJcSqBNU4CQ/OTK+zyqHkL+jppDtA8W2FZBWz5Tcse
 uM6A==
X-Gm-Message-State: AOJu0YxeMdcN7unHQfhptbK2UCwBfpyG25cGZtwQi/4gnjbKrCiQIH3/
 S7IJLQGrZ6PLy7fMBUhYaeylIVahmx/JGTitKGqpO+9K11EBff4nAkjLEek+4InFwrHN9iMCRkV
 ct06Tt0Yoa1rKJOj6VJgqXey08GSHGmIDRFNJzA==
X-Google-Smtp-Source: AGHT+IH5u5dTqkvQF11Ee++TMv9ArK6H2SCxYznLUtie7UfE2u4ZiKp6A31Ae8zGt6nfyHzGbtTqnnV6P/SpgnPGN9U=
X-Received: by 2002:a5d:6449:0:b0:367:326b:f257 with SMTP id
 ffacd0b85a97d-3719465dde4mr8267783f8f.33.1724158875461; Tue, 20 Aug 2024
 06:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
 <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
In-Reply-To: <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
From: Sahaj Sarup <sahaj.sarup@linaro.org>
Date: Tue, 20 Aug 2024 18:31:04 +0530
Message-ID: <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
Subject: Re: clarifying i2c_get_chip_for_busnum()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 20 Aug 2024 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi,
>
> On 8/20/24 11:12 AM, Sahaj Sarup wrote:
> > [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi,
> >
> > In `include/i2c.h` , the udevice pointer and return value definition
> > seems to be confusing.
> >
> > ```
> > /**
> >   * i2c_get_chip_for_busnum() - get a device to use to access a chip on
> > .
> > .
> > .
> >   * @devp: Returns pointer to new device if found or -ENODEV if not
> >   * found
> >   */
> > ```
> >
> > Should this instead be:
> >
> > ```
> >   * @devp:   Returns pointer to new device or NULL if not found
> >   * Return:  0 on success, -ENODEV on failure
> > ```
> >
>
> For the @devp part, seems like it as uclass_get_device_by_seq sets it to
> NULL and i2c_get_chip only modifies it when a device is found.
>
> For the return part... not sure. We don't overwrite the return value we
> get from functions we call, so not sure we can guarantee that only
> ENODEV will be returned?

make sense, devp can't return -ENODEV, ofc, and Return returns 0 or -ve.
So it can be closer to:

```
* @devp:   Returns pointer to new device or NULL if chip is not found
* Return:  0 on success, -ve on failure to find bus or chip
```

>
> Cheers,
> Quentin
