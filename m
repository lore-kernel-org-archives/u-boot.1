Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7046C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4985988BF0;
	Fri,  2 Aug 2024 21:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nIR1zKNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBB388BF3; Fri,  2 Aug 2024 21:28:33 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E7088BDA
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef243cc250so16041621fa.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626911; x=1723231711; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rycDyXiSEI/Gf9QG2CbKUyQM8Zxkm42fpcpYRMWfew=;
 b=nIR1zKNh8SlhA4vbBxmNLaZ++GfbUbzgBTcjxeAuhBr/I6jyUAxHwcb7P/Kvke+Oec
 g9iX4O08uotDCQOQOy6nwNxlVuDu9Nx3WCxSwx+nz8cZon4WvelshMP91Kr2DvVK6ANq
 gPaT8ho/rUcOq8ppm9DRa5U8Z55YHcfQ1CJ35Ho5BFSu8y2m9xnWtebl2k2wFQKwpkRA
 jL2rT0NZOI01coeTpgTxpbRoFrhl3o54P52jFK/ZYioO1+8eGlNN+v5sHd782r5rS3sv
 o+6FaxvzinWqW7UcpEh4hwTRpsdFH0R5qA5YgZQ5hruIPNYsltpZn+c2h/AJs9Iw4urh
 nQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626911; x=1723231711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rycDyXiSEI/Gf9QG2CbKUyQM8Zxkm42fpcpYRMWfew=;
 b=USNqAW0KAmDnSoOQ2dCVQKksVjRurtX0ecHGoNcnYnpPyMLpDMwMDKshVD7UW+hCDv
 vjTDc8yh5wT3h3deV2V4rEgyfirvkZF6jvuITxG56eWoGY0D6VYTyb0RvMmuppDmKhJj
 wkr9Ggo6LKtgSAnpboohcASbx8pVekqBtLpVeJjFbK/WfSldic8cDODQHSMsstdHBh/X
 Slhwndz5WHMnKu6B34uf2Q3ReZzyym6xQxdVgSu69OhIIJUViiM5zy0muYKUBV0sZdWl
 wW6muBpoi9C7ip1xUW2NrDLZhI4gATp9OXDhQ3sJ2SiUg41MNRhYHJ5Lpy/QHZWWHi4i
 iB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1TS7YR0TyIZLLqHHSRx/7mpEdZbmMi0neIrq7ZObmQZD/xUtkv9B6M2BhL65vGYWBK2tSU2Rl4QP+lZDDRq8OLFsqqA==
X-Gm-Message-State: AOJu0Yxqa2sr/mL1JQf1HDJWHsJsMVfD6CkGBhmaChz2jJUhAMS8oGxE
 ICVMAQdRlrk7w+pPsRqPEkVgYf/rADH2TKCW/vTPltuoSaQyz8vJQ9O9cvfBwaHcGXDz4/87fd/
 B/uZJK2XIvg7fpPRqMqFRGPoGfmw=
X-Google-Smtp-Source: AGHT+IFaQAqE1rFeluXA8zSh8NA7fE0O6r3lj5zZvDu5+ecjwSHCEYv3bC8vcB/y4MQjiVuMatub1DB+Hc+Flb/RtVc=
X-Received: by 2002:a05:6512:68b:b0:52f:c0dd:d168 with SMTP id
 2adb3069b0e04-530bb3b6de5mr1760705e87.7.1722626910790; Fri, 02 Aug 2024
 12:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <038dad39-e99a-4464-be5e-57a3a73ca8af@oss.nxp.com>
 <20240702090928.1663707-1-paul.geurts@prodrive-technologies.com>
 <CAOMZO5BGYvWhb9gBspMb4mbx_OFmJ+0TiKyP9inZ+i8ieToCWA@mail.gmail.com>
In-Reply-To: <CAOMZO5BGYvWhb9gBspMb4mbx_OFmJ+0TiKyP9inZ+i8ieToCWA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Aug 2024 16:28:19 -0300
Message-ID: <CAOMZO5Be0oXU30LYykk-gS_eaCgE0_wtdN2Vz9s+CeoKpNLO_w@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: ye.li@oss.nxp.com, sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, 
 peng.fan@nxp.com, eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com, 
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

On Thu, Jul 18, 2024 at 2:02=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> > Okay, thanks for checking, I will wait for the details and make the nec=
essary adjustments
>
> Please let us know if you have more information on this so we can
> proceed with this patch.

Please re-send this series whenever you receive a confirmation from NXP.

Thanks
