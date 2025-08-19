Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD1CCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B52382C84;
	Tue, 19 Aug 2025 09:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rZfVJ9aY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99B6802C1; Tue, 19 Aug 2025 09:33:49 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE5F829F5
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57J7XcSZ2902073;
 Tue, 19 Aug 2025 02:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755588818;
 bh=Mg+Jg5KM+s12DoNIzN+yZK+VMrza2sMoVEOWHjBDbCc=;
 h=From:Subject:Date:To:CC;
 b=rZfVJ9aYahp8VSZmLinRANT6lwvRmzpnWgn2v7hdJYCyRTjkJojOpz5GU+DJ3g/hx
 4SYCLPBiRxYe8AaMLeVYdCYtcNQDrZmfdPPEe5fC2gViKZlqwwTSeWKj4vOs511scS
 fSgI+ZSYwd1yXryql0HLn4ijBhDnB3X9lZnBHEtU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57J7Xcru229466
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 19 Aug 2025 02:33:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 02:33:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 02:33:38 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57J7XbJq2638516;
 Tue, 19 Aug 2025 02:33:38 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v3 0/2] Add compatibility for scmi clock protocol version 3.0
Date: Tue, 19 Aug 2025 13:03:25 +0530
Message-ID: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUopGgC/22MQQrCMBBFr1JmbSSZtDS68h7iokkmdhZtJSlBK
 b27aReiIPzN+/DeAokiU4JztUCkzImnsYA+VOD6bryTYF8YUGIjjdLC1iK5gUVWwmpP1rShaxV
 CER6RAj/32PVWuOc0T/G1t7Pa3r+ZMiksBZTBafS1vcx8dNMAWyPjt2d+PCweSd0oV3ujT/Tx1
 nV9A2JnLc7ZAAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755588816; l=1256;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=iXX8Hzv7bG7DWCUs2LaWj1YqnB3c13Z/3tGQ2nSd7KA=;
 b=16MJdFe6R2EQY/ckjYSq1f+i47QNkAuCHkeCuH824JivG76EatGay8ROSM2MKKljPVE//lw6c
 7qz1KMTVKpyCvn5fJgZFFJ72q/uBBtpOEIwr7MjNBOA/AXXapS54uT6
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Clock version 3.0 specified in ARM SCMI Platform design document
v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.

The SCMI server with clock version 3.0 rejects the message if
it doesn't have this field.

Add support so that both SCMI server with clock version 2.0 and 3.0
can be handled.

While at it, fix the set_parent support for non CCF flow.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v3:
- Removed a checkpatch warning, which helped avoid reuse of code
- Link to v2: https://lore.kernel.org/r/20250818-b4-scmi-v1-v2-0-e0351c4d839e@ti.com

Changes in v2:
- Fixed the code according to review comments
- Link to v1: https://lore.kernel.org/r/20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com

---
Kamlesh Gurudasani (2):
      clk: scmi: fix set_parent support when CCF is not being used
      clk: scmi: add compatibility for clock version 3.0 and onwards

 drivers/clk/clk_scmi.c   | 45 +++++++++++++++++++++++++++++++--------------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 37 insertions(+), 14 deletions(-)
---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-b4-scmi-v1-b3deb87fa712

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

