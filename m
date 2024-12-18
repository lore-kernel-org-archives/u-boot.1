Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8938EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFD1802B4;
	Wed, 18 Dec 2024 13:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gvRdmWq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7962B802EF; Wed, 18 Dec 2024 10:30:41 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A8C80288
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9UbQb4102803
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 03:30:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734514237;
 bh=fqOFlC6Z4+jahS6uOtRWDVgydfGg+cy0IIH1S3+4x1w=;
 h=From:To:CC:Subject:Date;
 b=gvRdmWq3QxQxDxwuwftPqQnuI+hxL30PldC4nVTEIbWroBO4i6TV7UWSM4AXr4k5x
 KTP0cCMO/VBuAAwdfBaGDW002DlbTWabI3BZc29fWrAuFltE2RL4Shr+k/0oQn/qP8
 Dj+e1VmYmIC+c1FShXeNIOy7oduSA/x6OSKIC4S8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9UbCM064857
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 03:30:37 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 03:30:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 03:30:30 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI9USGE060685;
 Wed, 18 Dec 2024 03:30:28 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH 0/3] Add fdt-fixups for AM62P variants
Date: Wed, 18 Dec 2024 15:00:22 +0530
Message-ID: <20241218093025.45701-1-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 18 Dec 2024 13:47:15 +0100
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

This series implements fdt fixups, by reading hardware
information from registers and accordingly delete/modify
the DT nodes, at run-time.

Logs for AM62P boot:
https://gist.github.com/itsme-aparna/b889fe59882c1acf0ef25a644bd325c4

Aparna Patra (3):
  arm: mach-k3: am62p: Fixup CPU core, CAN-FD and Video-codec nodes in
    fdt
  arm: mach-k3: am62p: Fixup thermal zone critical points
  arm: mach-k3: am62p: Fixup a53 max cpu frequency by speed-grade

 arch/arm/mach-k3/am62px/am62p5_fdt.c          | 83 +++++++++++++++++++
 .../arm/mach-k3/include/mach/am62p_hardware.h | 65 +++++++++++++++
 2 files changed, 148 insertions(+)


base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
-- 
2.34.1

