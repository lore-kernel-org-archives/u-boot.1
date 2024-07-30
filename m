Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58193C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 08:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7A988747;
	Tue, 30 Jul 2024 10:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zn9pR2U+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A98A887BF; Tue, 30 Jul 2024 10:21:13 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A32588746
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 10:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so15752405e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722327671; x=1722932471;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t3dh8gK/0XMUwDNpVVwc6lUsplJPDmkD9QuuTNvq6sg=;
 b=Zn9pR2U+tAEZZn7z4MB2zgxM1Y/BGhgQAV89xpvteTCdJzIpNvoqBPE2ScfG9nTX5s
 H3ESQVlHLzL4tvSUFjbgK9ZzX1m4aH+lBF/XGxPWVwBfp0mOyF9iiXKdrSHhaouOGQ16
 xUX7zxORsmOvVkwfF2cpKoHhJv9v3NXIaVSnLMTYXlBsCrws1gDjY81qkEXsAMLelp8m
 P8AROTYSInJDtHD4yscOHWo4fna3YrsziLtNnlqBVMOO7FtPQ/hbWMVTHppQPjMSNQO5
 ju7wRWdvzxqlX1djbOKcqOwHLMKKon/QsdbD64em5cykSpvxF914h8MkaBTLKHMZMYDS
 aHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722327671; x=1722932471;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3dh8gK/0XMUwDNpVVwc6lUsplJPDmkD9QuuTNvq6sg=;
 b=dEPaGAGjy08vQpCN91bHeTLqpqwEFUDIfedQUmDyvlXU3mzZHre8WQFoROUFnrz4YV
 5VUNj4IPEbAV0s5wEHgeBKPXYp0sn6Nk16jNyXsjVx4eKEcnczppmcK8CfBJsAZ8e/ER
 shocEeknxUZdhrfPRkQIC6IcuF+rDxy/TOg4K9cVERhORLP4iP4+9ftxqh5nPls7VRZ/
 ZfRZl/k8Zpm8sTee4fs6HArCfbVWKxJBIB9J8xCJ7S0c1MnwH86ZL7KAPX5PonnHFAbT
 YzCeISAgyojbVHSUhZaJNyL1ev2L9zdHCR8QTHnu+kakUr8Q38XFDDpsSLMc9nTpQj0z
 j7ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeTSN/DUjjKekrOvl3TVzThOtLfEHGYfUIw2+WVmo5d0xNVJV5chS9h1PilCYslD+mGAGGqytc/9JlWbr9XaTJ/gCdRg==
X-Gm-Message-State: AOJu0Yz1PtZCO1thxtlK3b9yTvAGbIB4VjAThHhAkwHF9BtAdGK14RsR
 yrt0w46fkd/efUMZXwvFXVFCR7VTrvJBTVDOCrlC6TuXHCjNxCPyIic2N2dDoes=
X-Google-Smtp-Source: AGHT+IFM3XadEQ+3jQbJIWgGV7822lnnOdpuGttflk8qnHM3UmlWB67cv+USS9x7OTI7ASvZfJDJFA==
X-Received: by 2002:a05:600c:3d94:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-4282442de6emr7482785e9.16.1722327670485; 
 Tue, 30 Jul 2024 01:21:10 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281fd619b6sm43018155e9.12.2024.07.30.01.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 01:21:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>
Cc: igor.opaniuk@gmail.com, semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com,
 avromanov@salutedevices.com, u-boot@lists.denx.de,
 kernel@salutedevices.com, rockosov@gmail.com
Subject: Re: [PATCH v1 3/4] test/py: introduce test for ab_dump command
In-Reply-To: <20240729143926.tc6su3jp5jmvc3xl@CAB-WSD-L081021>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-4-ddrokosov@salutedevices.com>
 <CAFLszTgU_NtS9bM1WXw0RLiZNJHvrBUEr7ujkUsELw0PxHPZkg@mail.gmail.com>
 <20240729143926.tc6su3jp5jmvc3xl@CAB-WSD-L081021>
Date: Tue, 30 Jul 2024 10:21:07 +0200
Message-ID: <87bk2fqoi4.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for the patch.

On lun., juil. 29, 2024 at 17:39, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Hello Simon,
>
> On Sun, Jul 28, 2024 at 01:36:05PM -0600, Simon Glass wrote:
>> Hi Dmitry,
>> 
>> On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
>> <ddrokosov@salutedevices.com> wrote:
>> >
>> > The ab_dump command allows you to display ABC data directly on the
>> > U-Boot console. During an A/B test execution, this test verifies the
>> > accuracy of each field within the ABC data.
>> >
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > ---
>> >  test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
>> >  1 file changed, 23 insertions(+)
>> 
>> This looks good but please use lower-case hex.
>
> Thank you for the quick review!
>
> I will change it to lower-case hex in the next version.

With Simon's suggestion addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> -- 
> Thank you,
> Dmitry
