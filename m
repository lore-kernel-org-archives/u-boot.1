Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8543DD6D25E
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027E389826;
	Thu, 28 Nov 2024 04:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DlApI0O6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AE089826; Thu, 28 Nov 2024 04:48:12 +0100 (CET)
Received: from mail-m17237.xmail.ntesmail.com (mail-m17237.xmail.ntesmail.com
 [45.195.17.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040F089825
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 04:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4109ad5e;
 Thu, 28 Nov 2024 11:48:04 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
Date: Thu, 28 Nov 2024 11:47:57 +0800
Message-Id: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05LGVZJTUsYThhDGktJQ05WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9370e2124503afkunm4109ad5e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Pyo*QjIsASwDPyo5FAMC
 LzpPCyJVSlVKTEhJTE1OTUNOSk5CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSElJNwY+
DKIM-Signature: a=rsa-sha256;
 b=DlApI0O61DJx+Ye0e8QUFNxZ7Gig6lK09mCRSKOS4osPbqASSmUxb5zqxrlQRFklX/eCnzh71NGtkmwWDWG9c8rzNlYVICdbZFoWlo54/1rXnACrtq16seUn+wAZIeAZOQAtbsCjktEBhM/YfZGQjQt77nbJ385uVIUL2dMZ+kA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ihKjC19EuXqeS4k4EMhQVjnxatCY6v6d2anH/kEELN0=;
 h=date:mime-version:subject:message-id:from;
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

The debug UART interface is available when CONFIG_DEBUG_UART is defined,
sync with the other platforms to use the same definition.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 lib/efi/efi_stub.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index 40fc29d9adf..5179c5b2c09 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -9,7 +9,6 @@
  * EFI application. It can be built either in 32-bit or 64-bit mode.
  */
 
-#include <debug_uart.h>
 #include <efi.h>
 #include <efi_api.h>
 #include <errno.h>
@@ -55,10 +54,6 @@ struct __packed desctab_info {
  * considering if we start needing more U-Boot functionality. Note that we
  * could then move get_codeseg32() to arch/x86/cpu/cpu.c.
  */
-void _debug_uart_init(void)
-{
-}
-
 void putc(const char ch)
 {
 	struct efi_priv *priv = efi_get_priv();
@@ -83,12 +78,21 @@ void puts(const char *str)
 		putc(*str++);
 }
 
-static void _debug_uart_putc(int ch)
+#ifdef CONFIG_DEBUG_UART
+
+#include <debug_uart.h>
+
+void _debug_uart_init(void)
+{
+}
+
+static inline void _debug_uart_putc(int ch)
 {
 	putc(ch);
 }
 
 DEBUG_UART_FUNCS
+#endif
 
 void *memcpy(void *dest, const void *src, size_t size)
 {
-- 
2.25.1

