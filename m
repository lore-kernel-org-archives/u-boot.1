Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99018CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 11:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D2483700;
	Fri,  3 Oct 2025 13:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bn+Kn0uH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C3583796; Fri,  3 Oct 2025 13:45:40 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0A0836B4
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 13:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b463f986f80so121530466b.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759491937; x=1760096737;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B4xqqZyIReV3x9Y1+CVMJijiotuQpRVNOcmC9D8BWW0=;
 b=bn+Kn0uH9CwPI1xhzTn5SA76hdsGMyyMOgY+Y9IH3pOqv97IaFNK7w3jozukuIIUc3
 pD1VMwd9R165YpPi1qCH2Znl9eZqurggkAgitM0WvHu2lKRQy/y8iSzVHv0vSufuBcy3
 xE3M6a91QlgQt2JnQxW4i0ystaXOkbN8C5mJNkmpAE4/zOYFV4DNlmUps31zbw3Dt0ID
 BMz1aak9a/osM7PlyTcY9usRl8Z59763MCcEG12E0uC2SbsbfiOcOv1vMFzxCt1dnXZ3
 oSB0B62hxHI2m8uNnlW7O0hdp5FtdU4RF7PLnRyWosMtZ4A4AKI7STPfMOwYxn/KLO1I
 /xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491937; x=1760096737;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B4xqqZyIReV3x9Y1+CVMJijiotuQpRVNOcmC9D8BWW0=;
 b=YW0kcgBOaIHRU265tDmsv7B51aDyRGrmzvmBNT5c1iZzV9aUyIFVIX+pfqgA2Clhtc
 rkbDPSmUbyBjMfxzpf6fqGrljFSpu0RK9t3Mws6ebyblUFYC0/BCvdPgAQKCLw9NZsk9
 wIZh8c0UeZol1j99qy+BVMPuftFIep22yC8BQauG5VseDciWvj8GR2k2JADNWIMGjIJJ
 9jXxQNflYzufnoXIi3/1TqGvkRhaEratC6uok48jz1v8R9+uT6eW7zWAHr2nQmAbedW0
 ez10xW9F6ZNGapa715lqt8m5lr/sehpKYKH4XzmXYQK5jPnBXmxhJd0ygxJf2hAFn2vE
 oe2g==
X-Gm-Message-State: AOJu0Yy6PnkUxQcxaKN6eA6Lp/X0oa8hlv4pGjK7FVrII+IXftqt8JW6
 LL3qV12e4q2xZXQpWSaESaOjs4oyFEbSaqEyI7tsfz2Q/JPu093d50uYUEo0zQ/OUJ5zxoS4bIk
 1Gd+sl6g/NVF96Cr4QS7q50ExvsU7B3Lx/VlYoVHNqR9FYLBVc8POaqA=
X-Gm-Gg: ASbGncvvzStv491xNcZPfDtXJfbqW4nff0c29xn1TbLHohGvGR9y0I6/CNHrp8sgJ6X
 76jCQvZcyDW+gdmoJ/EGBsClAJafE8FZJ6zwiUwTdjQjfcbL2aBC5HNkgOEJt4M7LCrY04YP7EI
 jUnsQXO68rAzrRonZx6nsOxHJDr7f7+c6bXlkqlE1sj14Hcarcjdf60nFt8pOXPqrOAxoaHddEo
 jHhzjJwnr9jkXffEJABQKyizrfTlHkBwB7aodj2r2hK3/OF7853q4KyqLsBBXct//aOW9Nlee8=
X-Google-Smtp-Source: AGHT+IFw84A0LI4L2SqMEzbO+SbXEQMcgZPiY0HFkNlOZmEdGApl8+ZEbX8DN9eHyiHCfHYs9gN+pf3TfoB3Kkwg2Bo=
X-Received: by 2002:a17:906:794e:b0:b3a:a16e:3db8 with SMTP id
 a640c23a62f3a-b49c089840cmr346924566b.20.1759491936947; Fri, 03 Oct 2025
 04:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
 <CA+tTRfLcAKz4oNL+TDL30jAE8_a8mf=FNmvioYYSPPKLGH1kgQ@mail.gmail.com>
In-Reply-To: <CA+tTRfLcAKz4oNL+TDL30jAE8_a8mf=FNmvioYYSPPKLGH1kgQ@mail.gmail.com>
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 3 Oct 2025 13:45:26 +0200
X-Gm-Features: AS18NWDE-4t_dhgv1VNxffz_bFExCXc_TOqHR-aIEW3GDkQKOvg9f0Of-8FfTtc
Message-ID: <CAPRXKZAPmsjBso=0Zv6+tYgAreO616ZSbYhkF8Vqcut1auC_BA@mail.gmail.com>
Subject: Re: [PATCH tiU25.01 0/2] ANDROID: Add some features link to OPTEE TA
 AVB
To: u-boot@lists.denx.de
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

hi all,

please ignore this patchset it=E2=80=99s an error sorry for noise.

guillaume

Le jeu. 2 oct. 2025 =C3=A0 18:58, Maxime Fournier <mfournier@baylibre.com> =
a
=C3=A9crit :

> Acked-By: Maxime Fournier (TI.com) <mfournier@baylibre.com>
>
> On Thu, Oct 2, 2025 at 12:45=E2=80=AFPM Guillaume La Roque (TI.com) <
> glaroque@baylibre.com> wrote:
>
>> This series add some Android features link to Android Verify Boot,
>> device lock/unlock and keymint TA
>>
>> - Add support of fastboot flashing lock/unlock  and
>> lock_critical/unlock_critical with Optee TA AVB if supported or with env
>> variable (for development only)
>> - Add support of get root or trust with TA AVB and Keymint TA
>>
>> This series will be upstream after release.
>>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>> Guillaume La Roque (TI.com) (2):
>>       PENDING: fastboot: Implement Android bootloader locking with
>> CONFIG_FASTBOOT_LOCKING
>>       PENDING: avb: Add automatic Root of Trust integration for Android
>> KeyMint
>>
>>  boot/bootmeth_android.c       |  15 ++
>>  cmd/Kconfig                   |  13 +
>>  cmd/Makefile                  |   1 +
>>  cmd/avb.c                     |  13 +
>>  cmd/cmd_avb_rot.c             | 129 ++++++++++
>>  common/avb_verify.c           | 183 ++++++++++++++-
>>  drivers/fastboot/Kconfig      |  21 ++
>>  drivers/fastboot/fb_command.c | 450 +++++++++++++++++++++++++++++++++++
>>  drivers/fastboot/fb_getvar.c  |  68 ++++++
>>  include/avb_root_of_trust.h   |  50 ++++
>>  include/avb_verify.h          |   9 +
>>  include/fastboot.h            |   5 +
>>  lib/Kconfig                   |  18 ++
>>  lib/Makefile                  |   1 +
>>  lib/avb_root_of_trust.c       | 534
>> ++++++++++++++++++++++++++++++++++++++++++
>>  15 files changed, 1503 insertions(+), 7 deletions(-)
>> ---
>> base-commit: 5b93c3ec7f9d66dc40d062a47a4a880f7d346b7a
>> change-id: 20251002-avb-6be401c09050
>>
>> Best regards,
>> --
>> Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>>
>>
