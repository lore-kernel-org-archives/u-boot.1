Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD0FC83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACCD48654B;
	Tue,  5 Sep 2023 10:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CLpQBWbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB008691E; Tue,  5 Sep 2023 10:21:49 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD08B8643D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3858LhuS029406;
 Tue, 5 Sep 2023 03:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693902103;
 bh=Vf2jeAM9GFdpNQZhtW+2+nuFA9ctbfidUe0m9wDT0bA=;
 h=From:Subject:Date:To:CC;
 b=CLpQBWbVYVWecI8toBotwSHI29mpu6ygOd2ofwj/JXAC7Wq+xR+yxwMyeVW+9oA+C
 thZGKI3/Me+lXgosfe9VzdP8wPoIwD0C9jnyiZp1TyBCV/d7xLDaGC0HaCKHfpBPk0
 Yi7r2sUkc3L1+nrz8p5n7waD4A4PaV4xNkTi1dCE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3858Lhqx013994
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 03:21:43 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 03:21:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 03:21:42 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3858LdLg016284;
 Tue, 5 Sep 2023 03:21:39 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [RFC PATCH 0/2] RFC version for ATF and OP-TEE Firewalling
Date: Tue, 5 Sep 2023 13:51:33 +0530
Message-ID: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3l9mQC/x2NQQrCMBBFr1Jm7UhMq4JbwQO4FReTdNoO1ElJo
 hZK727j8sF/7y+QOAonuFQLRP5IkqAbHHYV+IG0Z5R2Y7DG1uZsG3SiL1LsJPKXxlG0x9ORfet
 szd4QbKKjxOgiqR+KmgXf6ELIWCJ706DynMtwitzJ/H9/wP12hee6/gBi83O4kgAAAA==
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693902099; l=830;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=gxaPBTgRMOkSC3Bt8H1PZ6xyEbKuUJoYwjv1HVXU4KY=;
 b=bIjDoURQOfrR8wYZPFVtP6FeiPY+cbjeeDbfJJ4Y4NOJqgYwHZFyeRbxrewylYXOTcXSXECdI
 bp/o2lG8EY1AC1tdEczJdD7+YUs8QUSE5XTG2aF9Pva1dGhLHbVBLCR
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This is a start to firewall ATF and OP-TEE memory regions using the
firewalls present in K3 SoCs. Please give reviews as to what can be
better in the implementation.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (2):
      binman: ti-secure: Add support for firewalling entities
      binman: j721e: Add firewall configurations for atf

 arch/arm/dts/k3-j721e-binman.dtsi | 161 ++++++++++++++++++++++++++++++++++++++
 tools/binman/btool/openssl.py     |  16 +++-
 tools/binman/etype/ti_secure.py   |  54 +++++++++++++
 tools/binman/etype/x509_cert.py   |   3 +-
 4 files changed, 231 insertions(+), 3 deletions(-)
---
base-commit: 321d7b4d875a77552a969dd6ea5bbed2644fcb0c
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

