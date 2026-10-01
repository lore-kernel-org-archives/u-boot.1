Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA941CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6486A60BBE;
	Thu,  1 Oct 2026 01:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qI6u8gKerGE; Thu,  1 Oct 2026 01:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 93E5A60B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818328;
	b=mzp+OkyBdj0rMERnE4UgBin6nvid9EE/c+tBhZ7/Wp4dx8PY8nynmd4uEQ+KNgPnaNmy
	 2vY50zETpuy8wE0CZVRlfUfkQoZGrnyz3f/6zaZt21c9gvPpu5c9CJhKeuB4eUzKo8LmL
	 gwBqFMC12Ui5U1vhnPAtzeIxpv+hBGOrW033EqKvpn8eECn1R9gsQ/s+GcIbtuMI23tDk
	 xSPvyss5+eQkTo2WvbqM2d16CqIRRPrtRN6wHwV4wdVQbenRFmm0dAgMp3ByfXCyStcGI
	 gLmSmzoYhYxMFE12T0Blfal+bs45JhX2rRUkt57IMBaCZp5zNowTjk1OMQH70gACFSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790818328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
	b=lFf30Fu81JZLPYa8f5SX5zKKXHXrmY6dlCXLwdK19OAnXVi7tg4qlT0k8l1eR9IypkdG
	 VSqfUslwuVAMa760KPwS3n6Wi33cr/v8WMfw6M9D/2kMroC6lFqCxe2QF7aPQgc+959Gw
	 Afqs3O3K7gSmLo5G7LPijao2pX7CS6GhJuYdtsNlcm0DRb+vXDkoLFCkWIJs1IbUCl3gj
	 f3B86DA8ySa34ZT46WWgjjSRG/pLN6o/zta5a4jIBQYP9g7klHtRcEbdfo/siqqR/H1we
	 AUjS72Xq7vpktinusc0AbrSQfTnqRTBH82lHIcYbOkry4qw6Nv3GCue1CDVGnjCpHxA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790818328;
	bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpXMiOFtrV8nhAKAYrJsvUQWT9U2VlwTj5DcslLBm2pXuoEjcKjnQfLVxUeCk4usv
	 zQBD4nwwxYOTnO6Q6ymayw6QDxt4vauJIs49p/MlCfA75XxJPnhwgq47m7SkRXwPGt
	 MuRAJjbYPOmdNUDb2Z5nWtAWEes5FaJTH6KOwXe0Xag/0e/Y9LNiKm18M40Qe/42oa
	 yjlN1PIsTjwUV2mCy04FGlv041r13xAw0Tq65jQXNYgiYfhiSs6g2pdxSUFgkreC0n
	 zDXHK/mQx0Xwqt+AMdiVAOHRacF6CgbGjYKytl1Q29hXhLf5d5XyppH8NH5PQKSori
	 TgaP4vn4ZCU+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93E5A60B74;
	Thu,  1 Oct 2026 01:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED454116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D18EE81225
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPAAobVS9ija for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 276F981170
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818326;
 b=Z/qIRyj3G3ABOYC05+Yb179YgAsyKPgORuFspYBQamSYD53OqMGGFo/a+6RGeBLxBygd
 Z8vZ8SP0RlAKslzK5aLI5IDn61wGGh8Qfm1osC4/0wCn9IYZmQ9CWQ7hjLsIKVtSPpUth
 umwrm5H9VB6FHiGQYbqnwUY3tjJL+m0J2vU7jrZoyJjhZov1CxZqyO8BnqzCr0nbuFQlU
 TonUKoY49comgkgmcm8H4W9R++fOSeGWUxbGPVarcsJgdhctP84x4aci4qL45MzewVcye
 Qz+ABOvOL0tAokZ40kKwRHyU9NYjaqPf0PFPTOgjZmFyXGgXMVliIsoAZT1DjoJoebw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790818326;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
 b=Nc1csXF3b6FQmVHQ1dHva4Q3D/qSuKFmnTNYcaEHRl8xKgtJNNzRcGet1JFiMR1IH3Ev
 bCEJcrL6lrTWx9CXEusMQYS1eWQ1JooIf4r8YgSRVtJr7rUHjaBDtD7JeCuD7CotQg8n7
 WvItA6QqmZh3AVldnHp5KiRAeGQLeL03rS/0sNcNogSIuYG0x+d5K06mv5uFKmWMEP1G9
 2QkOQRWopSW/8W75WNUlRtDpPTWvnTiEtiyb14fFBBJLs5/oeBWqIfO8dPmGK2i2SIJtF
 aoqTyGIJ7TOtusxZZH6GKRD7Bc6diyruDMlkP4+NXkGFm4obw3x3VJyzse3/48rT04g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XUq5WyNr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XUq5WyNr
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 276F981170
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:32:05 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so39132655ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818325; cv=none;
 d=google.com; s=arc-20260327;
 b=jBXy5vZn7R45A1lEPwQc4wsIuePd/aGDi+jatBLZlTwLvOhND4f0cBToKQHmmTaTd+
 zjqf0a851V5ev1SIQarBOsMLotAp8oaloChIxjte0Tw3f0FUEUIiVReiR6xsHqJVqzp/
 E9eD3C6ELV1JiGn+cbUScj+gVczSCW/ZUSXsxA9ZmAcbvCuMjo2tldJ4BWXSueUPHWry
 +4+BLVV+srLJdeoVD+lPorswAbN+0f6JJ/0KCT/+gdn3Ml3D9ZgIj1Ul38EHT9qRNuuA
 +qPr/hEs0nQTBvdf7ET/T/Af+hJ2IFRn9OdMA1U9Qd1Wmw6d5Z0RP8uOAcNNQ9zVCEf9
 m57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
 fh=f5e1hBatHq9z+EW4hNnDcpr/2K/cDwMlmeIUSk8XQYw=;
 b=KtbRa2xvfaHV/Xp8vJBi863R5qW4gODlq8VpWPu0qIM7iAyFPpTEgWAyqK/mL/ME4o
 4d3B6U44FzHTVWCSbfjm5L6XsLEnky1Upu79YCK7x1kaOSl+dJCkH9SffPC1f6OvCtLI
 r6B5wtEo5FZfGn5yt0GelHjzyUSwWF7PS5eErqKXg5Fy35K/dWQpuuxeuUAPcukeMHjc
 /Nc8tIYqEV2bH1k9q1gUAkhnkq7kYduFl6RcGjo32KiFY+KVbEwZH1jSiYh9kV93dsmU
 zULxLO1vmE0d1LnkDliWW1ZGnSXUDlI1IS+tCpOjG8L3exa4Q2rIn2palJHbLJ5PB86V
 Zt4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790818325; x=1791423125;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
 b=XUq5WyNrnQBR0pLldnmK6ePRX9kktcb+WFRX6aB9KZa6MBQSLsfA9F9kfcuUZutmNE
 7BiwgxkL7xnsPThG8Se6/9zvFuCmBfpV0ZcDa0G7Xk0ximwH5IyMfCB7jIaXel0/we9A
 44U+cLtn0OB19QLK98KGEjVhr/G9n1RhhMg74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818325; x=1791423125;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TzL2ghYVwCYes/35BqL44QJOY/wrXFKL3nnxhrXQsfw=;
 b=v9iyeUUuis/WICtFKF/2EbrxgwSL6el1k0NdJim3BJqmXO6McfQilhkXRQmUEpOrTs
 2qrZY0rCS72Ga0ua04g8f9oWwAh4BnCIHbx2CMIbj3rwbpbEntkWMwNQ+ayStMLJJPzH
 RS5NYg+tLlMrpNJtHvSqxubhlcWl79qcUv6dV8pLJVlHfj2DBuhBiwESyG9ZkTfcKHFA
 Aix+F2nHAskkjAHIHw6m2vRns5Y6t7TQMa+wNsMfwpSarSr4qlKVLNTGRlrj0+NrDWxH
 soiHmdpXvuVWLg8OI7+xpD+CwqLFUtsV5q5jVO4JbhLYNHC/nI3zFTNig/mP7zi+5q52
 GFmg==
X-Gm-Message-State: AFq9FYLf8rcgUfjRGtRoL6E1lZo1Mf9bKtg9DzlAD9hO0om9pXu9Lb1Y
 9DfoCc+KBsMl3NqrTDATxC3EzD7WgL82t3lhETeil2Yt6/65LA1Rcvgc+fX6if9+JHOwkvnvdNR
 1mZjmCDZ8gAF2q46vmDXIsB//HJTYtNIG7dphK0ki9W/PyqyIw10qlw==
X-Gm-Gg: AYBFou150X7ZYgvTO/9gyBublNb7cJSOouh9lBQpB68/y5c2GEnmSc6ipBWivtgiPoP
 mDYuCCBj2nvVqNUohRcKHmgG3YYpCDyVrERzkUcDjSAR9tDMuqaoqRvRT+YeOCKLOgye1J7eas8
 h31OilAN9JUwcVpqkN9a5qZHpWkcqaUZVMtVg2lO6zaE19uKwoDbDVp/oeRjior81EitAj/wqCa
 d/YA8bF/rKfGIijgnCJ3LR/Ct63rkv+ZiBprG2q1z8wyPUre3MApgciELVcopbaxff5iBW0BXkN
 E+i5oqCaxwGkirq7rhZAoymJ6fYiIDT3lg7oGQ6HW+YyWVdK+0M36Yxk
X-Received: by 2002:a17:902:d590:b0:2dd:ad73:c98c with SMTP id
 d9443c01a7336-2e2e4b4a5bdmr22646165ad.36.1790818324696; Wed, 30 Sep 2026
 18:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-2-e943530349bb@arm.com>
In-Reply-To: <20260922-authi-v1-2-e943530349bb@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:31:48 +0100
X-Gm-Features: AclHuK9Lt0wgc1pa2Eb9EjmG1u8kS7FrMbVVfmBtpVu_gXtXHVCcj4q7_uy8rsU
Message-ID: <CAFLszThhM2msTbVUmtAvaZzepE6qmb1w-GMb9SV5xYZY862BXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_selftest: add minimal fmp test
To: vincent.stehle@arm.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Vincent,

On 2026-09-22T14:58:39, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:
> efi_selftest: add minimal fmp test
>
> Add a minimal test for the UEFI Firmware Management Protocol.
> At this point the test only does the following:
>
> - Get current firmware images info.
> - For each image, verify consistency of the authentication flags.
>
> This can be tested on the sandbox with the following command:
>
>   ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
>                   bootefi selftest"
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_selftest/Makefile           |   2 +
>  lib/efi_selftest/efi_selftest_fmp.c | 135 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 137 insertions(+)

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,135 @@
> +     /* Verify each image info */
> +     for (i =3D 0; i < desc_cnt; i++) {
> +             const struct efi_firmware_image_descriptor *inf =3D &img_in=
fo[i];

The spec says callers must step through the array using
DescriptorSize, since firmware may return a larger (newer) descriptor
than the one we know about. U-Boot happens to use sizeof(), but since
this is a protocol test, please can you use desc_size as the stride,
e.g. (void *)img_info + i * desc_size, and perhaps check that
desc_size >=3D sizeof(*inf)?

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,135 @@
> +             /* Verify authentication */
> +             if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
> +                 (attr_supp & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> +                 !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED))=
 {
> +                     efi_st_error("Bad AttributesSupported %u\n",
> +                                  (unsigned int)attr_supp);
> +                     goto out;
> +             }

efi_firmware.c uses IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE), so
please match that. There is no SPL variant of this option, so
CONFIG_IS_ENABLED() just adds confusion.

This only checks one direction. You could also check that any bit set
in AttributesSetting is also set in AttributesSupported, and that
AUTHENTICATION_REQUIRED is not set in AttributesSetting when
authentication is disabled. That would also catch regressions on
boards without CONFIG_EFI_CAPSULE_AUTHENTICATE. What do you think?

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,135 @@
> +     ret =3D boottime->locate_protocol(&firmware_management_protocol_gui=
d,
> +                                     NULL, (void **)&fmp);

This only tests the first FMP instance. With
CONFIG_EFI_CAPSULE_FIRMWARE_FIT and _RAW both enabled on sandbox there
can be two, so using locate_handle_buffer() and checking each one
would make the test more useful as it grows. I'm fine with leaving
that for later though, since the patch says 'minimal'.

Regards,
Simon
