Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABBCC52D6D
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 23:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29738890F;
	Tue,  6 Aug 2024 01:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VpmmDbOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D366E88673; Tue,  6 Aug 2024 01:25:12 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963B088361
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 01:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ef298ff716so467861fa.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900310; x=1723505110; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNhJ6GLbHVKqYaL2ot7Uv8L45xHRRzyQMTH6SanxFcU=;
 b=VpmmDbOTqZsfqCC3YcMJcgReZcOO9fIp/7JGb420+EGY3Pb3e1F4qYcR8s1dsBwppK
 38qGqkTW3aRaP8L829TM66EFyv+dx8sPHgbwXlcDyEjHfByRIuqstAUOF6D6p6fMmc8d
 CWu+wGS75xmt5baUe7OVYoa6RzzH3mxlP5N0cvvJJHGZHfO5ZF/FlZIaaYlEwYVc+CcP
 d5qmaXOIJPSEOk048oQ3XFFKCjQkKO0COHRJAQ9lM9qG23bSXq+1HOyQQmmNd/G29f1G
 28OBOS+bzjD5eQuGpO5Nu6jTYwp4qoW06A6Qi9WGLjTjD/X1hDjbHUOLpdSLl3HfhrkV
 cGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900310; x=1723505110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNhJ6GLbHVKqYaL2ot7Uv8L45xHRRzyQMTH6SanxFcU=;
 b=JVfw2bJ1ptUZQJh1a1U+r2dkCdCem71OiQQ7HKnp3ZTGcQkGc1vea55uOmmVTPTKaZ
 zKVo8JTlELCr5d6/uzUVBR6FUCvXyMYddWvPzwrwlCNveFy6a916wSjT8MGslN5ukNJY
 BWUxEUgqMdOCFuPaCn4V+Bgh4N9fnxXrEcymUBHOfBHjCZ8KEjuSYUtZ/98Ib2OUZeL4
 aS+2Q/6Z+SBKCbTK071iv9Tsebt7Myt7leG6GGIJqIiToaBoV00dQyIdIllulpM744GH
 5EB3mzL5B7OdyOl1uV4i6p9fJ4emjOzMRi35Es0ChrwzyvvzOfllweiRW+yHGX/xO2Z7
 +aIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUaG5emqHdB9cX8XsjXysZZw5jjyoKZdTN8ykQP4DdNSoBasxsLUGdykBMAyn88FUzn8B3iMf3EpfiGZ24Z8rfNpsLjw==
X-Gm-Message-State: AOJu0Yx574ZxRJwIx4WyfYRmiVr/jg9+BVSUmj027RhNPzCmt3V3qQaR
 JuclL3ZnkeZbMZBDe2CPjcAz/pBwd5XKfbk848nRBnXMJyjKmLZsPOGu8UBDNKJfyMxkPP4EyOi
 C0+kOWlf76F9W+GDAzaZty8/dblA=
X-Google-Smtp-Source: AGHT+IGI04rFEpq7djLv3siPCkn9/P0jSTxOVEtiNL8I9CMVmBkdhJ9DeUcZS2C202gZkpuDA5p0yac2BVHkEqjYxcE=
X-Received: by 2002:a05:6512:3da6:b0:52f:c337:4c1f with SMTP id
 2adb3069b0e04-530bb30827emr5048926e87.0.1722900309342; Mon, 05 Aug 2024
 16:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240805084202.3530203-1-lukma@denx.de>
In-Reply-To: <20240805084202.3530203-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 20:24:57 -0300
Message-ID: <CAOMZO5B6F3LZcs=eYpZwOmDGctRqrnJDby2hH_343vczpk_uJQ@mail.gmail.com>
Subject: Re: [PATCH v2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

Hi Lukasz,

On Mon, Aug 5, 2024 at 5:42=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

> +       "update_offset=3D0x42\0" \
> +       "update_filename=3Dflash.bin\0" \
> +       "hostname=3D/srv/tftp/\0" \
> +       "update_bootimg=3D"                                              =
 \
> +               "mmc dev ${mmcdev} ; "          \
> +               "if dhcp ${loadaddr} ${hostname}/${update_filename} ; the=
n "    \
> +               "setexpr fw_sz ${filesize} / 0x200 ; "  /* SD block size =
*/ \
> +               "setexpr fw_sz ${fw_sz} + 1 ; "

As Benjamin pointed out earlier this increment by one is not necessary.

All other i.MX8M docs don't have this increment.
