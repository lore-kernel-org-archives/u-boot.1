Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98657C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 00:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5B987F78;
	Thu, 28 Mar 2024 01:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DrYk3Z3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AEC87F36; Thu, 28 Mar 2024 01:10:13 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720BE87F1C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29f66c9ffa5so82213a91.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711584609; x=1712189409; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8y+yoY2xi1CPU25980F2HQ8Aoa/GwbAfTNMwkgX527o=;
 b=DrYk3Z3fRnJL674u+f2oBxh2lbANxiSpB4gGHt0D0/MpNmRisKcL9so6k4NWNTW/c0
 PUBuWDzu2zoq02SvR5zRUIA0viqLxqK2IhXeQM+Pm1E5aJeOTIFPvhx+PUhbNHg73Pdq
 ofN0HQ2B9b2tyo+DKBDtjlEzLHBnRlVSlS1dtjwidw9B9pAPHjTpN2Yt8knUeN0coP30
 CTSGyStlfW4KLmarhkxdle6P6RNzyWjyepILJ96sZYp4YB81Y0BhkKMjyCPQ2vjMxReC
 7kpwz0amG0Ql2IuFhsAaIcm//kFO2cHNEMCOXObsJQv6KPAU0LaW7KFPF4ghAJU9fNAc
 D9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711584609; x=1712189409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8y+yoY2xi1CPU25980F2HQ8Aoa/GwbAfTNMwkgX527o=;
 b=iLfAjKlxWDb0+i8tJw/76u7M/0ylcM4k+6UTLuC8WpcwFM9CaKbjWlPLYDnB+sU6T7
 Dqaj7ksMnn2BM/4UC/Gki9PNhLu8Rm4RX68WYYyLTV5m5/VFRCESB/YfEOoQmRTA47uO
 JbVDDWEeGn3SfMY6B/GU23INiN7yf/btdPJl6i12dl9Ask/WavIC8kk7c16syauRkfEa
 W80v0Qg4ONjqlK4GvBzbYIkfKbZaAY35lpt97/fDUWFdwGLBMMZswWvd6ml508WN9bTQ
 +CVecJFaNOHlP+WpMyLdtYsVGemjGYWmvqZVdofiz83wx8H7C1ZQeVc++u+3ljH48bZ5
 zGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOvNVjW7i+CeZh3YRERd5qGdoEJbvLAd0ghN2wvPVqxy/U5uItS+KrRXCrJstrcViMSmIms6ITsJuAMlf1JcgO0eUiFw==
X-Gm-Message-State: AOJu0YyttuRqLIUpwWiEiuaIlpqX0yK87XcRZWLLE7XwzxewOv976vlA
 zwYQ7FU0uB5QMEtZ8Vf2qNTY3T2YSH/3BCtF1Krc+EAAgh024Vrq6AyFk5Jws0a7N0VsndhDif2
 Anje2eA74IkcHWEIzZRyGqMnYetY=
X-Google-Smtp-Source: AGHT+IGqjwdHkQRG7zMe0i52qgnEtWWls4YbkaQNBc4GEnArX2+K7ehHti7esnDR5k94tWeQSAdwFq35EDNJ2tfNmtw=
X-Received: by 2002:a17:90b:3892:b0:2a0:2605:69be with SMTP id
 mu18-20020a17090b389200b002a0260569bemr1182730pjb.2.1711584608986; Wed, 27
 Mar 2024 17:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-2-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-2-4e7f341ed7ea@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 21:09:58 -0300
Message-ID: <CAOMZO5CrT7hDGMrVsF7GKLbr5QP+akG0yXQbvXffcY=SePHECA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] serial: lpuart: use ipg clk for i.MX7ULP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Wed, Mar 27, 2024 at 8:53=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +       struct lpuart_serial_plat *plat =3D dev_get_plat(dev);
>         struct clk per_clk;

Please rename from "per_clk" to "clk".
