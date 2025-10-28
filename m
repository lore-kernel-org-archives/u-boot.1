Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CDDCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F2983A5A;
	Tue, 28 Oct 2025 09:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=eds-india.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 750EF83980; Tue, 28 Oct 2025 06:39:58 +0100 (CET)
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com
 [136.143.188.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E56483976
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 06:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=eds-india.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=md.asadullah@eds-india.com
ARC-Seal: i=1; a=rsa-sha256; t=1761629990; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IEINfTkhQVuiqs+KEoVbbjRFFM9pk6Upa8p3VdR7Wi6nXT6xhT9RygqQRxmxXtmKzTaf0F3BJQMMr+1urOGY24st2O5xYxW6ovQw62z/bSB/xqTFXI8Wh/urxASYMWM8kK8qOYPPV/FopYGd+KMw/OC70VeiptHiX7Kx3aqAMRI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1761629990;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hML90WkSwB2EvL2Y3FUGCWlcK3yfBog4E2W0ic3sE6w=; 
 b=QWZuMgaN778RFJP7A3iVRhdO7n7oZydV3SyAltxOVKBDpbiiEVoZXjnxbUFY7/4sbptoO4yh4bKkFHalW/J/Cg3+UhQLt3hHJ/i50/3UjRGNgWeurMyc1KFyR341Csc0+pRmo5OeWOeYr7Pz4zuTSNTEgK4l2WCp9D+MV4ObGlE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=md.asadullah@eds-india.com;
 dmarc=pass header.from=<md.asadullah@eds-india.com>
Received: by mx.zohomail.com with SMTPS id 1761629986941367.3860239488788;
 Mon, 27 Oct 2025 22:39:46 -0700 (PDT)
From: Asadeds <md.asadullah@eds-india.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, patrick.delaunay@foss.st.com,
 patrice.chotard@foss.st.com, Asadeds <md.asadullah@eds-india.com>
Subject: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
Date: Tue, 28 Oct 2025 11:09:26 +0530
Message-Id: <20251028053926.654835-1-md.asadullah@eds-india.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <94b5922b-6f8b-4138-9d97-178c88bebad2@foss.st.com>
References: <94b5922b-6f8b-4138-9d97-178c88bebad2@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
index 0d199f6f903..112af61e9b9 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
@@ -78,6 +78,14 @@ int get_eth_nb(void)
 	case CPU_STM32MP257Axx:
 		nb_eth = 5; /* dual ETH with TSN support */
 		break;
+	case CPU_STM32MP255Fxx:
+		fallthrough;
+	case CPU_STM32MP255Dxx:
+		fallthrough;
+	case CPU_STM32MP255Cxx:
+		fallthrough;
+	case CPU_STM32MP255Axx:
+		fallthrough;
 	case CPU_STM32MP253Fxx:
 		fallthrough;
 	case CPU_STM32MP253Dxx:
-- 
2.34.1

