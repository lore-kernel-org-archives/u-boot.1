Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E7EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 04:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2864986BA4;
	Mon, 13 Nov 2023 05:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RKNhPRXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B8586BD6; Mon, 13 Nov 2023 05:30:34 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF0986516
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 05:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4URP1101474;
 Sun, 12 Nov 2023 22:30:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699849827;
 bh=Dc1WR+Fyw8RoMMQGZgoJUEbgA987EMySEKrnjDE20MU=;
 h=From:To:CC:Subject:Date;
 b=RKNhPRXvaSYn3e4+PR0DzY1ESM49u3VcHoXk6vePK1wM8PuTpyjUfyubBPZ4I7D4g
 zB1CTYzSS5IUp1RflLjjZXPNoKSvH8Fsz0rbdwBculGBFgS4UZq5W4oWjdP/jgIY1h
 Xzx3auNryAnNf+oG0tnbV7pJESI7JW9HSDDV4uE4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AD4URCX020513
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 12 Nov 2023 22:30:27 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 Nov 2023 22:30:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 Nov 2023 22:30:27 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4UOX5119664;
 Sun, 12 Nov 2023 22:30:24 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/2] J721E DTS Sync with Kernel v6.7-rc1
Date: Mon, 13 Nov 2023 10:00:21 +0530
Message-ID: <20231113043023.2126690-1-n-francis@ti.com>
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

This series aims to sync kernel.org v6.7-rc1 DTS with that of U-Boot. It
also includes inclusion of an updated devicetree documentation for
ti,j721e-esm.

Boot logs:
https://gist.github.com/nehamalcom/0eef30308f1910eea5eafefe2c4b7bcf

Neha Malcom Francis (2):
  dt-bindings: misc: Move esm-k3.txt to ti,j721e-esm.yaml
  arm: dts: k3-j721e-*: Sync with kernel v6.7-rc1

 arch/arm/dts/k3-j721e-main.dtsi               |  2 +-
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  9 +++-
 doc/device-tree-bindings/misc/esm-k3.txt      | 25 ---------
 .../misc/ti,j721e-esm.yaml                    | 53 +++++++++++++++++++
 4 files changed, 62 insertions(+), 27 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/esm-k3.txt
 create mode 100644 doc/device-tree-bindings/misc/ti,j721e-esm.yaml

-- 
2.34.1

