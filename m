Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C67C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 19:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 320D5811E0;
	Thu, 30 Jul 2026 19:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPLJDK9f4VRN; Thu, 30 Jul 2026 19:05:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C1D9811EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785438325;
	bh=y6rUyiP1xjJ4l7d0z6kwxoO/LVPNDPv9SHgzfpHsPVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0MbJt9Ahd+q7gHrheQax25YtIkf0E/mPNQXuVvzeTdUZh8mNXb5O7WCvZUzJv65f
	 h274r5LWWX57zDF/apvUUBjHARLWBhOoe+AGHSUekUcSFA/IOTs9DJO/hM2rwamZeJ
	 DLLqCrG4st4YSy4kB4ycvEgAqAKPqdE1S9ALXjO3VauCb2IPUdQ5fhRKIeitJY2b0/
	 NzjSgQaD32ixEpbc+1BIrDrRIC6qwXEZfXS+hn8cu61bAywRey4S8/HBtBQ5jX8Gdb
	 xOMZKnCu4dcIeF3JJbdKVFR4vf0xkHS4GPimtGRdFK06/4Th4cROw6UQGMZR6dIY5c
	 0HgIpTaLHZ1sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C1D9811EC;
	Thu, 30 Jul 2026 19:05:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E141526C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7202405BF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVJXQZ8TAW6S for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:05:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ozndrgt@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A53D940CDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A53D940CDD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A53D940CDD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:05:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E24849F3; Thu, 30 Jul 2026 21:05:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307D2849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 21:05:17 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so1011975e9.2
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 12:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785438316; x=1786043116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6rUyiP1xjJ4l7d0z6kwxoO/LVPNDPv9SHgzfpHsPVo=;
 b=Dy+2V5+bscHl/U4T7HxPaabfbkm6W26x17s73nXiEUKU8c7YfMOAxQsbsGOfSsYEyv
 3B6l5RyzbKtwbAfWkcFDauwOzHn3ECN4HIZJDhRGWfpoQ/ai04Ziioav2aZ9kqJcO8ET
 CfzWIw6CZHw59fZlNYAX4GPCemwwnOi413ni7AjZzcgx1uz5C+ddrO6W1gJ8ql4laBtI
 PAY/8rGSsiub0xEx2E+8KukXKMT+hDhroK5ilVgY3DZYuiWTPHHvywBJJAacwHv3VQ5R
 5BxUB7fyY4YlCuaqc0QlB/19Y2SG0uiGISBZCtUgDwZfviJRYBjIfVRUJ0l5bZ5TTOBN
 BKsQ==
X-Gm-Message-State: AOJu0YxITot+T7AD4YHI/JeMr7rajn1OZI3ICRxHf1YOszHawzHl2EBz
 WL7y5CXPkNg4eDp5uuE9bqKi4UxkWpV6Ny52RCXa05DzLZOoRIsZ0oed
X-Gm-Gg: AR+sD12N31WZknfYrsNlumGf9MdxqMsGor2ueT0+HojFQxu/TL9MCHkxyI8ohurhlu4
 x7F2Z+tV5uuT54UEDRephwgUItjqan9DR9ICwt44yonF1LlaG83/6yFHyKEP9nf1j8jkeBX3yWK
 U0JRgTWl0fGXOWXYQlwsZw1vTILjKzWpo0BuPmVENS+TL1uZTL/gNB6Aus3mAGdkXoIzlMEGEnO
 SjvSsdI9RSVFtdM05C+nSw3fC/F5Am/ctH64VPaBuGJthBHBnMzd17qKjNZ4GkdYBtPlGa4D+bg
 3U2gmlGaC0c31/c3Q/ztziWciBvFmGuWJ/DKm+lcv7h7duKpyKq7Z4ymPZ+AcfPoWuxY08mzgMA
 rrTGd/AHqrJ+m9OYw5jWdx2AMgeDZzyC6paZfZjsf7eh7qg06PmT4o6k2udYYqLc75LwVo86Rea
 kSyQDPXcogXuWeEuW8StgYa3ySQbgUOt1Pbzs9ipVYOJyAWxwxXL9zj2ayJcB148AJGCom4FX+n
 T1DVJkhc3RL8tRK+LKQWKaFRuhzlJUrFf5nVIQoo40+Rv/EAPqOKmM=
X-Received: by 2002:a05:600c:628b:b0:496:c977:3b6d with SMTP id
 5b1f17b1804b1-49800e74e72mr59506105e9.12.1785438316234; 
 Thu, 30 Jul 2026 12:05:16 -0700 (PDT)
Received: from hp-15-dh1xxx.tail71a1d0.ts.net
 (port-92-196-144-227.dynamic.as20676.net. [92.196.144.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89351e3sm8867769f8f.29.2026.07.30.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 12:05:15 -0700 (PDT)
From: Ozan Durgut <ozndrgt@gmail.com>
To: Stefan Roese <stefan.roese@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: u-boot@lists.denx.de, linux@analog.com, Tom Rini <trini@konsulko.com>,
 utsav.agarwal@analog.com, Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v2] watchdog: adi_wdt: get SEC fault source ID from DT
Date: Thu, 30 Jul 2026 21:02:56 +0200
Message-ID: <20260730190256.114708-1-ozndrgt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730163621.83050-1-ozndrgt@gmail.com>
References: <20260730163621.83050-1-ozndrgt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785438316; x=1786043116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6rUyiP1xjJ4l7d0z6kwxoO/LVPNDPv9SHgzfpHsPVo=;
 b=Xtu8KhLZ2n7rvN/yaDc6CupMAMT6ZAxLA6WKylc8TYxVAmUhdUPjL7K/wECx1Vv2QZ
 W1vTdcp3rcWDaHXXdvZe5gXuMCkcGZKvB8nGJ0hJXdMMSJrVklXNuAN5NKINeRzw1SsP
 NC+rd8PGyF0Yxp8laJ77JdhFTLViRd50Nh0OXGfkOwtN9l4e2J1x32s2/1mN0sdLkUzN
 8i72MKo7vRqF2zzk67qahktPm78LNJZHpmr14C7de5flG/x9qVFeyoUUjZLeeapdx+mS
 pvXLAK9R7wu196gVw49CVltvxEehbHdehs8oRTWGWI1mJfIFwwJU97/siyIQzYjEjCC4
 qjmA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Xtu8KhLZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ozndrgt@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xtu8KhLZ"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: UtsavAgarwalADI <utsav.agarwal@analog.com>

The ADI watchdog drives a reset through a Security (SEC) controller
fault source. The source index was hardcoded to 3 in adi_wdt_start(),
which is only correct for the SC5xx parts that happen to use that
index; other ADI SoCs map WDOG0 to a different SEC fault source.

Read the index from a new "adi,secid" device tree property so boards
that route the watchdog fault to a different SEC source can configure
it. The property is required; if it is absent the driver prints a
diagnostic and fails to probe, which makes a stale device tree from
before this change easy to spot.

Set adi,secid = <3> in the SC57x, SC58x, SC594 and SC598 device trees
to match the value they relied on before.

Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>
---
Changes in v2:
- Rename the property to "adi,secid" (vendor prefix, matches the future
  kernel binding so we can switch to OF_UPSTREAM without a driver change)
- Read directly into priv->secid, drop the temporary variable
- Keep the property required and print a diagnostic if it is missing, so
  a stale device tree from before this change is easy to spot

 arch/arm/dts/sc57x.dtsi     |  1 +
 arch/arm/dts/sc58x.dtsi     |  1 +
 arch/arm/dts/sc594-som.dtsi |  1 +
 arch/arm/dts/sc598-som.dtsi |  1 +
 drivers/watchdog/adi_wdt.c  | 10 +++++++++-
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
index e4cc612959f..3eff76c9409 100644
--- a/arch/arm/dts/sc57x.dtsi
+++ b/arch/arm/dts/sc57x.dtsi
@@ -113,6 +113,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+	adi,secid = <3>;
 };
 
 &eth0 {
diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
index 7b07589de47..abc58adf847 100644
--- a/arch/arm/dts/sc58x.dtsi
+++ b/arch/arm/dts/sc58x.dtsi
@@ -158,6 +158,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+	adi,secid = <3>;
 };
 
 &eth0 {
diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
index c4373aea60f..bfb3dc6c889 100644
--- a/arch/arm/dts/sc594-som.dtsi
+++ b/arch/arm/dts/sc594-som.dtsi
@@ -67,6 +67,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+	adi,secid = <3>;
 };
 
 &i2c0 {
diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
index ac1f24c86c3..026ee11c49c 100644
--- a/arch/arm/dts/sc598-som.dtsi
+++ b/arch/arm/dts/sc598-som.dtsi
@@ -124,6 +124,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+	adi,secid = <3>;
 };
 
 &i2c0 {
diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
index 7d7cf98b55e..55a68ea0b32 100644
--- a/drivers/watchdog/adi_wdt.c
+++ b/drivers/watchdog/adi_wdt.c
@@ -14,6 +14,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <wdt.h>
+#include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -36,6 +37,7 @@ struct adi_wdt_priv {
 	void __iomem *rcu_base;
 	void __iomem *sec_base;
 	void __iomem *wdt_base;
+	u32 secid;
 	struct clk clock;
 };
 
@@ -72,7 +74,7 @@ static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	iowrite32(0xc1, priv->sec_base + SEC_FCTL);
 
 	/* enable SEC fault source for watchdog0 */
-	setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
+	setbits_32(priv->sec_base + SEC_SCTL0 + (priv->secid * 8), 0x6);
 
 	/* Enable SYSCD_RESETb input */
 	iowrite32(0x100, priv->rcu_base + RCU_CTL);
@@ -111,6 +113,12 @@ static int adi_wdt_probe(struct udevice *dev)
 		return ret;
 	priv->wdt_base = devm_ioremap(dev, res.start, resource_size(&res));
 
+	ret = dev_read_u32(dev, "adi,secid", &priv->secid);
+	if (ret) {
+		dev_err(dev, "Missing property 'adi,secid'\n");
+		return ret;
+	}
+
 	ret = clk_get_by_name(dev, "sclk0", &priv->clock);
 	if (ret < 0) {
 		printf("Can't get WDT clk: %d\n", ret);
-- 
2.43.0

