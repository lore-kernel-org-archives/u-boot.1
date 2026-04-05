Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF061E64013
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AA083C14;
	Sun,  5 Apr 2026 13:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F2PZX3wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B978E83C5E; Sun,  5 Apr 2026 13:50:11 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850D18394E
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b936331786dso330029366b.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775389809; cv=none;
 d=google.com; s=arc-20240605;
 b=bT0CUSrCl3DsVYLOf98AdBxLFwR4GrsCDfzrwv6Av+ly/lmUGCMq1p38pFx8aw9eB+
 WH4hDbAZWo3ODEMyQ9fiMTUi6VyU34k0nJi4GWWKdvbvobsXtGl0njNTLN5y4q4zQKu4
 KF35LTXYSYB2xSHyDsvx+K53jpnp+jeoWyNhxXh7NfTpVnhj98qnx8vcuKHEFsb8LHyK
 QyMSIED+H3ugjaoJQpvp03XkGms04kWQGyb6iAHCc0UxJfI9k3n9xqjVk43nPi7lZjqM
 lV5oUtMnlQg4tKHKu8ufTdcofrITJwzYPI/nbfvJBgbzVgtNUDd27REorpLuU+VMZwNj
 ABuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IDEY00+i3JJRO+kad4dnp5tWHWcWzcZzL5RMGD6qr8M=;
 fh=FupddYeo0GvvCek3hd4jW7j0f5swrzsvCXAhY05xPqY=;
 b=YNa515TXnzoTYRSnbN/LFpHLlGNfN7POJDaCkG6wofZQgds8Jo8VQJAOPAZNIRTYhd
 4GWdWnZ+w1GOfScy4SqGqh3bP8GD4mDTzdde3ucfugBMBY7mnlxrAgJIfPFByMpSpNXQ
 prLSBKfQypn1BgyuFrj+3hvrzy1uB2MoCgK3aVfa8guYoPlKtGFFIoKTKNRTo9JZo18w
 T0AigMEZLo0zsOMwiXW+pl1NBzAfENbGpEcW2j3a7/bubgNWA2CrtHqGQ8oimkn39vhV
 7bX7JpvjBTpRjXYz9iO2X6yqJv2m4/dKtgiUAXcV2N7K86Y3cK1TSOb7L66Lqnrl9a+y
 CVlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775389809; x=1775994609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IDEY00+i3JJRO+kad4dnp5tWHWcWzcZzL5RMGD6qr8M=;
 b=F2PZX3wt5X7cdZhplhjF41Ng3G44R/XoAUpi6GT056w2v58j04t6DQ3rSnNz0MkY54
 KReei8nWpdfuC5ciGPfSg5MZZQQzyo2s1JelxTgGUjxQ+fzMCxXl4tY60lO6PxRbif24
 MDngBAR/LcBVpRKMHTH2rG620F8VuABOMbS1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775389809; x=1775994609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDEY00+i3JJRO+kad4dnp5tWHWcWzcZzL5RMGD6qr8M=;
 b=rfLtLBjun+ZilgKZEU9uP0ClvJhQ1tkXhow8Gg5hYCHda60E68ClUxNrRIy78uUaGr
 VRq3tJXsdrUKlJAenFgWRrL3bJNpZj8hHPh0bvHvM6JM0r8k0drx32+4t0BO2S6wNR12
 UVYwE1H2CCt9SH6L9J8MsfrMDInwsg3OvBIRe7CeOg5cyVyfbeboKsKqy25OwmLjSJ88
 600XA3hep6HrK+mvnGPCdguIXGlYe1gOv0DN9KB36uxYsT/dIuEfqJnb5pjuFEYqRuht
 JsgOsML/BmjQiNisvkmsRuAkk7RIRkEjsuv4ulwuOwI7RdS2DtymTW/rptRSuJ3iT4VH
 WOLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ZM1QKBE0WaW81XXKQZOF9Dpbx6P5PHZ+UmOX5CXd6d+6uwanllY2VTSC35GQTcQon5UYQIA=@lists.denx.de
X-Gm-Message-State: AOJu0YzNPJSyb4YFMrnQC6wyZWeEj5RgaSraL4x9Ov7A/ZQ9XUZVMNJZ
 1Xt07w+XNrjiSJwzWqFqDQpQy+MSleuoK6pFPlHNB32i5heFGm0F7Nn3xWmQE61hqnffbki2Wde
 DqvbxDQ25D0yeH3AhMaka4NIqrGUr5P7asPcqrN/i
X-Gm-Gg: AeBDieuYKQoHlIw4xjjEY1jthmf5Jaq1FuBDjOPdtlAFu9mcfYn6I3rtgAdqS3iTlCz
 N5LVkU63Bksz1y+QQ+jT3x/ROizzvGe8nCFTOT9KwqlsAYjVsnSaCc03KotnG8j/Mz5gmGUh+Vt
 cLjR03ewQN4+sCoPVdI+pV3F/sxI2u9jYujVX7VeCTFl8eEwzOLQ+2TavsPIjNNNs+XrLHWuSpR
 mvRYtkqXp2UqA1P4agVEsWLR3D+e8j1xmc+wKAUf6l3k0ae3qtkpTlsKaIMJ+SGAq69DdSLTNFp
 x1AxQQ==
X-Received: by 2002:a17:907:8b95:b0:b97:b2dc:91e2 with SMTP id
 a640c23a62f3a-b9c67428c5fmr457264066b.16.1775389808616; Sun, 05 Apr 2026
 04:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
In-Reply-To: <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 05:49:56 -0600
X-Gm-Features: AQROBzDq7w7Z5nKrfivdktDw_qk0K_ji8ZCrWMJV6K_zDXwCTiHFgMDHsektPy4
Message-ID: <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com, 
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, 
 ping.bai@nxp.com, marex@nabladev.com, sebastien.szymanski@armadeus.com, 
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com, 
 semen.protsenko@linaro.org, tharvey@gateworks.com, qijian.guo@nxp.com
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 2 Apr 2026 at 03:29, Simona Toaca (OSS)
<simona.toaca@oss.nxp.com> wrote:
>
> From: Simona Toaca <simona.toaca@nxp.com>
>
> DDR training data can be saved to NVM and be available
> to OEI at boot time, which will trigger QuickBoot flow.
>
> U-Boot only checks for data integrity (CRC32), while
> OEI is in charge of authentication when it tries to
> load the data from NVM.
>
> On iMX95 A0/A1, 'authentication' is done via another
> CRC32. On the other boards, authentication is done by
> using ELE to check the MAC stored in the ddrphy_qb_state
> structure.
>
> Supported platforms: iMX94, iMX95, iMX952 (using OEI)
> Supported storage types: eMMC, SD, SPI flash.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
>  arch/arm/include/asm/mach-imx/qb.h   |  15 ++
>  arch/arm/mach-imx/imx9/Makefile      |   6 +-
>  arch/arm/mach-imx/imx9/qb.c          | 379 +++++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
>  drivers/ddr/imx/imx9/Kconfig         |   7 +
>  6 files changed, 459 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/asm/mach-imx/qb.h
>  create mode 100644 arch/arm/mach-imx/imx9/qb.c

Note that this feature is present on x86 boards already.

I wonder if we could make this more generic? E.g. it could be a
function of UCLASS_RAM ? I could do the x86 part to try it out if you
like.

Regards,
Simon
