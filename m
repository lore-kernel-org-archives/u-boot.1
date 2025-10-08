Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D215CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 08:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E67839E8;
	Wed,  8 Oct 2025 10:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=eds-india.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49368397A; Wed,  8 Oct 2025 08:36:52 +0200 (CEST)
Received: from sender3-of-o55.zoho.com (sender3-of-o55.zoho.com
 [136.143.184.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452DB83942
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 08:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=eds-india.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=md.asadullah@eds-india.com
ARC-Seal: i=1; a=rsa-sha256; t=1759905404; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RvXluu+LG4xEx2IUCN2flQrwaliLEj0ZzPMIZ3cc2a9wpnuLG2qqoyNDOGS6tFVkfLE+m5T7d+yG2znveQcBO5ItbU3q7vV3UjWzfyefkgWvrJqiEaseCCxIyL8ADTTavQiI7a2+D7F5P0s2ys+YpAe/iB3FAx+1KC8a+QBM5tg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1759905404;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6IBOQA4M72hbGFUcq0MN0QpmD5I8kL0OcEW2eCfRXqs=; 
 b=Dn9g7wMyRqX7ul2fu7ZQ2xwC5kFahdXqOgPfZAXSqXu46Ml0wR9h0GdXKsPpUMnCsExHzQSs0lTLQUF6pTLf0aKv96O4HegXjsFwPJ6ho576nxk2IveURkjdyElvifU5tkf57b0Uv/OiJjFu26lNT0z9+3UVNw8WFgnB1l7FuY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=md.asadullah@eds-india.com;
 dmarc=pass header.from=<md.asadullah@eds-india.com>
Received: by mx.zohomail.com with SMTPS id 1759905402131883.049483352964;
 Tue, 7 Oct 2025 23:36:42 -0700 (PDT)
From: Asadeds <md.asadullah@eds-india.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, linux-stm32@st-md-mailman.stormreply.com,
 Asadeds <md.asadullah@eds-india.com>
Subject: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
Date: Wed,  8 Oct 2025 12:06:23 +0530
Message-Id: <20251008063623.1233604-1-md.asadullah@eds-india.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 08 Oct 2025 10:05:29 +0200
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

Add missing CPU_STM32MP255* cases in get_eth_nb() so that U-Boot
correctly reports 2 Ethernet interfaces on stm32mp255 devices.
This fixes the "ethernet not found" error during boot.

Signed-off-by: Md Asadullah <md.asadullah@eds-india.com>
---
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
index 0d199f6f903..48b452f01b1 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
@@ -78,6 +78,16 @@ int get_eth_nb(void)
 	case CPU_STM32MP257Axx:
 		nb_eth = 5; /* dual ETH with TSN support */
 		break;
+	case CPU_STM32MP255Dxx:
+		fallthrough;
+	case CPU_STM32MP255Axx:
+		fallthrough;
+	case CPU_STM32MP255Cxx:
+		fallthrough;
+	case CPU_STM32MP255Fxx:
+		fallthrough;
+		nb_eth = 2;
+		break;
 	case CPU_STM32MP253Fxx:
 		fallthrough;
 	case CPU_STM32MP253Dxx:
-- 
2.34.1

