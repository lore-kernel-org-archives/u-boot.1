Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D71CF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA37B841F2;
	Wed, 22 Apr 2026 00:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EM0XJ8w0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DFB83936; Wed, 22 Apr 2026 00:48:47 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D5284258
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so967532466b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811724; cv=none;
 d=google.com; s=arc-20240605;
 b=bpTRVCXnF2VYYPmdFKj5vJqmG2NUnMGEQ0fq4X10bLZwgJ34tBfdzBiTsM3/B8lkuH
 /H3xki0V+qQDufEFxEqaprsRiSLFnDFNoP1+2YN+VTSgdYvulHDasl0AvsUum8tpkoBS
 cME1wYr17yKdDuJRXF1kUE3C3syoNwY8BXKia74vsCNmiJUwD/QjVYmp96EaQX43dzRq
 iqdvEQcMfaY35MdfLn+O4z1MHiADS3g2qHeSQqD0UjP0MEy/csPlPMbsiJmtC5XvW/uQ
 oDYubF8E48U6+11o6DYOV4rm6b/r97Lg2V/h8MVeh68KP4DyWfHT4Z2xNZRraWzR4rGe
 zNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ffII1dlKQ5AqTkn4dizjSfBs67fY4AsXe2Xbgyj5rH0=;
 fh=FjXpY7iTRt7Egx0uJJyJRM87tOzU0fjxaesNiszpBy8=;
 b=Mzi42Nt0kbL0XtYY2qaJf/kjOMRPY26nzFPep2NMzRi4RnaZpOS7NNsC2H9z/ZdZgT
 bjlGeA4QEN4htkmMUi6fGgfZ8gC4yn2sjOuzD7ToUopj35Fh4dw+zZFrRxNYLMW6VsWj
 7yFelcnpzCMJ5zJTrF0oJXQ8U/GzXDXya0vL+AaSvvdhdpuk9mLyeo9PKXmQDpbIStgJ
 78rvyMCQ2iMwxFUKYJ5yg6HAIpCuoCASaBypg1Ux4BsWXdWYWwStpbVpmv6l+csU6Lq7
 5rrEoA7YeY3WlzSsCe3C9lVnfjB3KxhvhUrZ+11o4uAUSeFq7nhcBR2ZeJEpqobubfSc
 1UFA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811724; x=1777416524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ffII1dlKQ5AqTkn4dizjSfBs67fY4AsXe2Xbgyj5rH0=;
 b=EM0XJ8w0pFUT8HaG8dlE0k7LVtyhb9fgSvMFUdUkAmo5elbfd2tHvhyc01YwmH7UPC
 IaG4GXTKHJGjn/WVq0xuYqE3WcldN7L5MfBbd85W0jWGOmQzblhTuvghEvZdxeaP2Za4
 VXQ3138W4LqJzVfvAfex4PhAeECN1POXFDVFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811724; x=1777416524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffII1dlKQ5AqTkn4dizjSfBs67fY4AsXe2Xbgyj5rH0=;
 b=dtNYvWDjtoDgxmG/lUcGo+Bg1yEIMRB5zXKKXIdyESEqUNBfJInWdRuFUQRGoRPrul
 yvGXawgIF+lhsp7wgM/FyJX5AiTSakOHy2rQcTd1YorGbxX+DC0fJ6b6Z8QfQoDvOwup
 xvd9Im25+eshGF7wkcxMJjh9td6Cbbo5uqclDaAIUPsVOkE2rm1Q5R2MG3X6D0qttS3g
 BdYQJlOZ33Ts/EVm7YUgcSf76SrRL/trxNR4Cm3K9Nm23QgIoiwrrg2wO+IQSXSUijDJ
 6eMKAXChwGgGepn+rixE4aqoxkY32bgTzDvBiyyDAGyUIkDQIfyqA21fiTTosJFXYTcZ
 pfig==
X-Gm-Message-State: AOJu0YwhhgoBPb7uti4zasv0H/ui2GlIIFm0W9hgdb/gb5c6GPAMOE3z
 leEb2IFbBVPZ8QUQzKEpZhAQCgkMtzGRK2eHM7JYYv8+cYZ+Lm5VBN0wRAqU3mMSGoZN/SUB6NI
 RjbZXE0VwyLJb+oqVdiWTb8+QK3f7QRUYS3jO5yuQ
X-Gm-Gg: AeBDiestvQHVauQQ9J2+HvGRsRZNQ5sRzwrk/E3APq/aj02FL/KOB/aQkTcMObLhVVw
 8XEM53i9ufCstYIDcovSIzoEAAs/SEt+X7MaePl1LEIBvM2QcpvU2XNsUvRosUE9yF5SPJ/cSJ4
 sbvXyt7U15KU0mXVWxepueEfRMZJSweYY+dKsUAlBfJfiwhCwHbuBWHuPUogxvmFuNJS6H+b7u/
 cCH1obbPJcm9c0mLsXIGeX4WJAKNJePqXeKosCOZyAdhXw1/Mermrj2ipXEeAVubKMc3vyxlv2m
 RzIP+CV/gMkwO9+evF6y
X-Received: by 2002:a17:907:980b:b0:b9c:b178:36c3 with SMTP id
 a640c23a62f3a-ba420d2424dmr872986366b.2.1776811724116; Tue, 21 Apr 2026
 15:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
 <20260420120335.10120-1-maximilian.brune@9elements.com>
In-Reply-To: <20260420120335.10120-1-maximilian.brune@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:48:29 +1200
X-Gm-Features: AQROBzBFMBA_uMWyMHbXpnRlqCiWlh9xTkPXHOA9qrD_de8JLl3ILIlr2xifoPg
Message-ID: <CAFLszTj8SQuOzG6C9nhMdUHnXcDaA9eDomC9rQrdceaNBcHcjw@mail.gmail.com>
Subject: Re: [PATCH v2] pci: correct PCI device enumeration to include all
 functions on device 0
To: maximilian.brune@9elements.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, andrew.goodbody@linaro.org, 
 george.mccollister@konsulko.com, Simon Glass <sjg@chromium.org>
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

On 2026-04-20T12:03:35, Maximilian Brune <maximilian.brune@9elements.com> wrote:
> pci: correct PCI device enumeration to include all functions on device 0
>
> Currently the implementation does not just skip all devices beside
> device 0, it also skips all functions (besides 0) on device 0. This
> broke basically all AMD platforms, since they have a lot of internal SOC
> devices behind these functions.
>
> This was detected, because the XHCI controller and therefore the USB
> devices were not found by u-boot on AMD/crater platform.
>
> PCI_MASK_BUS() returns both device and function bits, so it skipps any
> bdf where either device > 0 or function > 0. Using PCI_DEV() extracts
> only the device number, matching the intent in only_one_child().
> It therefore now checks all functions on device 0 (Linux does the same).
>
> I build tested u-boot as coreboot payload and run it on a recent x86 AMD
> platform. Devices like the XHCI controller are now found again.
>
> Fixes: fbde868ba4aa ("pci: skip unnecessary PCIe scanning")
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
> [...]
>
> drivers/pci/pci-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> @@ -927,7 +927,7 @@ int pci_bind_bus_devices(struct udevice *bus)

Nit: "skipps" should be "skips" in the commit message.

Reviewed-by: Simon Glass <sjg@chromium.org>
