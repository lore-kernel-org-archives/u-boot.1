Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE5ACCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A727836B4;
	Fri,  3 Oct 2025 14:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OKzcu3vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EED835A2; Thu,  2 Oct 2025 18:58:44 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0AA81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mfournier@baylibre.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-57bb7ee3142so1373376e87.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759424321; x=1760029121;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8kyB0L1jXCzciR6FwHF7vq8CM9sJwLPWOOVhgdiu/l0=;
 b=OKzcu3vJkTdr8nkeFN3Bis5MXed8cwF+IZnzi9VBqMIYQnPp8QRxqyLSb5DRS4v7rW
 PC7RwpEbH8FBNaguIHAA3Gb70FRqh4434QVrYt2Cc2mSW4HAXfJ2B2k8ReeZM9JGGIFr
 tV8v6ejcQZbgJ+LJQbcLfVudexlzqiH6wxl4Q4SEwrs9R7D+iKni3pTMdY31D69bmg+y
 vyWylr7RDjjN0GFPzQEmCZsacAc/7CzymVnuG2jO7UmqQDVyIoZkefkiWtFt5E69DL6x
 tw9gituhVkyf6fyAv7B1rTEtX+2pQEqAjnvuna45g/Vpqwk/C41/pF2Pn8bjlFlopMRe
 mzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759424321; x=1760029121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8kyB0L1jXCzciR6FwHF7vq8CM9sJwLPWOOVhgdiu/l0=;
 b=mI9E9xkIPwy3SOssYNVm8PpdrDfQhT/ENqMVs+fcorfu4RCH8xaiCfZF7SlcTIpfnP
 yuhWb/Mfw/5Ys1y1fpci08jj0Ahdy7LvBSMYv43xWSvfJJrmxVvFOiHkbkV6hwGXPZuq
 fk0jfKk3U1m4vUKHHXdpx985L3wcw8Dfcg8cmcp9/Y9X0D05Hv+00TCWI/27hxrigsml
 8rqtAw4sGoQJDJhpu4saVE/UzSF0BxAXPd7hv1EQ0Lpz5ODBIeC/oAnqMBG+QzJV2zdz
 SerhmRfJ6ZSTeI8tgRZdMPmcH7aODU+CgmjG3+2HF3VdoIWVqRmRlPSgx1fFaN6Kl/Za
 Ye4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbAOc9ynqlAWDBMpO6TJPR7hM91EbpNQI7rj19ycvOLHLKX3incTcc1n+7OapARM05+MRfwIk=@lists.denx.de
X-Gm-Message-State: AOJu0YyHfDAw9oMZUpylC+EhHW/uJrZdRalbfjERgsmW6fWPIZx3q0oZ
 jdr4NAo+sCsfGuhnao+kPiFxzj/J/WAcuISdSNJWtgzUWCmhw7plGAh9E0aZoopoCT66slyN0TY
 nkJOgBgQWzb+X7rokyBIigjbmXmasK10Rygw5J+0EEg==
X-Gm-Gg: ASbGncu8w27TwsQFni8C71ixFZvD5iL7l3nvRWMfBKtsbUfhT3GF+wtCNS4dfwDYE7c
 Eykbr8tzinsOxQsR01zqHFtVDxxds8Ih9f9tf7E8WaOkWauVOUkRcwDnFkcmCt41ribdZnz0VCw
 SSG2GiOfDfDE/OI57K+wKckdJKEcITRRMkpw5wT81UvwZjrMv3TlheGCJBWcywI0wmZHXs1MWaz
 4tsYHTtCQ1R7AzyO0eU9Ao3/rbFaaHIM1mzPY1ssTicxiu9T5NVGmXK7vtQU0U=
X-Google-Smtp-Source: AGHT+IHZcTtKEkHBNnahuXKBWOGXaFdAHJv3GR7iOXTXhtw28fIHJdoNveAwrHoukuWWNcPYCyrsB/rmiE7R1TaYYxM=
X-Received: by 2002:a05:6512:3f27:b0:57f:405:7afd with SMTP id
 2adb3069b0e04-58af9f6af1bmr2346164e87.30.1759424321532; Thu, 02 Oct 2025
 09:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
In-Reply-To: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
From: Maxime Fournier <mfournier@baylibre.com>
Date: Thu, 2 Oct 2025 18:58:29 +0200
X-Gm-Features: AS18NWDa3sJG0k8ZkLDV5MF54kZOBCm20d9r-tpAlngddoIkwfthyEJVNGkxfvo
Message-ID: <CA+tTRfLcAKz4oNL+TDL30jAE8_a8mf=FNmvioYYSPPKLGH1kgQ@mail.gmail.com>
Subject: Re: [PATCH tiU25.01 0/2] ANDROID: Add some features link to OPTEE TA
 AVB
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 linux-patch-review@list.ti.com, 
 u-boot@lists.denx.de, Praneeth Bajjuri <praneeth@ti.com>
Cc: vishalm@ti.com, khilman@baylibre.com
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Acked-By: Maxime Fournier (TI.com) <mfournier@baylibre.com>

On Thu, Oct 2, 2025 at 12:45=E2=80=AFPM Guillaume La Roque (TI.com) <
glaroque@baylibre.com> wrote:

> This series add some Android features link to Android Verify Boot,
> device lock/unlock and keymint TA
>
> - Add support of fastboot flashing lock/unlock  and
> lock_critical/unlock_critical with Optee TA AVB if supported or with env
> variable (for development only)
> - Add support of get root or trust with TA AVB and Keymint TA
>
> This series will be upstream after release.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
> Guillaume La Roque (TI.com) (2):
>       PENDING: fastboot: Implement Android bootloader locking with
> CONFIG_FASTBOOT_LOCKING
>       PENDING: avb: Add automatic Root of Trust integration for Android
> KeyMint
>
>  boot/bootmeth_android.c       |  15 ++
>  cmd/Kconfig                   |  13 +
>  cmd/Makefile                  |   1 +
>  cmd/avb.c                     |  13 +
>  cmd/cmd_avb_rot.c             | 129 ++++++++++
>  common/avb_verify.c           | 183 ++++++++++++++-
>  drivers/fastboot/Kconfig      |  21 ++
>  drivers/fastboot/fb_command.c | 450 +++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_getvar.c  |  68 ++++++
>  include/avb_root_of_trust.h   |  50 ++++
>  include/avb_verify.h          |   9 +
>  include/fastboot.h            |   5 +
>  lib/Kconfig                   |  18 ++
>  lib/Makefile                  |   1 +
>  lib/avb_root_of_trust.c       | 534
> ++++++++++++++++++++++++++++++++++++++++++
>  15 files changed, 1503 insertions(+), 7 deletions(-)
> ---
> base-commit: 5b93c3ec7f9d66dc40d062a47a4a880f7d346b7a
> change-id: 20251002-avb-6be401c09050
>
> Best regards,
> --
> Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>
>
