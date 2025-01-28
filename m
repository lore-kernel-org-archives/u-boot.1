Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D85C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8451781DCD;
	Tue, 28 Jan 2025 14:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738072379;
	bh=yJjR7U40zH5dz0KnWoLFPHv5T8ShsbyNjJVViW81Sbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wXqK98tWlQ+VVseqdILiFEU/5BOriM5rf3jSf7C2jsULqgj+0hmxj9SLzr1TdDJ4B
	 lsEtr4V+SpUy21GVmANn3bJtrx3wB7JtcnEGLaKBYLpIRJ6tSd9+SlqIejO3AubTD6
	 O5sg1PUYTgyhZaTsv407YWm37U05S4uFKt3ytYfYkFTr0uaKhHJq8DcBh/rGttInaH
	 +9lUiDPyw+yRfPnKFU9vVW95hgq0Ia81Sk01xBrMQmrTos2cdaJOKt00nkzFrtTlsC
	 +hjxaf5kqxvzRHFG64rB+SHyl5fDAeoNw5G/9EfBTW8rfPriiqjy8iF0QRalIUlhcZ
	 4uXYserJa3pyQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83BC81E3E; Tue, 28 Jan 2025 14:52:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF9081DCD
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dOb/Gnd/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C159010382D0D; Tue, 28 Jan 2025 14:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738072375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJjR7U40zH5dz0KnWoLFPHv5T8ShsbyNjJVViW81Sbc=;
 b=dOb/Gnd/ckFmiFLCJn937oh/wrFFa5HM6gNMk+oX1Urq3qK6t8XcQa9X+NgXCCGxBIlU5C
 4xb23O1iVzo2ZZJAYbqSizy88B6iW+aUySDdLZrPMT+AKmNXaZsBuZWZFzgMrHxHLiTbLf
 r7j5Dk7jl/EUoL5k9TIJ6wYNjHAEAT9VffKJqQLPLbAiy02BBDkm8M+MIFHPPGgsuPu5o5
 5KFm5TGvrOw3OiviMeJnl1irl1b9Jlt1Tt46XwJ6Btr8wsI3sFk5JTqipxagZUPxume4yd
 ySJSf8cixI6inzy26jQ2iNuINavKul6cbwfezBi+rbOCPUEXMBddsnWsMzrGQQ==
From: Heiko Schocher <hs@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/2] doc: remove redundant leds bindings
Date: Tue, 28 Jan 2025 14:52:45 +0100
Message-Id: <20250128135246.74838-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250128135246.74838-1-hs@denx.de>
References: <20250128135246.74838-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

remove file doc/device-tree-bindings/leds/common.txt
as we have this now already in
dts/upstream/include/dt-bindings/leds/common.h
which is imported from linux.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v4:
- new in version 4

 doc/device-tree-bindings/leds/common.txt | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 doc/device-tree-bindings/leds/common.txt

diff --git a/doc/device-tree-bindings/leds/common.txt b/doc/device-tree-bindings/leds/common.txt
deleted file mode 100644
index 2d88816dd55..00000000000
--- a/doc/device-tree-bindings/leds/common.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Common leds properties.
-
-Optional properties for child nodes:
-- label : The label for this LED.  If omitted, the label is
-  taken from the node name (excluding the unit address).
-
-- linux,default-trigger :  This parameter, if present, is a
-    string defining the trigger assigned to the LED.  Current triggers are:
-     "backlight" - LED will act as a back-light, controlled by the framebuffer
-		   system
-     "default-on" - LED will turn on (but for leds-gpio see "default-state"
-		    property in Documentation/devicetree/bindings/gpio/led.txt)
-     "heartbeat" - LED "double" flashes at a load average based rate
-     "ide-disk" - LED indicates disk activity
-     "timer" - LED flashes at a fixed, configurable rate
-
-Examples:
-
-system-status {
-	label = "Status";
-	linux,default-trigger = "heartbeat";
-	...
-};
-- 
2.20.1

