Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D26DC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 15:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8ED87E11;
	Tue, 30 Jan 2024 16:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rJUljq/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBC987E1D; Tue, 30 Jan 2024 16:00:12 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD7487D5A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 16:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UF07qq012092;
 Tue, 30 Jan 2024 09:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706626807;
 bh=4xYNf+TFPSOOVIy/+EKYytIgbAAnBUr7TjfjlHNdheY=;
 h=From:To:CC:Subject:Date;
 b=rJUljq/Udjzo+GS3Lxwnu1+Fvlg3OBsTAnj/nRsggpSnfGQ1iToCP0h7dnCuywkO3
 OCk5wJ/RYhiW+q9XHnhxOvhb7zvAhvdKB9D8D8XM9J+PMm6Vy2uP7ct21smBEt1LU1
 oIe05CD8o0xt9XfoJ4VOjmiPaCn/TvLFPg1kLPrk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UF07WG015238
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 09:00:07 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 09:00:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 09:00:07 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UF04US014959;
 Tue, 30 Jan 2024 09:00:05 -0600
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH V5 0/2] firmware: ti_sci: zero the secure_hdr in do_xfer
Date: Tue, 30 Jan 2024 20:29:57 +0530
Message-ID: <20240130145959.879882-1-d-gole@ti.com>
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

This series adds a fix to make the initial 4 bytes of the secure_hdr to be 0 as per the protocol requirement as of now.
Also, inorder to provide a little more context to people add a comment to explain why secure calls are made from uboot

For context, please refer to the discussion from the first patch here:
https://lore.kernel.org/all/20240124101558.184411-1-d-gole@ti.com/

Boot tested for sanity on AM62x SK and J721S2:
https://gist.github.com/DhruvaG2000/9ca35d1261e8b30f1c2d4a514b9cd941

Changelog:

v4 --> v5
Pick Nishanth's review and also s/sizeof(var)/sizeof(*var) in 1/2

v3 --> v4
Improve commit message in 1/2 and add comment in 2/2

v2 --> v3
Address Kamlesh's comment on v2: use sizeof(struct ti_sci_secure_msg_hdr)

v1 --> v2
Rebased on top of latest master branch

Cc: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neha Francis <n-francis@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Andrew Davis <afd@ti.com>

Dhruva Gole (2):
  firmware: ti_sci: fix the secure_hdr in do_xfer
  firmware: ti_sci: Add comment explaining the is_secure code

 drivers/firmware/ti_sci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


base-commit: d5c0c990c3128401810514c66b41b386096d206e
prerequisite-patch-id: 2ed0c527b6ebf850744d9ff0eca0300a125f7796
-- 
2.34.1

