Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3880C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 09:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7578816D;
	Sat,  1 Jun 2024 11:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="USEi8DEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 106A688247; Sat,  1 Jun 2024 11:22:02 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CFE87FFB
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 11:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C7E8A1FDB1;
 Sat,  1 Jun 2024 11:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1717233719;
 bh=tFftIpXp2qqvjWCul6G9/l7YcicAXZ7XrdXuoyYsOzE=; h=From:To:Subject;
 b=USEi8DEWaSgMULsQwWrMEBRXAOAIZbPuz0MpQP88vol4JfW0Iyt2B9nT/4c4aAR4E
 qQu9FA7OQm/e/xOKB4g42sdjBPVxar/z55hnW6ZEMWpvJ2kQT2xG3HoT/nqmcM9KhI
 ZccTq1Sp1oeqbdcgL65/N7HsS4GemeumnFa7CXACLDV+hCKRXTfJk5SiHcBKeIREWY
 XCXAnvpDks29Sri301gTPFq6d0hbW15clmctkB5Mi1MvkbKjVh7e5agWw7zLp4eEy8
 flmUWQ90ylNtzsZeBAvdDMx7Kebo5wVHatOm+gbTdCc5FJseldu1ysuq0jWn0UrIu4
 kOuVwO2wueb1w==
Date: Sat, 1 Jun 2024 11:21:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] net: phy: Replace PHY_ANEG_TIMEOUT with Kconfig symbol
Message-ID: <20240601092154.GA4383@francesco-nb>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
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

Hello Marek,

On Fri, May 31, 2024 at 06:47:17PM +0200, Marek Vasut wrote:
> Switch PHY_ANEG_TIMEOUT to CONFIG_PHY_ANEG_TIMEOUT Kconfig symbol.
> This removes one more configuration headers option finalizes its
> Kconfig symbol conversion. No functional change expected.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
...

> diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
> index 0df3917e200..6fd43511ee4 100644
> --- a/include/configs/apalis_imx6.h
> +++ b/include/configs/apalis_imx6.h
> @@ -22,7 +22,6 @@
>  #define CFG_SYS_FSL_USDHC_NUM	3
>  
>  /* Network */
> -#define PHY_ANEG_TIMEOUT		15000 /* PHY needs longer aneg time */

You should remove also the line before, after removing the define it's
just a stale comment.

> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> index 9446acba792..f1921dac5e7 100644
> --- a/include/configs/ds414.h
> +++ b/include/configs/ds414.h
> @@ -55,6 +55,5 @@
>  
>  
>  /* increase autoneg timeout, my NIC sucks */
> -#define PHY_ANEG_TIMEOUT	16000

same here.

> diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
> index 27404c80fdf..950ec8b190d 100644
> --- a/include/configs/hmibsc.h
> +++ b/include/configs/hmibsc.h
> @@ -9,7 +9,6 @@
>  #define __CONFIGS_HMIBSC_H
>  
>  /* PHY needs a longer aneg time */
> -#define PHY_ANEG_TIMEOUT		8000

and here, and also in some of the following files.

Francesco

