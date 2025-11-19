Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26F8CF58E9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 20:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6A283F1F;
	Wed, 19 Nov 2025 21:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N4BORjxz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v/u6J8hS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E1A83F80; Wed, 19 Nov 2025 21:40:18 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393FB83EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 21:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dBYJb6kDJz9tWH;
 Wed, 19 Nov 2025 21:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763584816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQWQdQUvWXH1jKv7R4rETb7qiZtpTeWAKoa9C9QZW7w=;
 b=N4BORjxzBjnu5KbwopEuO2KaYSXeB/ua8PUNZg2gzDOswukxbZq6cUrRyDmwBBH8zEBDLX
 DCqBKRqlfgQdFG7286B9/AMfZQtFvUVNwzJBD6Z4ifllfomUDYB1xmAcfNEIoXizgsViuG
 cE3Tml0M2vGqc5nivC3kVfMR+aUFVMuba6//c3Dl1yVtuOW2RMvDEgVKjC5DSuPesu3oe9
 51bELPuXlJDrQO1l2i0lE1c5DrbxCAzuQzqibX1Zs9f4NO6WHA8Co4OhinJb/YcXb6IN7w
 71bctsKylIehWxl94lkeVEfqEGglQCu88Px5YerjLql253noMFD/cs3bGEohJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763584813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQWQdQUvWXH1jKv7R4rETb7qiZtpTeWAKoa9C9QZW7w=;
 b=v/u6J8hSi9yOB74ZPFamhIZbJD+pH4bY4GmUugFolWiuFUIj76OTjkkqi+tw+tSnXSOS8R
 zpZCkcYEZC7yx+OdQpqxFklvBZZDUAaa913oktrP1MafCdazys6W0JumUBKgK12IOCiGt5
 Sfaqr2EnSjruE7Gbf3KTlfSgJ3XFcEfOW0JuyoOrVayRlwXBwuySVY9SupyN74h/YpYGWv
 qosaY1bvVAXnY5lzRPQ4JteXRjilvsQToUwaHluf5MF0c6ek5XsxMmE92doXGsj8sfVl4l
 Xp4JvSCpssm4KnH+Iwpd8U4qE6VxjC8bY+OtTyIycXsoYK8+CXu67XDQ1yYWzA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Enable R8A779G0 V4H White Hawk RPC SPI DT
 node
Date: Wed, 19 Nov 2025 21:39:48 +0100
Message-ID: <20251119204009.182735-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c599f6054e466eb477c
X-MBO-RS-META: gepw7gs7chjbbmwrnxs4jbakyzxjauri
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

Disabling RPC breaks SPL boot on R-Car V4H White Hawk board, re-enable RPC.

Fixes: 1d94364c7f17 ("ARM: dts: renesas: Disable R8A779G0 V4H White Hawk RPC SPI DT node again")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index 8e4307ff87d..85e32208b29 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -23,8 +23,6 @@
 
 &rpc {
 	bootph-all;
-	status = "disabled";
-
 	flash@0 {
 		bootph-all;
 		spi-tx-bus-width = <1>;
-- 
2.51.0

