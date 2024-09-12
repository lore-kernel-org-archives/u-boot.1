Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC28EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5841988D8C;
	Thu, 12 Sep 2024 02:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ki6ypau3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7109788D70; Thu, 12 Sep 2024 02:59:04 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC8488D54
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718f28f77f4so334442b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102739; x=1726707539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8X5b7WwUXY3TdfJRImw5cUqJwVSZWDjQq0MFMTwQqRM=;
 b=ki6ypau33uwdbtpqSSxU2DACSsGYuPCSmLUV1QZ2nVSWg2c1INsBpc7CAu6rZF46eS
 nieAa87a2xgfL7I10SSC6qw42RybynzCooALxgOVcpIazaUSduvaFUXXAQm7bWVvtb1P
 0AJo4qZUKNeVSSTLrZlsFVG6jquX7aWCJm1oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102739; x=1726707539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8X5b7WwUXY3TdfJRImw5cUqJwVSZWDjQq0MFMTwQqRM=;
 b=rjuzpUTJf2O3poTiJtuS8jGEGDu4s7P0h5g3qWzMlJVEXONRrmm7iNxw8M7pDGWV5T
 HrnufS4xBO/ZqTreVq7PgNI2b4gRl2wh07xznJQfuPKEmcCPQrw4N1ttDmug/i0v64NS
 UkCQ0DguCWwsdRTN3Yi2yuIGnhWhddaMoXs4K0FKdt9vsvS2skS6wPCXr1NrEx7Jok9p
 TX5y7lm33L8DWrU1WGQczHniu3DO9E0Q2TbkwbG4NkrEr9WcOkBuqC1Z5qh9B6lSH92O
 iO3ssUqldzBFGCuQleKZwoQ0nv/F4857RUgo+MvOh/WKNJE/3CFVFr/UA6zszsIp1Eeg
 7ktg==
X-Gm-Message-State: AOJu0Yxz16d+ubhceG3I6hATPVxpNiLeC9tduUEyOUZUyPViyrylI5gT
 hMDQWj7Ey1LOoYxc1JfIuStedAz8kZuzwdgIdDBMXo+nUsAJdWsLth+wGBOr+oF3r6URCADJoSB
 X9LxFRevRl25ouQvmuUA7qGbrmoty7kQHW0WV
X-Google-Smtp-Source: AGHT+IGa8pUo7h0QXrVBGsDH3crnI3vTLNm20pSdR8DivZCdPM3n1xuqto4NqVNi7q7xfblbJPducga9uZnXmAC1Kf4=
X-Received: by 2002:a05:6a21:2d8a:b0:1cf:1217:ce87 with SMTP id
 adf61e73a8af0-1cf75ea2251mr1559378637.2.1726102739185; Wed, 11 Sep 2024
 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-8-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-8-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:15 -0600
Message-ID: <CAFLszTi=0fpsRxpG1dGHRePDzMaqEmd7vFXibr0Jb=gbGxvmzw@mail.gmail.com>
Subject: Re: [PATCH v3 07/30] arm: acpi: Add generic ACPI methods
To: Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add generic ACPI code to generate
> - MADT GICC
> - MADT GICD
> - MADT GICR
> - MADT GIC ITS
> - PPTT processor
> - PPTT cache
>
> as commonly used on arm platforms.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v2:
> - Add full comments to exported functions
>
> ---
>  arch/arm/include/asm/acpi_table.h | 115 ++++++++++++++++++++++++++++++
>  arch/arm/lib/Makefile             |   1 +
>  arch/arm/lib/acpi_table.c         | 114 +++++++++++++++++++++++++++++
>  include/acpi/acpi_table.h         |  34 ++++++++-
>  4 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/lib/acpi_table.c

Reviewed-by: Simon Glass <sjg@chromium.org>
