Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED50CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF01E86EFD;
	Fri, 20 Oct 2023 12:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="rBD7H2bj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354C087481; Fri, 20 Oct 2023 12:21:25 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FD487469
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 12:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so864747a12.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1697797282; x=1698402082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qfYEZyRAjVnQUY0HQ8yI5/v6WUBIN6sIU0c/uefkD4=;
 b=rBD7H2bjkOiVeorKuPX0xHJNL/2+LQ7sgWyiqYvvvQzvXpHqDKXWiN7p4rSCD2xnmZ
 RRZR2LC8OI+tuzZ96WOCESlR9+kw7t1RAgPO99WxZgGzw0sNjTotORTWcKzB4X0z6k9z
 gDPSOtQvr3ww6nWMChEVjbqIMHspDcBqt6LAJrx0RBp2UyvxQvevhBi+iLDWnmiKldBz
 y/q5w32Nz/rNE/S4globdHxxiupuy05XBaEuxyiPegkIBNR9QyIOF21/0JovSdlDobCj
 qEnKNpxX8YIjnbYjfNVy2i0/T/uUQdIelj3FZP0tECErsSvB84EsCuFXkp8XiyGwokr5
 WdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797282; x=1698402082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qfYEZyRAjVnQUY0HQ8yI5/v6WUBIN6sIU0c/uefkD4=;
 b=WJ8b/4fwRnudthWIAjNsbIc5KG/mU7cVDV3QAFncELuVp86PXIjH3XSgoVnNWqUhmX
 p87HlcSKKWlhtHcdzVkKnJ1PI5mlJiQYkHma3xBw+W7NH4phmARAXfTjfN8bzUYzUApk
 LKotyfFXlr0qU/9i6DmQ51kA9IOuDRQDLkqHm3zOBYMBpIMHNLi/NLHwIdg2VYG1pkAe
 kCND4lr8Mfe9LlkLB/BUdwOOu8C6J6dicftre0qxtQwQIaWI0D6uSwVHPapiLp7kTwfM
 mmTBuo9mSOxGYt5+7oSVgVjcpidbpWLFDOj01P1Uyk0uGlDSDSbQKW7j2ZjVeAY7S5UZ
 Xz4Q==
X-Gm-Message-State: AOJu0Yx1byI+E6gBMcl9pUkP33EZDmPqkoW5iNBB/iX/bwil+IRCN+0z
 m/f71IqIAdix5c64itq3OwarNteeHFxObz+fnLs=
X-Google-Smtp-Source: AGHT+IG18P2jNyKsoQJ/rBZZCrDqKdYnQ0zbB7VGb/RXDl5GA6BWdMZRlizBQ5ZkgI3d/WEffa8n1w==
X-Received: by 2002:a17:907:36c1:b0:9be:a170:81d with SMTP id
 bj1-20020a17090736c100b009bea170081dmr963220ejc.25.1697797281822; 
 Fri, 20 Oct 2023 03:21:21 -0700 (PDT)
Received: from fedora.. (dh207-96-32.xnet.hr. [88.207.96.32])
 by smtp.googlemail.com with ESMTPSA id
 e27-20020a170906749b00b009a198078c53sm1204693ejl.214.2023.10.20.03.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 03:21:21 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
Date: Fri, 20 Oct 2023 12:20:54 +0200
Message-ID: <20231020102117.1583572-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020102117.1583572-1-robert.marko@sartura.hr>
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, Esspresobin switch is being setup directly in last_stage_init()
which makes it hard to add support for any other board to be setup.

So, lets just move the switch setup code to a separate function and call it
if compatible matches, there should be no functional change.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Stefan Roese <sr@denx.de>
---
Changes in v2:
* Rebase on top of current master and resolve conflicts

 board/Marvell/mvebu_armada-37xx/board.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 1471caa9a6..f532486b70 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -301,14 +301,12 @@ static int mii_multi_chip_mode_write(struct udevice *bus, int dev_smi_addr,
 	return 0;
 }
 
-/* Bring-up board-specific network stuff */
-static int last_stage_init(void)
+static int espressobin_last_stage_init(void)
 {
 	struct udevice *bus;
 	ofnode node;
 
-	if (!CONFIG_IS_ENABLED(DM_MDIO) ||
-	    !of_machine_is_compatible("globalscale,espressobin"))
+	if (!CONFIG_IS_ENABLED(DM_MDIO))
 		return 0;
 
 	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
@@ -358,8 +356,17 @@ static int last_stage_init(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
+/* Bring-up board-specific network stuff */
+static int last_stage_init(void)
+{
+
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_last_stage_init();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-- 
2.41.0

