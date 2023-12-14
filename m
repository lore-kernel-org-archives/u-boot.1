Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B83BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A2487993;
	Thu, 14 Dec 2023 03:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nY0PLF8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63569879A5; Thu, 14 Dec 2023 03:04:04 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3D3878E2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6cea0ea6817so716233b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 18:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702519440; x=1703124240; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O77QOxAz5Nozu4czf3ll7EvMBJjWpw2OUbyp+Dbgorg=;
 b=nY0PLF8o5rIBVO5Dk40H5bbIpuDLQQpY9/88LHywRPHtw7ytih6LFsgMFslq6bua/d
 L4N+o5rr+83g6d/JXedFxhGVO5o1oNBtH87QJMAYmt/2+LkcRVtUxcVz/d0E6vJdmIl/
 pW5J3gbBUcIuIhauxSaEQ6Yykhg5yWloVXSSa+ppoB03Sj2hSeSW47op1Px76QDZp8Qp
 57cO4zs+RA2Y4lwUmAK9jb81Dl4+caqty2hEXPs5a/gEPDIJhMYKIpWrp1LlljUDLZfz
 8P/0hCXRHRMs9YE5ay/0Q8kJnRYHJcibf+YhVrCi8s/CmB8CrdhX91mSnrInEAAWRYSO
 eoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702519440; x=1703124240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O77QOxAz5Nozu4czf3ll7EvMBJjWpw2OUbyp+Dbgorg=;
 b=HfahSU1mGZzUtoWDkE0bTuU415SqM0dYn+3V7RuJkw9L51HiJRXm10aYjIxL+bmGW+
 le0+xWFNrzHO3WoVg27Mk+w9YBEuplYcsbdQe58KMzw4VgQA7+IHqguG3K/W1h5OqQH3
 Nlw/0iGMLVx3sUnDepropuaCXy60bEqOIUFl3lK5V3Og+ZRrBo/4KfhDrF62an4UZRZr
 +ItAbleJwCDNL4MBiTm+WXpq60jBRKddznttO7Y5+5CZvJQ+acuRrA9w9rem+wk6kmix
 V0e5sWoTTkhxPohWRIMJurbDjCg3CjeImd3NU9ZXCJ8Vz+gPAQkTau4gYIscgffGyHw1
 5+qQ==
X-Gm-Message-State: AOJu0YzAPKjoFo7sCN+o5gzoS7D2Mcl42aR3kWSKlWL7F+RweCuh+j3z
 T/4NhLWw3B4w26V5NnxO6XPOPmifpUPqxJ6iYEY=
X-Google-Smtp-Source: AGHT+IFH9qHhvSdlABFU651puF33XA8fxKPNXzOqGI3rrL77dUnHid9pKNI2PHrn0Ge957sQfKK7ZbabXKAlDMcbxgI=
X-Received: by 2002:aa7:888b:0:b0:6bc:67ca:671d with SMTP id
 z11-20020aa7888b000000b006bc67ca671dmr19104064pfe.1.1702519439926; Wed, 13
 Dec 2023 18:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
In-Reply-To: <20231107221617.470-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 23:03:48 -0300
Message-ID: <CAOMZO5BrDUKwqJu_pRinO-0uh-zR=P170YmLxZRnirDEvRVsyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br, sbabic@denx.de
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

On Tue, Nov 7, 2023 at 7:16=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
> and USDHC1 (SD on carrier board) to use on any carrier board like
> PICO-NYMPH. Based on the U-Boot version from Technexion it adds
> baseboard SD card boot detect to able to boot from selected USDHC1
> or USDHC3 boot devices.
>
>     - Add baseboard SD card boot detect from Technexion's U-Boot.
>     - Implement board_mmc_get_env_dev() for pico-imx7d SoM.
>     - Implement mmc_map_to_kernel_blk() for pico-imx7d SoM.
>     - Add board_late_mmc_env_init() to use from common freescale
>       functions to able to provide "mmcdev" and "mmcroot" variables
>       in environment of U-boot.
>     - Add "mmc1" alias to use for usdhc1 in imx7d-pico-pi-u-boot.dtsi.
>     - In default environment set "mmcautodetect=3Dyes" to use boot detect=
ion.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Adjusted commit log, removed (void)(devno), and applied itto
u-boot-imx next, thanks.
