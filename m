Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2765C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1771829CD;
	Sat, 10 May 2025 13:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GU/3Mmvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A06C829E7; Sat, 10 May 2025 13:26:12 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388F282952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad1f6aa2f84so625271766b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876370; x=1747481170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg6C1/XPZDbYnFOxkwymRdbJGSu2Igcw8hlvUEGAaII=;
 b=GU/3MmvbFMZppSZ35ysnSjW7c3MNqFwwW+7Kv6+7A4OS3A+YH1lhwvezwNTU1UlcHU
 XT20ISRMD1I0w1c2hloADNgCFVaIPyLetpPLAFVz926f/YepM5lweCD38cx/n38igV4R
 OP2zXv4evZIuw23DtJlZPAv/ucLGcXFOrZgkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876370; x=1747481170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xg6C1/XPZDbYnFOxkwymRdbJGSu2Igcw8hlvUEGAaII=;
 b=nM62uNNXCuDunUWZDUiZ0VA1jeS+LECvVuf5OXQxUiM7Ug19DQUsCVo2b+I2+KOqs5
 p3qvjbQC7X86SPjNixKvSWvzjopaDtIfIOkbVpKBJ31qjfnkElCrxim00xMMiahTUjl3
 uM82xFAg7mzxomSQL+LpvgXNiWtvhI0NyqBuPdiIuKhKwQzCN/Hn8iLD/ZLzQ+t0qEHg
 3gleurnSAVl7QnUnlN9ahBxsbEEojjrBExeXerHkNpUmgkXLlWXGikLNXJTQkFEjJvjb
 xp8rOr/Q03Cacn6q6fK2g0FoexjZ2G1Fp0DDmAabA7/54cxWpBQIzA52zlVEOHTJ4kMT
 qF4w==
X-Gm-Message-State: AOJu0YzB2rYmenE6Ii8t6d0WsM2UUhcTmIUdUDO2rUrhGCdrQ9E3FeYD
 n2TJnp4jXej77Ok5jNQATf8YTRm9HzxAYw1TN8ncbUnHq58198wIC/eHDMbEkZx0FTywtg4p/l6
 RtZeXl5g1iPFersp3aaJfkGcVRQznTVvJHOkHOiv/Oy/HLm3QslstwfxhNw==
X-Gm-Gg: ASbGnctz6U+Na+8mJFD/Kou7dwUxv21Cb+MZauFAWZ+9F9uCnyjeBNi+KXz+6EjYJq8
 yBzJ2O6MWIijdQTKHXPHRtjXnjW1c7Sx97Vq+i/Ggpq+PSForyaW4imwxyoHQe2k+0ZYV5o+Tb/
 pc1UpIvx/IwMLrY75W2i0wVVW+Bvypp4p0bg==
X-Google-Smtp-Source: AGHT+IFunhkw2iW1eNEuh1OhiBe2b6kgu2RlJ7cFmklA6NxJeOV4OCb3ofebz2s4+d9dQchl3fORIyeweJgpRgNjwtg=
X-Received: by 2002:a17:907:7ea5:b0:ad2:438d:2ca1 with SMTP id
 a640c23a62f3a-ad2438d341emr17795566b.1.1746876369729; Sat, 10 May 2025
 04:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250506205439.415877-1-ravi@prevas.dk>
In-Reply-To: <20250506205439.415877-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:38 +0200
X-Gm-Features: AX0GCFv25gStwFyn8psAwewZyrnLJtwYIilLc3TLF_sZXLZjpso5xsuIMIX89_w
Message-ID: <CAFLszTgOAxugYBZKYr2dQ4cp2tDrQvm_aawidGcEZ7QaWsq=zw@mail.gmail.com>
Subject: Re: [PATCH] doc: document test command
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 6 May 2025 at 22:55, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Add documentation for the test command, including the newly added =~
> operator and some gotchas wrt. the numeric comparisons.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>
> This should be considered on top of
> https://lore.kernel.org/u-boot/20250506141035.385756-1-ravi@prevas.dk/
> , but everything other than the regex-related stuff could stand on its
> own.
>
> My rst-fu is quite weak.
>
>  doc/usage/cmd/setexpr.rst |  5 ++-
>  doc/usage/cmd/test.rst    | 95 +++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst       |  1 +
>  3 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 doc/usage/cmd/test.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
