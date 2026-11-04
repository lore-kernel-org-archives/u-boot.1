Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C908606A330
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nPoUKD14;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=Mn7T93m5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3B184076E;
	Thu,  5 Nov 2026 05:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrXuGM5Iyojp; Thu,  5 Nov 2026 05:42:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11D0940748
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793857323;
	b=tFXovdqgdfAsYdbfycS1XHfTDNG3hvB1uOt1sHa0GYjh0NSeGtIv2CvsURScgjD+0C4U
	 IKOJIgnoU/ZH8heyR6alrX8D90Z5PmyYyEE4cn3E0GmtJ01rjC2fOjER0nJ6ZXEXKTIF/
	 Y1wPyL8xi55eUs4MyI2/UFP3CfY25BG+w4fhFDTflYPMHN/QhGl8pwQ2z7EivPHeSrIc1
	 EeJWglmO4X2engs8ft/3KIqaXc+wxoCMe58zAALhDA01BSKotUG2nLfjbifsx+dK9cmao
	 g05tNeFbPfpdUiYSoh5bycEbGZVfnrV+LMf6D6ojzvDlE8xnWzadd2r2Ai25qOnfw2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793857323;
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
	bh=3Lq5RFkP39//Q7XX9Ba54M/ytAndYfYe/Zl0brRWyW4=;
	b=WBOvbUhnd/pOAuIH1Cotz/q4hrk1BJYit7FkN+7o47QgeTM26rsnjNCesJkH01pnE/LB
	 UyBou5sFZkPceWsJw+JwbYITg8DDq3iEnmhKlCjddVtB3cEcYty58nbqNDCa0ryWzVt33
	 kHtNNL9Q8a+iyriVkM5bChJ8KxHk0aUWen3CtJs+JN6NCAFUU7BgV2XYrOJKRFz8/fpGJ
	 PrpGuj/R41Mi5P5m3gIPhT0XYIQGorvLVr7gRxMJn9BhNJanh6Exi2bDoBI8yeW6piRPM
	 w5T529/aiSFIf39ZDCHc5aUeP4EPE8ptfwUxhVmA4NgY+IUSk6W28YTW+EamQvfR+Cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793857323;
	bh=3Lq5RFkP39//Q7XX9Ba54M/ytAndYfYe/Zl0brRWyW4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPoUKD14aCxtJHWtoU+2+v8Kaku80XEDwH+GmjEBpG4SOZEl+LGtF2BgfApcSunjB
	 F4b1Afe7e1OGIEqa+/hDYe8A66NRVWkC/op+r/qHynudYQp02fmrWdqjNWPVVlkXhm
	 UXcnBYvV/xP4FWsQLw4ZPIFKTV39cl7kRhww85rCd0KqKpAr55btYTgsuB5vM5qo0I
	 6hiSa6pLe7ho+z4da+LX2plZvh7FZ3CAY8kmvsibVyknzrbwUcwXVTUeklbvMEdX5k
	 //BznlPnbX3cJ5CHI0zSBD7bDmZ57Xwo0Jbk2l6pRX8C83kym/qp1YcqDDTVmLrm4R
	 Iu5v9bej0GheA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11D0940748;
	Thu,  5 Nov 2026 05:42:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F818362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C9B381184
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUGSn0kJ_G_X for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 23:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED3378117A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.10.52.204
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.10.52.204;
 helo=smtp9.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=Mn7T93m5
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED3378117A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793836361; x=1825372361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3Lq5RFkP39//Q7XX9Ba54M/ytAndYfYe/Zl0brRWyW4=;
 b=Mn7T93m5EoodyUbbLy1qxp78DfFiZZrfjaupMSUmg1MB+8E6QIPYCYzN
 aFN0Fh2FgqEb/dzPzDVrXBJZrhfE3zggyB+LdeIcNhp+r+Hvhmjhr5PIY
 /A19V+//Na/wSBVUzg5YzxNY4z6xAOYTcqlaZyl3P7yIyvQiV7vhoOgIE 4=;
X-CSE-ConnectionGUID: Ij74yUfdQwm/SVrRIF016g==
X-CSE-MsgGUID: FlKds4JTQA60ojpsL2K5DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="116492664"
X-IronPort-AV: E=Sophos;i="6.27,196,1787004000"; d="scan'208";a="116492664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:48:37 +0100
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 00:48:37 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 00:48:36 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Thu, 5 Nov 2026 00:48:36 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <oss.patchbox@gmail.com>, <vigneshr@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
Subject: RE: [PATCH] mtd: spi-nor: Don't let clean_bar() overwrite read/write
 errors
Thread-Topic: [PATCH] mtd: spi-nor: Don't let clean_bar() overwrite read/write
 errors
Thread-Index: AQHdanpum56JNC/450OisPXniqpYJLcemExQ
Date: Wed, 4 Nov 2026 23:48:36 +0000
Message-ID: <11cdc940358344068869aefad012fd42@infineon.com>
References: <20261102032950.305343-1-oss.patchbox@gmail.com>
In-Reply-To: <20261102032950.305343-1-oss.patchbox@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2026 05:42:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> With SPI_FLASH_BAR enabled, spi_nor_read() and spi_nor_write() call
> clean_bar() at their common exit label and assign its return value to
> ret. This is also done on the error paths, so an error from
> nor->read(), nor->write() or spi_nor_wait_till_ready() is replaced by
> the result of clean_bar(), which is 0 when the bank register is already
> 0 or was reset successfully. The caller then gets 0 back for a read or
> write that did not complete.
>=20
> Only use the result of clean_bar() when no earlier error occurred, as
> was done for spi_nor_erase() in commit a9d9d412e00e ("mtd: spi-nor-core:
> Don't overwrite return value if it is non-zero").
>=20
> Fixes: 8c927809ea96 ("mtd: spi: spi-nor-core: Add back U-Boot specific fe=
atures")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Tested on sandbox with SPI_FLASH_BAR=3Dy and the emulated m25p16, using
> gdb to make spi_nor_read_data() and spi_nor_write_data() return -EIO
> after the probe. Without this patch 'sf read' and 'sf write' print OK;
> with it they print ERROR -5. 'ut dm spi_flash' and
> 'ut dm spi_flash_func' pass, and a normal erase/write/read/compare
> still works. Not tested on hardware.
>=20

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

