Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367B4C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEEA284B96;
	Mon, 13 Jul 2026 15:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="W4MeehYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F3A84B93; Mon, 13 Jul 2026 15:30:52 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2346F84BB8
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=ch1DqgGUQd2daIdLkymfP9PNeQQhycXWaPIIcNadmJQ=; b=W4MeehYQqxpGhm49hEiAIyrzku
 u3p7H7MGAt4O1QAApacRgLbDQB50ibWD60Itz9hxuRVjDVzegb/ZjOd1fpX45I3J5c9C0ty5WqLsw
 FCmpMX52aeOEGXvRHGFLuopIzWCJayo9fjsPE1u4uPuujVb47ne1B6rq1Oe7Bd7m7YcsAmo7nGCWQ
 nPsF5dOXZJgXHUcJEB5mO0WjKO0bKQ/m0uSlvTr1jc90O/IASIgiv916s++cRfcvpiAWhrOauMHob
 pXadsZfboQj7C8BiGea8+Z0daEaBIY7OqOM7jiTrDr6zigbiA19+YKHrCrAwCibdUbXmqMMv0grRu
 UrzfSZTQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHs-000Dle-1U; Mon, 13 Jul 2026 15:01:32 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHr-000Hfn-1q; Mon, 13 Jul 2026 15:01:32 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 0/6] TQMa6: Prepares for the switch to using SPL
Date: Mon, 13 Jul 2026 15:01:00 +0200
Message-ID: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series prepares for the switch to using SPL on the TQMa6
in the subsequent series.

Markus Niebel (2):
  board: tqma6: change U-Boot device tree fragments
  board: tqma6: implement ENET errata workaround detection

Max Merchel (3):
  ARM: dts: tqma6: add boot phase properties
  dts: tqma6: mba6: remove old device trees
  board: tqma6: use runtime SoC detection in enet setup

Paul Gerber (1):
  board: tqma6: add kernel device tree handling for environment

 arch/arm/dts/imx6dl-mba6.dtsi           |  22 -
 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi   |   8 +
 arch/arm/dts/imx6dl-mba6a.dts           |  21 -
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi   |   7 +-
 arch/arm/dts/imx6q-mba6.dtsi            |  44 --
 arch/arm/dts/imx6q-mba6a-u-boot.dtsi    |   8 +
 arch/arm/dts/imx6q-mba6a.dts            |  20 -
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi    |   7 +-
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   |  37 +-
 arch/arm/dts/imx6qdl-mba6.dtsi          | 535 ------------------------
 arch/arm/dts/imx6qdl-mba6a.dtsi         |  30 --
 arch/arm/dts/imx6qdl-mba6b.dtsi         |  49 ---
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  |  54 +++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi |  14 +
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi |  18 +
 board/tq/tqma6/tqma6.c                  |  86 +++-
 board/tq/tqma6/tqma6.h                  |  14 +
 board/tq/tqma6/tqma6_mba6.c             |  33 +-
 18 files changed, 247 insertions(+), 760 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-mba6.dtsi
 create mode 100644 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6dl-mba6a.dts
 delete mode 100644 arch/arm/dts/imx6q-mba6.dtsi
 create mode 100644 arch/arm/dts/imx6q-mba6a-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6q-mba6a.dts
 delete mode 100644 arch/arm/dts/imx6qdl-mba6.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-mba6a.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-mba6b.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
 create mode 100644 board/tq/tqma6/tqma6.h


base-commit: 5a7117b0a2e3f41475945a4443a4e3adf8799024
-- 
2.43.0

