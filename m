Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA274E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C990805EA;
	Tue,  7 Jan 2025 16:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TeBEvII+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6956F8067D; Tue,  7 Jan 2025 16:33:17 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C461C806CB
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so23343398a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263988; x=1736868788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBq3eI6h+mZaSCf+3EQOm7nb7SBg4DzO2R31hsna+nk=;
 b=TeBEvII+3k6W0xgUNcjH+vn2YpjFKV/vwTCTPxQ/r2t2eGP4OqlpK7Il+3hfLhXWvX
 nZbCJ1NbFvT0/IJVU9+FJSP1emEegSi9jygxOvySZMz0v+qizZzAjZZ84lfQFWUFVB8V
 azQC8cByxJPhNgZPwU5gLxauojcY/+P+NMFuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263988; x=1736868788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBq3eI6h+mZaSCf+3EQOm7nb7SBg4DzO2R31hsna+nk=;
 b=Vm6TpcKcxbnld1qUthbB1aPYBTqOpqSIDTLHRbZYMOO7nfqCbW6V5Osj+inOu+o338
 VsYNUkS4bubexROywBjONEMGHB9oqxESrkDa96JOf0kvhLl4qdp54gqWSDXwjWaMoIr5
 Nm8mPdxuQUZUtEf05I5hpSaB/i1Fq/es6HQvMVceyVzPgc/9Ky2denMNNHt4XGCMk1tq
 uyp3Jy6O1hkyO3M88RLbyUgYDYl1xsZLOCp2pmTxOrmsyp1Q3IvS+hLnIjVVo0EW87A8
 TF0+NhtisYw5W5yyskR1vVqEV+hQ/TzSbOvIDR1V2DN0+CbAJpkRgUTMpsVug1zYvA0a
 eR2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcrNSzF0zoznABzxMdgyBHOYfzCg36j1uw9b9gp4zIh2vEmDgVRuJFjPkwchvB90ancNTS8CY=@lists.denx.de
X-Gm-Message-State: AOJu0YxpQzUIVDqXCjc0AAG54eYhzDgQvfNnmOaZ2ktwIZjBM8xWo0P7
 hyFtk5Bug6BCKwd9aAY7e6IbMRJSRjMXRF6NPzMhKSe60XMzjZzlpukDYP4GiSQRC1icW+wvxHy
 avaSOwoIPxl9bDuDBEf0tshGKESX1XVO6lVMV
X-Gm-Gg: ASbGnctgJeFars1CfePvHLjX3rkGSpIdcLgbDBbWNHPc60eTkoNinCZBWSS6R22E8tz
 kxNG5fDLVc3WJsl3xbiRMVRVHZb08gTXP6m9Tvv8=
X-Google-Smtp-Source: AGHT+IHd7oGn1fUT+3S9hiTYQkomrqH2eUvLOAEE+mmqb7ANNcl3WCFM8PwLuShrvukfrtocxf6zSgDcB+Hk0GsRnbs=
X-Received: by 2002:a17:90b:5484:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2f452e1c26fmr94074668a91.9.1736263988404; Tue, 07 Jan 2025
 07:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-13-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-13-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:25 -0700
X-Gm-Features: AbW1kvbrqujPRutb_MNvjPT_nPtc6VurllYzbPRtE5D0gSPF4V6O1fo-JEWOCmk
Message-ID: <CAFLszTieJPgm45EHsFbk8YhZamJg=YoJBFHUg22tXL_dkkUQmQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] mach-snapdragon: support parsing memory map from
 SMEM
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

On Sun, 24 Nov 2024 at 12:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> It is possible to derive the memory map for a Qualcomm platform from the
> SMEM shared memory region. The memory map is populated by the preloader.
>
> Introduce support for parsing this data and using it to populate
> U-Boot's memory map. Since we aren't yet sure if this will work for
> every platform, it is not yet used in all cases, if U-Boot is booted
> with an internal FDT which has the memory map defined, this will
> be used instead.
>
> If the FDT comes from ABL, or we're using an internal FDT with no memory
> map defined, then U-Boot will try to use SMEM. This should remove the
> need to define the memory map statically in a U-Boot overlay DT for most
> boards.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c     |   2 +-
>  arch/arm/mach-snapdragon/dram.c      | 106 +++++++++++++++++++++++++++++++++--

comment again:

>  arch/arm/mach-snapdragon/qcom-priv.h |   4 +-
>  3 files changed, 106 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
