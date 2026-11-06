Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC00606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q16OZJRy;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n2nKo6ey
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 114C1811FB;
	Fri,  6 Nov 2026 04:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JVhUAhY4Y58; Fri,  6 Nov 2026 04:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A63E811E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793940301;
	b=Z5NMIfINVpW64+IvARhOlhd58fK22M0m6VTPS+mmvUksu5qi89K+bl93p/O3RlBcPl5B
	 po7Lpiub+4df9/fSSY+6QNd/1JSCgD3n02JcwBcTVVQi2go/216CRNQAR+QhP86vJiiZ9
	 WmROGb3ldYPep8No2fyT/9quQ91jtZxx8Zra6SdyAAI9T+EQOuM4L5LT0H9Kmc0bQ1/1A
	 HE7MSsHlDwLGKJ3UPEa+WgxfTZextv0VKcGk8JJwjnRmudEWv3GpYd6f/YuSC3wq6UW6K
	 OA/0ZIsxdQrS2NbQeOXiQ2WNphdIZj8U31TK3uwu3MAxNCqLdmJj48Y1BKg3rW9xg5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793940301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HdAp4Ad/kcZ1UcE/umcrjAIBHEbcNNft5zRjkVMJ6gw=;
	b=E+ltCF+JMeuvXRcRBmQ5GHF/kQ3K48TYOkCBXDBrz/SYW2VBIvxqW7COxTRSXZtlXjHA
	 e6AyB2IHEEyZj6JGlnoHFp64VcfycVFmsCTg2/tNceGNChU7Vpf/xXG2yb6kUABxl6YP3
	 oQtzE/Y0V4xx6ugJofVzxcvIKiPLqUFjRBElY2kOOn7Um/AiUV0oEW5epJOOVsZQWi6zG
	 AHBXEsC2BA0A1ZKzB/3Rx8MOC7l1jKUVHvHet5AB6d4Co/mv2FEXWVd1Z9TNGHaLO/K59
	 zMKhwA7LkdkdPS5BY/AZFj1wCYs4QcXXeVSXYbwSAvXoqwDr//lznB7nm4TCTgAUk6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793940301;
	bh=HdAp4Ad/kcZ1UcE/umcrjAIBHEbcNNft5zRjkVMJ6gw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q16OZJRyo11KUk6cBEhX4APE8O++4PNcPZewwwIJbIzTLTKFQ+P+nPgCBnpR84WnT
	 4PjVRgxvmLKyf+xmzpsknsQqjWMCRg1cEWxYAjmQYTkLeyfFXWn3pfw8xnOja5GR12
	 F+SynsH4uvDxlcW4P5ToLcldRQlzsCrImJ/JYMr1TCr3gIFkefkK87xw4A5DxUPdtA
	 SRyHwh7S44wXF9HQgRXiqhx8p+5Sas5lAeYOKHy1h+O1DvylA4aPQS7Zn78UO4+uhg
	 f00NxSmrioCFilu89U+HS0ZUZSARoucHqNpCNkyQdCc7ygL0MqM7ckAoT8aWMiz9rH
	 RXh4ZG5RPWeOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A63E811E0;
	Fri,  6 Nov 2026 04:45:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F1AC1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44DA440900
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-9wTSSPIWuc for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 00:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58ABC408FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=asai.6265@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=n2nKo6ey
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58ABC408FC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:09:04 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so32555eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793923743; x=1794528543;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HdAp4Ad/kcZ1UcE/umcrjAIBHEbcNNft5zRjkVMJ6gw=;
 b=n2nKo6eyWr7y0B2y+wf1+xa+p5bGOR6qE+tFMoDdea+3RJrc+QyOfhNku5bqE9g8uC
 mFjWT4nDyaYaKFVnhnT5aGVX7nBYFFLY/+yAKM1J5VYmsqwzHBdGJK7ZiT0AyKqmaUI6
 SXVDXXR3T+pEFr0SqAdrTLH+VUx2my7+cNxdUUkAsx/0Qwf3cK12rFpcBUDlTNDhTbak
 xMbJBqkACHQ4ooJAwkT9WzFpWVScy2Eab3YlZqyv2gBLZIvJOk5MV0fqf20NAk5mv875
 KCnsqoyXgYm6/6UBxQhMYD+ct74+ICeYxQAUlLz7V18FKhycMO+xEcsA1O8bMYiKgWk6
 jqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793923743; x=1794528543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HdAp4Ad/kcZ1UcE/umcrjAIBHEbcNNft5zRjkVMJ6gw=;
 b=hwDQ1cBEzYgmH/EJLi7YRel35O0aGc/lbxZYw41zl5w2C2Q7Ymar+sXqfVxs5RmM7o
 nIM99HbwcLbPxe9sRi1f7VK8u898FsokVsOJWsQpsD4YFsfF+4tJsSJUq2pxKnjoe/S/
 BeEbrKIZb8XsBwr63Ndb/oKMouk5k+n9B+jZWOTYC6tvbpgXy0PSRLOqcrxjwK/H1pAs
 ULgywjSCewxHfdOJyVC++c8UnLXkBKK0efVR5ebk3t4hCoO8YEfoVVPtIzTWPOXbyi1f
 Q1RDPTQuPfXRf9WCnMg650iq+zjl592LCbAs/UFW0Ne3NuGRFWkQqw9NIg/aI31iEPXf
 p5pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoNLsBJzroiWpMl8ndPFbjLym0SJ765x72Jg53N0Ws9YTNp6Rnu9uG6dk1N3K13D7y2kEXWek=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/IYLtNS4IBFOGTMZr8Q9N9qcDEBA/pBAsYNfgG+nEaynuRrnF2
 3+Wsat35rD6h4ljnylSgUpyPS1838imH+qNRBLd54KFf6Evs7kjPS/sG
X-Gm-Gg: AYBFou2Y7aLO649FtVRB5j+rwikXAM2ZxKI0N12TJhpXCzqJkC7QgWLmfNlQQBMIi2m
 gTYnQoBqlkiAgam8pdF3XesNmM16b6J+ob8lVYHEfUsk6PJsAvR045RuBUMH6/WSk1FjUrGNwDL
 3A4Ppr5UeFe/tCUPJgKJJsJObFSrdvywrbwxV2XSNRPBe+T6m31Sqkf+2/A9K68dkyXt9mpaTm7
 DHu2eR9LVDyqh8GQ/2Hd/mI8Rpi734EMld1/p9iHI+gx0ACJDZ+f7pplmwcI9l3c68xolxOAf+f
 6x40l0SwlukV4USf7cnCmlAoABVnEGjKXkbO+yPcrnjsj4qKFf76saCyofaAEEmOHQv1jk9cYZu
 f7FJTIcVlRomFsy/fIIjJhR6cdMFonboNf6rPigntFDs1u42bZc8KnRKi6e1jYsSesdpRgxbKKC
 crfLMcf5mJ/BVBdA1pr8EFFbcROWz1dj+H+m8VDZlxfcEAZ3CvLT4ztU/rg6HBJgHIYqhJVUCMd
 5TwVcRCHdIaP2t68/f6qlVINf+UaDlJaRg3lLM5eTi+WwaB6LzomuujqNlOX+c2Ls3hbVTR1kMH
 flODuRpKFztbqPYBrtePre4e/BVOYVi5So+VYkKE8kFOKTX6A+RF3jHYCFpnmA==
X-Received: by 2002:a05:693c:66d9:20b0:36e:a321:5353 with SMTP id
 5a478bee46e88-36f729cf994mr1226857eec.2.1793923742764; 
 Thu, 05 Nov 2026 16:09:02 -0800 (PST)
Received: from X870E-AORUS-MASTER.kkp-group.com
 ([2400:4053:d960:1a00:d4e5:611a:d757:e515])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa922b205sm663887eec.11.2026.11.05.16.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 16:09:02 -0800 (PST)
From: Shigeaki Asai <asai.6265@gmail.com>
To: FUKAUMI Naoki <naoki@radxa.com>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [PATCH] rockchip: rock-4c-plus: Configure IO domains in SPL
Date: Fri,  6 Nov 2026 09:08:15 +0900
Message-ID: <20261106000815.217889-1-asai.6265@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 04:44:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shigeaki Asai <y-asai.0816@docomonet.jp>

On the ROCK 4C+, nothing is printed on the debug UART after a cold
boot until U-Boot proper configures the regulators, so the TPL and
SPL output is lost.

The IO domains of UART2 (APIO4) and PMUIO2 are supplied by
vcc_3v0_s0, which is LDO7 of the RK809. This LDO comes up at 1.8V
at power-on (measured on the UART TX pin). U-Boot proper later sets
it to 3.0V and configures the IO domains to match.

Enable the PMIC, regulator and IO domain drivers in SPL, and add
bootph-pre-ram to the related nodes. The IO domain driver then sets
vcc_3v0_s0 to 3.0V and configures the IO domains early in SPL.

With this, the output is visible from SPL on a cold boot. The TPL
output is still not visible.

Tested on ROCK 4C+ V1.41.

This patch was written with the help of Claude (claude-opus-5-5).

Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
---
Tested on top of the series "ram: rk3399: Fix LPDDR4 tRFCab for
high-density devices", because this board does not boot without it:
https://lore.kernel.org/all/20261101185441.755448-1-asai.6265@gmail.com/

 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 32 ++++++++++++++++++++
 configs/rock-4c-plus-rk3399_defconfig        |  7 +++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
index 7a6af430a6f..6094cda551a 100644
--- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
@@ -49,3 +49,35 @@
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_none {
+	bootph-pre-ram;
+};
+
+&rk809 {
+	bootph-pre-ram;
+
+	regulators {
+		bootph-pre-ram;
+	};
+};
+
+&vcc_3v0_s0 {
+	bootph-pre-ram;
+};
+
+&io_domains {
+	bootph-pre-ram;
+};
+
+&pmu_io_domains {
+	bootph-pre-ram;
+};
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 0f6bdfdfb06..d3870586cf7 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-4c-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
@@ -24,6 +25,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4c-plus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -48,6 +51,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SPL_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -65,7 +69,10 @@ CONFIG_PHY_REALTEK=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
-- 
2.43.0

