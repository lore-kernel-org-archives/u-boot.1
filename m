Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6E606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fZglIuNY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=LAW9Q1aU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07A5F80F3C;
	Mon,  2 Nov 2026 13:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3JL4N42V-ba9; Mon,  2 Nov 2026 13:10:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12EBA80F47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793625041;
	b=EfkgKFJRFpSCf6Sb1G25IL2Q/6DKQy6FEndZEZe3zE1nvx67WKRs4ZA9NwL49RSTyuUt
	 xIe4PArb8bvPlsX/h4zKt+AQzVHzFZo4vZJo0MieXibmO5QRPXrbDG/MhJ1FwqpJUoQEd
	 eFSTYXz6R1z9SimHOqpEqMx3rakKrppkbviurzNz8mPQUOnQtDaywNHDzfkVolIeyTvcp
	 PWYJNWZiPnqxI2k871yfnJF7c+cfFJYkvS2M8eB+HSATpFSOapIrHWJaOtBT3oGb4jwMf
	 a52vpYRlXwEyatxNBant2pXe0tLnjigOG1oRNJFjoQzYgZKbTom+bkuRWBV4d/ZfGiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BP86DzfjSFpRJ26+c/FOi0QIzvx/jJRszoVeiTDjMlg=;
	b=RHCtmcF+ObqG1Ygxo+0wBHlVxq2wv4Yo5uRwBXPSPONiOfwSyfHvRfIo+y1UloilcKaV
	 RYyJ+fWJtl3Ie3ccgEfMXK+JR7skKn+TiwCEW5c5vs1VGMQHC4tARif5m+If3cM+UdRa8
	 RD/mpW2PRGqQ2BJg+RsWZPquyU6cIaMSWFDj4PxnSJ8hfXg0hZjqOxHeA6xbNUikaY6Tf
	 YeN0zMwYiHYvcZd+zc9LaPU3sMR1hu+7aQ/4BrNeMIXIanV2l2Ok2jniV4C3Y6cJqcOAb
	 4FgKPu2Tqt52pk/DBzIC9M1SxhWd6xnu7CRFcJ3oZc2Ok8e+525V2B+Z57zH6KEEqNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625041;
	bh=BP86DzfjSFpRJ26+c/FOi0QIzvx/jJRszoVeiTDjMlg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZglIuNYgBPF8T8b8NRvGhaiMioIdyVDs3t8kctzZwpxNJRGr9LLFyor6hgbEhAk+
	 GdN2zl/Og5CmGcYPLTwCAl8QThsdhHt/lUcKsttsgxizigHkcHTD8l1gof2P33SXBK
	 DpQZjyD6bzRD6VCtZjRJESGAZFtqay6c8Ny/1OmkolstwCJrPc5gjYHFAkPTs8ibKP
	 De22QC7lTNWMlYLk85/YYubwBwzccPdq1Jlp8YdDTQVQM3sdA/k7pjMJV1z+XtbfpQ
	 X/c/9EfW7GjXDPtEPefHQ6OcuQoJO/nbFY5UUVoFs/v+31iA4JSF3DOeNLkLHv/ou2
	 sLNJSRGot/7SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EBA80F47;
	Mon,  2 Nov 2026 13:10:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11064323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB003400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wodC2WExO6xv for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F148E400A8
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.10.52.204
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793611304;
 b=XrHyMCKPEN7D65UMq6/ADN0uzMIetW18kmhH/6mYYTyLSxVLWOOVKQuWmcqOH6SivTc4
 u4YEuBkpr78le6vJoQMo5/45SSHkL3tqXRPI1J/dAC7ivQQ5LZtjWUUzzJKaNjMm9Gbbz
 jGMrLJJEk8jeB1CldFtiExSHy0WRJQIsN+PeBaPGNnbBWXmhldB5cyTNnOrJ/llLGeuwF
 TsrGOB0orxy2p+Pqxqpt80L8XwKtY/48iu9/gKgjFrPcvoKy4P0QBlpF/vLajFNPb4hYl
 y6QuCq9SgAEuUBBuE6GiaCM+30BwaXS8i5+MiroK+7EET3vN1CM8UdT6+36DsQZN6Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793611304;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=BP86DzfjSFpRJ26+c/FOi0QIzvx/jJRszoVeiTDjMlg=;
 b=b/svz03/+fMtueV6Wb2pG/E8DRxgs17ITGxLPsKArkxCH6ltC9tsCdP6jf92Oe107GbH
 +w7ewEhTEhciS2Ed0rID27Muecba3rzejfCRz9/PH2ogs610t7X3hUWGs9zehlYym3Wr8
 8AP0mgWgoyWROlqSEcevRQY5s1iXomrcKGhzUtwQ7+1MXIYIHtUWPm+5Gvt7egF6WrJhU
 WHp0Z9YWYMzqAW+X0TN/htrpAXmo1yTjf5up003j4QQw+GtAutnOSmkrJbuX1i634tlzU
 J32LgysCrs4qOlFcvmwgut+KPR0a4zZyn0yrxX2hVuQLT7WGUXy1MTGJLwSlmnNOT7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=LAW9Q1aU; 
 arc=none smtp.remote-ip=217.10.52.204
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 02 Nov 2026 09:21:42 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=LAW9Q1aU
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.10.52.204;
 helo=smtp9.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F148E400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793611304; x=1825147304;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h3SPVtdIpqscjZv35y1pSiEz6s2LGBDairTK1i/nxgE=;
 b=LAW9Q1aUj85bCXJrA7nM8AYZVVif4BOq/f3ygCLdqG6i8aGZjytePkUz
 zLRuye59wf5+ehfv/Y/tyEDZGo3XQWw9NnRHu2LUlxUErUpY5PxQa8tES
 n1tPbBrvgFpjMDmBAxvWYpMNdxvOwTGCNDH0End1WRZigBDPEQJBaSQtP E=;
X-CSE-ConnectionGUID: xugVgjOKRk6V6nyv/KUcsA==
X-CSE-MsgGUID: tBC7ufDfStaa9cf5Nq1hbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="116077566"
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; d="scan'208";a="116077566"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 10:12:34 +0100
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 10:12:34 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 10:12:33 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Mon, 2 Nov 2026 10:12:33 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <marek.vasut+renesas@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: <kenichi.nagai.ry@renesas.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <vjardin@free.fr>, <yuya.hamamachi.sx@renesas.com>
Subject: RE: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Topic: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Index: AQHdZVCX6cZLGgwujECbVyfAKfZWurcah+rw
Date: Mon, 2 Nov 2026 09:12:33 +0000
Message-ID: <896390bd13f4439297a31492e1a3dda5@infineon.com>
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Nov 2026 13:10:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>=20
> Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, SPI, Quad, Octal and DTR . For
> details please see vendor page:
>=20
> https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t=
-nw/
>=20
Please use Link: tag.
Unfortunately, datasheet isn't publicly available...
Is it possible to add board information you tested?

> Signed-off-by: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Vincent Jardin <vjardin@free.fr>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 67486d7a945..fce22300b61 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -670,6 +670,7 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("w25q01nw-im", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI=
_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("w25q02nw-im", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI=
_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { INFO("w77t51nw", 0xef8e1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

It would be helpful to see how it differs from the existing w77q51nw.

>  #endif
>  #ifdef CONFIG_SPI_FLASH_XMC
>         /* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
> --
> 2.53.0

Thanks,
Takahiro

