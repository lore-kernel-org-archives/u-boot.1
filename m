Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7827C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BC4826AD;
	Mon,  5 May 2025 18:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFC5820E8; Mon,  5 May 2025 17:34:36 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DFC801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+dt@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrlvF14k0zWJt;
 Mon,  5 May 2025 17:34:33 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZrlvD0tHpzRhC; Mon,  5 May 2025 17:34:31 +0200 (CEST)
From: Quentin Schulz <foss+dt@0leil.net>
Date: Mon, 05 May 2025 17:34:22 +0200
Subject: [PATCH v2] Add 'bootsource' /chosen property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-bootsource-v2-1-5a315d9bff26@cherry.de>
X-B4-Tracking: v=1; b=H4sIAH3aGGgC/23MQQ7CIBCF4as0sxZDJ6WKK+9huqAwCJtihkpsG
 u4udu3yf8n7dsjEkTLcuh2YSswxLS3w1IENZnmSiK41oEQlUSoxp7Tm9GZL4jo4j0qRptFCO7y
 YfPwc2GNqHWJeE2+HXfrf+pcpveiFVn6YzaiNxcvdBmLezo5gqrV+ASoNhuukAAAA
X-Change-ID: 20250205-bootsource-84df255e9e6c
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heiko Stuebner <heiko@sntech.de>, Simon Glass <sjg@chromium.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Daniel Golle <daniel@makrotopia.org>, devicetree-spec@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Mon, 05 May 2025 18:13:02 +0200
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

Bootloaders typically can be loaded from different storage media, such
as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
such as USB (via proprietary protocols loading directly into SRAM, or
fastboot, DFU, etc..), JTAG, ...

This information is usually reported by the SoC-ROM via some proprietary
mechanism (some specific address in registers/DRAM for example).

It would be useful to know which medium was used to load the first stage
of the bootloader. SoC-ROM shall be ignored and not reported in this
property.

This can allow client programs to detect which medium to write to when
updating the boot program, or detect if fallback mechanisms to
unexpected medium were used to reach the client program's execution.

In cases where a boot program is split into multiple stages (like
U-Boot), it only represents the device that was used to load the very
first stage (in case of U-Boot, VPL/TPL/SPL whichever is executed first)
and not any of the later stages (in case of U-Boot, TPL/SPL/proper) or
any client program. They may match, but they may not and this property
is meant to only represent the device used for loading the very first
stage.

I have a board running U-Boot which currently has 9 boot scenarios
(eMMC/SD/SPI-NOR for the first stage, eMMC/SD/SPI-NOR for the next
stages; not counting USB loading yet, which would make it a few more). I
cannot force the BootROM of this board to select a specific device aside
from erasing the other media.
The only way to identify which device was used for the first stage is to
parse U-Boot first stage console output or add some custom logic for my
board. To validate that a new version of the bootloader works, including
the fallback mechanisms, I need to make sure the BootROM loads the first
stage from the expected device otherwise I may have false positives.
This would be useful for automated testing.

I could also very well see this being used to identify where the first
stage of the boot program is stored (which may differ from where the
later stages are! that's the case for U-Boot proper for example!) to be
able to update it from a client program.

Note that Barebox has been using this property for a while already, with
this very content[1].

This is chosen as a string so that it matches other properties in
/chosen (e.g. stdout-path) as well as allows for extending it, in case
one needs to provide additional information (e.g. HW boot partition for
eMMC, a specific disk on an AHCI controller, a specific USB device on
a USB bus, etc.).

[1] https://lore.kernel.org/u-boot/0066fcc2-3431-48be-8dc2-00ea7e2550c2@pengutronix.de/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Note that this property is already set by Barebox and I'm planning on
adding it to U-Boot as well, specifically for Rockchip SoCs.

I have some doubts about the wording, especially in the case of
hypervisors or chained boot programs. I'm not entirely sure what would
make the most sense to put in the property for those scenario.
---
Changes in v2:
- added usecases, non-usecases and increased verbosity of the definition
  of the property name as requested by Simon,
- Link to v1: https://lore.kernel.org/r/20250205-bootsource-v1-1-95f4ba69ac27@cherry.de
---
 source/chapter3-devicenodes.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
index 8080321d6e60d6b1e86c81af86c6850246a0223b..98cab42c105d9a390f74a6f80fb2bba61d5bb919 100644
--- a/source/chapter3-devicenodes.rst
+++ b/source/chapter3-devicenodes.rst
@@ -456,6 +456,23 @@ time. It shall be a child of the root node.
                                                        the client program. The value could
                                                        potentially be a null string if no boot
                                                        arguments are required.
+   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
+                                                       node representing the device the BootROM used
+                                                       to load the initial boot program.
+                                                       If the initial boot program is split into
+                                                       multiple stages, this represents the storage
+                                                       medium or device (e.g. used by fastboot) from
+                                                       which the very first stage was loaded by the
+                                                       BootROM.
+                                                       It may differ from the device from which later
+                                                       stages of the boot program or client program
+                                                       are loaded from, as this property isn't meant
+                                                       to represent those devices.
+                                                       A later stage of the boot program, or the
+                                                       client program, may use this information to
+                                                       favor the device in this property over others
+                                                       for loading later stages, or know the storage
+                                                       medium to flash an update to.
    ``stdout-path``         O     ``<string>``          A string that specifies the full path to the
                                                        node representing the device to be used for
                                                        boot console output. If the character ":" is

---
base-commit: 5688e1c0b961d2ca5a32e3b624a9f4a9b433184f
change-id: 20250205-bootsource-84df255e9e6c

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

