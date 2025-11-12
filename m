Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F6CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0E483966;
	Wed, 12 Nov 2025 15:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F66C83966; Wed, 12 Nov 2025 15:58:12 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68878391B
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d663527Kqzbrx;
 Wed, 12 Nov 2025 15:58:09 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d66340sF2z1ZH; Wed, 12 Nov 2025 15:58:08 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 15:58:00 +0100
Subject: [PATCH v2] rockchip: mkimage: enhance comments for v1 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-rkcommon-hdr-v2-1-49e6747f2460@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ7CIBCF4as0sxZTKMXgynuYLgQGIaalGQyxa
 bi72L3L/yXv2yEjRcxw7XYgLDHHtLQQpw5seCxPZNG1BtGLkfP+wuhl0zynhQVHTGuPXmsjjZL
 QLiuhj5+Du0+tQ8zvRNuhF/5b/0CFM86UkaMyZnBODzcbkGg7O4Sp1voFvODuR6gAAAA=
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
- specify what "init_boot_size" refers to, especially since some configs
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
Changes in v2:
- specify init stage is loaded into SRAM by BootROM,
- specify boot stages are loaded into DRAM by BootROM,
- reworded explanation of the "boot" stages to mention multiple stages
  and possibly U-Boot proper, as well as the conditions for BootROM to
  load those, suggestions from Jonas (thanks!),
- Link to v1: https://patch.msgid.link/20251107-rkcommon-hdr-v1-1-6b456bb3dd93@cherry.de
---
 tools/rkcommon.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index d191ea72c63..e7e78ef7e5b 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -76,13 +76,29 @@ struct header0_info_v2 {
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
+ * "init" means the stage that is loaded into SRAM. TPL if there is one, SPL
+ * otherwise.
+ *
+ * "boot" means the next stages after "init" stage that are loaded by the
+ * BootROM into DRAM. Only applicable if "init" stage returns to BootROM (via
+ * the appropriate ROCKCHIP_BACK_TO_BROM symbol, BOOT_DEVICE_BOOTROM is used as
+ * boot device for the next stage and the "init" stage successfully booted) and
+ * if "init_boot_size" > "init_size".
+ * Basically, it is the content of "init" plus the SPL or even U-Boot proper if
+ * relevant.
  *
  * @magic:		Magic (must be RK_MAGIC)
  * @disable_rc4:	0 to use rc4 for boot image,  1 to use plain binary
- * @init_offset:	Offset in blocks of the SPL code from this header
- *			block. E.g. 4 means 2KB after the start of this header.
+ * @init_offset:	Offset in 512-byte blocks of the "init" code from the
+ *			start of this header. For instance, 4 means 2KiB.
+ * @init_size:		Size (in blocks) of the "init" code.
+ * @init_boot_size:	Size (in blocks) of the "init" and "boot" code combined.
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

