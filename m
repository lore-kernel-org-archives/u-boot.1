Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5756C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AA4560B1D;
	Wed, 29 Jul 2026 12:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oS8Tbfo1pGJV; Wed, 29 Jul 2026 12:29:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00E6C60B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328141;
	bh=E9eTW4HSVuFpdt3bkmJnhC6a7z8z4+a9S8M3/87Gnbw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPLDDbAFPD5yVnTErZhO7ad/t59wuElmDHjAb3Xc7YhLJhvI7wmGkccggZg7S4NIc
	 syQwYrzhSMyzq1cpVIn+MgTECHNxBE1/z8LopL37pbFXLjQf3mbfpZq74IxYK+fNNL
	 IwFGhCz9Bejn94if02uHhqiQmY50FyY5IILPJhFdOE4CYKAjLecJZ9uNxfhXTthHsm
	 J6GeHQZQ3Z7Ltbs/YBzcPvxr7SdFU8sl4RWLh2UCoZnWs8vr6WInwczaci/N6yPPgt
	 6n6l5kZ1TlvWprf7mf0QN1WUrLLxCtDEr8wKpBvgwB9DLT6nT+njqYZd8uEnhfjcjW
	 lCxn+dYppOZxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00E6C60B11;
	Wed, 29 Jul 2026 12:29:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 176A0490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1F96810A1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRca3X4khyoA for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:06:27 +0000 (UTC)
X-Greylist: delayed 431 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 Jul 2026 09:06:26 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4D82780FF7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D82780FF7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::6;
 helo=smtp14.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D82780FF7
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:06:25 +0000 (UTC)
X-CSE-ConnectionGUID: TLgLhTYMQSiJriLVywLsGA==
X-CSE-MsgGUID: 9RPLRucqTquhvtOgOZo5qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="139840430"
X-IronPort-AV: E=Sophos;i="6.25,192,1779141600"; d="scan'208";a="139840430"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 10:59:13 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 10:59:12 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 10:59:12 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Wed, 29 Jul 2026 10:59:12 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <festevam@gmail.com>, <u-boot@0leil.net>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <kever.yang@rock-chips.com>,
 <u-boot@lists.u-boot-project.org>, <festevam@nabladev.com>, <vigneshr@ti.com>
Subject: RE: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Thread-Topic: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Thread-Index: AQHdGhLZ/a563f03JkOofxvCynNiXraEOfFQ
Date: Wed, 29 Jul 2026 08:59:12 +0000
Message-ID: <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
In-Reply-To: <20260722194638.1285159-1-festevam@gmail.com>
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
 t=1785315986; x=1816851986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Av3DgLj5mjZEIfCFJJE9mMk5uPWmD1DhN4ymdHDqtEc=;
 b=Y81g+Iibbyxvv0YsTBGp+yggF+t34mE5RrBTgVm6BBa1Ye2RLAit2szD
 /EEPUsOdOx3NmQoxlG8kW4rgdobyfQtM5IHSbpnnJ+xtbDbsgR1d+dPHr
 jQx6jDY6aY69eeOBH1lYAVhKGQHqLZAsnYPNMRipKSPHEj7yZvyopi9GC
 w=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=Y81g+Iib
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

Hi,

> From: Fabio Estevam <festevam@nabladev.com>
>=20
> Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.
>=20
> This is a 128Mbit device using 64KiB sectors and supporting 4KiB
> erase, dual read and quad read, matching the other XM25QH128 variants.
>=20
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---

It would be nice to have Link: tag followed by datasheet URL [1].

> Changes since v3:
> - None.
>=20
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 31a2ba49a87c..90aa1025176c 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ) },

Per the datasheet, this chip supports Dual/Quad ops but for my reference,
could you let me know if you tested 1-1-4 or 1-4-4 ops?=20

Anyway,
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

>         { INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
>         { INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> --
> 2.43.0

[1] https://www.xmcwh.com/uploads/435/XM25QH128C.pdf

