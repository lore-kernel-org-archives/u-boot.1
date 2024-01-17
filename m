Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94263C47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 06:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4AD86D82;
	Wed, 17 Jan 2024 07:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="bPA1LujD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D6B8787B; Wed, 17 Jan 2024 07:27:06 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96E286BFA
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4b72e63821eso6515058e0c.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 22:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705472822; x=1706077622;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3f6gSuZHK9qYCWU1T5xnt0rkrMtOvNfWSHlg+htnaHE=;
 b=bPA1LujDrbbyGVFK8ljFLgZiV1r1QFY9Fj0InpxDspMZfdk0gpGPjJ/TN/hUw3R5qx
 mljeoKX1onfev0LVPQiCrfj5ylGgk/6j0YsENZHdtzn+Lk0hbYsWbuRx7n01/qQ+3wDa
 tKj+eCSZvOc9A+J8Gkkkd31t9++DwXcC4NcKf7GC+KpGp03BN14vipUgO7hMbA9lFGM+
 5hTp1gr2sxQv3ejJQuXavOq1xmVtgDgBYokB5smgYAdFfkG2PvdX1YItNqNfxoK3r9Q6
 5TngRKn8AqeOor5GU/roMJ7K0+2MsL3aBS4VyRjAlcQkAyXY1ds30AavlP7TnJZcpJ5t
 n9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705472822; x=1706077622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3f6gSuZHK9qYCWU1T5xnt0rkrMtOvNfWSHlg+htnaHE=;
 b=UDV4Oe6YEOQhAo9yzf8DBa/OHFbOzfNhHVWMFQhP3iUiprJpwUeUzaJ/FHEATvxFYS
 EO2O7O6NVIg6td5J+YFS2mVrgKXp9PoTbhdmleCBovQcy+vnFngV9lDQMlaziH5zQ/FK
 MmH2ad8MEiEKENvRSUOOnhro4pHgDybv9Gb10rOwxqEcoczWfzLNaKddgeRAmLdo6B/D
 ryRDkUzqBBJWlC6VZW94hizVAASfsaetej6shUcKi6MGHFlDlJ5xc4b4c7xYwrgjbqSF
 XISxCgA1Gl+IGm0jHqhr5T5x+xru0kU1mnLofK1RuTBiHnQv4AK+UQE99Dj4Efpf53ik
 SRyQ==
X-Gm-Message-State: AOJu0YxAKn6HeY2rONvqRODhkXDAhz59rUrsSOwAP3spNiqxzrWkqP3Q
 2LYYUs5TuYg/hJw9EmfRZ9Aqu0KMIMv4tGhw6Od3gcvufK5H1PHTBT+uCXkuo74=
X-Google-Smtp-Source: AGHT+IHBR5UDjwcWGmV6p/tc6L69P+Ck2rpauFeD2HWdt+vFBwTuh/RmeH45qkP9m73PEfujbFCf/7dqnoieEdafjpo=
X-Received: by 2002:a05:6122:12a6:b0:4b7:185e:b866 with SMTP id
 j6-20020a05612212a600b004b7185eb866mr134708vkp.9.1705472822388; Tue, 16 Jan
 2024 22:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20231223065159.580100-1-i@shantur.com>
In-Reply-To: <20231223065159.580100-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 17 Jan 2024 06:26:51 +0000
Message-ID: <CABEcMwWgiKKQHUO8zZOi5ucEdyP0jT1HjSnr3m9XSb2ybiVhrQ@mail.gmail.com>
Subject: Re: [PATCH v1] Kconfig: boot: Imply BOOTSTD_DEFAULT when
 BOOTSTD_FULL=y
To: u-boot@lists.denx.de
Cc: Eddie James <eajames@linux.ibm.com>, Simon Glass <sjg@chromium.org>
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

On Sat, Dec 23, 2023 at 6:53=E2=80=AFAM Shantur Rathore <i@shantur.com> wro=
te:
>
> We need BOOTSTD_DEFAULT when BOOTSTD_FULL is selected.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>
>  boot/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 9f5b8a0cb2..fc96aadb27 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -426,6 +426,7 @@ config VPL_BOOTSTD
>  config BOOTSTD_FULL
>         bool "Enhanced features for standard boot"
>         default y if SANDBOX
> +       imply BOOTSTD_DEFAULTS
>         help
>           This enables various useful features for standard boot, which a=
re not
>           essential for operation:
> --
> 2.40.1
>

Ping
