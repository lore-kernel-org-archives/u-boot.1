Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C5CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 22:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91E98465A;
	Tue, 12 May 2026 00:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jbdmZeGp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SAEJNLpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 416408466E; Tue, 12 May 2026 00:59:29 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A11684659
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gDwCH020Fz9t6n;
 Tue, 12 May 2026 00:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778540363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zz8hb62EJzlWsfwj03uLJOEoT3y9pbXgvyV+BlbUD8E=;
 b=jbdmZeGpQIYif379lzLFcCCCJnVKzE73XcvCeIGxocPqN25/Knv7bCJoAJODyCqsDpunB8
 g8tdM8j7a46TVV3HS66joonCEcRNSbLlF6Anzo9Qifrfz/e7T265t30VhMVMuOmU0sQ64Z
 UdLfPsax0+gAKGViacMUycQyxwTTd8csr4FpgnMlICiRSkqrvbcXQOoAMu2UqJhw3UTQ5L
 XYSdleBg5V9zDmJHEWz3Vqv2jSRtPjXLq5qaMdFe23c3UaQGSXC6jxL9SAQNL4dQhC2niE
 1u9KMYaDE9cGIWHB1FRI2LCvw7r8AQoXyrCqNvcWH/TAzJeGTNhbayTIlY3yBw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SAEJNLpr;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778540361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zz8hb62EJzlWsfwj03uLJOEoT3y9pbXgvyV+BlbUD8E=;
 b=SAEJNLprMJmECtFqRuqpZ6CTvdRMOd1QbjJZMqpBOxhuiQVxt4jiXbUpnAeReJGrxeDPpc
 rouw+xV0+9Hh0gt2bEgQRKbszPFVch8I4qVgKcljkwhHj9iBHrFCQMC9SvnwM+dlNoKRob
 uoBY5eiyvlCVRHBZqoVV1lhbEr0CztX/OdB+TKgiYNxWq0eX6FPeYu/fpqXNppos6VO5t4
 v53E0bJMKa2LNWfT9Ht1GCZ8WHcMlteIFQ9onEQQ1T/xEeB6H+iOFquCqgUUbTR4RhR+bb
 BDW+MdU16Lsb11CgTgPbH6fz62Y8RC+wfS33sWJWA3Z8sCWnyBB7pTB7a249tQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Fix typo in linker script
Date: Tue, 12 May 2026 00:58:59 +0200
Message-ID: <20260511225918.28543-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 215522ec2fde05b366b
X-MBO-RS-META: mxco7noqnithqjnwmuiygcb9ia4746ju
X-Rspamd-Queue-Id: 4gDwCH020Fz9t6n
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

Fix typo, addreses -> addresses. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/cpu/u-boot.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 8e2266a90fe..98b0306f3b2 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -96,7 +96,7 @@ SECTIONS
 	{
 		KEEP(*(.__secure_stack_start))
 
-		/* Skip addreses for stack */
+		/* Skip addresses for stack */
 		. = . + CONFIG_ARMV7_PSCI_NR_CPUS * ARM_PSCI_STACK_SIZE;
 
 		/* Align end of stack section to page boundary */
-- 
2.53.0

