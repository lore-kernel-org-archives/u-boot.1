Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE10CE7A88
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 10:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6FE864D7;
	Sun, 24 Sep 2023 12:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kNq2MDiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F43A8656B; Sun, 24 Sep 2023 12:36:03 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318D986488
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38OAZvep015413
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 05:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695551757;
 bh=rrzlM/HazLnjQJnp8tLejv0paVPcRFfFcQG0iZH6Ce0=;
 h=From:To:CC:Subject:Date;
 b=kNq2MDiXAd6ozOkn9us5q7m5h7CK4HQAy1dFsaIKM/FlCW37ajyNW7WKjWPml7iLL
 ADGB8FEjzwTC4uHUO49GBxaalvfZF133l8PSiHB1p7mymNCMfVetJfdQOPBeFNI9i5
 vNMMIOUqfnhVDu0w635PpdDO0uxa5TRGQVrG6dig=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38OAZv7p075979
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 05:35:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Sep 2023 05:35:57 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Sun, 24 Sep 2023 05:35:57 -0500
From: "Kumar, Udit" <u-kumar1@ti.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>, "Anna, Suman" <s-anna@ti.com>,
 "Kumar, Udit" <u-kumar1@ti.com>
Subject: Looking for suggestion on using above 4G memory on ARM64
Thread-Topic: Looking for suggestion on using above 4G memory on ARM64
Thread-Index: Adnu0nb8gc4t/MwNTuSRX/cO6R8GaA==
Date: Sun, 24 Sep 2023 10:35:57 +0000
Message-ID: <555161078c764ca8a112f859a42927e2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.141.75]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Dear Experts,
=20
I am looking for suggestion/guidance, how to use above 4G memory on in u-bo=
ot for ARM 64-bit based architecture.=20

On our system, we have low memory from=20
0x8000_0000 to 0xFFFF_FFFF and above 4G
0x8_8000_0000 to 0x8_FFFF_FFFF

As per my understanding, we have following pointers in u-boot=20
ram_base,  ram_top , ram_size=20

If I keep, above this variables within low memory=20
ie.  ram_base =3D 0x8000_0000,  ram_top =3D 0x1_0000_0000,  ram_size =3D 0x=
1_0000_0000=20
boot is successful, but when I am moving to high memory like=20

ram_base =3D 0x8000_0000, ram_top =3D 0x9_0000_0000, ram_size =3D 0x2_0000_=
0000
boot is failing while reallocation for obvious reasons,

Question, I have for which I am looking for advise .
If memory is divided in into two zones, then how we can fit memory using ab=
ove three variables. =20
Or is there some other config, which I am missing.=20

Many Thanks=20
Udit=20

P.S. :I noticed few other ARM64 arch restrict gd->ram_top to 0x1_0000_0000
