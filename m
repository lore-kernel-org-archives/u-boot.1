Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C16606A32F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oha9UzGY;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=VYjZDLiy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E48660863;
	Tue, 17 Nov 2026 09:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbl6EJdZvcqU; Tue, 17 Nov 2026 09:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7954E60858
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907181;
	b=lqSC2TFYKkAoL3CWa6Vhy3fi8yBtbzbL5P9exmHy1RwtFPGwRk/UHubPjhtAHhUAsYUW
	 Up+yBBinVUvZkvH+WAbNYj+mdQtbxFZu016dXmKuArL0VBkZaH14KkILgkfr9/NW6Lt5r
	 rdExhTXJoFMofPaZWLWvE7qjgziBIhiA7ZLkOJYaKeHOl2bdkQBoonKN1LDy1asxquOhU
	 bJUeDJS2z8xtSSFr4VenfRfgPIDfqjX1akkKjBTtH+D1Sn8/WXHXrcRvK1Ce997WCipiK
	 /iZmCg0E0sx1MiEKG+T0iA+MZrcM11vgCpRQgRDRnL9gH6BEbrM9a5JE9MFS7WZLlZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fvYRq8UjSItXa6htaSq6FsB2GDMh6LrYavknVLY3wF4=;
	b=hBCif/Woo9s12iaBSHNJwVH0+zP7OxRyu4u2/1/QKaHaZEVrTHfeHFmDVtXWUVcZF2rq
	 Ka7PG/CtXNGLODCjNYOhoeuYf+Bcys8qOCxvg2duVMwirDllM7N6K8oHz8UXWpkOx4fxl
	 df18BdxnI7beXD9BYR6mnjwlpAM1Ym7nANAZJ+YGE3uijt8im4fXXSEKbcXetedPJqdII
	 hMEolSrwfq4K3ruGczNmDp9a8/lsBhZUN/f6c7TdlyYwcnohCOc35msYH2DFr9z7QiJwu
	 wsLZ1V0Wd3n5N8xl/vgWDXIfQj9K1RX6hds58OHvcmXDkBJ33CyacWbceqm/1VkAPPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907181;
	bh=fvYRq8UjSItXa6htaSq6FsB2GDMh6LrYavknVLY3wF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oha9UzGYQq+Pkb6VYJBr+Ep6r8P02uve3r0jHNvgCe/09p24jauT95h0z0I01SjH2
	 jVubCvroCHxk6nBDwwRD2sFYQyhfxwX0Tgc7tPBSWZL/+1mfgi0hbnzQsqxh1JtozY
	 k7wKV3jFHyIEgjdFvtp0N+eV2OB2+cq6Y/1Iq+Uw1N32bN20SaswKL3wz7YH0N4XvS
	 ekNDWjBF/cEjGk4jgebNbqtL3CwsSt4scHk5JDB+kRdF1ToUxfEhym6iOnhVLMiJjd
	 41TgmxNGcXdByaa3MbCo6cfUL/Qj1AcO5Z5wjwDR4Tcby7Djsey7FkzO3xxeIOZtW3
	 n5GYmX05xWxBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7954E60858;
	Tue, 17 Nov 2026 09:19:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58AACA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4ABA780F70
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZAy1t-7E3Ci for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B157080DFD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.9;
 helo=smtp-1909.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=VYjZDLiy
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B157080DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:38 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1g5vhpzT5T;
 Tue, 17 Nov 2026 10:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907175;
 bh=fvYRq8UjSItXa6htaSq6FsB2GDMh6LrYavknVLY3wF4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VYjZDLiyuMw2pm8ybEq6a5k6M0gq0+5q7GFXpdmYc/r9sfhD/nlq2FvYxllQTb07J
 HRT76aiTBgq5DHRc1q7wYHAZbHGHnhnt51dDLzcqnS46HRV0bfTkXhe2QCpohqVgi6
 oAwxANXh5lZahGzQBU4+QjJhMEYWe3iz8Fcg8mKybgQcXq9DaDV3MeIOohIjYjDXrE
 nvvVNKZdgaFfzqrGkoJ7gh04uu1ZI2Kl8jozcOSTdKuK0/kcm+QPPpjoIJhh2M9nsb
 uwjqLJvMp8/CfHdPNk5D1YUB2IGcNSyj5XosDrsL9Q6+E7eTorqj34Dks/VgY4+gTh
 qb17aFoRAtZ9A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1f1gGpzgtQ; Tue, 17 Nov 2026 10:19:34 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:04 +0100
Subject: [PATCH next 02/10] rockchip: be consistent on the "wording style"
 for MaskROM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-2-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Jonas suggested[1] to have a single style for Rockchip's BootROM, so
follow the recommendation and update all mentions to follow the same
style. I've decided to capitalize MaskROM so it's consistent with
BootROM.

[1] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Kconfig          |  6 +++---
 arch/arm/mach-rockchip/spl-boot-order.c |  2 +-
 doc/board/qnap/ts433.rst                |  4 ++--
 doc/board/rockchip/rockchip.rst         | 16 ++++++++--------
 drivers/clk/rockchip/clk_rv1126.c       |  2 +-
 tools/rkimage.c                         |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 2dc45aa54077..fef5932844e6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -751,12 +751,12 @@ config ROCKCHIP_SPI_IMAGE
 	  is built by binman. U-Boot sits near the start of the image.
 
 config ROCKCHIP_MASKROM_IMAGE
-	bool "Build a maskrom mode image for Rockchip"
+	bool "Build a MaskROM mode image for Rockchip"
 	depends on TPL || ROCKCHIP_EXTERNAL_TPL
 	select SPL_RAM_DEVICE
 	help
-	  Rockchip SoCs support maskrom mode boot over USB. Enable this
-	  option to produce maskrom mode boot images containing U-Boot.
+	  Rockchip SoCs support MaskROM mode boot over USB. Enable this
+	  option to produce MaskROM mode boot images containing U-Boot.
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index d2dd5e10935f..2bcf9fab0426 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -104,7 +104,7 @@ void board_boot_order(u32 *spl_boot_list)
 {
 	int idx = 0;
 
-	/* Add RAM boot for maskrom mode boot over USB */
+	/* Add RAM boot for MaskROM mode boot over USB */
 	if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
 	    read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
 		spl_boot_list[idx++] = BOOT_DEVICE_RAM;
diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 1e1bfbb91901..446c8ec8f2a8 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -57,7 +57,7 @@ Image installation
 ------------------
 
 The Qnap thankfully provides an easily accessible serial header as well as
-a very user-friendly jumper-header to bring the device into maskrom mode.
+a very user-friendly jumper-header to bring the device into MaskROM mode.
 
 To access both, the drive trays need to be removed. Looking at the board,
 through the upper cutout of the metal frame the white 4-port serial-header
@@ -74,7 +74,7 @@ Directly below it, the mentioned 2-pin jumper header can be seen.
 
 To write your u-boot to the device, it needs to be powered off first. Then
 a jumper or suitable cable needs to be used to connect the two pins of the
-maskrom header. Turning on the device now will start it in maskrom mode.
+MaskROM header. Turning on the device now will start it in MaskROM mode.
 
 It is important that the jumper gets removed after that stop and before
 actually trying to write to the emmc.
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 2dfbfa5f5f8c..60b190c198e1 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -333,16 +333,16 @@ Notes
 
 * rk3036: SDMMC and the debug uart share the same iomux, so if
   a SD card is the boot medium, the debug uart must be disabled.
-* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
+* rk3066: eMMC and NAND share the same iomux, so if in MaskROM mode
   and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
 
-Mask ROM mode
+MaskROM mode
 -------------
 
-Mask ROM mode is the fallback mode of the BootROM,
+MaskROM mode is the fallback mode of the BootROM,
 in which it listens for USB commands 0x471/0x472.
 
-Options to get your board into Mask ROM mode:
+Options to get your board into MaskROM mode:
 
 * Hold the recovery button, depending on firmware support or wiring,
   while booting the board.
@@ -352,7 +352,7 @@ Options to get your board into Mask ROM mode:
 Methods of last resort (USE AT YOUR OWN RISK):
 
 Short the following pins briefly while powering the board, so the BootROM
-cannot locate any boot firmware and falls back into Mask ROM mode:
+cannot locate any boot firmware and falls back into MaskROM mode:
 
 * NAND: connect pin 8 and 9 of the NAND flash with a needle.
 * eMMC: connect the clock line to ground.
@@ -476,7 +476,7 @@ Note:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
-If all other boot options fail then it enters into a Mask ROM mode on the USB OTG port.
+If all other boot options fail then it enters into a MaskROM mode on the USB OTG port.
 This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
 SD Card
@@ -517,9 +517,9 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
 NAND
 """"
 
-Bring device in Mask ROM mode:
+Bring device in MaskROM mode:
 
-If bricked and no Mask ROM mode shows up then connect pin 8 and 9
+If bricked and no MaskROM mode shows up then connect pin 8 and 9
 of the NAND flash briefly with a needle while powering the board.
 
 Show connected devices with:
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 018232dcb027..c80044c93308 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -1724,7 +1724,7 @@ static ulong rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
 
 	/*
 	 * the child div is big enough for gpll 1188MHz,
-	 * even maskrom has change some clocks.
+	 * even MaskROM has change some clocks.
 	 */
 	if (rockchip_pll_set_rate(&rv1126_pll_clks[GPLL],
 				  pmu_priv->pmucru, GPLL, rate))
diff --git a/tools/rkimage.c b/tools/rkimage.c
index 34f563f6a169..aa68ea792ead 100644
--- a/tools/rkimage.c
+++ b/tools/rkimage.c
@@ -6,7 +6,7 @@
  * rkimage.c combines the TPL/SPL binaries into a single image, sets the
  * magic value expected by the SoC in the first 4 bytes and RC4-encodes
  * the result if needed. The output is typically used as payload
- * for the Mask ROM, uploaded via USB OTG or stored on a boot medium.
+ * for the MaskROM, uploaded via USB OTG or stored on a boot medium.
  */
 
 #include "imagetool.h"

-- 
2.56.1

