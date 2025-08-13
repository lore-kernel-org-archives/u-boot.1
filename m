Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B1DC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3876A829E7;
	Wed, 13 Aug 2025 15:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i3vEGTJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580558338D; Wed, 13 Aug 2025 12:30:00 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A769829E7
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DATnSH2130061;
 Wed, 13 Aug 2025 05:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755080989;
 bh=PkzECAPZeCj/JXwbV3utlp9o0Wg/IJJPLJwyIYW4jSQ=;
 h=From:Subject:Date:To:CC;
 b=i3vEGTJunqstkpSV5GSoLxcmYrzWPSiIIQyzMX71uOEVWqiDXo9v7BsjzeOC8JN+z
 4bFmIx9X8ENQD4U2WqMEUBnM03SfR5aWc6OkeicUD7y/cAEv+0IMvY16neJNHmnQfV
 okj4b8n/XwFaGQe0U+Y4Pnia6xfPB8NKe/2V2bgQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DATn5J4185787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 13 Aug 2025 05:29:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 05:29:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 05:29:48 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DATlZs2165819;
 Wed, 13 Aug 2025 05:29:48 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH 0/2] Add compatibility for scmi clock protocol version 3.0
Date: Wed, 13 Aug 2025 15:59:34 +0530
Message-ID: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5pnGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3SQT3eLk3EzdMkPdJOOU1CQL87REc0MjJaCGgqLUtMwKsGHRsbW
 1ALHYx2VcAAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755080986; l=936;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=8n/UAGvuSkJLOBUxlliH8uqr6t32kgmtn90ajW7VQ5w=;
 b=5oRTM5ASTRbk2DquxhbLVuMhkXtHLnBlo55zSkAzL0JQ5d2TP3LoTOyePU1peZ1nLP2e1oX3s
 sZrk3DJc9xlBfUXGzKax21KcfpiQB45qKnILvKooi2Bp5k+S23zKlBf
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 13 Aug 2025 15:10:42 +0200
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
Kamlesh Gurudasani (2):
      clk: scmi: fix set_parent support when CCF is not being used
      clk: scmi: add compatibility for clock version 3.0 and onwards

 drivers/clk/clk_scmi.c   | 51 +++++++++++++++++++++++++++++++++++++++------------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 45 insertions(+), 12 deletions(-)
---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-b4-scmi-v1-b3deb87fa712

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

