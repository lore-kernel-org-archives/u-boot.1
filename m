Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F62C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 07:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10ED87DCA;
	Thu, 25 Apr 2024 09:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tvhgn/Ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B75C88E6A; Thu, 25 Apr 2024 09:50:10 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C097187DCA
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 09:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-343d2b20c4bso484088f8f.2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714031407; x=1714636207;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdF7oMtuGYpu6Iwo1kK8CkKrbFQQQHscwVY9uGvh8Is=;
 b=tvhgn/AiCpt4VHdTR/JzWr/eCDsthVgGfhVujaH1CcwhLzr/1MOOmjS0Od9pPBcAQT
 oyux1LLUmkqJNRGaKWUHpni4zR4creuNHNOYR5lwxdsIKYHfBN9AI0ahze6KtEXHLdJz
 FlcENEVf825GK4VXse5ToauTGJ+bQWoCaOSKGD5fbsSnm8H5YhS+bUnZ5yzHqqw2i+Yn
 E9c8v2VdzUfpdnIXsNprdlLPtRB/Il/aKUr/Dd6asHfHjE6QooRiVEKwcN0gZOHeDrJ/
 TEHGr0EATlZ21Ysc02vfRKlkqxObtNTQqAe8NqGGTmtR0kmC4AgSaFfcb9HbB8JGkNje
 ipKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714031407; x=1714636207;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdF7oMtuGYpu6Iwo1kK8CkKrbFQQQHscwVY9uGvh8Is=;
 b=gq0jhaLXuGyKkmVVFmSpybTUfhTqSTfepdTvjZ6YRQ9HKVGwKF2YcwLNEZ+woPbfv4
 JfwONXcXf9UQapZZaHKs2B51LmALAODGO9I9MyrUh5bGHs/o8Iz18Ccv9HOk1go15kS6
 PGHMjKVvJIjB1GnHVzuWpL4PB7UPxeKx5lseZ9ZI/s+qmBWhg/RWnhFaWZPpUUE6oGqZ
 nj1SEy7cDYKHMtNYciVMw+fIdDjtF8uzkuqFSUbjEWJj6PDA86OjlAh4O62t0X96w4q9
 pfaYJqn9cPwIAEwN53/9eOympxjFXP6vdPBWnXc8AavTCXMqYTVa0LkjGabXE04B14o1
 vSxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuH5uG5Z1NpsEoIhAFZJSQp99dLFppKwdbxzG2gHQUQIVGy+SwzShXE9uXR6blvCPa4uL1o6rQ8F0qGvIsJCTRFXd6uQ==
X-Gm-Message-State: AOJu0YwladSJLgKidQt2ZU9yoIKLRFPFBg8sMGNABlvhOGwwt1R1DW24
 U4tt7f2arFZxjXvG/8oqg2nKRcIBXEZn0StEB0LNu6jjSknlsKxYRZqb1plo0hY=
X-Google-Smtp-Source: AGHT+IEiI/Nq7+gt4NiuqfhuX95qWvNLeWpXBbjU3Ehofzhp9B+r2V01o8T2YPT4+SVIKoT5N2K5jg==
X-Received: by 2002:a5d:5cc5:0:b0:34b:b748:3dc2 with SMTP id
 cg5-20020a5d5cc5000000b0034bb7483dc2mr2381042wrb.0.1714031407050; 
 Thu, 25 Apr 2024 00:50:07 -0700 (PDT)
Received: from [192.168.2.65] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d6383000000b00341b451a31asm19014374wru.36.2024.04.25.00.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 00:50:06 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: marex@denx.de, trini@konsulko.com, Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: rogerq@kernel.org, u-boot@lists.denx.de, pawell@cadence.com, 
 peter.chen@kernel.org, srk@ti.com
In-Reply-To: <20240424073911.1943-1-r-gunasekaran@ti.com>
References: <20240424073911.1943-1-r-gunasekaran@ti.com>
Subject: Re: [PATCH v3] usb: cdns3: gadget.c: Set fast access bit
Message-Id: <171403140635.12883.13902832580631654142.b4-ty@baylibre.com>
Date: Thu, 25 Apr 2024 09:50:06 +0200
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

On Wed, 24 Apr 2024 13:09:11 +0530, Ravi Gunasekaran wrote:
> When the device port is in a low power state [U3/L2/Not Connected],
> accesses to usb device registers may take a long time. This could lead to
> potential core hang when the controller registers are accessed after the
> port is disabled by setting DEVDS field. Setting the fast register access
> bit ensures that the PHY clock is keeping up in active state.
> 
> Therefore, set fast access bit to ensure the accesses to device registers
> are quick even in low power states.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: cdns3: gadget.c: Set fast access bit
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3f831439c2dddcb84634195263e619d742e196a3

--
Mattijs
