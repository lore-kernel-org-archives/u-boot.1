Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ED7C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 06:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071DC8070C;
	Mon, 10 Mar 2025 07:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PhnyKK72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B21809A4; Mon, 10 Mar 2025 07:13:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A948043C
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4B22E3FF23; 
 Mon, 10 Mar 2025 06:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741587228;
 bh=1LHcadtc3ALr5G5sE7lW8eH2jcUdR77WhEThkN7JdYg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PhnyKK72fvOQ2cWxbTwfkAQPV5nfbHlwSGAEEDwARa/vyD1BNjxWRvLNDnE+vzMaN
 aMrMYjUYsFAiHvmPvq8Ssz1SL+m2isgVXF/JuiEJ1yCu+HwemIFLDKvBCu/LOTHirQ
 c6jn+scbRCbm/c4TYGsyBDnhoTXksh+5VOzM6BnX7b0vk/yCedl+JLHzStrMQt0Iqm
 DhOXTwkJIe6tLgprrCrpIfGIHRtQgD5Kw7hAcmu0wuZnCPDCzi7uDd5YBJUzPHEnlJ
 weLjgG1xsUeCVdEqSI9wglYBcPaircPOXjQlGlIKlUjxHRl+/LG43qYubu4QPzut94
 rfrzcbtStZaUg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] cmd: simplify eficonfig_init()
Date: Mon, 10 Mar 2025 07:13:43 +0100
Message-ID: <20250310061343.26208-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

As the system table already has pointers to the Simple Text Input and
Output Protocols we can directly use these instead of calling
OpenProtocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove unused variable handler
---
 cmd/eficonfig.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e08b6ba4a5d..629bf1b82c7 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -2283,26 +2283,11 @@ static efi_status_t eficonfig_init(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 	static bool init;
-	struct efi_handler *handler;
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
2.48.1

