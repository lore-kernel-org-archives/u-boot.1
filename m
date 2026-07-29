Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5989C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 782A681244;
	Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ts48rIoS9jsG; Wed, 29 Jul 2026 12:29:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11AE8812C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328142;
	bh=8zKEBL3hjG32gaTr3GoIhWvVkNLq9nnCSHjlUgKjRbU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeSD+erUO0gfV1h7gEKUGh7D+k9wpxavjI2Qj/AGuhlIpPJ6KqKfnPbdWGE4N8okA
	 3ESX0Cy4YyEXCeMhrqw/RlZQlk4uGAVBUrQWBClZFZp/cwKg2NbMfhYPhfvjSCRy8U
	 WfKdsqJowtu935a2uRijKg24YMdXjzqbGAMkhRHlaI8gU4xTuQ2CoVTkZftkKk67vQ
	 ptHerk40y8BT/IB8zH/nUb4LLjehvFKzsv2D/mQnLFgp0fSlKQvSoOihy6TCbeQDWa
	 7I5FR8JyV1/6BFym59vapMW0TcZic4d+jjmISzhqPP4pdnP+wtVfxxNil1QKdMa9qy
	 qhvNaEL+1QXwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11AE8812C0;
	Wed, 29 Jul 2026 12:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05EE445B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E052C4004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWIhSi-xok1S for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:14:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::5;
 helo=smtp11.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8BE2E4009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BE2E4009C
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BE2E4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:31 +0000 (UTC)
X-CSE-ConnectionGUID: l19BIOhsTOe1F3Rn5P4LZw==
X-CSE-MsgGUID: 5mzB5YvkTPSt3C7lbCRITg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="153636153"
X-IronPort-AV: E=Sophos;i="6.25,192,1779141600"; d="scan'208";a="153636153"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 11:14:29 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 11:14:28 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Wed, 29 Jul 2026 11:14:28 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.u-boot-project.org>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v8 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Thread-Topic: [PATCH v8 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
Thread-Index: AQHdHZ5JFSSXboGaZUaKKvE96Do3u7aEOIVg
Date: Wed, 29 Jul 2026 09:14:28 +0000
Message-ID: <d0c2fba28c374085aa9e5e858445cabc@infineon.com>
References: <cover.1785138294.git.weijie.gao@mediatek.com>
 <ff81a27b5e9985dfbd49d4862f1c3b592e30c0c9.1785138294.git.weijie.gao@mediatek.com>
In-Reply-To: <ff81a27b5e9985dfbd49d4862f1c3b592e30c0c9.1785138294.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:29:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1785316472; x=1816852472;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3gFybt7c1XdVw1axl4zi54qbWzEhUidiBkkUoPfzMH4=;
 b=fS2kMzJ6+tnDM5GGqUSsenYwEzw9cgSCtrLAkJkRb7/hEM0huxvbxSCj
 IvZyPzgWA+ybCExkmhBQ2Z27MLvfQFu2vM861UqYPDgsCI9ujGOvmJ7LW
 32r1TJxEpTF/06AMCWWeLkiCblqLJpIO1mVxEc5gR6qzVlueNfj728XW8
 k=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=fS2kMzJ6
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

> All currently supported ESMT/EON flashes supports 4KB sector and dual rea=
d.
> EN25Q80B also supports 1-1-4 quad read.

This is inconsistent with...=20

>=20
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A%20(2T=
C).pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pd=
f
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v8: not changed
> v7: removed SPI_NOR_QUAD_READ from en25q80b
> v6: removed SPI_NOR_QUAD_READ from incompatible flashes
> v5: not changed
> v3-v4: updated commit message
> v2: not changed
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..cf51f0ffa0b 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -90,12 +90,12 @@ const struct flash_info spi_nor_ids[] =3D {
>  #endif
>  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
>         /* EON -- en25xxx */
> -       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
> -       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
> -       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
> -       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
> -       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0) },
> -       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
> +       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K | SPI_=
NOR_DUAL_READ) },
this.
Please update commit description.

With that fix,
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

> +       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ) },
>  #endif
>  #ifdef CONFIG_SPI_FRAM_FUJITSU
>         /* Fujitsu MB85RS256TY */
> --
> 2.45.2

