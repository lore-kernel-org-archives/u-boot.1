Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247D8C43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850C684A7A;
	Fri,  3 Jul 2026 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="BOsHeeIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FBD846F8; Fri,  3 Jul 2026 10:52:14 +0200 (CEST)
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EC28469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 10:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1783068732; x=1814604732;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hV3OoQIP4JxTZV9ArazwcD+okGKQ8H3F/75eiYjwEMI=;
 b=BOsHeeIGDSRI2+F2ZieV6c/Onbu3MS07h1GosdSFfhg7ovzCIWgdJkNt
 VRuuFHTGfYTz8mpc/QiadB6OQRYC7TxRfsCiboapIDbf0sDvwHsCeosNF
 x3SvZpX+LfqcOxoEtAvfod6KthD3Rpg3WxyyBV1MkZr4lGcBs+wh86U6l Q=;
X-CSE-ConnectionGUID: dtqK5DzMRReiHVDNh3F6Hg==
X-CSE-MsgGUID: bL7dMsMgQZSwpAOjtj0lCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="99595088"
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; d="scan'208";a="99595088"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 10:51:12 +0200
Received: from MUCSE816.infineon.com (172.23.29.42) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 10:51:11 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE816.infineon.com
 (172.23.29.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 10:51:10 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 3 Jul 2026 10:51:10 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v6 4/7] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
Thread-Topic: [PATCH v6 4/7] mtd: spi-nor-ids: Add 4K page support for
 Macronix MX25L25635E
Thread-Index: AQHc/JlhmrwCxIewZEiWGKOfwEa/Y7Zbjk2A
Date: Fri, 3 Jul 2026 08:51:10 +0000
Message-ID: <d29fbb24a43b4593b7916bc50037d306@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <ab4739209544e1f55f623d17db1183547adce79b.1781508530.git.weijie.gao@mediatek.com>
In-Reply-To: <ab4739209544e1f55f623d17db1183547adce79b.1781508530.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

In Subject,
s/4K page/4K sector/

> MX25L25635E supports 4KB/32KB/64KB uniform erase sector/blocks.
>=20
> Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635=
E,%203V,%20256Mb,%20v1.3.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v5-v6: not changed
> v3-v4: updated commit message
> v2: not changed
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 4d07221ae65..018a8341553 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -323,7 +323,7 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>                SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES=
) },
>         { INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
> -       { INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SPI_NOR_DUAL_R=
EAD | SPI_NOR_QUAD_READ) },
> +       { INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

Like as some chips in this series, this chip doesn't support PP_1_1_4 (32h)=
.
Maybe using SFDP can correct the chip capability.
If you tested this chip, it would be good to describe test conditions, such
as SFDP used (or not), read/program protocols, and so forth.=20

This is a pre-existing issue in core that adds PP_1_1_4 capability along wi=
th
READ_1_1_4.

>         { INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_=
NOR_4B_OPCODES) },
>         { INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> --
> 2.45.2

Thanks,
Takahiro

