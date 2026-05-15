Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD25CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9624C8468B;
	Fri, 15 May 2026 15:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9I8tPFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95928469A; Fri, 15 May 2026 15:08:16 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC278464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so388278766b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850494; cv=none;
 d=google.com; s=arc-20240605;
 b=W/N9jeAjt7oMO22tF5EpLT6cNw/njXfJjyqBx/clWoOX3yUykpa0z9wzmI6//uPZlK
 apdHMXGK518qYVt2Baskjfviu8CA3R8lYMQNU03ITqkWs72YZTJstfcFL6VnD1fyX7iF
 siPWd7c3OZtkoJ3Pcbso2mfpkpnrGDJg0K1Xz6ew6rUBro0AdNhY83KoA/Xxq58Tc9pm
 1FMAo1emfBTizQs6egx43u9gsuKk9HpRA6m8rBzxavd+vA7o+FTNshiFcVyZ5olkJisv
 nvrKVQdqvf+IqiaztcXqenVRhAU4xjfusNE/8jVFOnmYOhCTxgz5WJ+x5JtFy/VLaCT/
 WCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+xlp1g376EOrLtCPrwisZF+YbIypr+STUyWCQ8zRCPw=;
 fh=p+5qEY7KshK5nNBu/OO78N81bwUQ6GeR8eoG5BHzLcY=;
 b=kwWqBocj/rzj0PB7478Oq3wnFBt7n427E0eTmd3kJgypDv5ZMSEzkkJu+8aN/hs6M4
 trSZsPJrHlCnD7/+qB5eAHXeRfhwJoYoGqwYlDeh8D5PBLbyhJibR3yOcY1uP+oS9ns1
 gOtISMT25wdb5VEcIlEozdtMpKe0L1KhceGWn0sfrO5Z0MFABLTaneDqJXVpsZwa2m0a
 k4tjzEF6AGvK7m15smBJPgAQH1Iw5Uix5YyUjtUXm8scJbPqTaisjGTza6p1KM8jpICQ
 BDSBuzzOJN7cQXEshyC4S3Q7lWSr1xz8IGH2sTpcpW3+GXLW6KQmEbhtfitRVhXW6vuq
 Ya6g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850494; x=1779455294; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+xlp1g376EOrLtCPrwisZF+YbIypr+STUyWCQ8zRCPw=;
 b=d9I8tPFu8hxjosyQ42ecCwZkABv7u7G0mEZyjSmlgDA6ZwUpgAZMxAOekKBIfMKdF7
 jklDnJfSo0BSCUWFX5FhEvkKVfNyvcWclRwelOrVUcQdfJLIBgF1Ksn9w7QIJuvWjQjh
 rkj3sbb2MmfeV0SkBq8qaUtaVELL6FClT8tyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850494; x=1779455294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xlp1g376EOrLtCPrwisZF+YbIypr+STUyWCQ8zRCPw=;
 b=FX/0Z7P1PTDJn8Ju5bGIbll72VtFSY+CPPIQp8KYKwD52ZRUEYFC3a2RKZBaqDGRR5
 gQOKvsBW3PNPiFwjCgKQ/PZDsOWGRNcZxNC9Z6sJc/Fz8Vw129jtUpzWrtmCLNy3O0A4
 YDbYNQ21EPGKS52ZqYN5JZDF0QvCeo3kSQ3ro0520MIkra76Vu+zmMLmceVA8o+2N8WE
 5ZldHZk6L87lwDgC7or1KgMKUvL6fj38npzdRfn6f494wNYIQYRZvVCtvUFRywtZVayB
 DYjQHQSekOaOuC5OwKBC20jktDPTAMUIeBYBA7Z3jx9Fw/BvP1SZnUzE92JHrZwVSkF1
 agJg==
X-Gm-Message-State: AOJu0YybgObdNrN1hGd9pOxUylUteEOxA7a+TN4CdFuu+N5kBLS0Xylo
 Av8Y8w54GsVk+PV/LyhyRH6mRURwwlfIvboJR3SY7mA2gwwoS8Z7pQfn9orS8/GTbUbG+tlScHr
 Hf+rGJ6NeFh/5iqbmGUOMFDxd+yXjmgcNxuHxyrT9
X-Gm-Gg: Acq92OFVjoSYEhbLsML0dPPNfKwmtg1b/l+4Yqxk0OrlMveIV401lpxIKQP+tWtznCS
 yGwuGKL5Io2OS6GAHnFLuZsnvHTMWJJGpca8mULIryzA4z6zBCs/t3jy6kBsqKC4MeC3rHwxrLy
 Fj4t1IYvLuN9I/3+yg1qLOIf+NvALTJEyYEQbIjrD70CenzQRqTzrx4tIL6uNXa3VQZCs7RVTk1
 GouUd0F8MZQktpigJ8xSDScdslO40BF7/gSdp8DMUAxCZcf5LT6cvfwe53ZibHsgAZAewxRR3M8
 L/qThA==
X-Received: by 2002:a17:907:b801:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bd517929a34mr193424766b.23.1778850494146; Fri, 15 May 2026
 06:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-4-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-4-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:08:02 -0600
X-Gm-Features: AVHnY4JRD6r2CCBgCAXxcpJkA3cRziMqTjg8K6iVxw-PkngctJREQoPNR1DxYLY
Message-ID: <CAFLszThYYgAK9kk-0muWsf+E2N7eV0NwvB1HKaf_D1UxiJKG9Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] arm: dts: bcm2711-rpi-4-b: add Infineon
 SLB9670/9672 TPM in U-Boot dtsi
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>
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

Hi Aidan,

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> arm: dts: bcm2711-rpi-4-b: add Infineon SLB9670/9672 TPM in U-Boot dtsi
>
> Add a TPM 2.0 device-tree node on SPI0 CE1 for the Infineon
> SLB9670 / SLB9672 TPM HAT.  The pinout matches the standard Linux
> tpm-slb9670 overlay, so a board configured for U-Boot with this
> addition behaves the same as a Linux kernel using that overlay.
>
> The node is placed in bcm2711-rpi-4-b-u-boot.dtsi (the U-Boot-only
> DT augmentation file) rather than in bcm2711-rpi-4-b.dts.  This
> keeps the upstream-Linux-derived .dts unchanged, so SystemReady
> firmware-provided FDTs and the upstream Linux device tree continue
> to match what kernel.org ships - which addresses the concern raised
> in v3 review about polluting the Linux DT path.
>
> A spi0 alias is added pointing at the BCM2711 SPI controller, so
> that wolfTPM's SPI HAL (which addresses the bus by number) finds
> the TPM at bus 0 CS 1.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
>
> arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

> diff --git a/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
> @@ -0,0 +1,39 @@
> +#include 'bcm283x-u-boot.dtsi'
> +
> +/ {
> +     aliases {
> +             spi0 = &spi;
> +     };
> +};
> +
> +&gpio {
> +     bootph-all;
> +};

bcm283x-u-boot.dtsi (included a few lines above) already adds
bootph-all to &gpio, so you shouldn't need this.

> diff --git a/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
> @@ -0,0 +1,39 @@
> +     /* Infineon SLB9670 / SLB9672 TPM 2.0 on CE1 (GPIO7) */
> +     tpm@1 {
> +             compatible = 'infineon,slb9670', 'tcg,tpm_tis-spi';
> +             reg = <1>;
> +             spi-max-frequency = <32000000>;
> +             bootph-all;
> +     };

Just to note - drivers/tpm/tpm2_tis_spi.c already binds to
tcg,tpm_tis-spi, so this node is not wolfTPM-specific; the in-tree
TPM2 stack will probe it too. Combined with Peter's request to split
the BCM2835 SPI driver out, one option is a small standalone series
that lands patch 3 plus this DT node and lets the existing TPM2 stack
drive the SLB9670 on a Pi 4, independent of the wolfTPM question.
Anyway, please adjust the commit message, since it under-sells what it
enables.

Regards,
Simon
