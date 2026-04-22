Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE7F94CB8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896DF8352B;
	Wed, 22 Apr 2026 02:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y9O2wfU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10FAC83936; Wed, 22 Apr 2026 02:10:35 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB5E805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-672c23aa064so8929093a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816632; cv=none;
 d=google.com; s=arc-20240605;
 b=JUbznk7hzZxhpWbnwCotqO1RykX2/7sD0KcPrsI6j8M/pEzBhxnHtBOsGZENoAZU/T
 RgswGjwyx1ezZgziKgOnLgcxt8w3e9plrhQAWw7sx5PaTInF5fH/KusPPJAcLnJk2B6Y
 tdtmNi7G4hyvqHxp5EgoYT94Pe1ujdYRRDyeNW/TuS6tERz66DiisihvgYZWqIWuHj3L
 cdunhp2i3ry7KV9sHR3LuGkV8ywlr34Ma+XaZn1RhIAdy6s75qG/8CUWLjP+3/3jMRli
 2FU6UXa4C1QkSI53YP7GdgG6uT8AJY6Kp4O3l9jTfGuoKdHotqADdFGxSmfs+wiV5EgP
 rLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A2Dr1RGSCLsbPSa2gIKuxGU2q4MrV50rfp3sK/wIZyA=;
 fh=huZavGIedmb5t2orr+/Rb1tnWmifMM80sbfGbi0WwQs=;
 b=kN8DY/8Paqfr+lqa9uY1KRkd+hNhoWurgZycqDRraslwL6KclTVASx905x1Uk9L85w
 Zrsm2sn3s2ElFAZfRFl3IJa7sQ/t+l8nGU3ylmqzTJZaKnFdmJUEmVlmAol+4bW4Qh5b
 CW50xTrHd1bZkk3qSkO8ZISctjPhVdcIT4Hy2ewGAEjh5pdPljuxHm561nTB/CFZcs76
 dX6SUHA3o894YyjEgCGkPaW6Pu+nmayIpoMVY2pkj3NZhxC/vJkVpgYthzA03Ax/2Nnd
 bgH6VZqQftzmOlmXHRf1NhEUh3dMsA4mJKr8sCM6ZPiv4OjW8KoeFMyxoEYaHFhOp5Xi
 D9Aw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816632; x=1777421432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A2Dr1RGSCLsbPSa2gIKuxGU2q4MrV50rfp3sK/wIZyA=;
 b=Y9O2wfU3XaAqIDTFf1cFIHY3AaqIV2d/TB+xBhQNW8eLYP5/O/KYcbfC+haptTnaWH
 tU14cxpGDDpasDNdOPTbH7QA6clR7JKYkaw8VOi3RiJER0hZvHJgNmiq8REcVYrN4eqq
 qu9kbgrVeb45Q8+cnYFIWKqTzmagwJ5Dy9jZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816632; x=1777421432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2Dr1RGSCLsbPSa2gIKuxGU2q4MrV50rfp3sK/wIZyA=;
 b=Fff4EbcSAA3/mhM2CAefvDDn17zyh7QMKe9pQf+PY0HGLTMjkYc8HeiktPHzpmLcp7
 loK1OpVxijsLurQFjSecx9zHceXSXfeeM+J8gv7IZDEGQI2inx7UEqlrhUJhWgCFKwhe
 Xym+5KSDwpCYEKbAVmJHK0q4GOAczGnK4y9wD5NVhtAl7AI8R+NzXwaIbL2EtlSBwZO0
 ScoGYuB5f0PJr9kveKNbkE6MqJiA7C15dz5l82FGO7gm0bx++yb3zEDHMepIN1Zs98ye
 N+8aRXFQTEmhS1JahEOt3+qCjat6zLRvCJZH4l+9kccILgX0Iw+Hpen6p7Wv059cNoX7
 l3Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ymmwcs0C1/M/arDlVmXCU0O/gs5Y+Bypq3bV69pvwkpHjGYjspN3V4uvVZaSWs47TvL/sz1g=@lists.denx.de
X-Gm-Message-State: AOJu0YxuE0/B2S3oc4Nq8aJ9u/IrqUARM4fncbnR+7LWRcpOEJDyOH3z
 7cwW6asys3zJ484Nrms/e9v0MSZXlrgA/qxAfj/+jEmhtzC9qie21NcJ560qfN5dYw8rZMIHpW1
 oCgyjWQtTsA3uFzhnwJ6Ox5001VolHH2GuN/Xkdez
X-Gm-Gg: AeBDietPx69OOo/2PvzdmlRruz+bdHihPKg9Q6ULLQoiEewAaYO2GEn5sApCTWdIu10
 XaWF/Rhf0vKs5URq4wQxRkfGxT3eOnZyoct4UzSB/TOLUYJ1Gpk0mhcbl3WFTsf4Dpb1Mf4RRCX
 KPE8kF/ECnG23cmDx4WiFFycafFi5ut/S9y9PbWy3XOsgDiFC2m16nW8IG9UBAFq8914APQvvEu
 Jd87FT/1K2I6kVg3babHZXSSHdRt/bBQ2TlFNL5s2vEJv/5cPd8tTC7SzcB7MCJG/Htyta4QAzu
 yTNadajZkgsdNf0FO8op
X-Received: by 2002:a17:907:a60b:b0:b9c:b069:8ab6 with SMTP id
 a640c23a62f3a-ba418b7e7d6mr905539366b.7.1776816632153; Tue, 21 Apr 2026
 17:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-3-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:10:19 +1200
X-Gm-Features: AQROBzA0UdOSbAmA6-XVzjGIa6oG1Xy6BazhF8Ne-qybcWooMQZZ5D_pgzffAkM
Message-ID: <CAFLszTizb=a5uvtjFRbDoUYoPX2iXyzt_jiFdkqBcKJbeOk3mw@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] mbedtls: enable support of ecc
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> mbedtls: enable support of ecc
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> configs/amd_versal2_virt_defconfig       |  3 +++
>  configs/qemu_arm64_lwip_defconfig        |  3 +++
>  configs/sandbox_defconfig                |  1 +
>  configs/starfive_visionfive2_defconfig   |  3 +++
>  configs/xilinx_versal_net_virt_defconfig |  3 +++
>  configs/xilinx_versal_virt_defconfig     |  3 +++
>  configs/xilinx_zynqmp_kria_defconfig     |  3 +++
>  configs/xilinx_zynqmp_virt_defconfig     |  3 +++
>  lib/ecdsa/Kconfig                        |  1 +
>  lib/mbedtls/Kconfig                      | 14 ++++++++++++++
>  lib/mbedtls/Makefile                     | 16 +++++++++-------
>  lib/mbedtls/mbedtls_def_config.h         | 17 +++++++++++++++++
>  12 files changed, 63 insertions(+), 7 deletions(-)

> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> @@ -300,6 +313,7 @@ config MBEDTLS_LIB_TLS
> +     depends on ECDSA_MBEDTLS

Adding ECDSA_MBEDTLS as a hard dependency on MBEDTLS_LIB_TLS means
every board using TLS now requires CONFIG_ECDSA and
CONFIG_ECDSA_VERIFY. I suspect you want to separate the TLS ECC
requirements from FIT signature verification. Perhaps the ECC curve
support should be in a separate CONFIG_ECC_MBEDTLS option that both
TLS and ECDSA verification can select?

> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> @@ -3,6 +3,9 @@
> +CONFIG_ECDSA=y
> +CONFIG_ECDSA_VERIFY=y
> +CONFIG_ECDSA_MBEDTLS=y

This suggests the coupling between TLS and ECDSA verification is too
tight. These boards want HTTPS but might not need FIT ECDSA signature
verification.

> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,23 @@
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif

How much code size is added by enabling all ECC curves unconditionally?

Regards,
Simon
