Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96376C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C9A881F4;
	Sun, 19 May 2024 22:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZcO6G/IY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vluPqplt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C84F88193; Sun, 19 May 2024 22:41:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B17187F39
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VjCJr73nYz9sHY;
 Sun, 19 May 2024 22:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1716151261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VR+FJJlgSjtwYABRf/nk0wYZ66Om3zO03JJtBLscBL0=;
 b=ZcO6G/IY8nJoCfKbK7sX6yqRKxS6FF2DKXT4Dp5zi+RgyHvxJzRJJwUcNriYAeC8msX1aE
 BT+gRJ8OAK8cefMU4cgzlvCyKlKyI2/QpaLDgd8HYPjRsOg3uVZO26Thp+TDGThYqFzwH7
 qUs6f+AU5/n0y2xjBOZcDFhrc4n8EQbo7CQm6nkYhglFI1o0bdn9vJ9mrxwkk7JMMyNE/N
 lYGpJhKINBYGk+/bgKA3U1lFQOVbTIhNxXCbxgrZcMJIzGT1BljrQs8vGA12WETO7hGDLn
 KXQZ2giphY/yiXH9WDTcm/Vm/vTzcocvnbNFrDDKDK/s0lDvgVbPyYTfaJ8nCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1716151259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VR+FJJlgSjtwYABRf/nk0wYZ66Om3zO03JJtBLscBL0=;
 b=vluPqpltC8IyDUX6M94ZlaUS7q/m5CUid9uVDpURRr2Yo9pfiU2RVuOqNGjWBAFPmxkadi
 0B7OUUGUfGpOc+Y7eYSn97m5vlcxnGJTeN+BaptJwTmL0EHflbkcJ2R5EcohgAkZKc+oDY
 DM7E0yTPEppqgwWp4JcEzG6T65VJBKvSHNQ/iPyX1v8ivDlftDhXzVBoJL1fSEmlbPQ9to
 qttf94rxlpH6cXP9B4V/rONOKg1dCcRX6VngO5Wx+kJPJmngDo0Saj9/lmhHBxWV9tkL1I
 5VXbidrAlnrY8tfj6dqRbzeu7ZhGk7+ZWMltJPsv42wfmkYNlN0uTe9FN8bRuA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Reserve space in 64bit R-Car DTs
Date: Sun, 19 May 2024 22:40:07 +0200
Message-ID: <20240519204044.187165-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pbdj1crud71yis1eizdykedxce81mtte
X-MBO-RS-ID: 621dc7d9c2558dd0223
X-Rspamd-Queue-Id: 4VjCJr73nYz9sHY
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

Reserve 4 kiB of space in 64bit R-Car DTs when those DTs are compiled
to permit patching in OpTee-OS /firmware node, /reserved-memory node,
possibly also additional /memory@ nodes and RPC node by TFA.

This duplicates behavior in arch/arm/dts/Makefile with OF_UPSTREAM.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 dts/upstream/src/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
index 9a8f6aa3584..26a83d3d29d 100644
--- a/dts/upstream/src/arm64/Makefile
+++ b/dts/upstream/src/arm64/Makefile
@@ -7,6 +7,10 @@ targets += $(dtb-y)
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
+ifdef CONFIG_RCAR_64
+DTC_FLAGS += -R 4 -p 0x1000
+endif
+
 PHONY += dtbs
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	@:
-- 
2.43.0

