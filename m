Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C9C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE6A83914;
	Thu, 24 Jul 2025 23:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHoQzrxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB50183919; Thu, 24 Jul 2025 23:19:06 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDA3835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553dceb342fso1169321e87.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391944; x=1753996744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLtSdgRsAxovys4/hpj35CJ3DCufjCBV+91u6PVcLXM=;
 b=AHoQzrxqsv4UJPjHaj844gvKQRqGxkNbMy9lQjZzQZJM7OARgj7lu+yu7yloyR2Inp
 ygLzLK5juzbKJnR1xQhb8oa+EPsXhprbbR1G64YyAresbOB0fsS5p6e4/EBpD67H0ZNX
 5oQCpsPdoNClfyt2OOnUEgZyT079tuzGbc0RdtZllj5LimeLchKqg/0fPDSAMNbJsrgn
 IbyMGzVBRy/TaMgTzI1YSDy3w7anRGaR3Jyfki65F6OEsei3cDjJEZwwR2OE/07kxvT6
 UM94QRuTiomQrwq39kz+OP4w4TOhbw1m/rXGyR9cD0MPGG1Ivwv9tnouvoZwCwcxLrF5
 O7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391944; x=1753996744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLtSdgRsAxovys4/hpj35CJ3DCufjCBV+91u6PVcLXM=;
 b=MxB511Tiq4WD2tmi8ALeglYK6h48QGAfhWuaAL/7n5jTWp0sX1wUv6jVXiIZ5My+3G
 DwDVoupcI2HZIhPSdknGQN5fniV/jP1ttpxDB2RTBWdlL06butKHCyzbUOxbg1hhqLPk
 9PwL6RJLgogMHhSJzruBvpO25OKP2fGpONsljJriFFcwILruzkPfvfjAcjFNowpdG0cI
 cyAx+pmkV6V1G+O9TNwf/lBANa9QgKqrzCOB/j9uw3D/n2XQhizf0Jkf8crIy/JUeQw4
 CPaQbiuw2tWI4P6YW3d0lz69Trq3CnUdUgyavcAaFvWwfA9tDMeO9xIOKA9YO8D35WLd
 93pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU04UV17pDFAaT++VV0+OtQj80ln3VwF6VeNEe1AYJRPkJEr7DdTT2jtJ1SJehKIlEj6aT+fGg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7SxP3vh+rMguP9ZY6eYqs1ULsJ6Js9J5nc5kmxNkx1qViAoWe
 1Z9VjME7AThvLC2GIMpHcWulcuG4XY/Lg+GRU2Fv49ZwZNK3OTpdHJEH1IFCRwF0dJ+hh8s+qyD
 /7hEHHqxherYuihI4k6GC2jYGf7Nc93M=
X-Gm-Gg: ASbGncsP5nXnqZ880GOdnnNQTvr90NDuYigqtc0B++KBh8rdpowntdmrpVwHx3qnM4/
 O6NB2hcoRsp/3O1Q3r0MGU0rPjKc2p1s9eFnAMQhOIt2a/otj4MuKO89sD+fZozf6BkpnOsc5YZ
 EeVFN5UWo5auXJ/eZ4w1T3yinS4LE9gMUen8JpoKDM6jvSCRjEQu5GsikdWYxJT6KX2Y0BbD7ZD
 rUOppaeRneGWj1w53m45iJN7SfU8ZEze+1r9fXw70d2ns0hmw==
X-Google-Smtp-Source: AGHT+IFo/ad4tJLLcZgIWWpUkx/uJLQ/M0cajeB1FDmo4xrQHUGP0H1L6bLR2/CmdQjPelSGUCdxbHYz+Iwaz+/o3CA=
X-Received: by 2002:a05:6512:1388:b0:55a:a74e:f945 with SMTP id
 2adb3069b0e04-55aa74efc4bmr2885933e87.14.1753391943697; Thu, 24 Jul 2025
 14:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250724024749.2165530-1-festevam@gmail.com>
 <20250724044610.GK18395@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250724044610.GK18395@nxa18884-linux.ap.freescale.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:18:52 -0300
X-Gm-Features: Ac12FXxVOZ96ajBzRW4QiFxRSbV3IxPfhK8nZzhc4s-K6QPse-UE7WjgO96XtmM
Message-ID: <CAOMZO5CZ-2Jk7m0360_WHb2tW-NLPT6Q6S=K_++UfT1Hsu_Rtg@mail.gmail.com>
Subject: Re: [PATCH v3] imx93_frdm: Add initial board support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de
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

On Thu, Jul 24, 2025 at 12:35=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> wr=
ote:
>
> On Wed, Jul 23, 2025 at 11:47:49PM -0300, Fabio Estevam wrote:
> >Add the initial board support for the NXP i.MX93 FRDM board:
> >
> >https://www.nxp.com/design/design-center/development-boards-and-designs/=
frdm-i-mx-93-development-board:FRDM-IMX93
> >
> >Based on the NXP U-Boot code.
> >
> >There were attempts to upstream the board devicetree, but it has not bee=
n
> >accepted upstream yet:
> >
> >https://lore.kernel.org/linux-arm-kernel/20250526-fpg-nxp-imx93-frdm-v2-=
2-e5ad0efaec33@pengutronix.de/
> >
> >Once it reaches upstream, we can switch to OF_UPSTREAM.
> >
> >Signed-off-by: Fabio Estevam <festevam@gmail.com>
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
