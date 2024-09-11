Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCE6EE57CF
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 19:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D7788B86;
	Wed, 11 Sep 2024 21:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clsVweAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2806E88C30; Wed, 11 Sep 2024 21:56:01 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72B688B27
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 21:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f75b13c2a8so2698511fa.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726084558; x=1726689358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq3XeKNWuCUI87cUPuYX2Ra5g6jtd5w4dmA1vQ/6Pas=;
 b=clsVweAwVGnbnyHwki2L9sdmAGfZ3pQkKK4SCv59FZ3kgCH2ctmig5eXPc7UHzpX5F
 qTaQ42iFuY+AB6qSHdvWdMRMyVUfYEXERpZ+lKr4k9GVc2+/2unBDOmPthCuLWbHhwdt
 mIWlG+M2u2b911+TcfDA7MH8knjdZi/mRKNvP8iA/tgJYy6K3GX7A2y3Ua1gZQqa67gD
 YG7htJLyySAah0U5lIqsE2BGu+eLysDj4BO5f+ldvHPhc4XKh4zVgYzme4Ae8V2H4RLC
 ejy6h1qzKdgJ6ckb6cAUfvDChLUfQ5IfzBwJvkqMvZAM/YfygTDaf+4Ud4CGmEDOiMug
 ghjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084558; x=1726689358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq3XeKNWuCUI87cUPuYX2Ra5g6jtd5w4dmA1vQ/6Pas=;
 b=ven3Vp4PkZ1jj0gB1PaDDqy7kRSAYZqV9LT1mV8OqRc37ZFqgkmj+o47s76fdoNI2/
 VCJSeWjEZuFs6tOtUDFI2ZRz5Jtu2YjXGaTpwUTRJZFzV713OlOy/kBZx0juhYd+LWGX
 OdOhsOFuIhKDBnbWKfPWjyWsXRtncU6KoQciFQyzZSHvp6blt7G6MQ7l9d55MdmNsNcY
 /5wzuh1v7bRboBj+ZD2RgDEpy329nTizeSCmWeUFZGJusVb3+KdBoQCvq15cjCItScVx
 UShL/fan+9Ob3TRsAmv5WzkMXep94fBeHrwoh9gVURXhoCU2SFrGLq/B+DzOZR0YFN3G
 XSdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/fETdEEfQLdlMd8lc1CZEIeVE7ATci2ONjRS0UkF5WPA1LaadGCqDt8AU39XCyL+lUjRLi98=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfjho8nj2hbXFm8ykwxMJPKJegr5fvW6mYi0jSFdatEe2iGP/h
 5txWsKh/OKwR/XVHCpQkV2JwhmT9THcqnK7d0/STN1HPyaiVfxofghbh+/dTFmCkscu48Er9aB/
 4mdiKXhMHLAh/LrJTRE47zGdD4Ss=
X-Google-Smtp-Source: AGHT+IEIgIHXZvANWiOPgY13BcobJrSU92squLwKAiE11TfpgRZwJ22Ljx02uLaT/w+sJ8I05wUTZlaBsHsOV8mB+hg=
X-Received: by 2002:a05:651c:2105:b0:2f3:f7cf:2f01 with SMTP id
 38308e7fff4ca-2f787f39bcamr2054231fa.41.1726084557874; Wed, 11 Sep 2024
 12:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-8-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-8-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 16:55:46 -0300
Message-ID: <CAOMZO5DhTzTp5pnE7Yz=BUn_w7OWOeaJT78nS37j0cUaynmiEw@mail.gmail.com>
Subject: Re: [PATCH 7/8] video: imx: Add LDB driver
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Add support for the LVDS Display Bridge (LDB) found on i.MX8.

i.MX8MP for clarity.

> +config IMX_LDB
> +       bool "i.MX LVDS display bridge (LDB)"

In Linux, we have:

config DRM_FSL_LDB
tristate "Freescale i.MX8MP LDB bridge"

Please follow the same description text.
