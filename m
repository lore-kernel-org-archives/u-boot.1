Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA29D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 05:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8364688BAC;
	Wed, 16 Oct 2024 07:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSx7lTtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E64C88B1F; Wed, 16 Oct 2024 07:05:44 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6485488B5D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 07:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5eb5ea185daso183238eaf.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 22:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729055141; x=1729659941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/uGN6V1Bjrvv7MHlEFg4e2xH9UVu/qMnPBsuzZOfklk=;
 b=OSx7lTtfCGaf5vZPhe3SB9rPG4WwqodcBs9dEQEt9ZLkBCplR5XkYx6gAEIkSP9O4F
 AkZkzuq5uPL/Uj+I+hC3hikUbWjaccsQ94MqD9HH+DOlOVIQhXRK05ndlIko0lKpwYgm
 vsiTuGM2XcYB/iaCTwnINvibxkJjSuG1R8pkMrf+W0nkg925nqTXaz0r2s7YiW4f8AxR
 TP6G5dHw2NMmjAUbh9AYQ+RWJPd92W6jbi4+d7aqM8UoICUZDsBwAshqghE0ats8MXRr
 mjexZ6zgx2Rnfkp6+k6MRgLhNH4CBQxVVp+JF71RLyOECDcLePsyI4FRz4H+zOIAXDz6
 OV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729055141; x=1729659941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uGN6V1Bjrvv7MHlEFg4e2xH9UVu/qMnPBsuzZOfklk=;
 b=IOD/vCIHRtJQl529K239pM9FmPZCq5MtQc082pD11kBf4X3byfpDMiQCliv/R7gLKD
 NjfcIqYlysYW+9Ut+rod3MqB4X6g+6XCsX9YDSsTFgeiw9LqsFkJMQe1x42pTwRPlxGP
 2W1v/5X+b70s9Q5hXl1ccAWt3tjqRrPYGjLPtqPLIG+8uILYw7EqsHF6v7BypyHKt2HB
 Ho5IoYgHqiL6iaLQSrbTh94ink43j0CPWeFDVOy0bDBkyOTFe7o1n/7SjvO+5LYqHLD7
 BaEkQw3W2O9LyvVRM9+wZV4YY7Tyb+QdFRUkJOIrBRXBrWzwxhAPP68pvoETrqZJnQBD
 SYoA==
X-Gm-Message-State: AOJu0Yz+gCP2n3g26ccO99Y8PrvHxjfLcdgg9SzBABx7AQumKAapt/OK
 GMEmQ8cVi6/k1FF3+1yupjfO1U0V5gmUipOotqMLW+TjUc9kyKRdAVCnVCJdTTmSWfrQYHM2tf3
 Spw5tYBt/EFBFAb33MFRJb60fN50fAw==
X-Google-Smtp-Source: AGHT+IH3ns6b7eIkC0pgpRN6FYbMYsADTonr4DniS9kE80Bslc2wdXWZujsaOuPeYrNAxCDjRzdvdY6b72BC6AOndIc=
X-Received: by 2002:a05:6870:1594:b0:268:9f88:18ef with SMTP id
 586e51a60fabf-288ede37d18mr2025964fac.13.1729055141098; Tue, 15 Oct 2024
 22:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
 <20241015183142.GQ53053@bill-the-cat>
In-Reply-To: <20241015183142.GQ53053@bill-the-cat>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 16 Oct 2024 10:35:24 +0530
Message-ID: <CANAwSgT0ng5R73D8jWS9MzeBJBcZT6vjgmade_d5Zoyuoe-C_A@mail.gmail.com>
Subject: Re: risc-v - efi_free_pool: illegal free
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
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

Hi Tom.

On Wed, 16 Oct 2024 at 00:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 16, 2024 at 12:00:01AM +0530, Anand Moon wrote:
>
> > Hi All,
> >
> > I am trying to create a RISC-V Archlinux image for the StarFive
> > VisionFive 2 v1.3B SBC.
> > Everything worked well initially, and I successfully until I upgraded
> > OpenSBI and U-Boot
> > to the latest versions.
>
> Sorry for the problems, this is known and will be fixed shortly.
>
Just wanted to submit a report.
> --
> Tom

I have tried to build a u-boot with tag v2024.10, it's a success.

Thanks
-Anand
