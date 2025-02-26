Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286BEC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C528801DE;
	Wed, 26 Feb 2025 10:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nnLe2oHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D2980805; Wed, 26 Feb 2025 10:13:07 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E7B801CF
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-046.46.114.pool.telefonica.de
 [46.114.111.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 77CAF3F207; 
 Wed, 26 Feb 2025 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740561184;
 bh=s+YDKl+AkMraG1Yitnu97PnglBQ6Mwci0IlSh2aBWxM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nnLe2oHNeY1xJ7xfJoRwY6S5wigaqj8c5fL2Y50rfgUC9oallt4nSAG7i7aUYWQFw
 /Lxs6IOfuCvtdyqLsSGqbZ7zGcAbyn4By3ToAw/GFS+4gGnUkF3FZ6JmVk67ObNXi0
 Aw8+Yk3dZOOcPBxx+Tqx6vkY1jhXqvlSnRLC6gE/3H6mOMSe81vor8kTEfMoNt/CSG
 xLpgKASGMhSG2kZ1QMe0tda2Y+XjWrz0LqEXX3Ppk52SSmz6Bv9BHO5gMedRbzTjh6
 ak1vCjXmjEPoN20w0UVQ+l1YkeXQ8zTiisWRwqQhO0oSwhQvsX4yb064eJ2M2ckKja
 cW1o/5XHKknsA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: simplify eficonfig_init()
Date: Wed, 26 Feb 2025 10:12:58 +0100
Message-ID: <20250226091258.16582-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

As the system table already has pointers to the Simple Text Intput and
Output Protocols we can directly use these instead of calling
OpenProtocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e08b6ba4a5d..0a523ae10c7 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -2287,22 +2287,8 @@ static efi_status_t eficonfig_init(void)
 	unsigned long columns, rows;
 
 	if (!init) {
-		ret = efi_search_protocol(efi_root, &efi_guid_text_input_protocol, &handler);
-		if (ret != EFI_SUCCESS)
-			return ret;
-
-		ret = efi_protocol_open(handler, (void **)&cin, efi_root, NULL,
-					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-		if (ret != EFI_SUCCESS)
-			return ret;
-		ret = efi_search_protocol(efi_root, &efi_guid_text_output_protocol, &handler);
-		if (ret != EFI_SUCCESS)
-			return ret;
-
-		ret = efi_protocol_open(handler, (void **)&cout, efi_root, NULL,
-					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-		if (ret != EFI_SUCCESS)
-			return ret;
+		cout = systab.con_out;
+		cin = systab.con_in;
 
 		cout->query_mode(cout, cout->mode->mode, &columns, &rows);
 		avail_row = rows - (EFICONFIG_MENU_HEADER_ROW_NUM +
-- 
2.47.1

