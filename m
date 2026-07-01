Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6809DC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DD184C39;
	Wed,  1 Jul 2026 21:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GqRR2O0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296F484C5C; Wed,  1 Jul 2026 21:32:16 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE2E84C51
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso466127fac.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782934332; x=1783539132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hjm+7W4HA5QjL2lROaIolfnal4+Micn3l46jVhw281A=;
 b=GqRR2O0KLceao+miytADbqTQbEpHlaHbMLeTZZD0L7BwoMOPaOYxgejnMPcrypAULL
 JaqAHjSoDZX2ckeQUDJ1CB9Jcgdk/DJ/MoPjDjd1LpjJtjZvnwEy+QSxmJKrj5bmTJwU
 udQXlaykDkyTC7XmKYa4Tx3KTbBL9TYuhwX+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782934332; x=1783539132;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hjm+7W4HA5QjL2lROaIolfnal4+Micn3l46jVhw281A=;
 b=EHsDhPMmwhgNtsR7mD9DZgssqwXYXiWB+v+lzhTpuABo0iW92O6TRj/ZWrPk4Eh3e+
 wHLRnqJBLGpC/t/tChP6TMTDyZFtyOLdzPbQW3TH1UYbkekQSTsQV4prtemrU7+fB0P8
 yTMQEYEFsdqxxWa0xPFuEK0HoKhQICFc0bZXEtBmo7IBYUCJzUG0GL0G1JEJfO7pIF/V
 b28XdljwEYpzU/cna5HlhE4gBVXJIjvQ2GgfHH7+YIwuH2zi09842cfUEko7Z0hlBfyt
 KmfnmjlH3B56173iHBExfY0Z/IMLSRjmxBIsccEcOJghmfu8BldExP4r4JpevdoyB8GS
 6BYA==
X-Gm-Message-State: AOJu0YxRvxO2LfGGqwKdpIfUtYL75EDKXN+fMdr9RU244xZaBk8GK70i
 GAYA35zTDU/v21DovuZGODVi0QKOlALX1bzsb4wmq+r+KLok83SVCVwtBsV/IL9MdWE=
X-Gm-Gg: AfdE7cknNaajwvNChDOXm0owx6nlrVy07rYQQbuDjXKkQWMWAjSqv3z9AuzJ4YJOt4c
 aGRTWkM36qnibZq3/j2W5Vl0N/ueS8tcFOtc8Pb9rIb5zI0C8m1Vb9aCEQ9oN4uuKMm8stzAOE9
 arETQ8p7+gQR0ViVbixQPS/3ArluZFPFyJBGN/ozp7mesyzx9qPcC8jqD4F2FQzspaFVtDrgFNN
 syw+aYcIAkj4BgNicPgXNCPWVJmBKQwTj1R99zNHeqcNLlcFx75nmatw0gAThLMbN2LaAlzbdFk
 R4H5bKe8k7ko19GYW+q/RYE9yWDJrLn0M7ddHx4mCx2gzkOJlXCcWHeQCIzRrvE0pRJoSOdjeq5
 j2/gAC03YVVstA13BD8R3H2PBRXgGL7VxkFCi6xPGswQ6smZkvw9AUX/Z5Rd9zrWYsqzEWTyxfo
 EavIU/nCbIjCxCPU4o0Dn9dtGxe4K8PYenTgrTgN7sd+p69KN5BEWRBP3VfcNIOAI7hI8nlfHdg
 c4w36MiKUNdA2+b5NBDilbfoNJ9yURdR9C7
X-Received: by 2002:a05:6870:c113:b0:43b:58a4:cc33 with SMTP id
 586e51a60fabf-44cab97d41emr1688850fac.22.1782934332592; 
 Wed, 01 Jul 2026 12:32:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe84f609sm712763fac.1.2026.07.01.12.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:32:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 =?utf-8?q?=E7=89=9B_=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
In-Reply-To: <20260619144554.5963-1-aristo.chen@canonical.com>
References: <20260619144554.5963-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 1/1] bootm: move OS index bound check into the
 legacy path
Message-Id: <178293433143.2600701.14374429022608257011.b4-ty@konsulko.com>
Date: Wed, 01 Jul 2026 13:32:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 19 Jun 2026 14:45:51 +0000, Aristo Chen wrote:

> Commit 103b1e7ce8cc ("bootm: bound-check OS index in
> bootm_os_get_boot_func()") added a range check to the shared accessor so
> an out-of-range OS id can no longer drive an out-of-bounds read of
> boot_os[]. That accessor is reached by every image format, but only a
> legacy uImage can deliver an unchecked value. bootm_find_os() takes the
> raw 8-bit ih_os byte straight from image_get_os() for legacy images,
> whereas the FIT path reaches the accessor only after fit_image_load()
> has rejected any image whose os is not one of the supported types, and
> the Android path hardcodes IH_OS_LINUX. The check can therefore never
> fail for FIT, where it only adds confusion and code.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootm: move OS index bound check into the legacy path
      commit: 3900903a588964555c9e76cca53ada7d217c00f7
-- 
Tom


