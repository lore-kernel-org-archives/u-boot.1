Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDF9C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 23:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8630C876D3;
	Fri,  5 Jan 2024 00:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CA387756; Fri,  5 Jan 2024 00:26:00 +0100 (CET)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9334787682
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 00:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp74t1704410744taiiha8o
Received: from ubuntu.. ( [111.196.133.100]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 05 Jan 2024 07:25:43 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: IByDngDI/kFQdTYqIn8MaSkPTi4LwSz+tUfd/N+Jv36X1CBdp+G5GuSgdNzrq
 VhN0DuDIf2/IElllfwgc2Zy8pqE6Oy5Y88P4tXgKUU1JrkMYTAmttXadqi7KVKpoFq8o9av
 bRLqjTcavF+Tr4JSdwXmuY2sJ6xhGSNihH/oRn1idzq8tAP/6/K1WsORmvqrfQHdxaSeEa1
 91vOL4cXsfGlY7vodSEamzZWqvgIsoQvcY/484y7Mg2r3FtyRPRj1srYfwRPStwIwOhAn3W
 TjfHXwCH43orNYtE9psMU/Ac+HnWPzrnVpjEnCzKllEAVq4SiB31yXewiJrRwg26656O6Iu
 zXN4gthIdPwUtEHrZU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 97656725142461310
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] doc: coreboot: Update stale graphics enabling instructions
Date: Fri,  5 Jan 2024 07:25:42 +0800
Message-Id: <20240104232542.322248-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

From: Bin Meng <bmeng.cn@gmail.com>

With latest coreboot (e.g.: v4.22.01), the instructions to enable
graphics support has changed. Refresh the doc.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 doc/board/coreboot/coreboot.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index f2c6452b5b..8408461617 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -32,10 +32,9 @@ of _x86boot_start (in arch/x86/cpu/start.S).
 If you want to use ELF as the coreboot payload, change U-Boot configuration to
 use CONFIG_OF_EMBED instead of CONFIG_OF_SEPARATE.
 
-To enable video you must enable these options in coreboot:
+To enable video you must enable CONFIG_GENERIC_LINEAR_FRAMEBUFFER in coreboot:
 
-   - Set framebuffer graphics resolution (1280x1024 32k-color (1:5:5))
-   - Keep VESA framebuffer
+   - Devices->Display->Framebuffer mode->Linear "high resolution" framebuffer
 
 At present it seems that for Minnowboard Max, coreboot does not pass through
 the video information correctly (it always says the resolution is 0x0). This
@@ -184,9 +183,9 @@ boot as a coreboot payload, based on a known-good build of coreboot.
 
 To update the `coreboot.rom` file which is used:
 
-#. Build coreboot with `CONFIG_LINEAR_FRAMEBUFFER=y`. If using `make menuconfig`
-   this is under
-   `Devices ->Display->Framebuffer mode->Linear "high resolution" framebuffer`.
+#. Build coreboot with `CONFIG_GENERIC_LINEAR_FRAMEBUFFER=y`. If using
+  `make menuconfig`, this is under
+  `Devices->Display->Framebuffer mode->Linear "high resolution" framebuffer`.
 
 #. Compress the resulting `coreboot.rom`::
 
-- 
2.34.1

