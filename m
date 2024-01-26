Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D4AC47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2EC87C00;
	Fri, 26 Jan 2024 09:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CVEVXW7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3004687C08; Fri, 26 Jan 2024 09:13:31 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4475A87BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3DC6F3FE87; 
 Fri, 26 Jan 2024 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706256808;
 bh=LCwoWcmGqfI6BQrkSQc8nmK2Gk6Ee1sxSTF3IYVrTEk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CVEVXW7F27mrftuEDrLrWjD2NN0AUyrIxB6rE/oAnLA5Zpg1AqhuDLJ7MHRb4WYIR
 y4OReHWcqqt47s4FyLtQtQl0zW7Kk4bBjn+9AcHJ+tcKhlW9nNXPp1LTp1cSL+/c7N
 WA1taE7kdH6lKtDeXM/Vqf2v5a612MzBfXv5ggYjZ9FS3tiatBXmVQdgEjIt20cjI6
 D0dwq009hzLbAl0SqWZa4WW+ozhDIgOKcStp31kz54imoYJJ+boc4ZXa2xzCPSMYlP
 4KDOul6AcnNAnTr3qCe76p821KYj9E0276Y8vxxCNhnQfoeRfiLYHvsgQVoAY4sNX3
 SHBNEpnu7fN9w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: replace find_smbios_table by library function
Date: Fri, 26 Jan 2024 09:13:22 +0100
Message-ID: <20240126081322.25781-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The code in find_smbios_table() is redundant to
efi_get_configuration_table(). Replace it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_tcg2.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 85562c50a1c..b5d4aa7be52 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1128,23 +1128,6 @@ out:
 	return ret;
 }
 
-/**
- * find_smbios_table() - find smbios table
- *
- * Return:	pointer to the smbios table
- */
-static void *find_smbios_table(void)
-{
-	u32 i;
-
-	for (i = 0; i < systab.nr_tables; i++) {
-		if (!guidcmp(&smbios3_guid, &systab.tables[i].guid))
-			return systab.tables[i].table;
-	}
-
-	return NULL;
-}
-
 /**
  * tcg2_measure_gpt_table() - measure gpt table
  *
@@ -1387,7 +1370,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	entry = (struct smbios3_entry *)find_smbios_table();
+	entry = efi_get_configuration_table(&smbios3_guid);
 	if (entry) {
 		ret = tcg2_measure_smbios(dev, entry);
 		if (ret != EFI_SUCCESS)
-- 
2.43.0

