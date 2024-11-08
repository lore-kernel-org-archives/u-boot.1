Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E0D5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953F889242;
	Fri,  8 Nov 2024 14:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=fr.thalesgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=fr.thalesgroup.com header.i=@fr.thalesgroup.com header.b="WO8GZCY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A0D88FD0; Fri,  8 Nov 2024 11:35:39 +0100 (CET)
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com
 [23.90.122.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFDC88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fr.thalesgroup.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christophe.lindheimer@fr.thalesgroup.com
X-CSE-ConnectionGUID: y1B/MnhbRduT+jLnx3Ydzw==
X-CSE-MsgGUID: szdKtZWKTLC7w63a+oZkvA==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com;
 dkim=pass (signature verified)
 header.i=@fr.thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="22184582"
X-IronPort-AV: E=Sophos;i="6.12,137,1728943200"; d="scan'208,217";a="22184582"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fr.thalesgroup.com; i=@fr.thalesgroup.com;
 s=bbmfo20230504; t=1731062137;
 h=from:to:subject:date:message-id:mime-version;
 bh=azKK5E7oCqFzBYDKIYKxCUdbtrEzWiT1sZfwBlTDWSM=;
 b=WO8GZCY313mMPB+syemGVDQzEkRi5I6sYCrSLA0Zc2bZITr+QBINkoz5
 m29HAzAuxJ7gav3xIG7ATdNdLNjIC7V4dArMSC9UNa8uVG43PNG7yKwOT
 OffmmopW+JJg60zyvqnFLYD4WsPWyVRalBcdWmm2+HVMdsbF492WhqRDd
 yibDSaDoaX/cNMxE2K164kG7TP2kgdkPbq7BhM6qD3QfwEArVJU8PPLLU
 L1Ya1S8dS1PLQM1BNi6fWcTchtY4liFyMPtWvv1IT/yi3SwWR4jKfmftG
 xRfZjNErIyNqCAxe5XVIl1kpGx0kdfV4v5viIkPkNFpn+0PUnkWqJdjm8 g==;
X-CSE-ConnectionGUID: VSdrBxgcT0qsWslNXrcUGQ==
X-CSE-MsgGUID: qXdGnGHWRBut67blojx+Dw==
X-CSE-ConnectionGUID: pj1rj4GwQiazAJNNswPudQ==
X-CSE-MsgGUID: GvdZyT9SRxGyI76S8fHVJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34491737"
X-IronPort-AV: E=Sophos;i="6.12,137,1728943200"; d="scan'208,217";a="34491737"
From: LINDHEIMER Christophe <christophe.lindheimer@fr.thalesgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Utilisation of PHY Driver
Thread-Topic: Utilisation of PHY Driver
Thread-Index: AdsxyCzozczgWiW8ScKFDvFNhZ4X3w==
Date: Fri, 8 Nov 2024 10:35:36 +0000
Message-ID: <ddb06fd41edf4822876059af3b641a46@fr.thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-nodisclaimer: 0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

I have started working with UBOOT on a custom board with Ultrascale+.
I am working with UBoot Xilinx Release 2024.1

Using a SD card, I managed to boot Linux and network is OK under Linux

I would like to be able to use network under UBoot

PHY is a marvell 88E1510.
CONFIG_PHY_MARVELL is set and marvell.c is compiled.

In the dts file, I set a compatible marvel 88E1510 entry.
Unfortunately, I get a "Could not get PHY for eth0" when booting.

Adding some trace in marvell.c I see that init function is not called.
I also add some trace in  \drivers\core\root.c and  \drivers\core\lists.c, =
I see that UBoot looks for a compatible driver for the marvell but it does =
not find it.
I have printed all the drivers that are compared in driver_check_compatible=
 and there is no marvell driver.

I have the feeling that only the drivers declared with U_BOOT_DRIVER are sh=
own and not the ones with U_BOOT_PHY_DRIVER.
Is it right ?
If so, how can I register and use the driver for my Marvell PHY ?

Thanks





