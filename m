Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D50CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 11:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1602A88ABF;
	Mon,  7 Oct 2024 13:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqK2p12d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA65688B3F; Mon,  7 Oct 2024 13:48:31 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F89883D4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 13:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539908f238fso4692287e87.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728301709; x=1728906509; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKG+JIu4hWoVqCjBNu7HJ3Xnb22/39Rvf9KKtDhzszI=;
 b=MqK2p12djMslkrrGAqLj1VZ7MECHDd+k0vRw5Q+1g8Y9G3av2IUqLhcPZMijN1It47
 3VSe/R8CDXr87TifgO6STOOFMVN2p91VHpP9jq8WEkEfbrKJ2MbbpeGOcamiS6PkKiYI
 kFRjyz7L0e9BX1YCBOY0mWcXONM9gNxPjBVxGlKYKVGAB28lyW0gtleRlVi8g+o001NE
 I1XFPMzGjzYWYymEAZikaKnuFHU8li4NXP7EnWRHNaSwMgOdDy/f+j0AGPKaGFW62DIm
 n9tGC5RkJxsKYOyPW4voBrJ89jJqEimLXVya+FciuZQYSvvhlvUOlBx/D8JBIkt1RJwr
 uo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728301709; x=1728906509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKG+JIu4hWoVqCjBNu7HJ3Xnb22/39Rvf9KKtDhzszI=;
 b=DdINCazkkp/wjrO7jh1MwP56ph6v3/+HaB/N83U9v7c2AThRBjqywUOxvweb2IfHg1
 4Pwogde27vCnPMWZRgc6KCFnyGAfws5Wt43Y2Joj4TjzbBfUGAz1ysL84X9AWMkvMNzM
 ciOM52Hx2rZq8uVP8ufKEZhSNfqlbPARksyZQlsUXBE8cvNJn28f8LBGLvQdM2XumjK9
 Y2Mr4EaGcknSRH59gozxq51WGZiXewBOOrDlZGIaR11tv+mozoCsfN2ZtPBzkDSQT1hQ
 vvYObvqsfYgqEg18EaUZOWLQT/Pa1tLjr4z1kiRKpXtKEz473KWVfRncb6k4hTGWmqS8
 dEIw==
X-Gm-Message-State: AOJu0YxOplutvTp8n53gfr1CI+/L1c6lD+XoGH1EgI7I/BONIdY6/J6G
 dlT/Z5HQ19hC/jSv0Hvy3Oa10/SVyAWVw+E8VZzvtZojoKuMXPHBH5Htq/hyq3vp2yHG2Hv+hdf
 TOZBxLohxn0rTjdyOT0OtJWR3cB0=
X-Google-Smtp-Source: AGHT+IEKSNn9eaeXvqVPdAOABVLFoI03SuKpdAkA/kfa/oPI6xGWVt25ZaEuzj0/fPXmuA56TkqHRmxcODga+Aktumw=
X-Received: by 2002:a05:6512:b25:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-539ab878145mr5272601e87.14.1728301708795; Mon, 07 Oct 2024
 04:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
In-Reply-To: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Oct 2024 08:48:17 -0300
Message-ID: <CAOMZO5BkHsSJ3mPMQUuXnYaCkEQ9LgjY+PetS1xWqdeQBKiowg@mail.gmail.com>
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, sbabic@denx.de, uboot-imx@nxp.com, 
 trini@konsulko.com, marek.vasut+renesas@mailbox.org, peng.fan@nxp.com, 
 fedor.ross@ifm.com, ye.li@nxp.com, seanga2@gmail.com, 
 Alice Guo <alice.guo@nxp.com>
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

On Sat, Oct 5, 2024 at 8:32=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Make CONFIG_IMX8_ROMAPI could be configured in defconfig.

Please state a clear motivation for doing this and send a v2.
