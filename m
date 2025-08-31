Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBBACA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 05:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C6C838C5;
	Sun, 31 Aug 2025 07:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="SkpBNyMQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dq9OMz0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A7883487; Sun, 31 Aug 2025 02:47:56 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B8F83447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 02:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601181; bh=a5OJqycfRFL4ChslnFhgiiV
 lovbRGH7mZcjQZR1jsi0=; b=SkpBNyMQ7tW3gyX87b0DUnUaIf2xE9NovNasZBUcqC8+b2jUlT
 ti2q7sSzHEnfxHnltDsAlsuzrPkij0mXK/gZaS6mDzn8PsmOUzrh5g0eMCl4pfIwECdhFtr+H8o
 vB8sBoQqwraS4NohafuJ0ROTENoK1e2kAxxTcl4C+GFeLqJMynBy4ao6JlHtfATFB6UXVkXKz/z
 EjJ6U7hjDqlELJ3eUW1Flr8bPjt/AWTimtCoF7O9FqNLEc7pJpePDb7OUDi0Ft4IfcAHRNEF2QY
 90xGMj2yq6D30yWYhDnLdvtPrIotW8dTvWcyV/y4sTXFPggi+CIZaDs95EwbdReJ9Og==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601181; bh=a5OJqycfRFL4ChslnFhgiiV
 lovbRGH7mZcjQZR1jsi0=; b=dq9OMz0KxkdG6j5ldBCdkV1ySlbFxJ5bps59KcS9x/x2EAefX9
 bHac6qjJjQ+lXE0vlKPXnI6TwsBYbhu0IRCQ==;
From: Jens Reidel <adrian@mainlining.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Jens Reidel <adrian@mainlining.org>
Subject: [PATCH 0/4] Bringup of SM7150 SoC
Date: Sun, 31 Aug 2025 02:45:58 +0200
Message-ID: <20250831004602.699953-1-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Aug 2025 07:09:14 +0200
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

This series adds a clock and pinctrl driver for the Qualcomm SM7150 SoC
and enables support for the SoC in the UFS driver.

The other necessary bits are part of Luca's SM6350 series [1] or were sent
separately.

All the drivers sent here are upstream in Linux already, however the
devicetrees aren't yet, but that shouldn't be a blocker for including
these drivers in U-Boot.

Tested on a couple of different Xiaomi devices, the Google Pixel 4a and
the Samsung Galaxy A71.

[1]: https://lore.kernel.org/u-boot/20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com/

Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
Danila Tikhonov (4):
  clk/qcom: add driver for SM7150 GCC
  pinctrl: qcom: add SM7150 pinctrl driver
  phy: qcom-qmp-ufs: Import SM7150 tables from Linux
  configs: qcom_defconfig: Enable SM7150 GCC and Pinctrl

 configs/qcom_defconfig                |   2 +
 drivers/clk/qcom/Kconfig              |   8 +
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-sm7150.c       | 250 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |  61 +++++++
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm7150.c | 142 +++++++++++++++
 8 files changed, 472 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sm7150.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm7150.c

-- 
2.51.0

