Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA17ED116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 14:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29BC83E61;
	Tue,  2 Dec 2025 15:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CE783DE9; Tue,  2 Dec 2025 03:29:42 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8816883DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 03:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 776421A2581;
 Tue,  2 Dec 2025 03:29:39 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A8C41A2571;
 Tue,  2 Dec 2025 03:29:39 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 232EE1800093;
 Tue,  2 Dec 2025 10:29:37 +0800 (+08)
Date: Tue, 2 Dec 2025 11:29:36 +0900
From: Joseph Guo <qijian.guo@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 qijian.guo@nxp.com
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 02 Dec 2025 15:06:33 +0100
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

On Mon, Dec 01, 2025 at 04:02:07PM -0300, Fabio Estevam wrote:
> On Thu, Nov 27, 2025 at 6:55 AM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
> > +config TARGET_IMX91_11X11_FRDM
> > +       bool "imx91_11x11_frdm"
> > +       select OF_BOARD_FIXUP
> > +       select IMX91
> > +       imply BOOTSTD_FULL
> > +       imply BOOTSTD_BOOTCOMMAND
> 
> What is the plan to convert this board to OF_UPSTREAM?
> 
> Has the DTS already been submitted upstream? Please include the lore
> link of the submission.
Sure, will add in next version.

> 
> > +config IMX91_FRDM_LPDDR4
> > +       bool "Using LPDDR4 Timing and PMIC voltage"
> > +       default y
> > +       select IMX9_LPDDR4X
> > +       help
> > +         Select the LPDDR4 timing and 1.1V VDDQ
> 
> There is no need for this IMX91_FRDM_LPDDR4 symbol. Please drop it.
> 
> It would make sense if there was a DDR4 version too.
> 

Noted
> > +F:     configs/imx91_11x11_frdm_defconfig
> > +F:     configs/imx91_11x11_frdm_inline_ecc_defconfig
> 
> Why do we need two defconfigs for this board?
> 
> What are the pros and cons of using one versus the other?
> 
> Can't we simply use a single one?
> 
> If you really need both, then please avoid duplication by adding
> including a common include to both.

ECC is to detect and correct errors in data of the ddr.
It is needed. I will add a common include to reduce duplicate code.

Regards,
Joseph
