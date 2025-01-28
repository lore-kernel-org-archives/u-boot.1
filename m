Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9AC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD1C81DCF;
	Tue, 28 Jan 2025 14:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="DrTlERYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F0D81DD3; Tue, 28 Jan 2025 14:32:01 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFD781DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738071115; bh=nSSHAy1O4z9hjkeUFphqFMtJnHq5pipznHIgUv8OpXI=;
 h=From:To:Cc:Subject:Date;
 b=DrTlERYf6kxfTNgX8UvXT3vqLNqJ8WIAqruBhyH/l+SAu80jA4t4Mq+EE2H8xAACZ
 Jf5ocbMcKMa9/RSgG4Mcv2A6dax5dqCvvsfFxefZJ13xnkf5BEhPOBcNZefrKWdDty
 79RDT/Do+tJExZeLYjwoLcM19jC87DAuXXiNkn9M=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
 id 7F48FE56; Tue, 28 Jan 2025 21:31:52 +0800
X-QQ-mid: xmsmtpt1738071112tqizycbpo
Message-ID: <tencent_576A82BB81A6305F262F7CF07BE2071BD809@qq.com>
X-QQ-XMAILINFO: OVkR+PSgVQ8cm//GqGsxGNHSFiqUTfRzQR56Dg+zySii5W8Gyp0ZWaEciHz/OX
 +IW7tze5HcvHI73pVG8Vu/k5gtYZlt1yZNMTLuc9JIu+zd5bSAhv/Xp+6n3IgR4t4N5DQq2BlCY8
 7V3RRVJTSRjaf/hl/8iHrPZcW8e+qLCor6XG51POCrIKxHBKx4HYasL+IeKCKsxbO4fwyJ9s06FH
 C7K1XoBRGbStKBKCWIGmG7hRCpzsu2C401SPJ6D023W6zOBOZoFkj79NBdSrg1BH93FK6S7uyoFH
 PctqZHeJiGlnZ06KBkfRCb+qaASmJeTRsMwS08yOFrP/IEbN/pa51C9UBaBPuc1dOo9MWu0qc6Qb
 yVOotHaQZPlCA920HeSELYUW/LCl5xY+jV5b+yEmyLOA/fsd3yYsYf55fF6+cxMRyWm3BPLR8rTN
 AIHyel0xPcJr7ho7ipmN4/Kmn33SFrKlPcq9z4cLvwLe/P1odOP5lv72uqLxIgEisii80eUJTWd6
 6t/0E5nY+mQ3bMk0/Z9c32kOot+noJoaL/YJ/OupXabgxNL9xCFh34vFnEDvmGAiO4ii8CyZLMIb
 lddrgI8PM7I7KVnywvb7y0lcmV8gr8iNHs6faHyZjmdDxassEWAlfa8tjcQv+8u/RyP91V4TkBEq
 qjP1Me92P5nZLl29meeR4zfs56Om/YgwUHXwFjxH6uU5sUcYuWiEklqnmir3ZlK7Ys7A4ygENOxI
 O96pYLTZesmb67VOsEuEwC1QK5eptkKCJHRXmxNvFT+wdK5iyqvRs6eqHcMTrI3QOgroKXgIkbF5
 HbTeyqvPI/FErFCTFuAGLSMdvo26pqhVMSa24BoJGn/E1RIPv7ca3DSEkK4hTzTDLW//6gIhtuZD
 Tfsc6Vj4Sn0+HLRH8s3RId1Denr9sctWgni1IRnDXlv61uMW3CMIHNp8A440dZSibKm1SzmAp9s4
 p05sJ0z6gqMQaMqDEDaworarNAlH6VqHBGxzO2TVEO9FF3AIhgmwzUapq/kL+1tPPyE28wfS7316
 b9QAODiw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: kconfig should not display the STATIC_MACH_TYPE option
 when SUPPORT_PASSING_ATAGS is not selected
Date: Tue, 28 Jan 2025 21:31:49 +0800
X-OQ-MSGID: <20250128133149.193042-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

When I use arch armv7,
menuconfig shows the STATIC_MACH_TYPE
option causing me confusion.
As we know, this should not occur when
SUPPORT_PASSING_ATAGS is not selected

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 314916527c9..349cfa1bdbc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2184,6 +2184,7 @@ config SERIAL_TAG
 config STATIC_MACH_TYPE
 	bool "Statically define the Machine ID number"
 	default y if TARGET_DS109 || TARGET_DS414 || DEFAULT_DEVICE_TREE = "sun7i-a20-icnova-swac"
+	depends on SUPPORT_PASSING_ATAGS
 	help
 	  When booting via ATAGs, enable this option if we know the correct
 	  machine ID number to use at compile time.  Some systems will be
-- 
2.25.1

