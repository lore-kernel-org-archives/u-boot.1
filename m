Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B7C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB982882CE;
	Mon, 24 Jun 2024 14:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMfPvjvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02029882B7; Mon, 24 Jun 2024 14:09:49 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D712882CE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c70c65ca5eso765584a91.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719230984; x=1719835784; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vCyO7fDi2uLjuCSW8to+3Tu2EMpgZPNm7yKb1vnA8M=;
 b=IMfPvjvR6Q1aRjgT+RHDXZiFCb29SooIaxmehTHKonFScHN1o1K9HlxD+7xxm/fGfF
 3EaPcRo63Oy7RGWsgZR4Lmoh+MsAzXhN/NyerH3kW/DZhpPIUupH36LfbZhmIMQeYNhK
 hrMCxVNV6iC37htnjuRt9gw7x51qiGI3PpdlJXOuk6ty90/OOhJG+6nIoGxLAzQEPsDJ
 nrpJdEgWqKDTPXNf9KXAownU57WMeEYWu/+ZsmOkLN50HPBXtMNgySGxm/GdsHC87+0V
 EDf+wpSLG/vQyDZfAAr/FZeHHzgtksEPYUpFqZfnwnOBjG4LG65iX7+LhGwFe162jpB+
 buRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719230984; x=1719835784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vCyO7fDi2uLjuCSW8to+3Tu2EMpgZPNm7yKb1vnA8M=;
 b=GbsATwN2DQke+xYiOjxQdce19iKXkpo0f2S8rtWgMSTmsO4cWYkVAD/a38PJxiTpS4
 WdjDroBVL+u1u//Hj2V7UB3QbIuru8qmkvz2CWuWDnBaPac4YMyFPGRZHhz5eThW4PPB
 nYWXAanCQBCrRwVqOYRWT69OyXJh/n2U6eXq7ZLWx5+4VWvlvo3xWugurnYMP/056Ala
 UXcrbDBMynBM+ZNl1hRc90PAVWD1BenPlu9WNNy6RUe0iCCy224ImbO+MnyBLaeuHoj+
 mkaZQRSiFa/6Asja2CleMYbAJdb6Dtd03V4nIJcK4hioFPJ5O++6cmdadSP368JHM0ce
 AgLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAmxRGwmO8/LUsb990t7Y/SF2JQYOA/TKtgYRnfAmqwEhW+rQXTii/klH8/Iw3Sn/0bFWg8FCnbwtucCby8mjN4fTyhA==
X-Gm-Message-State: AOJu0YwLeHeKgTPFOyBK1dDjj8i9fjAs1gOlXozl7qqQ/7+0i7cKgloq
 sPEHThYzkLhCibo42UXjIJzzhPTH0k4vlRNVMC+rYrgfjsOV7hAr5u+CnZs6/XmTPv/qZC8CfFe
 wLZnTaQyhQPrx4Dv/7Avr7LbY3nA=
X-Google-Smtp-Source: AGHT+IFpjTynkqApYS2P0tESQKknUiMp3zX5JVvhAtIusUNbawMsidUZkNoExb60vxgMPfPHJqtDCZLbOTq8ebcUuwM=
X-Received: by 2002:a17:90a:bf16:b0:2c4:cd15:3e4b with SMTP id
 98e67ed59e1d1-2c845f72020mr4878389a91.4.1719230984441; Mon, 24 Jun 2024
 05:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 09:09:32 -0300
Message-ID: <CAOMZO5D69WsyoKzccHNxmfc3mWpQkNOd0-Nii+KypXa4j0qahA@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com, 
 ye.li@nxp.com, eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com, 
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com, 
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com, 
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
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

Hi Paul,

On Fri, Jun 21, 2024 at 10:06=E2=80=AFAM Paul Geurts
<paul.geurts@prodrive-technologies.com> wrote:

> -struct imx_sec_config_fuse_t {
> +struct imx_fuse_t {

Please make the struct renaming a separate patch.

Peng Fan, Ye Li,

Could you please help review this patch?

Thanks
