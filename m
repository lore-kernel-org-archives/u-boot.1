Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FACC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 04:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0469D80EE1;
	Fri, 31 Jul 2026 04:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhV4LfAlPtvV; Fri, 31 Jul 2026 04:48:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A87380EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785473287;
	bh=0ZfoEwjKB3E7UMjM1mlBgqZV2gq5DwZ+lLpV85GFQyU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B2FHJXMHpiiUzFpLyJT8GjNmbSFKOOGOXENY2vTO2pwxyIhyMckthoSvYGlARtk6R
	 ObPLcMe6WIVb8NP7P1KWYuOx9UOTx0Tydy4a7FGh1mlEFNPlBkgTNoymGZyGprQP4G
	 0CzyylZvSXaRK70r0+iqngGbAtkJy9GMhH11BFbFWfX/LVyLA0N/REvTw7mqPILCku
	 XaGxwHwOL+8R9FxR+PORfFyjR/zVvgkpxl0+547nx9k90BdO+RotyxCQW1ZyJVWYKk
	 BrJ2/Sa8neOf1rOIpUN/KMmrjoZ2WlnI6xFm2JBfHxfvzY7fXybiDL3S1rJNAsBD0S
	 TeMYzjxnTpz2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A87380EE0;
	Fri, 31 Jul 2026 04:48:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D271426C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B844140159
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7c8pr_x88kfR for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:49:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.10.52.204;
 helo=smtp9.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 202FD40067
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 202FD40067
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 202FD40067
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:18 +0000 (UTC)
X-CSE-ConnectionGUID: aFLhZACoRlazrg4235d/5g==
X-CSE-MsgGUID: uYu29CVvS/ydxbc+DOf3eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="102943794"
X-IronPort-AV: E=Sophos;i="6.25,195,1779141600"; d="scan'208";a="102943794"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 05:45:16 +0200
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 31 Jul
 2026 05:45:15 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 31 Jul
 2026 05:45:15 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Fri, 31 Jul 2026 05:45:15 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.u-boot-project.org>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v9 4/7] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
Thread-Topic: [PATCH v9 4/7] mtd: spi-nor-ids: Add 4K page support for
 Macronix MX25L25635E
Thread-Index: AQHdIJexcpK2uCzqokOjCxC+IJpEE7aG+9FA
Date: Fri, 31 Jul 2026 03:45:14 +0000
Message-ID: <987f199bd1ea482cb545b48dbfd1214a@infineon.com>
References: <cover.1785465270.git.weijie.gao@mediatek.com>
 <02bf691fbce92bbb73c56be4bd3a0a7a6e84a1fe.1785465270.git.weijie.gao@mediatek.com>
In-Reply-To: <02bf691fbce92bbb73c56be4bd3a0a7a6e84a1fe.1785465270.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 31 Jul 2026 04:48:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1785469759; x=1817005759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/fyIIbTKLnlDonCQuLc4NRqG4/n3OAor/2ErEqLA3Dc=;
 b=p2YmN4wr5qiG5W7o1PTTcahEU7/5mlBCvWoZNMQHvtiV/8dgMOnhC+i/
 e+JVrOeP68P3Lo+nhXbGt7ZkdbJoIl8HU3lb8OChNrdtKMnbkvRUEzV7Y
 iNtfRBGzGdRAIaAfN1VydXTcKD3Ms2B4HbyOAT5xrj6PSjUTPZ4Od2Axb
 o=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=p2YmN4wr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Weijie,

As I asked, please fix commit message (email subject).
You're adding 4K 'sector' support, not 4K 'page'.

>=20
> MX25L25635E supports 4KB/32KB/64KB uniform erase sector/blocks.
>=20
> Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635=
E,%203V,%20256Mb,%20v1.3.pdf
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v9: not changed
> v8: restore SPI_NOR_QUAD_READ flag
> v7: removed SPI_NOR_QUAD_READ flag
> v5-v6: not changed
> v3-v4: updated commit message
> v2: not changed
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 454969826b8..07f34d361e8 100644
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
>         { INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_=
NOR_4B_OPCODES) },
>         { INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> --
> 2.45.2

