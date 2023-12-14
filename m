Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6307C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E31879A0;
	Thu, 14 Dec 2023 03:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fLUJ7/07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD150879A3; Thu, 14 Dec 2023 03:02:17 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C7A8791C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c67fdbe7d4so1124499a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 18:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702519334; x=1703124134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47gLWmgqtM70/xKoD8VYLDi3vUDxCLcXeMGxKrFGQjc=;
 b=fLUJ7/07Qwd6qALS3vvIenocfcotSOQ17jQyc5jtNmIGERprzW+gL0O4dR8lVvE5pj
 pi0qtclKNYHEFtFvm+p3Glzo6zYCKaO4h2A9zb5VcCpYYsa3zrp/uar0q+yp/JJ6c++J
 GoF/rA6dmZ8kDQx2e+lLj3ZO+eQCTb8yj/8RRySjxr9ITs3K6mOkZGg7992qBLUjb+8r
 sMPkfumDuONdMa+uUd9SZIFHnaqzcX8lRRBJPHRmLthowVbVmT+h0CBYGsyCbOymb9Lg
 NZEv35MmABhL7OpXDHYzv5fMawFY2Um/4fsx6xy/F54E7m0JZwroXzxRUOcx/MF5T/Yh
 aLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702519334; x=1703124134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47gLWmgqtM70/xKoD8VYLDi3vUDxCLcXeMGxKrFGQjc=;
 b=DhsDACA4ieJrHg52nLAB2kzrrLKiqDsH5BrtEqI6XH/lHmi9y2uv0VjHDlpbM7MAXj
 IJ5xRTIeGNdBQk18ijrqahrlwuLNgwAEYyDZZ0eWjDVwtaEWMIhCZt7dMf94SDgxzq7W
 2rVRE9kiccOmP/dkOxw490Es6YFOzvUOT0IM2+u4y3HmZgr2UlB4u2yvamA9AVuEGaoI
 o9LgKpU5DktrMAa0RZT6jB4wfNJPi+zUD44eK56VUfJPb9NSwpW/TBtE1BDcIXbMnjcM
 qIyLGChcb/gYFuF9vFWPliK15XMsdo5imgDH+lVJ/FQ5KU/0kosrkxx83JwBzvsmikOY
 7q2Q==
X-Gm-Message-State: AOJu0YyXJxy/Zm/C5k3G687M4qCjALgyHtq+5FL1GJJ8kEJZMqQQClBY
 14Irg3N1XgCiuTwELj3+F/XMirUwm69rg0IoYNM=
X-Google-Smtp-Source: AGHT+IFdAf1Dg1GI6+j7DkI4fb9Qd7TQwe2t7eZtY1Yb0DDP2eIVGPLiHTw9krTIptWtVkfbogUf2YYQuLMklGRibqg=
X-Received: by 2002:a05:6a20:3d29:b0:18b:c9cf:4521 with SMTP id
 y41-20020a056a203d2900b0018bc9cf4521mr20719977pzi.2.1702519333818; Wed, 13
 Dec 2023 18:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20231211134617.457471-1-festevam@gmail.com>
In-Reply-To: <20231211134617.457471-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 23:02:02 -0300
Message-ID: <CAOMZO5CY6jOnz-wuccr8B5fSgt5E2AxDA+4cnOpEJrTVe+f-9A@mail.gmail.com>
Subject: Re: [PATCH] imx: imx-hab: Select SPL_DRIVERS_MISC in the SPL case
To: sbabic@denx.de
Cc: lpmeyer@ics.com, trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Dec 11, 2023 at 10:46=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Selecting CONFIG_IMX_HAB=3Dy on a SPL target, such as apalis_imx6_defconf=
ig,
> for example, leads to the following build error:
>
> /usr/bin/arm-linux-gnueabihf-ld.bfd: arch/arm/mach-imx/hab.o: in function=
 `imx_hab_is_enabled':
> arch/arm/mach-imx/hab.c:879: undefined reference to `fuse_read'
>
> fuse_read() comes from SPL_MXC_OCOTP, which depends on SPL_DRIVERS_MISC,
> since commit 251a3053b1e6 ("misc: imx: remove DM dependency for ocotp
> driver in SPL").
>
> Select SPL_DRIVERS_MISC in the SPL case to fix this build issue.
>
> Reported-by: Lisandro P=C3=A9rez Meyer <lpmeyer@ics.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
