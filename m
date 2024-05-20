Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5351C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C9F88076;
	Mon, 20 May 2024 17:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZXmxQix1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5575881AC; Mon, 20 May 2024 17:19:08 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C0A87ED3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ecd3867556so80318045ad.0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716218345; x=1716823145; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL4r9nZpEZGtz2kg5NDpQTESMWbTaix5WsFe2Qi57k8=;
 b=ZXmxQix1vb5kPUgEZ4c9oznoPKP6sjhYp9RLuyHL9xgsLwtrUi9+uN3pTwACT1GWn+
 dTBZ8/WmnLH7HMYdHCIIs38pm5wV9J2e/roiTX9LO+qXf0hLQO0QFVI7YD90Yhh/kgD0
 Jd0uX3AxGiupcXXwkSoXkTDvhxx7+3Q95dJKQswiq33AzRz19RgD1rfMqyAeHD9RO5Hx
 U8l0IgOG4CGjtq/TnCpBQBR/2QFZVToRU7sKtl6TNct6jVAmj4ulYSf+o56q5n6qsphX
 2LlG9Wpwq+rwE13cSdCwto11JkcZVU/o+v+ipTjqbsGykTd3GkpagBHXDYPunr9mPQtk
 fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716218345; x=1716823145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZL4r9nZpEZGtz2kg5NDpQTESMWbTaix5WsFe2Qi57k8=;
 b=fgt+iHgtl/I2VOeWqOwaxWtEOWPf/e4b7JfMDA7TtBMWtiBpZTkHnkatWLMh3/xElc
 hFIg83xnkk5RbqylzgcAFkFkDzqmpHGL64is1rwcHeRbN41Hz6HEITQzHQsiNlZE1aaz
 J4RQBOnVRBtQqYPzckJL3Uis4uzZ5/kyAnuyXqmxM/TUYB5cAxjH3hYBttRInvzQHhMP
 HTyXslpctwV6Bint8nhBy50Hjs4JkmmBB0IamSz06jnBdWsSwnnFuucbawfBygjaOsIx
 OVWvDJYAyhKMvBFKqen2gVd0ruAvtMyz5vLcyBFsIizBJEAw+I909oq/SbY6or4bSCjF
 LXjA==
X-Gm-Message-State: AOJu0YysNSdfFAHpi8C7EJBTOzTY8s/qjKhOKvcM3mDqoNysGizBeUeD
 peHyfVbmJOl3JBoEySXHC/7FuB/h0IYE4puuqMbz1Vi98dzk+XNgJu7+7ZpMcwnvEpYaZlxSOqU
 BePmJ6b/M7ALj4ULRMpvzZ2/QdXE=
X-Google-Smtp-Source: AGHT+IHN15OBw3mfNCPA/5CH/F/yTDa+pYxYzKdTX5HOqPYcdcAkj1mQ6b6zy+8lN1UOHHOsIQYdGhHxnV/CE2P13eg=
X-Received: by 2002:a05:6a00:9285:b0:6e6:98bf:7b62 with SMTP id
 d2e1a72fcca58-6f4e02ac4cdmr35575665b3a.8.1716218345087; Mon, 20 May 2024
 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 20 May 2024 08:18:53 -0700
Message-ID: <CAMo8Bf+JNR-QSECNhaCWKVkU1s+m6-eUrqePzF=7XyezxDWu0g@mail.gmail.com>
Subject: Re: [PATCH 04/10] xtensa: Define PLATFORM_ELFFLAGS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, May 19, 2024 at 1:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> u-boot.elf target requiures it to work.

Typo.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/xtensa/config.mk | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
> index b0809999e403..3ec936272f25 100644
> --- a/arch/xtensa/config.mk
> +++ b/arch/xtensa/config.mk
> @@ -7,3 +7,6 @@ PLATFORM_CPPFLAGS +=3D -D__XTENSA__ -mlongcalls -mforce-n=
o-pic \
>                      -ffunction-sections -fdata-sections
>
>  LDFLAGS_FINAL +=3D --gc-sections
> +
> +PLATFORM_ELFFLAGS +=3D -B xtensa -O elf32-xtensa-le
> +

This fixes endianness as little for the whole architecture, but xtensa core=
s
may be either little or big endian.

--=20
Thanks.
-- Max
