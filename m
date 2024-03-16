Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF1AC54E5D
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 09:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9073E87A80;
	Sat, 16 Mar 2024 10:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QPyPyVvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4608087F3E; Sat, 16 Mar 2024 10:37:06 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F23E87E2F
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 10:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EB6C744874; 
 Sat, 16 Mar 2024 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710581820;
 bh=pu6h6YYdvsp+CEi3dQU5jOm5VkXiqG7Js7q83jytK7I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QPyPyVvETscBw/jnYq/k7FmDLIc7KsxvDrqgldZ4GmgR+/xpAbNYuCMMQqeRuWg7t
 b+pfSpZKq2rJZcYD6wJA+uhyeRz05TaJXiQebVvEHLh/AUFoTOXX2oyFqTGdTA5n0R
 YxA2tBd4w5ndvDxS3tGpB3SNVtypEylBKi8FLDslfImet6bTh14iHZRSQXyRjvJ30v
 rQLBeubo/XowKQ+WNYjFh2DvpwFvkffVIB7ZEFHvk9k1B/0dh2N38jIxY77ZOGxSRR
 E8QyHdR6CKyYY7Y7TTvjDXZUD3lXsNpfUml8jwzcsMI7PUwaxXqGUyVraN4wziEGPM
 pl2jEtYED2nyQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] cmd: bootefi: Don't show usage help if EFI binary fails.
Date: Sat, 16 Mar 2024 10:36:43 +0100
Message-ID: <20240316093644.54869-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
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

If an EFI binary returns an error code EFI_INVALID_PARAMETER, we show the
usage help for the bootefi command:

    Shell> exit 0x8000000000000002
    ## Application failed, r = 2
    bootefi - Boots an EFI payload from memory

    Usage:
    bootefi <image address>[:<image size>] [<fdt address>]
      - boot EFI payload
    bootefi bootmgr [fdt address]
      - load and boot EFI payload based on BootOrder/BootXXXX variables.

        If specified, the device tree located at <fdt address> gets
        exposed as EFI configuration table.

This makes no sense.

Fixes: 296faf4f7ef1 ("cmd: bootefi: re-organize do_bootefi()")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 9cf9027bf40..b509440cde0 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -154,9 +154,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	    !strcmp(argv[1], "bootmgr")) {
 		ret = efi_bootmgr_run(fdt);
 
-		if (ret == EFI_INVALID_PARAMETER)
-			return CMD_RET_USAGE;
-		else if (ret)
+		if (ret != EFI_SUCCESS)
 			return CMD_RET_FAILURE;
 
 		return CMD_RET_SUCCESS;
@@ -218,9 +216,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	ret = efi_binary_run(image_buf, size, fdt);
 
-	if (ret == EFI_INVALID_PARAMETER)
-		return CMD_RET_USAGE;
-	else if (ret)
+	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
-- 
2.43.0

