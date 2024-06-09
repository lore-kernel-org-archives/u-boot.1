Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563DAC27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 22:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB5587ECD;
	Mon, 10 Jun 2024 00:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pgq4bVkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40198883DA; Mon, 10 Jun 2024 00:33:15 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A83587C7F
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 00:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dfb0538e227so2012667276.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717972392; x=1718577192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZCcnZAe7mU32UsJVtYZ2mYOo+jLdAwabA0yB2V2t1c=;
 b=Pgq4bVkDv1HML283FY33D/5YbCf50KDKHOn2WivpbYUlFm0btC35enoWU7NXFBgVqj
 5TkTb3hGujxgrJWvs9D6iVyY42tgmW5Per0l9Mwdskb01tIFNEPO1ZRyP3eSxXs0aC9h
 oc1si6SVvUCdoTiP0qSALU+9xxZkW268CWsglSwo2x0LHSd7qD0wZ69idAUiL8c3FZhE
 LmT4VzgQs0xWtPeKB1iomKZ7ZOpy8AZMFUgFKL+qOzyLcQo+X7k58ro4HE5S/3lhvHgv
 bMoegqmsdD3Bcd6dmvq8xZtlHz+FsSPJAd/sMc+L4QqAQLITy9vKbmYoLgDEk/HEYQIP
 rwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717972392; x=1718577192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZCcnZAe7mU32UsJVtYZ2mYOo+jLdAwabA0yB2V2t1c=;
 b=kPYilz2U+CjKBcC9iDFDBuLVdIHK2p9r458KZb4SZunHz4L78hSXNwSHXIPewGByjj
 K3zEQ+kTDLbo5y+QGb5wmRMRKwhrWVdmt26jEsDSm+8LI7QwKHEOdvaegsO7E4sANeMF
 MXQHtXJvDvrXUUpHraG+vO/Y3vCsx15VU/0sNSXDHu4pdO1bJwl/V2VNCbVWAlLcdDdA
 qCFACStmWhaLiy3KifVIFTVxxFEacsyzqlmvAFBhcW319nxzZYC2JjvQQxBrfN1ay0Y7
 DXHCezhJiShyE7e5+/9AQBsoMNjP+ATs1bCg1mb27EKd7i69wguKA+jECgyU0jYjUXcN
 +4FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1hSH4SQqRuoQOgpuzFxJI2RHxQzN8fvIdzJjiDkzNjE17RpN5e8CcVVBEP1MRc2i2nPhd0xByRtHqQbwxgXNTN7pCoQ==
X-Gm-Message-State: AOJu0Yw9wcTpGoi47pytOGqkxFqMNc6m4+8RNLi0JTWfUU4D1y7CZGtv
 W7KvTnQ11k8v/82KAZTWRfO4YvGLENuWE049zK1gCfPBBX7Ha9SOvW3F8g5JCT078E/cwayvi8F
 jGH1E2nFRBi5J+c61bvtkDa0FRdHnlJokvW2wjg==
X-Google-Smtp-Source: AGHT+IF56abWQNuPPRmjOtNPbL3gOjc7CY5BkBlNOyxW5YqhJqJPmesE5kjZldX5XtYoOrPlK3L8rjlWOMh42JMYF3A=
X-Received: by 2002:a25:ae94:0:b0:df7:a75c:28e1 with SMTP id
 3f1490d57ef6-dfaf64b7d3emr7206203276.22.1717972391730; Sun, 09 Jun 2024
 15:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-15-semen.protsenko@linaro.org>
 <b06b361f-8587-471c-915b-60e030320ad0@cherry.de>
In-Reply-To: <b06b361f-8587-471c-915b-60e030320ad0@cherry.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 9 Jun 2024 17:33:00 -0500
Message-ID: <CAPLW+4kqdiQzLLMDFLRvSGx_bQFZ3n9bRJiuo7BJDHfVj6NDGA@mail.gmail.com>
Subject: Re: [PATCH 14/42] mmc: dw_mmc: Use CONFIG_IS_ENABLED() to check
 config options
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Thu, May 23, 2024 at 10:03=E2=80=AFAM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
>
> Hi Sam,
>
> On 5/23/24 1:31 AM, Sam Protsenko wrote:
> > Use CONFIG_IS_ENABLED() macro to check config options as recommended by
> > checkpatch, instead of checking those with just #ifdef CONFIG_...
> >
> > No functional change.
> >
>
> There are actual functional changes in here.
>
> defined(CONFIG_DM_MMC) !=3D CONFIG_IS_ENABLED(DM_MMC)
>
> Currently, if one has SPL_MMC and MMC_DW_ROCKCHIP defined, it'll build
> the SPL variant of MMC_DW_ROCKCHIP but guarding only with the U-Boot
> proper symbols, meaning, essentially the SPL and proper variant of
> rockchip_dw_mmc.o are more or less identical.
>
> I think we can argue this isn't proper and should be fixed. I think we
> need to migrate all the MMC_DW drivers to use $(SPL_TPL_) in there and
> create the symbols in Kconfig with the appropriate dependencies. We'll
> likely also need to modify a bunch of defconfigs or make
> SPL_MMC_DW_ROCKCHIP default y if MMC_DW_ROCKCHIP for example, so that we
> don't break current support (it's pretty much expected to have MMC
> support in SPL).
>
> I may have misinterpreted this, so please let me know where I am wrong
> in my assumptions here, but this does look like more work than just this.
>

Thanks for noticing this! I completely forgot about SPL as it's not
built for my board. I tried to check with buildman and it seems like
replacing #ifdefs with CONFIG_IS_ENABLED() doesn't change anything,
but I'm not sure if buildman actually checks SPL at all (it probably
only checks the U-Boot proper binary?).

In my v2 I'll stick to #ifdef and avoid using CONFIG_IS_ENABLED(). As
you said, correct rework probably takes much more than just replacing
#ifdefs. It can be done later in a separate series.

> Cheers,
> Quentin
