Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40ADCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53A6838D7;
	Fri, 24 Oct 2025 19:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="WaZnv32l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0110C83677; Fri, 24 Oct 2025 19:29:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF9D836A3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4C949260A5;
 Fri, 24 Oct 2025 19:29:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLS2KiFhwrtp; Fri, 24 Oct 2025 19:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761326967; bh=aw3eOAeZ+pVSspN+lxIs7FD43W5ZL7VvKc0KYUWE3ds=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WaZnv32lB4zsbJp/XDe9SEfTbKRrHGIow29Xlzr7XGXkFzWh8TOPbUdzlOXvHEnik
 sx+dLUvNv/GQaGcRiekfJNC0ML+YsvqP0ZJ7Lko4dXTmD6/a5kbl/7QwrInT1Ia8Av
 OWu2+OOj/zW8hKLWba0+JOBmpC+Yw/Uo3x7rQhUcjdFdddU8mZITofBqwO92BfzymK
 j6ZRnYsC6I+xazoGVqqdq0p6d40J/rwvDDBlHMIkbYwaMM7Brh5qVK02qffVxV/Nh4
 UGJIR8gJm1T+VyQV2gSUjZh9NK1ZsKXaVsL3uLjFfM7vPPCvVfyRJHQnLiql3DO7ln
 eoBe5lIVQ5teA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Oct 2025 22:58:29 +0530
Subject: [PATCH v2 3/3] doc: samsung: exynos-mobile: add documentation for
 exynos7870
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-board-exynos-mobile-v2-3-e6fce69e60c3@disroot.org>
References: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
In-Reply-To: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761326916; l=3594;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=aw3eOAeZ+pVSspN+lxIs7FD43W5ZL7VvKc0KYUWE3ds=;
 b=qNRcuY+yQi8iUp+lV8znZ4TZo2X8jSZQ/KazlB+QxTBBSTNrCYdOQ9PMOEgUGu0S3nmpFZApP
 znsPKe26u7OAUnyG+I9tP5b3jzgVssEXG330uiYQtemp3n8/GjIFffy
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 24 Oct 2025 19:37:56 +0200
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

Document the image preparation and flashing techniques for
Exynos7870-based boards. This is done in a separate file in a
sub-directory, which is linked back to the main documentation.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 doc/board/samsung/exynos-mobile.rst            |  5 ++
 doc/board/samsung/exynos-mobile/exynos7870.rst | 85 ++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/doc/board/samsung/exynos-mobile.rst b/doc/board/samsung/exynos-mobile.rst
index d5c1c83a4e84ac0fc9401b02de0ec786c9397892..9634991c0a171da832c65e119d6fe3e3b8331840 100644
--- a/doc/board/samsung/exynos-mobile.rst
+++ b/doc/board/samsung/exynos-mobile.rst
@@ -38,3 +38,8 @@ Preparation and Flashing
 ^^^^^^^^^^^^^^^^^^^^^^^^
 Since U-Boot supports multiple boards, and devices have different requirements,
 this step will vary depending on your target.
+
+.. toctree::
+	:maxdepth: 1
+
+	exynos-mobile/exynos7870
diff --git a/doc/board/samsung/exynos-mobile/exynos7870.rst b/doc/board/samsung/exynos-mobile/exynos7870.rst
new file mode 100644
index 0000000000000000000000000000000000000000..bbd857580b8275a7cc87b539075a9a9c17c630cc
--- /dev/null
+++ b/doc/board/samsung/exynos-mobile/exynos7870.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Kaustabh Chakraborty <kauschluss@disroot.org>
+
+Samsung Exynos 7870 Boards
+==========================
+
+Preparation
+-----------
+Create the following device tree (named ``stub.dts``)
+
+.. code-block:: devicetree
+
+	/dts-v1/;
+
+	/ {
+		compatible = "samsung,exynos7870";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		model_info-chip = <7870>;
+		model_info-hw_rev = <0>;
+		model_info-hw_rev_end = <255>;
+
+		chosen {
+		};
+
+		memory@80000000 {
+			device_type = "memory";
+			reg = <0x0 0x80000000 0x0>;
+		};
+
+		memory@100000000 {
+			device_type = "memory";
+			reg = <0x1 0x00000000 0x0>;
+		};
+	};
+
+The chosen node and memory ranges are populated by S-BOOT. A certain device
+model may have multiple variants, with differing amounts of RAM and storage. The
+RAM capacity information is graciously provided by S-BOOT's device tree
+overlays.
+
+Compile it to a device tree blob, then pack it in the QCDT format [1]_ using
+``dtbTool-exynos`` [2]_ by issuing the following commands:
+
+.. prompt:: bash $
+
+	dtc -I dts -O dtb -o stub.dtb stub.dts
+	dtbTool-exynos -o stub-dt.img stub.dtb
+
+Finally, use ``mkbootimg`` by osm0sis [3]_ to generate the boot image:
+
+.. prompt:: bash $
+
+	mkbootimg -o u-boot.img \
+		--kernel	.output/u-boot.bin \
+		--dt		stub-dt.img
+
+Offsets are not provided to ``mkbootimg`` as S-BOOT ignores them.
+
+Flashing
+--------
+If flashing for the first time, it must be done via Samsung's Download (Odin)
+mode. Heimdall [4]_ can be used for flashing, like so:
+
+.. prompt:: bash $
+
+	heimdall flash --BOOT u-boot.img
+
+However, if U-Boot is already installed, you may also use its fastboot interface
+for flashing. Boot into the boot menu by holding the volume down key. Enable
+fastboot mode from there, connect the device to your host, then run:
+
+.. prompt:: bash $
+
+	fastboot flash boot u-boot.img
+
+To flash an OS image in internal storage, fastboot is a reliable option.
+
+References
+----------
+.. [1] https://wiki.postmarketos.org/wiki/QCDT
+.. [2] https://github.com/dsankouski/dtbtool-exynos
+.. [3] https://github.com/osm0sis/mkbootimg
+.. [4] https://git.sr.ht/~grimler/Heimdall

-- 
2.51.0

