Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E4BC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 17:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E8F80423;
	Fri, 17 Jan 2025 18:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EF2806D8; Fri, 17 Jan 2025 18:13:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 359558036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 18:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3BBA1476;
 Fri, 17 Jan 2025 09:14:00 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.7.73])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0BB43F73F;
 Fri, 17 Jan 2025 09:13:31 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] lib: uuid: support more efi protocols in uuid_guid_get_str()
Date: Fri, 17 Jan 2025 18:13:26 +0100
Message-ID: <20250117171327.1641490-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 18:57:27 +0100
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

Add more EFI protocols GUIDs to the translation table used by
uuid_guid_get_str().

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---

Hi,

While the EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID, the
EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID and the EFI_LOAD_FILE_PROTOCOL_GUID are
actually used by the efi_loader, this is not the case with the
EFI_DISK_IO_PROTOCOL_GUID.
I think we should add this GUID to the table nonetheless, as it can help
with debugging EFI applications and we already have this GUID's definition
in the headers.
If that is not desired, please do not hesitate to drop the first hunk of
this patch.

Best regards,
Vincent.

 lib/uuid.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 97388f597a6..75658778044 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -119,6 +119,10 @@ static const struct {
 		"Block IO",
 		EFI_BLOCK_IO_PROTOCOL_GUID,
 	},
+	{
+		"Disk IO",
+		EFI_DISK_IO_PROTOCOL_GUID,
+	},
 	{
 		"Simple File System",
 		EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
@@ -127,6 +131,10 @@ static const struct {
 		"Loaded Image",
 		EFI_LOADED_IMAGE_PROTOCOL_GUID,
 	},
+	{
+		"Loaded Image Device Path",
+		EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
+	},
 	{
 		"Graphics Output",
 		EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
@@ -139,10 +147,18 @@ static const struct {
 		"HII Database",
 		EFI_HII_DATABASE_PROTOCOL_GUID,
 	},
+	{
+		"HII Config Access",
+		EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID,
+	},
 	{
 		"HII Config Routing",
 		EFI_HII_CONFIG_ROUTING_PROTOCOL_GUID,
 	},
+	{
+		"Load File",
+		EFI_LOAD_FILE_PROTOCOL_GUID,
+	},
 	{
 		"Load File2",
 		EFI_LOAD_FILE2_PROTOCOL_GUID,
-- 
2.45.2

