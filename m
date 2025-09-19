Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911FCAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 15:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5046B8329F;
	Fri, 19 Sep 2025 17:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A275832AD; Fri, 19 Sep 2025 17:50:33 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF63483285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSxmQ32dYzRtF;
 Fri, 19 Sep 2025 17:50:30 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cSxmP4Xr6zHjs; Fri, 19 Sep 2025 17:50:29 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 19 Sep 2025 17:50:21 +0200
Subject: [PATCH RFC] lib: optee: forbid OP-TEE OS loading without adding
 OP-TEE OS reserved-memory nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-tee-env-needs-optee-lib-v1-1-2d52e75f7580@cherry.de>
X-B4-Tracking: v=1; b=H4sIALx7zWgC/x3MMQqEMBBG4avI1DsQEwTdVvAA24qFxl8dWKIkE
 gTx7kbLr3jvpAAvCPTNTvKIEmR1CfknI7v0bgbLmExa6UJVecU7wHCRHTAGXrfHfxnYaKjeWNj
 SlJTqzWOS4z239Gtq6q7rBoMcQYNuAAAA
X-Change-ID: 20250919-tee-env-needs-optee-lib-32e0a3cec838
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

It is currently possible to build an image with an OP-TEE OS (via the
TEE environment variable) without OPTEE_LIB. U-Boot will happily load
the TEE OS and the next OS (e.g. the Linux kernel).

This is an issue because on FDT-enabled devices, OP-TEE OS adds nodes to
the reserved-memory FDT node for the memory regions it just reserved for
itself. This updated is then passed to U-Boot proper which should know
better not to use memory from there. The actual issue is that without
OPTEE_LIB and OF_LIBFDT enabled, U-Boot proper will not copy those nodes
over to the next OS's FDT before starting it. This results in the next
OS's (e.g. Linux kernel) to not be aware of reserved memory, incurring
random crashes or device reboots when it tries to access secure reserved
memory area.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
I've just lost a day trying to figure out why my board suddenly boot
loops when running a specific program in Linux userspace after updating
U-Boot. I actually inadvertently had the TEE environment variable set
for a device which doesn't actually need to run any TEE OS (so had
OPTEE_LIB disabled).

This device is Rockchip PX30-based and the image is built with binman
like all Rockchip-based devices.

The issue is that I built a U-Boot FIT with an OP-TEE OS that reserves
some memory regions for itself (via the TEE environment variable) but
U-Boot proper "forgot" to propagate those to the Linux kernel's FDT
(because of the missing OPTEE_LIB).

Unfortunately, binman doesn't seem to have access to Kconfig symbols
(grep CONFIG_ doesn't return anything meaningful and binman is either
 configured through FDT nodes or via CLI arguments, c.f. cmd_binman in
 the root Makefile) so I cannot try to be smart and guide the user to
the correct Kconfig option to select if TEE is set. I could add a
property based on the presence of OPTEE_LIB in rockchip-u-boot.dtsi for
example and have a custom message based on that, the issue is that I
assume all FDT-based platforms do actually need to do this dance, and
not only Rockchip.
Another option could be to add a CLI argument to binman through which
we would pass the state of OPTEE_LIB and error out the build in that
case, but that feels like opening the door to dirty hacks (though this
patch is admittedly another dirty hack :) ).

Another option is to propagate the TEE environment variable to the
preprocessor of the FDT (via dtc_cpp_flags) and then I can do

 #if defined(TEE) && !IS_ENABLED(CONFIG_OPTEE_LIB)
 #error "CONFIG_OPTEE_LIB must be enabled!"
 #endif

but we have the same issue as above, it is then Rockchip specific and
also feels bad.

Another option is to remove the @tee-SEQ node from the binman FIT
description when OPTEE_LIB isn't set but then I would lose the nice
message when no TEE is provided:

Image 'simple-bin' is missing optional external blobs but is still functional: tee-os

and even worse, build without any TEE OS even though I could provide one
with the TEE environment variable.

Finally, another option could be to move this hack under
arch/arm/mach-rockchip/Kconfig to make it Rockchip specific or add a
depends on ARCH_ROCKCHIP

OP-TEE OS on Aarch32 Rockchip boards doesn't actually need any of that
if SPL_OPTEE_IMAGE is set because arch/arm/mach-rockchip/sdram.c then
marks some hardcoded memory regions in RAM as holes in DRAM, which has
the same effect as reserved memory regions I guess. I assume other
platforms may use something different, so it may be casting too wide of
a net.

Does anyone have something more delicate than this sledgehammer of a
solution?
---
 lib/optee/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
index e6834d4d3e1fe700d15ae57984ccc2716955ba2d..34b9d8afe675c5aa2aa2122e6716eda1697e3898 100644
--- a/lib/optee/Kconfig
+++ b/lib/optee/Kconfig
@@ -4,6 +4,25 @@ config OPTEE_LIB
 	help
 	  Selecting this option will enable the shared OPTEE library code.
 
+config HAS_TEE_IN_BUILD_ENV
+	def_bool $(success, test -n "$(TEE)")
+	select OPTEE_LIB if OF_CONTROL
+	select OF_LIBFDT if OF_CONTROL
+	help
+	  It is typical whenever OP-TEE OS is loaded before U-Boot proper that
+	  it modifies the FDT passed to U-Boot proper to add reserved-memory
+	  nodes for the RAM it just reserved for itself.
+
+	  U-Boot must copy those reserved-nodes in the FDT for the next OS to
+	  boot.
+
+	  Failing to do so will incur random crashes or device reboots once the
+	  next OS is running.
+
+	  This makes sure that whenever TEE is present in the environment,
+	  meaning a TEE OS will be part of the boot flow, the copy made by the
+	  OP-TEE lib will happen.
+
 config OPTEE_IMAGE
 	bool "Support OPTEE images"
 	help

---
base-commit: f28891d444631c91a6e090927486a2169b51b20f
change-id: 20250919-tee-env-needs-optee-lib-32e0a3cec838

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

