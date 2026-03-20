Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C4E1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8769984011;
	Fri, 20 Mar 2026 21:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OPl3KOJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47FD83FE9; Fri, 20 Mar 2026 21:53:33 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC2483FED
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67baebf716bso1393644eaf.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040009; x=1774644809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MbaMDBzmqDxzBfp26f6/NhaJeB0cNJN4f46Tn8UFRdA=;
 b=OPl3KOJTL3NqM3hpwuFS8es0kcKdfv7szVwPUpBLVC5FfTTO/sriQeymlChrMogjDc
 0EL1xE7IUFlt2eRJpfwAUjyDpXdOdz0owHwA78r07oyP+TU3Wu9jY7nRGVpUgHI2Jy1p
 DQduiw+psApKzCibKIudEWiLKkhfHmdz2RNNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040009; x=1774644809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbaMDBzmqDxzBfp26f6/NhaJeB0cNJN4f46Tn8UFRdA=;
 b=drMZPQdpRWzVnxWHBwTCTd85E2g9704DZTxK4lU4NPfpOagukg5FYTns7eY2CBbgvT
 ZrnTvftRjMIgEtVKAOK5oZuWDFUxRATxFsOyQ3MX1o09NRUPGvIyEMXiktByjfwrvIZb
 XlvZO9veuWb7C9F9gcgVTj6mNBeNFZ3XlUfdULDmcGtK8YSomXxYV50FlO4XfizPe6WW
 W4OdosWUZRHa0Gtu/7gdIAK29++eWXHd6Qtbir2MFk0/2+tswxUFXtknmKiZPbgf0Pq2
 QSgkjPrzKvOknQs/CuZYP1pLKVRtoz4Yiyk2PE5TpisOl3bMZsx9/fTe78IMIW19xWgi
 OzYA==
X-Gm-Message-State: AOJu0Yy2ywEO4hb4WmoL8o9GM7U81V/5I6P2INbdEs8fo9pH1jTrnf44
 Cswkqqq9QA0+YVQYtSY0W4xubn7TmiSoHSDBh5S1v2SCz8sJUDSXXQJTE5ZZ5AAmbDBDJWzzwO4
 36s7l8EA=
X-Gm-Gg: ATEYQzzdyGRH63WsANkoV9bpu1iGqCBSDOSPdkrRKGTrN310Ze8mA/0uz+5glRPzRaV
 wI7QY4b3HM4q3IAp0iesMjTL2R8jALynuRIqDJ4nNvbGDvU9kN49hbiSsWKTKyzGXgnc1WWJ1wn
 Wh2yu5FduGohky69t28rfpL2t1Wfs7Ebvfsw9XzX1wcSq3jcvKHNDS8LkYeVNT0syIsBz+QIdKr
 9JTiORbb5lRuVxxFx5SeqY2xcxMGSrIz/k+6EmN1LnOwl84D2nI1z70mqJNcyuQ04Xy/6mAtJP3
 R4txJMSKeC0RRXUcEywPrINHPOjfklZAtFPDwItlfcG9xz0mRI1oTER25TVrJPwNg4AMhT8DDyt
 3YG06BvXwFNqrCt+aUFkHJ/Jn6+zJShiQLxBgWfD94NATl9jI4Efc4I8dwHJXcgvZ5JuNS3/mwu
 dtWvd4Da2kl1wC2oy81zGc98rUUbUqnwvKmkDiaJZmdsMtFQlSCAWUmTBS1YRf0aRyCDO4BeDLc
 1cVqJKbFaj9WDnJLBUd1oemvrhx31uIoXJV9O9Zk5bQ++0V3itXmSF3/Vb1Hg==
X-Received: by 2002:a05:6820:806:b0:67c:1d90:3949 with SMTP id
 006d021491bc7-67c22fa1860mr2793838eaf.48.1774040009210; 
 Fri, 20 Mar 2026 13:53:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252c91d0sm1911637eaf.5.2026.03.20.13.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: Rework dependencies around NET/NET_LWIP and NETDEVICES
Date: Fri, 20 Mar 2026 14:53:27 -0600
Message-ID: <20260320205327.3788628-1-trini@konsulko.com>
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

Functionally, both networking stacks require DM_ETH. This is because
they both also require some networking devices to be enabled. Express
this more correctly by having both NET and NET_LWIP select NETDEVICES.
In turn NETDEVICES no longer depends on NET or NET_LWIP as it's not
prompted anymore.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 Kconfig             | 4 ++--
 drivers/net/Kconfig | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Kconfig b/Kconfig
index b52331d6ff25..01708e80f476 100644
--- a/Kconfig
+++ b/Kconfig
@@ -787,14 +787,14 @@ config NO_NET
 
 config NET
 	bool "Legacy U-Boot networking stack"
-	imply NETDEVICES
+	select NETDEVICES
 	help
 	  Include networking support with U-Boot's internal implementation of
 	  the TCP/IP protocol stack.
 
 config NET_LWIP
 	bool "Use lwIP for networking stack"
-	imply NETDEVICES
+	select NETDEVICES
 	help
 	  Include networking support based on the lwIP (lightweight IP)
 	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 02063ce3aa91..9d4e9f069701 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -90,9 +90,10 @@ config DSA_SANDBOX
 	  Ethernet device used as DSA master, to test DSA class code, including
 	  exported DSA API and datapath processing of Ethernet traffic.
 
-menuconfig NETDEVICES
-	bool "Network device support"
-	depends on NET || NET_LWIP
+menu "Network device support"
+
+config NETDEVICES
+	bool
 	select DM_ETH
 	help
 	  You must select Y to enable any network device support
@@ -1106,3 +1107,5 @@ source "drivers/net/pfe_eth/Kconfig"
 source "drivers/net/fsl-mc/Kconfig"
 
 endif # NETDEVICES
+
+endmenu
-- 
2.43.0

