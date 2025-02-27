Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99AC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68C680FE1;
	Thu, 27 Feb 2025 15:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kkDo0L75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E348880FF4; Thu, 27 Feb 2025 15:18:12 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B0A80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30b83290b7bso11868021fa.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740665890; x=1741270690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2zV1Vkv2ON8iRN2Ub1lgUKjxwYrENwXk2CVEFKn4Rk=;
 b=kkDo0L75FqB42EHOc+XgeRtDI7sJgEByHj4mhT3JX3zkRo4r5PWqvP+0Gxo+7Ek5zX
 4l1upfyZ6yzTDfcAUst/801bDVe43j0vThsyKCEptUPmV+yqpbkhjcY6lZlhgJuOKrus
 WZQIvS/qn3e2R+SoVRgEqRvoebPBJ98I03pTNJ78fZUJxSq+DDgFSCBtXQOh5DjBlzca
 lbYple25OefZHwGCWDDRGWLYQ6dH7vCzeT450Jv334AJSwX7o/RMBP9JeH23HjUEc6tg
 +ufYD9kqBpcL6x/ep4iz25fDgja4+lMcVE7aV9aN2M4FyoYGW/WArNelXtXPbv6mZMIN
 h3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665890; x=1741270690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2zV1Vkv2ON8iRN2Ub1lgUKjxwYrENwXk2CVEFKn4Rk=;
 b=Y75zHb7cdjqaee+8Bz+/TvHHkDC3mXePJ5FSyRmh9/I9qBhqA7rsvQAhUfMpKd2DuY
 4kYZ7uEuSVmg+zgI5fgOI0P/vyCMEqkx9NQVbYxhQPxL5+Nz9KDylEnvMJaZ6AkGpFY5
 9xfuVAUHhX+jQuWenbIY+X8RinfjDuQcNTjVx0hJSSb3KUFCc0W990WaxEECrI0/eoCd
 THEBdvDvMtZtimJM0A7TrZwZbE3uCVjzPHrh9e6D6dEIZvKUicycGClbj4aObaKjCiWL
 xIIdj0zNNILdsX+LW3Bio6dE7Kae9C7L3m9Bs0gZPnM5QMeQmS9deuWWAkP0my9GHYsS
 zRXQ==
X-Gm-Message-State: AOJu0YyxwCtk2cyK0sz9te0SdJ8/XnGYBUSgaYQx5nYWidtWXYcPZLRw
 6tRTg6bt8XwIZiVNPdjC/0V5Mon4y56rZ+QneenRnTfc1kd/1iFD9hMh1d/9GxFke7jZUY8gDj9
 9HdTEgoJMUFIcUvuuUj3jlFcZ7ok=
X-Gm-Gg: ASbGncsephgwzqeiQrez0rQb+jcvQopyK1wqsGTcVEgxdzXapsnQ9XxFp297it1oYk/
 KDaO/VfLCBAm6yQ7zWKdYZOGSFyQCwOnV74WmhLkYHbXHD3VHiZ86Q9HF0pB3IChMQ+ZXfcDjoF
 ryx9pmAHBpFW+v3aBX4X0oRPwu2Vc8KinluZ88U0E=
X-Google-Smtp-Source: AGHT+IEZ8sddFZShq6n7X73j7FO3Rv3RpFRoz4vshNHYupen1FkFCDcUzPeVyreEtJhp6qeTx+sbX/GSvg1zdNg4yfo=
X-Received: by 2002:a2e:3a0f:0:b0:300:1dbd:b252 with SMTP id
 38308e7fff4ca-30a5b171b21mr93834291fa.7.1740665889989; Thu, 27 Feb 2025
 06:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20250222171329.90917-1-marex@denx.de>
In-Reply-To: <20250222171329.90917-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:17:57 -0300
X-Gm-Features: AQ5f1JoLdLmFlM0ZRK1uTHRfqOEtu0de2L_Vo-Bk3CZCfgxIiWjoJPlqOr5Nh40
Message-ID: <CAOMZO5BjwG+geZQbm_-po0cZaPH7i-_mOGco4mDF3grRqGB4gQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Introduce DH i.MX6 DHSOM board specific
 defconfigs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sat, Feb 22, 2025 at 2:13=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Move content of dh_imx6_defconfig into dh_imx6.config. Retain legacy
> dh_imx6_defconfig as multi-config for all DH i.MX6 DHSOM based boards.
> Introduce separate imx6_dhcom_drc02_defconfig, imx6_dhcom_pdk2_defconfig
> and imx6_dhcom_picoitx_defconfig for each i.MX6 DHSOM based board, to
> make build for those boards easier. No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
