Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE3606A339
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=guYMW3hi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib+Xm4iR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78F80608B8;
	Wed, 18 Nov 2026 01:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqJ20HtAF1zV; Wed, 18 Nov 2026 01:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BA706085E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965162;
	b=f/WaMQi4yFX5Jdegx0Nq+Ge8RXRrkx/Ihpro1gtOFhGOdl+9UvHvSl7NseR3/ySJm3g0
	 Ohy5zu9r7EWlYO/ttwWhMHL8uHVPX/P8RxmuwcCjE3f4YvC4Jus4EiPlu/UKfSNpPwRH1
	 DwZfp4DC67QNqGz69P16Ygw3x21QN8MGUhs6V1UkMOtOKIAqniOr79WUgj8Q+41H0rZd1
	 H8tuQ/KcmKsRuwVw07YgmeIWphUAj0o9Ss87K/6XaeeqWnI4SKBCLXdUfs4cCKMf1fkXK
	 wEsaZSBqx04iH7k62gAit7almWJMwFWT1rt7WACnvsIYbblHq3E/0EIOWhvayd+7gZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=TuXW0plSezx65WaNxJj5w0bXM1ildQG3DM1Ocbu4Hxg=;
	b=F4hRf6C2t9B0rzJrLdJrmIv4V2YsI757V5j4197Yp2ixlp2VTjPK2aoAFmO9YCeOfruW
	 36d/vxyA9gIUUtuUL2IpHa/6FRBJS6uexZZlAIO+g0j/IQYmYM+auFJojoYXCauGoOP5W
	 FnHv4czUDT9+svONE/KVso45POMoE6/AaBuUiwW6jPMyo/JSSqaGYiIXkuwVfBrVKKO4J
	 HzYKzOtZ/7NucSF28lDGFLkOcqd1bvgGH2TsPD1FGYBDZ+Fpy3BX3d1NHDlWmht9lp0iq
	 PYkEORNtfFZ23DBd/WOwYwZwFAohSn0Z2VFnSVbyBGpbDCo9i4eUi3d7bkNvE/3sH9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965162;
	bh=TuXW0plSezx65WaNxJj5w0bXM1ildQG3DM1Ocbu4Hxg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=guYMW3hiV16OgvNaX7Vd8Avnu+YKuGPoYUMN0TCG7L8Cxbor09z6fw3WcPT4/dGVR
	 OHOSJvwM7E08ht2qFHFqb/6CuhKk44HuFWf/Vpa6/8J9ukMKB+HeaH0l5VaC/mggxl
	 5WXGL5oFPRTmgmLItwH1sjfzjbJvUtaNJNG91NL34u8sm5458KRBvJgKHSPuWfe/ty
	 fTDT9/gkTMwS2c49bzRSFysPxhf4ax8Xk1mFwtilSpIC14m6Oq15PhBtIms87N97Es
	 uVTZNvgOfmLTd1qSh0vQGfLRxC5RvQPMA+yEmnzc1fZDQK/ECPhujNLB4zB+ofHSTA
	 WELoASQYQKi6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BA706085E;
	Wed, 18 Nov 2026 01:26:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CB67D33
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6D6B810B7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:40:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KmzGoSWFJbHM for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:40:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C04FF8109F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ib+Xm4iR
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C04FF8109F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:40:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1B3061CCE;
 Tue, 17 Nov 2026 22:40:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DB0361F000C8;
 Tue, 17 Nov 2026 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794955249;
 bh=TuXW0plSezx65WaNxJj5w0bXM1ildQG3DM1Ocbu4Hxg=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=ib+Xm4iRtxfT0m91K5rCrv4sQgmz50O6pY/aAF7zH4Qr89vkChQd2GJWPNQ+ObR0g
 JXy5lHmA+eAN4URbrzOkbdZLZOSGg/luoUvTTcidnkl2n1y2FVPS443ARhS9YFwCMk
 FwC+FFZGTRdS5JKVvs6ie2cujeoz86y/mnx1lxzM2XrU222tkj9JRlSsr8ylz8DQ7w
 5rPOR3arvOCW6VQx2OQADiAhSJcTnESBHxJ7XmsaVjQQZ3IvAdMrz7AraJZ9DVhMzW
 oXs6AadaXCltlXtBSQFFvG4oN0U5saX6927SHvjhUA8utLcbKfZ4/2hA0DLvKDc/ma
 ruA9sg0Y6WkTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3601B4AB0A;
 Tue, 17 Nov 2026 22:40:48 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 22:40:48 +0000
Subject: [PATCH v3] sunxi: Add Orange Pi 3 LTS defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-sunxi-orangepi-3-lts-v3-1-473ed5569351@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO/X/GoC/4XOTQ7CIBAF4KsY1o4pUNG68h7GBS2DHaNtw1Sia
 Xp3QTcuNC7f/Hx5k2AMhCx2i0kEjMTUdyno5UI0re1OCORSFqpQRhZKAt+6O0Ef8m4g0HAZGZS
 3G+PQeG2kSK9DQE/3F3s4vjPf6jM2Y7byRW0ZoU5K0+bRVzVqcDhwPm+Jxz48XjWjzOyfRlFCA
 bKy2vlKbd0W96erpcuq6a8iN4rqE1E/EJWQ0tSV82tfYak/kXmenxxb6to+AQAA
X-Change-ID: 20261021-sunxi-orangepi-3-lts-2fa76de6f361
To: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.u-boot-project.org
Cc: Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794955247; l=3847;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=RtlKPWjNtEXF0V5zt9qRofSTktGUys8yyv2cqLufyu8=;
 b=SirQuTYr0H4Ns1jO9KpQVx9CsHPZyjl+EO+hgcZgmp7KW7/IwTi6U//WpCp0rZ1LJpPrrHEVa
 GpDtUGY3D7xCq8Q8PFxMnjZHHW7Y1eHmROQTCAcuimWx4jUyaGTAe9w
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: filipescu.cristian@gmail.com
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cristian Filipescu <filipescu.cristian@gmail.com>

Add a configuration for the H6-based Orange Pi 3 LTS using the upstream
Linux device tree. Enable the Motorcomm PHY driver and use red PL4 as
the power indicator through the existing SPL LED hook.

The sun8i EMAC driver reads MAC-level reset properties rather than the
MDIO bus reset in the Linux DTS. Provide the equivalent PD14 reset and
timings in a U-Boot-specific fragment.

Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
Add the Orange Pi 3 LTS defconfig using the upstream Linux DTS and the
existing SPL power LED hook.

The Linux DTS is accepted in sunxi/dt-for-7.5:
https://git.kernel.org/sunxi/linux/c/a203a4bac331
This revision depends on its devicetree-rebasing import and the shared H6
DVFS update. The local DT staging commit is excluded from this submission.

Both defconfigs build with GCC 14.2 and TF-A v2.13.0. On the LTS board,
SD boot, U-Boot DHCP/ping, USB 3 storage enumeration at 5 Gb/s, and red-on /
green-off LED state passed. Linux boots successfully; its board checks and
768 MiB of eMMC HS200 reads at 150 MHz passed with zero reported errors.
Preparation used OpenAI Codex.
---
Changes in v3:
- Select OF_UPSTREAM and the accepted Linux board description.
- Remove the board-specific handoff hook and main U-Boot LED settings;
  use the SPL LED hook for red PL4.
- Supply the existing EMAC driver's reset properties in a U-Boot fragment.
- Rebase onto U-Boot main (2027.01-rc2).

Link to v2: https://lore.kernel.org/u-boot/20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com/
---
 arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi |  9 +++++++++
 board/sunxi/MAINTAINERS                           |  6 ++++++
 configs/orangepi_3_lts_defconfig                  | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi b/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
new file mode 100644
index 00000000..cfbfe60e
--- /dev/null
+++ b/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "sunxi-u-boot.dtsi"
+
+/* The sun8i EMAC driver uses the MAC-level reset properties. */
+&emac {
+	snps,reset-gpio = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+	snps,reset-delays-us = <0 15000 100000>;
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 344f52ea..36db194e 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -443,6 +443,12 @@ M:	Andre Heider <a.heider@gmail.com>
 S:	Maintained
 F:	configs/orangepi_3_defconfig
 
+ORANGEPI 3 LTS BOARD
+M:	Cristian Filipescu <filipescu.cristian@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
+F:	configs/orangepi_3_lts_defconfig
+
 ORANGEPI 4A BOARD
 M:	Chen-Yu Tsai <wens@kernel.org>
 S:	Maintained
diff --git a/configs/orangepi_3_lts_defconfig b/configs/orangepi_3_lts_defconfig
new file mode 100644
index 00000000..85ee37c2
--- /dev/null
+++ b/configs/orangepi_3_lts_defconfig
@@ -0,0 +1,20 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h6-orangepi-3-lts"
+CONFIG_SPL=y
+CONFIG_MACH_SUN50I_H6=y
+CONFIG_SUNXI_DRAM_H6_LPDDR3=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_OF_UPSTREAM=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_SUN50I_USB3=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set

---
base-commit: 45516c31e1227746cda1078897fd44ec1e494a98
change-id: 20261021-sunxi-orangepi-3-lts-2fa76de6f361

Best regards,
--  
Cristian Filipescu <filipescu.cristian@gmail.com>


