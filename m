Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F0CCD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8DB86A88;
	Tue, 19 Sep 2023 09:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PW36gNWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0D286A30; Tue, 19 Sep 2023 09:28:34 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF13086A84
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5029ace4a28so7554485e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108512; x=1695713312; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruHuhUK48hHmba15sTiV8DFn7DyotV9RLqXckzE9ZUg=;
 b=PW36gNWIGGMh1le4qvXqqseqk6Yq5dQA7uBPNXeMuQUFl1ADuL5u8yJvqEvM0atQEj
 j2a8fGCbVAnoFn/BoHGQCyIGnpV5+a7q5XjKR0Dyob9B0R5r/o0yQG4XmIgnkEVV8RKQ
 Z7fLJ9tQhA4EDLMv8K4UysuPUGc1gQQrN23EgiAtfWPf5D0V18SoVQerOneCNlBCOoNR
 ZkdoKt54wTpPiEYjmqsjK05qhFOixaGUwsd1afHEgbQSI7HUzfDhbTVsJvn+92lHDeoV
 ITD1xKyxYyWNGzhtYoRwjQgPWekFQ+YK16bLPzap5Cz8SjIac/OXMl/u39gldY42TlX3
 HmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108512; x=1695713312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruHuhUK48hHmba15sTiV8DFn7DyotV9RLqXckzE9ZUg=;
 b=O5aSKmpRTGLWS20JOUdTc+kHR11PB0YcYPjEESG7CX5IzmIAfADjZrh6dqdi3SFxMP
 7phgzO6/dUMtBu+JXAm6nZn5LTvdvHY86nI36z6fSVGzJliN4oVGTTgXUQpHoE+Gu9Yl
 uh4APrc0Q5aLBWEnvk3D8lkJh3oN0A5J6bDxvR1VqIqky6KK7z3BUU3lrTCS8miRSZVl
 HrSo+jDhax3uTFjqCrfSE2hCViapm5zBm+AMcYKqcB3aSrtm7qYxAMNI1w++knHM/cX8
 A5WcVNDjRK0C+gqxSHS7fSFD5nVbS6Lnu5qF2S78kqSSX4cOyWQQqCmL5AM87upiB9VS
 Cjug==
X-Gm-Message-State: AOJu0Yx6tSP+9ROTX62lPMxzaO1Rpgb3/dECrQDhhxTKV/VaypLEoGe0
 pJig7k75HqxKsW95L9XhxVwEeJzY0zrKfRnLaFk=
X-Google-Smtp-Source: AGHT+IHKQuywwsAthYBRMg8kk/06rYUArj44QIAhg+4hs/njeA9ydzezwepP9DzC/jBStcelnO3Cp7cE9eDHKR4cXbM=
X-Received: by 2002:a05:6512:12ca:b0:503:16ec:7153 with SMTP id
 p10-20020a05651212ca00b0050316ec7153mr697570lfg.31.1695108511876; Tue, 19 Sep
 2023 00:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:28:20 +0800
Message-ID: <CAEUhbmWDcqUzcRkGzY=nHXEPakWKJyfvJgzQ2DoZam6uVssWLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] TO BE FOLDED: x86: tangier: Add FADT to the chain
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Andy,

On Fri, Aug 25, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The Simon's patch missed the FADT to be added to the chain, hence all
> the issues on Intel Tangier.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/tangier/acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
> index 01b30553818c..ffaa56ab6f87 100644
> --- a/arch/x86/cpu/tangier/acpi.c
> +++ b/arch/x86/cpu/tangier/acpi.c
> @@ -52,6 +52,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>
>         header->checksum =3D table_compute_checksum(fadt, header->length)=
;
>
> +       acpi_add_table(ctx, fadt);
> +
>         acpi_inc(ctx, sizeof(struct acpi_fadt));
>
>         return 0;
> --

Which commit should we squash this patch in?

Regards,
Bin
