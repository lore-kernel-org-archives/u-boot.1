Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18873C9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0908360B71;
	Thu, 24 Sep 2026 02:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OKtZaiOdQyql; Thu, 24 Sep 2026 02:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0316260B51
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790218572;
	b=L+cJs7miY5LDfsWrG4B7S/cAdo9Lcuj+/0LQBU/HrY2JB2ven/jkHddntmmcioek38cR
	 eSQ13kWHG/huBKj3HnmBBzYudCOwv7C/DKS539Cj3rBlaEp5MthMdkyal3IanlEgW2Jfl
	 mjVcEGHmoequkzPGKWAgNkr6hij6/82Fop3akSmlwdtE/77gEAEewDwBwen4U8oqBsZgH
	 z6GRPCI0DLevkIanEnMSILsO8LaGFp9721NYHB24DLBWzVvOrh941CEgpJZC9SoVMf+nf
	 Vt6XPkgHWN+ZbzzZEMjjJ8N1tE9F+aHOw00JK7PerIb+T4isyqsDOB12HeLHMQ+tIjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dUxW4pVf8RyjKyBznw8WctZlDR2M5pHTo2mb74vYf2U=;
	b=m0IVZaZP0tyaPyk6ojg8HwAHkyqrN064fKoodq803p4XR1aY9VsDfIPVrN8R2KQRKmu+
	 A7z5SC90qN+hh78c47RRcOlDr+Oa00xO4f3PlSohs4hBg7s7YMVO/HjA5G6vcHyldHXQN
	 /+5GYTyCRYw1zlc6ihHYFXdipYhoWmf07IQsCzfFOxx/ZzPQWEFHcfRYeU3UUWsv47Vjl
	 0B0VyYBcaK9cBz+BebtlE4XdTRClRfK+V+UKKJHq4PamIvKzXFCTF4MfWCGn6qWw5C7iw
	 koWmO+vRBX/ZPhnvteW9z4G0QBlCIwJXo1kSka+F48TrMl1S/Dzs8d6m78HUDaNusdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218572;
	bh=dUxW4pVf8RyjKyBznw8WctZlDR2M5pHTo2mb74vYf2U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aROxsMMjn5WJc84fKMBzw7WBoUQkqSfsXV1Qp2xhUjETF46mSxPLKjAt80KLdqp8B
	 vvFDwnMZ38Fp8BCWcufoRMScmWdHHHBluPdkgSQtrDHOHwnJugkLEW4HxGh3wQgkvD
	 YmjIDAW9Ati3HGkslUsNlp1OHoB4eyLyyEYx60Bx9HNIleGxeH2ts9jZSvdY9YHfuo
	 j97+MRzOlHSinDah5KLU4AzkJohClAY7JNi4RpEftFsxZN0h+YdlogwFQTtTTW2Stn
	 XKN4XZT9eNwkmCUaj+I66jvXStgH1Css41g3stJZ6u6oC7gl4qYRrwT0bU4jg9RbT8
	 5zYHO6BM8KL6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0316260B51;
	Thu, 24 Sep 2026 02:56:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55A14194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B9C240E49
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CyqkpmvCPH8W for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DC8F340E1E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790214264;
 b=NvDQycCLewrCV4Ng0K3cDsckkO67YZHYKzOFPKmN2JCt7aYViTkK8GO1WzApnabFRwR4
 mThhg9IMekUTLVCpr4adZax4S6hhuH32Ug93cA8Z5JIOSBr4ExQjieUXuIpnGVB3k3hjs
 /YrA/nK0co1ft3SCD0t2QT0vZ0O23VYF8sYXx8dTAtr1weL2pkIIfUPuVh2r2Ue82ydju
 9Z0GgfSPM+pn1pDIumzZCTJ6np3uFsvwJJUQDkrRP4WVShqutq010Uy3o4OPEC0Wd/vFI
 3EuZ613QJD/+BfQoeG9/DVHFiaTMvGDD9yPIQ1GqiFilHD71+Xoa1Bwktb7FxdyiFCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790214264;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=dUxW4pVf8RyjKyBznw8WctZlDR2M5pHTo2mb74vYf2U=;
 b=XgRtmWdyJh/fT+ONb0ZY/k/ZXoCHWIRUsniof437XEI+G8mE6zRT78E37e+ZNKXcq30m
 BEIUprZGlv8LfmZ+KuDckJNFQMM7XaFcxMZminV7caKTv9TJ1e/mWPs5rLAXLOI/jhGYT
 lY+FsfjrlqQIh9S24L81SrNtc00/SFAkAozcYuDOOA52WtBZnKZL6OsdWTPXeIwUmYJWQ
 PUd5E5u/w6Jd3KoPyCg3Y4p78uBq/UfJb4QmWPWFEd8oI3LSFeWiVAG180JdbBjZzJ7ag
 xte/Br2H+1XhxRKPneRyitMsIoGOrwCPsAvnGr2Xww31IBkzgNzXn9B7t+Re31FnVbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=agnAMZ1w; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=agnAMZ1w
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC8F340E1E
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790214264; x=1821750264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qqZE9cifBBK6o12crSMIFMl/99U+obWYg22OA+l7iyk=;
 b=agnAMZ1wrnQuaXM9eQLwFHoxQ5QCsKvFm6ZujyqRcUo9JX6j4ull7b56
 JCBdVCTwQPPgUcH16YxE6Hwz6vKYpNIZukaA5HoWqzfbV2aySAV0q2YXc
 UlzuJuIlB36pBspbjj484KwYOgZTPDnCvTRtDLJtM3801ACX9Dht21eAP 4=;
X-CSE-ConnectionGUID: aq24P1HsR+yxEPWtlgI9Wg==
X-CSE-MsgGUID: J1BR/F8YR0GziQ/s0K/sjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="180474812"
X-IronPort-AV: E=Sophos;i="6.27,119,1787004000"; d="scan'208";a="180474812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:44:20 +0200
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 03:44:19 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 03:44:19 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Thu, 24 Sep 2026 03:44:19 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <jim.t90615@gmail.com>, <JJLIU0@nuvoton.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <dhphadke@microsoft.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <yschu@nuvoton.com>
Subject: RE: [PATCH 1/2] mtd: spi-nor-ids: add Winbond W25Q02RV
Thread-Topic: [PATCH 1/2] mtd: spi-nor-ids: add Winbond W25Q02RV
Thread-Index: AQHdRxg+JQZY1T8k90Gs8j8EuGkY4Lbc+fIg
Date: Thu, 24 Sep 2026 01:44:19 +0000
Message-ID: <d43b9d647d3741049db4f5a711a368d2@infineon.com>
References: <20260918024800.1838414-1-JJLIU0@nuvoton.com>
In-Reply-To: <20260918024800.1838414-1-JJLIU0@nuvoton.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> Add the 256MB W25Q02RV (JEDEC ID 0xef4022) to the SPI NOR ID table.
>=20

I searched and found the datasheet [1], please confirm it's correct.
If it is, please give a Link: tag followed by the URL.

> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 31a2ba49a87..3e7096bd419 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -633,6 +633,11 @@ const struct flash_info spi_nor_ids[] =3D {
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
> +       {
> +               INFO("w25q02rv", 0xef4022, 0, 64 * 1024, 4096,

Per datasheet, W25Q02RV has ID variants, 0xef4022 and 0xef7022 for differen=
t
part number suffixes, -M and -Q/N. The name needs to contain suffix.

> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

Did you test locking feature?
The chip has 4-bit BP but current u-boot doesn't support it.

Thanks,
Takahiro

> +       },
>         {
>                 INFO("w25q01jvfim", 0xef7021, 0, 64 * 1024, 2048,
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> --
> 2.34.1

[1] https://www.winbond.com/hq/support/documentation/downloadV2022.jsp?__lo=
cale=3Den&xmlPath=3D/support/resources/.content/item/DA00-W25Q51RV.html&lev=
el=3D1
