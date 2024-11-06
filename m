Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEC3D29F9D
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 06:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BF388DB1;
	Wed,  6 Nov 2024 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OOiJiKNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF808919A; Wed,  6 Nov 2024 07:39:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C085788A1C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 07:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A66dWMk000399;
 Wed, 6 Nov 2024 00:39:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730875172;
 bh=iKnKrwKuQVWdM21cbZu5iApcpbrvIBxr78TVYQpd5i4=;
 h=From:To:CC:Subject:Date;
 b=OOiJiKNvLm/fMpDFx3b3nhUFGnZJm0ClmGJfhTWP370FAyESLAj5iqzuvpoawJ++7
 etCj0cP/Z5u/4mv3zn+VrgufHYetouTlrYn4iNILPv6VfnO8vVvnvv3uTx8jUKI1hu
 rqZEalYErvGSQIPPbz10pgyz6n4MXl7XHg/IoPfk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A66dW5X008219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Nov 2024 00:39:32 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 00:39:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 00:39:31 -0600
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.218])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A66dUaN129161;
 Wed, 6 Nov 2024 00:39:31 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>,
 <w.egorov@phytec.de>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH 0/4] Add QOS support for J722S and AM62P
Date: Wed, 6 Nov 2024 12:09:26 +0530
Message-ID: <20241106063930.59870-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add QOS support for DSS in TI K3 SoC to route the DSS traffic through
RT queue by setting orderID as 15:
- J722S
- AM62P

Jayesh Choudhary (4):
  arm: mach-k3: j722s: Add QoS support for DSS
  arm: mach-k3: am62p: Add QoS support for DSS
  configs: j722s_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: am62p_evm_r5_defconfig: Enable CONFIG_K3_QOS

 arch/arm/mach-k3/am62px/am62p5_init.c        |  2 +
 arch/arm/mach-k3/j722s/j722s_init.c          |  1 +
 arch/arm/mach-k3/r5/am62px/Makefile          |  1 +
 arch/arm/mach-k3/r5/am62px/am62p_qos.h       | 42 ++++++++++++++
 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c | 58 ++++++++++++++++++++
 arch/arm/mach-k3/r5/j722s/Makefile           |  1 +
 arch/arm/mach-k3/r5/j722s/j722s_qos.h        | 51 +++++++++++++++++
 arch/arm/mach-k3/r5/j722s/j722s_qos_uboot.c  | 58 ++++++++++++++++++++
 configs/am62px_evm_r5_defconfig              |  1 +
 configs/j722s_evm_r5_defconfig               |  1 +
 10 files changed, 216 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos.h
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j722s/j722s_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j722s/j722s_qos_uboot.c

-- 
2.34.1

