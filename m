Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD4FC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAF2980F5F;
	Fri, 28 Aug 2026 13:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKsEq-yYt0bg; Fri, 28 Aug 2026 13:59:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925546;
	bh=jSDS97C6bT9H4DlJZt9lNpD0i5mCYqTJN3g9tip9t5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCuX0CIKEAL6su80qRU9a1/zskUyx2Q0S6v6Mwb2lxDkaeCUelBhfTM4iN4s/48x4
	 tY2clZ+xO9jwk3z6oDIGVgCHr1tHTC1YEegmcMNmjVe0T55ms19ooQhWoEo/gpTANo
	 2sQeIjM0+AgRvHQhPWtqyMnoSaaE6rREDwOBnuO5K7jAp4yOHODFWysITQfDP/O0yq
	 hkeSoZ6/thYyOYS9Epwja1UYsbHAUL4tGAB9FKCfzJ2hVHshkaqOEAFVLQyDdLbMyW
	 iJospMaYbIsUdfg2Gb7N3iwB94pT0NE4BsbO7pXquejMXXUZYiAYqQ+quvfXuFKiGK
	 vYj6E88oL0M6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE76A80F61;
	Fri, 28 Aug 2026 13:59:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 624FC334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5482280F48
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zryJApNPzPCV for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:59:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=FlSu1n1u
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FE5080F61
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:59:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 50F101A18A4;
 Fri, 28 Aug 2026 13:59:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1DBF860537;
 Fri, 28 Aug 2026 13:59:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4DD611C781DF; 
 Fri, 28 Aug 2026 15:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925535; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=jSDS97C6bT9H4DlJZt9lNpD0i5mCYqTJN3g9tip9t5I=;
 b=FlSu1n1ufKMrqLPmfkVGWbv3ufN4HplaCJUAyGM23aVfgOP3jXMDwJ3QF+KL53RA6brLSc
 IUzcGpbYqDTynJmYkRufRsAt4nNS8CYydM5iFERu9bjczZ9PhGyraOsKYp/TluV6PNRh3Z
 1Tg42JJQkwZxvpbLxB6pydv2cVXGJcIknR/QTnZztMBhIhJ7e87kNsv04KVELSI3TbRR1J
 L+PrImPQJA/PDTn1mHa6SY0AyWO3koY7COqpVN6ZmnSGpkP15XgYAKdG/HLCMOaNDH7CJO
 8/schbDzxAfC0zoQl0H9jmc0nDy0TVsxtU4DtO852t9LSVd5i8rS8vdrZJfvTw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 21/21] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
Date: Fri, 28 Aug 2026 15:57:30 +0200
Message-ID: <20260828135730.1565643-22-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-binman.dtsi | 7 ++++++-
 arch/arm/dts/k3-security.h  | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03b..1cf417ed7dcd 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -475,7 +475,12 @@
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
-						FWPERM_SECURE_USER_RWCD)>;
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
 	};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb5..3e066bca6ad7 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS   0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
