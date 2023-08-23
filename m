Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C69FC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94298645D;
	Wed, 23 Aug 2023 22:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187C8864CE; Wed, 23 Aug 2023 22:39:14 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 4EAEC86432
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (ab.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id B847E74DF;
 Wed, 23 Aug 2023 22:39:10 +0200 (CEST)
Date: Wed, 23 Aug 2023 22:39:09 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/2] doc: board: starfive: Add more info about
 supported driver
Message-ID: <20230823203909.GB21828@m1>
References: <20230822143357.2818-1-wiagn233@outlook.com>
 <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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

On Tue, 2023-08-22 at 22:33, Shengyu Qu wrote:
> Since PLDA PCIE driver is added and VL805 support is enabled in
> defconfig for Starfive Visionfive 2, modify the document to keep
> consistent.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  doc/board/starfive/visionfive2.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 941899a0a4..460f23aec3 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -20,6 +20,8 @@ The support for following drivers are already enabled:
>  3. StarFive JH7110 reset Driver.
>  4. Cadence QSPI controller Driver.
>  5. MMC SPI Driver for MMC/SD support.
> +6. PLDA PCIE controller driver.
> +7. On-board VL805 PCIE-USB controller driver.
>  
>  Booting from MMC using U-Boot SPL
>  ---------------------------------
> -- 
> 2.42.0
> 
