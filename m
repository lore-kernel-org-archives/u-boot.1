Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF7E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8830A805CD;
	Tue, 14 Jan 2025 14:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=xes-inc.com header.i=@xes-inc.com header.b="KTmsLQUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637908060C; Tue, 14 Jan 2025 14:58:17 +0100 (CET)
Received: from mail.xes-mad.com (mail.xes-mad.com [162.248.234.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7528022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vfazio@xes-inc.com
Received: from vfazio4.xes-mad.com (vfazio4.xes-mad.com [10.52.19.201])
 by mail.xes-mad.com (Postfix) with ESMTP id 0F80B2018A;
 Tue, 14 Jan 2025 07:58:14 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xes-inc.com; s=mail;
 t=1736863094; bh=N9SU5sA/fwgNPZFpE9lWwT/PHXltsbV8u+AgJeGlsz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KTmsLQUsldhLKXwt8LVw41EtEW8sl4e6+ZxIv+T0eJUG76vgRqRlhos1p2tQzSstZ
 bkDzSpyyaWJQShFWFHoN2aVQPlUcva5YhVYWj4RqIiQ94B9TyfW6nGcFCRznlDEBTa
 v2Ta8i6tRqMX2JaQkfq0R02IknNwNH3VWXB506GI=
From: Vincent Fazio <vfazio@xes-inc.com>
To: michal.simek@amd.com,
	u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vfazio@gmail.com,
	vfazio@xes-inc.com
Subject: [PATCH v3] rtc: zynqmp: allow on Versal architectures
Date: Tue, 14 Jan 2025 07:58:12 -0600
Message-Id: <20250114135812.2605618-1-vfazio@xes-inc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d2ae2c87-8c0c-4496-8767-1ce5b28fbfac@amd.com>
References: <d2ae2c87-8c0c-4496-8767-1ce5b28fbfac@amd.com>
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

Also, require DM_RTC since the driver uses the RTC driver model.

Signed-off-by: Vincent Fazio <vfazio@xes-inc.com>
---
Changes in v3:
- Revert a typo in the help text

Changes in v2:
- Add DM_RTC dependency (Michal)
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 9c2d1398247..6467f20422b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -294,7 +294,7 @@ config RTC_DAVINCI
 
 config RTC_ZYNQMP
 	bool "Enable ZynqMP RTC driver"
-	depends on ARCH_ZYNQMP
+	depends on DM_RTC && (ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
 	help
 	  Say "yes" here to support the on chip real time clock
 	  present on Xilinx ZynqMP SoC.
-- 
2.34.1

