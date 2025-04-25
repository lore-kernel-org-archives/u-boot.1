Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE4C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D8381E14;
	Fri, 25 Apr 2025 13:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gO1mGjIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B33581FDE; Fri, 25 Apr 2025 13:48:01 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1473D810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54c090fc7adso2149259e87.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745581678; x=1746186478; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwQRuvdgVc82AQbgm9L1kaZ2dJXQO6y/oM69jlgC+hg=;
 b=gO1mGjItEg3/bng3W9xYBBe4EPguBOjCyfQ97F+0w46147eOr2H/TVThXLHtQSjIz5
 2qDyoHb0IeGkg8PBmcYDHFPdypW3jvHzoz8P2A46jP76AAw1kWRFjTZaL6DRk1v7Jdqw
 0ad8LCH6FqOIToEomIESkWGgoKjRXU820RWLuYsqoWogIyXwvW/l4+fIYibIWrVtsGIU
 9loaJKJBj+dVY3f/k1BMS6MVVyQ+ieA2WMlREaWVHtEUMEWmElOFDS5IV+ZJtrrz0ICB
 2SnSo5olL+r4/2GYQgjzj1pzPMQkHyLjyCxOPhU588qPkuyFlRvWnl0UX7hu52MpnhsK
 Royg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581678; x=1746186478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwQRuvdgVc82AQbgm9L1kaZ2dJXQO6y/oM69jlgC+hg=;
 b=J/NMzpo11Cbhj4XrGw2EOHHsCbgdQrxjwV1ySS8LKBX18/S95L17ma/5vsQllPd/FM
 lsppADygvxPs2MDlwJfkYN+Q5snBapxDBPm0vU2PwLsPNo3TPh/h0xDorUs00NMtG9B+
 MrQQp50aghlaQK9SJm3X3boBBtYWTyaQVoq+qhS3p3U8ckl/rp/YJumF3P1Sf/vu70gN
 xKz3BHsaab9VuLHoc2Ebv8C3HyGLW/u+mWXFumrdCVWYX7nNB/F5mHq1UdIUXxPLVRlF
 33o9hUNDuWT/khfSlLH6zh3dwgGAR4d3yNgVsuVEdkrbvlNhsPWRFN3g47Dvq/CIcJyD
 +r2g==
X-Gm-Message-State: AOJu0YzahOBl9YLMqdQgXbeyWc1piYjosJ6hiSHM05LEmpZ08vEGfrjh
 wHAKXFZsWsKJj7RvLiTYythOsH4ReD9OHoUlVZvMBYjOSkqKn54JjFodXE+NcNR67yxoB+4Bv2C
 fFtXA8rSQ5TDoBlNJI6fKnYyPs84=
X-Gm-Gg: ASbGncueQTZPXsAZT3ZVOMvk3lTuE6uotO8tQQ2v3edRqP0QcDfciHiHTXsJ9EQLfKB
 N+8KZC6y+58KWqPvCKx+9kvY+pwlHCcKNjr/l/+bderXbDFiIWhCx2qk7pVkIYKyahwE+u8f3vY
 TH41ebh0xKHPg+XqnY1RdW5BfIkKHvb34130sXEuCluJugK+0sq+TqYA==
X-Google-Smtp-Source: AGHT+IGHTvN3i61SdGVMY1WnInBep6LjiVGgUnvQLDk6av+HYnwXO8qztigq7laTogFWTp+MhieaOBsUbr4fEdM/hrQ=
X-Received: by 2002:a05:6512:1394:b0:54e:816a:ec2e with SMTP id
 2adb3069b0e04-54e8cc06418mr565318e87.39.1745581678052; Fri, 25 Apr 2025
 04:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-4-hs@denx.de>
In-Reply-To: <20250416090419.54781-4-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 08:47:46 -0300
X-Gm-Features: ATxdqUGTFntY36jfnOIJ20xJuaHbgDwK-mBy4lLYHGjW1QmIM2Xp8lBv29nTQe8
Message-ID: <CAOMZO5Bo-W6M3Ax52QK8PzFYOb0=Vq2EmSd9SqN-sQZQ1b0QUA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] siemens: capricorn: add ahab command and enable
 watchdog
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On Wed, Apr 16, 2025 at 6:05=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> From: Walter Schweizer <walter.schweizer@siemens.com>
>
> Handle watchdog in U-Boot to fix CI.

This commit log must be improved.

The watchdog's purpose inside the imx8qxp is not to make CI happy :-)

> @@ -16,6 +16,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
>  CONFIG_SYS_MMC_ENV_PART=3D2
>
>  CONFIG_DM_GPIO=3Dy
> +CONFIG_AHAB_BOOT=3Dy

What do you think about this option? It seems unrelated to watchdog.
