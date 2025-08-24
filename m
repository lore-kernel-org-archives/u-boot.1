Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3AACA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 13:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A9B82AE1;
	Sun, 24 Aug 2025 15:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R4VE5X8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BF882C84; Sun, 24 Aug 2025 15:22:04 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24C7828A2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 15:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61a8c134533so7326785a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756041721; x=1756646521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C8op8Gjpxw3guQQmncnqdkXy6i2J2CKCB67E84QU4T0=;
 b=R4VE5X8E9mkg21ULrDfTiBPyHR7wpXtGr7nSChdIQkd2PmRgodskQ3HB1NcXFezoxo
 5Zokk65406yOOyZOAFYKSsfQbj1J+T6oyr0hXeKxuCg6LTC5bRM7Et2gqip8xJRFU3/6
 JBb2C+wWSKcyl9ZGn7UqITerNzR4VlS+8jQRJKaGu30EjvoUqqjOhpPmwT3/Yhv/ryWF
 ufUfmNDFgnSwo1qLW7KKxfDiuBMCOVGIXhJmAXPrVjr0Ppp7RH+N7LSPNNbimoZDQE/f
 EpofjNmWtyGqFpsg10c7YqdvldgW6wRNVPF5rqybeoVjpZ34TNIpOMnYlafWJlyAXQOL
 lHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756041721; x=1756646521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8op8Gjpxw3guQQmncnqdkXy6i2J2CKCB67E84QU4T0=;
 b=BwFZrIPE3Qp88jlUU3Ym4ISeYUUUPVP5NLAbpX0jjz/zImfbdciW3NdgRn0gzHabmS
 z0iQm7BpGfvQXLqDWHKy1u9W98PcSW99v7YMhZ2f0NKKJeEH5eX8Whe5XoZn3LyIs9ld
 u3qQe2jZDmBXGLE30XoIPFqLk2phQA3hU7iHSXKdDGsoPbHoZY+SKYodlphHGdGxrj7A
 KfI8bFteMjnLSWkSJM4sAxW0Jl3mQZL+MH6c/vbjCTiNxQ9PSzU/MkMTZlfGZ+TCQDp3
 eREV1d8Ept82HVi+0joCQq4Taz82wadWv8C9UQmV8UyK6rICBlwmPG3xQ7McsrQdkE55
 WFFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ/bqSDC5fwgWthTJ5G+VtDt4WwP5Y8+eAa1bt8+918ufeOXPl2vT6Pn4LPaO+ZAc0qe89eBg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1PaKVY7NQQFu4reRhKV7hLa10pIEiTiaZC3uYVF6XeUDN1L81
 Krf9o87SKgpid65YWDCsRzs703Iy8okJ6aLT2UT3EJm5SMELqvaH9ai6d3ZQ057l9z2wZyfPxeJ
 YrtytcrR1yFl5lrbp0sh4VzP0aGBMEfI=
X-Gm-Gg: ASbGncvAnKyb95hs3hQVgOU4K4NmnxPo7sP/RK0Pqdm4XA6ITwKSEfbuN0eZd1QZ59Q
 FOXPwjvwX3xVZx5VyNcoKjZArqnPu3h0spRVv0UOPwRDeSGxrF0dYucOIMuXQhA0Spq+zvABiiF
 OH/uoAFue+bcCpBzaQUvKKfnzU3uOMdgGaVb36/H2LVrQrR57d+zSZ7gTDcoriQXm+UNSeV4dfb
 3rFXA==
X-Google-Smtp-Source: AGHT+IEEAkUjbIy3WGH1N0cEReiPOAEg/yGyd1mNtEAUk0WtFmGndBjpdOQMZPSQKj9JO2Im6f8hWsEkvy7noeGqBEQ=
X-Received: by 2002:a05:6402:a0cb:b0:61a:967f:55f9 with SMTP id
 4fb4d7f45d1cf-61c1b492cb4mr7904405a12.10.1756041720936; Sun, 24 Aug 2025
 06:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 18:51:44 +0530
X-Gm-Features: Ac12FXzofBUSfcR_V1AXJVED7KPcyyaZCjI39Z7UUp_0LJmYQr0CXR2RxLKN-QE
Message-ID: <CANAwSgSC4Af-kO9sFjd9Xugh4SxBmC_cvLhAK=xX7kQvk4avTw@mail.gmail.com>
Subject: Re: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Sam

On Thu, 7 Aug 2025 at 03:57, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> The E850-96 board has a LAN9514 chip which acts as a USB hub and
> Ethernet controller. It's connected to the SoC via USB lines. In order
> to make this chip functional the USB controller in Exynos850 SoC has to
> be configured in the host role, and the corresponding power regulator
> has to be enabled as well.
>
> This patch series enables USB host and network support on the E850-96 by
> making use of the LAN9514 chip. While at it, enable all power regulators
> (LDO) in the PMIC chip which can be useful in the bootloader and kernel,
> including the regulator used for LAN9514.
>
> Sam Protsenko (10):
>   usb: host: dwc3-of-simple: Add exynos850 compatible
>   board: samsung: e850-96: Set ethaddr
>   board: samsung: e850-96: Add ACPM code
>   board: samsung: e850-96: Add PMIC code
>   board: samsung: e850-96: Configure PMIC regulators
>   board: samsung: e850-96: Extract device info from fw loading code
>   board: samsung: e850-96: Add bootdev var to choose boot device
>   configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
>   configs: e850-96: Enable USB host support
>   configs: e850-96: Enable Ethernet
>
>  board/samsung/e850-96/Makefile    |   2 +-
>  board/samsung/e850-96/acpm.c      | 169 ++++++++++++++++++++++++++++++
>  board/samsung/e850-96/acpm.h      |  27 +++++
>  board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
>  board/samsung/e850-96/e850-96.env |   2 +-
>  board/samsung/e850-96/fw.c        |  45 ++++----
>  board/samsung/e850-96/fw.h        |   4 +-
>  board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
>  board/samsung/e850-96/pmic.h      |  14 +++
>  configs/e850-96_defconfig         |  10 +-
>  drivers/usb/host/dwc3-of-simple.c |   1 +
>  11 files changed, 482 insertions(+), 33 deletions(-)
>  create mode 100644 board/samsung/e850-96/acpm.c
>  create mode 100644 board/samsung/e850-96/acpm.h
>  create mode 100644 board/samsung/e850-96/pmic.c
>  create mode 100644 board/samsung/e850-96/pmic.h
>
Can you move pmic to drivers/power/pmic/ ?

Thanks
-Anand
