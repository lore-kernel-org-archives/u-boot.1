Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6F0E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B4D8060A;
	Tue,  7 Jan 2025 16:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZMPPDa8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330A38036B; Tue,  7 Jan 2025 16:33:05 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511388060A
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso18157384a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263980; x=1736868780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FRviGNDTsz2HU/b/xxQSITqXS48sKuYKvV669IG1inI=;
 b=ZMPPDa8lxy8ig1GuiIElQKYKirSepOWG292Le4Az6rK61vfJwTd/8RsiXjkrgbYH8Q
 EYbKEtzk73RcD2psPlIHcA2LGQjAFt/WAgTyCU1vUsvoxe7ME/NxYcJkBIq160ywnxej
 zktFrEBPKcHJ+124Jxg/Q5WqpCfu+pi//QKH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263980; x=1736868780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRviGNDTsz2HU/b/xxQSITqXS48sKuYKvV669IG1inI=;
 b=h8qV5kpPcKFTJJBbEL1RF8cMsFOzYa20FvQ+qG52543f3cKGZUmjWlvhNRnfGtvoP6
 9/5NihjqV1kIU6sKm6L1iv0EWlH0j4xPOo1S4thRN5oxP4UsMGndzb12rj+77zIJBCro
 FpxixlH6fdHfPi9PAh3r1s/MsnxQlwBviY8WsgQe/qc05SBfMlS0hPMg3+og1ZJb490Z
 cQ2mW2u1Gui9H7AgrVqFgwJ+ROZlK/E5HwrTHwBRsZp2HoXp1Sle6oSRtW/J7994DLi1
 x2WlzPFCNviFiaP6FPi/28DDAzFRNvXX2KA+mXG5EOZMYy57ArRr9mAergm1K2LS9iXo
 VWhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVrhp4uM0apeNVKfBoZJUokKajnBLmUcKmp83MJDg56ZvQPP3RSsqKqsOUXjGiZAW+o2YliTc=@lists.denx.de
X-Gm-Message-State: AOJu0YzCYvMjVykzbKmQYkc5Uq+Iaj1rfrjTn2jUk0ZOAjY48j4HZrKO
 ruoIPzpQmTM0+KNjs4H5kdYC3ZiqgCXLDGEjZ66mUa7/qxeuPy2AtYGQmyX4iSFIImaE1MC/vuh
 xpHg/QZ86KtUw72RZckZAYNPkq5WZ/zCCG30V
X-Gm-Gg: ASbGncvjNkYF8mOA7HSiY8f6N61wGvEyqdhq7O0twgBZsenFSYHdVbG9g3n2qcTlU37
 IROpa9WVAtulW2Py4YTycSUhMOI7sRvSjb2fxSCw=
X-Google-Smtp-Source: AGHT+IFAdApno/TFqTmJQaychUvpCcGnmbiMP/gRzEzXFjPDo8ETMpYumC5kJS/50fswQCnu5BtZl/Z4Ospagdk56pk=
X-Received: by 2002:a17:90b:2dc2:b0:2ee:bbe0:98cd with SMTP id
 98e67ed59e1d1-2f452def731mr96945869a91.7.1736263979927; Tue, 07 Jan 2025
 07:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-12-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-12-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:22 -0700
X-Gm-Features: AbW1kvao16F_gknSMXBtwCYedZ9SBUQM3-NLoJVivjOtf_AlZ6cak6fSZp5zqT8
Message-ID: <CAFLszTgZth7aq4OvbLT7s29CSbrT99iyACNpSUkTPBk7CuUSjw@mail.gmail.com>
Subject: Re: [PATCH 12/15] mach-snapdragon: move memory parsing to its own file
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This code is getting a bit complicated, split it out to try and keep
> things a bit better organised as we're going to be supporting populating
> the memory layout from various other sources.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile    |   2 +-
>  arch/arm/mach-snapdragon/board.c     |  94 ----------------------------
>  arch/arm/mach-snapdragon/dram.c      | 116 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |   2 +
>  4 files changed, 119 insertions(+), 95 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But please comment the function in the header file:

> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 74d39197b89f..b7f3bf798d3c 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -22,5 +22,7 @@ static inline void qcom_of_fixup_nodes(void)
>         log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
>  }
>  #endif /* OF_LIVE */
>
> +void qcom_parse_memory(void);
> +
>  #endif /* __QCOM_PRIV_H__ */
>
> --
> 2.47.0
>

Regards,
Simon
