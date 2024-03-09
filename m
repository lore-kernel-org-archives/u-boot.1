Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C3C54E58
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 02:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B85187EDD;
	Sat,  9 Mar 2024 03:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709950752;
	bh=PAeI9NCzFDhe9XGHiw2jaLdV4s0b4fBGC43SKyY6pCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZWj8l54H/yP3vpf3OZC5lP5bZ5eQP+gSjsEDMPuseRUUgzn3MjYDjw7gq8ETW67O
	 AASIcJ4BzLxiOVMYB70t/Sev762IeXoJqb2R38496BiJ44Wo4gZxpa2gpD2Yvrp3WP
	 x+8IqnmMaAvbRNsMbQZS5G8oFUwFK000FSnpqQklR5WB0qmUsAxF7A1SJ1PX0cSeWN
	 B/i2Eid9jxoY9U9rPHltP/+sRrws/rRq105RASpQJ20ElqOZ4W8sv4ZJ34q6z6zc5V
	 QzCsqDCmdhJ8/tIP3dG3NxMUPoSGZ6hXsOTDl6ieRgadi4yAi/dTjhPVG/PeR29wc1
	 olAf49/qy7Ixw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6097C87DDD;
 Sat,  9 Mar 2024 03:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709950740;
 bh=PAeI9NCzFDhe9XGHiw2jaLdV4s0b4fBGC43SKyY6pCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qKGi4pLVcOTGX50h6WUCqkRrJOfCx54y3AXmaavONaCAzbnKKh/TvOEezDANqiwbf
 mjdoT7ReBq+rZiAmeHcnsE/HMbomXK6jqHIlXkHbhxg/yumPyLqwzvFHFL5hXJqPRR
 tqR/9kFBE7SvInqShnF0K9vWH0yTRcXgifpdV//+6gbtbA8QTd61IADQzwlO0tunGN
 1n01tAMaZX8VTp4TeeOqWwTASGzkufX9EQCj0EHtFajSFNoeKTKarSJsQcczMD7TfD
 G/86uTw1ooNA8ljmxUMQClERjZGk/GkCCR7lNc3dEdZ1HcxW9fMmJCd+gSFKV6BZ7j
 Ew8IQgeXjdg5g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/11] net: dwc_eth_qos: Request clk-ck earlier in probe on
 STM32
Date: Sat,  9 Mar 2024 03:11:30 +0100
Message-ID: <20240309021831.264018-10-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309021831.264018-1-marex@denx.de>
References: <20240309021831.264018-1-marex@denx.de>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Request the clk-ck earlier in probe in preparation for obtaining
the clock rate from these clk-ck in eqos_probe_syscfg_stm32() in
the follow up patch.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/net/dwc_eth_qos_stm32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 33477925ff1..4db18130765 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -201,6 +201,11 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	/* Get ETH_CLK clocks (optional) */
+	ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
+	if (ret)
+		dev_dbg(dev, "No phy clock provided %d", ret);
+
 	ret = eqos_probe_syscfg_stm32(dev, interface);
 	if (ret)
 		return -EINVAL;
@@ -223,11 +228,6 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 		goto err_probe;
 	}
 
-	/*  Get ETH_CLK clocks (optional) */
-	ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
-	if (ret)
-		dev_warn(dev, "No phy clock provided %d\n", ret);
-
 	dev_dbg(dev, "%s: OK\n", __func__);
 
 	return 0;
-- 
2.43.0

