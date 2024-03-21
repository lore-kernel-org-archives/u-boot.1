Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2614FC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D74387F4A;
	Thu, 21 Mar 2024 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wbo65AKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690CD87F4A; Thu, 21 Mar 2024 15:47:23 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A72880BF
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41477b68cb5so1778495e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711032439; x=1711637239;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SbcJD/TBG4x+mmSRSJYO3nHLr4djFQtYubqL5g5//LA=;
 b=Wbo65AKKr+5XRP4NETFLZqwlBRrlVmh0W0OcFL/DKH7Np6MVKHYi1+LWEOPhClFV7N
 rmKKyv3wfo5S3BkHBcU9CJ6I4QXO3hvraTi/Ird+uJRMxowO7ucvhHcEUpv+9kVnXCP5
 2s6/nZpSUcbXAw6cBo4TSzWplJIqeIHY4+7jvJc+G+lD8dmyxxnIeFvxzuNMXvXEk4WM
 9S9L+NMzqnA9cbb9ynbiou0LsUA0C8Gd3+8WezdkI4+u4O6QUg+ngMQYXqdwfNIio0DN
 JikY4zl2F3ib/1hY++IR+tX1QRAjICpX6f67vIOwLmRroSExujBVLSC8r1hbWAQquljL
 7VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032439; x=1711637239;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SbcJD/TBG4x+mmSRSJYO3nHLr4djFQtYubqL5g5//LA=;
 b=ZiIdZiNFV1uwHZliJ78SmY2VEMebSaejfho5JuSy78tjR9yx1CrrZwMJBPjJxszdCb
 b6tyffctc75a4/dk6Ayj0akK6wyzMronEOlP5SGQX5n8684cwkdC2XYEV/qH3DkH7cx5
 ZWRfyxGwVrlh3AGFptOyeiT0oz+jqSj4yKoK7NwiBRjpZz/utv0u68H9GbKjy0vnxTte
 Wo/ehLw4q9Ikkr5skgo1S4FWRSUvvEEKkMJTysRAPqYXgh8xeNoVUGMHboF4i+Kq3i/O
 JmEtm7Ee60Z5eq3qr4qLgcT1MsqsFS7xpHM7WNuDqHfIGMOZiPEldJODacEX+6FDuIoV
 M25A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3I2WCogLwO9Z7K6cKY4Yu8+ZScncZl80dbDANwvd6ntm9NmqQJzxTp4fLJk6qnvYR/QoGPH2TgnorT4N+itBehbtMwA==
X-Gm-Message-State: AOJu0YzeTH+kwxpwj6NYNbmT7un1r1DsdoaAuJl70Cnx50zkjOjjmwUc
 Wu8hXNPD8zkEj90W45GNeTM91TXnAhNrAtu7MPFQP0+VBvE/JG9Q1DAILae4LFg=
X-Google-Smtp-Source: AGHT+IEG0VZWR/cYYN8htcK3HbAvE+Nxr6MdToOwzp7I5YRaX9KmymMXKjKUnGJfHaEMq62a2ntqFw==
X-Received: by 2002:a05:600c:3106:b0:414:7431:6983 with SMTP id
 g6-20020a05600c310600b0041474316983mr1493661wmo.25.1711032438605; 
 Thu, 21 Mar 2024 07:47:18 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b004146750314csm5862863wmq.3.2024.03.21.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:47:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/5] Qualcomm DWC3 USB support
In-Reply-To: <171101299073.1017001.16411913317437946645.b4-ty@baylibre.com>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
 <171101299073.1017001.16411913317437946645.b4-ty@baylibre.com>
Date: Thu, 21 Mar 2024 15:47:17 +0100
Message-ID: <87zfurvdze.fsf@baylibre.com>
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

Hi Caleb,

It seems CI got broken with this series.

Baseline CI (passed):
https://source.denx.de/u-boot/u-boot/-/pipelines/20006

With series applied (failed):
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/802278

It seems the change on UMS introduced some linking errors on arm32:

f_mass_storage.c:946:(.text.do_write.lto_priv.0+0x1de): undefined reference to `__aeabi_ldivmod'

Could you have a look, please?

Thank you.
Mattijs

On jeu., mars 21, 2024 at 10:23, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi,
>
> On Wed, 20 Mar 2024 14:30:46 +0000, Caleb Connolly wrote:
>> This series enables support for Qualcomm platforms in the DWC3 driver,
>> adds support for arbitrary sector sizes to the USB mass storage gadget,
>> and fixes an issue with the CDC ACM driver where it wouldn't initialise
>> the USB device.
>> 
>> Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
>> makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
>> gadget mode.
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/5] usb: dwc3-generic: implement Qualcomm wrapper
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/850b307789dca8dfff6d7cad57ba2ffbfbb5f6ed
> [2/5] usb: dwc3: select DM_USB_GADGET
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/97d629372c8c58da96f46aa6d2bec09f120cc62d
> [3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/86327b4e3201a55aefee2f1bfbbea9a7896461f0
> [4/5] usb: gadget: UMS: support multiple sector sizes
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7e71eeb39f4c5280b1ce677f4a14063feaedff95
> [5/5] iommu: qcom-smmu: fix debugging
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c9959ce7b54145a83d3797bcfb3c3713cb4a97ea
>
> --
> Mattijs
