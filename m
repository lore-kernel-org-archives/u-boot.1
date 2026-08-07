Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BDCC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8394409B6;
	Fri,  7 Aug 2026 20:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jt1-DlaC3vKV; Fri,  7 Aug 2026 20:45:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D0B04099D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135522;
	bh=JjDOoyR5fKWKhi9GZ3A4T2WoZucbUWnn4QHzqSvaahU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ge5ZBHVDwkmmfHvs1uwsiYCPIoDWus4ux/v6uPZfBewPuWhtEtLqYWDLgbVDZICTC
	 e/LizQM1YSXX1HAkGxZsQF95n0WbfzqnyUN1r12N4CbgXbm6HMXzm8iAF8wt/A/MlE
	 xQqC3sTtK3ZyWwxm3lrU4h1/ShDPxmwP79oD9zW8XwSY2Wt0/s/JOFZNP8ktoW9HI+
	 K4l3QqKEyO0sbaHe4uu0eFwdbdZAEhqnRKF8KUYpzgSkocGaVy6LjGkJdoibQu7XGV
	 5pbrQrsEaKJVPriyAPo6fiukHQkVnHcK2XU+fHU5MxeARdOvvscmktwLjHiURq9ckG
	 3e9PR7z/9dBag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D0B04099D;
	Fri,  7 Aug 2026 20:45:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F38E296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 817D1608D4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4l4xcujKH7S for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 96EA7607EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96EA7607EC
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96EA7607EC
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:19 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so5536002a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135517; cv=none;
 d=google.com; s=arc-20260327;
 b=Tfq6YGv0tkTOx50yGjDzkyup5lt3IKBsBvKszEpcQLMdUisNzRWj81cEcGA0QfljXm
 UWj/j9syBDOGrnARX3lihdnQ8OuVNHJ3M3XYjWRTE/I16mrXztQFda4APr4DsG2wiCAQ
 deeDPsji1bKMyj4hPV/gM1pZK3LoYcUcTXfFREoxEtcYbjAqAQbZeC6RujWUtfox78W3
 BMkckQnbBeyr942iFVoTFqhMOaVyHteFC1lSzY+uullDGrIhj5t5BUNsRRMhvSBQjasr
 dvWu7w/JGvXE5/UMHuFHzIUyOPRKa9wQKqrBYD0HNCdTHF049tMpN0JJaLeA50DiCIUD
 Pq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JjDOoyR5fKWKhi9GZ3A4T2WoZucbUWnn4QHzqSvaahU=;
 fh=ijpGqnd/DhBct2Cw5aDmEJPs+G5NkZyVrRaaBz7981M=;
 b=CD4cTjnydHJc2ucUxR/uUEWVyqUoZh9FIW+H5VZG3l9JRx2Kp2rJvSpiA0W0+7kxqu
 nL3s9dRlVVOsoHuAmNgbo1YKYEI/WgJt6+8oh7H0mUwwmwjt1FGk7MTBo4tbzj15oyH1
 rcT8cuUz0c9sUmH3qgK5Ug5q24pYJjp/KItym8HCe+8X44Bn5wuqpHWWLu/01fhMqaO3
 rWDH2wkC52WME0yoIkrTWzgp9a1UQYwfwm7urZuSpsmbN7ixTjN5zsCfOkgSCiKPNBnR
 wo6ie5Sv8IyA9Ecv2+XJ2WvidsqCeSebL53RFQYQSCodiPoZsKYTg1U0XWtX8hMHQV3N
 aKvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135517; x=1786740317;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JjDOoyR5fKWKhi9GZ3A4T2WoZucbUWnn4QHzqSvaahU=;
 b=CG35Cy6mGF8Z8g5aQQEutZ+bFgEkC7C8tFAT3NYU/o8I2pl++v4YFBl6hOZDy1OVh5
 /DW6nk0IdhPofgM56NNAoHpWp8rsh+u4gV98Ql3/n/TR/SfuCM0GGgtLCS/eEDX1qv+w
 NhQZSgUvExw8Qbrv+XJjREXd51hChM9tZh8MfvW1/CjPaGNlRwo2LHwbk5GoVQwKfiWw
 ydQL01PhKCzkh61OhH38730/bMWmLCOXr6hXH+jCTFmK7gtYNBLIhZrf3ZeK8Wbd5Ec4
 aEYKom29sMWXcxPntWtUsrUna0HeEFch0tIeKVoNGLPEM8l7/PNAMi23ajvSr7blua4z
 Ui/g==
X-Gm-Message-State: AOJu0Yz8uUJn3dERkw88dDh9aJKCaWqvRZp5G/+OSECongFKFM/bMKeL
 Z95D7/KE9nbnEsYrsL4T+lbnavfyTGPojqFGYQoDFuin9XeHcpmWUbXgFD2Dgrfm7LgjjeiY8Lv
 9ANay6cv2udPkT/VH761/7z+HwgQi/ipqx5cs1B6X
X-Gm-Gg: AR+sD11xtZXEH9sEHMqv8Rl7czQaWYm2E3V+4JHVxlRTELFDxNNmhTa1knb3OYejjBo
 flezDT/6MgWmnW5+c/esYiaadK+5by626PLJnTktHJmwpwf7Vlf6HozkDc/znjc5RSdJoKifmk5
 bfmAPijLDPUFfZYI2iLH7aVYdfIr9XRe8hrSAMwMQqT7WQyg3EvhuXjJkzyz8JcbceuCqC1IV6m
 beZyPoF/ykD+At0DOOKoZ9Wvnq9MtJpt9nB/Q9l4Sci0WIlICaNRA8cyTZTVmjvToZU99OuDKNQ
 gTCT2fetaLoPjmjNQbrdCAGEE7rtsCMcixzT5W9cpfD1
X-Received: by 2002:a05:6402:4597:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a1f2488fb6mr1487027a12.15.1786135517420; Fri, 07 Aug 2026
 13:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <20260807-riscv-full-fit-support-v1-5-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-5-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:45:05 -0600
X-Gm-Features: AUfX_mx4o5pr52pTEo0VoiQl3lcCNZVj3_AHSXzaTG-auhb4gCpXoalxi08FfXU
Message-ID: <CAFLszThEAi0i32zbBQVA801Jt5PBwvNHdc682V66BUMTHd-g8A@mail.gmail.com>
Subject: Re: [PATCH 5/5] spl: fit: Add test to check loadables
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135517; x=1786740317;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjDOoyR5fKWKhi9GZ3A4T2WoZucbUWnn4QHzqSvaahU=;
 b=i15++elFLyPJfFl6SUDrGYuWqfGw9i4eslEkDByEZic/1P7pfcvym5dok+xdfBZ0Tv
 EAXHkQ+LB5Z0RA0k4jBxn34d2aMvmisRVWlSLIfsubYK0EIkCUC+32JPbd61+dCcHlPE
 BOfu+g9ouJDomjizpjDDDEt6xrS+SFmkF2Kho=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i15++elF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Nikita,

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Add test to check loadables
>
> Add spl_test_firmware_image() to check lodables correctly provided by
> spl_load_fit_image().

Same 'lodables' typo as patch 4; also please can you reword to "check
that loadables are correctly provided". BTW I applied the series and
ran this test on sandbox_spl - it passes here, so thanks for adding
sandbox coverage.

>
> We create special image with U-Boot, firmware and empty dtb. Then invoke
> spl_load_fit_image(), check everything (including dtb) loaded correctly
> and then check if loaded dtb contains "/fit-images/u-boot".
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> test/image/spl_load.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
> +     char *data_uboot, *data_firmware;
> +     const char *uname;
> +     ulong check_addr;
> +     char str[100];

'uname' and 'str' are unused, giving build warnings:

    spl_load.c:439:14: warning: unused variable 'str' [-Wunused-variable]
    spl_load.c:437:21: warning: unused variable 'uname' [-Wunused-variable]

Please drop them.

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
> +     if (fdt_end_node(dst)) /* root */
> +             return 0;
> +     if (fdt_finish(dst))
> +             return 0;
> +
> +out:
> +     return total_size;

This is fragile: fdt_finish() shrinks totalsize to the actual
serialised size, and fit_image_get_data() locates external data
relative to the aligned totalsize, not to prop_size - so the data
offsets only line up with the data at 'img + 1168' because 1168
happens to be exactly the serialised size. Any change to a node or
property will silently shift the external-data base and the test will
fail with a confusing memory-compare error. Please can you do what
create_fit() does for the external case: check that fdt_totalsize(dst)
does not exceed 'size', then call fdt_set_totalsize(dst, size), so the
layout no longer depends on the magic number being exact.

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
> +     if (fdt_property_u32(dst, "#address-cells", 2))
> +             return 0;

The file already has ADDRESS_CELLS and fdt_property_addr() for this -
please use them here and for the entry/load properties below, rather
than hard-coding 2 cells and fdt_property_u64(), for consistency with
create_fit()

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
> +     /* opensbi image node */
> +     if (fdt_begin_node(dst, "opensbi"))
> +             return 0;

The u-boot and opensbi nodes are written with two near-identical
20-line sequences. Please can you factor this into a small helper
which writes one image node given a name, type string, data offset and
struct spl_image_info? That would remove most of the duplication and
make it easy to add further images later

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
> +     /* check loadable and load address recorded successfully in empty dtb */
> +     noffset = fdt_path_offset(phys_to_virt(fdt_load_addr), "/fit-images/u-boot");
> +     ut_assert(noffset);

Not quite: fdt_path_offset() returns a negative libfdt error when the
path is missing, which is non-zero, so this assertion passes even when
the loadable is not recorded. Please use ut_assert(noffset > 0) so a
missing node fails at the right place.

Regards,
Simon
