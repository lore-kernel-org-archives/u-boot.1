Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF2C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC26E838FD;
	Thu, 24 Jul 2025 23:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VvcqBtoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755FE83900; Thu, 24 Jul 2025 23:16:39 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F8E835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-32f144d0db8so9808021fa.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391796; x=1753996596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5/xwgis50JyrCJAQX42iJWVBKcgQdtykvkIRozbsDA=;
 b=VvcqBtoYOhcr4BgyBpnCNLx1tCre7nKGmbXMJapFiN47dmc5QOblEveGNQhkHLD7m8
 iGDhgx+twPJr5z4Ep+ll37Mfi0inGwzqvLpOFKI3A6cf+YA2R01R4PxW7Hft5Fca+6rm
 hHsDdYiyNOy6KqSGMyfjTLtsNKMhj3xEJqXHPgu/zTYxV7LZEmDEa7Ch7BF30eMLNY5L
 RXyh2K26f+WS+4LxZa+w1UEVzAJM4+2bwrMq7sF1lq6rvPo/+zBJExRfInu3jpLZA9A6
 zqNrpO9vgwLmIWN0ZUxseI+IoG4+UwjksG2oCA05RF7ql4fR+E2i6aJGV4VVZOY8jAta
 Lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391796; x=1753996596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5/xwgis50JyrCJAQX42iJWVBKcgQdtykvkIRozbsDA=;
 b=BfltvYR5Sen3jFANL99Cygxz9ZLTy1FEOifw6cHrtSq4VZ3WTdCzbjJiLLZfhY1nID
 2OLFl3oji9C4BYnf60lc7ujRWdPGMlTcnVMO5M1kzOHee2KMyXKQsdZdv2DKcPpqPd9q
 ojz5lPzdwHGodtPan/T6NSfPIlcxBtqQ7uorQqoRRN3DKi20Ix99u0W88MC6/2uWux6Z
 xuG9X6A1H53DG3Xt/Yami4Kh0Y/iTBydlWj3aq7uOg6C3UOKiuBH0uOsKELEEK9cR6bH
 /S6gXwP60/rcwAIBwNHE2ks1MMKsKcqyAmzmyxCCWVYl3ROhBZSN+nZnl19/dwivonvW
 3b/g==
X-Gm-Message-State: AOJu0YxFueU14DLC1iDS2za/Foz4NOIOfcqDBTwptnSi9zxyJQ11tGR7
 yI/gQW0LNskgkDKXQsWXotoPTBNGerqTloDMAM95wbNT+mfaKxMLGZFUmp2PU59L0NNWfXa/Ycm
 zT3AlfyvJbYWm1BBYH2frD0ImYLysSAE=
X-Gm-Gg: ASbGncsFjbl8mVhFpuv22EMu1wNKM7kYFXG3m6oODnOo9cxm1M099pVf7jeJ3m5qg/0
 3JEIhyrZbNdcO1WPdzNcVOzyVKfKhmJRYqC+T+idevPd4ZTEXTCeD2bDNY8rJxZKerPpMXaB+2S
 gyB0upYPGvJVT3hHYuMBTl5Jy0C6g4V7UOKriUHTU/BCyqbx79tz/7iJRRQPVycmYMg2XSi+oAW
 +DAVKhGax924T5m8BBDYQGjoTjbSfMdWqX48GU=
X-Google-Smtp-Source: AGHT+IEWlGpBtM/frkau5AASdlr4f9lvrcaWYcRuUwrFAYLg4yVwzISgeh05hIAZThbzYMqLzaM5iQcx08AHWSGsjls=
X-Received: by 2002:a05:651c:408f:b0:32b:c74e:268 with SMTP id
 38308e7fff4ca-331e25b5ademr6219041fa.17.1753391796292; Thu, 24 Jul 2025
 14:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250722103915.105561-1-frieder@fris.de>
In-Reply-To: <20250722103915.105561-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:16:25 -0300
X-Gm-Features: Ac12FXw9XKPBWKWTHGXjPQY9SYkDXE9GlSrGrwHkIJLetqw36HAsCpUdPRhIKPk
Message-ID: <CAOMZO5D+yT_JyipqOLaQX+a5mCq+dcs5ZJa7E=xpDh1FyEUgQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
To: Frieder Schrempf <frieder@fris.de>
Cc: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>, Greg Malysa <malysagreg@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

On Tue, Jul 22, 2025 at 7:40=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Switch to OF_UPSTREAM to make use of the upstream devicetree.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied the series, thanks.
