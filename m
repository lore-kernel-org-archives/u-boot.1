Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED310C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 00:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5218144A;
	Wed,  6 Aug 2025 02:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qPgX791C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gQHsUhFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B618483957; Wed,  6 Aug 2025 02:59:15 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE52283971
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 02:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxX3w2WLwz9t7d;
 Wed,  6 Aug 2025 02:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cM38luGqsep5R3P84KfyfTGcv6ZoD957lwO6e2J+NDQ=;
 b=qPgX791CcdAeqXGppKLlkxvQPxms/V5klquJ61fSdLRGfE83mOzLcyu+2kPxEc89QD7ywF
 LisfQ0bbaHPSivf371Ydef3RtKEwZJOHc2VY7flQonux+G4RNGGKM+A7XO0wNMgEmH8ly/
 Efg6GmbDEzAs9NA/HsI/dCOlAKd8P3T/f5Bq4198ua+7QRMxWcZurT6JDbBN/USWZVkVBG
 E2nbA2n66Nd5x3pk5cR8lqQkJwq0awOUrnJEqVGODzsk0Pfzd7jX5G29Q0rwXjKNyQG6J4
 pPjacUNUKIuXFkKCt6CUtffjSp+t0BwJ3r1r+m8Q0gpN/IOiQv6OUJtTHIKlqA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gQHsUhFZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cM38luGqsep5R3P84KfyfTGcv6ZoD957lwO6e2J+NDQ=;
 b=gQHsUhFZYC6WJ//1IjwNLYSrpwZVGPqCpqXds0pqwGIdmw24zncsd9CDJ3X9drLmPmRmfO
 WMpqSp9mKpJme89ZgAEUEhmCvt6TQkJvGIaXxxDaQ1d0ezPUjKATGGIt0sybQoM7G/jZR5
 e79CvVeBuc30I0aHv8caSDUBX1cw2EeMkbt0FlqK0sc8rAveZp8wr63HYRhmxjCxx4j7x7
 a87Xe5zdqntEwqerGcIPjsh2lPyonVMqCr0FM2cf/CW+fbDaYpRvdjd3sR+47IPZUqAu/T
 gRmaycVvqpjSbAgreBYTUEkgRMOgIlwgNAH2w3r7x9cVUUg/ECR7ubpHpsrH8w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Enable xHCI USB on Retronix R-Car
 V4H Sparrow Hawk board
Date: Wed,  6 Aug 2025 02:58:30 +0200
Message-ID: <20250806005838.284304-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9530ce1f138ecd077cb
X-MBO-RS-META: n73a77z7x8jadffut9dyyh4ensiphune
X-Rspamd-Queue-Id: 4bxX3w2WLwz9t7d
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

Enable support for PCIe based xHCI USB 3.0 driver and USB mass
storage support on Retronix R-Car V4H Sparrow Hawk board .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/r8a779g3_sparrowhawk_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index bb8d110dc0d..9cee4d287ef 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -25,6 +25,7 @@ CONFIG_GPIO_HOG=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_BITBANGMII=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI=y
@@ -34,6 +35,14 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_XHCI_GENERIC=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PCI=y
+# CONFIG_USB_XHCI_RCAR is not set
 
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.47.2

