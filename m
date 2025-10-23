Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16595CCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B7583631;
	Thu, 23 Oct 2025 23:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yDV+dTNs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XMjFJFAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F140832BC; Thu, 23 Oct 2025 23:49:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F7A8003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ct06d0nnLz9v4P;
 Thu, 23 Oct 2025 23:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=li5U7VeG22caadE9S9YNPgp4M1x5MlFKrYxqbEdqmTY=;
 b=yDV+dTNsnVcPH675NF6qY3lnsm1jW8ZXQG1R6W42X4MYqV1Z6A+NrE4xN6ilEJz8sPapjB
 Zy/zkTbGfkKe6Y3aSLqtHvNScf0l+YnUCaeZ3oBHgFZ8+vbynpLs/JihmtRiZI+HzBMu9P
 dGKochqg+VRhEi/jy1SNFDs2wbEUyf/SMQSr13D9z/8v4Mu9ioIopwSlCa+HamTOK2vfUq
 di+BUNdPsVSfi9mCTAG94ezQ1Y+qYO2Dfy893jXjcZtDihHtmVmIykVT/f1Moe5UmpPGvs
 Ren4CqsLVR9pIo1fbSB71MNjcoV3oOKiZs7xiLOZQHVM3JSWAAcP76PFLp1Zng==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=XMjFJFAT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=li5U7VeG22caadE9S9YNPgp4M1x5MlFKrYxqbEdqmTY=;
 b=XMjFJFATTjVKMHTbzICvuQPu/8TqEO0gj0yhwssZTBi9fUjR6iey273949+8npitdF/iwn
 GljoiXYA2czJ6YefM0xVVLhcJBuCMFyBkkOD6q7h0BG8W1rBCoZ0xF4s4KXpwZu+/N/ENg
 V4RDXgtCQQR82ACgckkBJSS/WTKiKw4ch88m48QxA4bgUVBh3PYSMtAbD9qgEDXWAhxT3S
 /DgwK5nlsCorFK0yxF+GNs6gcaI8wVXXoHNAZxSX4ojbAuJpjgOYbnAlncWKsNFBpL6pZg
 yuA+CA1voJaIG1CyagZ2LftOumBS0hui6M7Hs7lha4S/vzUbtxTbcQkNVeUNFA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] ARM: stm32: Add MAC address readout from fuses on DH
 STM32MP1 DHSOM
Date: Thu, 23 Oct 2025 23:48:26 +0200
Message-ID: <20251023214855.181410-3-marek.vasut@mailbox.org>
In-Reply-To: <20251023214855.181410-1-marek.vasut@mailbox.org>
References: <20251023214855.181410-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dcdd40aaf9eefe5b2e7
X-MBO-RS-META: fu5y7tsq4zt1n7867yikgzxgzbicjzq9
X-Rspamd-Queue-Id: 4ct06d0nnLz9v4P
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

Add support for reading out the MAC address from SoC fuses on DH STM32MP1 DHSOM.
The DH STM32MP1 DHSOM may contain external ethernet MACs, which benefit from the
MAC address stored in SoC fuses as well, handle those consistently. This however
means the architecture setup_mac_address() cannot be used and instead a simpler
local fuse read out is implemented in the board file.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/dhelectronics/dh_stm32mp1/board.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 065d2f338c2..c18f1911fe4 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -119,6 +119,29 @@ static bool dh_stm32_mac_is_in_ks8851(void)
 	return false;
 }
 
+static int dh_stm32_get_mac_from_fuse(unsigned char *enetaddr, int index)
+{
+	struct udevice *dev;
+	u8 otp[12];
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(stm32mp_bsec),
+					  &dev);
+	if (ret)
+		return ret;
+
+	ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_MAC), otp, sizeof(otp));
+	if (ret < 0)
+		return ret;
+
+	memcpy(enetaddr, otp + ARP_HLEN * index, ARP_HLEN);
+	if (!is_valid_ethaddr(enetaddr))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int dh_stm32_setup_ethaddr(struct eeprom_id_page *eip)
 {
 	unsigned char enetaddr[6];
@@ -129,6 +152,9 @@ static int dh_stm32_setup_ethaddr(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
+	if (!dh_stm32_get_mac_from_fuse(enetaddr, 0))
+		goto out;
+
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eip))
 		goto out;
 
@@ -154,6 +180,9 @@ static int dh_stm32_setup_eth1addr(struct eeprom_id_page *eip)
 	if (dh_stm32_mac_is_in_ks8851())
 		return 0;
 
+	if (!dh_stm32_get_mac_from_fuse(enetaddr, 1))
+		goto out;
+
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eip))
 		goto out;
 
-- 
2.51.0

