Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F84D2E038
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 08:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA2084081;
	Fri,  5 Dec 2025 09:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="COhEDNW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0702484083; Fri,  5 Dec 2025 09:27:39 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B142884056
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 09:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C6D211F993;
 Fri,  5 Dec 2025 09:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764923254;
 bh=MYXLgopmRmioy5gpDDjoOOe25rFlRIN3+zFRGb6p8Us=; h=From:To:Subject;
 b=COhEDNW04KgfH2DmooIdmLdkMJpl1awS8NcAJ9am9YmbA8XlxnjC25X4jDfvZLX+C
 9udQinacrqDsWQlmQ7Gnt8We0h8Vp6zUg4ll6U0z+D200GdDUJNs+2Uovf3UanZvqW
 hQA9GwAix7o1Sw0hx/jmRKqbLbf6sULuamFNYQ4janvlyH35QWszAyYlJAxKjoI3O3
 X8/2MTI6W8FwD6K/EHwXwVi2dUIDCmie4Qy4kulwJ58jyjGTHwYKpSMzKm0lmww7/G
 3/VW5Z7Ao6o6GUBUD1qCILfNLJP8DjaGJQViRMr5YpeA35sGwfgOalp87k1M8+9/ni
 PClj31V3QeY+Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] doc: board: verdin-am62p: Fix boot log output
Date: Fri,  5 Dec 2025 09:27:28 +0100
Message-ID: <20251205082729.39436-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Fix boot log output not being rendered correctly, fix
it doing the same as done in verdin-am62.rst.

Fixes: b8c43968b801 ("board: toradex: add verdin am62p support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 doc/board/toradex/verdin-am62p.rst | 135 ++++++++++++++---------------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/doc/board/toradex/verdin-am62p.rst b/doc/board/toradex/verdin-am62p.rst
index 2f3262b8d1ec..cc60505a40cd 100644
--- a/doc/board/toradex/verdin-am62p.rst
+++ b/doc/board/toradex/verdin-am62p.rst
@@ -125,72 +125,69 @@ one may also use the update U-Boot wrappers:
 Boot
 ----
 
-Output:
-
-.. code-block:: console
-
-U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:46:57 +0100)
-SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
-Changed A53 CPU frequency to 1250000000Hz (U grade) in DT
-SPL initial stack usage: 17080 bytes
-Trying to boot from MMC1
-Authentication passed
-Authentication passed
-Authentication passed
-Loading Environment from nowhere... OK
-init_env from device 9 not supported!
-Authentication passed
-Authentication passed
-Starting ATF on ARM64 core...
-
-NOTICE:  BL31: v2.12.0(release):v2.12.0-1106-g4301798db096
-NOTICE:  BL31: Built : 10:57:58, May  9 2025
-I/TC:
-I/TC: OP-TEE version: 4.6.0-18-g76d920d354df (gcc version 12.3.1 20230626 (Arm GNU Toolchain 12.3.Rel1 (Build arm-12.35))) #4 Tue May  6 19:48:13 UTC 2025 aarch64
-I/TC: WARNING: This OP-TEE configuration might be insecure!
-I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
-I/TC: Primary CPU initializing
-I/TC: GIC redistributor base address not provided
-I/TC: Assuming default GIC group status and modifier
-I/TC: SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
-I/TC: Activated SA2UL device
-I/TC: Enabled firewalls for SA2UL TRNG device
-I/TC: SA2UL TRNG initialized
-I/TC: SA2UL Drivers initialized
-I/TC: HUK Initialized
-I/TC: Primary CPU switching to normal world boot
-
-U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
-SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
-SPL initial stack usage: 1760 bytes
-HW CFG: 0x00
-Trying to boot from MMC1
-Authentication passed
-Authentication passed
-
-
-U-Boot 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
-
-SoC:   AM62PX SR1.0 HS-FS
-DRAM:  2 GiB
-Core:  147 devices, 31 uclasses, devicetree: separate
-MMC:   mmc@fa10000: 0, mmc@fa00000: 1
-Loading Environment from MMC... Reading from MMC(0)... OK
-In:    serial@2800000
-Out:   serial@2800000
-Err:   serial@2800000
-Model: Toradex 0099 Verdin AM62P Quad 2GB WB IT V1.0A
-Serial#: 15664919
-Carrier: Toradex Dahlia V1.1D, Serial# 11287149
-am65_cpsw_nuss ethernet@8000000: K3 CPSW: nuss_ver: 0x6BA01903 cpsw_ver: 0x6BA81903 ale_ver: 0x00290105 Ports:2
-Setting variant to wifi
-Net:
-Warning: ethernet@8000000port@1 MAC addresses don't match:
-Address in ROM is               58:a1:5f:b8:93:f9
-Address in environment is       00:14:2d:ef:07:17
-eth0: ethernet@8000000port@1 [PRIME]Could not get PHY for mdio@f00: addr 7
-am65_cpsw_nuss_port ethernet@8000000port@2: phy_connect() failed
-
-Hit any key to stop autoboot:  0
-Verdin AM62P #
-
+Output::
+
+  U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:46:57 +0100)
+  SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+  Changed A53 CPU frequency to 1250000000Hz (U grade) in DT
+  SPL initial stack usage: 17080 bytes
+  Trying to boot from MMC1
+  Authentication passed
+  Authentication passed
+  Authentication passed
+  Loading Environment from nowhere... OK
+  init_env from device 9 not supported!
+  Authentication passed
+  Authentication passed
+  Starting ATF on ARM64 core...
+
+  NOTICE:  BL31: v2.12.0(release):v2.12.0-1106-g4301798db096
+  NOTICE:  BL31: Built : 10:57:58, May  9 2025
+  I/TC:
+  I/TC: OP-TEE version: 4.6.0-18-g76d920d354df (gcc version 12.3.1 20230626 (Arm GNU Toolchain 12.3.Rel1 (Build arm-12.35))) #4 Tue May  6 19:48:13 UTC 2025 aarch64
+  I/TC: WARNING: This OP-TEE configuration might be insecure!
+  I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
+  I/TC: Primary CPU initializing
+  I/TC: GIC redistributor base address not provided
+  I/TC: Assuming default GIC group status and modifier
+  I/TC: SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+  I/TC: Activated SA2UL device
+  I/TC: Enabled firewalls for SA2UL TRNG device
+  I/TC: SA2UL TRNG initialized
+  I/TC: SA2UL Drivers initialized
+  I/TC: HUK Initialized
+  I/TC: Primary CPU switching to normal world boot
+
+  U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
+  SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+  SPL initial stack usage: 1760 bytes
+  HW CFG: 0x00
+  Trying to boot from MMC1
+  Authentication passed
+  Authentication passed
+
+
+  U-Boot 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
+ 
+  SoC:   AM62PX SR1.0 HS-FS
+  DRAM:  2 GiB
+  Core:  147 devices, 31 uclasses, devicetree: separate
+  MMC:   mmc@fa10000: 0, mmc@fa00000: 1
+  Loading Environment from MMC... Reading from MMC(0)... OK
+  In:    serial@2800000
+  Out:   serial@2800000
+  Err:   serial@2800000
+  Model: Toradex 0099 Verdin AM62P Quad 2GB WB IT V1.0A
+  Serial#: 15664919
+  Carrier: Toradex Dahlia V1.1D, Serial# 11287149
+  am65_cpsw_nuss ethernet@8000000: K3 CPSW: nuss_ver: 0x6BA01903 cpsw_ver: 0x6BA81903 ale_ver: 0x00290105 Ports:2
+  Setting variant to wifi
+  Net:
+  Warning: ethernet@8000000port@1 MAC addresses don't match:
+  Address in ROM is               58:a1:5f:b8:93:f9
+  Address in environment is       00:14:2d:ef:07:17
+  eth0: ethernet@8000000port@1 [PRIME]Could not get PHY for mdio@f00: addr 7
+  am65_cpsw_nuss_port ethernet@8000000port@2: phy_connect() failed
+
+  Hit any key to stop autoboot:  0
+  Verdin AM62P #
-- 
2.47.3

