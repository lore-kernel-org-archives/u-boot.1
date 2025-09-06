Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D06BCA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 00:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A4F83AC7;
	Sat,  6 Sep 2025 02:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m3qirjJu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sOnZc1RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7535183919; Sat,  6 Sep 2025 02:05:35 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59192839D9
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 02:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJYQ475JRz9syt;
 Sat,  6 Sep 2025 02:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C89njIdtrKai5QqgCYWE0E7DXc81Z+60UK30Mflq/3k=;
 b=m3qirjJuPHrjWXB/Ng306xBUkXTZAz0gt1tv8bvGK2S0avv3H6WtboVvJAlrDKTgmfRxOV
 WXzdCUCXCnBMHnNjJ+kCnzY5GY3wU1lpk4rqWCgXwMUBg6mAfuksQNL4GP5DRtU/FH5tGf
 3Y+ModGOBkeJEYNdRXWPDGln8qzsdTRPG5H5G8zHWgv1BP9Qcu9C+xakmlKPYDdH66ijXa
 8INz6GuMxLMI5oIY1sZevDa6PerVbUNFqNfFIQlD+d/eftzL6bv9ZrIrxENua/0CuI15AV
 QO3hkLRcXDylDyRe9c6TlyCCflwlqQh9BStInIc9pUst0EerMX5jjcorMsjSWA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sOnZc1RB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C89njIdtrKai5QqgCYWE0E7DXc81Z+60UK30Mflq/3k=;
 b=sOnZc1RBW1w4ysQoc6Ci3jk3x3UHJStfSWvN16xQA9hetfmfX/cuAtp7iovYUTSDFcbwEZ
 QB/8KsCXwm8SX7ggAFXvObPLCd2OPf4oAehPY7VQPG4HJDfHui25hQaibbDx4iM/R6miy+
 yDBnbk1V/sjo9LWNOmBBxcgaf7egwgUPzQj9/4V5XMgqzP05827JQCnr8x48KKq7P/S96D
 P+Vgr//5DhJOCHEYYzW3rpYOLEo/f1E+s16CkoKYOL4RX1d/P2BvSdgnMPUwHznPRbF0c1
 ikZHlldKT2ST0jBu98wU5WvYVfkVPRnuAYRKNgvnRVrycQkcl/Fp1cSuGTl4ow==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: Enable thermal driver on R-Car Gen3 and
 Gen4
Date: Sat,  6 Sep 2025 02:04:20 +0200
Message-ID: <20250906000507.284853-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250906000507.284853-1-marek.vasut+renesas@mailbox.org>
References: <20250906000507.284853-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9a39afae66680329328
X-MBO-RS-META: pj9bgcxpqjwsh4z937eqsoahj1p1jhqu
X-Rspamd-Queue-Id: 4cJYQ475JRz9syt
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

Enable thermal driver and 'temperature' command on R-Car Gen3 and Gen4
to allow reading out the SoC temperature sensors.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar64.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
index 12211ae2810..073f728bf09 100644
--- a/configs/renesas_rcar64.config
+++ b/configs/renesas_rcar64.config
@@ -2,7 +2,10 @@
 
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
+CONFIG_DM_THERMAL=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_REGMAP=y
 CONFIG_REMAKE_ELF=y
 CONFIG_RENESAS_RPC_SPI=y
-- 
2.50.1

