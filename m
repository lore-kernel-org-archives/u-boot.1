Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548A2CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 16:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2F786F4F;
	Wed, 18 Oct 2023 18:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HCrCsuAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6213A86FDF; Wed, 18 Oct 2023 18:10:26 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559FC86FD8
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 18:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso14698464a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697645424; x=1698250224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=naym+WKaCGUs3y983SLTOMNF8R09HXOGGJTzcbc0lHY=;
 b=HCrCsuAFDVYBt1ZIfmXJ9o9gQZG2yQWWJuvttGdul6yjWnvo57Dx1uJRGi3OA7OO7d
 24fKurtqA+hnZgV7r+7k5JWunu2wc3MNLczo+n2tDXMtdHnXOKjoLDKABWXpjhsUbyuo
 G6i6LPVk9NK3ksO/bL/Anf5dS3OD3hBeTR6LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645424; x=1698250224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=naym+WKaCGUs3y983SLTOMNF8R09HXOGGJTzcbc0lHY=;
 b=GL1k/xRGjn6pOnI+xV6Lwqgqv/7UvmNaWh4/ctTkh2N3Tb4gz4Sqg3HtRvHp3KO5hg
 9Kbg13dTjLTytHMbL8s1949lXWWWxjuupnJ5t86P8E8i4jMM9vx3k2WRhiRq0DezSZl8
 IFJsOSqXUIfepEwGKvndvi9jc87mhFMyR89KdvHVAhp/a/o3QBzPq4Z+1NKHZXa29CRU
 qx8TK4PjC1GvE1rBKhCus0Os645MIyAUUR1uXLAWRlnU2QvTpazdHppKxh5IT3IQMQjq
 sDUQFAqmtmNTLMxnojSDlZs+np0bsvgup7QeErz3F+KDdTRumsvYtpnn6vK1UPpy6+5j
 wayw==
X-Gm-Message-State: AOJu0YzX1lFklWtBV6PG/6fRJEAqJCnrSXJ23QiFGJSG+hqs4SjDbIAd
 mGBhopw4g1UfP7gNRPH7parw9hhvspEbkdYj1h2crw==
X-Google-Smtp-Source: AGHT+IFTJZykgS2ZS3odoL0rQLilFMeZyGkYVAkZbs2W8bKCC1SEysysJbRqaE5/12yTfjqSAFwK5V+hfeo7JOT13sQ=
X-Received: by 2002:a05:6402:1485:b0:53e:1207:5b69 with SMTP id
 e5-20020a056402148500b0053e12075b69mr5091711edv.10.1697645423609; Wed, 18 Oct
 2023 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home>
 <ZS6ET7ExtDSCfsNN@eryximachos.home>
 <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
 <1ba8ea25-bad0-b66f-b189-67754c488103@denx.de>
 <ZS-6WM11jJnsaakJ@eryximachos.home>
In-Reply-To: <ZS-6WM11jJnsaakJ@eryximachos.home>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 09:10:13 -0700
Message-ID: <CAPnjgZ3bmVieVZpYGPbbGZFU-VF3FbGbAGGM8ekLKhOw=uYS1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
To: Philip Oberfichtner <pro@denx.de>
Cc: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Philip,

On Wed, 18 Oct 2023 at 05:00, Philip Oberfichtner <pro@denx.de> wrote:
>
> Hi Heiko,
>
> On Wed, Oct 18, 2023 at 06:31:57AM +0200, Heiko Schocher wrote:
> > [...]
> >
> > May Philip can use uclass_get_device_by_phandle and try a list of
> > possible UCLASS candidates, like UCLASS_RTC, UCLASS_I2C_EEPROM,
> > UCLASS_POWER,... and if found, check if parent is UCLASS_I2C...
> >
> > may not so expensive ...
>
> Looks more cheap and elegant than the other variants indeed. But I'm not
> sure if we can maintain generality using this approach.
>
> What if the specific I2C driver is not included in the build, because
> the devices "actual" functionality is not required?

Then the device will not be bound and the function will fail. There needs
to be a node and a bound device.

> Or what if a driver
> for the specific device does not even exist in U-Boot?
>
> Wouldn't the device fail to probe then?

The DT should specify the compatible string so the correct i2c driver is
used. If there isn't one,I believe it uses I2C_GENERIC but you'll need to
check it.

>
> Please correct me if I'm wrong, I'd give it a shot in that case.
> Otherwise I'll try it with the aforementioned
> device_find_global_by_ofnode() followed by device_bind_driver() using
> UCLASS_I2C_GENERIC (I hope that works).

That is the same approach, I think. But anyway I think Heiko knows more
about this than me.

Regards,
Simon
