Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F490C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC04808B6;
	Tue, 25 Mar 2025 13:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzvTpqxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3E580EEF; Tue, 25 Mar 2025 13:55:18 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D19F808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso5168443e87.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742907315; x=1743512115; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y42awx/wcSRJQ2bP/WQYpo7bEUFNCnyhwCCPxpt/jY=;
 b=TzvTpqxmQ73vV4OmlvsPwAM8poTHvHbuKZTCUYtPuD/NpfUu1S2XwDWIeXWnwVFLIF
 PTSt55L/1sN40KfwnySoUOvnABM9U2Mjg76eTO+c2JGrpbuQe5TsfXyp32CqioyJpXd7
 kNb0kfbkLXDNc68CL48xhBPiWN0C4IWUUWKCUtE5CX4AxX8Z51yFkifIbvQGDDSB2ubj
 UR3rN2QzimWIDaUU2YKyR3SFpuzc5EEAb+OsPlg4zPEYScb+dM4NyRzOkUh8SaTjpJeR
 kJdv1NLY7X6LGkbDTXn+hNlEs+90yAzjRhSQ2BznhqCp79/Uqlt7Lb0KqntT9qnxbq8a
 Jh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907315; x=1743512115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Y42awx/wcSRJQ2bP/WQYpo7bEUFNCnyhwCCPxpt/jY=;
 b=Siq0seZnw7t5/P3/mKlg8VloSHwXXonw50TSplMysJq8gglBTBv1q2X20BhJuQSaVQ
 pJ2I9HP5Lp2FFwefpi51Wf9CtNRXWmwQyGiLXbMOfopmuliEIVegYBEAZUa9dPYL9hLX
 zL1/lBeQrPsiodDH2flThDW34e9wP0U1prDd5LJwd7ZgJBdjts6DlIVANgQoszOBPeEY
 JyDiYFGtmhnG7aRXM89AFrHU8wBhMz6WW2WUaNzFUsperF4QGfObebB+ngiXetlaSRF2
 1nuVYc6GlAHuX4/PIBBAlH5pLEJXXLJ/TXl7ENyzOLcbNMmsGUaCdra7cI2ArmtPZr8P
 AynA==
X-Gm-Message-State: AOJu0YzoeOGQtH7RWUUNJL6ZZTx4637aWjEN8PEJsUD+Wbl7nfaSuiPV
 0KWfV5EB5jr8or94UUX2OsINs8V1E0A4LAK8BwBVTv6WtvjjZ8SZ9IxnqkZu3LF/p89hF7jQw17
 7RQUo3PQoxQWgTWBSfnfsqOvOi2Os+Q==
X-Gm-Gg: ASbGncu320sMgsrDyaxWNi4lFn/3zk2ztcQwk/mpfAzvgBC8oiydLk4CZUNLjZFmxAj
 A2ImmG/04F5H/funQqd/7JIXiIiFGFDFdZ89HXTDje4o64pR4a4+JTWbEm51sO3BoK1mZj/zQZe
 /ofx+MRRw5qKaOVpNT4+x3UHExbVZiSxL50o7YfEtfjs2MkkV1EmUMrh1q
X-Google-Smtp-Source: AGHT+IG5PmlLMQ9soYGcKX/f58U9MNxGWK0NWevkgyo+jmlBHK7HZskSlEBvRQ8xRil5UWDp96k+6tG2TSSLGRvSHug=
X-Received: by 2002:a05:6512:3e21:b0:549:903a:1bf with SMTP id
 2adb3069b0e04-54ad650363bmr6717229e87.48.1742907315114; Tue, 25 Mar 2025
 05:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 09:55:03 -0300
X-Gm-Features: AQ5f1JpgyfcGPs70_NprRJ18RJjlj4bdYdv3urK4i1w7_BatIx5E3dR5FtM6s5o
Message-ID: <CAOMZO5ChkkCbxOUZcUh6O_brmXHqvA4rHgjNR7vVxXmAbXO8iA@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com
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

On Sun, Mar 23, 2025 at 1:02=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add clk_resolve_parent_clk() to resolve parent clock udevice name
> based on clock-names DT property. This is used in SoC clock drivers
> to look up the clock name in clock tables, which matches a clock
> name in DT clock-names property, and convert it into udevice name
> which is used by U-Boot clock framework to look up parent clock in
> e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
> parent_name, &parent);
>
> Pass struct udevice pointer through the various iMX clock drivers.

Applied to u-boot-imx/next, thanks.
