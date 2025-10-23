Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E01CCCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09C98006D;
	Thu, 23 Oct 2025 23:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kZjQmIoq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pYyx0U0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AFB807C0; Thu, 23 Oct 2025 23:46:32 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA1D8003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ct03T5cC4z9tk9;
 Thu, 23 Oct 2025 23:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761255989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qUy8WcVhhs1DyLTOiIPfn3Q+cT0AlpAxZNoqw5IJohU=;
 b=kZjQmIoqYRnbZlC+1chq0309MvexIUUMHvIKPxEZ/jDvwCx3Q7fWdH/UJhr4idlXmXyqv8
 JdLkiLW15ZgIJQ9HPABjxAKdssdW4D/gf+tl/8n9rL69EiV4ku0VZFV7CeFiXzAgDFjmv2
 6GDKFnv2SSWFz4t0VhiZMcXvOVXQjLvwjTuchI8CDRPCR/bg1jeItoGaFnWKiKNLVZ+gUS
 ysQSl+hnbBw3fphM+TzhzPOW32viC5bJpSlLDarKm65dm84ZWtJh7AjlwR+MW8Pk7vWOtu
 DqFPinHvbljKDZpRPWTzD9JhS2EdgMV9bbmlvcGHbG3ePEi54Lvb+EYb1BlLBg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761255988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qUy8WcVhhs1DyLTOiIPfn3Q+cT0AlpAxZNoqw5IJohU=;
 b=pYyx0U0ZrA5yPf6ZhNrihBdyUGS6q+2fUjNuGProBRT8mWx+XFbM2GMIgV5P41XuViUF/9
 i4BQIVC0vJAGu1EKz+aU1GbBgRo5LjKgFGpd7YhJnC0le9yvhNKxEz0CjALcDHGbOcyg96
 uGL0DtH9Ruv5GQJ826YqUihPgj/GUEEYbHav/W+3l2J+1qWm9UBlz6sv6sGbChyWWZ4s3d
 w0kMGI/kGN9rHGoMzuZHukLizPU7OW/uBU6pLCpYvJKX4T/SX6qoSWjWAf9lGwy7HWK8M6
 gwMRxCQjbms6c/b+umhD5v72IU4QIkrUXnuStm2FCf9BAi/nMYyWEdNs2BFCLg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due to
 ETZPC
Date: Thu, 23 Oct 2025 23:46:05 +0200
Message-ID: <20251023214614.181165-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ajamhtpbyzaxx51k96s519bnjyxm6wrx
X-MBO-RS-ID: ddacfc0b436078df4d9
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

Switch etzpc bus to simple-bus to prevent breakage on non-TFA systems.
This fixes boot of every STM32MP15xx DHSOM device.

Fixes: ad3cdc677dda ("ARM: stm32mp: add ETZPC system bus driver for STM32MP1")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
index 386c605c07f..ed2629f379a 100644
--- a/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
@@ -51,3 +51,7 @@
 		};
 	};
 };
+
+&etzpc {
+	compatible = "simple-bus";
+};
-- 
2.51.0

