Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316C3CD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FE384C00;
	Fri,  8 May 2026 00:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="af57+PHT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MRn1Yq4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 730D284C01; Fri,  8 May 2026 00:05:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EDF84BC7
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBRBt62lTz9tFm;
 Fri,  8 May 2026 00:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=krYKVF/SNQ9HBp2AHzn5wElA6tm8vcZMG7P5Ca0M768=;
 b=af57+PHT5lEUNgUrOIClrDIsaLJwZCQhlvuBy/gPJKDNsCVbDY8w7JnvCcKNph8hMQdNYs
 I4gu0VZONwl1joZ5F/fX8Dw4c4yP6hm6aObElFQdXtlKJaOXL9212qytPZppuBRK1N474L
 tt8+ZxeIBEuxyoPhcox//dikU6k0omruV+QBGYwp4DqaaHBrFspd0xsywiCxTjPlEWvwSG
 /mINchl5PLutxFiPxQKb4mH/QVzSGwFO9ru9d+cNXs0LgYpVVZ1y9L0KLUWRWuoBX8erSB
 9LFS2qvNB14rJZooZUD6fH/YBakGL5+30jSvjk573p2V1ohyXakr4QAj4el5HA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MRn1Yq4S;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=krYKVF/SNQ9HBp2AHzn5wElA6tm8vcZMG7P5Ca0M768=;
 b=MRn1Yq4SluB3/ZiEtKpnOtQi5I2dg1Bn0tqDf+/j8IDuUwA5mIjWKgAPN9v3MQmigZjg+k
 ZSB1S11CSZrgRpLD6yL9hw8JSOJU4jWtxDjN6XEYpBC+Rtd9a6AshRau/A//VwislGRX1m
 P0yP/U3pHCtMtgqHGj4ieLU4ALLionrbdxSDAz5XKyoYQlLEPys6at/J5SH10JqLWTB+Qq
 gl9JF47n1zAWmFk7HgBAPZOq5bC7gUyvGNU6dWpp/WUZpqC8mqHfLq4AIcJRiv6oQ3pQxn
 6C+W08d7F33tDIrubE2qkwqO7UfpW9XQmdrZ2up3xBJ75Nl1auuEIlt43Llffw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH] firmware: scmi: sandbox: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:05:09 +0200
Message-ID: <20260507220519.209085-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fw76k7xticwbxok9tbus4phshfzx9nc4
X-MBO-RS-ID: 31733b0e837c7411cb0
X-Rspamd-Queue-Id: 4gBRBt62lTz9tFm
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 010bf99fbc6..832bfb55711 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -1341,7 +1341,7 @@ static const struct udevice_id sandbox_scmi_test_ids[] = {
 	{ }
 };
 
-struct scmi_agent_ops sandbox_scmi_test_ops = {
+static const struct scmi_agent_ops sandbox_scmi_test_ops = {
 	.of_get_channel = sandbox_scmi_of_get_channel,
 	.process_msg = sandbox_scmi_test_process_msg,
 };
-- 
2.53.0

