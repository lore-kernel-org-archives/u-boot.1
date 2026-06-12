Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00360CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181D184981;
	Fri, 12 Jun 2026 14:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="kAa2uGQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CFC839A8; Fri, 12 Jun 2026 11:00:07 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C769D8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781254804; x=1812790804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3wAlVtArSgkr+3c0DLA2T3uIWUNQx/+RJqmKz35at5Y=;
 b=kAa2uGQtCCocTZPDDW+eBB5qtBjdC1+tAePHiqgFSYSwRi10il9dIPZo
 H5XdMT8CBRUhKwkdQGqBjk9bpbDuCEmLyU1iB0InmCpzDW3nKXaW4F0m4
 wQBy7S2WbaU+p7hBj5gwr2hsBJCaELqWDFACIAVb3+L59gATMN3/mgvma U=;
X-CSE-ConnectionGUID: dEzX6QoUSIW8gCVptyB4oQ==
X-CSE-MsgGUID: OOtu7rW1RR2vxFe76TTutg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="147006668"
X-IronPort-AV: E=Sophos;i="6.24,200,1774306800"; d="scan'208";a="147006668"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 11:00:03 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 11:00:03 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE815.infineon.com
 (172.23.29.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 11:00:03 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 12 Jun 2026 11:00:03 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v5 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Thread-Topic: [PATCH v5 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Thread-Index: AQHc+XpLskzdXaUb/Uq70S0lcT/TKLY6oIng
Date: Fri, 12 Jun 2026 09:00:03 +0000
Message-ID: <a9442d6a6a3f4b968c2a1df3d000978d@infineon.com>
References: <cover.1781164951.git.weijie.gao@mediatek.com>
 <943ea3c862a19365aab4d45e0a669eab4b37f63a.1781164951.git.weijie.gao@mediatek.com>
In-Reply-To: <943ea3c862a19365aab4d45e0a669eab4b37f63a.1781164951.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

> W25Q256JV-M/W25Q512JV-M are 256Mb/512Mb flash devices with Quad interface=
 at
> max 104MHz clock rate. DTR is not supported.
> These flashes supports 2.7-3.6V voltage range.
>=20
> Both tested on MediaTek's filogic platform.
>=20
> Link: https://www.winbond.com/resource-files/W25Q256JV%20DTR%20RevK%20102=
02025%20Plus.pdf
> Link: https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%20062=
92020%20133.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

