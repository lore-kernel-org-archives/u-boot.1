Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C96C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 08:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C685288395;
	Fri,  5 Jul 2024 10:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mgcb5vkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD3B88395; Fri,  5 Jul 2024 10:36:16 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159D888974
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 10:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b5f90373d4so2388316d6.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720168573; x=1720773373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kc9ShR7uEbYHXFeYfBqkenV0sxo5lzGLss+Xhh2rRGQ=;
 b=Mgcb5vkIsSUaeeZ6BmPKYCvckLTTi4qgl5WiIn5EHebdEvf5BOEgOEzxymFO+j3olz
 E3MnosRZwsWUKfgbUhTUGS473BpnvmOhKWjEZoqh2FSnVB+nbX4D/qM8I85d8O5hwAKZ
 RHWh36m6SYQT+5h5EkLk3Al9MWhk4+ctRQM9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168573; x=1720773373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kc9ShR7uEbYHXFeYfBqkenV0sxo5lzGLss+Xhh2rRGQ=;
 b=GCclGBQrfwkAXQk+B1uChBgrzQmcKgYr40L7nuqwWIdLJgd7ckqWBf2+ZQYPxL+snr
 B1fhLlbQp+fQoqWVshs4CvD2EvYA41xjuvClnsvKqypPAIyS3uOM4PypzwgPqZRfkups
 efeN1Ub5FjQoXKWylpHQHag8mLkDr2e5tiM+ZgyRkiwu7mP8ZvXbNGng6siiBaCnH7dq
 CE27wENJTNrLTnApVVktZWLLWSsgQp06HpFyPvnqEAad5SwaeBUhrd2dJzS8Czq7Jv57
 +YktT2P4k4duWpWnfyvroz5h7tPMFhXz+dJXqla0gPkpwC7STA/aEUJAEolEidv1krEp
 P0/Q==
X-Gm-Message-State: AOJu0Yx+JTKe5Xd6iAsG+44MT6FimtaUN2VMS52ixy9sPzBl7yDffg8F
 fTa+ih/OUsdLZf646iIFDSFvossJt8SLAcxbltUspAd7uU9WfAKMV6TSRWHryDzaQyq7m4bVs42
 f9DVQeH+eexVDvyN9kxfOHrRn6Hgam4qMPfuXA5uqOYsq58w=
X-Google-Smtp-Source: AGHT+IHW6V4He7dA8Fm0jowb+YSuAkUp1KYzpFtOg//L0bP9ujOwY0sdM+abVKv8tQzABfWESStp7EVzztUrMN0UA+U=
X-Received: by 2002:a05:6214:20cc:b0:6b5:101c:6473 with SMTP id
 6a1803df08f44-6b5ee598826mr61417666d6.2.1720168573003; Fri, 05 Jul 2024
 01:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240703211909.1435390-1-trini@konsulko.com>
In-Reply-To: <20240703211909.1435390-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jul 2024 09:36:02 +0100
Message-ID: <CAFLszTg3+YvLkfBvaFsmGGTYgXgLq-y4-TXzj6R-tqFcjArRJA@mail.gmail.com>
Subject: Re: [PATCH] test/py/tests/test_fpga.py: Correct check for legacy
 image format support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 3 Jul 2024 at 22:19, Tom Rini <trini@konsulko.com> wrote:
>
> The build option to support images of type 'IMAGE_FORMAT_LEGACY' is
> CONFIG_LEGACY_IMAGE_FORMAT so update the pytest to check for the correct
> option.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/py/tests/test_fpga.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
