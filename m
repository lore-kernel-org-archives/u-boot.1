Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51963C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897BA88876;
	Wed, 24 Jul 2024 11:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QKRkrV6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9968888D4; Wed, 24 Jul 2024 11:30:35 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F4288829
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d19c525b5so2390993b3a.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721813429; x=1722418229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ugNs40o5UgDkJkX92McbW7jL+wfTcdMcsSJzFalHK4=;
 b=QKRkrV6s9azCZntyD/g+B2ha6UXt+vO+EnBzt7wBb9buNWw/OcfUUKRhxr7yZTdxeM
 bJB66dPqP52YqFMh0U8giRpmDWY8MLYFPiLFNfpfFtJvZCv2Uut2sJvveMJf4DGn6YiI
 6xvxI4ArIC54oOEufVwSdaYnrv2Q0ZBh8OKvND7y53xi1WlL17nyhITx392TUllTO2IK
 /3IfqaQzHTcNGkqHQEAE1vaJ+97V4D7MWOMpR1/6fZMLVt4/kRqdz2EGi5jgBl3fDiEK
 07HXkVI3lgCo/tLSHpoEwqjt/JWUnvpKXTDCyJ2RMSpPKcoXDHW7152D8fHW2D5iAMY9
 G/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721813429; x=1722418229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ugNs40o5UgDkJkX92McbW7jL+wfTcdMcsSJzFalHK4=;
 b=qT0L/B3FicrGmLCLk9n85A9gITbDgmdZ4vDO/O4LiSEDm6/gUh6zdIdqStgP8c3E02
 CGfJrVKOQU96MNWtZKs2qRHHvz45ew4jILivs11BRjMGi58oRl+gepBnrIOJfdwKYCXZ
 9SgtyWNAGdbwNY1vR83RPqtY+eH6kP+Ot2WBgqoRsCV2RoxxULbA3focvwlsMPIfvBN7
 WbVzaxyK1me0SfrBYyVvpEcRCGbcqEuxCancAq7y1gluaMKWC/yM07171LQyr3F7+zTe
 z4rvUbdJQ7DmAlm2Cv22P2zKZklYYmj74Y8BSySanbhhuuFgcDKbQStZ092IQY4g+kvJ
 pMbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4sRHcQYTYbi+YOQovkTvYxMpK0prYAPc0Tw7Qh+KaiCwf+79UwTcMUvqImBpDjCTPgHKboYJPHiIZslms4vYrnTfbHw==
X-Gm-Message-State: AOJu0Yw6Jn61Ba9krUQpDqOS+8BxNgCazY95ritJ+jqhbERbq1a67x/W
 EwFDABZHFUn0QI9/uP7l2Rgj86bG84O8IdhHB2WaVHWPhSNTIz45mAJDWQ+zPaofzoY+h0+HZhS
 HLsKw637TJaJlkBEKEOHOVa9Cu/fhsj3noY8USw==
X-Google-Smtp-Source: AGHT+IHan8ziHAba9KXFYTXPB9OCw18ixW3lrpeYKk6+l+eokiztH+63sccAxASGcJ9881pq/ZWfbqGaMp5IFkee94c=
X-Received: by 2002:a05:6a20:2d2b:b0:1c1:b653:a754 with SMTP id
 adf61e73a8af0-1c45e634394mr2936934637.25.1721813428607; Wed, 24 Jul 2024
 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-1-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-1-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 12:29:52 +0300
Message-ID: <CAC_iWjLY7RiQ4p_RFSv-S0bj_WZi9AQ12QODQ-x8zi-0M1nvUw@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] efi: define struct efi_guid
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 19 Jul 2024 at 15:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This let's us forward declare efi_guid_t in the UUID code without
> pulling in efi.h
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/efi.h      | 2 +-
>  tools/eficapsule.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index c3c4b93f860a..b92c961a2afd 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -73,9 +73,9 @@ struct efi_device_path {
>   * EDK2 reference implementation both define EFI_GUID as
>   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; which is 4-byte
>   * aligned.
>   */
> -typedef struct {
> +typedef struct efi_guid {
>         u8 b[16];
>  } efi_guid_t __attribute__((aligned(4)));
>
>  #define EFI_BITS_PER_LONG      (sizeof(long) * 8)
> diff --git a/tools/eficapsule.h b/tools/eficapsule.h
> index 6efd07d2eb6b..97d077536d5b 100644
> --- a/tools/eficapsule.h
> +++ b/tools/eficapsule.h
> @@ -23,9 +23,9 @@
>  #endif
>
>  #define ARRAY_SIZE(x)          (sizeof(x) / sizeof((x)[0]))
>
> -typedef struct {
> +typedef struct efi_guid {
>         uint8_t b[16];
>  } efi_guid_t __aligned(8);
>
>  #define EFI_GUID(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7) \
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
