Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF97CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C2683DCA;
	Fri,  7 Nov 2025 17:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6217C83DEA; Fri,  7 Nov 2025 17:49:24 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F357283D2E
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d34lj3hQ0zKVn;
 Fri,  7 Nov 2025 17:49:21 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d34lh3L2PzP6j; Fri,  7 Nov 2025 17:49:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 07 Nov 2025 17:49:07 +0100
Subject: [PATCH] rockchip: mkimage: enhance comments for v1 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-rkcommon-hdr-v1-1-6b456bb3dd93@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNz3aLs5Pzc3Pw83YyUIl1Ly7TUNEvLJJMkMxMloJaCotS0zAqwcdG
 xtbUAVscL5F4AAAA=
X-Change-ID: 20251107-rkcommon-hdr-99fef99b4b64
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Improve the image header documentation for v1 header:

- specify this applies to all MMC, not only SD cards,
- specify the offset for SPI flashes,
- specify the key used for RC4 encoding,
- specify what "init" refers to, especially since some configs enable
  TPL,
- specify what "init_boot" refers to, especially since some configs
  enable TPL,
- specify the size of a block,
- add documentation for init_size and init_boot_size,

Note that the offset on the storage medium isn't necessarily 32KiB (64
blocks) for MMC or 0 for SPI flashes, it's just the first offset the
BootROM checks. Barebox[1] lists a few options, though those are
applicable to RK35xx which use the v2 header, so not guaranteed they can
be shared. On RK3399, the binary can at least be stored at offset 0 and
32KiB on SPI flashes.

[1] https://git.pengutronix.de/cgit/barebox/tree/arch/arm/mach-rockchip/bbu.c#n19

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/rkcommon.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index d191ea72c63..6d1f88bcac1 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -76,13 +76,24 @@ struct header0_info_v2 {
 /**
  * struct header0_info - header block for boot ROM
  *
- * This is stored at SD card block 64 (where each block is 512 bytes, or at
- * the start of SPI flash. It is encoded with RC4.
+ * This is stored at MMC block 64 (where each block is 512 bytes), or at
+ * the start of SPI flash. It is encoded with RC4 with the below rc4_key.
+ *
+ * In Rockchip terminology:
+ *
+ * "init" means TPL if there is one, SPL otherwise.
+ *
+ * "init_boot" means the entire software the boot ROM has to load for booting
+ * U-Boot, typically the TPL if any, and the SPL.
+ * Basically, it is the content of "init" plus the SPL if relevant.
  *
  * @magic:		Magic (must be RK_MAGIC)
  * @disable_rc4:	0 to use rc4 for boot image,  1 to use plain binary
- * @init_offset:	Offset in blocks of the SPL code from this header
- *			block. E.g. 4 means 2KB after the start of this header.
+ * @init_offset:	Offset in 512-byte blocks of the "init" code from the
+ *			start of this header. For instance, 4 means 2KiB.
+ * @init_size:		Size (in blocks) of the "init" code.
+ * @init_boot_size:	Size (in blocks) of the "init_boot" code.
+ *
  * Other fields are not used by U-Boot
  */
 struct header0_info {

---
base-commit: fdf36c2e9ad4f770ee951398a86bd55404d9b7ec
change-id: 20251107-rkcommon-hdr-99fef99b4b64

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

