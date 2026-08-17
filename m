Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48BBC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E7DE40765;
	Mon, 17 Aug 2026 13:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0slLf00SlNp3; Mon, 17 Aug 2026 13:34:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0809840752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973656;
	bh=DRM0QiLbGPOdQgxkhuQyJ5a8QJesqzzwGig/5inAR1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJGG4w1veu1BnbyKOljCea5HVctmTH72dqRLChpU/m5uVbtNz8lBtN+qYW60UB7qQ
	 gAEf5AeodSOw1IkBgFUxz4jQJ2cK5LPZ+a/aOPpeuKei1AL2lJSB5U5zmGp0hwrVJi
	 F8ePkqzua0ppXfbkSZzVmjBqk9MKBKrPQN1Oyu5MrzqKgMPrf8S/97AboOy/s4Ep6g
	 Td4v+AWcLfcxE2yIp4BeGG7NT6xlK82WP1TTfmrvi3eNMtEzFlM8FcJacI1AcG/gKG
	 hs1bJg18p3Dngs6gbJfHqXO1t7tI+WSyt/v79m7J9CyvP2vu669BrBYP53IWPmdDyE
	 0sWT6rXYGEZPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0809840752;
	Mon, 17 Aug 2026 13:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87549147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7919580962
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxRRSpd8zU6z for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C7D680BAD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C7D680BAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VRS4w6Yj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C7D680BAD
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FC8B40088;
 Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B961F000E9;
 Mon, 17 Aug 2026 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956267;
 bh=DRM0QiLbGPOdQgxkhuQyJ5a8QJesqzzwGig/5inAR1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VRS4w6YjnepWJo2vkK2A3j5knZnTSxfm0cpHwMSog31cqcgyFYAaSs7jbkcWwSLQF
 mVuxMM8FzWBRVcQsStHRuXiJZZ+wKI1h3fSNHNofbwVIJyubO2p9/nxqhtC2PBacKa
 BOBd1TBx3b7U/EVdmwBZ1IP7snDdtWhovP0+HbZX8fqhYw4NnqNQu37blO0fLBJwHk
 lynN+myn+pBQPvjqOQ93sgLVGduP2zFrWvATP7FbnbCalnuZJDPEYnYIZffZIGnT3i
 zTU6HFDQ2xAwcQ81xTVNDn2XlVzH6t+zJ9ZYqVmpZHe3mTVGLS52amxD89Phj9esoC
 cypt5skbwS4Bg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:11 +0200
Subject: [PATCH 7/8] arm: u8500: Switch Stemmy to upstream Janice device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-7-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use the upstream Samsung Janice device tree as the initial target for
the Stemmy configuration. This also prepares the board to share the
upstream Ux500 Samsung device trees with Linux.

U-Boot does not yet implement the U8500 clock providers used by the
upstream device tree. Add a U-Boot-specific overlay with the known MTU
clock rate and a fixed input clock for the external SD controller.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/dts/u8500-u-boot.dtsi | 20 ++++++++++++++++++++
 configs/stemmy_defconfig       |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/u8500-u-boot.dtsi b/arch/arm/dts/u8500-u-boot.dtsi
new file mode 100644
index 000000000000..41eaad7f78b9
--- /dev/null
+++ b/arch/arm/dts/u8500-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/ {
+	/* FIXME: Remove this when the U8500 clock driver is implemented */
+	sdmmcclk: sdmmcclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	soc {
+		mtu@a03c6000 {
+			clock-frequency = <133000000>;
+		};
+
+		mmc@80126000 {
+			clocks = <&sdmmcclk>;
+		};
+	};
+};
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 57e794c5c88b..1f512416c9f4 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -11,7 +11,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
+CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_BOOTSTD_FULL=y

-- 
2.55.0

