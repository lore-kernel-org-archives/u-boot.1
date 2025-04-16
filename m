Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93CC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CB482CA2;
	Wed, 16 Apr 2025 11:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="x2WIYPE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1C582D17; Wed, 16 Apr 2025 11:26:47 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BFB82C49
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 251631FAC0;
 Wed, 16 Apr 2025 11:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744795604;
 bh=+oyn42A4NICRagEY6lvBSwPDwtmcYlerUG8oVuPYxgk=; h=From:To:Subject;
 b=x2WIYPE/jVzp6WBkTqMbln4lWWe0rJTZ7rvUckjLmy6vJRKj1MCHI6wwUTaikxdgg
 Qo27miyhPf80AMC9d63vg16M7JIwHv7zSoegqS0SSvC0SDQGWFW2JvpVwesxqrgDoJ
 nBryR//ORIECKp7lHfbA86fNVjivPEVmg3aNOH3hQade9b+XTU9CXgIoqbTDp6zv6M
 qY+B6Z2jBSDe7ISgKyKutkCHlcVj/xDn6elj2HHqrMRjPRtSOor5tDhMzYRoA8OhIB
 FdzPmBUqVleV2wyhc4M8MLB5Uiy8qpK3Oy16DRbr+grXgw6SuNUlXv0ZVWnpeABeI+
 zg+id/98AHCxw==
Date: Wed, 16 Apr 2025 11:26:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
Message-ID: <20250416092639.GA24345@francesco-nb>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
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

On Tue, Apr 15, 2025 at 02:13:30PM -0300, Fabio Estevam wrote:
> On Tue, Apr 15, 2025 at 1:55 PM Marek Vasut <marex@denx.de> wrote:
> > Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kHz
> > oscillator clock in SPL DTs"") in place ? If so, try and revert it, does
> > it help ?
> 
> It seems I have not pushed the "Revert "arm64: dts: imx8mn: Include 32kHz
> oscillator clock in SPL DTs" fix. Sorry about that.
> 
> As Francesco is using imx8mp, then I guess we also need to do the same
> for imx8mp:
> 
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
> index 6de9ab5d37cf..35af412f01b0 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -37,11 +37,6 @@
>         /delete-property/ assigned-clock-rates;
>  };
> 
> -&osc_32k {
> -       bootph-pre-ram;
> -       bootph-all;
> -};
> -
>  &osc_24m {
>         bootph-pre-ram;
>         bootph-all;
> 
> Does this fix the boot problem?

My issue is not the boot. The issue is that USB is not working.

With this patch applied nothing changes, the issue is not solved.

Francesco

