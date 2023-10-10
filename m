Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FF8CD690B
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A1486D78;
	Tue, 10 Oct 2023 10:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aPq62rog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D28F286D9C; Tue, 10 Oct 2023 10:52:52 +0200 (CEST)
Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com
 [101.71.155.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79CD86B1B
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aPq62rogD66XvY55dD3/CLLk3fJrJA+F/qTJ2+nWzYeBBX6FXItW6ak5qfe1LLKR2sfnfszLMeVqkT+UwXPFDKoD6L9KnV+B5yJesWj45oxTsZM7BvtApA+xiOng6M20cHdRjFcnQ70eM+f7GQl7iKiNMvlUgUjkO2Yt4stY1JY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=uUpxbC086Ca3KnqRLPabkJw8IiJaOWmIjD4mecAA76c=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id DEA0D4003BE;
 Tue, 10 Oct 2023 16:52:06 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 1/7] rockchip: dts: rk3568: Resync from kernel-4.19
Date: Tue, 10 Oct 2023 16:51:49 +0800
Message-Id: <20231010085155.31027-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010085155.31027-1-zhangqing@rock-chips.com>
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwfS1YYQ0oaT0tMQ0MdTktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b18c94b272eb3kusndea0d4003be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6ESo6ETw9CBE2GRwMLyEo
 KwMKCTBVSlVKTUJNQklMQklMTEpKVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpCT003Bg++
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

Resync from kernel-4.19:
(a6cf6aca12c0 drivers: rkflash: Ajudst the dll strategy)

Change-Id: I7b7134946b76dbd8963cfaafdc5b56750622855e
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3568-cru.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
index c1942422a438..251445cf7632 100644
--- a/include/dt-bindings/clock/rk3568-cru.h
+++ b/include/dt-bindings/clock/rk3568-cru.h
@@ -478,6 +478,13 @@
 #define CPLL_50M		415
 #define CPLL_25M		416
 #define CPLL_100M		417
+#define SCLK_DDRCLK		418
+#define I2S1_MCLKOUT		419
+#define I2S3_MCLKOUT		420
+#define I2S1_MCLK_RX_IOE	421
+#define I2S1_MCLK_TX_IOE	422
+#define I2S2_MCLK_IOE		423
+#define I2S3_MCLK_IOE		424
 
 #define PCLK_CORE_PVTM		450
 
-- 
2.17.1

