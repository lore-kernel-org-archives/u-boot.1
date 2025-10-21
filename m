Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDFFCCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 14:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9381B80107;
	Tue, 21 Oct 2025 16:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYjb7zB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E0980107; Tue, 21 Oct 2025 16:24:27 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43229800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 16:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-58b025fce96so4796321e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761056664; x=1761661464; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1PeQ2liYoTP/qXDS6B/xd6WmHOhdU+oESiZxg4rAFs=;
 b=HYjb7zB+iBREf5nwwIahjZV18ZcUlxvgxjWBtZYb5PJCOyeLmkl80FoKbB4xTmaSMw
 AMn66WicpC2mFUtrqeM7tbCbswFfzY7AuO0wsjyQ4nTIikIbl5thPSA7YO/jysePIQoY
 GX6xIopGz/np3uFaNMwU0baQPgfsKal5rXY+75HFsy4KTMkJWaBksHkcxVKjGVfMfd8A
 eeTFS2cTVEk7blgZhuetoEvYeb4ma3nRGs4jYLWvz6MxSxLFZ8dIGIDdj2yrYD+Ce1zL
 1JErFrFUti5P8d7EPzEMr3CLnqTjXK0DV6OVQqgiSP0aFeU7z3KrULCOvUyodu0/aRHn
 OwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056664; x=1761661464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1PeQ2liYoTP/qXDS6B/xd6WmHOhdU+oESiZxg4rAFs=;
 b=kj3SHP1vmqwFAIqZuqLmHYl2uQJWxjCl6oUInsT0Ez/yg4TkzdTrf644SPO9pen8vw
 4x6YkahYJrna5B344OmKMyvj1NsLzZzAmbOcehIDOAtXrQMdB9tJKveVkO9SA5yBGaQZ
 HHlYplMXh+Oi9ICbhPwXOhms5Ohw7VSWa84veY9OJZkNO8uuCPWHMSH4ECJ2AIZWUGaE
 zodoYwDtqLzqW02ilAS0soQk88zdh9C2ZcW910bfJ8JUfcmeIqd2zUBmcvprXM56W8xn
 hW2iwn37/8f2WOUc6n6CP2BrFDl91PN1cBURwGzLx8Pt8Tc6trGD4z7RrXVC1XXfuyHj
 fdQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYX3hfazhohiE7MpIAJ89wajYLZjmuyhhgCkQrGefauSB8rXNV4I8tV2L5dVnPM8nW/pvSROw=@lists.denx.de
X-Gm-Message-State: AOJu0YwGcSwZFV8xHWpjhvBjtOk4j+TYIPQUy6ONdNWtPYz7koyJh3LU
 qVjlN3k5zhQ5sy7WpP9dTWk3nArCcpvmm4cnb2fyDVw8ftsvYfQoyg5Ztvs9Uv4k7dCacXTodlx
 6cSFwKo08nyFq87EMsJ6IDaUSXDmpheA=
X-Gm-Gg: ASbGncs23jFCas/wF56YDEs+LEPL/LSnXtugYCgBtndFcZ4cMVPO8Kq3Is1ySPdLPcE
 +ZJA9aUldmAkg3vW5x7mJz5o+MKn0assTus24sz9mo9mS9H35B9k2rC3t61ESEHa0VQDyBrr7CM
 QqMi0L4JxP6pTEIW+eSuA5qIG6EJZ1/g8NLJEvI50duZsHa59BaHHXnPwTESvNFKWQ3BeenN+Li
 6h/58zZhf4pqW2FAtwGxrSKYnZCIQeBpkowyybiQxijE6bjktpFhndZQfWRq7Fu8AOyKJR9J3iQ
 ozP3uNU2rCr97Hc=
X-Google-Smtp-Source: AGHT+IHv2wBi3PQ7689qU1N5LQIy/7z/zlsDtbh0QZ1D7tD4JiMFb1yZDG5csek6RllvsTpXNUK6FOw/xCys7StRTP4=
X-Received: by 2002:a05:6512:3b13:b0:57e:4703:3b0a with SMTP id
 2adb3069b0e04-591d8552c2cmr6124797e87.31.1761056664198; Tue, 21 Oct 2025
 07:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
 <20251014111756.446456-2-alice.guo@oss.nxp.com>
 <88093ae4-a18f-434b-b0a3-a362133871cc@mailbox.org>
 <PAXPR04MB9644DA5017638F3B0716710FE2F5A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644DA5017638F3B0716710FE2F5A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Oct 2025 11:24:12 -0300
X-Gm-Features: AS18NWBO8t60_ajh8PyeJz4fthIWotqn9wRgafFdElAPvTsT-13oEW5NaTET-bw
Message-ID: <CAOMZO5AEjeEDaXt4NphbViWoc8v9kLHes_gcnFTT6SbMj5VXpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>, 
 "sbabic@nabladev.com" <sbabic@nabladev.com>, 
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>
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

Hi Alice,

On Mon, Oct 20, 2025 at 4:10=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> As far as I know, the i.MX943 operates in little-endian mode, and the BE =
mode is not used. Do you think it is necessary to remove the big-endian rel=
ated code?

Yes, please keep it simple.

Please resend this series with a link to the upstream submission.

Let's get it reviewed by the mtd-linux folks first.

Thanks
