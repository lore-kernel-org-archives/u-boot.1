Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE9C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FFA879F5;
	Fri, 12 Jan 2024 13:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d820eJ7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2100A876C6; Fri, 12 Jan 2024 13:50:22 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41008879FD
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A6B68CE23B7;
 Fri, 12 Jan 2024 12:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C8C433C7;
 Fri, 12 Jan 2024 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063814;
 bh=ufCM7wt1OkGRcUI60F4cyD/BurlN5aihqfLptVRU3QE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d820eJ7E4QBwXhMubw0aG3M7pb+rGncmqlvpB+ud/Fbjoqvr+EMTtSF56q3BK6HOG
 GuvhyxWHeRHKj0NYj5yFeOKFyaD6LkmrAAS7HTVcPR+cuVdlbEIbVXk9KfWeej6VO8
 QzG4h0Grfcss2k/qf2BrH11Krw9fthzeu6xA01uvYzrriHts0TzOMES18fin0l5aR7
 KyJpsAjp3WhHfBXFe0pB/L1i6mPQlqmvNqNwhQErwjIK4F8jk0VkW9+QCbGR5U+fwf
 egPwtdykqdz+wOAiPLthr2X9uZem+YJnmyqHwmFaF6ztocvDvhc1Ho+qjoICVtkFxe
 HmQMpLHqgFUvQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 5/5] configs/j721e_beagleboneai64_a72_defconfig: Enable Sierra
 PHY
Date: Fri, 12 Jan 2024 14:49:51 +0200
Message-Id: <20240112124951.238098-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
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

This is required for USB Super-Speed operation.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 configs/j721e_beagleboneai64_a72_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index 959f86844d..f66206f6e3 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -127,6 +127,8 @@ CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_PHY=y
+CONFIG_PHY_J721E_WIZ=y
+CONFIG_PHY_CADENCE_SIERRA=y
 CONFIG_SPL_PHY=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
-- 
2.34.1

