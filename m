Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD453606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yatGb84i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=XHuSbi/2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA5C140752;
	Mon,  2 Nov 2026 13:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKl50FwKxu7n; Mon,  2 Nov 2026 13:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B5C64079D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793625043;
	b=GwcgfERfK7qiCWb9rTmHJIK0X8cQFt9y8dXaaxBK6mTdjloGROhGuesz7S8NxvExjHUf
	 qOPsYFhz4JIfIsRvMXp9Ft4XSDPlChESt4Jxa0xCKpzbPhKsruqgqLrCkVdLt3oYghrhI
	 L55715aJqjcAqBf0aXZHzHJeaWcxloRavaIq7JlJmul+zPYnfMJz/0SwowSDZlhJnBQz3
	 /6+X+yErRstIapGy2tUm3tMRtqbsqhsA+QbzoWYtVFW5TgdkgYoLG9jqfiRfJxjqqHTX0
	 O28gq2IZA2Jj8oM+7SWzpBp/ZmYWMgE02zYXEtidyahzs8/piOKte1scSAxslgYVOyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625043;
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
	bh=G32d4PZm9utS0TuA+eqAt4DMtVNgzxSzDQJkM9J9+jI=;
	b=bVRbmCjt2TdX8iw6Ya16RN2vLsMl2DWKFZ9mM1+/yySdmIRvCEQmcu1oLA3eej+n4K6u
	 nM3mm3hYV2UWWf6ti5aDxX9J4MQnquqfPkTjmn1x8sT6iPqTK6G+It2lQaJd5bvIg8GF8
	 oqYXtUGgQ81IfkLQe1YudHCjJO6PQFEChQSmKojgmU3z1YptDPb8AXxuPzwUu+ZkxiiIa
	 wULx3Dktsqdg0nRIOS7LXCv9NtHjyOSqgdoDaNzbsQMC+yUXlDyTnjch8GOWSn81JrBzc
	 N71ehlDVcisp6zA0AU7OBkpMDlTFPMvuTcTmjWFS5f21Cemy9It3OckGJ/UYGDunZ0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625043;
	bh=G32d4PZm9utS0TuA+eqAt4DMtVNgzxSzDQJkM9J9+jI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yatGb84ii/NU/xjtgYJmpV7uSeCzrbwQk60qPI95kAB8tbm+HpzWfKBENBFIoKtS7
	 KenzekI6TKMbzF8UxdppJBPKdDX25QNjiTsTxBgo0L0++/NZ+X0+v2ptPP5NnMp+gK
	 INusy7rD4tboqMKlMu2R8iXDh/7IBUdI3IDJRgLOrVK2Jrp6177CFUFWq7gPdhzqrc
	 qcWvufTUsdYhySyGQ3c9kYvpkra5tqp08/BN5YD6vC3i3omGWTZwpz/wb3GiexnqOD
	 rDHhyGAOWm6ppvUCg131VmnPTCzuN48lfQvYZh/Y8xOQYt4A9cl+kuMJ3FzZyLQ2vr
	 8JB2/ex0qrdxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B5C64079D;
	Mon,  2 Nov 2026 13:10:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F948411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CC6F80B09
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emZlsi5as9PH for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D4B080AED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793612033;
 b=P1xiXWcUvHJy79uGDXcLWRB8N5N88gUwkdo+7bVO7LDitRJ+7QnzLycRRr12/fUVI9TE
 dxyDZyoHPy2+KzN28BVsqJotyHLlzXr0ntg5us6L3GpUBQd0gkrCD/+YLlJYjGi1Q1KB9
 0NvwwvwDqRAHd41nsC+G8K6Hk8ZNfZCI5g545FGp5GwgPf93meHQIJT4Mr4FdOh6CmF+i
 pbgqmWJ9pd0yI67DfVohMRyMbf52l/Ftoa4bze7R/cxxBR/Pbc+rRNBs+q/mE95UycOOT
 ddrJn3+x4XL+PGr0P6Gk6wXYlOkpvwHqS3tYkFZCejfnNf6jZLUxxz6ZUEbmeFPh84A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793612033;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-Virus-Scanned:
 X-Virus-Status;
 bh=G32d4PZm9utS0TuA+eqAt4DMtVNgzxSzDQJkM9J9+jI=;
 b=N1pIBndwGHrRdrVTGYofZSkSvW4oe3zG+zHXvFj4d4Sv0MkdtrBLfs4JvlXRsJLs3Wd4
 pQe7N0UIogjw70PwyCVelChOFsjrodbpcEm9n1pScCLn/TJQPr7a7kYwG/TKGnP8NoEYg
 6IrraDdwUDAG70q6GANDK1h35nVy+eKlRZ5D/I8855tISNCgHXdhYu82lufxToaEODyC9
 JDf2VHl1L0O9Oyl1IQurZrgaW19AuGwoaIr10RnTCnuRQV17Gq/jtlAzcEifRIMDIeXHg
 XGmMcPu5umSg3vHGtYLnNNAsjVhJ7zPrWILraym4VOuHXPbjEJvJmTQQc24PfdrG6IQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 spf=fail smtp.mailfrom=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b="XHuSbi/2"; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=infineon.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=XHuSbi/2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D4B080AED
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:33:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B412783E76; Mon,  2 Nov 2026 10:33:48 +0100 (CET)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CF783108
 for <u-boot@lists.denx.de>; Mon,  2 Nov 2026 10:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793612021; x=1825148021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QPXAlBwbAepjNN3ybbK7mfUmmGvZe3qJhzd2y5pexvM=;
 b=XHuSbi/2u5i06GWm2YGGcNjXyZhovrUT0YnqphvdunTFoCQV/miZx8eP
 s3GnPO2b0ajgVeZeFW/pbnIjgMTVMbmshWjxmQVgrnd2qZWGb/zmBARQK
 7RNmvCWklulfnPhLLVWQlydlFHR8mkRW4BrE8dL2THVnDbpTPUqgdgTKY k=;
X-CSE-ConnectionGUID: TNY2+nNbQ+KpFHEE+iWOhA==
X-CSE-MsgGUID: RQHZ+kpNQeqRPEWLiHUjLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="187476120"
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; d="scan'208";a="187476120"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 10:33:41 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 10:33:40 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Mon, 2 Nov 2026 10:33:40 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <ssunkkan@gmail.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <Jacky_guo@xmcwh.com>
Subject: RE: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Thread-Topic: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Thread-Index: AQHdagLBIPXMF3co8Uyr3mNTTUjKxbcag9hg
Date: Mon, 2 Nov 2026 09:33:40 +0000
Message-ID: <0b5e6c2475e44574a61c5692d9ac13d3@infineon.com>
References: <20261101131239.1566-1-ssunkkan@gmail.com>
In-Reply-To: <20261101131239.1566-1-ssunkkan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Add support for XMC XM25QU01D SPI NOR flash.
>=20
> Datasheet: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf
>=20
Please use Link: tag.

> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index b370e78262..b42d7af967 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -677,6 +677,7 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { INFO("XM25QU01D", 0x204121, 0, 64 * 1024, 2048, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

Did you test in Quad mode?
Current driver assumes Quad input page program is supported if
SPI_NOR_QUAD_READ is set. I don't see Quad input page program with 4B addre=
ss
(34h) in the datasheet.

>  #endif
>  #ifdef CONFIG_SPI_FLASH_XTX
>         /* XTX Technology Limited */
> --
> 2.55.0.windows.4

Thanks,
Takahiro

