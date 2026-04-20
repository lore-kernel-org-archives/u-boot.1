Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D658AEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C214C83FF5;
	Mon, 20 Apr 2026 06:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AHjbuWZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E437784181; Mon, 20 Apr 2026 06:31:00 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EE983B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so476753466b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776659458; cv=none;
 d=google.com; s=arc-20240605;
 b=C6wZEuLm7zAT7gHlROlMQJ50M854fo2t/dixxOn5gdW49kUtVJGAhRkOCqRGP8WgPF
 1QUGFYp9LlM+ZeAqLiWY4+woGBJdL/FeLTcqyVYfdglsk2lSCfFgpBe1TgmpO0avBOap
 cF6EHEExfte3E6wm780h1jg1p8UBi++OUWmJsIwVKySqHRsun7DJTP8B2Z73waT++qR4
 gG+RQzEc3GL6JTjAzAOsWftgcdKqqkBYsNjQaFIF5IYse7iXahVLCy7tJB25hoE/4r9c
 Kn7Zp70G193ZG+wg91DV1efvyDgj9Dfjde8/uMQL3mdl88OxpkH6+ZM5mulq9EehY0cp
 55BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a3PIOTXVDU7mwIlDcFE0xU0PuUzWui6pYgDmioHwxuQ=;
 fh=Qf72jxhI2UnuO7wPIqHrOpJHB2Y+2qiEDFHo8SBQpkk=;
 b=c0h54pJTKdB5XRXDiLoA//RRi4Fn7ymYyncvhuYmVfeu3SH1+93aaXZpBgKC2PrGEV
 rLlHKi21xOjt5/xMPP6GS9uUkmHvvl9+LsK3QP3qON/wJfMNxewLFUQ1c67VdrrEQpID
 ZaLJnWkQ3fAFEfAHW3ZFtvSTjgjOIIEHU6mGuxJld334BfZZ1OhHAQoYDAqUtYC/PHKE
 nsrApjnLt/KCapUPh0Jcl3FN9212kXXnKRDlDRB1lZ5sdbabKns+v2e2ttp2ne7TLdfj
 z+anUd2xE3keEcSgj55okIZxxiCdy+M9R1zvFzQrCFSzywBy/+lxvlnffDFuluQNexF9
 MWhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776659458; x=1777264258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a3PIOTXVDU7mwIlDcFE0xU0PuUzWui6pYgDmioHwxuQ=;
 b=AHjbuWZibQu93qhqZwO6Itlib3EN/ihAI1+a3mZG2XPoRWmnozAigGWM/t8Fu5evRT
 DOG/dp1M1XkKmwCUh5mrIGlFWthE/hRvhV8SfHAl7ib+U+fAdea7Y0C97e9VxgOK3OB6
 kVvBR2IwQw0NssWGggiUlvsMP704O9G+tNzJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776659458; x=1777264258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3PIOTXVDU7mwIlDcFE0xU0PuUzWui6pYgDmioHwxuQ=;
 b=gatvAojQHhohhmezjKYSSZKguxh8huTNH5EQYG48PjXxSk+b5raDhDvwEI9wJdxMOy
 Og+CBwa2oPZBA5yvrx9YpVO/feUcuIpdbzTohaAWobvoaVfNjKi3ctphtt1lomcB3HUu
 HxZYl4beiFqy1HrbyxCuGW5LcOVIWc1zKjZxEK44KiW16a2/d1HQY8cuTB3DazW4jYSo
 NLKlikNTs6ocQ1arYzzIzGYk25RERlN+55rHnJiaXiYI/evT+3cSBdcNNjSBml5qKov5
 6tVbn/4+rayYYlskPND1ZcftMqxgMfkddXLAvBG8tAN6mtp5VLLgU6au8zIIYAyB6EX8
 fHWQ==
X-Gm-Message-State: AOJu0Yw6XTbow9HvwUnKWfdovqoB7w8ZACm5u91V1xcH2OqZ6s4gKBmx
 pNWI8HWZX2lFpFu/6UetQn/QExo59RyB+cn9kuh5zaw06GQhAo4nc5rT0cl4AROL10/a0MbobbQ
 cHv5YafBR8u3SRa4JIWz4s7/tFaTCXVFBv5xlHxqG
X-Gm-Gg: AeBDiesRsu3C5+BiIT/Bffw91T9kMb9lw5CcQUyYEO6LoeKPs5QhHJLHp/+0bR9nXmV
 wL5zteBSopHEkPsTEeYCNj4PvnXoQ39lk1Oc8SIIG57BvM6GyN3KjEafVBtXk3vcX9bKPcx/Et0
 V48U50WMfszp4ds2LxC2Av7cdbyjCL0PrS+Jjodhn/Y9OHqXGH/OTibSbGcNX7ogBjKB3H9aVQK
 SuxkhCUsQpDqFqLfRp2hhjAZ8PIpjf7wSiGfjsXZIgq15P3htndrwYHKBdL9dhBTlSU1Dy7164z
 fdPw5nG2Wd8m347UU/wz
X-Received: by 2002:a17:907:94c7:b0:ba8:422:6015 with SMTP id
 a640c23a62f3a-ba804226350mr56444666b.1.1776659458203; Sun, 19 Apr 2026
 21:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
In-Reply-To: <20260416161305.24118-1-maximilian.brune@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:30:45 +1200
X-Gm-Features: AQROBzB7Z4OG-rY0767n09-_6I3JFMOtJ-gvuKBEULVvlilcekaQDT-ApATRMJc
Message-ID: <CAFLszThRDZ_6T09au1uzMO8pcHMDLGZGkF7hBzGtgRjRjC9s3Q@mail.gmail.com>
Subject: Re: [PATCH] pci: correct PCI device enumeration to include all
 functions on device 0
To: maximilian.brune@9elements.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, andrew.goodbody@linaro.org, 
 george.mccollister@konsulko.com
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

Hi Maximilian,

On 2026-04-16T16:13:05, Maximilian Brune <maximilian.brune@9elements.com> wrote:
> pci: correct PCI device enumeration to include all functions on device 0
>
> Currently the implementation does not just skip all devices beside
> device 0, it also skips all functions (besides 0) on device 0. This
> broke basically all AMD platforms, since they have a lot of internal SOC
> devices behind on these functions.
>
> This was detected, because the XHCI controller and therefore the USB
> devices were not found by u-boot on AMD/crater platform.
>
> Fix it by checking all functions on device 0 (Linux does the same).
>
> TEST=build u-boot as coreboot payload and run it on a recent x86 AMD
> platform. Devices like the XHCI controller are now found again.
>
> drivers/pci/pci-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> @@ -927,7 +927,7 @@ int pci_bind_bus_devices(struct udevice *bus)

Right, PCI_MASK_BUS() returns both device and function bits, so it
skipps any bdf where either device > 0 or function > 0. Using
PCI_DEV() extracts only the device number, matching the intent in
only_one_child().

Fixes: fbde868ba4aa ("pci: skip unnecessary PCIe scanning")

BTW, the TEST= format is non-standard for U-Boot - you could reword to
prose or omit it.

I notice the mention of AMD - have you tried booting on a coreboot +
OpenSIL platform?

Regards,
Simon
