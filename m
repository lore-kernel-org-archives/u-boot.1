Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789B1C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 13:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69387F52;
	Fri, 17 May 2024 15:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="o1x8Sy8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7969E882AE; Fri, 17 May 2024 15:31:16 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7D687EF7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 15:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id A5F401FA5F;
 Fri, 17 May 2024 15:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1715952673;
 bh=A3R88Gklaveze6JP833qmZQOh1ImuVe0zFMil/00J+A=; h=From:To:Subject;
 b=o1x8Sy8z9/u29/QYFLgITpuC70ghIkaoskKMAK42CtdU7djwMm8LEM0upSQBODATd
 K0+uI+1JnA0mntAvMNJd9FIfMDoYmhBi122W/g2Y7ce4rVejApMlbU199TCTKXFspU
 bZlwICakOgm7ZtKtw1M6kUIWFw4XEisjyccMXtHl9zVBdpUu0bgxdZYdzvz0S1ritz
 poKS86whHz4q9dOyRW5THAzWjTufFHwu02eR2S+XSriAUKNYcpXi8Zon3ZfyUug0ax
 j6GtGV24WR1BOmWk3cCyk9uYeA3BzZGbvlVUV6FKqpu7IK8sKaj4yv1utJwyhgGR5w
 GafpDo2LZ24Uw==
Date: Fri, 17 May 2024 15:31:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 anton.gres@ifm.com, ch@denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
Subject: Re: [PATCH v3 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
Message-ID: <20240517133108.GA22869@francesco-nb>
References: <20240516213036.89016-1-marex@denx.de>
 <20240516213036.89016-4-marex@denx.de>
 <CAJ+vNU1Sb60gX4RoHwO=o2kf0c9bW85W2i1VwJg3Oa1hFmxADw@mail.gmail.com>
 <b5366e76-6642-457d-ade9-a0e68f181e99@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5366e76-6642-457d-ade9-a0e68f181e99@denx.de>
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

On Fri, May 17, 2024 at 03:25:38AM +0200, Marek Vasut wrote:
> On 5/16/24 11:40 PM, Tim Harvey wrote:
> 
> [...]
> 
> > > -The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf.sh
> > > -and can be used as follows to modify flash.bin to be signed
> > > -(adjust paths as needed):
> > > -```
> > > -export CST_DIR=/usr/src/cst-3.3.1/
> > > -export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> > > -export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> > > -export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
> > > -export PATH=$CST_DIR/linux64/bin:$PATH
> > 
> > Hi Marek,
> > 
> > I thought you were going to leave the above env setting examples in
> > the documentation.
> > 
> > I suggest showing how to specify using env (by just leaving the above
> > in) as well as by copying them directly to the build directory if
> > wanted.. otherwise the documentation is lacking.
> 
> If the tool can do env vars now, I would like to avoid copying key material
> around. So what about this:
> 
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> index 1eb1fb0aa61..257ffb45656 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -144,6 +144,8 @@ The signing is activated by wrapping SPL and fitImage
> sections into nxp-imx8mcst
>  etype, which is done automatically in
> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
>  in case CONFIG_IMX_HAB Kconfig symbol is enabled.
> 
> +Build of flash.bin target then produces a signed flash.bin automatically.
> +
>  The nxp-imx8mcst etype is configurable using either DT properties or
> environment
>  variables. The following DT properties and environment variables are
> supported.
>  Note that environment variables override DT properties.
> @@ -160,7 +162,15 @@ Note that environment variables override DT properties.
>  | nxp,img-crt        | IMG_KEY   | full path to the IMG Key
> IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> 
> +--------------------+-----------+------------------------------------------------------------------+
> 
> -Build of flash.bin target then produces a signed flash.bin automatically.
> +Environment variables can be set as follows to point the build process
> +to external key material:
> +```
> +export CST_DIR=/usr/src/cst-3.3.1/
> +export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> +export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> +export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
> +make flash.bin
> +```

FWIW, this addresses the concern I raised on the previous version, works
for me. Thanks Marek (and Tim).

Francesco

