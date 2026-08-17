Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAE6C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5124160842;
	Mon, 17 Aug 2026 13:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDfS6uH67C6n; Mon, 17 Aug 2026 13:34:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D63E60881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973679;
	bh=DRM0QiLbGPOdQgxkhuQyJ5a8QJesqzzwGig/5inAR1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t0mmSoJpE2TCDBfmRwTiN7pjhrUXbFc/077mXyltfcEz/4rjjnKT1nlHC0G/RW1kl
	 wP7LlfZX6y7OOwdKBStaw6DQb1Om8GgUWmhw3YJSBzj3/1wydFgDyaUrS5NnbhUTVR
	 eLNqhfGGJoz6VuPM5OtOXddTbqPwKeu3jkfkyjX0vGnb4jGt4x0HQ50izIfwXLMoyO
	 tQQ6zT0PxeGvdPUiWSXtHl1+FwKuK9IJlKxZOQVDG4SluLBn1e8ApasyMImQzoRtwe
	 KiyLBQtvK1jgaLWXm6edhGSYzExm44m/t63+RZht0aLFt4U7EH1lzAPW61F9fnNMwD
	 1PSXPiNUdYASA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D63E60881;
	Mon, 17 Aug 2026 13:34:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 502772EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42AE9605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpMdqNY-al46 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:32:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ACA6F6071D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACA6F6071D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Yh/gO3jS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACA6F6071D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7398F43D0F;
 Mon, 17 Aug 2026 09:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461C1F000E9;
 Mon, 17 Aug 2026 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959125;
 bh=DRM0QiLbGPOdQgxkhuQyJ5a8QJesqzzwGig/5inAR1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Yh/gO3jSUefyy82PHhWWEP9GaWPGClBzQ8qTKKuzTTv3Dqlf3M4SkT9NBpmLa2LT1
 CmY+uRSQY6cMn46w3E78dfVPkOTOFY6vNmbn8RDtauH/juV/Y5XdcZ7+WxorSRNCkp
 R8oe48L2tQMb0Unp1V9eBnSdp5372OGOvPT30rggvCrJEiguva9q2th2jquqmZEkKI
 wtaIZ7zMJU0BnBMNAH9YwitEotd8BOgOst8nYqAjBmnGeTtSBlTQUUrZ4aWIVUYDgm
 JRk9N5OSHD/CSZ3KmL4KKclhB7QEI+MlcA7ZHx3MRH+wBxD4U10ZtDs6IsvqNxnGVG
 gTvTiExD4bzwA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:56 +0200
Subject: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice device
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
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

