Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20D7C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035208887C;
	Thu, 13 Jun 2024 17:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fl7F+gak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A0688887; Thu, 13 Jun 2024 17:21:04 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD12D88245
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-797f2d8b408so78908285a.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718292061; x=1718896861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GX+AS5jlJwmfE9Tg9LSeDgvhvbMAbyKIo9ankx9PmbE=;
 b=Fl7F+gakaCzGWeIvZNQ02v3YMuSXQkhh5CWhZw+I/6QFPVVcJYIpfq3YZJo4uvOtgd
 lppZtmqH4AnRXmbWTN68c6QWIW/qX2p8hm9PDZST7nXSw2KFPgAEWZ+1XohZHM/atHbj
 5v0LeuyPGAcGAh3D1Y3HvXotG0QzJgpSvqivM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292061; x=1718896861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GX+AS5jlJwmfE9Tg9LSeDgvhvbMAbyKIo9ankx9PmbE=;
 b=AqakzM/UWZy5LNUg1XQGkkPnf5mLED4a60biC1lrO2nik6qtOlgfvSQF+NeTLyjOfE
 zxCkwXEGcVXRqvm/FZs6ucuya9dBlgG7IMge2atS5gwLp5IfPEpDV+708p+lSiqoQsej
 bOzBa6uXepH9PYuBiC4xKuSXn/JDm6wUbZMBK8XpYctdEz89EZYojO/L50zTwQ9+boDw
 mfk7DO2acMWwlEo1xEwiD+iBNwX3eO+zTekOLthu2CZzZainEataTwaPE5uOO0LIpgrF
 L3cMRfQ+td7hfkNeoixjmdw8lKxzghiy34xB5agNcBJacHdG7pI2qvBjGuTDgAiR75Rs
 Bzvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/Pv48sGDKULU5Y25H52LfRcnctuYwti93loMmfJBObG8jRECH0JorE7oVqY73+SOZzEmfUsrERpGROpGVk0kd3ihJQ==
X-Gm-Message-State: AOJu0YzAVLEWX6OA4n1mMbndDxMRFQYKRUOs6bM2/upSgWRUtsHtlngX
 K9CByciMwksXVcuPFDCPbgMdmi4prLrLM9nX7WCqT2vLpyLbka39iFXTh+5fH6KYFKQ+ahErwnl
 2FnLE9gLW/3ps65cNloFwdQaKm+Y6z/eV+jy3
X-Google-Smtp-Source: AGHT+IHQwaVgLbnegbvu8+hEQ9CLlLaQs+kFsdyrCeoG98/Q7pi0F154sLBV61/pk4dVZ511BVl9sYrYsIi1CTRTudU=
X-Received: by 2002:a05:6214:5c4a:b0:6b0:8e1d:f71a with SMTP id
 6a1803df08f44-6b1a731b496mr45790266d6.50.1718292061548; Thu, 13 Jun 2024
 08:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 09:20:50 -0600
Message-ID: <CAFLszTixnbwk-4mEnGZDmnyf2ApFmU6S8b6wCPHWwkKNKEq9+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
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

On Thu, 13 Jun 2024 at 04:13, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> The only way to configure the load addresses for both bootimg and
> vendor_bootimg is by using the "abootimg" command.
> If we want to use the C API, there is no equivalent.
>
> Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
> specify the load address from C.
>
> This can be useful for implementing an Android bootmethod.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  cmd/abootimg.c  | 10 ++++++++++
>  include/image.h | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
