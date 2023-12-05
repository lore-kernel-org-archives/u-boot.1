Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2316C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 02:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1663C875F5;
	Tue,  5 Dec 2023 03:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fuRjhgSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5264E875FC; Tue,  5 Dec 2023 03:38:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419A787554
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 03:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 733F240261; 
 Tue,  5 Dec 2023 02:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701743878;
 bh=0/HYfxuQ+4KFxlLwHD1OWtTL4/yAc04ZrVWDHfRokyY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=fuRjhgSIkMhR9QptXS3hgK5LBuq2//nj/NJZBnOEXQahlcYWes+M3pbhq/fT5vo7p
 sTCSLbvRIdpIx4K+VG2HgTGy3duakotKSpC4prcZgH7t0rJDSKGtTZ1GKprgNqqic7
 hZIzOdt4RLS+spQhvUBXuNEdCabkSaq+mOWeqDLXQ2pNmRTUbaKmWKph9S2XXLkWQF
 6xqQge244kdBFhGhRmfoVypFQEdVWEeUG6JY68HPhhAQDiaDGzDnrhEx+x2I9EAPFj
 2cmcXSgjIcX2qiKf3ZS8xiI29vAx6SwkGfSawWR3lOwDeUJT1n0YVJmTs6ZXzl1Nn1
 o+36MD58KHK5Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: boot options should relate to the ESP
Date: Tue,  5 Dec 2023 03:37:51 +0100
Message-Id: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

* Only generate removable media entries for EFI system partitions.
* Only offer EFI system partitions for boot options in the eficonfig
  command.

Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot option")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c              | 6 ++++--
 lib/efi_loader/efi_bootmgr.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 34a59cb15d..c066b28b6b 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -626,8 +626,10 @@ static efi_status_t eficonfig_select_volume(struct eficonfig_select_file_info *f
 	efi_handle_t *volume_handles = NULL;
 	struct efi_simple_file_system_protocol *v;
 
-	ret = efi_locate_handle_buffer_int(BY_PROTOCOL, &efi_simple_file_system_protocol_guid,
-					   NULL, &count, (efi_handle_t **)&volume_handles);
+	/* Find all EFI system partitions */
+	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
+					   &efi_system_partition_guid,
+					   NULL, &count, &volume_handles);
 	if (ret != EFI_SUCCESS) {
 		eficonfig_print_msg("No block device found!");
 		return ret;
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 48153bd5ff..9e84391186 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1047,8 +1047,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 	efi_handle_t *volume_handles = NULL;
 	struct eficonfig_media_boot_option *opt = NULL;
 
+	/* Find all EFI system partitions */
 	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
-					   &efi_simple_file_system_protocol_guid,
+					   &efi_system_partition_guid,
 					   NULL, &count,
 					   (efi_handle_t **)&volume_handles);
 	if (ret != EFI_SUCCESS)
-- 
2.40.1

