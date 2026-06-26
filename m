Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1CFCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42D68460E;
	Fri, 26 Jun 2026 12:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WvXrxbFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F3E8495B; Fri, 26 Jun 2026 12:37:48 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C938404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so1732707a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470265; cv=none;
 d=google.com; s=arc-20260327;
 b=WQKbgEdz7s1Ll82EsQEDyHWANITWw86NCbeIjdDwlYdkCMFpLa/msPT/Ic1JuRfE8w
 a67Yh3UmVCLw8KRRQSuJ+Ws1m4up7c1OC8TwfFj3TZ2xb4x+NRkbi/oU5gX3N2ftthaV
 JCrRaSvyjTBZ7cWzBBgsAI6ToDPA+lfrr1yOoxGULBhaRR3Wp1q7z3HiafSGyOBw0fs4
 J6c+5BpIy6WOOgGSRs2QyZQvXnfFlGV4xA7k/dJQJ3YC8Vruto5Ld8XI3HR19jicZ0Uq
 F2tkPebYBbZApdbXXYoTIz26Psv77wXplyegOtIdi3fvec1iOSLJyWwpHChD5yU4+ifj
 dcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bHYtblKt8dkCtFBtAIkxLRyI4bgUCCu13EuFoC0sR3w=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=dJsE94t6/hZ8AoGhuk3o8H4ls7hycI8uTyhE/dY3bJukTz1025e3jA49TDtx5GuU7c
 qG0vLo9NlW2Wu3jGqYauxtCuWouORCCS7PIScinxwIBiCvBibM8KrqTbcnKfmgX4QfQF
 Z8Ps44tmwg+NBIC3CmkCrQHF/5S4fGWD5W84f/0KdD3aAMr5licEG2UEXZ3bt7pgek2y
 jwgdxKCcPqdL8neqOhxoQGFgHKfsH9FkKlHWk/8fsqmAZFgmxL1Urokz+IUKZfDJwc1q
 s+ZWFYfq3mBYLW1yNkZG9zZK2VBf/5xg5huvvc5+3SlFCMoJndIByYQjvVhblLp/CUnu
 KvEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470265; x=1783075065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bHYtblKt8dkCtFBtAIkxLRyI4bgUCCu13EuFoC0sR3w=;
 b=WvXrxbFdINRKHEeiYcVFiwVlk0OnC/A3bJlh950GpQlSsu/2wb3ofyal+mtm1QpKk8
 TDF+3i9Gjim/7aRx92TenR6N7Jpt1gk4nUAOsRPoyhpl/FCCYDqhCPpnqJ1RJq3Y3A9M
 vUfVNRdwN+wE2LpxFOrJkwC5BLasoX77INCNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470265; x=1783075065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHYtblKt8dkCtFBtAIkxLRyI4bgUCCu13EuFoC0sR3w=;
 b=QqAvdlWtrJqLSJjrHKbstpVSWKQhqvXLFXAXIwEW23+AXr45vuMJiaZYBZlQd3k+vG
 KRdD00vuqheJXCEkDv7mw7lTb6Q5APl9jpg+UKgVLcz9Tq2p1El19BWBY6N5bTOCEeVi
 C1iMWqvuKEPZdsykA3osCHIvYNuUZePWxE0VB2sdG+c9rqXcaVrjfKD4rYWua+sbOGy2
 U6pnQRKsTgYakGHuqY3V7I85ugx9/p4ZS3kKs54fK8uLYYl/PFhZlOOfryYGIJvtVp6/
 qLZlEELy9AjQ/OGXa+d0B5Jvzy/jeF6kG28gBZ0T26xa+E3fQ9MuNHDlgposKaoFH/el
 uuFg==
X-Gm-Message-State: AOJu0Yyc0UG/s4mW3GmEh/mWYMNnj8SxL/oKM9UIcBHgiQr+hOrA54Ei
 bDR5qcitYZu08gj7rvdQkkPTPOK4EBYs29ydhx6y6NjH9DbxWQsLx8KS4cmBWCuiKmT+aK5hSpg
 b6Tr8BT+Rb2s1EyyXEFyECk6YxtnpoujVAsQm2zrd
X-Gm-Gg: AfdE7cm0Ch76F+hdmCE18BQp8z7Qe2LbBebuO1ByuK+iKLdHJWRPsSbsYXI+u3uylq3
 N5FPwWQmQxxat3Dp8u6wM0FVwGdDSXQMoG3sV0Jqeanni6WvNUtIFcVj7FcCZO5PW4a5V9b4uu0
 xRv6uGJQTuCS8gqasBVLd4yVz9/SwPxrrOZfUL3pHADKKwGIlvNkj3Ab10NVIQqMmceJp/Zyczq
 gOoNHMq0Wie/nMvaw5DEmbC5emWz54BiRgzHpwStNWQn3rmpTnpMCk1wES6ucvgs5nHXz1Jwg==
X-Received: by 2002:a05:6402:4314:b0:697:8365:7e63 with SMTP id
 4fb4d7f45d1cf-69810a5cdebmr1851898a12.7.1782470265505; Fri, 26 Jun 2026
 03:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-1-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-1-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:37:33 +0100
X-Gm-Features: AVVi8CdYS-aUElTBHxu6KcFi4gNdTxIs1Kx6OOSF0B1mauJ5HHR0P1lySMV1y4o
Message-ID: <CAFLszThipuAATAXxnAtxK83fLT-xeCxUXCL_qG2FVAvOVViMKg@mail.gmail.com>
Subject: Re: [PATCH 01/11] button: qcom-pmic: introduce exported setup method
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

Hi Sam,

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> button: qcom-pmic: introduce exported setup method
>
> The qcom_pwrkey driver is currently binding to both the individual
> pwrkey/resin nodes, as well as the parent pon node.
>
> In the next commit, a new glue driver will be introduced for pm8916_pon,
> which will continue binding these buttons, as well as additional
> drivers.
>
> button_qcom_pmic_bind was renamed to button_qcom_pmic_setup and exported
> in a shared header, which the new pm8916_pon driver will call.
>
> Signed-off-by: Sam Day <me@samcday.com>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> drivers/button/button-qcom-pmic.c |  6 +++---
>  include/button/qcom-pmic.h        | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)

> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> @@ -13,9 +13,9 @@
>  #include <power/pmic.h>
> -#include <spmi/spmi.h>
>  #include <linux/bitops.h>
>  #include <time.h>
> +#include 'button/qcom-pmic.h'

Please use angle brackets - this header lives under include/ and is on
the standard search path, so #include <button/qcom-pmic.h>. The same
applies to the include in drivers/misc/pm8916_pon.c (and pm8916_pon.h
itself in a later patch). Quoted includes are reserved for headers
found relative to the .c file. Also check the order (button/ comes
before power/)

> diff --git a/include/button/qcom-pmic.h b/include/button/qcom-pmic.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include <dm/device.h>
> +#include <linux/errno.h>

Missing the usual #ifndef __BUTTON_QCOM_PMIC_H / #define / #endif
guard. The pm8916_pon.h added later in the series has one - please
match that style.

> diff --git a/include/button/qcom-pmic.h b/include/button/qcom-pmic.h
> @@ -0,0 +1,17 @@
> +#else
> +static int button_qcom_pmic_setup(struct udevice *parent)
> +{
> +     return -ENOSYS;
> +}
> +#endif

The stub should be static inline - otherwise any translation unit that
includes this header without calling the function gets an
unused-function warning, with multiple-definition risk if it does get
used from more than one .c file. Compare with the pm8916_pon.h stub in
patch 4 which uses static inline correctly.

With those fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
