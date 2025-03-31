Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669DEC36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0E781F30;
	Mon, 31 Mar 2025 09:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V/7tc4Pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD37881E18; Mon, 31 Mar 2025 09:24:28 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B3381E60
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 34B183FFCB; 
 Mon, 31 Mar 2025 07:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405863;
 bh=gLhJVdZ9Y9AWplx7vvfHlwZ8HfHMzm63pVyd79VsX+U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=V/7tc4Prxkh5qNy31kJmqbxYqW4FtKdEGVmiMBQI4ZNtrMvyDY/iL5Gu3XE+d6UKH
 ny3ngtwToKrazH6O0wLHZop0RqHrO3ExyrPUrZYHYCycJQg4tTsjDkZX/mbyUStTBZ
 p2Csi5jsQusoz3xClLOteLIBUujC4kYy3X/mqExq6HN2EG0jqXikuygKbAndgeBThP
 wkr2dHlp9hpmKmcWSwyiGXEDcop2++Bk12vO9fC4glb3sPsNf4C8Zacna0juInnR8k
 EuRjfTNrWugKip4tp2RnkiELrh5mrOOPig/tf/pwbdsTfK8CHWAl84mcPlw6kPm1Uq
 GwmhLhODMJJxg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/8] board: starfive: spl: support DeepComputing FML13V01
Date: Mon, 31 Mar 2025 09:24:06 +0200
Message-ID: <20250331072410.8662-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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
v2:
	rebased
---
 board/starfive/visionfive2/spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 13a48939c8f..52f75471de5 100644
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

