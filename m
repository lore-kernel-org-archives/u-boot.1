Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32544C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFD781DDF;
	Sun, 23 Mar 2025 17:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745716;
	bh=Wgc8Wz+VaocT26juYyaFm5lfsyzTOqY83ue4SZPrzuE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k16j8no8zdw+Q5BMdyr4fo9efsh7tbs/rJG5wDIoMH+h7ew6Udb5tulAjJKapuhuM
	 aiisI+uhaOeclJg3GDFZEVPzgiq8rETeAuP+8MY6Vfm6iWNevqoQeo9K5mI3KsFiq9
	 S+DtZSO5S1PJovLtxzomRWIAvQuTgt5AaKWCRQFXXrSeB0wpPd9cEmpOd0dz1T+6k5
	 +TBlDEW8ltsH18FVQHTavXy6oH0JJ1LxB+PtZrCiQMvtVxrkrXfwhpHDqo6KVT1JNO
	 uxqHzb4hMwLFmJMbq2DN+UjAU6XHMglq/ULaA0QSQiznHTYW9et8iwsskg9FSbvGK5
	 O3wN1TwYIHIcA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422E581F71; Sun, 23 Mar 2025 17:01:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D62C81CFD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ssrgp5cb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8AA8D102E64C8; Sun, 23 Mar 2025 17:01:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745711; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Wgc8Wz+VaocT26juYyaFm5lfsyzTOqY83ue4SZPrzuE=;
 b=Ssrgp5cbrZu7lLeOzx8botYSpqiV2F2WZh+xOlPxNTTKa/X//fPWLyDyWyKDkS/uPbK2lE
 QJ0/v4dPVXs0JD7sDW2opCVI6nEk1hB45sRPyMGz4cJ6GZOmn5uFwwtTvrEcJM9NgQ63iV
 GT41WJ+XEt6YJWVni/i6jbp31lapAvboxYm7bJ8V0Aj06/cX3AnwoedI/j4qtBI1eMvb2f
 r/lYOW/KdLhDB+D2+0SXqKgX/J9AQK2zK1QzxLeiRJ9BXod1rGuhc55emCNKnjxmNBRf9R
 OYRxuoF29rQocnrHgUSnkDZHm9rOodWLqrMubDp0g70cgmr3OqxKN52CouLVmQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
Date: Sun, 23 Mar 2025 16:58:29 +0100
Message-ID: <20250323160107.145749-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add clk_resolve_parent_clk() to resolve parent clock udevice name
based on clock-names DT property. This is used in SoC clock drivers
to look up the clock name in clock tables, which matches a clock
name in DT clock-names property, and convert it into udevice name
which is used by U-Boot clock framework to look up parent clock in
e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
parent_name, &parent);

Pass struct udevice pointer through the various iMX clock drivers.

Marek Vasut (24):
  clk: Add clk_resolve_parent_clk()
  clk: clk-mux: Fold clk_register_mux()
  clk: clk-mux: Use struct udevice instead of struct device
  clk: clk-mux: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_mux*()
  clk: imx: Pass struct udevice to clk_register_mux()
  clk: clk-gate: Use struct udevice instead of struct device
  clk: clk-gate: Resolve parent clock by name
  clk: imx: gate2: Use struct udevice instead of struct device
  clk: imx: gate2: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_gate*()
  clk: imx: Pass struct udevice to clk_register_gate*()
  clk: clk-composite: Use struct udevice instead of struct device
  clk: clk-composite: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_composite*()
  clk: imx: Convert clock-osc-* back to osc_*
  clk: imx: Pass struct udevice into imx_clk_pllv3*()
  clk: imx: pllv3: Resolve parent clock by name
  clk: clk-divider: Use struct udevice instead of struct device
  clk: imx: Pass struct udevice into imx_clk_divider*()
  clk: clk-divider: Resolve parent clock by name
  clk: clk-fixed-factor: Use struct udevice instead of struct device
  clk: clk-fixed-factor: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_fixed_factor*()

 drivers/clk/clk-composite.c        |   4 +-
 drivers/clk/clk-divider.c          |   7 +-
 drivers/clk/clk-fixed-factor.c     |   6 +-
 drivers/clk/clk-gate.c             |   5 +-
 drivers/clk/clk-mux.c              |  47 +---
 drivers/clk/clk-uclass.c           |  18 ++
 drivers/clk/imx/clk-composite-8m.c |   4 +-
 drivers/clk/imx/clk-gate2.c        |   5 +-
 drivers/clk/imx/clk-imx6q.c        |  80 +++----
 drivers/clk/imx/clk-imx8mm.c       | 254 +++++++++++----------
 drivers/clk/imx/clk-imx8mn.c       | 246 ++++++++++----------
 drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
 drivers/clk/imx/clk-imx93.c        |   8 +-
 drivers/clk/imx/clk-imxrt1020.c    |  42 ++--
 drivers/clk/imx/clk-imxrt1050.c    |  78 +++----
 drivers/clk/imx/clk-imxrt1170.c    |  30 +--
 drivers/clk/imx/clk-pllv3.c        |   9 +-
 drivers/clk/imx/clk.h              | 116 +++++-----
 include/clk.h                      |   9 +
 include/linux/clk-provider.h       |  10 +-
 21 files changed, 783 insertions(+), 769 deletions(-)

---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com

-- 
2.47.2

