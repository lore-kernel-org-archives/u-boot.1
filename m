Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F30C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2175B887E4;
	Sun, 28 Jul 2024 21:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kqAEN8Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19CA38877E; Sun, 28 Jul 2024 21:36:20 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D7387B1A
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7093efbade6so1517431a34.2
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195377; x=1722800177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cGp2wBk3QLvi0ImmIalBH66o29kEyH99oOnp0jsIY7s=;
 b=kqAEN8Fvm8AyiH5CZGNexYp8fq98YTESEft+uSdNh2aSqRM8j0Wcs1V2qX/fDJ+Mkm
 WNIigkmS+1e9uUW1x9WJETW3xKJSbAJ7x2ZF8aj6MSceW5tyNwutUCaZx5IZi+UGyWod
 wBGtQEx5SJIj35T3DLC6ta44r8NaYSRMMMSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195377; x=1722800177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cGp2wBk3QLvi0ImmIalBH66o29kEyH99oOnp0jsIY7s=;
 b=IRItPDj26JHVoJBy1Rp66d2MW3xZQt+hWEDUqkBO0N0ssQTj74n7R6V5Ko/hr5csJA
 B6vrkUZ5BSnC0Sx4qS9JvRXsS3LTp5XD+IgmiPuc+H7bybr+WIZQc13P6uFvj8h2svUl
 qcZTgyO2Oye8zgS30nvvXelma13ZBfOfIPFvcXzE6FfgQjfKc4wStXVve7kfGQFcEt8v
 0lDCVypdYaPksnBRWmy5VyCEF39xUsYC3rwHyDwfZZ02MAgCIrjZ8Zs+5zJH6d0jTax+
 yyfN6wergxf8BuibZmrMZbD4chCOWvx6+URC8UjP/fkCUNfvDTi8ILOtp/5CaF5i9TZF
 u24g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeRGQiuuK+B2VUDe7iXJqjM2/GKgAvwfG30LCb2jvN6L7VeJkI+zHS0GWtpqWO3oxfZ+RYKCLjTSkcgrGGC01t5PAFug==
X-Gm-Message-State: AOJu0Yxm1aSG24eG+t5jy2wbu40VeIXCir6yVQAO1+5DO/TxDJXDys0i
 fPPX+FNJ13HUFRU8ThYx42IPS2yTdjuyM09Y1lyMK5Aa9NhykTQu4SRrt7GJ0FrhX8pkong7hqL
 6wWilC35BLub3oozKshmnLZhXxluCovJ4G6jC
X-Google-Smtp-Source: AGHT+IGJ1iKS/HNwB2tlA+Kg0jSjvkfXUBYTb4FkJcLNjR1UGm/Es5i8bGrBR9qTx64CPQ+RxAeD6ZZb/pViozDJZHI=
X-Received: by 2002:a05:6830:3690:b0:709:4094:2a68 with SMTP id
 46e09a7af769-70940c7344amr7472990a34.30.1722195376671; Sun, 28 Jul 2024
 12:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-4-ddrokosov@salutedevices.com>
In-Reply-To: <20240725194716.32232-4-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:05 -0600
Message-ID: <CAFLszTgU_NtS9bM1WXw0RLiZNJHvrBUEr7ujkUsELw0PxHPZkg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] test/py: introduce test for ab_dump command
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

Hi Dmitry,

On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> The ab_dump command allows you to display ABC data directly on the
> U-Boot console. During an A/B test execution, this test verifies the
> accuracy of each field within the ABC data.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

This looks good but please use lower-case hex.

Regards,
Simon
