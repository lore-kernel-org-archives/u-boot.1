Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2395AE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E946380219;
	Fri, 13 Dec 2024 11:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqMoeuS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47799801FE; Fri, 13 Dec 2024 11:23:39 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445508010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 23276A42A2C;
 Fri, 13 Dec 2024 10:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B9CC4CED1;
 Fri, 13 Dec 2024 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085416;
 bh=wzvtGplHyeAXNEF0hdfug2A1kLixQUi/eiuN7psFxHY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fqMoeuS1YptrMEJekcv6WOwj4rQSGoVaLZ+AS3tJe/QVB7oKa3xUjfHJup0nE/QbS
 9LofDwr8jxvR0aGqM+5NmP6HlQj4NpFDIbjsxziQsqIiRARm/7jq2WjRKsDgScNIZm
 dqCfVqPObqwrcWZdLQDGwK6NQSfPhBwM1mrNRsbmYYyC+GvVSwqNmfNiUixiFoEpzR
 L6qXc+ThJMjSZCsTD22jLTyvH0P7TFxO+qJ5S+Ildf2xP2qz0Dn0bIy+RwC04YKkcQ
 p7v1vCeuomuk6Gjeh3Nrf3DTDsQMrhYcAY7z0g0PytjysQSMzAz5sMoYbXpSStQuMn
 fAD+Ho9aQ2bQg==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/5] board: sl28: fix linking with disabled watchdog
Date: Fri, 13 Dec 2024 11:23:17 +0100
Message-Id: <20241213102321.2166920-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
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

We don't have a reference to the driver used by
uclass_get_device_by_driver() in stop_recovery_watchdog(). Fix it by not
calling that function if the watchdog driver isn't enabled.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/kontron/sl28/sl28.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/kontron/sl28/sl28.c b/board/kontron/sl28/sl28.c
index adfec8ba237..0baf5c63f18 100644
--- a/board/kontron/sl28/sl28.c
+++ b/board/kontron/sl28/sl28.c
@@ -156,7 +156,8 @@ int fsl_board_late_init(void)
 	 * If the watchdog isn't enabled at reset (which is a configuration
 	 * option) disabling it doesn't hurt either.
 	 */
-	if (!IS_ENABLED(CONFIG_WATCHDOG_AUTOSTART))
+	if (IS_ENABLED(CONFIG_WDT_SL28CPLD) &&
+	    !IS_ENABLED(CONFIG_WATCHDOG_AUTOSTART))
 		stop_recovery_watchdog();
 
 	return 0;
-- 
2.39.5

