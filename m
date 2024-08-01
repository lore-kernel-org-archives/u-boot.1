Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57F9C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 13:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EF188A9B;
	Thu,  1 Aug 2024 15:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VcYXBdnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D0C885AE; Thu,  1 Aug 2024 15:13:28 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2273388ADF
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 15:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52f015ea784so1162984e87.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722518005; x=1723122805; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+i0mfYKwlmad+MNup9nrh9RfeSTfEj2Zg6NRbl5jw/g=;
 b=VcYXBdnYFz5tW0MaHIvj9Yxjna3AXwHfbPPdBLnqFSVhLYIBaocFfnfCHHW+VXsc2p
 sOXEbIYTJYufOjsFoLKxiC3RBIzZGKIhaNTzWD2VXEd1500pVepkPMnrTcfHhioJGjTc
 75hx0/io3LmS/pu3zpc8pPgZyunwQB9HfL97fMZKYAYqltc6cNl2/jqSSjJHABrd1Zm+
 AFTb2wi+O0MVFVNhYsSYrMV5qfJ/tfZ6HQkIc/YtGby0W84HZ11LyQ8JOlUXhDz6ZwV7
 s0kzVEOdlCVMITwpPtuhKTluqceZWnVo30fM+zHr4qPxulfU6q/N2gV0sVomSnyInSn4
 B3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722518005; x=1723122805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+i0mfYKwlmad+MNup9nrh9RfeSTfEj2Zg6NRbl5jw/g=;
 b=sxQOC5sVWO6iCeLrfqPQjhr2/qo4jQ9zB8pKdu6bE4qxgePKawgTD8eRG9W2rYg+f3
 Gt1l1Plz3gXaCAypI++A12fnrHmegBGpZewvX95tKZKALVr72oDbFBLDZvl0qdPWXXdv
 kFsxETMR5OoE/H/WNeQ0eIZocUfSWJlaB+UZdv0sBkPP2Qo2Pm+cSjl6MREhkXukLIN3
 CN43L04FFi4SnRVmB7NGEFYFHL3ALgekYOn/hYY6FemIo6neeAfKPG2a+e2NZ4w9E1BG
 yltr2TWnVkg4MLEzFxEHFDd4ENmu5MT14TZy1ni4T6f8EM7HdUH7iRzgQ7TVvoYjh/Qo
 qhfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJfUGkcwWGvrAEVaC26tLaTaCmp2+CoZJ1Va+yK9CCgyAD33vqalENGu3/YmG6rc2qNq9KG47kxjfEA3uP2+qEX08YRg==
X-Gm-Message-State: AOJu0YzbRHj2FvhTrBmHEkOY3LnvMNQbIG+/MnDP8D5yAhRPutgN4N28
 Zp9y3ir1nFAhsu1ckhh7z3hORxhraOeaG+JJ39L9h5u/4KaMbssSlz/vFfAK80v0oS3VLu9LUIb
 0bbgj5+GrHmHnXCPHt1L7mco1SxE=
X-Google-Smtp-Source: AGHT+IF1V6XBpoqeVjTJTJq2wIsP264Qk5s+AynLwbCElbCYQLJ54HMZOQRiUQzw8C+/Wj5l637PUlTTBEGNkuPKNEU=
X-Received: by 2002:ac2:5dcc:0:b0:530:baec:3975 with SMTP id
 2adb3069b0e04-530baec39admr42051e87.1.1722518004918; Thu, 01 Aug 2024
 06:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240801125416.1582652-1-lukma@denx.de>
In-Reply-To: <20240801125416.1582652-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Aug 2024 10:13:13 -0300
Message-ID: <CAOMZO5AJw66wweVOL0QkvnKrAWCKRvQ9n00OdRfUPxfR8LUibg@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: Add 'update_bootimg' command to update
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

On Thu, Aug 1, 2024 at 9:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

>         "mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
>         "mmcpart=3D1\0" \
>         "mmcroot=3D2\0" \
> +       "update_mmc_part=3D1\0" \
> +       "update_offset=3D0x42\0" \
> +       "update_filename=3Dflash.bin\0" \
> +       "hostname=3D/tftpboot/lukma/\0" \

I don't think all the users will like to use this tftpboot path :-)
