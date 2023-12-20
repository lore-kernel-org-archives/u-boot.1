Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D93C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ACE9876A8;
	Wed, 20 Dec 2023 12:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29AA8871C3; Wed, 20 Dec 2023 12:45:05 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A163876B1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id F04AF20144;
 Wed, 20 Dec 2023 12:45:00 +0100 (CET)
Date: Wed, 20 Dec 2023 12:44:56 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
 u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
Message-ID: <ZYLTuGyzppSLh81A@francesco-nb.int.toradex.com>
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
 <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
 <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
 <ZYLQX+WzAlITahTH@francesco-nb.int.toradex.com>
 <CAOMZO5AxX+RTBwpZ+DE-rT5gtYB=pv-tWesMx3NGcheiCL5ReQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AxX+RTBwpZ+DE-rT5gtYB=pv-tWesMx3NGcheiCL5ReQ@mail.gmail.com>
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

On Wed, Dec 20, 2023 at 08:39:38AM -0300, Fabio Estevam wrote:
> Hi Francesco,
> 
> On Wed, Dec 20, 2023 at 8:30 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > Valid point.
> >
> > In general re-using the DTS for the kernel would not work.
> >
> > The bypass and reset signals are part of the USB HUB node [1], and we
> > would need to add such a driver to U-Boot to be able to properly
> > implement it (despite the recent plans to make SPL a full blown
> > bootloader and U-Boot proper the operating system and kick out Linux I
> > would not go into that direction ;-)
> >
> > Given that I believe that overriding the Linux DTS to use these 2
> > signals are simple GPIO HOG for U-Boot is the correct approach.
> 
> Yes, this series can go as-is.
> 
> My main concern is why U-Boot still uses the NXP-based
> fsl-imx8qxp-mek.dts, fsl-imx8qxp-colibri.dts
> variant instead of the mainline versions.
> 
> The other i.MX SoCs in U-Boot are better synced with the Linux kernel DTs.
> 
> I don't have access to i.MX8QXP/i.MX8QM boards to help on this, but
> for better long-term support it would be nice if someone could sync
> the U-Boot i.MX8QXP/i.MX8QM DTs with Linux.

Understood. Yes, this is some real work that someone should take up.
Just doing the sync will likely break everything now.

At the moment the situation with i.MX8QXP/i.MX8QM is not as good as
i.MX8M* neither in U-Boot nor in Linux :-/

Francesco

