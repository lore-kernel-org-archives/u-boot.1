Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07EBD3B7E0
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 20:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E4E839D7;
	Sat,  6 Dec 2025 21:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZmEuwSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8C083A3B; Sat,  6 Dec 2025 21:04:18 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C3683957
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 21:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-37d13ddaa6aso20619301fa.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765051456; x=1765656256; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEotqOIlOcfr04GRL7zpquY+e/yzghdX0+UDQNncJlg=;
 b=SZmEuwSr9O3ow+3wBKrrtLzOxGAQ0f6DfVpNFtENj0XxD/EIFVcUh76DRc+EusFuKX
 tTNPdaUA6hVH3NihPGSIZWY4dYamDnTsYy4DKzBFYUEWhvrrkVm/df1DoEWsekVpr4Oe
 j7CHbjtEwU2gK56nofLRBO/kY8yIJ7yBcG2lKKBbLCWZl+fuyn5sLgn1ZFjHcJ49mgye
 OXIMAR9S29fXygBMUi8koQWQQQMQ/B0DKS6I7xv0ZK0WoQaG1JCRHQ1lx1Rm0FjIslBy
 ROpTIiLI+lJgYOkhD6FtGKo5I++Uv9QbtV/HpYeHsXlboFIlZYj6W/yMC/MH60+HSACq
 VfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765051456; x=1765656256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEotqOIlOcfr04GRL7zpquY+e/yzghdX0+UDQNncJlg=;
 b=h6lNHaGwS46e6oNDciOUc+BfIzrwNs/fTtImHXPO48Tj87tXPPTI/F4gWNj12UXEMP
 dtYQ+Rg91oLZEmkCFeto840yGLHvp/bLToRPoSsWiPBCpqIwPpIfqGrzdEw1cGdgJTLj
 yIbl1IDyNwi8CfNG2fj1FoTWt4BKpPAKFpjk0uDl9OTHHCNeXMf2JenTrc/xteRTLsl1
 01u9/aqjoW70OI94o6t/c+IoVTSyAHEhbkBg4KSznVf2/01E5qwOrwt3B+vz1tPN0ZnS
 0xnTaqzY/8nnBrJcY7k1/wHvNE+5HSj1poJP9r++TCdoV/oTwZaWVBk9JebxTDk9prqa
 rl5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa2YgEfOgauQH4py4wKYRIGCNhuH5b+18w/UZ0Llit/0PsAaTd5hw8CIzL6owf7KeocN8GmAM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywodv7cfNMSDNtsSi7J68SLdWegDLPbQThbdQgeSxhkTPPjPb7R
 ylxq6qPgOKGoTHqX+cdhb38YMVBg736me7KEiK2kEJUVts73WsMf2DjJrAwVUQ+MDNy1AY844ed
 hfFjHI9nebpb3GmFSJn1nsTFvkROPQSo=
X-Gm-Gg: ASbGncs5xW0R4Sv/OpXi3DPtDvBKb0Tj0xOpTsb726N4CQMieC5p9OTxy1zxhWW9JUC
 Zm6xCUIhLs92Ick3H0J3EotVaRBkGeB+QV0YRxkFDwC0wldLHD4z3W4OemxlOBQdh0D/9XASChW
 yadIVYFT7GNDbUcTVttZGa9X7EXxVF9Kx6vdLhitEMjQi1vtUSulFChEm23YCt9Nat35CNtzrYQ
 SNymOvFnJ316hKzOf/nm0Eh3Y5wxZDE6umssoOEdqSHR9ee9xLiuOy/ih6m87Qdl3l5YXuLspPs
 YB6AbPZdMKNUiVSzBD3tFQqYd2I=
X-Google-Smtp-Source: AGHT+IFtJTnh1aNSGN3+wQR7+9R7wEnxMWhX4PUkM/FDdawui+gM6WNuNdSsySz+MwskM2dQE80J+YwBF0ZcGy98ydY=
X-Received: by 2002:a2e:b88f:0:b0:37b:a41b:58a1 with SMTP id
 38308e7fff4ca-37ed83bef13mr8008961fa.35.1765051455751; Sat, 06 Dec 2025
 12:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20251204164133.1677471-1-max.oss.09@gmail.com>
In-Reply-To: <20251204164133.1677471-1-max.oss.09@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Dec 2025 17:04:04 -0300
X-Gm-Features: AQt7F2r-C39XAWvjqjUEdct0-K1JY4EU7u7FtAUWWsivS5Jb85CF7seSiHwkSJo
Message-ID: <CAOMZO5BG-T-e-Gc_AP=nOnFPPXF3Ov7detWD5+0A1PiGH1wmiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: apalis-imx8/colibri-imx8x: use default for
 SYS_MALLOC_F_LEN
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
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

On Thu, Dec 4, 2025 at 1:49=E2=80=AFPM <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Drop setting an explicit value for SYS_MALLOC_F_LEN. This increases
> the available space to 0x10000.
>
> While U-Boot works with the current setting of 0x4000 increasing the
> size for cmalloc helps if further space is required, e.g. when
> enabling more DM managed devices.

Applied to u-boot-imx/next, thanks.
