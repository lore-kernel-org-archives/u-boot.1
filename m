Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED04FCD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BE4839A8;
	Thu, 11 Jun 2026 14:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OxbAmm9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1B58407D; Thu, 11 Jun 2026 14:27:51 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D679B838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7e8833c99fcso88055057b3.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180867; cv=none;
 d=google.com; s=arc-20240605;
 b=POFUJVx7qrK4tcdghE/Tt2vBPNUYAFaZO/+OR8vllKxxILHcvbZmISDCP4vqDIWqWS
 gUwypdcETY6EthmujmhdiTsptr8WVuWh7SLoX4N1XNVnIhcghHtmf495rSg36OjtcIEP
 CdBLmZqs7O7J89iflKreWa+faevQ85MGeGFzJZbJraogUddIMszCLB0dVSEnLhoxOYlO
 6YFx06At4/AuuGbMay1KROMvZq8IxIvq19QClesdV/ejkQ+TloL/2iIfAbV/yPthknLo
 ySgs2+3QqFO5p8qT93tYQmUcBd06MDE9hl0nLt9qVBlJBpT4l2RVtxmzitAhwfJsf534
 VvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h8Q5E2fngkfO4pJVSMqrgQpSKATHI+6M5++AEXAWkmw=;
 fh=uukWsy69hdsdcnyJLwUgIJ9fLCYu3jIKWxa+lmy27Xo=;
 b=kN/NSQnI5QFhjp5jpgCT0GyDP0LsNCleXU8E6Hjk1+7N4t/+I33/7adjZNFR+d8Fmh
 X97i6xedYfbP5WCZ7MLvlH6BTcHjjPy+pD47UuR3pjAAhPZxu0NHppluDxDBw3/yOvAf
 ovONsrcSwO15FnoO7HfdNaxwVqPVLZkk3W+jS/JCiF3r8U1+O3evTAn+gXxSKqAuiZvo
 mrEoJT0fgYPTU6qGcFs2eGUsbMgwtVkwvHWiW10WSPnHFrHl9rE+ypSWV+dtZQiNud8H
 4RtFTyNsUy+NILolVTcBkpSWTRtbWgrMMwp3YxsQ6U3YKlMXRuZzdpKuYlfDgh5AHC0H
 LGtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781180867; x=1781785667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8Q5E2fngkfO4pJVSMqrgQpSKATHI+6M5++AEXAWkmw=;
 b=OxbAmm9Rn0aIA76XTWWbU+qKzDJs2rTJjzXpsmCVQ7UxvmXa5CuXgZKLpEZjHstEIZ
 /41rWxtPb9GjESr9rq/EHv4R04BE44S4lO2NGab2fy8xZ+R29kkdJs1x8xOIsQvjEKOZ
 wiHEUmn9SfT4hjKxm2sobR+OLmT/wI5oZDveUkjWLGh7L4UJtd309dOAF7HFnEzFQWz5
 blfUZc4aYQhYAdNG2q44058dBv7MKzhzVtUTr6Uxdl63XASx4UqRXS5CeNKcLyR2es9u
 hGNfA1bhOyqrRYpo49jnzjbuGIT/fIaytx7EzhaXMmu4yT2RtPhkZ4QKX/tiv5qheuDj
 W7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781180867; x=1781785667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8Q5E2fngkfO4pJVSMqrgQpSKATHI+6M5++AEXAWkmw=;
 b=WdaXETjyibwO2aHZZ+VS2C2vi5jWQmiLWaulY+FvYqgoSRtYpXOt1n/HhtFxZGoq0N
 gbCzfHaC0+doKRVvpLUD/+BE6oRqy5kq0At7hmyzFoeBeTNhjqVM802aNwncX+c7JVXk
 dW2LGq5bZdIwtRUFgTSsdR5PUnDv3FlYvBGzjQRhNv7edmrMmuyunfIEds9knJ08SH5v
 hNvyHiO3eSDFrziUk5OgzK5AR1QhjSDWGNvHkpMgJoKtBFCK8lWqVXrXjmE1/TAti/c4
 9XZ5JSYA+gme1QeT0EooU3UzBT56ysu3bRX+j7/lJKdDxlnzUv/2dMYBfoKvsmGsdHCC
 5IZA==
X-Gm-Message-State: AOJu0Yy/3voRkrhTQDcE9lXQofvauxun3wwds8euW+ix6Fwv7318MRZM
 U63s9ARK2nb5O5wAwJI6svZYYcOcmt2q9H8AqguoMtnCJJ6L7lpav4rg9XkuPKLL+ser15RO3/x
 EHGiTDf2/Tmr+RMWgUy7uKSOG5wos0NriWm6Q10cYYQ==
X-Gm-Gg: Acq92OEazL9OG20DedmuwIW8Nqga7B3zKhFUxuGWgwlp5tVU2jQHYsyulvqEIn324QA
 gvxkp7ADX/3c4Gzp5C1/dar2pBfRMNTcPHQ+3KMcviwca0Khq6mhrd1DltFI8Pb9Gzs1Kb3yfB+
 UTcG26i1n3jhhxU6AdiwR3iMUFF5wDOibFQuDc6u9jJlvybmsqL47JT28D7cJYP89i73SGF6d/h
 y5dNaK5KXzkZkhlmFKBZJtVRytu07l7IEiw/7P+MxXzR8Pu/zCO5UE5KmqsIGEH64yK2VJrsp+8
 OTSddiXmr2FsIBApJ6OwUrEc3l2tblulkbqRsqSNemO5Ks8bpKDFLp34YDaWMJHTSBuT3dKyY4M
 WH7LuxryGYhtB1D81boj/jHHFr2OA11mQeIxZtlH7yxNeNbbBBY/zSIaid6XHML7tEANEVrva4e
 e2QtdUE0nUM44qibyysNc0VrSkgPIU0YncNOOP0zhUhKqU+pk5obHbPH8c7ndSL1cWZjSH28X3Y
 tq4v113XvD72Uwuw5v+LDmJITXRzGqcnqi44qp1SI7nH+vEUCQdvEFMmlmO4haIuMXJ77O126sL
 TsUBbWuGdgow9iWn7ZKzt3x9NmIOLimsjoNDjX3xFXYBbU3vTRXmoUN+N9eBG005WG3ncz9QaSb
 zXcZh0C4BbGUTtQT9oA==
X-Received: by 2002:a05:690e:4195:b0:65d:5702:3373 with SMTP id
 956f58d0204a3-662699788dcmr2068792d50.33.1781180866346; Thu, 11 Jun 2026
 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260611092926.578977-1-vincent.stehle@arm.com>
In-Reply-To: <20260611092926.578977-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jun 2026 15:27:10 +0300
X-Gm-Features: AVVi8CdXjsZfFjEFq02vpWnRdt3kqrGQjXZ5_S_eNwVU_P-ylYBk6vqqZdWshac
Message-ID: <CAC_iWjLn3P+=hq4GJxhQZ7Wz7uLbahas3ZZMjf16uzkyUwznCw@mail.gmail.com>
Subject: Re: [PATCH] efi_selftest: fix guid comparison
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>
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

On Thu, 11 Jun 2026 at 12:29, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The `loaded image' efi selftest is comparing protocol GUIDs with the wron=
g
> polarity.
> This can be verified on the sandbox, where two protocols GUIDs are
> retrieved by the test from the image handle in the following order:
>
> 1. Loaded Image Device Path Protocol GUID
> 2. Loaded Image Protocol GUID
>
> The test matches on the first GUID, while it is in fact looking for the
> second one; fix the comparison polarity.
>
> While at it, use guidcmp() instead of memcmp() to spare the size paramete=
r,
> and use the Loaded Image Protocol GUID definition from efi_api.h instead =
or
> redefining it locally.
>
> Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Alexander Graf <agraf@suse.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_loaded_image.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_selft=
est/efi_selftest_loaded_image.c
> index 5889ab12617..48890a66db7 100644
> --- a/lib/efi_selftest/efi_selftest_loaded_image.c
> +++ b/lib/efi_selftest/efi_selftest_loaded_image.c
> @@ -9,9 +9,7 @@
>
>  #include <efi_selftest.h>
>
> -static efi_guid_t loaded_image_protocol_guid =3D
> -       EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,
> -                0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b);
> +static efi_guid_t loaded_image_protocol_guid =3D EFI_LOADED_IMAGE_PROTOC=
OL_GUID;
>  static struct efi_boot_services *boottime;
>  efi_handle_t image_handle;
>
> @@ -60,8 +58,7 @@ static int execute(void)
>         efi_st_printf("%u protocols installed on image handle\n",
>                       (unsigned int)protocol_buffer_count);
>         for (i =3D 0; i < protocol_buffer_count; ++i) {
> -               if (memcmp(protocol_buffer[i], &loaded_image_protocol_gui=
d,
> -                          sizeof(efi_guid_t)))
> +               if (!guidcmp(protocol_buffer[i], &loaded_image_protocol_g=
uid))
>                         found =3D true;
>         }
>         if (!found) {
> --
> 2.53.0
>
