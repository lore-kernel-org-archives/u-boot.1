Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDF606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zbwebUDL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZJ9/JbF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43A7C811F8;
	Thu, 22 Oct 2026 07:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5vNkTnOOfgo; Thu, 22 Oct 2026 07:27:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73CAC811F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654066;
	b=U69IhOGTQgWSig+uz2u1wMZmmqZsMmzjkzHLKmfwA0U4FMETIWHy4zXd2vIFiNAsgVh6
	 WZ3lZYlO54OTba9to1fvSO/xuy/3pz/f6bKwFmPOkr2VleZqjvS0E8ZUOsDDIr6M/z9vU
	 pN4GtYFPoOtWveUj5RmZOrE8YVsc8v0funqnV2hB1HnBZd9mhXKtqBWKir1UKz1SXx57k
	 ANdOn1YIYn33PQAi1l3j1dIM4sXSR7Do0igVo10WLVONeuE17Cm5hSnoa4sgpa4ZbBKS8
	 R/MFiRY/9f5NaUcx0tv2Si54oMp99w1M5AE6+AYTHkwEhIylQ0haTvkwLzJI629nZiA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=DTbStGII4DobQBXgujKJfYI2eU1H/J8AkOyEPKVJ0uw=;
	b=PTSNNfysk4qAFY4vr6LZzzyDNfO8Rx4alcThxGg1YnzmrJLTg73b8m2FBRxOHxDzXyGa
	 jiS5HjjUZQ21Ww26leGwwbxDk+cn0OeiiXGFB0jRqvd3+E4Zdiis8fLoP7tMOLVnHTnnO
	 f7uk9NM9KC2tD/MazAG0ME2JWfH5WNXGvFfrXNfI8Uwms3sRYPeVMMw0w1fHCR97ln3KA
	 9K2k/RkkO8mNfPhFKBalJQfTlpKTleaNAfWbiCU+4/DOvjLutWaRQhcwNiyDKwoq6UfQ7
	 D356gPBLSz+pEjWcdKPERT8OXPKJOtUJBU73inSiH8dw8wb1yTRF2YGR63k7MLUgTFw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654066;
	bh=DTbStGII4DobQBXgujKJfYI2eU1H/J8AkOyEPKVJ0uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zbwebUDLJCTJav61egROGvIDJ9Q55Q3pVBY7c6Byohfb/aQwOx0TGsp6xmY5DXlNo
	 mbALZZ5mjOWJ1inPgZ85uqpFSBo5lCbhhf+sI71HDr/A35Lwp8sqMM8eSBC+pe6yvf
	 H+1DBd5mWiaJI0TqPJdceLVR4PJObyEoaVacHNbql7ymE3eMooj4npwDxqTJL+Hz+M
	 Xl75ZBr3ir1cP4u8zU2eAduLKdLu81eUU1Y7tImOA0NuMe+Qc61TOGAY86+XhfalgJ
	 6b81Co+On4ABBRminBsU0IkYOAJDcs/XLoYrZu02WKHlddFV/BUOwahQFY/twLnSKb
	 9DPshMeU7M0cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73CAC811F4;
	Thu, 22 Oct 2026 07:27:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E7DE81184
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDEC840719
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 97TGSA3bXfOh for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 07A074070A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792648752;
 b=ZcLKV5ABze3NfbgYXqruQETWDI6DMNYG7AY3moelM+FOeQ/OAf7RiA+eqUaY8FU7DJH6
 2yKfydz99sEozzJeDWTOnxKYFYQtODGYE+DhQmO+e0lER8vhBU0vZBdaCLGcKxP8USvKX
 zzuUy6fkMP54hESg1f26WUZ57Gq5j4fYXHiv5wjbtrPAatxmOIKKBYOTOVo2QuIrR2aMg
 1AtD5CDgLAYj8dQ0B3DHZ0aTsOhIKl4MS0k39uOssTafqbu0B6ZrmzXxLH0EkeLNiWUKH
 fAnGCRwkRRdSRRFGfH0n9ke5XjzjlVsKUzqGMpytmdHYoX2d6RfXA1mxdHbXee3+OGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648752;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=DTbStGII4DobQBXgujKJfYI2eU1H/J8AkOyEPKVJ0uw=;
 b=X70dTwxCwDbx4AlIvXSMktLD/zrqVUx09yY6qwdgFBBpYdxDTW+1+TnmVQfNuDlkkflN
 spwO7cKSTjIK4Kop7RPlgxlQeyvURIu68n+x+QaiR2uBlt0RZ8I/tdT2f4KFu8YhnEQcz
 ElgWz1Ijeemap03Z9JlHvwwlf6G1Gwwua9umLpM4+SuGfVIl/sEfAJz1FmBc+CW2Vfkz0
 /ArX9jtDWKxdG6lZx4xsVZzkF0V6hWqN44KLhCuTDSleGnjj+/u8sRkb1wsT6eBfmP5hg
 Ql7aYYL6UKFZOWbO4abHKsMN+CTI76LPljOTZk/98IHPqDMoQbGMjPouC0d6dLeoSEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="CZJ9/JbF"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CZJ9/JbF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07A074070A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E196160018;
 Thu, 22 Oct 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792648749;
 b=UyCuCapsDe6Ps5hEZ/dxysToxB16QSeyG2WwYs0Ohf/aC0oGE7cA3fhXni5X5W55qIGc
 6cpA38fF0gKfdfRxPgK1m9Ykaz6O2TOv5LcHojKYhiRnLY41JxAy4ecf+x63USe8/gUVD
 7XBnIDuzOGN+JtBBOICpny7hGDlM+Xj60A5KcWQPK6QZbiuniYx6fJXZQcYNYwhLdGYHh
 wPv5u9Z5Ut3quNHF230zvphqIDYO42C+1k3KX3I9uWzuucs+COJnq/yHPgGb4Mn+FZ6fh
 pcrGra+SQFgo/xNq/r/1L9MVzu1yJAAXZfi2PASF9meM3QuwE201dhkqEDe8C9QyQSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648749;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=DTbStGII4DobQBXgujKJfYI2eU1H/J8AkOyEPKVJ0uw=;
 b=Pry8qASptdjwfe+Wp0R45CI+VDjvVx+k35Rff34LultYvm3cGUbpNMeRc3lvWio7T46f
 m+YCCEheZdBdT7bFjufdXH0nMXbLc0kEmfTdzsyplwYqPgX1qkOVsIyr5uC/cHiwxoS2e
 a94YhCkCnCKy05RhF1Y1kaURlgu2GZxtuzMJia957alNx9pBbdh53BIYe+QMUIKee/ymA
 HDbMoUOyB9feYB41wII9fKwZbXhf6UMe/CgZOQaFoagHUMPp4yBDKoak83LLXTLcb1r/T
 ycl7/W3AEWQDGuiFq1rYwdyOC1Bb3IbnPgLTZOy506zICLIG2OTOhSDn2wCiAwfQzSQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E96A11F000C1;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792648749;
 bh=DTbStGII4DobQBXgujKJfYI2eU1H/J8AkOyEPKVJ0uw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=CZJ9/JbF8jmO2J+LG4b7E+yAqIXWlrsdDnb8vHf5S/Le/PuXz4vU61X58O3XQPaQX
 r5LA+a+2o+8jvxoZ8/X6KzmywkSRKM6eNsUpYHZc3zb1n8ZH+ZBv2DwefOwFaZgnFk
 ikdkiOPodJ9FBlZb3ob3hGzmPGFqjNw8jqwHAZGi3VsEbPI92tGfuKHGoJom7TvfjR
 L8KxYSUIbUPfD23GOTufm78EAKcDNimk/G4U+74uNBWRqCnsnFZ0BwFttk+UzEtT7K
 we/+61vmrS5mgO4HqwEry3rxfn+jdQPzeiWlBrHdsMcjENLkva1u2tTXaOU5GSxsz+
 vmGnQ7HYzz4qw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 53B4343508;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Date: Thu, 22 Oct 2026 05:55:02 +0000
Subject: [PATCH v2 2/2] sunxi: Add Orange Pi 3 LTS defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-sunxi-orangepi-3-lts-v2-2-46b9df5f9e43@gmail.com>
References: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
In-Reply-To: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792648514; l=3227;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=wQbVA8bqEQVClwmJkwr0zVm+czfrqdl+XPM9uwHmMGM=;
 b=nitYkL+q0Mhp42nAwwGN+0BdMJbMnkLgqG8LCiXzI04SbHC/ENhCxvXJuvBipi3hgUasyvB7v
 UDUwhonlSUMDD8alFoX5VQ3E0ADi1yK6qBKUqEORGiuwQ1N5rtEEqmr
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 07:27:42 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cristian Filipescu <filipescu.cristian@gmail.com>

Add a separate configuration for the Orange Pi 3 LTS, using its local
device tree rather than the original Orange Pi 3 board description.

Reuse the H6 LPDDR3, SD/eMMC and USB configuration from orangepi_3.
Enable the sun8i EMAC and Motorcomm PHY driver for the LTS Ethernet
hardware, and omit the AP6256-specific Bluetooth fixup used by the
original board.

Enable GPIO LEDs in main U-Boot to light the green power LED on PL7.
Leave the early SPL status LED disabled. At the OS handoff, turn off
green and turn on red before Linux initializes its LED driver. Limit
this indication to the Orange Pi 3 LTS board compatible.

Extend the board maintainer entry to cover the new configuration.

Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
 board/sunxi/MAINTAINERS          |  1 +
 board/sunxi/board.c              | 19 +++++++++++++++++++
 configs/orangepi_3_lts_defconfig | 19 +++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index e84219e2..6a47b9cc 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -442,6 +442,7 @@ ORANGEPI 3 LTS BOARD
 M:	Cristian Filipescu <filipescu.cristian@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
+F:	configs/orangepi_3_lts_defconfig
 F:	arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
 
 ORANGEPI 4A BOARD
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7..7b735a26 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -10,6 +10,7 @@
  * Some board init for the Allwinner A10-evb board.
  */
 
+#include <bootm.h>
 #include <clock_legacy.h>
 #include <dm.h>
 #include <env.h>
@@ -17,6 +18,7 @@
 #include <i2c.h>
 #include <image.h>
 #include <init.h>
+#include <led.h>
 #include <log.h>
 #include <mmc.h>
 #include <axp_pmic.h>
@@ -875,6 +877,23 @@ int board_late_init(void)
 	return 0;
 }
 
+void board_quiesce_devices(void)
+{
+	struct udevice *dev;
+
+	if (!CONFIG_IS_ENABLED(LED))
+		return;
+
+	if (!of_machine_is_compatible("xunlong,orangepi-3-lts"))
+		return;
+
+	/* Indicate the OS handoff before Linux initializes its LED driver. */
+	if (!led_get_by_label("red:status", &dev))
+		led_set_state(dev, LEDST_ON);
+	if (!led_get_by_label("green:power", &dev))
+		led_set_state(dev, LEDST_OFF);
+}
+
 static void bluetooth_dt_fixup(void *blob)
 {
 	/* Some devices ship with a Bluetooth controller default address.
diff --git a/configs/orangepi_3_lts_defconfig b/configs/orangepi_3_lts_defconfig
new file mode 100644
index 00000000..b7571134
--- /dev/null
+++ b/configs/orangepi_3_lts_defconfig
@@ -0,0 +1,19 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h6-orangepi-3-lts"
+CONFIG_SPL=y
+CONFIG_MACH_SUN50I_H6=y
+CONFIG_SUNXI_DRAM_H6_LPDDR3=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_SUN50I_USB3=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set

-- 
2.47.3


