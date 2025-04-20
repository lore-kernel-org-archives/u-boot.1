Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D66C369CB
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 01:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992BC82027;
	Sun, 20 Apr 2025 03:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA7E82045; Sun, 20 Apr 2025 03:43:35 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD75F81FC0
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 03:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98.2) (envelope-from <daniel@makrotopia.org>)
 id 1u6Jfs-0000000052H-2YvT; Sun, 20 Apr 2025 01:43:26 +0000
Date: Sun, 20 Apr 2025 02:43:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com,
 u-boot@lists.denx.de, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, ericwouds@gmail.com
Subject: Re: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
Message-ID: <aARRJ85ULmqsYgPo@makrotopia.org>
References: <20250406130244.19496-1-lucienzx159@gmail.com>
 <eacd3b66-0262-4bde-9b91-6ca7eea789fe@mailbox.org>
 <2aa57092-f844-4ef8-9b97-0998a697c0be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa57092-f844-4ef8-9b97-0998a697c0be@gmail.com>
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

Hi Lucien,
Hi Marek,

On Fri, Apr 18, 2025 at 11:57:19PM +0800, Lucien.Jheng wrote:
> Hi Marek Vasut
> 
> Thanks for the review.
> 
> The next commit will change the loading of the PHY firmware to the
> filesystem on a block device.

Please keep in mind that most systems using this PHY are (like the
OpenWrt One, for example) simple embedded devices with only a small
amount of NAND or NOR flash. Loading the firmware from a filesystem
means overhead and complexity, while loading it from a simple
MTD partition, raw UBI volume or one of the EMMC boot hw partitions
is a better match to the reality of the devices it is being used on,
making the process less complex and more deterministic, and hence
more robust.

> [...]
> Marek Vasut 於 2025/4/6 下午 09:30 寫道:
> > [...]
> > 
> > Can this do the same thing as Aquatia PHY and load the PHY firmware from
> > filesystem on block device instead , using the blk* or fs* commands ?
> > Then the hard-coded filesize and co. won't be necessary.

Note that the size is afaik given by the hardware in this case, it won't
every change. Hence any handling of a more dynamic approach of loading
the firmware will also have to come with a size-check against the (again)
hard-coded size anyway.

> > 
> > If you need board specific loading override, implement __weak default
> > loading from file on filesystem by default (see what Aquatia does) and
> > then override the loading function on board or architecture level.

That can work, but in practice it will lead to code duplication, as all
platforms using those PHYs are kinda similar (ie. MT7981, MT7986 and
probably Airoha/EcoNet router SoCs as well)

> > 
> > U-Boot really needs a proper generic firmware loader, because this
> > firmware stuff keeps showing up more and more, but I cannot ask you to
> > write one only because of this PHY ... but if you are up for a challenge
> > ...
> > 
> > [...]
