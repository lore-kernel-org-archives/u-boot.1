Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B83C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 18:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9496087572;
	Thu, 23 Nov 2023 19:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC6B87572; Thu, 23 Nov 2023 19:23:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F2A0886FED
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 19:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=robert.catherall@foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B38A61042;
 Thu, 23 Nov 2023 10:23:52 -0800 (PST)
Received: from e123340-lin.cambridge.arm.com (e123340-lin.cambridge.arm.com
 [10.2.75.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4FF3F7A6;
 Thu, 23 Nov 2023 10:23:05 -0800 (PST)
From: robert.catherall@foss.arm.com
To: robert.catherall@arm.com,
	u-boot@lists.denx.de
Cc: andre.przywara@arm.com,
	liviu.dudau@foss.arm.com
Subject: [PATCH] arm: vexpress64: juno: Allow boot from VirtIO
Date: Thu, 23 Nov 2023 18:22:58 +0000
Message-Id: <20231123182258.15928-1-robert.catherall@foss.arm.com>
X-Mailer: git-send-email 2.17.1
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

From: Robert Catherall <robert.catherall@arm.com>

The AEM and Juno FVPs (Fixed Virtual Platforms) support a VirtIO
disc interface. Adding VIRTIO to the list of boot devices allows
these FastModel platforms to boot from 'disc' in the same way
the hardware counterpart can boot from SATA or USB.

This is a NOP if CONFIG_CMD_VIRTIO is not enabled, so no impact
on Juno hardware (which is built with vexpress_aemv8a_juno_defconfig)

Signed-off-by: Robert Catherall <robert.catherall@arm.com>
---
 include/configs/vexpress_aemv8.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
index 24d8ca0866..8020689e39 100644
--- a/include/configs/vexpress_aemv8.h
+++ b/include/configs/vexpress_aemv8.h
@@ -187,6 +187,7 @@
 	func(USB, usb, 0)		\
 	func(SATA, sata, 0)		\
 	func(SATA, sata, 1)		\
+	FUNC_VIRTIO(func)		\
 	func(PXE, pxe, na)		\
 	func(DHCP, dhcp, na)		\
 	func(AFS, afs, na)
-- 
2.17.1

