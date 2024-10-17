Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70DED3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085AA891BE;
	Fri, 18 Oct 2024 01:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AUQbgC7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E96E89170; Fri, 18 Oct 2024 01:12:24 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E4A89123
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cc1b20ce54so12426026d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206741; x=1729811541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2SivWwkmoUuRRg4u4xSlOP4kOeUkfeBMEL5PidXhNo=;
 b=AUQbgC7rycASllZWr1/cXyHdCsdNiklIppE+2anElca4qqRz3aWRdkcEHS2OKbQVM6
 TXihSFZ5ywrKMl2vRhN91nPkO1vE9ZQshpNCkPQVArsS21onW4hfDeMaBRSgQ4KeSWa5
 sbvc2oqetjnTHi3ekUTnCYlv+UA4YEU/VFi+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206741; x=1729811541;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2SivWwkmoUuRRg4u4xSlOP4kOeUkfeBMEL5PidXhNo=;
 b=NVv5PH7LEKGbk/65MlnYL4Iaa/wCKJkJi4/HlQfuWrRhE6L+HtmGEUqBL7c8vpGI5q
 N2tAoBHW9xzr47jNF/H9KPFH1b9xiQPJ3mIq//TfRSh0hk2/DtA9e3CWhhCWi8pCoJLT
 ECtL79+OfSp151dmSDWV06CyH9yqi1DFw2lJTLEzIt7vwJLhg9gIj3WnLx9NqyHbf0ob
 o9LfUzMAi8yIEBZ24RdQEnt4TN6QZxC9ctdFDEpURPfNBY1qb7nIxi3K4QeytuKYxcn2
 48kHmFVh/VF9FZKt/kneUm+wt7FI7l8ym7yqobSx9v2dw5t/va1kgv92Imo8UjYNS2RO
 MeNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVogojIZts/MKi4IMjLnvec6cPeK7FHVSjAX4WXuW+DCRB804BHAbHRec6Wr2Pu0SRTSuQ0G0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx7V53M4LgZXLXesv4TBKCS6lA+JGy9ZbviWnROz4zTS+/cXN3
 jV0dqFwRonp8mbV3/q7dF3QfJ+LKJYAyG8Fnd8Akg6wkjZa8DxE87aj1926/KkEMMdKJCtbJ+9j
 IjKog49OAidJ+C+VZ4ODPX7ZK+BVPXAxNkgFI
X-Google-Smtp-Source: AGHT+IEa+zONQocv7RTIVlZlATLIlh8bFA/yJiNEsL8pR3Imggo8lYHqsVHDoAn7F4qa204teQVa2khgrrRtdjj53BU=
X-Received: by 2002:a05:6214:5543:b0:6cb:ecb1:e6c1 with SMTP id
 6a1803df08f44-6cde1508007mr8096976d6.17.1729206740965; Thu, 17 Oct 2024
 16:12:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:20 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240122143512.196907-1-trini@konsulko.com>
References: <20240122143512.196907-1-trini@konsulko.com>
Date: Thu, 17 Oct 2024 16:12:20 -0700
X-Google-Sender-Auth: nzyG-PZ7CbCzpU9NF7lQdEN1oK0
Message-ID: <CAFLszThrqdwc24PaTnSdZCFTuorw4cKMwNLnn97cxz0O7um7Kg@mail.gmail.com>
Subject: Re: [PATCH] x86: Make default_print_cpuinfo be a weak alias for
 print_cpuinfo
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

While a few SoCs have a unique print_cpuinfo function, a number of them
just use default_print_cpuinfo. Make default_print_cpuinfo have a weak
alias to provie print_cpuinfo.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This will make re-using arch/x86/cpu/efi/ as a generic set of support
code for U-Boot as EFI payload/app a little bit easier.

Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/coreboot/coreboot.c             | 5 -----
 arch/x86/cpu/cpu.c                           | 2 ++
 arch/x86/cpu/efi/app.c                       | 5 -----
 arch/x86/cpu/efi/payload.c                   | 5 -----
 arch/x86/cpu/slimbootloader/slimbootloader.c | 5 -----
 arch/x86/cpu/tangier/tangier.c               | 5 -----
 6 files changed, 2 insertions(+), 25 deletions(-)

Applied to u-boot-dm, thanks!
