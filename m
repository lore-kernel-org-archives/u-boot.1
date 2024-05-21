Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA28C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981128870D;
	Tue, 21 May 2024 09:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n68SN0ub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E0F88703; Tue, 21 May 2024 09:13:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E85788706
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 312B261FF2;
 Tue, 21 May 2024 07:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE5EC32782;
 Tue, 21 May 2024 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275621;
 bh=LGrmxjSoFYLqgfGB/7b+QkRkv/d4ampIHd/wOAXj8t8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n68SN0ubbLhdgnzEmimWnCKzPiMG479ZP+gXSAnGmrN44bzJFNEEMD63QTMBWtHbw
 QY0PgV0GSxbfazBaU7q4Sv+z/RN+W1y+Q+B0PQgHAgxbYGVR4GCtoK/aFF6FK7MOvp
 upTJYjRpLLMIlKMtbcUaky4pUSjNrjnNk5tIfsnoHL0RC0M9MqLmUrtBwQCNrzsgAR
 KzIFMHYq1l8VnDekpeHsZK3LsyygCI+0r24P0cDHIud9cH3OrjhNXV1Vw3mtFZwPKi
 wui/8FJWE8glLHmUhmOUOfbC4rTep40U7VodYYNEOQh9+AZI7V6ZZVZTUW3PMRhLO4
 AzZAhTxP1kYXA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 01/11] common: eeprom_layout: Assign default layout methods
 and parameters before specific ones
Date: Tue, 21 May 2024 09:13:25 +0200
Message-ID: <20240521071335.4193-2-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Assign the default eeprom layout parameter .data_size and methods
.print() and .update() before calling eeprom_layout_assign() in
eeprom_layout_setup().

This allows eeprom_layout_assign() to overwrite these if needed.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 common/eeprom/eeprom_layout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/eeprom/eeprom_layout.c b/common/eeprom/eeprom_layout.c
index 5a9be1da06..406db3f7d1 100644
--- a/common/eeprom/eeprom_layout.c
+++ b/common/eeprom/eeprom_layout.c
@@ -111,14 +111,14 @@ void eeprom_layout_setup(struct eeprom_layout *layout, unsigned char *buf,
 	else
 		layout->layout_version = layout_version;
 
+	layout->data_size = buf_size;
+	layout->print = eeprom_layout_print;
+	layout->update = eeprom_layout_update_field;
+
 	eeprom_layout_assign(layout, layout_version);
 	layout->data = buf;
 	for (i = 0; i < layout->num_of_fields; i++) {
 		layout->fields[i].buf = buf;
 		buf += layout->fields[i].size;
 	}
-
-	layout->data_size = buf_size;
-	layout->print = eeprom_layout_print;
-	layout->update = eeprom_layout_update_field;
 }
-- 
2.44.1

