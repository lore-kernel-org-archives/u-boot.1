Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EA5E674AF
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B5883B99;
	Mon, 22 Dec 2025 14:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvVag08b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E51E83D3C; Mon, 22 Dec 2025 14:34:44 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D6C83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-640d4f2f13dso3554040d50.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766410480; x=1767015280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1+jZFYevFZZZfazHGj83XdajQtaGu/ZwzCl8Z4+7oA=;
 b=SvVag08bK+1VNb1CCK0CpOvt1gfTUzt++B+IdKvODOHonMkDVb34fHWyoGSNx0xIAF
 uL8XMS2ix1X5h8tlVH/MDVlIS6r+iUdxn67oNiCiiQejHeNJoVQ1r4EjWnJaFguQlFQc
 hpGbVk11U9E0eV1xxvd+YXvGFOzg1FQphrksMb78KtZ6sZm8DX0T7rL94uxb43KDn5UT
 QRGNiIjq5Z5pKNHEP6hCsDpIQhyv2yax5JaKOMR7gV5PMOgUB1y46iIz2mV0wlN734tk
 i4gvNNx94CSPZ6DYS21L1dQvi7Y5eaxRp8T4uE537pNchL+Xo401rMbqSiqJoshRpvB1
 SKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766410480; x=1767015280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1+jZFYevFZZZfazHGj83XdajQtaGu/ZwzCl8Z4+7oA=;
 b=HPmZ4shRgKLY1f1pNibFOM1sHt0FBxQbljjYpQMEhsTwYoA8eTCh/u9dM6blR3Wnd8
 T8zcVmpnd1tNdFWhNHDaDjbo+gCCqjwzVRiCPij+Dh4XampcwgVT5IzeKfWTjF7qZV77
 MVKRhDu5T1tSjVI4WvBt/nebhIOBocnE3D7Y1PTxLkm2XjM53zu+FI9DxJFAnJELB5kI
 LptXoqgXXVTaVxCPWcTsl1GME3T/TL3OkklRiGztT78/tU8ref/hkeMSt/CGNq80hPeM
 kveKFemGghqpiqAOPnXHQxka7p2Swxy8Ki9KnTFcGCUA8NvlglG1d8VzaYBRRDW7crqc
 Sp1w==
X-Gm-Message-State: AOJu0Yyif+s3c/CEgVWu36y4R7Ts8doPY2E/+KzbDJ3DgC7i0oOEOH98
 LRpUMDmx3D0n2Kajhcej2yDw0uWTX/pHyn4Tl1tME4W5zfXt++MmgczB/fI4DC/ejzxA8GS46pI
 N85GEIC66/4BQ+bDA38BDQJTYehIh38a1bg6ZYf1pEQ==
X-Gm-Gg: AY/fxX4vIuNB87gRaBrU//ARPoVI3SPGIsF9mFtoSQKsmq+HSl40nb/8yJ8IM6GmgQY
 w02zwjFPbhBCKGPi7ZhJ5RchvT+U+rOT5d6FfjYZMAfqlvCC88DWpQ93S0s+vvYgnqDJX5HvLfY
 e4jTJTnSp8xTarJN/etdW6+r7FPxehqzPEfgGvYtKLz5PiH+BBTtqVBb5uozalWGsuo7rvf+1EL
 q0I67XSstj+SftNwzBO2zC3yeI4448RkmjSiOj8ubFGPzzB8dn87Q3wsz7k7oxjQ1iUCIeW3YvC
 yRBd9f4U39kyn7Z6bSYySMWSLTgrRQgLEMfVs/gLCEOxAtT98qr9EiwyrCfmYHIDQBMjpD/w9ch
 bA57CsgkIwOyn3vqJqqUuadI4LFrrZrXFVZx3jZz7wpTAXwRYJipKFrrNkShKXjRNaWotncrWey
 G1PVWMmtbRAOsebg3hi1HVzSYi7XnycpUgvX6IWx1QJnPwSTkjRBS2wONiTzAKLNF+708n8Fj3Y
 lq6lqA48Bbk5+gB1Ai8xfqknCZacoqoYKl24SRKWCZfdxwFuQ0k/rrSyrhKNNMJHhvitACaLzL2
 61bh59nWk9I2274KxYN5DWPs/kS2fdULWzZ1yAF7Ryw=
X-Google-Smtp-Source: AGHT+IEh19GQ/ArmFJ6EH5/pQHc6oGnTjMMcBjk0nqetINA45mtXjWeUlL7jA4dbLte3l5Tqyy1z6Xz+lStNvaxtD9s=
X-Received: by 2002:a05:690e:189e:b0:646:78d8:d2bc with SMTP id
 956f58d0204a3-64678d8d459mr4726446d50.32.1766410480374; Mon, 22 Dec 2025
 05:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20251219214812.168957-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251219214812.168957-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Dec 2025 15:34:04 +0200
X-Gm-Features: AQt7F2oQ1TPjax84N2eJeHG0Wt3BBqJ2e1TP2SzcJRJoIrmDGWbLIHNehOzbOTI
Message-ID: <CAC_iWjJBNSeTCNG96EnNNLc8RGhBq5mRCc88Z8TC7WktHDiYAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: remove unnecessary __efi_runtime_data
 attribute
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 19 Dec 2025 at 23:48, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Assigning a single variable to section __efi_runtime_date while the rest of
> the test is in the boottime section does not make much sense.
>
> As we do not set a virtual address map here, we don't need a runtime
> section.
>
> Update the variables at runtime test.
>


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks!
/Ilias


>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_variables_runtime.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c
> b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 0886b4894b8..fd570d673f0 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -17,8 +17,7 @@
>  #define EFI_ST_MAX_VARNAME_SIZE 40
>
>  static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
> -static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
> -       U_BOOT_EFI_RT_VAR_FILE_GUID;
> +static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
>
>  /**
>   * execute() - execute unit test
> --
> 2.51.0
>
>
