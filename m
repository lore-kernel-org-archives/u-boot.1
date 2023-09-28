Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71416E732C2
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 11:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB8586568;
	Thu, 28 Sep 2023 13:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="CQqCi57D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F56F86538; Thu, 28 Sep 2023 13:08:23 +0200 (CEST)
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch
 [185.70.40.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4BA86568
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 13:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1695899299; x=1696158499;
 bh=jSDOgdU52fjwuwNmZN7XJFZsRYTVdapfUrqf2bS1K7o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CQqCi57DfgMYC5aqMqDSaohc3jT7NjlcHttnhGwaYlQeFu6NBKP3fwTMxCKw0V1Js
 1jz8Gd7sdsSalIfR4gogmhoV5uKiUeKJZCWzwFhpilVjBo7m+2kwgYj302GcRrZzc4
 ByIrrzNTxlYHgpJqgjvk9oLT8LetxHYKyYeSedOut2hV3shr9LfiMYMnJxfKcPCTH6
 lfPSiVkxrG30IDOaoUVdPg/L8LPwCGB7XmoEddm0oj6+ffInVRB8o2fVCkGKSOc80T
 +RNs1KZppwUMn4S6m3Hua6DJdNaRT7uGCYh3yJahvGgtya944sowWJyTPywjjGMCBG
 LU8Flf4beGGKQ==
Date: Thu, 28 Sep 2023 11:08:11 +0000
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building
 SPL
Message-ID: <CVUI3MZ0E9QQ.3RDSILF3MHWN8@flaptop>
In-Reply-To: <20230925215516.1528643-1-jonas@kwiboo.se>
References: <20230925215516.1528643-1-jonas@kwiboo.se>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Mon Sep 25, 2023 at 11:55 PM CEST, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meso=
n_mmc_probe':
>   drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_powe=
r'
>
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
>
> Also add depends on DM_GPIO to fix following link issue:
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pw=
rseq_set_power':
>   drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_na=
me'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined refere=
nce to `dm_gpio_set_value'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined refere=
nce to `dm_gpio_set_value'
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

This issue was discovered while working on SPL support for Amlogic
devices (not upstream yet), which is why the errors are related to
the `meson_gx_mmc.c` file. It doesn't seem to be an issue specific to
meson_gx_mmc though.

Cheers.

