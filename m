Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346ECCD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C4284849;
	Sat, 23 May 2026 11:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTU5fVjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645908485F; Sat, 23 May 2026 11:47:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497A0847C8
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so1390549566b.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779529646; cv=none;
 d=google.com; s=arc-20240605;
 b=GzFNdYh3+UljZI65n+OjlVfLt/lCBtJ1/mhopmhqnHa2d21OO65rHhI1fv3VVdsvTU
 dTsWW4LCiYzrCp9kWvCnpHV/7C44Cr7f7cwZXW+03XWlpUYB12PXOz5kJaVlAnIlZ3Tg
 ggn4yzwOVQ5xNrsTyzFD8jOAdVDT3oxGgwlY8shaIUwvPxSgTgpQTHEOCLHsJs4lSObM
 DUK9E7yTDVcWWNWNxK6K1dF1lDpP7JBe+ntHg4xGzF9g8zhn8SlT6XXUpn4v+YhrJyKq
 rLywbYosjreJ7qBaRkkz9TCT9oNlMY/758Z2ys40DX/tEV3nIs1xiUEDPb1BUeLT6Vzp
 Feew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7KeOPveaqyd8dlsiWqmuxyf5BwmK59YaNq+M+qF1tXc=;
 fh=J+YKKn9mpAkV/TR4C5Zbuk1+d1QQhpd2KKLqwW8NX80=;
 b=hhZf7cYODA+xE9s1uIE3mms9TxcWKclOx70Hahi+dmoEQPvciPEZFqZGiBzYnts3Pv
 WjlbcBpbi+YNPSnLpyy8HofRd/dQ8y8F8mHYx/HDLU3Z0154bAKsQAn5ZCcs4QxDYay5
 QH2g2uQE2BmxdJlg+BFm6o7VMQkrqrvaKTeCKSaye//TMcHNUreJdwYB7+mABdEaALHG
 6UsCV83cmS0HGZTf/5+qfNJCSKcJmKlN4gZb8bTsEGNgz+rQjNaz62UfwrXAqf4xJUAW
 G7L/N+bpU+3sTCoFque4+01lAtZGOMJpHfnmi/Ayvb3WHHBEthxndnMDchnd70wAW2zL
 mheQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779529646; x=1780134446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7KeOPveaqyd8dlsiWqmuxyf5BwmK59YaNq+M+qF1tXc=;
 b=cTU5fVjyyiyivxPK5JwDuwo+SB8yX89nf9sk8BPvZP70x8f9Ckk6OlBYHz0BdIXuIu
 sWEiw1aYgm9DYc42R77a74Q8uxgBbvEBA/o7IEIA+Ib/QpBZHuIP47AxzKff7rOJV+aS
 PXPvtfCmMx/uzqfUPUIS18zbIke+Ab0lvXWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779529646; x=1780134446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KeOPveaqyd8dlsiWqmuxyf5BwmK59YaNq+M+qF1tXc=;
 b=QFahKhHlzowkmRaIkN8fuenAhWXCdNXOc/tFBBo2L+IJkQ+wYtyNhOYcqHcdYSttpQ
 0WWsMMjtQBG6/pkcpj5Cwe7xFSSBZsmKC1nTxBbj0E0bqBz6RR4LhgDEbYme4gqATfPf
 +xGB9iGjurb80QJd1eRht6T6WKnIm+U4nrJIganlBIbLugKQGq1fOrWh3NapHfcDm88I
 /IFrgEcwPEOd0FYzTRSn4y9XqILol7+2xqyEgECsIH3CyxzzWYjJGvsemOuIfYrJlt09
 D9pr9sDm0RLak5kmB9kDBYllzLRiXFF+u4GMA4/ZWXpUvs7lZlTEYFNb1zoADhu7e2iq
 qIaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dfrYKP/TzFTBKfdWKzoEJUfyoltg8Gu0oUa89EuisrYkFUMlNOqrY6Ua+WuKfe6a7N6dS73I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+9xcYeMfmHqMZkdlSgTCFE5x5Zlm6ngL6sIOl8bHn1+nvuLHX
 ngCSwc5edXXXVKD1eB8VIM+biGCSRjaDgnBJRAZ6jsuA4LkqSS8nXtaV9q81Rij7ZnpHKMyLRE6
 Cr1lFYgvBsv9eCOASMI2NQxjqBxqfcOZtqXQUWrF+
X-Gm-Gg: Acq92OG6DHJopjiSDGKTwnDL8ol0HTdx/R/1G6tvjCpg9ullXnxcAR2yoKzgsGzG3fE
 3/7Zc4HiJTSZYeO3ajPkgGHe6DKRVo2hbeBGmOW9m5Jm8Szwz+v/mm6GhD2BQ66XQuT3HjRMLkG
 Yc/cSYgm8j4HpN62io4kBMDE8jI4O/wpSFYDrixELANMSDBmYpSP+VjLCcQ6lzXnLquUZYwA9rL
 oh81X09+pIe+OaEBWFp+qnXO/I1AsTHgGiT35gLO6Rx1At+wHAWdO3iMJPqMFURT9niLAME+igu
 x+LzF1xXr3OM5aZ0
X-Received: by 2002:a17:907:75dc:b0:bd5:27b7:adaf with SMTP id
 a640c23a62f3a-bdd272cf2efmr318262566b.33.1779529645656; Sat, 23 May 2026
 02:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:47:14 -0600
X-Gm-Features: AVHnY4K06k-YVJhFw0ta5ogVtmvsRk7HXmFlqP-piCLmwhSp2JXEb7s4jkzB-68
Message-ID: <CAFLszTixnZijVs8r_OwOxnMJ8+zJ-hPsurTiLJFcXQEP9Bmypw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_selftest: add ACPI configuration table test
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-05-21T18:50:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_selftest: add ACPI configuration table test
>
> The new unit tests checks if ACPI tables are available.
>
> If yes, it checks if the RSDT correctly points to the RSDT or XSDT.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_selftest/Makefile            |  1 +
>  lib/efi_selftest/efi_selftest_acpi.c | 75 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

>     efi_selftest: add ACPI configuration table test
>
>     The new unit tests checks if ACPI tables are available.
>
>     If yes, it checks if the RSDT correctly points to the RSDT or XSDT.

the first 'RSDT' should be 'RSDP', since it's the pointer. Also 'unit
tests checks' should be 'unit test checks'.

> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
> @@ -0,0 +1,75 @@
> +     if (memcmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature))) {
> +             efi_st_error("Wrong RSDP signature\n");
> +             return EFI_ST_FAILURE;
> +     }

I think Ilias says the same thing, but please also verify the RSDP
checksum (first 20 bytes for revision 0, full struct for revision 2).

> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
> @@ -0,0 +1,75 @@
> +     rsdp = efi_st_get_config_table(&acpi2_guid);
> +     if (!rsdp)
> +             rsdp = efi_st_get_config_table(&acpi1_guid);
> +     if (!rsdp)
> +             return EFI_ST_SUCCESS;

Silently returning success when no ACPI table is installed makes this
a no-op on every non-ACPI build, with no log indication. The fdt
selftest uses setup() returning EFI_ST_FAILURE for the unexpected
combination. Could you at least emit an efi_st_printf() saying the
test was skipped?

Regards,
Simon
