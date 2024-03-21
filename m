Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93146C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EBB87BAF;
	Thu, 21 Mar 2024 10:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OyLIDl8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A03879F6; Thu, 21 Mar 2024 10:23:16 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BCB87DB8
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso362501f8f.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711012991; x=1711617791;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n54cOyFWTm6Iov6dnmeVSRskF1meDu2bJAEAe1l0bMk=;
 b=OyLIDl8LDuYc0L9OIq5ycCLNOMdcmQ+PFy2k6HWgKj5sdFyh4wRuxb5Sc7dXu2pO6C
 oo9T/VI7fbsgu9tcSdB7IJvUTrI898hyQvz4lDIucJZ94E831uDMJ3Vv0imUsEP8Uodz
 Oyb0ABHa3sRAmVM1XDnH+5uNfsLpo2EF5FRhM0EjL0SPPZ5ZYB2QKX17jfhy8XJ1jvIl
 0cylPmFnMD5uBXs9XU/uExc9DO835JfAkX/Pi8UpwNq408kgvMsdiZbGi90Lel8E9DgH
 +H4P0q3YgY0RMadtHEAuyvNavPZlPz9AlLjrF+gQd1LcX3Q8V9aWiVcJqEmelrPxJDGZ
 +l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711012991; x=1711617791;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n54cOyFWTm6Iov6dnmeVSRskF1meDu2bJAEAe1l0bMk=;
 b=uXt3SKnDq8Ozt7SKI0Kg6koZUxyBdpukUyuegDmHjSbOqAtagtXvStrtnMnJClsRGI
 g0cJg8SYt7bI2B1lNH0Bgtt5snL6EPVDfTbsZmPUCo5KNgc/7q6Zr7I58B752OM1mmqu
 sVeisY0PpQdoHgdND9FbgTftZ8E2S984q1zCBfzVQylYEJVuqfGR/fDlYBxcSr1IcoaE
 XrLv5xCOSo1NU5N30gFTAxuAAruUuEOL687lLjlcrF2cJqZX0yQWZWEr/z9waxead6gH
 dm9tByXuh/QiFkY0EeZvGONzDC4xnUjpMmerbmBjyBgW8ewKxnnCWN5QfiuHHDMy1Gm5
 c/2Q==
X-Gm-Message-State: AOJu0YyITwnQthJ0/hE/Z7vfG1LQRidTFY4pUpr9hBUpEP7uZddJoSB+
 O3TXTjQAugVOupKAoS4bMtXDRbMInpKOOWdvc8556p1QPqyTnhv3yrCvNpkKHSk=
X-Google-Smtp-Source: AGHT+IFPkR0E07V6CEv+RNk+lMajlHpbtT5oAo4x27vIE7HQkmMsNmfy6Ain+haoGrbXO9fqGmaltQ==
X-Received: by 2002:a5d:53c1:0:b0:33e:d7c1:a132 with SMTP id
 a1-20020a5d53c1000000b0033ed7c1a132mr9917434wrw.29.1711012991408; 
 Thu, 21 Mar 2024 02:23:11 -0700 (PDT)
Received: from [192.168.2.43] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a5d4704000000b0033e7603987dsm16728438wrq.12.2024.03.21.02.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 02:23:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
Subject: Re: [PATCH v4 0/5] Qualcomm DWC3 USB support
Message-Id: <171101299073.1017001.16411913317437946645.b4-ty@baylibre.com>
Date: Thu, 21 Mar 2024 10:23:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Wed, 20 Mar 2024 14:30:46 +0000, Caleb Connolly wrote:
> This series enables support for Qualcomm platforms in the DWC3 driver,
> adds support for arbitrary sector sizes to the USB mass storage gadget,
> and fixes an issue with the CDC ACM driver where it wouldn't initialise
> the USB device.
> 
> Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
> makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
> gadget mode.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] usb: dwc3-generic: implement Qualcomm wrapper
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/850b307789dca8dfff6d7cad57ba2ffbfbb5f6ed
[2/5] usb: dwc3: select DM_USB_GADGET
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/97d629372c8c58da96f46aa6d2bec09f120cc62d
[3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/86327b4e3201a55aefee2f1bfbbea9a7896461f0
[4/5] usb: gadget: UMS: support multiple sector sizes
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7e71eeb39f4c5280b1ce677f4a14063feaedff95
[5/5] iommu: qcom-smmu: fix debugging
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c9959ce7b54145a83d3797bcfb3c3713cb4a97ea

--
Mattijs
