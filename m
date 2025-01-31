Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCE9C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 00:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BA180C96;
	Fri, 31 Jan 2025 01:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZP3YEckz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35E880EBD; Fri, 31 Jan 2025 01:10:17 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BFD809D0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso296756866b.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738282214; x=1738887014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LahOcgtmVmIr7twcLq4xPdWKJJCIKvQRF1CxKIO/J54=;
 b=ZP3YEckzhDQFaT/f8PTUWuO9dxgoKgttOq1/5Vg96q/OfPiolnOlSsrF7TTwbDJmL1
 9qlGBa0usBHR6EmXXNjt/SLDrRFEw1MU9bXDWVNJJhm9jX1C5DGT6azJTzimBQd8HDeL
 p5d7XZ4X8FSlRTPx/qYp5yUOV4aIkKgNulXD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282214; x=1738887014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LahOcgtmVmIr7twcLq4xPdWKJJCIKvQRF1CxKIO/J54=;
 b=nTwOtB11YUeAsXzC4vBDi5y9CveLM0b+pquHKMwn/sC1VYHqu1CErACJcaTuv1CUKx
 mSQQSL6Kf5zctYkCxDDibFH4ouEqfWqIFC4mcjFBVq2GohSl+VOjs3+LgKbNbboKl6jZ
 GRRIjN8S8cLUFH+042m17U8gs23S2IARmlg6JnrkRHbQDH/pm7WJ/q1F3OTy0Dgq81HK
 k8upZaV6BMl9JKMksmSe450A2iqhRop9kdm5wG7Owb/HP3ikTC0g3TuvX+Of8BoKQZPs
 iTHTfos3KM3X4EVP/o1335EWP0HYi2PglXmdb6/W7A9cVQygNXtSrebjp/V3OlKU4/xD
 h7RQ==
X-Gm-Message-State: AOJu0YwLnk/7bapYX6kOBSkWtbAFTJHqEdxcHCRYXpc9XhZ2vhoy4sy8
 YZEGrS/LzKiTI9pqqj7MLm2XKNB5/qv6vI1lzEeEl2KU+VJuMMCSZKqOAnk6sBsxHgOwUJHILmd
 OxI4rS86unbzPFJPd4al+jh03esJnJgf/VhBKZsPmR9xXYdo=
X-Gm-Gg: ASbGncvxMza8vFH5Fcdx5YagXzcfZmduRZ64GitQJlQJzdrz8Z7aVwizegOaMfO0qky
 F1UBldFHWdw2VzXHMgtTWJoO8ddXb67UqQ7zpiB6jSWeLoz6CEFujyzh+RsT1lRURmli2XMA/zw
 ==
X-Google-Smtp-Source: AGHT+IEzIySORljp+JpYfXEm3UG5lsk5GulznFiSE6RNwpLgakphTs5gvmI996Hmq7CxUUs/AO50sB4F/rxOuFHisqo=
X-Received: by 2002:a17:907:7207:b0:aa6:5e35:d730 with SMTP id
 a640c23a62f3a-ab6cfceb99emr764327466b.24.1738282214017; Thu, 30 Jan 2025
 16:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jan 2025 17:10:02 -0700
X-Gm-Features: AWEUYZlEMlQIDXkqyhNS04w_jVS00PMbv5bVrTkyb1Eievuk5nTrOHZAHltK_Ew
Message-ID: <CAFLszTjne3m6OCndx-CJ+jbiZ6Fv=my0rGJeEeBbeOYY-31==Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

-Ilias

On Mon, 6 Jan 2025 at 07:48, Simon Glass <sjg@chromium.org> wrote:
>
> This test was hamstrung in code review so this series is an attempt to
> complete the intended functionality:
>
> - Check memory allocations look correct
> - Check that exit-boot-services removes active-DMA devices
> - Check that the bootflow is still present after testapp finishes
>
> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> call the bootm function instead, with suitable modifications. That would
> allow bootstage to work too.
>
> This series is based on sjg/master since the EFI logging was rejected so
> far.
>
>
> Simon Glass (8):
>   sandbox: Make USB controller as having active DMA
>   efi_loader: Fix display of addresses in log
>   efi_loader: Return the memory map in pointer format
>   efi_loader: Correct bounce-buffer setup
>   efi_loader: Check memory allocations in bootflow_efi test()
>   efi_loader: Update testapp to get memory map correctly
>   efi_loader: Check that the bootflow is not removed by app
>   efi_loader: Test that active-DMA devices are removed
>
>  drivers/usb/host/usb-sandbox.c |  1 +
>  lib/efi_loader/efi_log.c       |  5 +--
>  lib/efi_loader/efi_memory.c    |  9 ++--
>  lib/efi_loader/testapp.c       | 37 ++++++++++++++++
>  test/boot/bootflow.c           | 78 +++++++++++++++++++++++++++++++++-
>  5 files changed, 122 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>

Series applied to sjg/master, thanks!
