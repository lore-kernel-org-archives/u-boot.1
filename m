Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE5BFF8878
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58E584660;
	Tue, 28 Apr 2026 20:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NLviuyvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359AE84664; Tue, 28 Apr 2026 20:05:16 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077898465E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba36357195bso1384562666b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399510; cv=none;
 d=google.com; s=arc-20240605;
 b=I4ikkkreg1oKrWUs7NimJ9wa0Uy72LNmCXkR3bH+yj1DKlSF+zmWsUqBDKVoJCf6bc
 q9R39krs/SaW3bKoy5TVsZIwk4Kpu3AvV6dTaefkZtOBvGXiE/ORCG2MAzTBeZMqAKL0
 oMGOAbP9ykIa3jhYfMBqHTNAaSpCSOiCZe114zy3QefpjhaMXPtBu/WnbQa7rR9/0UP1
 4KZSVNt7LL9z6fpgYeF5Im3h/RUjyr2mAxoU5zw2Ojt9C273pt8ve+6ZmwBVQ1ii2RGV
 jyjZgmlazS1Ei9wMDeFAMfi8hsPs9zo0fQOLzBqsn24hTmF+l37K+MUaVumPYxRHF0Bd
 AxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+TDOQyl8qmlYCZ6WAa4gduwd+h2iRfMfFXXxPwGG5k4=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=VHgumEUSVwu6s1W5StcVxp+Q2CIxy4AxDTTdcymzr6nM1AedjyWNFkyq7KlqwvYRKi
 HKz1fdT/CvpINxcTKjrfBpJJ72KMVfmpLA6DhOqbOqvBdDQRe0vgSXUNt60PYqNlOx4c
 vyJ60Ofpr88sYITost9ww6U1kqRaT6N//BGoVZRGQodZIBOq7bGZWzcJubyYLlXw7w6A
 mOp34QMd2nBZb6NvcT1lNJsA4yN0gFutIflJxy8BYENlsr667lzZeFBsDnCz77TVDke+
 ojJHft8SissUopoVwwHX2KRR/ffNfxWEsFpoNWewwpgCCISdQzCfLiLSFhAUbT0Xk06E
 y5RA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399510; x=1778004310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TDOQyl8qmlYCZ6WAa4gduwd+h2iRfMfFXXxPwGG5k4=;
 b=NLviuyvICEHoysxd3/ETPEOxqXLYoT7jel9XLgShDKEMMiRGFLIpf9oXSzw8IFRNyV
 UYWE74jUdHeqKYYOKrxLFsTEM28vgQ4RtjihWKiK5b9C3acUba4rd5GO1cE+Tem0qTel
 P1tjuKdzeaK1xlr8c+M5w34xDkB6BxFdpXB9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399510; x=1778004310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+TDOQyl8qmlYCZ6WAa4gduwd+h2iRfMfFXXxPwGG5k4=;
 b=ejYzYlq9oRiEH7agLVAZJWJP1UExMw73YmCv2Uji633VRW1jt799EobzQxnRxU5NVS
 WU6rDFCVWcWbCdAqYbaFcaHr64T0wpLGeyg+tbouAWjWUqumtf1MW4tahtf58TgKDm24
 kP8LDndZWWYLEtRrBHuL07KgooFyYklrWCTocNiBG6ZsuC17NdzU7Powbk6nsed9Nou/
 uA5qvBJZKWllqJBuRWa1TeMuUFc5Fw4Giz6fTlFv1eukPHoKCRJ7GzCySHbeQK3qW9FM
 mbBeEwpCLdJSCpx4ocTic+Wg1PxvIcILi+SLrPK5Gt17bSEuyXuJrQcO8BNotPdZOJSj
 1mkw==
X-Gm-Message-State: AOJu0YwNAVVqRmOoFw3AqRTfnmwbwOJ1bkiM4ZuM9v6FL3TzXyJizkHo
 K9HqX4I5pc5w/IXwZKHgulmNp6C7jo6wFCPpF7a5CXw5WYwrW49a8ukMtdeI3yIfBJYQIkaQfoO
 osyNMFkVdsASOSc31qAKA/qwaABxJQ76IFEVX9HzL
X-Gm-Gg: AeBDiesnmmzzXM/75B3vqBIe2BxStZTkSnDbz6H5DPHgqBM/XPgFmqmel9JlK7rgasr
 Rf5KClBKq06/YeX5p6PPabGwM3cXpoCP5oWqXup0J4qzsIGWSYPOvQaMyzgRsesSt1+oTtNEmRD
 pEqRortr68xi0t3aC0mLY0Lp+U4+eObqgyghiVppHJe+k4KzxlKg6pHz5sRe478ll9vLllOuY7Q
 OuA5/xN9ViuXD0mLQi+wjsQpCVmaakMkcgamMndyePf/iLjpqihvfLchKzWxaRfSoaV33KCas0E
 7f8c8wbsCYWt52ld
X-Received: by 2002:a17:907:d30e:b0:b98:1062:afdc with SMTP id
 a640c23a62f3a-bb93e64a2b2mr25702566b.27.1777399510282; Tue, 28 Apr 2026
 11:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-8-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-8-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:04:58 -0600
X-Gm-Features: AVHnY4Llf_Kdgmatyws2pCr9un87iCKeMLuHIElrzDx9WBmRR6Hh-ZF7wuzSUA4
Message-ID: <CAFLszThODjZiHNnTnKFUV=Sx2dZPeW=t+5t6Yfh6wcQDwjMkZA@mail.gmail.com>
Subject: Re: [PATCH 07/12] efi: selftest: add runtime variable tests with
 non-volatile storage
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi: selftest: add runtime variable tests with non-volatile storage
>
> Extend runtime variable tests for persistent storage
>
> Previously, EFI selftesting of runtime variables was only supported
> under CONFIG_EFI_RT_VOLATILE_STORE, which uses VarToFile to simulate
> non-volatile variable storage. This commit adds new test cases that
> exercise runtime variable operations for persistent storage.
>
> Features tested:
> - Creation of runtime-accessible variables (set)
> - Retrieval of runtime variables (get)
> - Deletion using SetVariable() with size =3D 0
> - Append operation using EFI_VARIABLE_APPEND_WRITE
>
> This improves EFI compliance validation for non-volatile runtime storage
> scenarios and ensures proper attribute enforcement and variable
> management.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/efi_selftest/efi_selftest_variables_runtime.c | 106 +++++++++++++++++=
++++-
>  1 file changed, 104 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -39,6 +46,80 @@ static int execute(void)
> +     /* Compare the value of EFI variable if it already exists in non vo=
latile storage */
> +     if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +             len =3D sizeof(v) / 2;
> +             ret =3D st_runtime->get_variable(u'efi_st_var0', &guid_vend=
or0,
> +                             &attr, &len, data);
> +             if (ret =3D=3D EFI_SUCCESS) {

The two-phase split worries me. As written, phase 1 creates a
non-volatile variable and immediately returns EFI_ST_SUCCESS, so a
single 'bootefi selftest' run reports a green test even though none of
the new assertions (append, delete, re-get) actually ran. It also
leaves 'efi_st_var0' behind in NV storage if the user never reboots
(or if phase 2 fails on an early assertion before the final delete).
Could you split this into two distinct EFI_UNIT_TEST entries - say
'variables at runtime (setup)' and 'variables at runtime (verify)'.
Then the user (and CI) explicitly select each phase, and the
persistent state across the two is part of the contract rather than a
hidden side-effect. At minimum, phase 1 needs to print a clear 'test
incomplete, please reboot and rerun' rather than EFI_ST_SUCCESS.

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -39,6 +46,80 @@ static int execute(void)
> +                     return EFI_ST_SUCCESS;
> +             } else {
> +                     if (ret =3D=3D EFI_NOT_FOUND) {
> +                             efi_st_printf("EFI Variable efi_st_var0 not=
 found. "
> +                                     "Executing First Phase\n");
> +                     }
> +             }
> +     }

Any return value other than EFI_SUCCESS or EFI_NOT_FOUND
(EFI_DEVICE_ERROR, EFI_UNSUPPORTED on a platform without an FF-A
backend, etc.) silently falls through to the volatile-store path below
and mis-diagnoses the failure. Please fail explicitly when ret is not
one of the two expected values.

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -279,7 +360,28 @@ static int execute(void)
>       } else {
> -             if (ret !=3D EFI_UNSUPPORTED) {
> +             if (ret !=3D EFI_SUCCESS) {

This flips the contract: previously the !CONFIG_EFI_RT_VOLATILE_STORE
branch asserted that runtime SetVariable() returns EFI_UNSUPPORTED,
which is what every board without a runtime variable backend still
does. After this patch any such board fails 'variables at runtime'.
Please gate the new behaviour on something like CONFIG_EFI_MM_COMM_TEE
(or whatever indicates a working runtime backend) and keep the
EFI_UNSUPPORTED expectation otherwise.

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -39,6 +46,80 @@ static int execute(void)
> +                     /* Append an existing variable */
> +                     append_len =3D sizeof(v) - len;
> +                     ret =3D st_runtime->set_variable(u'efi_st_var0', &g=
uid_vendor0,
> +                                                 EFI_VARIABLE_BOOTSERVIC=
E_ACCESS |
> +                                                 EFI_VARIABLE_RUNTIME_AC=
CESS |
> +                                                 EFI_VARIABLE_APPEND_WRI=
TE |
> +                                                 EFI_VARIABLE_NON_VOLATI=
LE,
> +                                                 append_len, (v + len));

Not sure if it is possible to align these lines properly? Not related
to this patch, but the EFI_VARIABLE_... prefix is really too long.

Drop redundant parens around v + len

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -39,6 +46,80 @@ static int execute(void)
> +                     if (memcmp(data, v, len)) {
> +                             efi_st_error("GetVariable failed\n");
> +                             return EFI_ST_FAILURE;
> +                     }

Quite a lot of separate sites in this hunk print 'GetVariable failed'
or 'SetVariable failed' with no further context - when one trips in CI
it's impossible to tell which assertion fired without rebuilding with
prints. Please make each message identify the step (e.g. 'phase 2:
append SetVariable failed', 'phase 2: post-delete GetVariable did not
return EFI_NOT_FOUND') so a log line is enough to localise the
failure.

> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_=
selftest/efi_selftest_variables_runtime.c
> @@ -3,6 +3,7 @@
> + * Copyright (c) 2026 Arm Limited and/or its affiliates <open-source-off=
ice@arm.com>
> + *
>   * This unit test checks the runtime services for variables after
>   * ExitBootServices():
> @@ -22,7 +23,13 @@ static const efi_guid_t efi_rt_var_guid =3D U_BOOT_EFI=
_RT_VAR_FILE_GUID;
> + * For EFI variables in non-volatile storage, these tests have to be exe=
cuted in two phases

Please use 'non-volatile' (hyphenated) consistently in the doc comment
and in the inline comment a few lines down ('non volatile storage');
the rest of the file already spells it that way. Same nit for the
commit message body. The commit message also opens with 'Extend
runtime variable tests for persistent storage' that just paraphrases
the subject - please just drop it. 'Previously, EFI selftesting =E2=80=A6 w=
as
only supported =E2=80=A6' should be present tense per U-Boot conventions ('=
EFI
selftesting of runtime variables is currently only supported =E2=80=A6').

Regards,
Simon
