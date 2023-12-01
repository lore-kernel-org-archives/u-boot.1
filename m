Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DCC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CE087638;
	Fri,  1 Dec 2023 11:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S5h2CLZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766DC87638; Fri,  1 Dec 2023 11:30:19 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F09587083
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AUDJP027211;
 Fri, 1 Dec 2023 04:30:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701426613;
 bh=FkXTAGH29SCw1uYIjRhScLU64eCX3errEWcB5ig1gyo=;
 h=From:To:CC:Subject:Date;
 b=S5h2CLZChzDc/CvNGilu3Egt5djyErQmjgCljLR5D9WUWkKqriG93QhUevJPAjsqx
 noe+HjB4b7ZfEMboKLZZPoFI5vKvfjcA/W65pVNQihA8/07LqYZZRWw7LkOzc6w+B5
 a9HI9J+Iy4N4XJXoXolrjzrQGMHU1TINUBXP1oDU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1AUDfH096212
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 04:30:13 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 04:30:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 04:30:13 -0600
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AUA7T078636;
 Fri, 1 Dec 2023 04:30:10 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole
 <d-gole@ti.com>, <nm@ti.com>, Kamlesh <kamlesh@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH 0/2] docs: AM62x: Remove SW_PRNG Flag for OPTEE
Date: Fri, 1 Dec 2023 15:59:52 +0530
Message-ID: <20231201102954.47582-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The CFG_WITH_SOFTWARE_PRNG option was needed once when there were some
issues with system crashes/ hangs after a suspend-resume cycle. However
this seems to no longer be the case with newer firmwares, and this
config is not needed for basic boot support of the SoC either, hence
remove it from the docs.

Cc: Kamlesh <kamlesh@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Dhruva Gole (2):
  doc: board: beagle: am62x_beagleplay: Delete SW_PRNG flag for OPTEE
  doc: board: ti: am62x_sk: Remove SW_PRNG Flag for OPTEE

 doc/board/beagle/am62x_beagleplay.rst | 1 -
 doc/board/ti/am62x_sk.rst             | 1 -
 2 files changed, 2 deletions(-)

-- 
2.34.1

