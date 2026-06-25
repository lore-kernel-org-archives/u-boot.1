Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA02BCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B1A84A20;
	Thu, 25 Jun 2026 19:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZU4B3BtX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA1E84949; Thu, 25 Jun 2026 15:42:31 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB4E847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c07c246ad7bso354464166b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 06:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394947; cv=none;
 d=google.com; s=arc-20260327;
 b=U0KFA24Eh3xSaU6WKLt+ZI0ZkJZI27CUMYtiE3zmbiSE3BPVbYqZi7umT0CcRuho/f
 KSJ3q3ytna3RD7NMK2ZaRTd8OHvns6N9xtDYnY8emTSfhCiIr8yINvqjP6oWjzbcTUHY
 5LJSbRrIMczW0FuSNO15dnqYeI7Vi2sDcK70DhRxPmI2MNxYJpr70pj3KCgwUJ1mRRow
 kNkXamGCK4NdtT/ge/oXl75DNUz3VKUghu7wD6GLuzI1OQMuBYOnfBNF9F9nclBOfgaF
 ALd1h545pVKZbH5p4AHGqQrqlzTyIMejobQId4CuaUqH3E3wolBMPmAy0ojgLaLRz9Vt
 xmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rmnejHaq4H7frlKucsNaUHk/BfL/bxJ2tYdK3BOiZVM=;
 fh=oaA51ISSULoTw3UTKyEsVVNuznQsHbXJY+VGXyScUYs=;
 b=rvFLfJphR1oTBpCsNLNXOSIbIQ5DXs0i5ec1kWKH8sUYpbtlmpMVG4U+TtlGz9XHk+
 8qQtOR3NXn7NsX+9lnGaQR7abqylfosnMEe+QkQytZtBoLfaCEiXctEa4qru16u9yaFh
 ty17oaj+HJL0+IBiPz94ROoeOuXHqHrNufd8WEQnKJmPRD0wMPCYMAcu6gmUhqveGiqr
 hGac0FO26L6K1Nb76NeZQtagNcsXVauSIRIfCWhqgiToQYSWEzT6KBO1XDkwZuxtcQsp
 w0SZKnCleq5UHT3KuUczdztTvzPbZih23N1FGBxi2vXE6G2t2gIv4oQU2PCu0j6AwgWw
 o9mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782394947; x=1782999747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rmnejHaq4H7frlKucsNaUHk/BfL/bxJ2tYdK3BOiZVM=;
 b=ZU4B3BtX4dovygNVvya4KehoKZ/h/2xVm87zaaBk6jKT76qyNpL29/weafJ1TTIDNB
 6Gfrnt3/tGMoLCzRSiiutCWiPjrC+S7lgUvmIL7tbRgGMq6ie6KwCxbsS5aQ5vhEX3PT
 NK6NU3oBUHddq3zFMh7pZke7gK1l+G9ciZThs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394947; x=1782999747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmnejHaq4H7frlKucsNaUHk/BfL/bxJ2tYdK3BOiZVM=;
 b=JWNsDeDfdD13LEc7Qopg5ps9LG1QPp4VLT8wVJGFiZUYssXnanVjLTwzS8Ktj3pPIA
 2YfmzflGbHzLEQR8w+v/yajeUfbHzO3Up22fbXy0M8r00rIEp5dMz8jWC7hsaRdtSmE+
 aYPvcIha550FTY7Kr1VsXy2tGo6sP5io2EUY9pMuJ0xl0UxmEFAifFrST1fzwHogeqro
 H9nHhL97hV7Ejja3Db2bw0KC7lNa0VUsNfj85pysMI29CIC3DVTDBioJjTylFd2EBCJ9
 sgKAvE/BkrvzeVKrppyrEELg+JncPzsLkPN5ejBumBT5XI14B+sjJIL0vPr6rhfrxbKT
 3cVw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1YMJdzWRNDAk+jkUeu4a6PSC3vad2kjNpapZXM11/5OhXfday1aA+FHeeh0skCGwi7SFwnRY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw5SVXAfN3D3M1PKEyZFLpxSWrKUoCRlRnGRSXFDcMxxqiV8gy
 IZNf2/KVkZ6G7KtVJzWKJEJ1eRxNwnMJ0a1mMNUArka0NAQFg754V1UweLd4BGB+FyXl45qdPbI
 KyDJ/rWEqnBDCFooA796ajkaqodEZbY1816QdnmrE
X-Gm-Gg: AfdE7clm7d7bZ8VWUIbWUZbD+7p+biktbEM9jlquAEPHZ+nW5sF3BXx3VxTcjzQcDxH
 E4ozVLezBXagGTFpgv3hGfF8pLYebo5AmW3VNSPmnrCXkmoowWzZMAHmDQ2N4hpX2sE3jsThRLe
 FOo7bndKboWfGdx9kQsol7mLvGFBEzVUiU2w+l4WultILZ/+YjyoKS5dEI3BzXElPp228tfElrz
 3Bfz5LDl35AfS8pA8xhJv48BHXvOlRiEu/rkAL7h73RX9EMpkVRmf44gJEZ0GAhOZ8Rc5dZ80Xe
 INSXpxOw
X-Received: by 2002:a17:907:c448:b0:c05:8586:da12 with SMTP id
 a640c23a62f3a-c1206180d8emr187472366b.50.1782394947511; Thu, 25 Jun 2026
 06:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 14:42:14 +0100
X-Gm-Features: AVVi8Cc_IgNh3b_eiDMxpJcFo7vth8fa7pvz5fTOl3f8Tk5B3-14rn3HRJXkU_w
Message-ID: <CAFLszTiMJDrOhGcJtsr6JKQYu8NZTRWZF+3aQ0yO0CGMVZAfEA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
To: Anshul Dalal <anshuld@ti.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Dinesh <dinesh.maniyam@altera.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Marek Vasut <marex@denx.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nick Hu <nick.hu@sifive.com>, Jimmy Ho <jimmy.ho@sifive.com>, 
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Jonathan Stroud <jonathan.stroud@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Beiyan Yun <root@infi.wang>, Weijie Gao <weijie.gao@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:34 +0200
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

Hi Anshul,

On Thu, 25 Jun 2026 at 04:18, Anshul Dalal <anshuld@ti.com> wrote:
>
> U-Boot does not support modules, so having tristate options is useless.
>
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> CI: https://github.com/u-boot/u-boot/pull/998
> ---
>  board/st/common/Kconfig      | 2 +-
>  cmd/Kconfig                  | 4 ++--
>  drivers/cache/Kconfig        | 2 +-
>  drivers/clk/Kconfig          | 2 +-
>  drivers/firmware/Kconfig     | 2 +-
>  drivers/i2c/Kconfig          | 6 +++---
>  drivers/i2c/muxes/Kconfig    | 6 +++---
>  drivers/i3c/Kconfig          | 2 +-
>  drivers/i3c/master/Kconfig   | 2 +-
>  drivers/memory/Kconfig       | 2 +-
>  drivers/misc/Kconfig         | 2 +-
>  drivers/mmc/Kconfig          | 4 ++--
>  drivers/mtd/nand/Kconfig     | 2 +-
>  drivers/net/phy/Kconfig      | 4 ++--
>  drivers/spi/Kconfig          | 2 +-
>  drivers/ufs/Kconfig          | 2 +-
>  drivers/usb/cdns3/Kconfig    | 6 +++---
>  drivers/usb/musb-new/Kconfig | 2 +-
>  drivers/usb/tcpm/Kconfig     | 4 ++--
>  19 files changed, 29 insertions(+), 29 deletions(-)

I don't see this in patchwork but it looks like you sent it correctly.

Regards,
Simon
