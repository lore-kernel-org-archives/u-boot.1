Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58756CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 01:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C5C833ED;
	Wed, 24 Sep 2025 03:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EU/R3A2/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y6EyAxkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7001280107; Wed, 24 Sep 2025 03:47:55 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C67180B9B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 03:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWfqs23YHz9tdp;
 Wed, 24 Sep 2025 03:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nK2eaxhvwzZFFQCl77s7dCYl6ywSrw8DQVl9+WlaxNo=;
 b=EU/R3A2/tj2m5e/ewquGM+g/JP7ueYcJK1ILH3IsXFkgQqvWDw1edbmmCOprD9D/40r7Ea
 s7m8fj6iOukYwO8s4ykknfznrCbCEYk3GjjeSb0m5//FGEx6vIWrEK8orMBXm0280uuo8B
 9VY7T48nBmPTXX0/kdxHmxT+eVscHMcbO2SQQYQSil6MOnEsTtuS6PSEMJ+ctg4KGbwCF9
 NeCd5ZL9P2uy4fx/lU9FxEhXB0k5H2WGAeLU4dmBdHMBcAytHnMHS0CXJAZqenN59aRiMK
 eNtGjLcteW/B8jZXreQAMIwvYpgxA2YpBc6iC9mzMRefbwR9ZZLSqnUmrFK5ZQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Y6EyAxkH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nK2eaxhvwzZFFQCl77s7dCYl6ywSrw8DQVl9+WlaxNo=;
 b=Y6EyAxkHlcNoXr90lkLeyvEp9yPSciCj0n9EfVrmRrY70f8VHuZDxfLHjGj2dBCcBECF2r
 zZYhY1VOl+6XpUmyYmKVFiTDqYSA7wlnwLdCqKEgzz2+3wAUlbpDf15vGhYswqTAYGcp+5
 QgVj1aaQHV3dW/Ky7Tc5LU7XehM+oEn1/aJxsMMK7X6dGZghNQTQJFSJuE9gtn2JnUsI68
 fy0cT9kExASxQxHndcD24Tt2mB/nJBGzpMI7DmNfopahNpKmjCgi9awr9bhaw0pugI9FsP
 2viNDOU3YUKSvkRRNSL1TARqE0cxKQyVD/JFB8Iqh7OhKRPzfGln8X8bO9Nk8w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] pci: pcie-rcar-gen4: Assure reset occurs before DBI access
Date: Wed, 24 Sep 2025 03:47:13 +0200
Message-ID: <20250924014730.120800-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250924014730.120800-1-marek.vasut+renesas@mailbox.org>
References: <20250924014730.120800-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7f4097c1fe31d9ed1a
X-MBO-RS-META: mrj7pxj9nwx4x4rd1ocn7yapc373zegt
X-Rspamd-Queue-Id: 4cWfqs23YHz9tdp
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

Assure the reset is latched and the core is ready for DBI access.
On R-Car V4H, the PCIe reset is asynchronized and does not take
effect immediately, but needs a short time to complete. In case
DBI access happens in that short time, that access generates an
SError. Make sure that condition can never happen, read back the
state of the reset which should turn the asynchronized reset into
synchronized one, and wait a little over 1ms to add additional
safety margin.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 1b79d834122..74aa75d2927 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -316,6 +316,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	if (ret)
 		goto err_unprepare;
 
+	reset_status(&rcar->pwr_rst);
+	mdelay(1);
+
 	rcar_gen4_pcie_additional_common_init(rcar);
 
 	return 0;
-- 
2.51.0

