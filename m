Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F4DCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 19:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B00D800D7;
	Sat, 23 Aug 2025 21:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOfxGgb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF17D82103; Sat, 23 Aug 2025 21:34:35 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06BF80077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 21:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-55ce508d4d6so2588948e87.0
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755977673; x=1756582473; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeoELlHq1T5mBn6HeF82w/jUkCr0L3B6hLCn49lB/QQ=;
 b=kOfxGgb2faSq7arlVXwcyXGYogjp81aV48w9XLSC0ZwiH1uDIAQgDn3nqV0iHuPH97
 MW/+FWYUQwXPS3vHU2I+/+qKXEFecHlUY5hJXXVIn/J51xi17iY9oG+5STPs4wIkKywn
 H7uCplyUi1XM0UClv59oFCbZUCgVJtS2YjFEdM/SuvkKqfDs1XHJ/X7505TNO6LmMUop
 FExJTfmMxwCv2/xwGlDOvKjFVij746doRWfuHyIAtuSrBUGunlgVZkaNZSt2OBNspBkU
 gDaSYaATvn+MT0fFk4XjBJP9FDXsCyMJuzgwV/LHrz3E6LeM4hXI7KVklZUurdTHVYux
 SWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755977673; x=1756582473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeoELlHq1T5mBn6HeF82w/jUkCr0L3B6hLCn49lB/QQ=;
 b=hH2o4zZY69gw42u2RVOBLE3FG9kiHeJGG7MQzEioGYHnMWTjY8435ouwd+i3VCFFl2
 ogCKGSauz+GccHcLahy1wu+zNocxJ6jYMA2r6OpwBRL7GedB4XNUaZ2L3x1cQk7NSI8v
 Bjq/kd3ntjBTk8JKcdBR/3xcX0/0RW7MiX3PNdvSHpWamv67ahLCd4oIvPD7hL7Aht0g
 1sFNIfIm9XNkcpVEvNUhTHJGzZavhxO6Uk+uiFfeNnBHH0YZ1MldkbhW6iCc9If4SLcC
 rMjJ5nfz+qM7JwAXO2AJTMTRysesJcNViFVmK5/toMt57aoVRNAe60llkdy7QNt5KD0z
 VbcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEjMZguUd17mi91ujJf0NpjVK87dYZbzYaqXyW2dwN8CdrwgX8qR1H0fiK8yO/doH90HeNpKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwoCLGIhYnsP9n4wjtsiGQrwSzKxhR1jtrnjhy4VW9XZl7JLx0z
 yOEV4JjXXA17hayD17IiLYs7KOuOvyVjBhkz/NGgZuU0ivZmWbYKVeD2fGy4WEYVUhVRJHdNLhP
 FycOnGNUHWYG8KVEmh65eV84W+zZ5dmKNPQ==
X-Gm-Gg: ASbGnct98vOEuq7FzwLuIvbEpLQzovPPCBlFh/OdOsw44Q9qqSS2QlRNwXYrtqRJCvw
 e0c4JfPNDeW/Ip+4hcEcNeGdtNqNXOyylyAUPYjdCaWYIqoHoQLFCWYBJfbgi8uQ07LuQEgE11i
 mgXyVBM6xnb3+mTVxnzz4eWTTzUpQYI4I66hOBT2HWKJpeURlrkewhdSZbFpH/H9ngGRnySsM1C
 3jAi4CQhYoZGS02O9yERuFsTwa4x+SOJUa5Ooo=
X-Google-Smtp-Source: AGHT+IFbijLvoSY3aw6RF4rFh9cZA7Z76ICnDy9ZuQ597o1xzh1DnVef4FoSgj9I8mhzRvB/k435kBWWeMBCZkWcPO0=
X-Received: by 2002:a05:6512:61cc:20b0:55f:3472:535 with SMTP id
 2adb3069b0e04-55f347207e6mr756011e87.39.1755977672733; Sat, 23 Aug 2025
 12:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250820130851.1374226-1-jeremie.dautheribes@bootlin.com>
In-Reply-To: <20250820130851.1374226-1-jeremie.dautheribes@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 16:34:20 -0300
X-Gm-Features: Ac12FXy1k_cvpYgdqz2jcpAVvjQ4YL_I1i1HMN7ycd42MI-EsYt3BIEtK-jlDRQ
Message-ID: <CAOMZO5DRxmhs5TVSMFMj-wZhwrVbiuu3zyv7nnOKKubEkEEAuA@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx93_{evk,frdm,qsb}: Fix conflict SPL early
 malloc address
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
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

On Wed, Aug 20, 2025 at 10:09=E2=80=AFAM J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> Because the early malloc pool size is set to 0x18000, so using this
> start address may cause conflict with ATF, then corrupt the heap data.
> So we delete the definition to use the default early malloc pool from
> CONFIG_SPL_STACK to avoid any conflict
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
>
> Cherry picked from nxp-imx/uboot-imx commit
> 1ba675df122627a19debe1d807877052705372c6
>
> J=C3=A9r=C3=A9mie Dautheribes: applied the same patch to the frdm and qsb
> imx93-based boards
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes <jeremie.dautheribes@bootlin=
.com>
> ---
>
> Changes in v2:
>         - applied the patch to the frdm and qsb imx93-based boards which
>         can face the same issue as suggested by Fabio

Applied, thanks.
