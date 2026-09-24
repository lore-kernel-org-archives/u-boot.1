Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF996C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A13F540F0E;
	Thu, 24 Sep 2026 02:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2RjxSgCQ6fu; Thu, 24 Sep 2026 02:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A04340E61
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790218577;
	b=WDBCWzfQ45KIJ6SJoWTuW8q6mCgbhP/or+g3Mwe4uYf81bX9aVHw9Osdn534oJ1uXdZ2
	 jv9nd+LsFIXrN+GxmegTVILw4NW0i4gFSDLRw5jw2t1sjF3gOSo+dKxPB3vBF2B1FrjO+
	 qUrpyYPnO+b8CDuqaqnL4Tb5RVCAV9CKJkzpX9Gh0cGofr6w2+LCO1319e2QqFoI/3ViK
	 GPoOjHNyXohO0gvs+vdu+zfmIDlCD65GVf4GNGsSiOZbpCHwKU/k1aQKFFRUxcIsu823W
	 6neMt0vtUJNu2/1JbzY0Xwr55rYV/Eu7/eMsPxcJc4y5jdenntbzVCCpDIQPOFOf1vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BCnTnYWd/bjl0McYF36W1SN4X9s/ueoJewc2y5sTE+A=;
	b=eMtqGWcJldACpnXJzCzWuQl+gSr74NgGCSAr7RUh+eTT3Ed985gm/A7bnB7HLIUBluPh
	 XkTNC3k0gZ85sCDg5anorht6RSWVPkEwHMbSL6wlbbMlvdeHSHn5v7jhU1Wv9StXs5cev
	 GXW20sC/pLLYVvkCZ8GwOwz7Ljnct+fbpcp8pHzjaahc6iwLutzsXC+siiFdlMS3703th
	 kX4yCQSiWWxITdkKGK5+1ciFLHHwbZyO2A0B7MAW6YabHpBQbqRdyExH/fhphZSJSs7gh
	 mCUGkDEjrXVTYCuKcX5Fdu90OAsVULUZsekqPQ5ZWtg8uNdaHL5p/YPKVqCuNznt7Cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218577;
	bh=BCnTnYWd/bjl0McYF36W1SN4X9s/ueoJewc2y5sTE+A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5f9VNV1tF+AI8ZUgSxy2q/TpLR/Qaj5pBX24TC2eQRf2LNovWrzYjtTnsfgGg/Z7
	 lqyI64T0IOzIqWSDsWbjf0y254TES06L0pgZlT/PiutZsA6pwIkV5HxLHdsyLEBpy7
	 dWS289f6MqpwrVJR8paS/bqFOb38T0ebZXc3R/J0HBc9OnLV4QWQbwwi/47gEsVJuu
	 3Z5om/ZAgirwhI/jSrv8uxDgOf82BlvzACS/6rOnR5bzL1q0hMFG37DcAjOAuuA9vD
	 GsPc05isqA5JoacxlczKLBmvhRLaxC3cLZyQkmMM8EUmNyr8/Bb32DRL+MXIHZwMUX
	 f79Kk7gNpebyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A04340E61;
	Thu, 24 Sep 2026 02:56:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82CC0194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 686C9400AE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWE09sMyahtL for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C662540079
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790215175;
 b=m7XaKtRn6ny5l1ZcrNCQLlsUgaQV8F94zAJJVOVWmEPRtkkxZ5TimuX3EwGB5RkYHAuN
 LyyqbhbCEWkQ+1yM/GAnnJe5xHHhYle6Dy6W8976AqOnsq1nIHYR1TcCukNKdfaJlIKqf
 G6bc9H4PEv8sEn3/ynYwH5o80m5IiM0YmbQ1GlHDS40Nf9UgV3rtwMV9fZUFn2UFKr9Yl
 qb+NS252I8k/YAJLhM7jnyfy0aLWk8WjBLNW62PqXhybhzzdE16Hq+BPRCWDIV8/ZALX8
 RBN0+q54cFHj7cHq9iruNE128rJumZFDoiW1N5rtK8DO/r0gWS+Ytdjr0alKD8uSmGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790215175;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-Virus-Scanned:
 X-Virus-Status;
 bh=BCnTnYWd/bjl0McYF36W1SN4X9s/ueoJewc2y5sTE+A=;
 b=gLG9oNjwEf5Zy++3EAmqV7+gyYjo1+D7oQjL9nQfY3IOzxgYVFx2qAntAjsSMnNEOYFT
 HqoxiUMZVm300OktWFhdwqr9pTfhs82R38z8nC2I9QRUEh8bsmIiUNUxdViRcPRib8PK8
 A5ulkfwNKZhGCHQDPi7kVndrKxjPAFiZPln66hftYarAxnG1Ny9HgR8vLOQHWAqVW2uD1
 lwKTXsHjTdjdmUE9Ex18CWoVsveF6njc3qTvTCOSHD8/fQtTjnzAtx+vrDER1rJj2DueK
 lZx2Xh0kdN352RmIkt4q7Hu1/SvC1UZrWfjzqBjPLC7riPTDMD4lIKIhjG/UKfGeiNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 spf=fail smtp.mailfrom=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=Z1ov3gSl; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=takahiro.kuwano@infineon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=Z1ov3gSl
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C662540079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:59:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD79847DD; Thu, 24 Sep 2026 03:59:32 +0200 (CEST)
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5685C80117
 for <u-boot@lists.denx.de>; Thu, 24 Sep 2026 03:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
Authentication-Results: phobos.denx.de; dkim=pass (1024-bit key;
 unprotected) header.d=infineon.com header.i=@infineon.com header.b="Z1ov3gSl";
 dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790215170; x=1821751170;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3MSIbDsmBg13SyU+krwE5romGRrtVcc5vkCtHUGoK74=;
 b=Z1ov3gSlWPDEcmMH6F2Yb6f21k1o7nruucOZeYwaFLZspvk5HzupRPJc
 XlSio8iJNPWIzj8qCUepVOT7BJkZxkWz0fQbThPBFEtpKoyKx+0dP7jnK
 /roGX0V46J3L/r2zD/wO9zAwuj6go+TCMhYJ9vWbEACOulTZpQYXb/fKG k=;
X-CSE-ConnectionGUID: Fg/KGsnWSu2baUThLS78KA==
X-CSE-MsgGUID: TX9KNnTGQNickzZlZYujJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="110752662"
X-IronPort-AV: E=Sophos;i="6.27,119,1787004000"; d="scan'208";a="110752662"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:58:30 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 03:58:29 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Thu, 24 Sep 2026 03:58:29 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <jim.t90615@gmail.com>, <JJLIU0@nuvoton.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <dhphadke@microsoft.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
Subject: RE: [PATCH 2/2] mtd: spi-nor-ids: add GigaDevice GD25LB512MF
Thread-Topic: [PATCH 2/2] mtd: spi-nor-ids: add GigaDevice GD25LB512MF
Thread-Index: AQHdRxhBPrinGXvsykiJTFML/3yAorbc/3jw
Date: Thu, 24 Sep 2026 01:58:29 +0000
Message-ID: <c94b42e4eae94a5585e8afa7fbf2b526@infineon.com>
References: <20260918024842.1838692-1-JJLIU0@nuvoton.com>
In-Reply-To: <20260918024842.1838692-1-JJLIU0@nuvoton.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 24 Sep 2026 02:56:02 +0000
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

Hi,

> Add the 64MB GD25LB512MF (JEDEC ID 0xc8601a) to the SPI NOR ID table.
>=20

Please confirm the datasheet link [1], and add Link: tag.

> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 3e7096bd419..06794d5507a 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -187,6 +187,8 @@ const struct flash_info spi_nor_ids[] =3D {
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd25lb512", 0xc8671A, 0, 64 * 1024, 1024,        SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> +       {INFO("gd25lb512mf", 0xc8601A, 0, 64 * 1024, 1024,      SECT_4K |
> +       SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},

The chip has 4-bit BP and TB that not supported in u-boot.
Probably the other existing chips have the same issue, but I'm reluctant to
add a new chip with HAS_LOCK flag when it is known not to work...

Thanks,
Takahiro

>         {INFO("gd55lb01g", 0xc8671B, 0, 64 * 1024, 2048,        SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd55lb02g", 0xc8671C, 0, 64 * 1024, 4096,        SECT_4K |
> --
> 2.34.1

[1] https://download.gigadevice.com/Datasheet/DS-01014-GD25LB512MF-Rev1.1.p=
df

