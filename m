Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328FFD116F5
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5753383979;
	Mon,  1 Dec 2025 08:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VCelVxXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D6D83A28; Mon,  1 Dec 2025 08:32:53 +0100 (CET)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC4383966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202512010732509a18d3de90000207da for <u-boot@lists.denx.de>;
 Mon, 01 Dec 2025 08:32:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sEtrj8UcIEPjK9m4S9nQs+960q8+Q/O5yesHzY9F7fw=;
 b=VCelVxXfIRvpVNZeMyggDr0TvX3h3hUSwHOkkF2KMTdRN1+3kLQMzvymNvbfu/VZNtb2aM
 uymmd8nvD6NQv6DpU2iAJ5Bcpy6m8i3n0ARIj5NU3tZ/qx0IX120phaoy1rsz83X1z1hMRiJ
 GcKz8S5JL6JGK6JJcolQd+GmbfZmUtHw900jQsMJ1AjXEW+szr/3vHjInNjFtiG6Cjfp+tNZ
 5wrQh86RYq3k6nLcqJsdOsniD1/M7PzVm+HkZ0QTUDq4/meYtbIwm8baBR/EpkyyY+1V/aOY
 i+hLYgE6AXRo/Mpwvibl+KjvT84AczEoxYZ4MheCW7ifqVr7mQzi7vQA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
Subject: [PATCH v2 1/5] spl: Kconfig: Add missing SPL_LOAD_BLOCK for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
Date: Mon,  1 Dec 2025 08:32:45 +0100
Message-ID: <db6aa161176dfcc4d2764e9411b4d195c9c3208c.1764574369.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764574369.git.jan.kiszka@siemens.com>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to explicitly select SPL_LOAD_BLOCK when USE_PARTITION_TYPE is
enabled, just like the other choices do.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 8dade2b501e..d24466b0c66 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	bool "MMC raw mode: by partition type"
+	select SPL_LOAD_BLOCK
 	depends on DOS_PARTITION
 	help
 	  Use partition type for specifying U-Boot partition on MMC/SD in
-- 
2.51.0

