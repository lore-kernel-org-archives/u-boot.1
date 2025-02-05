Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF7C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9329880934;
	Wed,  5 Feb 2025 14:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288CE805E7; Wed,  5 Feb 2025 10:11:58 +0100 (CET)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA78280207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 10:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+dt@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ynvcq2FMbzn7G;
 Wed,  5 Feb 2025 10:11:55 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ynvcp3sfszCfQ; Wed,  5 Feb 2025 10:11:54 +0100 (CET)
From: Quentin Schulz <foss+dt@0leil.net>
Date: Wed, 05 Feb 2025 10:11:34 +0100
Subject: [PATCH] Add 'bootsource' /chosen property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
X-B4-Tracking: v=1; b=H4sIAEUro2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNT3aT8/JLi/NKi5FRdC5OUNCNT01TLVLNkJaCGgqLUtMwKsGHRsbW
 1APEznJ9cAAAA
X-Change-ID: 20250205-bootsource-84df255e9e6c
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heiko Stuebner <heiko@sntech.de>, devicetree-spec@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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

Note that this property is already set by Barebox and I'm planning on
adding it to U-Boot as well, specifically for Rockchip SoCs.

I have some doubts about the wording, especially in the case of
hypervisors or chained boot programs. I'm not entirely sure what would
make the most sense to put in the property for those scenario.
---
 source/chapter3-devicenodes.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
index 8080321d6e60d6b1e86c81af86c6850246a0223b..defd1a46e4ffaa4bb085306b5e153d38b740ac66 100644
--- a/source/chapter3-devicenodes.rst
+++ b/source/chapter3-devicenodes.rst
@@ -456,6 +456,9 @@ time. It shall be a child of the root node.
                                                        the client program. The value could
                                                        potentially be a null string if no boot
                                                        arguments are required.
+   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
+                                                       node representing the device the BootROM used
+                                                       to load the initial boot program.
    ``stdout-path``         O     ``<string>``          A string that specifies the full path to the
                                                        node representing the device to be used for
                                                        boot console output. If the character ":" is

---
base-commit: 5688e1c0b961d2ca5a32e3b624a9f4a9b433184f
change-id: 20250205-bootsource-84df255e9e6c

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

