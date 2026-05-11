Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C5CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA82845E3;
	Mon, 11 May 2026 23:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="PmAtBzst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA998464D; Mon, 11 May 2026 23:45:47 +0200 (CEST)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBE78394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:2af:22b0:4541:7af0:2b60:7c7f])
 (Authenticated sender: vjardin@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 0814813F8A9;
 Mon, 11 May 2026 23:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778535944;
 bh=bu7dYCRtb7eHbjbFX8sq8+stqsgDm+yO7lYHGjRkMeI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PmAtBzstNJXhyQrHkGSICWCbBUJGuI/8pezfFlb2NSHsemlBhJQQnkhYbw84NPfcI
 m/yBJkcSvtZrWqKkkCrk7gZ8bgeRAEAyAcUS0SM/ClZ/MHKNOqxR+YdMN+ga1qAlwj
 nbtXqb5j835yNGUDcXXO+qvLsY+cw4qqPe17sv6D556inGhr4oUBXSz2+pU59K0yak
 RVuEWtfQKOnUO+D/UUzxNbaB6hMsP/xwNgkG4nlFbVh6FYc/Wa7cpk6FFeWXjAAIzq
 gQXvcRhX1NI+KKqO3jtDwOegL3ZzksylFyos8eraNglcVm7AoQ1ODo6+cIvBDsRY53
 7QC94fWpFvlsA==
Date: Mon, 11 May 2026 23:45:31 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Takahiro.Kuwano@infineon.com
Cc: u-boot@lists.denx.de, christoph.reiter@evk.biz, dlechner@baylibre.com,
 flaviu.nistor@gmail.com, jeyu@issi.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 yangshiji66@outlook.com, ssunkkan@gmail.com, trini@konsulko.com,
 vigneshr@ti.com
Subject: Re: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Message-ID: <agJN-3C_Pril04zA@L30177.local>
References: <20260510222140.603755-1-vjardin@free.fr>
 <77e1b83ec3d549d0a2fe2816241446c7@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77e1b83ec3d549d0a2fe2816241446c7@infineon.com>
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

Hi Takahiro,

Le 11/05/26 10:28, Takahiro.Kuwano@infineon.com a écrit :

> 0xc8671c is for GD55LB02GE and there is duplicate entry appears in the last
> part of GigaDevice entries. Besides SPI_NOR_HAS_TB flag is missing in the
> "gd55lb02g" entry...

I deliberately did not copy SPI_NOR_HAS_TB. The GD55LB02GF
datasheet (Rev1.2) documents an SR layout that the uboot's current
SPI_NOR_HAS_TB handling cannot drive correctly from my understanding:

  - datasheet table 4 (SR1): bits S6..S2 are BP4..BP0
    Bit S5 is BP3, not a TB bit.
  - datasheet table 5 (SR2): bit S14 is CMP (Complement Protect). Default value CMP = 0.
  - datasheet tables 2 and 3: show that the BP4..BP0 region grows from the bottom of the
    array when CMP = 0, and from the top when CMP = 1. The TB-equivalent direction
    selection lives at SR2 bit S14 on this die.

currently,
  - include/linux/mtd/spi-nor.h defines SR_TB = BIT(5).
  - drivers/mtd/spi/spi-nor-core.c reads and writes that bit in SR1 when
    SNOR_F_HAS_SR_TB is set.
  - the same file spi-nor-core.c has the comment "CMP: complement
    protect - only support CMP=0 (range is not complemented)", ie the
    framework never reads SR2 for CMP.

If SPI_NOR_HAS_TB is set on the GD55LB02GF entry, the framework will toggle
SR1 bit 5 on every direction change in sf protect which on this die is BP3
not a direction selector.

For the same reason, SPI_NOR_HAS_LOCK on this entry covers only a subset of
the chip's protection levels,
SR_BP0/BP1/BP2 (defined at include/linux/mtd/spi-nor.h) as BITs 2..4
miss BP3 and BP4.

A vendor hook handling the full 5-BP + SR2-CMP layout is out of scope for this patch.

> >         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> > +       {INFO("gd55lb02gf", 0xc8601C, 0, 64 * 1024, 4096,       SECT_4K |
> > +       SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> 
> Could you create a new entry just after "gd55lb02ge" with the same flags with
> it? GD55LB02G'F' should be a successor chip of GD55LB02G'E'.

ok, I will move the entry next to gd55lb02ge in v2.

Best regards,
  Vincent
