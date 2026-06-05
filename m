Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6642CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81790848BF;
	Fri,  5 Jun 2026 02:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rJK3QZZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6C5849D8; Fri,  5 Jun 2026 02:13:13 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C049084874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aa2c25c632so1314606e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780618391; cv=none;
 d=google.com; s=arc-20240605;
 b=Z0BA9EJret6YP0hyF80bq7fB8uiSfDbx8cq7EuEMQspMbiuROr9vJpRGctQUW7mwps
 D+Z8nfkW7kmtDR1P7D3b0osP19dMrYl2uJ2wazsXEOWBmwdWipGGF23ajWns3qXNOyvw
 9zgg0u5SyF2W5n7ro6IunkpOegrp0Q1D0GEX6KoJ8ccjWPnABzm3HT5WSX2ublofrIrQ
 sRVBc5HFBgzuvWKZMhEMa88niK2MONitAO+LPC/wrl+efMnmtW9dRfrKP2TBWO9j49bd
 73HVNEv5Xl5k88XUfE1lRm+DPtyafV3h6/AxL/X8YZLM1k7RDd4AI/rn7hZhaX1E3sRf
 8b/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZL3yUgE6iyZqe24aWCwWeKn2uNBD/ABRyi7OPbnEvXg=;
 fh=NDeKNAA7t94GNOTT0+pSaWp2DtrvW7eg3LLv6bgf0W4=;
 b=Iaj+TWcERSM6Ih/Q6+wsVav6vXbcGPdosjgEJO+IE+ep/QpfF39dbbQ/nV9K4SeZzW
 zxyAJVrpfwdF6j3Tqx9/Vs3oUKbnRxlQLEnb/wz5ahLBCrL+0eb9yX6q1Lh3y3V6IXpA
 N6NSnCxGLzWx0e00beqDqojPYUys5zHNf7Rtg0slfnAyy9HSgyefJ9DXMOiFFnajYW4m
 3EzXHe5o+bwHyCRrXeM8PnCJcYXhFAA7UxW8KJhc3svpCb4IWjxIsxoSUOijFVGIckLZ
 qOdzRCCHHWOYDRGxd5zwDuC7OFk68U0qGCZ5VXvwnFVu02GRL//EN0ZjBoNlTCdFaKam
 y8PQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618391; x=1781223191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL3yUgE6iyZqe24aWCwWeKn2uNBD/ABRyi7OPbnEvXg=;
 b=rJK3QZZNklp6WS7wfO+G08WRklh0NZFEptWwY57ZT63eB/fDEMh/Gd/MvGhvmpDuWN
 RtdrsCEP556nIb+mTHY6DEubaEOjuPssnvXhS/ccV9NKpvfi7gagmAZ7SUyJWTTsjqrv
 mdTRz6ZpObp8/f/3iNofD8/Lobo+LJjCLwbURI/xr8DvX+XJhRtVFCuOllJkBaycKYws
 Nhpx0dOPe0ZVrr92Cj9mF6RzTi5F9Y/0m6vB9KGHjM74fEswrQgV6dCZafIWf9ToqusY
 7gQ2/utU0Yrd8Gv5T6aXfaeRTk7IlU6hLhrOcxEdEV9NrycyDExyMZrxo2irDHPVU2D5
 jAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618391; x=1781223191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZL3yUgE6iyZqe24aWCwWeKn2uNBD/ABRyi7OPbnEvXg=;
 b=PtQkfxGX7SuUwHDu3SoIEVkU6lzsXgMEu7Gt+O66OBFRWlJrN9wru+EaFh6fOiRERg
 iF8pr5nOgINPLvqzzHna5ydJm/O9bJuGLkdaOvflOXJPvO3hiS7/ycVVX6NBfRxwjY5a
 0jQoFskvF+iRfqz00RxMrtGrpi8ECs6iIEbRaZITy1FrwfifgUNfCUFjUbplKTHmwvrQ
 WSYb5wdsiWp6QHygI3JVe6xRtKQtvdRvF/lnqb9e6AJXcTQjHESmaqY0V6cLrbD8zA/T
 K0S9D9i+mQ7+BMRdzL8/zYUf5w3/yIdMAjRiDMKLRXR10j4OIqonH4Cb8PbWK69bTbtS
 TDfQ==
X-Gm-Message-State: AOJu0Ywkd5rMeuUBItzb14+b0VklMBpMBoipAEZzw3ShnCpUkzkI3j3O
 4CpD5DzZnP1EW8vFwYz8HpGBFgyGBEjk2C6hxyc7S9Fawm6fJzJp+JPA7mcVBDEuBYOTilaGKvh
 BnFqjuKE7fzFiJCZioh3pwD2Aj6WQHYM=
X-Gm-Gg: Acq92OEN9rBvqOWiZo0p/nJKzbc9rMK/vhc1rj3MhmnQfRKt0HhuwjYjHyBV6ghJIMS
 XSisK8oi4OLCnTqYNQTVUHzILYNEzAbB9/vNg9itXZuqkQNZQFUWI3GWxnQ7FFmDfJsd7nwK6Ti
 RkcMAuHvpxw91Z+OCMBoYS/R0KnSQ+vFjy/Dy54S3YBhq6OzojxeczwcSYrJOjUI8rjV4ZNZBDJ
 1QT6/h4M6hzgf+BgVGjC04MFtY4GGV1dIKosKslpi87LsTI1jlF0vdasvCmFdjoh3HhvODQ74Er
 0SK6B6xo4YB9tH2hg9XyYN5Skakm6rncQswidhHQcRxTKz7blb9X+PH1Lp+6mMTpia1uUj70O3C
 fbdaWQA==
X-Received: by 2002:a05:6512:234d:b0:5a8:8df1:61bf with SMTP id
 2adb3069b0e04-5aa87be895fmr253119e87.21.1780618390955; Thu, 04 Jun 2026
 17:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260603223245.137065-1-marex@nabladev.com>
In-Reply-To: <20260603223245.137065-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 21:12:59 -0300
X-Gm-Features: AVHnY4LgPMnuiiybrMbIn3Lx9hyR3SWGidhsVDjSxqZjSuDQ4MtIvwqAsXFHpDM
Message-ID: <CAOMZO5AajRJ31MLvYM_n-Xe2eoYAYx=kkusox77Chqcuj-yVjA@mail.gmail.com>
Subject: Re: [PATCH] tools: imx8image: Fix FSPI alignment to 4 kiB
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Fedor Ross <fedor.ross@ifm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Simona Toaca <simona.toaca@nxp.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Jun 3, 2026 at 7:32=E2=80=AFPM Marek Vasut <marex@nabladev.com> wro=
te:
>
> The SPI NOR minimum subsector size is 4 kiB, update the alignment.
> THis is particularly important in case of embedded DUMMY_DDR, which
> must be at at least 4 kiB aligned offset.
>
> Fixes: a2b96ece5be1 ("tools: add i.MX8/8X image support")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied to u-boot-imx/master, thanks.
