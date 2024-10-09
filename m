Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB52ECF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F3389118;
	Wed,  9 Oct 2024 03:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkEywzxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216DD89144; Wed,  9 Oct 2024 03:57:35 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED928913C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbbe3f6931so12663596d6.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439051; x=1729043851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NX8eytFp1hR/Qnkv06nHIgA7I/OokWp5jhWHmdhIGo=;
 b=mkEywzxAjhfnOLh8jAocUbNTniooOngYXRVquFVFqK0PgbTtcK+6zn8cXw2cD1+QGz
 2VE8TJiwx8b1jGURcNogBUdwzRZYLccz2NXCjt+ODCGsTWsRhcZoalkGrhUpViLRIWxG
 rVuPdylVLqbl+hHgxv1Ov2yC8VaoIbXz12kX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439051; x=1729043851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NX8eytFp1hR/Qnkv06nHIgA7I/OokWp5jhWHmdhIGo=;
 b=UgFPrTKMDzrU0gIKOQe/pk05/4dZPUC/wLXuhjb1pV4MH2wfXPTr7V3++TOzLNN9pH
 grCubnf04q34mt9TnQS07tgS+GrDkyGI5EYxJOf1dOvdhL3xzlp60ZWRw7sg3vRh+E8W
 v4uIPMLHSzNbXJ+6/XFNTu9g/eE24lSEr0/UWwwsP/Aqw/TCH1t5n29iXS75zfVqd2Sz
 COAJbMS7IUNgyCvE0qc6DtNsvlXbVrrrlTc8O+X7pI38zaCF75BHPu1veJzqRZG/KYQ7
 Z9llMY64RlPlttosYeKINtQIQk6XlG8vQX1ncTBt80ppf4CFMvd4TMaheoMEYMKZVfKS
 y/Tw==
X-Gm-Message-State: AOJu0YzfJv7FX36B047fRhUF5Tb+67Awh8HD5OIo4g3kydPleTImR+ic
 9/p8g07lahleLy7t7nyHnZZV2Ah+AXpr6pPU5NaS9q5xlYyk0OZ5sQVBQXOWbfvPUpCVwxbDfOO
 34drUjkbILjIw8Sqf+1TFzzNwFL3kDv+Wy4nQ/YCFL2xrcEihbQ==
X-Google-Smtp-Source: AGHT+IF5bHS9NpXGXC+qcTOdfjSW3K4s+tLcZuDhhDQXq9jDakoisNs4E3Q6Td4eqfTLXEmKfaCblZnrOcgoODD7NSY=
X-Received: by 2002:ad4:438f:0:b0:6cb:c9bb:8545 with SMTP id
 6a1803df08f44-6cbc9bb8671mr13018606d6.11.1728439050757; Tue, 08 Oct 2024
 18:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241008120813.622408-1-andrew.goodbody@linaro.org>
In-Reply-To: <20241008120813.622408-1-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:20 -0600
Message-ID: <CAFLszTjkBfFrGWOtdaLCbA=AF7B+Z+bz9fb0TbB6WwO2dUMWMA@mail.gmail.com>
Subject: Re: [PATCH] test: Fix skip check for sleep command test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Love Kumar <love.kumar@amd.com>, Tom Rini <trini@konsulko.com>
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

On Tue, 8 Oct 2024 at 06:09, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> When the config option CMD_MISC was renamed to CMD_SLEEP the check
> in the test for the sleep command was not updated. Do that now.
>
> Fixes: 16060854095 ("cmd: Rename CMD_MISC to CMD_SLEEP")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  test/py/tests/test_sleep.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
