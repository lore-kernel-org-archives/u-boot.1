Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FA9CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 13:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C5C848A1;
	Wed, 10 Jun 2026 15:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGfGPiIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0717848B0; Wed, 10 Jun 2026 15:36:43 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84748489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5aa61503fdaso6768548e87.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098601; cv=none;
 d=google.com; s=arc-20240605;
 b=f/vJAAAGKk2ChH0sOboT7BXVcA0nSuNs+WMgiBsERtLuhLZClt6Zp7VrA9ISyD6nF4
 tT7YS6R6lWSkPU5p0uwCiw8jxy0zUMvUKMNlyKUqvKBMriF2R0NVxwlttRm46vBH6zno
 zPD4favTfqcNOy7mckQ50s2XT7uf49/znatRgDaH5GwOnw3sHqkvJEX8iI/nI1dttfiq
 yJHmrkcr7ifZ3KaoPEaYoi2mG5yjBwTjVtdlaUOU3NUXEwe+qTIAlrX5vC6GbrFiYaPD
 itzVSZkDf57f/ClzPlEyXfPvDB+YXjj0Atc3Hz/qqFgzfEzj7uB7P6CsQLwt8gWgQTC1
 RjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GXnLk8IQink61wbV8cWzzX0ONHPCarEKznGceJfpawE=;
 fh=qWu9MYub6CQ9rsELn4rgay8bpAJM/7RpPJTeYz1LKuo=;
 b=T1ht26k6fmSvx/oFY78SmJEpbP17wLBkL/aZM/+FUbBGeLOoSZhdI/j9USHDupPKaT
 i87+Z6nkdlU4ZPXyd5vsOklhIhECCT4sP7FzynN+SHwrR2v0bVUS3SEGuWVPTMKBKo1e
 rKOFE0Uh02Mk6xR0XXfW7za1tX0O7cm4aV6FZveBU9cASS4BG1uSMKaM4ki12oBjhN5V
 ebbq9LvD+cqZ7IdA/bSz9BA/MbdyZAGIwO6qM0OyQs8qQiAB2se2de/nn0ypH7sZ0ohu
 m8O4vR5Yt8flzfa+JYB3Su8ltuV9CzHoEqLn/U+1qmahOQO+TchlFMUdGh4xNhfiQ5Hn
 DZuA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781098601; x=1781703401; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXnLk8IQink61wbV8cWzzX0ONHPCarEKznGceJfpawE=;
 b=BGfGPiIsEhQwRvaHNOWDBfTR87t3qmz4VPisAY4TNkCW1toTQwSt5+3IL5x2bIrIA/
 G80ykY3OfCVpbn4SihEe9sChuTpJ0NuWWR66KbjNcjz5x22F1LeHfJcWAgmpGT+Q+JyH
 lTVKJiEZkcuXqgfic/dA8RgdZKEmrIX+Kf1S4Lk3hViH4G5fnfJf6uOQj3PLvpl/S0rY
 pHExfDfqKOBbUmBozkNnte2b2fiic4OCDS4WuLPhHMI+LBehAIOoakvWaZkhxmM84+MM
 hPHrCN4VJsAgyf1TYJPaAKqdlnpDaM9ow7pas6fdIYtxjhVk0DiBkZ7lyoMUPd3wexAB
 5gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098601; x=1781703401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GXnLk8IQink61wbV8cWzzX0ONHPCarEKznGceJfpawE=;
 b=ebRz/vz5ZWedKnzDsxitQ3erbZnqez6En+3BaN9PlQJqJ0G1/7Bjaoa1cftGOy1SaV
 Zics6adCrPR8BFfE4Fkcw+pun31pRlBUOj8pjE36wt+6NdbzSc1DJeOtebBnh9UqgMs8
 1Uhr08SY3z5/jMgarifkfqj7K+QX9UW+minj+tj8zs7lcb6CMt1n5+fo5rjJ8gWKcGUz
 s8W8819UgzzQnvS2Kaa81cecG8N5w4JNeJP6OryhPk1UyKrYqq9S8b8kBgGOLEIoWtit
 x9FhSxCg6xDKxG8nuqlIrMVhz/CZi+78ZabWzeEkhv4gE1yjtgMIvU8KDIQenniErHSo
 rAuA==
X-Gm-Message-State: AOJu0Yxo82jmYDwJx2QoaIQKpNAHpGH0RTyQ22+LdVHIlU/yhQTsZpp5
 bu9pXBM0E2ycu38fzODGxnoW9TLl5Fc3xQGe3b860S4rIBFu9metuAZB5zfZDJ0FOKsGJw48fxI
 IIHet7cI7gafkfsm2G9rMyvlmAAN5qqwciw9B
X-Gm-Gg: Acq92OEZx5I3onVaku7J3bCjgxxyjTRsOZkP3Fh+h30wheAfm0QA7aXEqIkHrEAOknu
 //hkjrhLeK2/mVDxAugzzE81an6CIOUFpVACokAsXvHdlJJrbiE3WeCs7ZvtjMQzav2MkWgTtpR
 +2LFbs/Lx0jhdXyxiB0CuFomszYbCIin0hF6247kwZAuqAo2lxidaMkVsryQsS1nA+L4OsXPV1h
 o9/ep4DwifL3NC78SjItZ8A6YOwGqnnBo+xmukJSJIZA605XY18fUuFCh+Wl2qBtBPqw2jcvTB0
 NoCdnu/CogYDtYIbL5UDYlbKLEtgYqpiBMWGLMJ6AmRGPVwl5kg3kDQtOhZ28JSo9EgoijvnbAA
 6ZpYfeHk=
X-Received: by 2002:a05:6512:2210:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5aa8865b116mr6075197e87.2.1781098600485; Wed, 10 Jun 2026
 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
In-Reply-To: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jun 2026 10:36:28 -0300
X-Gm-Features: AVVi8CemgM96ic7XXIa_DgVoJUwK65G7Ps9eaJiSlr1BJVVRIiwT2xzXLxPlqj0
Message-ID: <CAOMZO5ByfxpwJp=VMpZV1K=nrTgd3znCVDnZUsMa3wsmquU_Vw@mail.gmail.com>
Subject: Re: [PATCH 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
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

On Wed, Jun 3, 2026 at 7:58=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> This patch adds SGMII interface mode support for the i.MX95 platform.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (3):
>       net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into =
helper function
>       net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 XPCS
>       net: fsl_enetc: Add SGMII support for i.MX95

This series causes a CI failure:

+drivers/net/fsl_enetc.c: In function 'enetc_init_sgmii':
+drivers/net/fsl_enetc.c:393:24: error: implicit declaration of
function 'imx95_xpcs_phy_sgmii_1g_config'
[-Wimplicit-function-declaration]
+ 393 | return imx95_xpcs_phy_sgmii_1g_config(dev);
+ | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+make[3]: *** [scripts/Makefile.build:272: drivers/net/fsl_enetc.o] Error 1
+make[2]: *** [scripts/Makefile.build:497: drivers/net] Error 2
+make[1]: *** [Makefile:2209: drivers] Error 2
+make: *** [Makefile:189: __sub-make] Error 2

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1475635

Please fix it and send the URL of a successful CI pass for v2.
