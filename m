Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A683CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B8A83890;
	Tue,  7 Oct 2025 10:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="QAByEswN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F55583655; Tue,  7 Oct 2025 10:18:14 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9336283869
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2316C9A45; Tue,  7 Oct 2025 10:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825092; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=w6dBlaS6mXI1KnmJzZOsdAQ1LQFP+Jtse+1dtI0A8fI=;
 b=QAByEswNxE/MG0ugKZUMxlj19V+jOKDv379S4Pn7OW3EkZQNveqhuyT1iC42BIZP2vm/Cj
 RElz5iVhyTedhCPrJnQNxHi576JERfMG6Ws4TlrF4gQSfiavi7D3mrIVGbilvJhqgkXmVF
 AzYrgRGYqxXzq5tqkkQ1Yt3Vz+ctqfEpYD8poW3mB4ew4aPL/Ryw3RaUn3uyxlIZsaj90M
 Rz/t7aQbCTOOa7NgsspQZY/dJeSdL9PZ08eEOvCykNSSFa0LmmWIt04xQUJnDsE3+brZs5
 5l1Yakn7IDGxDGHfBD1KhVS17TZclx0Hwzgdnpa9jQYFmTEAWEUsMdz80nkO2w==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/13] imx: kontron-sl-mx8mm: Increase CONFIG_SPL_MAX_SIZE
Date: Tue,  7 Oct 2025 10:15:58 +0200
Message-ID: <20251007081640.61772-2-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The limit of 0x27000 (156 KiB) was valid at times the DDR firmware
required a fixed amount of 96 KiB of space. Now that we use binman
to include the DDR firmware it only needs around 57 KiB of space and
there is more room for the SPL.

Increase the max SPL size to 196 KiB so there is still 60 KiB for DDR
firmware. This allows us to enable USB and SDP support in SPL.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 4f08f2c572c..92583317a07 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -43,6 +43,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_BOARD_TYPES=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x31000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.51.0

