Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F58D41D69
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CEC83A9A;
	Thu, 11 Dec 2025 17:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="TP7B4ysH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BE7830E4; Thu, 11 Dec 2025 17:35:16 +0100 (CET)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF7483045
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20251211163500d8221e0e7000020799 for <u-boot@lists.denx.de>;
 Thu, 11 Dec 2025 17:35:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YrXJClV1a1DPQpxjgfo7AD5l0krw1z1L0F4hhPBBjI0=;
 b=TP7B4ysHfd4SWtHu2/8+go2DfFFDlWxwZrfDo99UiFUz4tXymVoEI2saNDlfuKTrkNl/Qb
 dwgMS2UjdZxIl9j2U78BJZuOa3U4QE0XDFx/hymVhELL3xNWJzXC5/oyCPoAfoFo+5/iwaVr
 AnlfXhGbbfUhOsMRNPYotzoPbNxs6L7lUcRnK1X8b6wfTpXB00bwuLU80Vwn+clGto6FcQAV
 OSD7cHw8lhcju5gnGFH9aFAwqJlW1PWSJUpZH1YFpczF4FP1ADxZQM/cevxj/4lX9a0PxLkM
 QpovvkP17kVJzZGm/pyKjZQ7gL99MBHz48Cc7pG2YueE9+/slhpMvuVA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v3 1/5] spl: Kconfig: Add missing SPL_LOAD_BLOCK for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
Date: Thu, 11 Dec 2025 17:34:55 +0100
Message-ID: <53abd048d1c0ba71f09d8fddccb7dc076859a74e.1765470899.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765470899.git.jan.kiszka@siemens.com>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
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
index 3b7b6cafef8..142cdb34cd5 100644
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

