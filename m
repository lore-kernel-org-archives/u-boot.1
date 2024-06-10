Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D159C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F77987E62;
	Mon, 10 Jun 2024 10:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRihtQla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E342788452; Mon, 10 Jun 2024 10:51:52 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B773485B66
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f1edc71e6so116296f8f.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718009510; x=1718614310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkVRQOt7R0Pxh4yKyfLDPZue6ZJ3HY7jiTUt26cEKmU=;
 b=BRihtQlaZ50cW1JxzXDVODV5fd6Yxqq4OOn68/fk1M7IzAUiyCIYGy/iQitwqIjlTc
 ZqEA5Uk4WLRRw0YFb1AvifKiUzMnXCsw9C8xGkoVEffmHTO8rSsZsMK095TTTl08TgdX
 WB4JT/g+puyTCooFmhGew8yCljBliK7R0CvcjCEjs+MZaU4irqBIs1jsy74Bh82WI25B
 wQCG4CYEYCcVcOWhM2Fy21Atsx0RKBTIc4bcLSHVWKHZ+0sNSQPD88gwvOZ0SJAi7wxj
 MKHDOCmiOx0+IBXBeAt8KG75omipdhHZ84OWknAps46DOxhHsQPjxIC3DO18U7XCF3+O
 JAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009510; x=1718614310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkVRQOt7R0Pxh4yKyfLDPZue6ZJ3HY7jiTUt26cEKmU=;
 b=EByMJ4X03239Z+x2V+Pbb8RQ0GYCmjCBgfuPHqzrZIE+ZGaV2V3dymdy3+vHeDWjbR
 I9znNFMQ+MresiopItgHejoFyt+Cv9bHvJYiny452Oj+FlXK5JSz4D0rHWgdIMNM1CXI
 tMgbnHs0bYZC4I62Xm45JAywEf9VLRoGerSrvdDzYzgBrQ0sH4VO5LBeQIoTI+v/OAbK
 h81MhklmboeocBuaoELHqCdb+OVft+mVuSoBsmquWbNOL4BwiFzbHpRDYnri4goTlYQh
 88Fp0y/Wt8x/AIvIqaPOCwGq6P32qymezByP/0n3SzIIrC0HEk0RO2FupR7pKnq+aBEM
 uN8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFx0U68Q5M88ZYfMiF+zVuKvjbPmUpEAENRVF6fWBjhKTFJWnayC/14eUdDxEBqxi1tgXT9qqr3ex2e5ZaiPjNF8+upQ==
X-Gm-Message-State: AOJu0YybKn28wq4peYgqY0VyLTtckrhCJGDsttbe0seKJ0kYmwi/KSF4
 RFzT7jdRQiHubKxP8FoVsH0F1m+aY0Be3LnGeCDC9YtwqZSJUHMX0SiBQB81CW/62dCeJWWIr3E
 eQpZDQnBjcuQ0PgvBAgZQs5paesYHEw==
X-Google-Smtp-Source: AGHT+IFzPbib2O0WRJf4dJo7lx+z8r1et8OgdVfHWE58D+g8ZjScin3Us9cnu5lR7TdAHaHxQOtvBBQKXatJF97DCuo=
X-Received: by 2002:a05:6000:1888:b0:35f:2584:7714 with SMTP id
 ffacd0b85a97d-35f258478aamr1003475f8f.5.1718009509801; Mon, 10 Jun 2024
 01:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-1-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-1-0c69d4457cc5@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 10:51:38 +0200
Message-ID: <CAByghJbTBLTBLjpsuebXr=6YWB7K1irRj8s0jPWjqcnLxAMhGA@mail.gmail.com>
Subject: Re: [PATCH 1/6] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
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

On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When calling android_image_get_dtb_by_index() using boot image v3+,
> we should also pass the vendor_boot ramdisk address.
>
> Use get_avendor_bootimg_addr() to do so.
>
> Note: on boot image v2, this is harmless since get_avendor_bootimg_addr()
> returns -1.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/image-fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 56dd7687f51c..8332792b8e80 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint =
arch,
>                  * Firstly check if this android boot image has dtb field=
.
>                  */
>                 dtb_idx =3D (u32)env_get_ulong("adtb_idx", 10, 0);
> -               if (android_image_get_dtb_by_index((ulong)hdr, 0,
> +               if (android_image_get_dtb_by_index((ulong)hdr, get_avendo=
r_bootimg_addr(),
>                                                    dtb_idx, &fdt_addr, &f=
dt_size)) {
>                         fdt_blob =3D (char *)map_sysmem(fdt_addr, 0);
>                         if (fdt_check_header(fdt_blob))
>
> --
> 2.45.0
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
