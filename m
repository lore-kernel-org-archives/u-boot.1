Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB966FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E36842EB;
	Tue, 17 Mar 2026 02:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QPDY1l4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747FE84285; Tue, 17 Mar 2026 02:24:53 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A45842CE
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4671cbce2feso2179266b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710689; x=1774315489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5L5++JCcTm3JW5FvBpRQRejQcoWLWABrxwirRxWmgBY=;
 b=QPDY1l4Npge5qfdOhlVn0X4Mr/oijhEtHjLWXrlKA2NbZvdcYPRad7sSADMYawl8mo
 bqD/yoqUU8D4NJq+1KtGdOqpoj3cux+Uh3lnDoIErbqDFt1Gl0CXkd6GsAFjnBkbDMIa
 3x4q6yyV2p7VPI1jPGqhnMb6o5R0EenY/QlSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710689; x=1774315489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5L5++JCcTm3JW5FvBpRQRejQcoWLWABrxwirRxWmgBY=;
 b=Rb2tALfA++3jJUDhpKfZBPDwByEe7PMFAo2cKEe1QObgAK5GjtL3OiA82kSt8oP1po
 BCHdrLYrM6O1HBzBZcsOK+4dWKwmPmnIPxfc1ISYuexoVY1zD88z4wYaweXInHI3wf8W
 1ijnhEYEUM422tSGE7S4NZeVbJHm+TWMGA9y7PLB1dMnLK/CrPl8T7/JKq7YLfqa/N3A
 gVw0OivD2yvbmBiuY/4FbzWEbieqqgcuUeeE4jhVFPWI50XHLIoyoIc8Au/OULR5WVy3
 7HntsTaP4tvF8NfxzNuRWG9pwwx7xlnJOsDVI9Gb7t6NgjYjVCKpM5Dd7TiMR8e/fmmJ
 zuPA==
X-Gm-Message-State: AOJu0YwTCT4cOpGjH7EJcDRO6lakWAtQ8rQQRMgBuuqb4405Lkfx31VU
 9J0CgVizSLTxWZkoqQP9Dwwmsle/Q1cjeK2Tgj5+aUxaB4elsYpw2h+orG+zqDg4FNL/6BGIhj6
 Q1gR3KoU=
X-Gm-Gg: ATEYQzxnJZnrf8Ka0DiNu5QdO/5LwkgSysHj1TA0/kah3FDaHhu/PaShm19yk5IdsNO
 bGfJe5FCKxewlmh4AWHyCeLsTFHWD2UjT6QmcofErs1EnJDI0KZbQfgv6KAKXfHp2n90CJQEY8O
 9DGVRcId7vZldCdnwvlL1oCzWChb8NKcnE6+0N30E4KcK26ANNmSy5AA1rmlV7pjtQ5fq+az3eW
 +MahWWXI957sKlVPBZ55cVA/LoDHf4/1NI5LVtoYZ84k4UCPUS0TAKEgeYxYKbavY2ogPFh5XOg
 P7ZgvSRBtSMS70TMNLPfBjKCMJV7jECcYY0/mNPM+nuBuZkyCw821SgZH3fBv2BqMFix73Qb8Fg
 XU7DQZPHoi2O5x0hjWE3sqCnSPO0L8X8W4lEjCVaeZ1MoqgHIqzEGNYeUlJHVFSSTi9chSoRmcy
 BsHhz0Id+A7Z16SLzUu1nWGwC69ISwKThDIUf2S7UKmZ7YWhs+i7BdLJxana5ySdg4Iaf+5S6Pv
 I/MBeU7vXX6UaPou0ERjtgVJ5zgYpTO8MxY/OiDA4q8+akMh+4=
X-Received: by 2002:a05:6808:6509:b0:45e:a1e2:2808 with SMTP id
 5614622812f47-467570fdedemr8463527b6e.27.1773710689649; 
 Mon, 16 Mar 2026 18:24:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734160cebsm10440627b6e.7.2026.03.16.18.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] watchdog: Correct dependencies for WDT_MAX6370
Date: Mon, 16 Mar 2026 19:24:48 -0600
Message-ID: <20260317012448.4162644-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue with the dependencies
for WDT_MAX6370. It needs to select both GPIO and DM_GPIO not just
DM_GPIO.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 35ae7d106b1a..0047846a44af 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -216,6 +216,7 @@ config SPL_WDT_GPIO
 config WDT_MAX6370
 	bool "MAX6370 watchdog timer support"
 	depends on WDT
+	select GPIO
 	select DM_GPIO
 	help
 	  Select this to enable max6370 watchdog timer.
-- 
2.43.0

