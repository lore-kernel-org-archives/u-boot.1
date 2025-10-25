Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F49CCD1BF
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 21:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EFF83045;
	Sat, 25 Oct 2025 23:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lLMIsVuG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gbIumSmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4742983771; Sat, 25 Oct 2025 23:35:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722DE836AC
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 23:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cvCkL22Grz9sWc;
 Sat, 25 Oct 2025 23:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761428154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4wPg1CKN4418e2GLwJwD3NO5/4QFEN9ZrQQCPIj1Yqg=;
 b=lLMIsVuGmPDxjd4OV8Zpf8+rfnhNZRzAd0n8ssUWQatyaYvKq6AOICGUp7yE4dpvbgW7mA
 DFeunj3gjdoqkpTMR8cxCn+Ex7dE+CrmD/Zv6/HQR4Ty4g3XpLfWMjbWlUpCQ/suObANjv
 RXr3TTCIvV8V9wuAlMu+2De379xIoxg9lNvOLPK7jI3fQkZWcDo0CVQ5ijCTB57VBFHcPp
 NPtCDBBe1WGvqEQH1gtURj+yqllYlMYM0HqyeavtwkumQkUMDZDrRdRAW4rrUqXFUeRIJV
 h+i9ipE5rWsZV5guJxwPAH+43fjFSxcJtDQBqY/iZXp8PHyz1fpRWX6Mm31JqQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gbIumSmG;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761428152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4wPg1CKN4418e2GLwJwD3NO5/4QFEN9ZrQQCPIj1Yqg=;
 b=gbIumSmGnF3utcnYWD/u4aeuwjd1Y+o/IB6G71TuLY1kWjQPWMChu3kt4RbJQRqVv1UdrX
 Ny16UJFNZmllo90BI+K61Fhqh9dsb+AFdcoxRGTT9kOn6Y55qjuKxhkAbuht0nSVjbQZfC
 b+hTp18jeCyPmBbTUkzQHfsaosuMESXAXH03fj0wrJ2Jy/MoeGkMQ4G/kLpVuuDnZdnOlt
 gumeB2/6i3BiJG+vIIP2eIQmahLjDQZ54FZDBtv1EfuQmXLAKu4DRNYnVRRtxu1EtSy4Te
 tYyNVDv8qN+XusE8s7EMrAy8Lt1Wd0Q+PqcX3YsVZJxNg/yC2cJEqxd9i2wFvw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour() misuse
Date: Sat, 25 Oct 2025 23:35:09 +0200
Message-ID: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: heomty6u87diquojp7sp3tdwj1abma61
X-MBO-RS-ID: 56bcf681a0a55506dfe
X-Rspamd-Queue-Id: 4cvCkL22Grz9sWc
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

MMU region cache behavior configuration for SCMI/SMT mailboxes is
platform specific. Even on ARM systems, the mailbox memory may not
even be located in any cacheable MMU region and may instead reside
in some SRAM. Remove this non-generic cache behavior configuration
code from generic code path.

It is unlikely that any platform is affected by this change if it
did configure its MMU regions correctly on start up. Platforms
which might be affected are i.MX94/95 and STM32MP.

Fixes: 240720e9052f ("firmware: scmi: mailbox/smt agent device")
Fixes: 2a3f161c8b16 ("scmi: correctly configure MMU for SCMI buffer")
Fixes: b2ae10970d40 ("firmware: scmi: use PAGE_SIZE alignment for ARM64")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Etienne Carriere <etienne.carriere@linaro.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: Viorel Suman <viorel.suman@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/firmware/scmi/smt.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 237871559f0..cd1c0801f72 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -61,20 +61,6 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (device_is_compatible(dev, "arm,scmi") && ofnode_has_property(dev_ofnode(dev), "mboxes"))
 		scmi_smt_enable_intr(smt, true);
 
-#ifdef CONFIG_ARM
-	if (dcache_status()) {
-		u32 align_size;
-
-		if (IS_ENABLED(CONFIG_ARM64))
-			align_size = PAGE_SIZE;
-		else
-			align_size = MMU_SECTION_SIZE;
-
-		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, align_size),
-						ALIGN(smt->size, align_size), DCACHE_OFF);
-	}
-#endif
-
 	return 0;
 }
 
-- 
2.51.0

