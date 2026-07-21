Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5DCC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBDD1608B0;
	Tue, 21 Jul 2026 19:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tozR5N6WjC2V; Tue, 21 Jul 2026 19:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E5BC60611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784663830;
	bh=2jsi+RjxwWrjEXr3byYPhIzD7cRD7uJA5WQjNbYGytE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=AQP2Xk/OMEd9YwpCLqNXIdvCLdA3CpSQ6q8BN0LOF3SUd8Ii+2X9rHnikRGV+UG4p
	 Wp3rBZT42f1sq1fR6Z7aMy6M/2ejreAeZTOK167RX0g/0xa2IQmkAgq1h0yS7K3dfH
	 Kcd7nIg9FuWHIWPRp7iz89ISLmrh5xTuNKVgvutkb2QDDDttwWP+Je47cjZvphQKss
	 WAdXLhfM7NbVfg7WwVn2rOqvNPOwSoQM4Z6fYgoXQR6CbTHzwIHkq41x8TgoRsxsjV
	 mXioDDPMtPanZg7w2CkNXTBC9bDAvCe/Mz4dg1i/RkGpOqdf4NLkkodsu/zatJwEl6
	 z3GeK3FBLHSEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E5BC60611;
	Tue, 21 Jul 2026 19:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E12EC42A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6DC880DCF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nb2BUk3I5-rt for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:57:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AF30980DCD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF30980DCD
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF30980DCD
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:57:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h4Scm5JkfzKmwc;
 Tue, 21 Jul 2026 21:48:56 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Switch to GZIP compressed DTs on Renesas
 R-Car Gen3 Salvator-X(S)
Date: Tue, 21 Jul 2026 21:48:33 +0200
Message-ID: <20260721194852.398550-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: byi9jrfxcbe91ouipffc9nsyd9umbn63
X-MBO-RS-ID: d7bbf23252a62e9b887
X-Rspamd-Queue-Id: 4h4Scm5JkfzKmwc
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784663336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2jsi+RjxwWrjEXr3byYPhIzD7cRD7uJA5WQjNbYGytE=;
 b=QuNPM49zcGNZb+LK7sZr6et8zg9QWkNZ9HgMPmErPHMBbLLgLrUn/4U4p8lml+u/Q6Kk12
 HlkiO8SYhzu0vO4O0YJlkup8DfoEatUjdKHT+VHnAy6XZPuR0BQZpuA137ha8InDs9jNpd
 7TWcmC0uGt0NK30rEIy8DO5KMA3VFlVsDyf1TQ4VqNY/hNxJUvAugZKv4mWP5OE4VEkXwq
 cf6v9bQW9/U2a6EMIuJP85ZSACwUN/uO2qMxY+aD/db0DG+F0cOfWwFsSuCN09aVPO8+eu
 Ggd/bzRfR2nfETuX62AdHXQttDiw58Blcx8OaRzV/GdWWYgVOUWYUREkSGzYKQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784663335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2jsi+RjxwWrjEXr3byYPhIzD7cRD7uJA5WQjNbYGytE=;
 b=ZXCU1IrWlWJQk7G5Ndpzd4H3DfBqATyQUZfSNMEoBZ4gc6S8cjPKUAXjKuQGJeyuRcaz8G
 efu00e3IarYKFwONVKcl6Fm6az3kwX2aW8fB0JK5y7105NbVAYVTshzN2MvIXotNpEWQ/U
 SCm9BflySfIyxlAFsbG0PEMnNdk+5vP4VaaAKE7jVlAxOOIn22ucTkEEFv8gfb+nAnl5C7
 umcjZo/mjug5RrO4/kOUD/YySWJwp73FW2efOckh89zarkE/ePdMAVAjU01JdA3OsycKph
 fztO8rlijsBSrKukF+Azvy7tl28uEdk5urDZpQkuBsufwyeAegDmYE6PrjQzUw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=QuNPM49z; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ZXCU1IrW
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZXCU1IrW;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch to GZIP compressed DTs which leads to better compression
ratio and saves about 7 kiB from the resulting binary compared
to previous LZO compressed DTs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/rcar3_salvator-x_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 7adaf665a35..3c078feef51 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -32,7 +32,8 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_OF_LIST="renesas/r8a77951-salvator-x renesas/r8a77960-salvator-x renesas/r8a77965-salvator-x"
-CONFIG_MULTI_DTB_FIT_LZO=y
+CONFIG_LZO=y
+CONFIG_MULTI_DTB_FIT_GZIP=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
-- 
2.53.0

