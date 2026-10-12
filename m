Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E69CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96DD56064C;
	Mon, 12 Oct 2026 15:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AP0wIXmCC2ow; Mon, 12 Oct 2026 15:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF1F060669
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817284;
	b=XF5iIF/oIcht0hzG0y1aDcyyXIqUmp/cFfm/C8U2n1mwTZuvT8iIOQfJ5TGL4CgDaTke
	 p/V3Fzio70It1+ux2A4mzp2L9yZNttxCboljgDoTNaSWpfkEx5lQ3FBu4n5vrV2otfvmy
	 K0pKWbErwXdLMsDNxocjwjW41veiMaGqlVIXhcKlbgfSg/Dibnc9h/r4kbHoRw9kq13xc
	 iNWOwJ9On2Hs6xirVxb9O2uq65QFQr6iW9GT0iT326QF3mrD2ATc6nT4kB68PRLFLFls3
	 7qzGLsrolPWTV5fWpW9qIsm0tNxdnqk5iOaVy7aTp6cUwEzS5W7uMLw/waOnv3xOSJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=XwHjDvCqQzTYQn5LJAvxporpx+/yKih+u2NI/YZ6JNE=;
	b=cktpyOo1VJHBn/JIm8bPDGGnQE3QZ5cSEtTOZrf1uwqQ7J1iE3GtwozZBNzlmFVnMwXq
	 ZjVToqApnIt2jxzZ4h+LuCx+q/0O4ubWFdDSH3aMc4yatj5VfKKm4UHPx+PW+G4VYOMq5
	 gVwK6l5DbIb+pkL7gvdX7E0cVxq982q/AztpvDQGw4xxGciX4W6+yqhuOcaA4wGAR0F1Q
	 Vf7ViS3mGtYiQyLK8BLwn12r1GLeauuogwJ/gRG5xDu1sZipT0X2atBQz2MvwynCSG/aI
	 EQxTlcOJyh1S9GWb4C2IgRiyTPSSKxO/Q24fChwhBLVWh3yRAYLtrDdrNRYCEr7Mhag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817284;
	bh=XwHjDvCqQzTYQn5LJAvxporpx+/yKih+u2NI/YZ6JNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gBsFvIZudWVs4GhdGC1tKMwAkqEZpz3HwVqWcWuSieuqyXUJzr0ImugVrF5+JaPXs
	 kgK9j1OPCFWoqk4E21i6vhE4OSO4t1p0ELxe6ADgMuWS2biSZ5S04MJLnGcV5Q+b8o
	 ODS7CX1yqFaK2K5YocfwEL8O3GLOBaaBs5uIA4EZ5RUUHvSbXElzejGptT9sryHPgP
	 uTA2BQbmh6jFJAs12Q24O2jAMiuB3dtmcEaBQxvHBKD72yIewA5nhmrUodmpZJjpK+
	 UejtCCjzALfYGFUqgPgFzOWl97gmfgcYcQfOWULUi7OwuJMpepCuP/OldWTaZD0i5w
	 0rRkqSZIOnSPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF1F060669;
	Mon, 12 Oct 2026 15:01:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 134319DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11394401E1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2V_aST-18zm for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 46B92401D5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791811341;
 b=dOWJ1jA/uYAHe9X4XQH+lZHarUyUDO2/7L08RhTVFYDgpNmwRlzrXtl+hEnkdaNUkmVL
 Ju+rRYezGJCkYsnCah1C+ROZcFkG3wlHmyre1Zfq6mFMiqklVDmeJK6q3sUZtGrCzEEuw
 j8lxfFy3mtTOQGDW0Gh5+xKFz6lmWIoOvkYPQvnQgZnTTqwyJbSdLfn96efH94xKuPDkd
 WPhlC28CQBDBB24pDTsbFbo3ygh47IzvDSWRT+NXufRkZa4u48HrEpVdz44gZZclPH2FO
 EJoXyCFNNmSPywwFC2NQW0l9bZWtL4i0hFanLfyklB4ZLMxr3QFILXLwyK9BZNA9pmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791811341;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=XwHjDvCqQzTYQn5LJAvxporpx+/yKih+u2NI/YZ6JNE=;
 b=Nfms4kMZsHg+sKCd+hS97+dRcO0Cn1IeCRcSJZtWGaDQmtUC2XZW8ALHKUQM8J+JiSmO
 E2IcP4mIAzAbNoNAyzXU9gL3rh/hNV4XWOEB9mxYV/3gNsJ74mDmV26gHXlrPZ/sMxNIi
 5baEoqchCl1fGA92JIQVHmMdsBe/J131HzpUac54PH5h8bWu2rPR5HBA2fD/duf8kF3hz
 76nhcupECoi3jnS0I5ooxb7ZFNaO3jvP8cRTo0KWFpAedY9jgEQUaF0fbdnxPGKFgyeUO
 pPqizEGLATf7kGi270zdlLiQwd715AyQRTagRK05Ye7632l/vol4eIvD83kGd6NIvDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ay1ZxkQV; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ay1ZxkQV
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46B92401D5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 63FA060AA2;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C45EC2BCFD;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791811339;
 bh=erfXo+UF2ZdPJYkfDQSGh5gSJfmce2BnTduuz0rNftg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Ay1ZxkQV0f7aVe6+CjitrA3nn2GDXGdyrqqzPY8dVB+oAVBXtQh6GXqR28ijsEO0G
 xl0XsZYip/+Y53YvVJnfere8t4SZibKVmd+YCvpP1VN4fjJIkFZWTeS/PcpEJoAA1x
 m2XmLuhzVJVoe1sndsu+d81TotCyHqzphoptIy5jT11h0pU0uJKIXbDY3PNXqcGwip
 Js5ULXh92x8+oapKlk2D8EflBevxoH3GJQeeSHakyJptXi/XIPHjkZaO+EC4G0l2Gr
 6QKet+VEI2VIYvyBHFKnqJezo1PfbydweRmDY5DoBI5mlO3fuuQGkDdxXxRuVDM+jm
 kXuxCEDMahY5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 02DDECA9EDE;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Mon, 12 Oct 2026 21:22:18 +0800
Subject: [PATCH v2 3/3] board: rockchip: Add FriendlyElec NanoPi R28S
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-nanopi-r28s-v2-3-3d162759dd3d@proton.me>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
In-Reply-To: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=TJybbvr0PctsDCGzRg8/U7Rw4E7ysvYnyze25HOPRPI=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwz9znX6J8Is+M7tC+/M6rp9Ez5TsUjvTrsFnpf50fVS
 8Z2zIzsKGVhEONikBVTZJHdVB0ptCp6ZhGL1HGYOaxMIEMYuDgFYCLZaxj+Cun+V/o7Ze7krmSv
 J9fWXe9YGXY+5W91ipvaI65VMSIf7Bj+12WFzCvds/ZDROwT+VtljpznfHNX7z0fM+HKNrGPLLq
 fuQA=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 15:01:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: 安容 <HystericalDragons@proton.me>

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

Specifications:
- SoC: Rockchip RK3528, quad-core Cortex-A53 @ 2.0 GHz
- RAM: 1 GB LPDDR4
- Storage: microSD slot, optional onboard eMMC
- Ethernet: 1x GbE (GMAC1 + Realtek RTL8211F),
            1x GbE (Realtek RTL8111H over PCIe)
- WiFi: AICSemi AIC8800D80 over SDIO
- USB: 1x USB 2.0 Type-C (power input and OTG)
- UART: USB Type-C debug console (onboard WCH CH340E), 1500000 8N1
- Buttons: user (GPIO), MaskROM (SARADC)

Add the board to the NanoPi RK3528 board target, which selects the
R28S FDT based on its HW_ID, and enable CONFIG_BUTTON_GPIO for the user
button.

Features tested on NanoPi R28S:
- SD-card boot
- Ethernet

Signed-off-by: 安容 <HystericalDragons@proton.me>
---
 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi      | 3 +++
 arch/arm/mach-rockchip/rk3528/Kconfig            | 5 +++--
 board/friendlyelec/nanopi-rk3528/MAINTAINERS     | 6 ++++++
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c | 1 +
 configs/nanopi-zero2-rk3528_defconfig            | 2 ++
 doc/board/rockchip/rockchip.rst                  | 2 +-
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
new file mode 100644
index 00000000000..151f1872fed
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
index 87b65d666e9..6e934408e56 100644
--- a/arch/arm/mach-rockchip/rk3528/Kconfig
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -1,9 +1,10 @@
 if ROCKCHIP_RK3528
 
 config TARGET_NANOPI_RK3528
-	bool "FriendlyElec NanoPi Zero2"
+	bool "FriendlyElec NanoPi R28S/Zero2"
 	help
-	  FriendlyElec NanoPi Zero2 single board computer with a RK3528A SoC.
+	  FriendlyElec NanoPi R28S/Zero2 single board computers with a RK3528A
+	  SoC.
 
 config TARGET_RADXA_ROCK_2_RK3528
 	bool "Radxa ROCK 2A/2F"
diff --git a/board/friendlyelec/nanopi-rk3528/MAINTAINERS b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
index 67f14661087..6665e35309a 100644
--- a/board/friendlyelec/nanopi-rk3528/MAINTAINERS
+++ b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
@@ -5,3 +5,9 @@ F:	board/friendlyelec/nanopi-rk3528
 F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
 F:	arch/arm/dts/rk3528-nanopi-zero2*
 F:	configs/nanopi-zero2-rk3528_defconfig
+
+NANOPI-R28S-RK3528
+M:	安容 <HystericalDragons@proton.me>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-r28s*
diff --git a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
index 5719eba9a89..001a047650f 100644
--- a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
+++ b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
@@ -15,6 +15,7 @@ struct board_model {
 
 static const struct board_model board_models[] = {
 	{ 102, 144, "rockchip/rk3528-nanopi-zero2.dtb" },
+	{ 223, 265, "rockchip/rk3528-nanopi-r28s.dtb" },
 };
 
 static const struct board_model *get_board_model(void)
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index dde9134112f..0af811d0ea2 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -28,9 +28,11 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_LIST="rockchip/rk3528-nanopi-zero2 rockchip/rk3528-nanopi-r28s"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_LED=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1f4e58c8be2..c454d417444 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -103,7 +103,7 @@ List of mainline supported Rockchip boards:
 
 * rk3528
      - ArmSoM Sige1 (sige1-rk3528)
-     - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
+     - FriendlyElec NanoPi R28S/Zero2 (nanopi-zero2-rk3528)
      - Generic RK3528 (generic-rk3528)
      - HINLINK H28K (hinlink-h28k-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)

-- 
2.56.0


