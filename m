Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B146E6400F
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 03:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB51807C0;
	Sun,  5 Apr 2026 05:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SDtDLEUA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bSE8UgAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1426E83C14; Sun,  5 Apr 2026 05:52:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0D580433
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 05:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fpJSm2Hy1z9tlV;
 Sun,  5 Apr 2026 05:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775361160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cLxLaA3BKEnnSt0icABI6NHKZ64LB8OOsP/QNWGW8O0=;
 b=SDtDLEUABhtin/hlXN13sNY6VzAlgatLDOgyWeB6DhpPCzJT/RJQkk+QYah4vteiCjkISl
 UiNI0Ic1ptyGGQeer0Vu15jVL0wimHcajFZYC82EX/lhHSPnGIdtgOLWhE0B+9JNjcD5m6
 SA5ONLn3tpKrKVzdr4F1QlcB8CjACdDSHf37l16d/uKdk3zyIkg0c+MGrpx5Zk/1GwgEXV
 3VpH+U0hDoeNxHjpqko8Fw4vr78qSMT/DFPdzgXQG5TPkERFMCI+dIGrluqacSlSD94a4U
 JDrUzf5eDhtn1/vubk+5FT3EoS00q37RnT0Sq0Gt+AXUr7Kz4cjMVcXAa8FuBw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bSE8UgAM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775361158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cLxLaA3BKEnnSt0icABI6NHKZ64LB8OOsP/QNWGW8O0=;
 b=bSE8UgAMSVUL7ckqqGj9Vt6AMUbrurQxfAnV/zp3cUEHk3N8/hehYl2Ef+rrhCDQgw1vzI
 Kc93FHrfOYSNrbW0eqIODHO14lMtZt3nhgt6GARbjAWOedrEba1n9mFGMxEsTIapKWb3ag
 EjtKLEEMr+O4XN5hKueuSti8fFJyoflVYsbEAufNU5gU90KAOEFEwKxAgF8hZS3dBlCV3g
 htYf9un4OUy2Me9p26DnfHiP6/u6MlPXSneYj1r0mYNYpQiiLuutwJZdf4moVRIQSyd1ly
 +MCCnlVRnk4yRMsPS1VObNsP2CzCquG30XlX+1DaYVbbVvmsr02eTMPQh0ZsdA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Enable preboot environment variable on all
 R-Car systems
Date: Sun,  5 Apr 2026 05:51:40 +0200
Message-ID: <20260405035235.348357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 74f3b77588d2d1231b4
X-MBO-RS-META: gouu5yxgxnseifxfr1qhpcprym7m4xdp
X-Rspamd-Queue-Id: 4fpJSm2Hy1z9tlV
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

Enable the 'preboot' variable on all R-Car systems. This variable can
optionally be set and contain a script which is executed before the
autoboot timeout starts. This can be used to run critical scripts or
similar tasks. By default, the "preboot" variable is empty.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index b3107d79b0e..548c7827e77 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -28,5 +28,6 @@ CONFIG_RCAR_GPIO=y
 CONFIG_SCIF_CONSOLE=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
+CONFIG_USE_PREBOOT=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_WGET=y
-- 
2.53.0

