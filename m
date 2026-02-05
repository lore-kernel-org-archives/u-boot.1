Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA45ECD985
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 16:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C472483B5E;
	Thu,  5 Feb 2026 17:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6100C83B86; Thu,  5 Feb 2026 17:40:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DE99183B0B
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 17:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4C4F339;
 Thu,  5 Feb 2026 08:40:09 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.128.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EBE93F632;
 Thu,  5 Feb 2026 08:40:15 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] efi_net: add missing EFI_CALL in efi_net
Date: Thu,  5 Feb 2026 17:40:12 +0100
Message-ID: <20260205164012.667019-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
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

The efi_reinstall_protocol_interface() function is a UEFI function;
make sure to call it from within U-Boot using the EFI_CALL() macro.

This fixes the following assertion:

  lib/efi_loader/efi_boottime.c:3752: efi_reinstall_protocol_interface: Assertion `__efi_entry_check()' failed.

To reproduce the issue, define LOG_DEBUG in lib/efi_loader/efi_boottime.c
and build u-boot for your platform. Then, boot the U-Boot helloworld.efi
application over the network. Example commands (adjust the URL and boot
entry number):

  => efidebug boot add -u 0 net http://10.0.2.2:8000/helloworld.efi
  => efidebug boot order 0
  => bootefi bootmgr

Fixes: dd5d82a59995 ("efi_loader: efi_net: Add device path cache")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 0f8a851e3f2..c2b85dac236 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1024,8 +1024,10 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		goto add;
 
 	// If it is already installed, try to update it
-	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
-					       phandler->protocol_interface, new_net_dp);
+	ret = EFI_CALL(efi_reinstall_protocol_interface(&netobj->header,
+							&efi_guid_device_path,
+							phandler->protocol_interface,
+							new_net_dp));
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-- 
2.51.0

