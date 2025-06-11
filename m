Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2196C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 09:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F75C828A2;
	Wed, 11 Jun 2025 11:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIG5nS+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995CC82A4B; Wed, 11 Jun 2025 11:58:57 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2B480050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-32add56e9ddso52678971fa.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749635935; x=1750240735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cuctOQVMFL9e8poU/sq78JYPAUSHTOuKGWaDiL0rR5s=;
 b=MIG5nS+zM3T59GK6xvXaQFsvtJqEuZre1L3ZmOMzL7KHVEh6MWxGRZJC2a7hP68cN4
 h3BB0fRNF+JPg9rbnyaPjpNVVBG8jHXM/5caK/YoSYsf0DkPhGBnZWRuU5+PwNUyZmCe
 vIm8ZZm6PPS3HyXHWUzh3S65R4/COgl2jM9K2ZVpPKBfEv75mL98tEItD9Ih+d/LIvIo
 sEAKssQm3AaboV3mwe8u6EyFuetHh61xH/C2A3zH9D1xYto0p8ZbkPgvhoxEOBrJad85
 UQcz5OeURmGXfTIo1NFzag9pe6z8eWHhI6rhGRx6xSSSMOY4YSvClirvk7tQOfDvXnPu
 cS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749635935; x=1750240735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuctOQVMFL9e8poU/sq78JYPAUSHTOuKGWaDiL0rR5s=;
 b=QU1BbVsVsptF8UPEAN2Xq+8pLbRPree5QKnBJp8GNWPo3crutF7Y6v+TR/RTIUknWa
 lZvD2iltfbVQQAzM9e2g8sr83wuufioL++V7nNiqDwdJDD4X2BpLSNAnWGoYmI4gUsT2
 kxAA3C3+R5hBvlt6D5h80vZNgrAJa0QlHpQ1tddk+qyTfRTVZQGoJgRe4YrGsVmAfm4l
 NMkDxZD3TGpLomK8UY3pI4t/fSUaphFd+LSbZXkVQ+46BcItIoZumdFEbqoaTmCl3MPY
 vW+XuNn1fWUnPiKN8QL270r2umHVIGgPwGztKzCpbLO4MyHqb3/FS6120wbK1blyTOhj
 E82Q==
X-Gm-Message-State: AOJu0Yx/Ig7yt3DO8KC0pFH7/R+rDD51PVQUKH83NmfMW40TR/AR911K
 NckcyvLPYn2a0salyAwsypO/KhopdCgbIMbebDBKb+0/2fJBEw1+bQBcTMR9aZ+8y1GpHm7vA5q
 WHfiIpC1u+jC5Ozt4ujHztTBS3/gd7ss=
X-Gm-Gg: ASbGncsKvipkLh/TAjfh3NlDqqRKpE7jdQzcd0Hmqso5JM+12k37enyG+aSc4LXWxwT
 nTzcnVfvtdA1cO36YWsgmW3S/c2HNH3Ns7Wh1G4PvTBQeyCHqu9RhShhNMq6f5IIaIuklcQg9Ff
 iCT9v1gYZChtWtqgx6Nw/IFo+GYfIXmPUMHaUUPYbprPPa
X-Google-Smtp-Source: AGHT+IGkYVAAKkFivtNkHs5gHKsFpZEKUzrosjupgFn/iJhw4cBdq3zUccLhPTZZ1yBDApM9k9sIAmPR41pPxP609FU=
X-Received: by 2002:a05:651c:1992:b0:30b:ba06:b6f9 with SMTP id
 38308e7fff4ca-32b223d1f34mr7271361fa.26.1749635934433; Wed, 11 Jun 2025
 02:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250115020737.230558-1-trini@konsulko.com>
 <174434362339.24440.10543026192875667256.b4-ty@nxp.com>
In-Reply-To: <174434362339.24440.10543026192875667256.b4-ty@nxp.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Wed, 11 Jun 2025 11:58:42 +0200
X-Gm-Features: AX0GCFvI1Xxg-8F4lCTZKfSR3ph1ahGHbs7pXZs86Wyx2O6ypF2rqWUMUHQKBKs
Message-ID: <CAEyMn7Yg5xkanAV+wEiGPwb4X7XqCKpJiMaPB+sdwdmhxbdKXg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, mwalle@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Peng, Hi Tom,

I figured out that this commit introduces problems on the kontron sl28
board (kontron_sl28_defconfig). Since this commit accessing SD card does
not work anymore. I see that the freescale
has CONFIG_FSL_ESDHC_SUPPORT_ADMA2 support but now we need in
addition MMC_SDHCI_ADMA or  SPL_MMC_SDHCI_ADMA to get MMC_SDHCI_ADMA_64BIT.
Is this intentional?



Am Fr., 11. Apr. 2025 um 04:46 Uhr schrieb Peng Fan (OSS) <
peng.fan@oss.nxp.com>:

> From: Peng Fan <peng.fan@nxp.com>
>
>
> On Tue, 14 Jan 2025 20:07:36 -0600, Tom Rini wrote:
> > The option MMC_SDHCI_ADMA_FORCE_32BIT is only tested or used when
> > MMC_SDHCI_ADMA or SPL_MMC_SDHCI_ADMA is enabled. And for
> > MMC_SDHCI_ADMA_64BIT the same is true except we also require
> > MMC_SDHCI_ADMA_FORCE_32BIT to be disabled.
> >
> >
>
> Applied, thanks!
>
> [1/1] mmc: Kconfig: Correct dependencies SDHCI ADMA options
>       commit: 53bb8fdea12a346ceda1ac109ebb05d2c9625e5d
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>


BR,
Heiko
