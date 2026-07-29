Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90FC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D89F81456;
	Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aasVCfmMsAjk; Wed, 29 Jul 2026 12:29:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BB2A812AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328143;
	bh=sJOfLYvYXTSUhPWOwF2e7QL5iigkGQhRlj2yKJFsE6c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJ0T61VZdjVCicNSFxBCj3gYDic0Jlo1vwmqsCB3w+azHlD7nEgGhhuy1IGnL5jqq
	 L8bACmfiVL1cb2V7vYVDT5Ppk156I67k3YZgRoDLuDbu11xCXJYzWFsfLrwdhHEFFt
	 bsBkjr3ydCr/eURJ4TueKirVtqbB0nIBJI0KuzB0ZYex9pId2eVh9JF4KdIpBAZdU8
	 hdRRiPf7GzcdHirLMpfB1Fd1hXf9K/4TYieR6OnijpRQzB2HSG/17KFrbbmngqScUK
	 o8M7Iv9z/kanpmOK4sxt7dNiQM32wYvR5gHKnLWFp/83Rjk8r1+coQOSTFVm6vG1cM
	 6cn0Ot+NDXWSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BB2A812AF;
	Wed, 29 Jul 2026 12:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A2AF350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C4ED80C16
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZde5xn8QrRF for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:14:41 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 Jul 2026 09:14:40 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A1CB780C04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1CB780C04
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.10.52.204;
 helo=smtp9.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1CB780C04
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:40 +0000 (UTC)
X-CSE-ConnectionGUID: vwi170WwTHSx/Fk3VhxWdw==
X-CSE-MsgGUID: oQvLHM5SSiOjJY/PwmJRyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="102681472"
X-IronPort-AV: E=Sophos;i="6.25,192,1779141600"; d="scan'208";a="102681472"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 11:05:33 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 11:05:32 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 11:05:31 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Wed, 29 Jul 2026 11:05:31 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.u-boot-project.org>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v8 4/7] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
Thread-Topic: [PATCH v8 4/7] mtd: spi-nor-ids: Add 4K page support for
 Macronix MX25L25635E
Thread-Index: AQHdHZ5grkke9MCb4EirN7wv3nyihbaENf8A
Date: Wed, 29 Jul 2026 09:05:31 +0000
Message-ID: <133edd1327f84413a4dca5a724f1fe3d@infineon.com>
References: <cover.1785138294.git.weijie.gao@mediatek.com>
 <1a0f09385dbf3c29e284e98f60abcb46d25303fa.1785138294.git.weijie.gao@mediatek.com>
In-Reply-To: <1a0f09385dbf3c29e284e98f60abcb46d25303fa.1785138294.git.weijie.gao@mediatek.com>
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
 t=1785316480; x=1816852480;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BzN13Ztah7z6hTp5oDknal/Pl9HUrWpuaZ3wZxEmolQ=;
 b=dUE4YJqB++pve4isbR03J76/4MbxfrWlUz+dzVf1bkE8joM7BvxRTzKE
 V/OE6Id6IK73sXCSLJHogw2/YIk3YuJ/C4q15BVvxzPUmaA48CTkYNyoO
 ChsgqnU443Hg/6sAyt0Pv3+TSusPaEFr7FUdY5YfFvJ0CG76x1ZXKx06N
 Q=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=dUE4YJqB
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

> Subject: [PATCH v8 4/7] mtd: spi-nor-ids: Add 4K page support for Macroni=
x MX25L25635E
4K sector

With this fix,

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

>=20
>=20
>=20
> MX25L25635E supports 4KB/32KB/64KB uniform erase sector/blocks.
>=20
> Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635=
E,%203V,%20256Mb,%20v1.3.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
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

