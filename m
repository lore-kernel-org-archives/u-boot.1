Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB24CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D27740573;
	Mon, 12 Oct 2026 15:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JHRVcbILsnm; Mon, 12 Oct 2026 15:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F31BE40577
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817283;
	b=AIBRJfhydoRZys3yig/r0FTFHlucMYNT2e28WGhV6HDR37zSkVOExkp87sKc5KX+ROr9
	 S8SEKEkAbmlGvGssq9Tj7JuTw2Ri6fxGD13K5RzgGw5B3drQ+L/IegicR7gDTerIHSqSz
	 DNpqwwB7xCYphpGy3TbsJ1439GFvrnkvwJNNj8/nKqsGo0sv6YR1C4cQmfXIvm38Ur5e2
	 JpSqJKJ19G2cj7Z/quolzp5xueJFWtFulcywehT4p0v4LxsMGUb84d1ZA7k1/0ChgMOOP
	 CSf3/AB4nKshN1yh3xCkuLAJ1iTNAFFzCnfgABMPLR4ZBNbBZLx1i0W4h94YEYdAkNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2wzJpqymLONWBXvl6fA1/0EjdBoxMENMMNiKqIeb1II=;
	b=IJC/YVd96quQfbPat8LAgo3wjgO0uW2mN/zIrClq+Lf4dz1hU4eL14PkTtwxvf9dnh2V
	 NLejCLwJnEZS77yssTtDLVoU0x0Ff907IhpudBlv5P7wAwUfJPH+zrWaaB3IlHFDuG83h
	 gbknTUNr0We8rZr7J3n82AE/v1SjMBn6tdO66hQl+25rO7XRFAWPxjolLNdOOat8fdFci
	 qreTqasNOEekqDLbZ9Poir96r8Y/Tk3j0kG10M+dK9+nLnp6gE8+IY7x0bHv2SJB3rwJY
	 m+SdLayNkBx3f0rvNimAdnLQ8ik8PfVNZxHc5/xmsE6FySOjyHX5TPr9pMCxcEVhoew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817283;
	bh=2wzJpqymLONWBXvl6fA1/0EjdBoxMENMMNiKqIeb1II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZrftLqNVg4InlfVVw6cXUIEHEhZ0sWWYKgsn9KTJQw7OWiBBGW00gcS7gWqmALxzx
	 ejlv7z7iCjop6W71J0NXhm7qjwRoFttrNn7rsCTvnhWvH37jxbarcbCYiQOHdkGzuZ
	 gi9urmjx/HMYtYWGGvA3pna0mBxec09lXfPPmSUyzmXl9VeLkNBjydpfoujZryTpN8
	 kcOG4UDLozy4AQCBfoTuNYyqFO/zPX1q4fOo8Ap+F7+dMBYk1uKdpU24faFLdZSJlc
	 l1JB5r3aLiOu7wlVBMTvKz48QBRPhpXHXh0jyUVk6J2KGBb4hmHyhjilnABIhOFXHi
	 qykirgZYYD0XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F31BE40577;
	Mon, 12 Oct 2026 15:01:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0101156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D99C6605D6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWNUJY5cn0uM for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02A8D6060B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791811341;
 b=mf4Tr9T4lsIqUIb5/2Cl41N/21celZKFchjmMDfulYEk4+avQ0h7z4YHZH5Y/bw3iUQA
 sSsropXOVGUwvPc4A7n/+UMMzTCx+aRZ7lhENDIarg45AfWVJ51Vv0jRQmRuAHVJgqrwK
 ueNqkhJ+yvRAqDqUN4o90BVo73UjBdsgxNEgvwwtAnFXm7VhPzIy9yKef7eHerBRb9M1Y
 ciuTytHpeBagDkxaZI4gtnb/O8yrYx+Is8BhstSZFTw3OxRYcPOJMEF3rwkwDU0V/2CkL
 DqDa1bNZQSltkAmfTTsVzdK1tF2T62XKlte3LFZrxsbeim5PAk0h84EZp3tYEbqYZlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791811341;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=2wzJpqymLONWBXvl6fA1/0EjdBoxMENMMNiKqIeb1II=;
 b=OoP5JaGq+QQR7lZR2c2+QQ/8H83r1jKtuT/rKzP4bdL44QyteoApLugGt0/cIZSo06mi
 75Oz9nI18q+0gOQyM3qfjYTdc5USdB1zhmCZzO8XnjYdQZt85WgyiKoKPS/M4cfrnydCt
 WNXu2lGj0a4oOJ+nUZsBqedTY8BhRok2VG+OITLRluy2unpSjfqBvqpukSks5DwmGe0Wp
 mYoHJv+pywDCLr+MWSrX3GayzW4GETjifWYCjJugkVeK/TkRRYgaDXzxIfCOHHUOmBjRO
 nIth30CAL2IDSbLnccCk9RVaaOb6qKxpd/YlECTsny3bAA7z1wRKaqT0yITrsc/u0sw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B3NckGPg; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=B3NckGPg
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02A8D6060B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 56B3E60229;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ED7EC2BCFB;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791811339;
 bh=82iFRSgGzOeQSKmHjRWQSuhS/zeGliypzjZGNvjda7o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=B3NckGPgxg+E81BJX2ZQGqZe2qAFILNWAEZvPVMFJfvPocJIpfxFUdIqDtL0TtxOW
 vC8oU7QTmqVv33/ljwdHaAGEDBCrvQD7Cnl6Ao7e0Wx/dwE4GjnQgOOmXHkq3pHVa/
 phQLF/GdXnIbInEKTntwtQnYpHjB5kO9LgHvhfyFO0kHeqiFwv4ksOlt9zW8kKV/1E
 uf1ROSWgBOjMPMPGXzx8NnGbzDQeLVsL04wx/QVP00nIb+oRDUrxbZQM6qKQpU3FvG
 bsNaM03JTuMSoCeK8R0RMX/fzWc+KpaAZCW+C8NaGnY2j+SWGcQpBM2MySfBCshZ4S
 oE5fphZfc+3hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E4478CA9EC5;
 Mon, 12 Oct 2026 13:22:18 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Mon, 12 Oct 2026 21:22:17 +0800
Subject: [PATCH v2 2/3] board: rockchip: Add common NanoPi RK3528 board target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-nanopi-r28s-v2-2-3d162759dd3d@proton.me>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
In-Reply-To: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6066;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=NiIfV2Qx/1hcZHbnmxz6hKFMCUHDxvDq8FVVT27NAec=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwz9zm3maa0CB3IfevrnZxVuLx8Yu0dtjnJojFStapiS
 zkmL+XvKGVhEONikBVTZJHdVB0ptCp6ZhGL1HGYOaxMIEMYuDgFYCL87Qz/s8v3urktn35kf/2i
 vwdYTk3eZ3J55l7RN1smvH6SF9oStp6RYdLhqNmTzey+HxJNyVJbfmHW3Y0z9HbOMXr/9vn5e/e
 9D/ACAA==
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

The board variant of the FriendlyElec NanoPi RK3528 family can be
identified using the HW_ID voltage divider on SARADC channel 2.

Add a TARGET_NANOPI_RK3528 board target, based on the Radxa ROCK 2
board target, that reads HW_ID to select the FDT in SPL and to set the
fdtfile env var. This allows one defconfig to support multiple NanoPi
RK3528 board variants.

Move the NanoPi Zero2 to the new board target, it is the only variant
for now.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: 安容 <HystericalDragons@proton.me>
---
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi           |  5 ++
 arch/arm/mach-rockchip/rk3528/Kconfig            |  6 +++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS        |  7 ---
 board/friendlyelec/nanopi-rk3528/Kconfig         | 14 ++++++
 board/friendlyelec/nanopi-rk3528/MAINTAINERS     |  7 +++
 board/friendlyelec/nanopi-rk3528/Makefile        |  3 ++
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c | 58 ++++++++++++++++++++++++
 configs/nanopi-zero2-rk3528_defconfig            |  1 +
 8 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
index 3e2fbd81da1..e8c8dc2f032 100644
--- a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
@@ -2,6 +2,11 @@
 
 #include "rk3528-u-boot.dtsi"
 
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
 &vdd_arm {
 	regulator-init-microvolt = <953000>;
 };
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
index 480ac2942ff..87b65d666e9 100644
--- a/arch/arm/mach-rockchip/rk3528/Kconfig
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -1,5 +1,10 @@
 if ROCKCHIP_RK3528
 
+config TARGET_NANOPI_RK3528
+	bool "FriendlyElec NanoPi Zero2"
+	help
+	  FriendlyElec NanoPi Zero2 single board computer with a RK3528A SoC.
+
 config TARGET_RADXA_ROCK_2_RK3528
 	bool "Radxa ROCK 2A/2F"
 	help
@@ -14,6 +19,7 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3528"
 
+source "board/friendlyelec/nanopi-rk3528/Kconfig"
 source "board/radxa/rock-2-rk3528/Kconfig"
 
 config SYS_CONFIG_NAME
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index d1810fb0528..e56108d67cb 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -10,13 +10,6 @@ S:	Maintained
 F:	arch/arm/dts/rk3528-hinlink-h28k*
 F:	configs/hinlink-h28k-rk3528_defconfig
 
-NANOPI-ZERO2-RK3528
-M:	Jonas Karlman <jonas@kwiboo.se>
-S:	Maintained
-F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
-F:	arch/arm/dts/rk3528-nanopi-zero2*
-F:	configs/nanopi-zero2-rk3528_defconfig
-
 RADXA-E20C
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/board/friendlyelec/nanopi-rk3528/Kconfig b/board/friendlyelec/nanopi-rk3528/Kconfig
new file mode 100644
index 00000000000..94b15b06691
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/Kconfig
@@ -0,0 +1,14 @@
+if TARGET_NANOPI_RK3528
+
+config SYS_BOARD
+	default "nanopi-rk3528"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ADC
+	select SPL_ADC
+
+endif
diff --git a/board/friendlyelec/nanopi-rk3528/MAINTAINERS b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
new file mode 100644
index 00000000000..67f14661087
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
@@ -0,0 +1,7 @@
+NANOPI-RK3528
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/friendlyelec/nanopi-rk3528
+F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
+F:	arch/arm/dts/rk3528-nanopi-zero2*
+F:	configs/nanopi-zero2-rk3528_defconfig
diff --git a/board/friendlyelec/nanopi-rk3528/Makefile b/board/friendlyelec/nanopi-rk3528/Makefile
new file mode 100644
index 00000000000..752426dcfdb
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += nanopi-rk3528.o
diff --git a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
new file mode 100644
index 00000000000..5719eba9a89
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <adc.h>
+#include <env.h>
+
+#define HW_ID_CHANNEL	2
+
+struct board_model {
+	unsigned int low;
+	unsigned int high;
+	const char *fdtfile;
+};
+
+static const struct board_model board_models[] = {
+	{ 102, 144, "rockchip/rk3528-nanopi-zero2.dtb" },
+};
+
+static const struct board_model *get_board_model(void)
+{
+	unsigned int val;
+	int i, ret;
+
+	ret = adc_channel_single_shot("adc@ffae0000", HW_ID_CHANNEL, &val);
+	if (ret)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
+		unsigned int min = board_models[i].low;
+		unsigned int max = board_models[i].high;
+
+		if (min <= val && val <= max)
+			return &board_models[i];
+	}
+
+	return NULL;
+}
+
+int rk_board_late_init(void)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model)
+		env_set("fdtfile", model->fdtfile);
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model && !strcmp(name, model->fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index 2c725380ef4..dde9134112f 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
 CONFIG_ROCKCHIP_RK3528=y
+CONFIG_TARGET_NANOPI_RK3528=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000

-- 
2.56.0


