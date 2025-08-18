Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF8CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 13:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F28D80FA8;
	Mon, 18 Aug 2025 15:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oHuDCgqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0A7803DF; Mon, 18 Aug 2025 15:20:35 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8550680107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 15:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IDKNeA3171063;
 Mon, 18 Aug 2025 08:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755523223;
 bh=6B0Bi1mFyqwx7wQORcI0KKnbn7QXMsg+pgCPSxlz3c0=;
 h=From:Subject:Date:To:CC;
 b=oHuDCgqvYVtiSTV4OuHP5FeWriWH26G9LL3ZZCq6gi0ckkLzsj4PMIxsIrQTHA6lR
 pTNRXASwZuoTIXdqfirWWmm7lRN5OdcRZ8Cl59W6tleTlKLKitELUEuGvy1kSjednX
 ozWyABntUN3XLxvZmZDBHAEqOfJ0I92YasNaeZLY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IDKNL44040429
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 18 Aug 2025 08:20:23 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 08:20:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 08:20:22 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IDKLLG1360174;
 Mon, 18 Aug 2025 08:20:22 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v2 0/2] Add compatibility for scmi clock protocol version 3.0
Date: Mon, 18 Aug 2025 18:50:17 +0530
Message-ID: <20250818-b4-scmi-v1-v2-0-e0351c4d839e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEoo2gC/22MQQqDMBBFryKz7pRkYlG66j3EhUkmdRaakoi0S
 O7e1HXhb96H9w7InIQz3JsDEu+SJa4V6NKAm6f1ySi+MpCim+q1QdtidovgrtEaz7bvwtRpgiq
 8Egd5n7FhrDxL3mL6nO1d/96/mTqFlgOp4Az51j42ubq4wFhK+QJKfBNBoQAAAA==
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755523221; l=1096;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=NweGVkMaT1vuLNe8LazvUJ61WGqEntXhTPjVIRTbsz0=;
 b=evCHeDyWdy5dzE1ScDqOZQybrsEc2s7abwk4vVipuAK26Zn4oBeaEYYPPaisA7nvG231oTaai
 R42zLWO4gCvCLHd0uFyAV+rTqIHFYYrAuqdvKuZoDvPIqF3X/2f8HoX
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
Changes in v2:
- Fixed the code according to review comments
- Link to v1: https://lore.kernel.org/r/20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com

---
Kamlesh Gurudasani (2):
      clk: scmi: fix set_parent support when CCF is not being used
      clk: scmi: add compatibility for clock version 3.0 and onwards

 drivers/clk/clk_scmi.c   | 55 +++++++++++++++++++++++++++++++++++++++----------------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 45 insertions(+), 16 deletions(-)
---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-b4-scmi-v1-b3deb87fa712

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

