Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921A1C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44B9879DF;
	Fri, 23 Feb 2024 15:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="SsBt44XN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926F48573F; Fri, 23 Feb 2024 15:08:03 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEF78644E
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ThBdf4GL1z9t2L;
 Fri, 23 Feb 2024 15:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1708697206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lnIByoNq1+qAFlRJj0WtKn5K41Dr074DpMQ7EgzFw+k=;
 b=SsBt44XNPkXsFB7dbGqotUykINv2asqEhu84Y8b4aY0zW0UX4QloDpvcyb5bR/4UjfDfFY
 jWr8WZ3MslOAOYMt0BGjgq6OY1EePu1VZtBtnneXAQjCPHctmTYEMgEG4U5G4hHSih1so+
 mRz5idcXiNTyHlEJJfLN1IdlQO4CopYjiLFKTUONs0iUJGHiKcXPsOdrrESZoYJecsz/+I
 l31L5cvTCS/hSQFVYCFZ58q0ou9VgaXDxpNaYBxsnsU5jSPSLVCfKry8U8ptTvatCaQ9Z3
 HpI9F7p+rcJ0BxhmnvUcVCSVG9l9YqkM9vXbcmsdtoM5be+No1sdZP63yf+fqQ==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/5] configs: zynqmp: don't remove power-domains for spl
 device tree
Date: Fri, 23 Feb 2024 15:06:09 +0100
Message-Id: <20240223140613.1240570-1-lists@steffen.cc>
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

These are used during sdhci initialization as functions are called with
node_id even if we're not talking to the firmware.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---

 configs/xilinx_zynqmp_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 1fcae45e95d..a96b088534a 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -107,7 +107,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_BOARD=y
 CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.39.2

