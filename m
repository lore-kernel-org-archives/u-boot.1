Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B5FD3C53E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3FB8912B;
	Fri, 18 Oct 2024 03:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S0nxOA05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A36488BB2; Fri, 18 Oct 2024 03:18:46 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BC2890F6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DAF453F9B2; 
 Fri, 18 Oct 2024 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729214324;
 bh=Xg0Aciyfb65ZcO+W77cpDsngyJU4K+nY3+d6DehnVgU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S0nxOA05hN32h6Y8Al2fYg9eMCIvq37GXVf6LSmg2W7BjFX51iGyEAcb7ECWHLb2O
 6KTHx7TnbGnDWTClHpWVmFfbhbzBviiFo0MwYy3KR7St5/XEpmJEPNx2kuCuQks65l
 YquebfLiC2/rBnv+oGrHMYsYE6nomWBmMxatokm9WjYq5u08lm2Lt8xaF+GAXLG0sX
 OIA2UNUfaHnOctVlg6MfsY7RboHgSS+YQaDFrxL0IF7oSGppnFHSzC1I/CUIYFfZLw
 4Ca4KiArxF0cTPteS0hiUuh+61RFuKjGE+1hVvkatmN5dBwfvXrD6Xs0vls3F8t16D
 AlbqLBKJBJUpw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] efi_loader: reduce noisiness if ESP is missing
Date: Fri, 18 Oct 2024 03:18:36 +0200
Message-ID: <20241018011837.126813-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
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

EFI variables can be stored in a file on the EFI system partition. If that
partition is missing we are writing two error messages per variable. This
is too noisy.

Just warn once about the missing ESP.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/efi_var_file.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 413e1794e88..ba0bf33ffbd 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -37,18 +37,16 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
 	char part_str[PART_STR_LEN];
 	int r;
 
-	if (efi_system_partition.uclass_id == UCLASS_INVALID) {
-		log_err("No EFI system partition\n");
+	if (efi_system_partition.uclass_id == UCLASS_INVALID)
 		return EFI_DEVICE_ERROR;
-	}
+
 	snprintf(part_str, PART_STR_LEN, "%x:%x",
 		 efi_system_partition.devnum, efi_system_partition.part);
 	r = fs_set_blk_dev(blk_get_uclass_name(efi_system_partition.uclass_id),
 			   part_str, FS_TYPE_ANY);
-	if (r) {
-		log_err("Cannot read EFI system partition\n");
+	if (r)
 		return EFI_DEVICE_ERROR;
-	}
+
 	return EFI_SUCCESS;
 }
 
@@ -67,14 +65,21 @@ efi_status_t efi_var_to_file(void)
 	loff_t len;
 	loff_t actlen;
 	int r;
+	static bool once;
 
 	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
 	if (ret != EFI_SUCCESS)
 		goto error;
 
 	ret = efi_set_blk_dev_to_system_partition();
-	if (ret != EFI_SUCCESS)
-		goto error;
+	if (ret != EFI_SUCCESS) {
+		if (!once) {
+			log_warning("Cannot persist EFI variables without system partition\n");
+			once = true;
+		}
+		goto out;
+	}
+	once = false;
 
 	r = fs_write(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, len, &actlen);
 	if (r || len != actlen)
@@ -83,6 +88,7 @@ efi_status_t efi_var_to_file(void)
 error:
 	if (ret != EFI_SUCCESS)
 		log_err("Failed to persist EFI variables\n");
+out:
 	free(buf);
 	return ret;
 #else
-- 
2.45.2

