Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3072C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4CB832BF;
	Wed,  9 Apr 2025 09:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nWyNOdvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B831083303; Wed,  9 Apr 2025 09:18:54 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2C48283E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-207.46.114.pool.telefonica.de
 [46.114.104.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F06014148F; 
 Wed,  9 Apr 2025 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744183129;
 bh=zqAI/2lYHIZnORs4K3oUzhbejxx1AGp2s0dZGMvDKcU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nWyNOdvGXjC/9uz6MlkG7egPtbzfSnbR8G/UQ7fLLDEyCY7rbD6q+Vscy2AP4Yer4
 cG+7xYi+OLkpNLzHSfKxgqKqdaflfIucDpfTVFFvzNDPyZnqKABdyT5ZoGGjk2VP43
 tW0eqYncLIujZ8G7P6WMZ9TsmHocAOK2pc3rrjBML9pb200AZoVP7cr40afcoIvENN
 rBGPKhV5LnEnuXizmkupKGzbEpUdcS9o1uILqCl1lnR20sKaKVVTSiDuN3VYbU5DtH
 NVnl8mW76wLg+mCLrX5yAr3gaEBEGAuK5YWl/jbyYawK8deo3eUBmaHH/caeUyXI2U
 QqxVv5QkKDoUQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/8] board: starfive: spl: support DeepComputing FML13V01
Date: Wed,  9 Apr 2025 09:18:31 +0200
Message-ID: <20250409071836.26629-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
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

On the DeepComputing Framework motherboard (FML13V01) choose the matching
FIT configuration.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2:
	rebased
---
 board/starfive/visionfive2/spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3e4d3e21988..9a3081ef06f 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -125,7 +125,10 @@ int board_fit_config_name_match(const char *name)
 	if (strncmp(name, "starfive/", 9))
 		return -EINVAL;
 	name += 9;
-	if (!strncmp(product_id, "VF7110", 6)) {
+	if (!strncmp(product_id, "FML13V01", 8) &&
+	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
+		return 0;
+	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
 		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
-- 
2.48.1

