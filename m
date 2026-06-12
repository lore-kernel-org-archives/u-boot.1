Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35CDCD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C1E84968;
	Fri, 12 Jun 2026 14:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="W5ycd68k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10342839A8; Fri, 12 Jun 2026 10:41:17 +0200 (CEST)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93468005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781253675; x=1812789675;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IcUtwKF4dHhWgh+OEGJ0xjeiVhD+Zav2G86pKRd2FgY=;
 b=W5ycd68kPTmzVX2iPFVsmFVkll1lLqeSFysypA3e7itm716o+8WyZlnh
 lCKaq2gKdoy32ZyI09jbAa9LMmbQ9kqu13grkLAALWSFLIl1l1oei+4lY
 c2gCEDYAgzTaf0XaEq6NT4jLAXkF/hrQHaFIyII5BCAEskIRCZ/WlYmh0 k=;
X-CSE-ConnectionGUID: essDhrQRS6aVcjLz7B5X1w==
X-CSE-MsgGUID: bom6PksxQo+3vf+DmrKmcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="133557964"
X-IronPort-AV: E=Sophos;i="6.24,200,1774306800"; d="scan'208";a="133557964"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 10:41:15 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 10:41:14 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 10:41:13 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 12 Jun 2026 10:41:13 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor-ids: Remove SPI_NOR_HAS_LOCK flag
 from GigaDevice GD25B256
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor-ids: Remove SPI_NOR_HAS_LOCK flag
 from GigaDevice GD25B256
Thread-Index: AQHc+XpFJWD8O75j/kGbk27WLb2l2bY6k6NA
Date: Fri, 12 Jun 2026 08:41:13 +0000
Message-ID: <543998b43ed44688a8d8e7a3b67e12c7@infineon.com>
References: <cover.1781164951.git.weijie.gao@mediatek.com>
 <8fd933856d0d6e4a37a4e344ffc4deb97c2b5f9e.1781164951.git.weijie.gao@mediatek.com>
In-Reply-To: <8fd933856d0d6e4a37a4e344ffc4deb97c2b5f9e.1781164951.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

>=20
> The protection scheme that GD25B256 and all other chips supported is not
> compatible with the spi-nor driver:
> This driver supports BP{0,1,2} + TB,
> while GD25B256 implements BP{0,1,2,3} + TB
>=20
> Link: https://download.gigadevice.com/Datasheet/DS-00327-GD25B256D-Rev1.7=
.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Please add=20
Fixes: e72023c4906 ("mtd: spi-nor-ids: add gigadevice part #")

With above update,
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Thanks!

