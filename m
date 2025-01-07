Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE7E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 16:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8F9801E8;
	Tue,  7 Jan 2025 17:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=xes-inc.com header.i=@xes-inc.com header.b="chAnwSxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD77801FD; Tue,  7 Jan 2025 17:21:27 +0100 (CET)
Received: from mail.xes-mad.com (mail.xes-mad.com [162.248.234.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5AB801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 17:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vfazio@xes-inc.com
Received: from vfazio4.xes-mad.com (vfazio4.xes-mad.com [10.52.19.201])
 by mail.xes-mad.com (Postfix) with ESMTP id 9F02D20401;
 Tue,  7 Jan 2025 10:21:20 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xes-inc.com; s=mail;
 t=1736266880; bh=kY2YRKV3XhBiLLcRyMTPYKSOeLlfOUWFde0xk7W0kjA=;
 h=From:To:Cc:Subject:Date:From;
 b=chAnwSxa8179p5k/2twpXWsNZeK5SDo9Y88tYl4QK58y5Dd8nWMwo1ZLsda5QPBDs
 rNEdJdWtaUodzbmUcTqKcw0wpJiRuKSg/j+5mxwrTf9PdiB9W8at2h/An37fGeHX3p
 36nsbYchuj0ZVQUae0Y24wD9DsW+s9tr0Z8NoQ+E=
From: Vincent Fazio <vfazio@xes-inc.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Vincent Fazio <vfazio@gmail.com>, Vincent Fazio <vfazio@xes-inc.com>
Subject: [PATCH] rtc: zynqmp: allow on Versal architectures
Date: Tue,  7 Jan 2025 10:20:44 -0600
Message-Id: <20250107162044.195633-1-vfazio@xes-inc.com>
X-Mailer: git-send-email 2.34.1
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

Allow the ZyncMP RTC driver to be enabled on Versal architectures.

Signed-off-by: Vincent Fazio <vfazio@xes-inc.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 9c2d1398247..ecdcfe1f240 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -294,7 +294,7 @@ config RTC_DAVINCI
 
 config RTC_ZYNQMP
 	bool "Enable ZynqMP RTC driver"
-	depends on ARCH_ZYNQMP
+	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	help
 	  Say "yes" here to support the on chip real time clock
 	  present on Xilinx ZynqMP SoC.

base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
-- 
2.34.1

