Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCB2C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF8C849A4;
	Mon,  6 Jul 2026 07:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="KtCaoUJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7408846B4; Mon,  6 Jul 2026 03:51:39 +0200 (CEST)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B23184105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 03:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1783302697; x=1814838697;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eMbJPChMDi6Dxp8kvPc1Ymx0cH55DNuB7IgW99kU1MM=;
 b=KtCaoUJy0LnqxH15gJdbc0oHennrhrjss4lshFAuUFG8UW5X1uace/SP
 Ku/jXTILyCILv3o7qUV0ADiXiUOfETBkv3dYo7d4rmSxCb0a6WdWV3Vrv
 LZKI6m8emfPZZPyw75MUly/3wnVMcEKoPt5RGbj0ju3goBD92Q6HrO6Ig I=;
X-CSE-ConnectionGUID: 0uZhPeBVTtCvMNVQuXoOYQ==
X-CSE-MsgGUID: CLpLaFOTQWCc6gfgGNYtnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="136774802"
X-IronPort-AV: E=Sophos;i="6.25,149,1779141600"; d="scan'208";a="136774802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 03:51:36 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 03:51:36 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 03:51:36 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Mon, 6 Jul 2026 03:51:36 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <trini@konsulko.com>
CC: <ssunkkan@gmail.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Topic: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Index: AQHc/APmUW/o4KdHWESmEKE4zUuI/rZbiSfQgABJBgCABAjSsA==
Date: Mon, 6 Jul 2026 01:51:36 +0000
Message-ID: <46c1d75fd52e4eefa971608af8ff6ead@infineon.com>
References: <20260614134406.542-1-ssunkkan@gmail.com>
 <5787d9d649b34f74b66a56a067da9760@infineon.com>
 <20260703141140.GI749385@bill-the-cat>
In-Reply-To: <20260703141140.GI749385@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
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

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, July 3, 2026 11:12 PM
> To: Kuwano Takahiro (ATV MS MPL PAE - MS) <Takahiro.Kuwano@infineon.com>
> Cc: ssunkkan@gmail.com; vigneshr@ti.com; u-boot@lists.denx.de
> Subject: Re: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
>=20
> On Fri, Jul 03, 2026 at 08:11:48AM +0000, Takahiro.Kuwano@infineon.com wr=
ote:
> > Hi,
> >
> > > Add support for dosilicon ds25q4bb (256M-bit) SPI NOR flash.
> > >
> > > Datasheet:
> > > https://drive.google.com/file/d/17UFJa5_3imH0YmWlRGTQYhO2JBXf4Klk/vie=
w
> >
> > Do you have a link to vendor's site? If you have, use Link: tag just ab=
ove
> > your Signed-off-by: tag. If not, please write this after the '---' sepa=
rator.
> > I don't think it's good to add a link to share drive in commit descript=
ion.
>=20
> Yes, this is not a good idea, we need a link to the vendor, somewhere.
>=20
> > > Signed-off-by: Ssunk <ssunkkan@gmail.com>
> >
> > Could you sign with full name?
>=20
> Just like the linux kernel, we don't have a "full name" policy anymore,
> so this part is fine.

Well noted with thanks.

Takahiro

