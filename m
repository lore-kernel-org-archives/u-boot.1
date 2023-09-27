Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA54E810D0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC8C86DCD;
	Wed, 27 Sep 2023 14:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lwil2X1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E2286DDC; Wed, 27 Sep 2023 14:01:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BE086DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id BEFE0B81261;
 Wed, 27 Sep 2023 12:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5956C433C7;
 Wed, 27 Sep 2023 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695816115;
 bh=ioUgXD0sVXvp7bSmMYPzQNyTwHTX+miXhZku63q8sh4=;
 h=From:To:Cc:Subject:Date:From;
 b=Lwil2X1PjU5r9OXwL4S+BvtrJoVhQn+87araH6+1rzQHiVH+yUwpG+ApsM1kWoXvn
 rjvRHjoExnJveuU1mixN8qZOiz5coDGh+HJ+ZPg2OSJUmQzzJ9e/jMCp3QyaxntOKc
 vjXFv44sZbD9SAtRZB2OtpF5kocs514+0HOsnbVf11PmFF55sqGg3dhsvAni5iuG35
 551+Y0vm0qfBWU7EYgcVJMxbcSEWr5qqccw04qXhJOYzGleLsSrNAQoWDPcWVwTahl
 XrMsKVht8lRRBN7olcsFB1ktgQS0czRw9r+Yt5BaT2hU3q39ERqT5ah0nAGCKXBUCZ
 Zv1Yr4w0XTNtg==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: vigneshr@ti.com, bb@ti.com, afd@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 praneeth@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm: dts: k3-am64: Sync dts from Linux v6.6-rc1
Date: Wed, 27 Sep 2023 15:01:46 +0300
Message-Id: <20230927120148.75088-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

This series aligns the dts files for AM64 platform from Linux v6.6-rc1.

cheers,
-roger

Roger Quadros (2):
  Revert "ARM: dts: k3-am642-sk-u-boot: add PMIC node"
  arm: dts: k3-am64: Bump dts from Linux v6.6-rc1

 arch/arm/dts/k3-am64-main.dtsi        | 209 ++++++++++++++++++++++----
 arch/arm/dts/k3-am64-mcu.dtsi         |  53 ++++++-
 arch/arm/dts/k3-am64-thermal.dtsi     |  33 ++++
 arch/arm/dts/k3-am64.dtsi             |  22 +--
 arch/arm/dts/k3-am642-evm-u-boot.dtsi |  70 +++++----
 arch/arm/dts/k3-am642-evm.dts         | 177 +++++++++++++++++-----
 arch/arm/dts/k3-am642-r5-evm.dts      | 194 ++----------------------
 arch/arm/dts/k3-am642-r5-sk.dts       | 194 +-----------------------
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 122 ++++-----------
 arch/arm/dts/k3-am642-sk.dts          | 174 +++++++++++++++------
 arch/arm/dts/k3-am642.dtsi            |   1 +
 arch/arm/dts/k3-serdes.h              | 204 +++++++++++++++++++++++++
 12 files changed, 815 insertions(+), 638 deletions(-)
 create mode 100644 arch/arm/dts/k3-am64-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-serdes.h


base-commit: 4cb31a9f3560b293670de95e76c1f3cf2f9e1ca8
-- 
2.34.1

