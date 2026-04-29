Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1BCFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638F584912;
	Thu, 30 Apr 2026 01:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MnSD/IBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8BB8491D; Thu, 30 Apr 2026 01:56:34 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D1C84910
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-678a1642a81so504790a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506992; cv=none;
 d=google.com; s=arc-20240605;
 b=G7DrwT8uzGZmdwQUVWNXkPKJrJ/cEsyTt1mahbStpKze3Jqc1wWQFrbl6TFp3abH8y
 59cUiKRFKcl496cBRsjEEb2ZSiqRjKU8b85CaXSKrtvVtcS/lHX5GsH9vagqzDjSHLHc
 XtNnh4my66g7Ne7xCraWUdfgU+s/8DYiY8eDZ6ePMQuOKawRgNKT8GJK/vyIfUDhxF4c
 RouGJpjIxMyxvTrWBCp624W3guQC1NaG29BBoAOMLWiTBVy/i8FTnJKNCj8uvjMygaZ8
 lMbftFa+UF5z9uZ9MGvxGEcQIhcaNjM5mU0vCYl5TnN2qVzbF3nPbtBCzaakmmnnLj2i
 8vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T8tXI7wb0u5eJZ8z7MpL29Va7cGTABCxblT1t6UJbXc=;
 fh=I7GiAdneCkBThil64KmQY67lpX8rQQKv/vWT7AXWZ1o=;
 b=iZ8EszNBkvyrQTQ0Y7ruDuT0doOmv7DcXZFf3knwBCSdgj2fvPfxFGb4XFR9S0nrX1
 8Pyxa0VwkToI+vxw8j4/jYpXwU6t78z8V8uV7leRD1HbtU17FYf3EGhlwpDpdYHM6GEa
 +ImrdGywHM7gXfn5Cv9jjkbBpbmUegeqh6H2ZTpO+QnjPRHIrnNnB8Fglg1WPx7iI/Su
 VL/Pg3HNyrQuxezSi64TCKJsOPXR+Vg9cZwXA2dFAkDLJePYlHbpUNnEmv/B81DLoOUA
 scjani7A1WMGhxIzJlVIWSrTZcxlb1s0Mao2rxgB/obAqFWgtWxDKYVlpcBHNI8StTBz
 xHRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506992; x=1778111792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T8tXI7wb0u5eJZ8z7MpL29Va7cGTABCxblT1t6UJbXc=;
 b=MnSD/IBF5uAFLuFAx+mUq3c7afml4CpA6VNMKW/44zqjFAjxMjcBQBlC4tFnAAxtrC
 kLlvruiQmuKVjN72ThOtK4H8YIt8lK3GXV3wtdN9MNiXKjSwIYRE4ONf8joBoDV9YEQp
 oyGX95LSXs+8nelcmVo8dJZcgpW+bqtBDO8gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506992; x=1778111792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8tXI7wb0u5eJZ8z7MpL29Va7cGTABCxblT1t6UJbXc=;
 b=WT+11K8jQGnw+lVESiWSYgh4cWOlT2CvnIVoBTKlloqvfW/KpvYAuIJRgI/wiPFxDZ
 djdS2spoAPwWVpOaTHWuQiTZZI50lUpu4OiRnwes5RcyXJ8UmbbNwTxwFdk8IbIc+yvQ
 BbHRFuL5yJNyeeOS0riFLG4bljgR3UsIGBKH7oyaYVoKDezbMm7HHMjGmEpTB0Nty8Ky
 AewzpBgnd8EoRQdO8SbgBi5IQSjaIUQh5lxl5nMWHUoPNrK++cB4BqDkRLawGVnQEn4o
 WRHTYMwiVwXtPGwIhzpZ2tUfkMauhZ1OhhudlDah1WlKa7dDisvVX8Rhre52oQekw2R7
 w7Ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dudWi0lQQfchFlAbJaa4sJP04HDEQhOzL34t1BQlZzaJmjVo9U6/rgew7NdoyoZ8mn9YMopM=@lists.denx.de
X-Gm-Message-State: AOJu0YxgnjNT3ItqMSJEk1HyroCcm9EuXXywlSxqAul7LWyd0ovdC4e6
 9Kqyc4oCvqHHyyJklZOQgdYiRa2NQfOPdGu7pvHN6y17dkrJiugk6xPPidrw9vRC8DKWwy48hEJ
 o1N6Wq/JBRHU0RUCTaxlcwm03DXnCgQJx1t5r0qlD
X-Gm-Gg: AeBDietyBrHZ4JOTI0aP/PZFpV33v1Ogvi30C4MMzJ7fgDsTVJA1nHVbohy+A7141zB
 AIr5zSs/HHs6VUe+GCAHTYtq0Z7lwGXS0FW65MnnXGwvaEd1gXitTBB4s/WRD0P6wnb7HUDNJsn
 Gt6bLQgtPmdk1cnzGnDdXcd7XuEYGtxAda73gm2Sa74LowT0b1c6TMKFMFXlmdJVQR6nHmUbFQr
 9OppJKI9Dqa8si4chridnqlly0AywS+pKq5ly//cOM3uKuWLSMNMIV4gjw/2ezPSWrMHltbKOCC
 7DYzCCgQ7eEHdWSZ4CtMKK8/sDE=
X-Received: by 2002:a17:907:70e:b0:b9b:7bf8:800b with SMTP id
 a640c23a62f3a-bbac8279d61mr40333866b.40.1777506991932; Wed, 29 Apr 2026
 16:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-9-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-9-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:56:19 -0600
X-Gm-Features: AVHnY4JNacOSQ82O84eGmEsNkEdrLMTNT2qZ5TcMiycX-w36zGlZ6_bwFqTUU-g
Message-ID: <CAFLszTjTh0yZ+K_E1A6bXHFUgZNN8jEjHC=E9JFvBkH5Ky-MyQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] tools: binman: Add a test for boot and load
 extensions
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> tools: binman: Add a test for boot and load extensions
>
> Add test coverage for the boot and load extension functionality in
> ti-secure certificates. This verifies that a certificate can be
> generated having boot and load extensions.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> tools/binman/ftest.py                              | 10 ++++++++++
>  .../binman/test/vendor/ti_secure_boot_load_ext.dts | 23 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -7270,6 +7270,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPackTiSecureBootLoadExt(self):
> +        """Test that an image with TI secured binary having boot & load extensions can be created"""
> +        keyfile = self.TestFile('security/key.key')
> +        entry_args = {
> +            'keyfile': keyfile,
> +        }
> +        data = self._DoReadFileDtb('vendor/ti_secure_boot_load_ext.dts',
> +                                   entry_args=entry_args)[0]
> +        self.assertGreater(len(data), len(TI_UNSECURE_DATA))

This only asserts that the resulting blob is larger than the unsecured
input, which is true for any signed output and tells us nothing about
the new code paths in patch 7. Please verify the actual behaviour -
e.g. read back the generated config.* file (or parse the cert) and
check that the sysfw_boot_seq and sysfw_image_load sections contain
the expected bootCore, resetVec, destAddr and authInPlace values from
the DTS. Otherwise this would happily pass even if
ReadLoadableCoreNode() returned None for both extensions.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -7270,6 +7270,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPackTiSecureBootLoadExt(self):

Since ReadDictFromList() in patch 7 returns None as soon as any single
property is missing, please add at least one negative case, like a DTS
with proc_id only, to confirm that boot_ext ends up None and the
certificate falls back to the firewall authInPlace branch. As it
stands, only the all-properties-present path is exercised here.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
