Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BB1C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B258798C;
	Fri, 12 Jan 2024 13:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sIiQnW4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B82187969; Fri, 12 Jan 2024 13:50:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3209A8785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9617961CE1;
 Fri, 12 Jan 2024 12:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66245C433C7;
 Fri, 12 Jan 2024 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063798;
 bh=TyqIweVxcIBrxVleQP/Fn6c8ZoeRxg4va7NEniy1puc=;
 h=From:To:Cc:Subject:Date:From;
 b=sIiQnW4OpST9iJLH1BdWfoU7z1PyU+2hdmovvz5WlXqomSD3l/uVWfpOczeO1QSWA
 H4rug92XZZJuotCyaqFzF5+sWNf7+PJqEN+Ed0q/ftlwGVsZmGtMylFdJpEEEe1v7I
 nwFYDktA9EiwSzclGvGS+hD5rts57T1xkNfi5PxRXCu/vQ/GNlnH5L6O44x3kUfVPd
 XEFFR2Kkt3LzJi1TKUKcL91wepnxv/XNF5FmnAE36AiQBrEIKpfvWhWFFDwCfLXRuo
 xwPcLJkgiXI29JY32thqfLFzAEtKuq7V/U8UFrQq9Ap2lZddlVpT+c7hPBm0w9cNuy
 u563R0dVFrnGA==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/5] k3-j721e: beagleboneai: Fix USB
Date: Fri, 12 Jan 2024 14:49:46 +0200
Message-Id: <20240112124951.238098-1-rogerq@kernel.org>
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

This series fixes USB operation on k3-j721e based boards.

CI testing: https://github.com/u-boot/u-boot/pull/468

cheers,
-roger

Roger Quadros (5):
  board: ti: j721e: Drop SERDES PHY init from board file
  usb: cdns3: avoid error messages if phys don't exist
  arm: dts: k3-j721e: Fix USB0 operation
  arm: dts: k3-j721e-beagleboneai64: Fix USB operation
  configs/j721e_beagleboneai64_a72_defconfig: Enable Sierra PHY

 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  2 +
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  8 ++
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  8 ++
 board/ti/j721e/evm.c                          | 77 -------------------
 configs/j721e_beagleboneai64_a72_defconfig    |  2 +
 drivers/usb/cdns3/core.c                      | 28 ++++---
 6 files changed, 38 insertions(+), 87 deletions(-)


base-commit: f28a77589e7505535a4eebdc7269df98f67dbe68
-- 
2.34.1

